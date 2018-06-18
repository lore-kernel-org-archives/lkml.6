Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0879BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5949208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kLoAlo3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5949208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeFRMeH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:34:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42766 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbeFRMeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:34:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so16661225wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jy0NKrS+1eLnBcuICVoDsClf6XMvq/rY73JgYMfUnXA=;
        b=kLoAlo3AK04XqyUoq68wb7RmoyF72STVbj888/eyTEdydPmAOydvhXYYFU+eIY6jL7
         yfzWx0wi+3OdR9JT1r+yPgOa+QwKtH0DueMGUsLq6aluHmTbA8AA1kznj8ABp5Q8s2dP
         BssYRMAMdM1HfKgOabNGxXyXh1a9dRcbK67Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jy0NKrS+1eLnBcuICVoDsClf6XMvq/rY73JgYMfUnXA=;
        b=B8DWHCOP4nrY7M8laCWmE4mZdPl/1AloxKvAV7kL0TAukQ3K0Y3omv3MdJFvP0Tu+C
         3xswmI7ntF9fYNq9jgDPS1eCOakrpoA1TbkUjGcjXLoRHAwgMjXHfvrP/rRC0ZfCv42x
         DDje/xJkad+p9QWMpV27shrv/4/4pFXcuNOkkciElquVa5STKWi2PvrHv9XyWlEXkZ1w
         8bG59ARNAi4pHFiW7SlkioT2ldUuWvPTA3yUwUoJ/gZJNqZBrjKWyzmFFPwSBxFVUDRD
         I8eymWOIM4Dq8HnJaSz8NhN+XQtXY5PDnVf7y6q9xXobctxBaaQfsnL1MSvWkaPg8WQo
         jxxg==
X-Gm-Message-State: APt69E2HjSl7gEGZVNmUFKQgD4DvcVUtnKiUNzK+KA14T7UmPdlD9aEc
        fhEcklALQiTXtppmqsZv/Jl0+Q==
X-Google-Smtp-Source: ADUXVKJPYxKFFlpEFwOt3kjlxT4dT/Psek1e4vrlStq9nQ4bNQRbjKggF73Q8FQHQaMLT6b4+Q8IsQ==
X-Received: by 2002:adf:fc05:: with SMTP id i5-v6mr10096727wrr.157.1529325244250;
        Mon, 18 Jun 2018 05:34:04 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r10-v6sm24291318wrm.66.2018.06.18.05.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 05:34:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/3] rpmsg: glink: fix W=1 warnings.
Date:   Mon, 18 Jun 2018 13:33:36 +0100
Message-Id: <20180618123339.24115-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
Here are few patches for warnings which I hit while building
kernel with W=1 flag.

thanks,
srini


Srinivas Kandagatla (3):
  rpmsg: glink: correctly annotate intent members
  rpmsg: glink: Fix various kerneldoc warnings.
  rpmsg: smd: fix kerneldoc warnings

 drivers/rpmsg/qcom_glink_native.c | 45 +++++++++++++++++++++------------------
 drivers/rpmsg/qcom_smd.c          |  9 +++++++-
 2 files changed, 32 insertions(+), 22 deletions(-)

-- 
2.16.2


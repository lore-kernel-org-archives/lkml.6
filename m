Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0085C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BB32089F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzYIxEC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405719AbfBOKks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:40:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37030 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405683AbfBOKkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:40:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so9793511wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5SKJS8qovTbJMzODn5WiJfdSGP0EbMwiqTEZR2+aeQ=;
        b=nzYIxEC45Q3ICZtLEKthn3t+qYJROHebSOp5QK9/9KalVz/e7dmkwiMzzYRTmsVLpg
         OKYtUfBnq/jAIP0XNCPyFdT2tNdO5cT7N0OxJ08xP9LNE3PymVe9/AVoGLCrgLquSc+8
         0EX5P+qobDZJBx68Y+JfbDFTat5duKrBQ9RfGsrd/CIiTgJzQMDxvtllghDhYPpoEyf0
         qIL+ZQ6dkLOdQSvZf+1rImrhMha4BnCN2tgvU+3dmJARos8yBqnf9THSg7sRAK1dktqW
         7RoxiB2lIJ/lHcQmDGGquXH2lw7C1z0zpaAqPY3ppAsuW6KePRQ620d8uYesbo5bN5VF
         OOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5SKJS8qovTbJMzODn5WiJfdSGP0EbMwiqTEZR2+aeQ=;
        b=BcJVdSo3O5TlhTD75TUKBbAzVY+SvOFjJO4250L5JInms0/rZFbJaJAAF8LsmmUr56
         LpJuYa48TbSX5zHAYzdGZMhilL6pnO+3b+qDXri4OF+WfbHUi6RLP3+EJkl8Da1KztA1
         O+W82P5lJE+p3t13aUGlOM1e8UrF2ICt36HZ4rIvelbl3VTi3OvscPWDPiMQ2RafsE8E
         B8TipZKCAutq37zH8/oMWj/QS3D05Ebi6Wy2KCx8/sFIVL1w6gb5YNTJuuAQ7CRTTfxW
         3dzQBB0f023AAhRc6vN0PkCtWSLab1tKbKrsapSmIGIdnPXJs5iZ0jNp3pMW7rXQkRDf
         TyDg==
X-Gm-Message-State: AHQUAuZlat9xZrlH1kbg6XUioMqid7D/fHbPAuk3xUKTCV2hf/CtSvdm
        /7OMMcEIHXIolPCO+cnymQSr2A==
X-Google-Smtp-Source: AHgI3IZ2eVTarWqhePePCb7grgy4qLlMaVHz5rOxGDXl2RahIzWOKBdi78go3prPi1m/10BBTIlZmg==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr6252106wrk.35.1550227246104;
        Fri, 15 Feb 2019 02:40:46 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v4sm6525577wme.6.2019.02.15.02.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 02:40:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] misc: fastrpc: minor fixes.
Date:   Fri, 15 Feb 2019 10:40:05 +0000
Message-Id: <20190215104007.27103-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two minor fixes, one to fix build error on x86 platforms
which do not have CONFIG_DMA_SHARED_BUFFER selected,
and other is to hanle possiblity of running out of compute
context banks.

Thanks,
srini

Srinivas Kandagatla (1):
  misc: fastrpc: select CONFIG_DMA_SHARED_BUFFER

Thierry Escande (1):
  misc: fastrpc: Fix device_open when no session is available

 drivers/misc/Kconfig   |  1 +
 drivers/misc/fastrpc.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.20.1


Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB5AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541F6208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/ZJ9Xxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541F6208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeGMPyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:31 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36971 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so9848117wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cKK0sp5xcDVw+DeKQ9QC8gIRM8ZcvvZ84rhkF+pNVfc=;
        b=h/ZJ9XxwkjgntGXLEZqNOOq/uFAlicm7sO2LvA4FfB70RMnL6XECZUH63QdSob+LXC
         6mF82omv8Q5cAwlgLL+uojk/DBlg94u15ccTpZ1MoIfIkmz94GQ8tvK2fb7fNmp94EKt
         q6yuQHeaJJoyG1KgmDuMFiFnU2da29G2zINOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cKK0sp5xcDVw+DeKQ9QC8gIRM8ZcvvZ84rhkF+pNVfc=;
        b=YQc7IyES7MYKpN8hnH40PNLHI2DEKi4YmJ9TvrBmH4naGHI5LAlagZLk38gwUngPYe
         9e+ybWtfuR5V/t8gc/QTQuik+BJMzNdZVY+PyP19DN0xlr5UBobjOUEnEy1RwK5hYnvV
         m+389w+vuhLLrXbecLdm1ds/9t7SsxG4nEurjxNU5+RVxXSHvZOh3H9JK7szIf92IvxL
         n8cODr2NxuOMwfPN8i+W5U2PUfEIGuxQiWSkWKkj7iZVnDIY0wPw/QCyZfDhQEyfoLl/
         3TJAcat1uTNXfNUAy8BIhutyFgORzlYnyD8COlDs5ONQiojxdahzaN/1rUde9l0pnKqT
         kTFA==
X-Gm-Message-State: AOUpUlHUabGO4a/8gbMt3VNTSZF9Zpuus6qfjFEQ/SODqqclfdPdYQmZ
        ZnTL5ZP8dnLzE1+Adk7yoQ9F6A==
X-Google-Smtp-Source: AAOMgpcM0XWSvQnmly1QD6G2vSrltIO4pNjOseqZ7vv1g3zDqPQtyf2uaOOn+gDsJmJa0X/gCWmQpg==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr4391694wmg.42.1531496361040;
        Fri, 13 Jul 2018 08:39:21 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/5] ASoC: core: add support to card re-bind using component framework
Date:   Fri, 13 Jul 2018 16:36:27 +0100
Message-Id: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During discussion regarding card re-binding when components unregister
and register back at https://lkml.org/lkml/2018/7/9/785 it was suggested
that component framework can be added into core to provide this feature.

With this new changes the card will re-bind once the dependent component
re-registers after unregistering. This works based on the match done
from component name using component framework.

I have tested this patch with qdsp start-stop and module-load-unload usecase
for more than 10000 times in loop on Qcom platforms.

Thanks,
srini

Changes since v1:
 - Added new flag to enable/disable auto bind at card level, It is useful
  if machine driver/module is really removed/unloaded. Also to help cleanup
  the master component. Without this we will endup with a memory leak if the
  machine driver and memory associated with card are removed.
 - removed unregister from unbind callback.
 - updated match function as suggested by Vinod.
 - Added qdsp6 cleanup patches to this series.

Srinivas Kandagatla (5):
  ASoC: core: add support to card re-bind using component framework
  ASoC: qdsp6: q6afe-dai: remove component fw related code
  ASoC: qdsp6: q6asm-dai: remove component framework related code
  ASoC: qdsp6: q6routing: remove component framework related code
  ASoC: qcom: apq8096: remove component framework related code

 include/sound/soc.h              |  7 ++++
 sound/soc/qcom/apq8096.c         | 75 ++++------------------------------------
 sound/soc/qcom/qdsp6/q6afe-dai.c | 34 +++---------------
 sound/soc/qcom/qdsp6/q6asm-dai.c | 35 +++----------------
 sound/soc/qcom/qdsp6/q6routing.c | 32 ++++-------------
 sound/soc/soc-core.c             | 62 +++++++++++++++++++++++++++++++++
 6 files changed, 89 insertions(+), 156 deletions(-)

-- 
2.16.2


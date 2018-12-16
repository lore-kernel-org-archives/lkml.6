Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F66CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD02204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 16:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAQE1ddG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbeLPQ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:57:29 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43340 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeLPQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 11:57:29 -0500
Received: by mail-yb1-f193.google.com with SMTP id d136so4208962ybh.10;
        Sun, 16 Dec 2018 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lcpo9vkJaU/B4DRr40bY8llUuPtTjVRD00OqQ9pC5Zo=;
        b=UAQE1ddG/VLsNRlzaR4IDdx5+CqoGFCqEyZ3CsFBQmIK+ZOdOPndB/SdOvLg++/FZG
         NSGPXUwurMlih2XKXHhMm5bff3xEg5Q2Bjm+UPHZtA9ZtucvHhvejIFWb4xN6SUHnI/u
         BJIKx2JAdixI0od1yKkMPr1yieHGh7HmGjEcfcYoJJinCczPsxcI4i0Gq3XiBIqRAG1C
         2zpHhR/0JtyvvWMnwbzldXT7YkWxMWPi4MQ7MeqPvgfoQgF+FPxfgN8qlLMEKd5iilH3
         hX/BGGktxaB9O6baPcs4bsqh3f9q2lLkXNcKKDi2bJ4S5aScgtX+0ZunZdJyFiDgtf+Q
         cvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lcpo9vkJaU/B4DRr40bY8llUuPtTjVRD00OqQ9pC5Zo=;
        b=A6xeM7yMFkVO3xNfONg/GH/4IJRw8VPMJIYXpgpJR9r8aXxEmS7u25MuLmqSZ0MB0S
         MAyhHUdD2xhO/mxWNZp4F+i9wgMxyOyNDsKFNBjtsUPfJbSC3L8xYkcVVeV0IUdwxlNw
         WDP8M1tUoWyd4Bpo3TDVEzSDhZ//7S6SxaTQpujql+xDhRXR8nLPcg8ezGjRSFOfrujE
         v0idc26Y+ZRMlUYEiJEKPeh9Ax1PCZf62IxYMSvDkJLlWNkHF8DEduP8CsZpphAG+rhd
         gG5TYyCvp+DKezkm3jTOiX6NKDj700LEwQHNerv4BfFycu1QH7m7vMHidbudIOYlm5x0
         +6xQ==
X-Gm-Message-State: AA+aEWZhAvKUDg3FZmBqDYSDI3jtacQr8KsCSmjNGZVANB3Sd897Efti
        YSJ4BYOBpm2oSwKBQX28au4GXryZ
X-Google-Smtp-Source: AFSGD/WvXA72Dj6w+afppRkwF0EzMAyXFekjQV66HfvbuOc1TdYvZ3/wnKQ50u7LR4jbjpHW4kPO9g==
X-Received: by 2002:a25:6d42:: with SMTP id i63-v6mr10263068ybc.17.1544979447074;
        Sun, 16 Dec 2018 08:57:27 -0800 (PST)
Received: from ubuntu ([67.191.186.148])
        by smtp.gmail.com with ESMTPSA id y1sm3317353ywe.86.2018.12.16.08.57.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 08:57:26 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     marvin24@gmx.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] Staging: comedi: cb_pcidas: fixed a spelling mistake coding style issue
Date:   Sun, 16 Dec 2018 08:57:25 -0800
Message-Id: <1544979445-10079-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/comedi/drivers/cb_pcidas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas.c b/drivers/staging/comedi/drivers/cb_pcidas.c
index 8429d57..02ae00c 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas.c
@@ -116,7 +116,7 @@
 #define PCIDAS_TRIG_SEL_ANALOG	PCIDAS_TRIG_SEL(3) /* ext. analog trigger */
 #define PCIDAS_TRIG_SEL_MASK	PCIDAS_TRIG_SEL(3) /* start trigger mask */
 #define PCIDAS_TRIG_POL		BIT(2)	/* invert trigger (1602 only) */
-#define PCIDAS_TRIG_MODE	BIT(3)	/* edge/level trigerred (1602 only) */
+#define PCIDAS_TRIG_MODE	BIT(3)	/* edge/level triggered (1602 only) */
 #define PCIDAS_TRIG_EN		BIT(4)	/* enable external start trigger */
 #define PCIDAS_TRIG_BURSTE	BIT(5)	/* burst mode enable */
 #define PCIDAS_TRIG_CLR		BIT(7)	/* clear external trigger */
-- 
2.7.4


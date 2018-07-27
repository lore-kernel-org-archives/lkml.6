Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1DAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D99F20893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/xRWYFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D99F20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeG0KGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:06:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46144 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0KGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:06:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id t17-v6so2022828ply.13;
        Fri, 27 Jul 2018 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HfMP2w542DW7GZm/67DEFYm7v+68mgXV8RJ5TgNWbpE=;
        b=u/xRWYFwPHlbT+fu6knhtwtLLY+B81LzkghP8HRsc7R9ZCxSGFrqGwBX78oSvN7GJv
         +7LUPHcgTfIlfIUSzTFk/S463sDFXq/Do5yGUWhTTKlpqWqLaHrAOcaTYqzGxe4083u+
         7EJfJJDnYWTXg1oHNtwkqU+LaYbDPJgFNPoPptUYsDopsWq39BwPv0gjeJd45KHiZ/Y4
         t4CYUM8eCgxsN8f0+SN21NmLhzZ/kzhRF9UhbMaeFtcqwXPaRxabYTm/cvCHuNfkpIsf
         cscCzUnbs5SUSwSP3dhFt7h9nh5/MUweVSdtnjhqRP+4+3KCgu35QTG7iu2l7oyLcZ85
         F6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HfMP2w542DW7GZm/67DEFYm7v+68mgXV8RJ5TgNWbpE=;
        b=KToIiizkhtdYpyDQmRSqHwKDkXSiDRkUp+IJRbBtG41gVkL+wMugP5Nwc1o4mrba13
         3Auxr3xgmVNYMkPoDTWBTxnAG3lpZgx0QdoqVYbEpqJX4yfPC+kc2P7wd9Gpchf1lg0O
         1Lg8/YJomByZllVF3nE70Sq/bHHK0GIKQ5wWGXsFiL2Rd9fpqTPZkWPQ9d8Wk7WY3AEG
         dcHnnJNlnJWMVrF8v25edEpHluWg6Zf9hc3tJoliWp1GUteEIWn+Zn3iyadg0MLGjNMF
         ip6fA5k5bs+SpRXUoqoWvYCsrVpmUR/F3g29sAcE/jxH4b3LAV7dMW/GVajWHkO0CY3A
         zITA==
X-Gm-Message-State: AOUpUlE0wUdI8CS7BpvVDANPHdTM19RgrGqLFAlPvrqck3y2IDNlzpcb
        QsJrEi8iv5TbENdQu9K0Kls=
X-Google-Smtp-Source: AAOMgpfNY0I+vt4MGrXq7lkQWN++PyyFGbZbwTxZmzLDc9jQzH2ovcISY5jcC2JPGsda7aeF6XomPw==
X-Received: by 2002:a17:902:d692:: with SMTP id v18-v6mr5224036ply.59.1532681141670;
        Fri, 27 Jul 2018 01:45:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id e19-v6sm4004205pgv.48.2018.07.27.01.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:45:41 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     simon@thekelleys.org.uk, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: wireless: atmel: Replace mdelay() with msleep() in probe_atmel_card()
Date:   Fri, 27 Jul 2018 16:45:35 +0800
Message-Id: <20180727084535.3848-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

probe_atmel_card() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wireless/atmel/atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index d122386c382b..d90f04e14292 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -3692,7 +3692,7 @@ static int probe_atmel_card(struct net_device *dev)
 		atmel_write16(dev, GCR, 0x0060);
 
 	atmel_write16(dev, GCR, 0x0040);
-	mdelay(500);
+	msleep(500);
 
 	if (atmel_read16(dev, MR2) == 0) {
 		/* No stored firmware so load a small stub which just
-- 
2.17.0


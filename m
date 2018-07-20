Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286FCECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6F8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGTkp5/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6F8206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeGTEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:49:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46712 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeGTEty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:49:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so9912289wra.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NPtei4HD0eenTewtuWYDSj91EEOZj7wqjYKg9iUMTS8=;
        b=PGTkp5/lQTQzKtqlQEqIHmCyM9Bi+VB+YepcTHzgvrAmkGZ0kqKlomoSEATlHUJvjr
         reez4FJ0ELUJEvyrvkosQH8GpZDlAOwBDNzB23SmO0K0dxImiIdJWipdMylbinjoh8eb
         k61Ws0gR/+/QfolvkBxPkyvT34BraZpUFRQ7MdGDhjKvw8Va4wJydClHbT+jtlWNpCw9
         6IezR2EZf3CohfAy8acMQF2mQ1C900lC3r+2prUsa/W8dQhYm+312KCqxdL2Fedy9mAa
         SJd235d25UxYGLQR/goFrxNKQp/eykROssTDUK1bT6bcZcICdTYtbqotIeGGWw+7LBNZ
         cuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NPtei4HD0eenTewtuWYDSj91EEOZj7wqjYKg9iUMTS8=;
        b=ngO0Z/6EYGdpS01FcKys0J2pEtVKlwVyyyitAN4KdlwNdNv1I1f7WYifvMMW7MjGyY
         y3JuUMc2dAW41yoqtDKI5i0aZHF5eIDxHFS7b6yPIbV0BZzi/8RsCj1z785wtkjhsqgT
         1jfHYsBRAUF4kusKzsChMa2C7k3Yc/28obkOFi+mI8wpkrelfQhy1FW3hctYFFP1qyky
         QsV+HGSFC+UM3I1hMMfpqA40qOad4CDSQtPCwMB6CJ83yrBZtQ0WnvA7m6VjM8Q6Ndgh
         qOFvY0J1WFW8TlHf0y9Eu8OG2URM6npmiXus5QqOF+xSm/XBIXwHZKoPk2Ed94zieck2
         awqg==
X-Gm-Message-State: AOUpUlHc3B0KO4jrxDJUzhV09IGbhPrOjkStmryd3Bb0hAsq4ohsJxNh
        GSOiVI/f8qdNzxOMkucBUb2tA3Y/X2Y=
X-Google-Smtp-Source: AAOMgpcJ36F867fnuDlxCYc2LoaAbVTpAdJMhzDuOFUNcsZaBtmn5ThIRm0HBsHs4CfK3svf5p455Q==
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr236443wrg.34.1532059419328;
        Thu, 19 Jul 2018 21:03:39 -0700 (PDT)
Received: from ali-Z97-D3H.cisco.com ([5.79.84.73])
        by smtp.gmail.com with ESMTPSA id z5-v6sm1122724wrv.2.2018.07.19.21.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 21:03:38 -0700 (PDT)
From:   Ali Aminian <aminian.opensource@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ali Aminian <aminian.opensource@gmail.com>
Subject: [PATCH] Drivers: staging: rts5208: xd.c fixed a brace coding style issue
Date:   Fri, 20 Jul 2018 08:32:04 +0430
Message-Id: <1532059324-13925-1-git-send-email-aminian.opensource@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing a coding style issue

Signed-off-by: Ali Aminian <aminian.opensource@gmail.com>
---
 drivers/staging/rts5208/xd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index 667dfe1..261d868 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -787,9 +787,8 @@ static int reset_xd(struct rtsx_chip *chip)
 	}
 
 	dev_dbg(rtsx_dev(chip), "CIS block: 0x%x\n", xd_card->cis_block);
-	if (xd_card->cis_block == 0xFFFF) {
+	if (xd_card->cis_block == 0xFFFF)
 		return STATUS_FAIL;
-	}
 
 	chip->capacity[chip->card2lun[XD_CARD]] = xd_card->capacity;
 
-- 
2.7.4


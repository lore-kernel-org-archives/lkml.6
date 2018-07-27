Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D62C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9865520857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQlcjmoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9865520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeG0EIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:08:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43950 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeG0EIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:08:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so2321479pgr.10;
        Thu, 26 Jul 2018 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8yjXE90/Gx9a7TUfxETbMTVN33860hpUiZYcT6PKR3A=;
        b=YQlcjmozl5eW0eIw4m+yX9OocETDB1NWITWm9AeD086MNYGUQKlMLRaleUUEbunVjj
         +c5Y1MzKA9ho6JqOI0S+JTE0fjf6NxyECZ0o1QAfkIb49j6T78FY+i/cserxsyaFOctD
         MYaTR0mJ6Mud0d1uBLreeA3HqPKbgeQo2VZ1x024d+kb9wJPgylwH0L/cZlouZsx7x69
         SuL2IWv8jhsA5TR3AEaY7l652/+VE9Ukj4veKfPMGohPFEX7ZZHW8nA9rWAnr3NN83zf
         iRg3+xpFd5Ix++Er/f33rGxnAYfd+loZ1WvDH0YIi8w04QrDorKYnGvRHSAh+KIvOBxG
         6fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8yjXE90/Gx9a7TUfxETbMTVN33860hpUiZYcT6PKR3A=;
        b=RPZk0Rv5eqvjnJV+3HhMfFRpQ/HWdrF/AanA5ht6nWWZP7XB2tR/TCW2kwxJ2UkF7G
         LQq7UZRVR8qAJUc7/AG7m76j8kYzWfS1SHIaQpC+PJZIC7+yZrkyBLLZqfts+lnKaw/B
         nQdAkAz64vkyHSIf+PI3tPZX3yrJ56lTaHuUSsUudrq0bX4vwVVbElnCNciofmshZAv0
         991R1AfnRIpQS5mvSuCsOLC5tEMYrp2V4ivjxv53Rxbwh6M04ZLtpaWTf4taJrWNnDYu
         0HVoyqeWGE7tEdxXXQ/aNiSp+oNg2A+OQMRZPZY6z5fUNPBVKH5s0u0O5nTjMPQg1LoY
         su4Q==
X-Gm-Message-State: AOUpUlH4xDNsRVJIqXCkMVjYhD+lbQjt8b8GoGCft2X5yPeHHUj5HdWk
        vBsor4w70dog5vYVkK9FdEY=
X-Google-Smtp-Source: AAOMgpeYkAGX7i263voEWbaIGic3Wzt9sw+Ub0/0czbieO/UYvyKefomNpytO832WGrUyEr/I/200Q==
X-Received: by 2002:a63:ce12:: with SMTP id y18-v6mr4294920pgf.144.1532659714879;
        Thu, 26 Jul 2018 19:48:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id g85-v6sm5831264pfk.39.2018.07.26.19.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:48:34 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: hisax: config: Replace GFP_ATOMIC with GFP_KERNEL
Date:   Fri, 27 Jul 2018 10:48:28 +0800
Message-Id: <20180727024828.2107-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hisax_cs_new() and hisax_cs_setup() are never called in atomic context.
They call kmalloc() and kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hisax/config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/isdn/hisax/config.c b/drivers/isdn/hisax/config.c
index 7108bdb8742e..b14714004503 100644
--- a/drivers/isdn/hisax/config.c
+++ b/drivers/isdn/hisax/config.c
@@ -1029,7 +1029,7 @@ static int hisax_cs_new(int cardnr, char *id, struct IsdnCard *card,
 
 	*cs_out = NULL;
 
-	cs = kzalloc(sizeof(struct IsdnCardState), GFP_ATOMIC);
+	cs = kzalloc(sizeof(struct IsdnCardState), GFP_KERNEL);
 	if (!cs) {
 		printk(KERN_WARNING
 		       "HiSax: No memory for IsdnCardState(card %d)\n",
@@ -1059,12 +1059,12 @@ static int hisax_cs_new(int cardnr, char *id, struct IsdnCard *card,
 		       "HiSax: Card Type %d out of range\n", card->typ);
 		goto outf_cs;
 	}
-	if (!(cs->dlog = kmalloc(MAX_DLOG_SPACE, GFP_ATOMIC))) {
+	if (!(cs->dlog = kmalloc(MAX_DLOG_SPACE, GFP_KERNEL))) {
 		printk(KERN_WARNING
 		       "HiSax: No memory for dlog(card %d)\n", cardnr + 1);
 		goto outf_cs;
 	}
-	if (!(cs->status_buf = kmalloc(HISAX_STATUS_BUFSIZE, GFP_ATOMIC))) {
+	if (!(cs->status_buf = kmalloc(HISAX_STATUS_BUFSIZE, GFP_KERNEL))) {
 		printk(KERN_WARNING
 		       "HiSax: No memory for status_buf(card %d)\n",
 		       cardnr + 1);
@@ -1123,7 +1123,7 @@ static int hisax_cs_setup(int cardnr, struct IsdnCard *card,
 {
 	int ret;
 
-	if (!(cs->rcvbuf = kmalloc(MAX_DFRAME_LEN_L1, GFP_ATOMIC))) {
+	if (!(cs->rcvbuf = kmalloc(MAX_DFRAME_LEN_L1, GFP_KERNEL))) {
 		printk(KERN_WARNING "HiSax: No memory for isac rcvbuf\n");
 		ll_unload(cs);
 		goto outf_cs;
-- 
2.17.0


Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1B8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2598F20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVivLXqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2598F20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbeGWPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:22:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36523 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbeGWPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:22:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d14-v6so126452pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L8+fiPMBjv+xt4hVwLR2LcDNB5+3+svfD6YIFWrEQiU=;
        b=tVivLXqV+Oya6zIru8r7jicqZqLWaBcx8mdzaEJd2f5g5bY9Ysv8bFPofCgFus9XUo
         z+hFm9hFIdqlXQ8FBK1oYoE/46jDZ2N5RN9z9gGTIE2Ka14djCnN9STAFXz2tM9Sh7sm
         BnBdtzHMDXk08yJELESs3KBCNDRr+KXx1l9rLaWhY/iKgL5GQn+Riyk+5IJ/B78d/Vte
         GlqED9xa/goTWQp8VHBjpVWh40X3I3yWf3CJvjZJkSUcGINyIT3W79W0b2mccBll8dcM
         K0VEH/wPNSGzWSZ6onsh9mLU/BoCPT9Qcb7PRA9OVljOBp5HjE9ntzfRoo3H/V+3Eiz6
         p8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L8+fiPMBjv+xt4hVwLR2LcDNB5+3+svfD6YIFWrEQiU=;
        b=t3rrpzRuHQTGEK/vUHJxr0ljPH+t/b1Q6cwwXUF+FkiEww2VdujocNRxoSoS10Y4qi
         9c+y199Kiyc4X6duWqx801v43740i3HIBnfASNr0mgi/Z4kHDvbggPziwKXTv22QMIfq
         EVlGVn9+hV7iZYUwfNwM0lCEoEG4KOEewW2NsuDZkG+4R1GdRexfdl7hGZ2eMr58WdGm
         K1un1VsZ3EIkn4vcaDqCCvhOelNN9T1AB9LJp5iMUsUUBNei/kjowNZH8suGQoj1Gwms
         WTuY4G3oL1NfRfO0NGAIj59PjXQiN9PbXzQZ38GqcrWyCCGPkeNHktM67Z3Ps1tWAZxt
         WdAg==
X-Gm-Message-State: AOUpUlFKM89jwBa9HcSZqu9+fXV1zsjI2Iu8Nqg71n5DRsDITydeWF05
        7T5mO1osTw6apWVUF/rH6fU=
X-Google-Smtp-Source: AAOMgpdzk0aSKd3Ou/qmWoelpFeltcAi2O6qofRv1yXnjZLHkNKV0OCISbqznDgquvKziVrFSXr48A==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr12471141pgw.132.1532355674517;
        Mon, 23 Jul 2018 07:21:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:e422:450a:e730:728b])
        by smtp.gmail.com with ESMTPSA id g184-v6sm11560306pgc.22.2018.07.23.07.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:21:14 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] firewire: init_ohci1394_dma: Replace mdelay with msleep
Date:   Mon, 23 Jul 2018 22:21:04 +0800
Message-Id: <20180723142104.3477-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_ohci1394_wait_for_busresets() and
init_ohci1394_reset_and_init_dma() are never called in atomic context.

They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/firewire/init_ohci1394_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/init_ohci1394_dma.c b/drivers/firewire/init_ohci1394_dma.c
index 2cc89ce745c9..6b5a3c12f715 100644
--- a/drivers/firewire/init_ohci1394_dma.c
+++ b/drivers/firewire/init_ohci1394_dma.c
@@ -192,7 +192,7 @@ static inline void __init init_ohci1394_wait_for_busresets(struct ohci *ohci)
 	int i, events;
 
 	for (i = 0; i < 9; i++) {
-		mdelay(200);
+		msleep(200);
 		events = reg_read(ohci, OHCI1394_IntEventSet);
 		if (events & OHCI1394_busReset)
 			reg_write(ohci, OHCI1394_IntEventClear,
@@ -228,7 +228,7 @@ static inline void __init init_ohci1394_reset_and_init_dma(struct ohci *ohci)
 	reg_write(ohci, OHCI1394_IntEventClear, 0xffffffff);
 	reg_write(ohci, OHCI1394_IntMaskClear, 0xffffffff);
 
-	mdelay(50); /* Wait 50msec to make sure we have full link enabled */
+	msleep(50); /* Wait 50msec to make sure we have full link enabled */
 
 	init_ohci1394_initialize(ohci);
 	/*
-- 
2.17.0


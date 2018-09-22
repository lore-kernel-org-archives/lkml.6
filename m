Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71204ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141B2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141B2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIWCGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:06:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:33829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbeIWCGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:06:17 -0400
Received: from eddi-vb.fritz.box ([87.123.147.0]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQeET-1gE1tX1qAv-00U5IZ; Sat, 22
 Sep 2018 22:11:22 +0200
From:   Tobias Herzog <t-herzog@gmx.de>
To:     oneukum@suse.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cdc-acm: do not reset notification buffer index upon urb unlinking
Date:   Sat, 22 Sep 2018 22:11:10 +0200
Message-Id: <1537647071-2691-1-git-send-email-t-herzog@gmx.de>
X-Mailer: git-send-email 2.1.4
X-Provags-ID: V03:K1:QhsEh3wA1+3v7LtrNvHxKCikbMPc7ivodPrGkhh9Dxm8Acc/kZO
 DCtBMBhiAY1OqDu6v574pFyyCNAb2P2vz7KRuK54GFKbQAp4NUCjHGKFkKiLcfnGV5IHy26
 NM/bz3tCaw+HG9h9BFb6M7XERQj540/hfvQEc+/yd14cZGGgg5HtbndaY4dzNvaRKZySSoQ
 i9EDdhEEmhPwXBJ8ynZ1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dHWl2n3aPdg=:Ccm6O6dNuyPtCUIK5ylcrw
 dKVxPZY6uobb/V8qv9dcc4+2zYYthVM5d8zDx66ETTbZ7qKbDMUhWxcRc1GKsFl1J3fl58cF4
 VWsdx6hiWpDRqI8o/+5x2uQA+PhL7ZqFu2SV5XyBeM03WlZx8SipRxq3aBvN2EQJ7FLbez/6c
 OgqmHa1PzoqIeXJT7Uu3SxLgC+jX883QnsKcbUbO+61BPh/1ekov2UiFVgZYLmN0ZR+UgUj0e
 068P3gb44qG1Rm4IeiTOwQ/7l42Vl88gD+Muj0dhAXUvIbZ4BNu6YIlU9kS+rdXXVoD01t+og
 SaywC3EBQI9Xhr2jhlukI+1b4bRsX/pshxbws7mse+iQTlL7UaTKMAd+c+lLGvh53bIMgSngT
 1mQ2rmoOPV4WQ6BRvW7S03iY12i0vjZcDaP1iXy1lKDoLb18hw9pubqR2us1Yb3A/igJxnKC8
 e+7D76CLNfVDU1fMSeJO7T8Mv8DQRLbWUnYdgEPtFNgbMtBlDAyg3ZxyfikAYKx2asvZnneez
 IDFJ486fz0Dw7dNaUDY4nBO+u5zatqJl8NxCnxc7Vs2BO433yq0W8qBkveRRtlpFh44w8VuJ7
 0UBvDnS89IyEtdwZpwyGdLGLnaAPEaAsURg50cc5sPcO/gN4CpwKeBiDGgESjsNRiyzbv2QGq
 DyKE6LRFmRAJ937i9Z19XSSaX7PMG8s4mDGxvFUIaI1gWwb+V/5l3oQj5Pyp0p1Nt0HI5PJ6R
 i3jaVzt4IO5wWxxJHIy/Kx521YQ8efEn76JucZHZWl7EtDWtLxwr38LYxyaP5Fx03U029YM9t
 zK/SSMSj3k/eKdCeRiWsnbkeepmNQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resetting the write index of the notification buffer on urb unlink (e.g.
closing a cdc-acm device from userspace) may lead to wrong interpretation
of further received notifications, in case the index is not 0 when urb
unlink happens (i.e. when parts of a notification already have been
transferred). On the device side there is no "reset" of the notification
transimission and thus we would get out of sync with the device.

Signed-off-by: Tobias Herzog <t-herzog@gmx.de>
---
 drivers/usb/class/cdc-acm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 27346d6..50339ca 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -355,7 +355,6 @@ static void acm_ctrl_irq(struct urb *urb)
 	case -ENOENT:
 	case -ESHUTDOWN:
 		/* this urb is terminated, clean up */
-		acm->nb_index = 0;
 		dev_dbg(&acm->control->dev,
 			"%s - urb shutting down with status: %d\n",
 			__func__, status);
-- 
2.1.4


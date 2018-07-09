Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A6C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1588520673
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvRPjkeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1588520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932504AbeGIJBO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:01:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36334 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754077AbeGIJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:01:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id u16-v6so13215291pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RvigYRG3J3iEcUNgk32LwqwVII13LMfAQxIwp8kGsTQ=;
        b=FvRPjkeKN9JeD2RmsOfoelmJYRmdfqJ+QVSoK7/NTW/ScXnHrplv9TKIHsNLT5IUqU
         xaRUN6QIj6A7LrrDp+ws+2NqYFct6YTLIrOaLEolB1bIwx26IIeGYDKtuTlIvvcgE7Y6
         /Y6V93zry0zJtKGWMNIKr3wmosOyKinUF/WZckoz/t0Pnud/7Z9jYft2Ke/JuCVp3t5j
         3RgFkojhUbdF32AqoMQHhCYHLeYeqYfU/CdlN27ttbn+USaTKm6chV9kW84+pwcXvNzv
         tXbNFm2qyJnMMgCCgqY6CQbG+R0ZNMnZZHKl9WOHS6GI3sqriYAKWwTD0QD5DBKzDVW/
         4cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RvigYRG3J3iEcUNgk32LwqwVII13LMfAQxIwp8kGsTQ=;
        b=ZvDBsWRdZo7LcAR7CCop6BofdCc89Y6UkTWUxwMJI2d7OyLoBlX7zkCvLhIYaLILSd
         MrJlg0lf6NsKc0yQnQzWZkFeSM5ZpoMWTlLc3SgFtF0SkPjOHNhgxGV0XwDPBeE6+/iX
         ilUfikEhhD3Il8WOnQejYRHqIiT4cPWlo3DfXPxwWMztk43rzJaXA10XgmmRAdOae49H
         tvJ8SH0dJY5pOF2ZXfeV3m0OVo4N5o2knoMWLz1wkFwx+2i5qFiMlTFg9wlqJgVMlWJI
         NL+v1Fqlh/C/V8juSJ2PzFv/5Z4eFFtSEIiSzzAXxwqyBJGGgwQ9AmP+sQmHX3NQP08z
         BU+Q==
X-Gm-Message-State: APt69E0Pk8lkyQXDlmZM5RDcdlr7SK8wAAMbVs1aS/ZfYjv2p6XUVLZ6
        k75r7M1D7rYG7bgJfD+XEms=
X-Google-Smtp-Source: AAOMgpdOJNRQ6qkg7BYG1rxQtkEhfVFjfwG3C+zUeJi3O3cH55m7MdqDHaYKqC5XPyB3CdYLT2YQxQ==
X-Received: by 2002:a62:b14:: with SMTP id t20-v6mr12401589pfi.36.1531126873097;
        Mon, 09 Jul 2018 02:01:13 -0700 (PDT)
Received: from localhost ([14.139.180.40])
        by smtp.gmail.com with ESMTPSA id r16-v6sm27557154pfe.173.2018.07.09.02.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:01:12 -0700 (PDT)
From:   Jaya Durga <rjdurga@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     quytelda@tamalin.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        root <root@boss.chennai.cdac.in>, Jaya Durga <rjdurga@gmail.com>
Subject: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Date:   Mon,  9 Jul 2018 14:14:06 +0530
Message-Id: <20180709084406.6129-1-rjdurga@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: root <root@boss.chennai.cdac.in>

CHECK: Macro argument reuse 'gdm' - possible side-effects?

convert GDM_TTY_READY to gdm_tty_ready static function
to fix checkpath check

Signed-off-by: Jaya Durga <rjdurga@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index bf554f7c56ca..5de1940c1f79 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -27,7 +27,11 @@
#define MUX_TX_MAX_SIZE 2048
-#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
+static unsigned int gdm_tty_ready(struct gdm *gdm)
+{
+return (gdm && gdm->tty_dev && gdm->port.count);
+}
+
static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
@@ -127,7 +131,7 @@ static int gdm_tty_recv_complete(void *data,
{
 	struct gdm *gdm = tty_dev->gdm[index];
-	if (!GDM_TTY_READY(gdm)) {
+	if (!gdm_tty_ready(gdm)) {
 		if (complete == RECV_PACKET_PROCESS_COMPLETE)
 			gdm->tty_dev->recv_func(gdm->tty_dev->priv_dev,
 						gdm_tty_recv_complete);
@@ -154,7 +158,7 @@ static void gdm_tty_send_complete(void *arg)
 {
 	struct gdm *gdm = arg;
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return;
 	tty_port_tty_wakeup(&gdm->port);
@@ -168,7 +172,7 @@ static int gdm_tty_write(struct tty_struct *tty, const unsigned char *buf,
 	int sent_len = 0;
 	int sending_len = 0;
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 	if (!len)
@@ -195,7 +199,7 @@ static int gdm_tty_write_room(struct tty_struct *tty)
{
 	struct gdm *gdm = tty->driver_data;
-	if (!GDM_TTY_READY(gdm))
+	if (!gdm_tty_ready(gdm))
 		return -ENODEV;
 	return WRITE_SIZE;



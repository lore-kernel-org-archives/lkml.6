Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ADC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EB420882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOFmYlSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EB420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeGIKR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:17:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36108 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:17:26 -0400
Received: by mail-io0-f193.google.com with SMTP id k3-v6so16557918iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RvigYRG3J3iEcUNgk32LwqwVII13LMfAQxIwp8kGsTQ=;
        b=qOFmYlSglJOUi6cbJUUeABXGhCyNGvikIzTRGlkjiEW9GRyG0bjRp8d/aZZpoKOE9l
         U66DOgtbVbs+dRnaOc01x9GE+tBc/DVwtuY3Q68N7LUnN19s1yZULZFodkGP7hIjP4UM
         92CAx5V6XXbSsmvaenSeoiIrI44ZWjEH+WWdWTULWCgZOqSXiTiaQCQJ4gPqcgsFjYbs
         sbZC+7CHaFeGdaWaSiSzykcH/dCTUvN7W8jnwcBtm66LGub9asdvyX54YXkCbaSZEleo
         uYWaI2utvVTxh03nJL71y9x3x2GgRctJQF//9Bg2Se+Y0dpkgaiDuoEEzPw2kkajqMwI
         WNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RvigYRG3J3iEcUNgk32LwqwVII13LMfAQxIwp8kGsTQ=;
        b=e7ek7bmp4DtVIhQF/sxGjlvWTnmAV53LWNO4Bv/jVmmLl5PJi7M67PBlaorm9upEN+
         0iwCMAh/YV/xB9XhhS7WSVm2lea2hLZUhAmEONRzvLY1yDx+opaekkgXXULFiojdLdoG
         prBxBiSgclX1fcvnkPb21aivyNbwuKharJIf982ipvmMm7AiCNBXFq9CdxhkD5dxF/kO
         TVnIbA899SwPFbdw8l24r91nsmuNT42g9znOfxpf4sGk6OGxHSLRBLWXXFetVaA2xH96
         f6CovFoG7UUmxZcn0xpvtgmbDujROFw7jFPTFtZqMxhKOphs6eGwwOT0geuXBZP6A/xf
         AjAA==
X-Gm-Message-State: AOUpUlE7REImSTS9SAldjCaT5WIJMWW9hopY9V7iPqrTQXCdhvRshJM7
        3O+fTMKud6ahcmqdS9SZTQw=
X-Google-Smtp-Source: AAOMgpcq+FC6Iy6c79BuLR6zgUaeG+ZiP9dEAGxD6wiwCE/5IcVExsmcFT556rFDmnp9P54ccLQxyg==
X-Received: by 2002:a6b:6503:: with SMTP id z3-v6mr7926005iob.129.1531131445458;
        Mon, 09 Jul 2018 03:17:25 -0700 (PDT)
Received: from localhost ([14.139.180.40])
        by smtp.gmail.com with ESMTPSA id w141-v6sm1622568itb.31.2018.07.09.03.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 03:17:25 -0700 (PDT)
From:   Jaya Durga <rjdurga@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     quytelda@tamalin.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Date:   Mon,  9 Jul 2018 15:30:20 +0530
Message-Id: <20180709100020.7399-1-rjdurga@gmail.com>
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



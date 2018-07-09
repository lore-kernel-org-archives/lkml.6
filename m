Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A43C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/oJXh/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932801AbeGILPK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:15:10 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33830 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbeGILPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:15:09 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so13458288pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=owlczyPcFLNrePYRAylupTU7gKMpXSCpjpryOOV8Izk=;
        b=A/oJXh/yPAzVBCC/eIaYGTse8hXC5ESaJDUr7ZZEHY2zkim+ZO9pJGVOUERG4At/kA
         6MYbABvomcKq8cMAcHJJ9GYy/aqDchWoEWzVV6z2Pn4QFiVIKJ5GwWDBV4XmUyv18aW7
         vXua3EC8FcZgIUEC5vDF8tdJk30n8xAT+5CjDNH53UPw98Lrk/PWvImDp5cm3oDCrSVe
         EddqRcsF9LCmNK5Db9HSo2lgA8vaWv97ZIMPUZfAMoMp8p/eh7KxDYgv/6gTBMoD3gtk
         ErlI1yyNZ9rjZVSPfNPERZ7R4OL6kLzW3kg7S3y4jWVWVv25p35JVenKV/huM6T/StFj
         Q+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=owlczyPcFLNrePYRAylupTU7gKMpXSCpjpryOOV8Izk=;
        b=ZoenPXkFV1fQV+suOTNIZqzes+R4p9APSxE/hjvLBLS1j0ANktnyu0jZMxGnVksUIR
         6I1OhOdiaoHvhqEGQ/UkJLmCDTWXqz07bTEnH9RUjfFi17WbyzD0HEQU0hvBiIwlQFiz
         oGCQ8NNzfVp5b/KZ7hODiGBX0izYAlYYzoMb4bsGm+TwjStd/Si782UsgLqXI1ABU8PO
         m7sy26c9JKXhDbxtxdDqUa+YG3OQM+CkByeWUEYOAiskV4AvpTTcrQ9TWCrX2D2BxhyK
         BR8BATVDx4tFfNBXriJxLGoUX036V3I1I2M5ROrl2l9QVUjHbPcb4LJYnLfFmonWFqbS
         +rQg==
X-Gm-Message-State: APt69E2mPP+L5p6eX23jEqKsPSh+wEW4taWDx1t4FaCIu2TrLpBMtPOi
        th8HrfTJHzN67EHosmmCWio=
X-Google-Smtp-Source: AAOMgpdYjOPXG6tTUZX1nHCN/GPHpEDVwKHg3Kbn9X1dEtimmHRPxOAIIeD60rmJM8PjFAAVtOC9jw==
X-Received: by 2002:a63:7f16:: with SMTP id a22-v6mr18509340pgd.255.1531134909113;
        Mon, 09 Jul 2018 04:15:09 -0700 (PDT)
Received: from localhost ([14.139.180.40])
        by smtp.gmail.com with ESMTPSA id x6-v6sm22752353pfe.30.2018.07.09.04.15.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 04:15:08 -0700 (PDT)
From:   Jaya Durga <rjdurga@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     quytelda@tamalin.org, jonathankim@gctsemi.com, deanahn@gctsemi.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Date:   Mon,  9 Jul 2018 16:27:58 +0530
Message-Id: <20180709105758.7943-1-rjdurga@gmail.com>
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



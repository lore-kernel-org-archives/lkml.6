Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF820873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlV2kKtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CF820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932727AbeGIMxv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:53:51 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46894 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeGIMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:53:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so6003727pld.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=owlczyPcFLNrePYRAylupTU7gKMpXSCpjpryOOV8Izk=;
        b=FlV2kKtKy0a70dOreU4nkDlZ5rkhZlCvYLjmaaGcGfy8i/K2SoxTORnHDKTRQqOyvS
         II30GvJoN5r3B5GzO9WUmAq9ae5/1PRRDabtXJmr4Q7wE0xjEphCxivpVSonOFglP/1X
         vhGVSOSVdNOFSf6fjsDVoxdIh0p1MBCmLQZlqhLI7etk5Tt7Q6sDuZLp7uULjmUlCTzH
         T10hGN3gqVeXkuxoln4HUfmn6x2YSWuqxPTcCG3KQ7tr8nSCtEl/ov5gYgEll1P9teq+
         2FF5U9aY2WgwfGv1EaLp7/rwDhZY8mIMIj49fKEhHgAIeme0zcfX2DDvf8XW0v3fnVhe
         6Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=owlczyPcFLNrePYRAylupTU7gKMpXSCpjpryOOV8Izk=;
        b=NEyWQgQHunJxK2q3zkqDnkb0tdoLrkZqbLaEth+RcA2oUtLtIN87TGxR6VhFEOjZeJ
         TvnqEf3Oa/USqSYszKN9ZQwyBOt/qGJ7HxLwPxGgtQrGywI4jafru88pRr19GJJe5u9k
         b57WFHFtDT5VjeVkFSfrjIwuJ8PH7+PAFVR7TTT0SNt8kTx87aCGNmUXxa+Dfj/SFzRh
         HYiLWbvkPD625OcoG4ZdlzeHojMp1d1w4bPq18UBoCEAy3KH6jPwcIiuPq9UOkPd0OCS
         hc7k/srmdIS5T4T2JuUJiPRJRBCNPEun8q5eQsK9r3r4tl3D9nHSJnKQQpjqba4Jkb61
         emnA==
X-Gm-Message-State: APt69E3Vtc+GVhjkNHkGsoioG7tZYnpx1EJsifh6ZVaBVpkzhvUcQXqo
        Jcnq7IORzuuGQFL8O++8/Q0=
X-Google-Smtp-Source: AAOMgpecLUBEHhGU8rxLLVu63a0PTGPlIxEzjwLXNqVh7PkTVhvxfTs8Jj/umfCyHhv7VGK1dbireA==
X-Received: by 2002:a17:902:b81:: with SMTP id 1-v6mr20786628plr.164.1531140829239;
        Mon, 09 Jul 2018 05:53:49 -0700 (PDT)
Received: from localhost ([14.139.180.40])
        by smtp.gmail.com with ESMTPSA id j27-v6sm44371148pfe.48.2018.07.09.05.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 05:53:48 -0700 (PDT)
From:   Jaya Durga <rjdurga@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     quytelda@tamalin.org, deanahn@gctsemi.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Date:   Mon,  9 Jul 2018 18:06:32 +0530
Message-Id: <20180709123632.5682-1-rjdurga@gmail.com>
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



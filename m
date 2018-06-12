Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5D7CAC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A21208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWyVx8gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A21208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeFLEgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:36:36 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45551 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeFLEge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:36:34 -0400
Received: by mail-pg0-f65.google.com with SMTP id z1-v6so10829199pgv.12;
        Mon, 11 Jun 2018 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u2y/COd7y8AES/tK0ar8bdl7+Wngd4RVNZyzRK4JZmE=;
        b=bWyVx8gVe8Py4PiMNhLiHpvvBH5DCY1++MQ0orkVEhAoIRDWpFf0NGsGinDXuLkBW5
         AEoR4U80Xf9K4Or8Wre27lT2zjCWVUjURKhGqH28UKY92LM4+iWrLZoWGr2dCg6zSOlT
         /s5lPnuaBWa5ZX5OV++kUWNVYo6GvozF0AjHiOYt+F87ye/JYDpXDuV9Y0NC/Im8GlYi
         HKofGiPCNUPuWo/n+IBFsexppKXvnOpPCB+owDkyp5j8ogSbtK1J4YDI2xayZbayVbhe
         koksWVmfcLFhCIZ5C7SJs+WOiEyvIlS41iAkP4myaFfwh/uCYqSjLjBDMW6gH4Ddiyil
         MpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u2y/COd7y8AES/tK0ar8bdl7+Wngd4RVNZyzRK4JZmE=;
        b=BocKrDyGSDsHR0lYWuqVEk7Z4YQOmxeic6W1xOLBVh09tpDYFI7Fx3/KfYJS93tBTS
         +pI7nTVh4fcToQZpOles1APf7id+dBJH7tQFsaMMSCCH/Ruz2UNnl4pL27tRqUI2setM
         M8QVuOrX99KVKSxW512wX5rkuADzzJGNV0WAe822WmyrNuNNAhL/NrKu2ThpS0BRjoYv
         i7xerCwRNL1uriv8Jrsk+ktuKZk2FiTo6j4v5n+TPGo5TlW8R0n7e4KHWUpbh10XupQr
         xX2jhXOf7Vf/kp2KuIRfp+Gruib1BVZFBQVWQNBpznc4EDHlXO6CGk6VZ4DNbqXPfcr5
         gfoA==
X-Gm-Message-State: APt69E2uYzKP3kczEeu5R4s6d11hriyWDXrdXA+1JKFZeqCjjeZSTkIF
        4F5y63Uyf2tyInJ31TpgklI=
X-Google-Smtp-Source: ADUXVKINMhRv1r9olMEMqWDsQ8MunUIN6NPoc/1MpDlHU9+zElJ8A/dbwggp+GYC+B+vHhWzFdth0Q==
X-Received: by 2002:a63:3201:: with SMTP id y1-v6mr1776666pgy.419.1528778194234;
        Mon, 11 Jun 2018 21:36:34 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id b22-v6sm15029438pfi.144.2018.06.11.21.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:36:33 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/tty: add error handling for pcmcia_loop_config
Date:   Tue, 12 Jun 2018 12:36:25 +0800
Message-Id: <1528778187-41182-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pcmcia_loop_config fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pcmcia_loop_config.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/tty/serial/8250/serial_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 9963a76..c8186a0 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -638,8 +638,10 @@ static int serial_config(struct pcmcia_device *link)
 	    (link->has_func_id) &&
 	    (link->socket->pcmcia_pfc == 0) &&
 	    ((link->func_id == CISTPL_FUNCID_MULTI) ||
-	     (link->func_id == CISTPL_FUNCID_SERIAL)))
-		pcmcia_loop_config(link, serial_check_for_multi, info);
+	     (link->func_id == CISTPL_FUNCID_SERIAL))) {
+		if (pcmcia_loop_config(link, serial_check_for_multi, info))
+			goto failed;
+	}
 
 	/*
 	 * Apply any multi-port quirk.
-- 
2.7.4


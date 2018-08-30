Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BB420666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clMamF/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BB420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeH3FrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so3133369pgp.9;
        Wed, 29 Aug 2018 18:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cu4oYdi29BeIVUgBpHHRk6wAnaM4DIFxP/7eTOSnPAw=;
        b=clMamF/K17MHX3zSijJ3DLqsAbOEXd1MmRHVf81IQCuvBa3BYSI/sZMH447TQZtCk4
         Ec7tGKnZ14YlHqeR2asLs3exGhnnotPRYS1Tir2Pdp438cyR9rUbZFv5vMHxNeGnnBRI
         QaK3TTAk16+p23Zaq3TlMnZ1BLVpKZbTYwMzU4POwsubuc1OFEVfzBZACvwOM8zna+KW
         b8+YSVe0M8TF/lHAXe/Rqh1ZkPInrnJcdTEJ+3Xbs4oKfeqtfBJG7MbBDNGwlzUUhy1l
         s9S8AEud76hfe9vPY06MgZnB8oFuBNh9kpNyWFDUxDbII+x+r38bTzzd1n8S8ajTDkm4
         eREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cu4oYdi29BeIVUgBpHHRk6wAnaM4DIFxP/7eTOSnPAw=;
        b=aado+KC+IiZN+xsQGrkrXq6juHqUQNIC/cfyoVl/woR89Aa75dwMTjq+KPAZe0oAAj
         ukZaFCC3UwxaJnzbQuyTlLwilRNljT/PloBhQOfFmnCCWBQi5H5calOENll+Kl3nWml/
         7T+i4FoLaZJETl1p4ue6OwIDefxjM1TXH6K//L1ltnVnWgyCmDqbQhSo2FHIjEOkIIyM
         UDZ3YkBZSmjjXko0dnn0fH1h3KbjOHL+HdHiyyjI+gLQcO/FOqSb1atcem4WQPwI0e6f
         vW7r+FlsmKAOEFMgWDnKj43DAW9vQqwZ0ZTYygnkJqYik3ueHhiTdAkJ6u0UTzCImG1e
         0S6g==
X-Gm-Message-State: APzg51Ct9G6JSxqMptU9c/iRTtbn0nvGIdbDdA3kjYL7cKhJWyHgmzQC
        Z0NGztCd0tEbjdGjxqmCVlQ=
X-Google-Smtp-Source: ANB0Vda5/FmrNnnVWNN+JvgjmkvtOEvThUNhiGFU9gzMBKlxxyTXDb9pgUBeTtD82nfSpBvc187aLA==
X-Received: by 2002:a63:788b:: with SMTP id t133-v6mr7696387pgc.329.1535593643453;
        Wed, 29 Aug 2018 18:47:23 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id a16-v6sm6184210pgv.29.2018.08.29.18.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:22 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com, Oliver Neukum <oneukum@suse.com>
Subject: [PATCH V2 1/4] USB: serial: f81232: clear overrun flag
Date:   Thu, 30 Aug 2018 09:47:10 +0800
Message-Id: <1535593634-22004-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The F81232 will report data and LSR with bulk like following format:
bulk-in data: [LSR(1Byte)+DATA(1Byte)][LSR(1Byte)+DATA(1Byte)]...

LSR will auto clear frame/parity/break error flag when reading by H/W,
but overrrun will only cleared when reading LSR. So this patch add a
worker to read LSR when OE.

Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v2:
        1: Add flush_work(&port_priv->lsr_work) in f81232_close().
           Thanks for notice by Oliver Neukum

 drivers/usb/serial/f81232.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 96036f87b1de..2f595307dd14 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -41,12 +41,14 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define FIFO_CONTROL_REGISTER		(0x02 + SERIAL_BASE_ADDRESS)
 #define LINE_CONTROL_REGISTER		(0x03 + SERIAL_BASE_ADDRESS)
 #define MODEM_CONTROL_REGISTER		(0x04 + SERIAL_BASE_ADDRESS)
+#define LINE_STATUS_REGISTER		(0x05 + SERIAL_BASE_ADDRESS)
 #define MODEM_STATUS_REGISTER		(0x06 + SERIAL_BASE_ADDRESS)
 
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
 	struct usb_serial_port *port;
 };
@@ -282,6 +284,7 @@ static void f81232_read_int_callback(struct urb *urb)
 static void f81232_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	unsigned char *data = urb->transfer_buffer;
 	char tty_flag;
 	unsigned int i;
@@ -315,6 +318,7 @@ static void f81232_process_read_urb(struct urb *urb)
 
 			if (lsr & UART_LSR_OE) {
 				port->icount.overrun++;
+				schedule_work(&priv->lsr_work);
 				tty_insert_flip_char(&port->port, 0,
 						TTY_OVERRUN);
 			}
@@ -556,9 +560,12 @@ static int f81232_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 static void f81232_close(struct usb_serial_port *port)
 {
+	struct f81232_private *port_priv = usb_get_serial_port_data(port);
+
 	f81232_port_disable(port);
 	usb_serial_generic_close(port);
 	usb_kill_urb(port->interrupt_in_urb);
+	flush_work(&port_priv->lsr_work);
 }
 
 static void f81232_dtr_rts(struct usb_serial_port *port, int on)
@@ -623,6 +630,21 @@ static void  f81232_interrupt_work(struct work_struct *work)
 	f81232_read_msr(priv->port);
 }
 
+static void f81232_lsr_worker(struct work_struct *work)
+{
+	struct f81232_private *priv;
+	struct usb_serial_port *port;
+	int status;
+	u8 tmp;
+
+	priv = container_of(work, struct f81232_private, lsr_work);
+	port = priv->port;
+
+	status = f81232_get_register(port, LINE_STATUS_REGISTER, &tmp);
+	if (status)
+		dev_warn(&port->dev, "read LSR failed: %d\n", status);
+}
+
 static int f81232_port_probe(struct usb_serial_port *port)
 {
 	struct f81232_private *priv;
@@ -633,6 +655,7 @@ static int f81232_port_probe(struct usb_serial_port *port)
 
 	mutex_init(&priv->lock);
 	INIT_WORK(&priv->interrupt_work,  f81232_interrupt_work);
+	INIT_WORK(&priv->lsr_work, f81232_lsr_worker);
 
 	usb_set_serial_port_data(port, priv);
 
-- 
2.7.4


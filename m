Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4306C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hEWI4KZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilCSkDOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4306C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeILMyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:54:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33311 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeILMyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:54:43 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F0E3A21C1C;
        Wed, 12 Sep 2018 03:51:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Sep 2018 03:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wHfcbhCMsbt9mZBMH
        6l/+jCbzzslRHmi0qaAVelXT0Y=; b=hEWI4KZBqSpdtXq7itoC8JwtY79zm1Xlt
        g3I7y77XXS/xViEDByd8/Zxhvd44ilkEEsQX47lsfmN44nVv55erYWgI7WnE7vav
        E1WI6S3VX5xUnqprgk+Rv/Fqu84oqMjWjj9f63tlNRxJh5lrBbeOAieIzFUUP7Lb
        qZIs7rAgA+xO7hMFYu+vyBrya4zjwsjVoCR/lZmD0dn/tesAd9acYlQ86rKnuLp7
        FGeajiRFMXEKJ288WjiKi33JfVzFneKBxI57ubFOp3BkHyehMQN2yesPTp0ylPH7
        D/cFTTEVn8lWKRz3zzbwWWr+v1HrwRcySqnDt64fbpXAuxGgMvg+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=wHfcbhCMsbt9mZBMH6l/+jCbzzslRHmi0qaAVelXT0Y=; b=ilCSkDOF
        YVFilIgX3vJEO77JRduOMVPhYnPtHUELSeSQ8OqLCD7QmHJdLHGAeZWgETuVnjhn
        llmxGVTGl1As2HVBWb1wc5LLzf6SMqHBkpQ/J1cGSCZWOKGKH9FwygsawE6hMU19
        lisS29uzf40VbogWZKyrxilJonTALFvkMYVYuA1HSzjBYRz01B+ha1TnJcjKKEWI
        M26ToE/pWzMAssUi5uLKgMFdOyE7BpTGXXSOR3m29Y6YdWhHQ1GYj3xzQd3KNOYS
        tmjBU8Egd9CA9ik2/F6IuvGI3bHKZymUc4Mo3qALKCV3kzYNKL9cp461ey3wDE8j
        tym3v0XMoHiLVQ==
X-ME-Proxy: <xmx:e8WYW1x0GIgurZIQHBH8rtaCs1LUukD9epMXuVaIdQjKMyCBA-lt7Q>
    <xmx:e8WYWwQZ21DuUrcAgKHkurAMc4jyEfLgMpS6XHvEKR2P306eJMadoQ>
    <xmx:e8WYW-XyI-BMUT0qWaBXkkcxjy48owYZr-GwpktfqBPuEf9wCjIDlQ>
    <xmx:e8WYW5M8tqfzTFWiomhBb9TfmxaJ2dUWFWb-SpvPIhAdqOBPs8UeyQ>
    <xmx:e8WYW2rpIbXV4JhGhxRdjQXkVxV6SggvRWRufEzHj0BRkQKxTeoHRA>
    <xmx:e8WYW4mdNe291Jxcd_a0XwskSf7XQKIYgTlT7BP9yYwBxo6BsaNKMA>
X-ME-Sender: <xms:e8WYW2OUvJhcNhdkpfSAtYuNJhp8-bqCUpLGY2cVZ2gAFE0cyLM5ew>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id C69E6102D9;
        Wed, 12 Sep 2018 03:51:22 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/3] tty_port: Fix function name and brief desc
Date:   Wed, 12 Sep 2018 17:50:43 +1000
Message-Id: <20180912075044.8695-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912075044.8695-1-me@tobin.cc>
References: <20180912075044.8695-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File contains kernel-doc function comments that are not in the correct
style.

 - Add '()' to function names
 - Capitalise brief description and append a full stop.
 - Use correct spacing for function name / brief description as per the
   kernel docs (Documentation/doc-guide/kernel-doc.rst)

	/**
	 * function_name() - Brief description of function.
	 * @arg1: Describe the first argument.

 - Fix spacing for kernel-doc function comments (no tab space after '*').

These changes all touch the same lines so do them in a single patch.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/tty/tty_port.c | 120 ++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index cb6075096a5b..382282013c9d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -74,7 +74,7 @@ void tty_port_init(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_init);
 
 /**
- * tty_port_link_device - link tty and tty_port
+ * tty_port_link_device() - Link tty and tty_port.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -94,7 +94,7 @@ void tty_port_link_device(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_link_device);
 
 /**
- * tty_port_register_device - register tty device
+ * tty_port_register_device() - Register tty device.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -113,7 +113,7 @@ struct device *tty_port_register_device(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device);
 
 /**
- * tty_port_register_device_attr - register tty device
+ * tty_port_register_device_attr() - Register tty device.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -137,7 +137,7 @@ struct device *tty_port_register_device_attr(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr);
 
 /**
- * tty_port_register_device_attr_serdev - register tty or serdev device
+ * tty_port_register_device_attr_serdev() - Register tty or serdev device.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -169,7 +169,7 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
 
 /**
- * tty_port_register_device_serdev - register tty or serdev device
+ * tty_port_register_device_serdev() - Register tty or serdev device.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -188,7 +188,7 @@ struct device *tty_port_register_device_serdev(struct tty_port *port,
 EXPORT_SYMBOL_GPL(tty_port_register_device_serdev);
 
 /**
- * tty_port_unregister_device - deregister a tty or serdev device
+ * tty_port_unregister_device() - Deregister a tty or serdev device.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @index: index of the tty
@@ -235,7 +235,7 @@ void tty_port_free_xmit_buf(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
 
 /**
- * tty_port_destroy -- destroy inited port
+ * tty_port_destroy() - Destroy inited port.
  * @port: tty port to be destroyed
  *
  * When a port was initialized using tty_port_init, one has to destroy the
@@ -273,11 +273,11 @@ void tty_port_put(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_put);
 
 /**
- *	tty_port_tty_get	-	get a tty reference
- *	@port: tty port
+ * tty_port_tty_get() - Get a tty reference.
+ * @port: tty port
  *
- *	Return a refcount protected tty instance or NULL if the port is not
- *	associated with a tty (eg due to close or hangup)
+ * Return a refcount protected tty instance or NULL if the port is not
+ * associated with a tty (eg due to close or hangup)
  */
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
@@ -292,12 +292,12 @@ struct tty_struct *tty_port_tty_get(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_tty_get);
 
 /**
- *	tty_port_tty_set	-	set the tty of a port
- *	@port: tty port
- *	@tty: the tty
+ * tty_port_tty_set - Set the tty of a port.
+ * @port: tty port
+ * @tty: the tty
  *
- *	Associate the port and tty pair. Manages any internal refcounts.
- *	Pass NULL to deassociate a port
+ * Associate the port and tty pair. Manages any internal refcounts.
+ * Pass NULL to deassociate a port
  */
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
@@ -333,13 +333,13 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 }
 
 /**
- *	tty_port_hangup		-	hangup helper
- *	@port: tty port
+ * tty_port_hangup() - Hangup helper.
+ * @port: tty port
  *
- *	Perform port level tty hangup flag and count changes. Drop the tty
- *	reference.
+ * Perform port level tty hangup flag and count changes. Drop the tty
+ * reference.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  */
 void tty_port_hangup(struct tty_port *port)
 {
@@ -362,8 +362,7 @@ void tty_port_hangup(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_hangup);
 
 /**
- * tty_port_tty_hangup - helper to hang up a tty
- *
+ * tty_port_tty_hangup() - Helper to hang up a tty.
  * @port: tty port
  * @check_clocal: hang only ttys with CLOCAL unset?
  */
@@ -378,8 +377,7 @@ void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 
 /**
- * tty_port_tty_wakeup - helper to wake up a tty
- *
+ * tty_port_tty_wakeup() - Helper to wake up a tty.
  * @port: tty port
  */
 void tty_port_tty_wakeup(struct tty_port *port)
@@ -389,12 +387,12 @@ void tty_port_tty_wakeup(struct tty_port *port)
 EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
 
 /**
- *	tty_port_carrier_raised	-	carrier raised check
- *	@port: tty port
+ * tty_port_carrier_raised() - Carrier raised check.
+ * @port: tty port
  *
- *	Wrapper for the carrier detect logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the carrier detect logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 int tty_port_carrier_raised(struct tty_port *port)
 {
@@ -405,12 +403,12 @@ int tty_port_carrier_raised(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_carrier_raised);
 
 /**
- *	tty_port_raise_dtr_rts	-	Raise DTR/RTS
- *	@port: tty port
+ * tty_port_raise_dtr_rts() - Raise DTR/RTS.
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
@@ -420,12 +418,12 @@ void tty_port_raise_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
 
 /**
- *	tty_port_lower_dtr_rts	-	Lower DTR/RTS
- *	@port: tty port
+ * tty_port_lower_dtr_rts() - Lower DTR/RTS.
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
@@ -435,28 +433,28 @@ void tty_port_lower_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
 
 /**
- *	tty_port_block_til_ready	-	Waiting logic for tty open
- *	@port: the tty port being opened
- *	@tty: the tty device being bound
- *	@filp: the file pointer of the opener or NULL
+ * tty_port_block_til_ready() -	Waiting logic for tty open.
+ * @port: the tty port being opened
+ * @tty: the tty device being bound
+ * @filp: the file pointer of the opener or NULL
  *
- *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
- *	Handles:
- *		- hangup (both before and during)
- *		- non blocking open
- *		- rts/dtr/dcd
- *		- signals
- *		- port flags and counts
+ * Implement the core POSIX/SuS tty behaviour when opening a tty device.
+ * Handles:
+ *  - hangup (both before and during)
+ *  - non blocking open
+ *  - rts/dtr/dcd
+ *  - signals
+ *  - port flags and counts
  *
- *	The passed tty_port must implement the carrier_raised method if it can
- *	do carrier detect and the dtr_rts method if it supports software
- *	management of these lines. Note that the dtr/rts raise is done each
- *	iteration as a hangup may have previously dropped them while we wait.
+ * The passed tty_port must implement the carrier_raised method if it can
+ * do carrier detect and the dtr_rts method if it supports software
+ * management of these lines. Note that the dtr/rts raise is done each
+ * iteration as a hangup may have previously dropped them while we wait.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  *
- *      NB: May drop and reacquire tty lock when blocking, so tty and tty_port
- *      may have changed state (eg., may have been hung up).
+ * NB: May drop and reacquire tty lock when blocking, so tty and tty_port
+ * may have changed state (eg., may have been hung up).
  */
 int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
@@ -623,7 +621,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 EXPORT_SYMBOL(tty_port_close_end);
 
 /**
- * tty_port_close
+ * tty_port_close()
  *
  * Caller holds tty lock
  */
@@ -640,7 +638,7 @@ void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 EXPORT_SYMBOL(tty_port_close);
 
 /**
- * tty_port_install - generic tty->ops->install handler
+ * tty_port_install() - Generic tty->ops->install handler.
  * @port: tty_port of the device
  * @driver: tty_driver for this device
  * @tty: tty to be installed
@@ -658,7 +656,7 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 EXPORT_SYMBOL_GPL(tty_port_install);
 
 /**
- * tty_port_open
+ * tty_port_open()
  *
  * Caller holds tty lock.
  *
-- 
2.17.1


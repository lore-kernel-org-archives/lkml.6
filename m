Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A39C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7477C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="b7RKi2g3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lq55aeiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7477C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeILMyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:54:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44433 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeILMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:54:38 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 77FAA21B7C;
        Wed, 12 Sep 2018 03:51:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Sep 2018 03:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pZElkUvQnheJKIWVj
        tk3hIrE3k9NZm881jX4kTxJ8rE=; b=b7RKi2g3HOJI+SzfPb0l+tV8lkiOMnjWJ
        oSJz3gN+bWQq1c6rWWVvBvBdu7P3gZSRFYzQLxUa4a2u2s0VlNf/YRSGv50VG3gL
        Uxm/xh6E3gdzeTOpsEVROeM/HeFsrj30/7pabFC4HqsyHa4D3H2L1squ6srprWGt
        PWgoSdRU2SST3O7yJwXicTZzEdenjZ+afF4nlcc7c4zr6KM42U31CmfNSO6swuUn
        9gHnpzzeb6YF6mUG6+1FRRKOqAGFBmqOh7nklF09SgoaIEEEMIl8mDKGcKyjl/Uz
        Q13xClOunHSvGz2oTgwT3qAMVm84uT2MBxQyrWBiYUwfjSVyih/Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pZElkUvQnheJKIWVjtk3hIrE3k9NZm881jX4kTxJ8rE=; b=Lq55aeiy
        iTBx7PsGblEADpi2UiQaOy9nHZbeJKfx/P54jOVbOJvLtNT2N6GNRKm60zYhYOHt
        qXroIVVgWHBW7W4MIzge7MMCApQbptCzUFDZ1a6ViHxfiitpqJjrGHDbtW3yXC5s
        Rm8c1cI1rRW+f8iFE5qJOPlFkIEshC9Ajs6Vhq3pkIQS6H3+A2wwbQllR+d2CBGN
        psAs88ZL35zAixZWDKMFFQa3rG4UNt0OTAZNL6Nv9OWdYtyI0GuoAnmixQUJ9gWj
        PNBVtXQ5ElQDvw9f+zX6KC5gdaGLw4mE4GwJqhOWjr0CGA/O74Rzty+J5G2GUADq
        cSEvF6Bqpc71Ig==
X-ME-Proxy: <xmx:d8WYW4CgJnRNLIrp5_53lx6145ArFuxlhN_0yJ2GIf-HFPSMATPLLA>
    <xmx:d8WYW6FAYAM5R8C_wD9s6R-gEznrT_P0QN9wf-QW7_KzEhYaBS7YLA>
    <xmx:d8WYW0-uw5jGt-K0gWWqvJWb4XlK13kYYaU9WfXsp3n4V2RgR_RiNw>
    <xmx:d8WYW3mZJTnKdrmy1KRCLLPRXf3vIEZxVDLKXVbMQvoE8rvYlk6bDw>
    <xmx:d8WYW6_uePT_nmKAQ3LSsFTaAW1bXPrLGfJlWtHFPvj8aczZ_bjnqg>
    <xmx:d8WYW9KkLOcPUPDbInr_0jaC_CcMcZMh8p4PsulY8EZab3luqkopnA>
X-ME-Sender: <xms:d8WYW4TC13V83YuFQ1YbGHetsidsfdDtv9Lg7aAK0M7TjlLXGk37Yg>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F355E46B6;
        Wed, 12 Sep 2018 03:51:18 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 1/3] tty_port: Remove incorrect whitespace after comments
Date:   Wed, 12 Sep 2018 17:50:42 +1000
Message-Id: <20180912075044.8695-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180912075044.8695-1-me@tobin.cc>
References: <20180912075044.8695-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are a bunch of kernel-doc function comments that have a
line of whitespace after the comment and before the function they
comment - this is incorrect, there should be no whitespace here.

Remove incorrect whitespace between comment and associated function.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/tty/tty_port.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..cb6075096a5b 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -279,7 +279,6 @@ EXPORT_SYMBOL(tty_port_put);
  *	Return a refcount protected tty instance or NULL if the port is not
  *	associated with a tty (eg due to close or hangup)
  */
-
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
 	unsigned long flags;
@@ -300,7 +299,6 @@ EXPORT_SYMBOL(tty_port_tty_get);
  *	Associate the port and tty pair. Manages any internal refcounts.
  *	Pass NULL to deassociate a port
  */
-
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -343,7 +341,6 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
  *
  *	Caller holds tty lock.
  */
-
 void tty_port_hangup(struct tty_port *port)
 {
 	struct tty_struct *tty;
@@ -399,7 +396,6 @@ EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
  *	to hide some internal details. This will eventually become entirely
  *	internal to the tty port.
  */
-
 int tty_port_carrier_raised(struct tty_port *port)
 {
 	if (port->ops->carrier_raised == NULL)
@@ -416,7 +412,6 @@ EXPORT_SYMBOL(tty_port_carrier_raised);
  *	to hide some internal details. This will eventually become entirely
  *	internal to the tty port.
  */
-
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
 	if (port->ops->dtr_rts)
@@ -432,7 +427,6 @@ EXPORT_SYMBOL(tty_port_raise_dtr_rts);
  *	to hide some internal details. This will eventually become entirely
  *	internal to the tty port.
  */
-
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
 	if (port->ops->dtr_rts)
@@ -464,7 +458,6 @@ EXPORT_SYMBOL(tty_port_lower_dtr_rts);
  *      NB: May drop and reacquire tty lock when blocking, so tty and tty_port
  *      may have changed state (eg., may have been hung up).
  */
-
 int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
-- 
2.17.1


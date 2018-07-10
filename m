Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F110C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272C120840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Kf5ilJ3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mrt2Lyk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272C120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754673AbeGJA0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:26:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43955 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754613AbeGJA0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:26:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BEB67549;
        Mon,  9 Jul 2018 20:26:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 20:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=49wK7fHc614+eufHf
        tXSiReAIiZBzW/ABTgrRQqFpuE=; b=Kf5ilJ3njI0XTD8q4nDauXA6uxk+MxpFZ
        2y+VY9P35zA9KtW/3jK5DEnvubKm3YogfC1ufGjS6iuYpbWfgr9haY+5hqqW/rEy
        u4rZcJi6g/YfwjjVW5yIQ1YW3lidaUtxuZiEx5T7KCTvamTyS1o/Oz6h61st/E7Z
        C/hDXxnv3fX7ap/KHWiR7zozXaP0YySngzi4E8PmFbX+rMJ7ZPPvl2JzAI71oi8r
        aFmioePujOwAo0xw9vLud8i6WW8SZ23jJDwWFLEDP6cemrWzIHU2nrCIPJ/RmBxC
        PScUVT091D+6qGWZhilx86ZyKBM0lgCbMkI5UJiThQZ/mTSafuoiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=49wK7fHc614+eufHftXSiReAIiZBzW/ABTgrRQqFpuE=; b=Mrt2Lyk5
        RZ5cFX098/IaXP0ql0duytiAC3bxMP3Vdt5y321Klz2C0V2YAmzHpLn+ZLAtu3U6
        DVQRaAxvNetuv0Qh2zxyUisMdjS7qjD6vihjwM9+MqdFhF9VWGgLk0pikTS4nWm2
        /T81SKTMPBPmuTKPv8tRl06cWdpxwmNzWXaDKAbTHMMlFmTOYgBRd7pvEMpojH/W
        ZeXOBGOOF8fchzSfHNWLITk8g54BlUQLZOoMJeh1DQKnk2JJ2k3igqUuBMki2ab1
        VrY5h5769kExUxSMIzn2q5XXYvUife2uokbeLvPugo4xkQR/zcPOs9/BciRU5Px1
        zN7aKwOdmkpleQ==
X-ME-Proxy: <xmx:Gf1DWwTEDVgZUhWH6JR_Y7ZOKQAsksLIbesXP8XYPfijpjYFOgh6LQ>
    <xmx:Gf1DW8Q3PZXukrsiHWepfhkAs1JGKNUBpX0mq3zwWVPhSQSc9Hw-hA>
    <xmx:Gf1DW4r9Su86ipFP47v3VvaIIzCLR4hjh2U8p-MKm5oFC9D_9pZuZQ>
    <xmx:Gf1DW6N7Zo89l8Wv1m8t2HFWac0j2TZmhfDpdyC7f_iU2ErNLPOFQw>
    <xmx:Gf1DW1AfQKEUtQtw4P-O30QBlRpPOITACrG9sxSCzMrgTdwiex9LjQ>
    <xmx:Gf1DW-u5H3ILBa6KWklZtGu8oKovPJ0jmdGiqhku1oShSvMbaYcUKw>
X-ME-Sender: <xms:Gf1DW0r-Am0ZLmyk3TDnyWGOGeNyz5FNaghbr9mARLprzGMD-Na8wA>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91CF010277;
        Mon,  9 Jul 2018 20:26:00 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] vsprintf: Remove incorrect EXPORT_SYMBOL
Date:   Tue, 10 Jul 2018 10:25:18 +1000
Message-Id: <20180710002519.5044-3-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710002519.5044-1-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently boot variable 'debug_boot_weak_hash' was added (by me).  In a
classic case of cargo cult programming the novice developer added a
macro call to EXPORT_SYMBOL().  This is wrong and was pointed out on
LKML.  As pointed out EXPORT_SYMBOL() cannot be used on static
variables.

Remove incorrect usage of macro EXPORT_SYMBOL()

Fixes: bfe80ed3d7c76 ("vsprintf: add command line option debug_boot_weak_hash")
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index cdc2c355dff5..fe834a201f3d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1655,7 +1655,6 @@ static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
 
 /* Make pointers available for printing early in the boot sequence. */
 static int debug_boot_weak_hash __ro_after_init;
-EXPORT_SYMBOL(debug_boot_weak_hash);
 
 static int __init debug_boot_weak_hash_enable(char *str)
 {
-- 
2.17.1


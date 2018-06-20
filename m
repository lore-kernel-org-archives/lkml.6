Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D096C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92C720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="JcX8YndK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXZO7Spb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92C720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeFTEVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:21:07 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43179 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751327AbeFTEVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:21:01 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0790421C8A;
        Wed, 20 Jun 2018 00:21:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 00:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4nti1a0Q8uBjJP8q+
        VZ/JychP8e5B5x42BlssWtnEQw=; b=JcX8YndKJuzXfjhk8qfx5hBsGIomsSWtD
        IKdgm6BHilEV+Z35vvB51U5/rYahMg+jXhJrfgiChi9Os+kJCznPlSh//VnDWjbW
        hN3JH0t2FOIxQuwBlf6maH8I2wyW+ybO12ltDV1kfVwBrzF8vw94OR2cOOkrJPk1
        bVmlwBsOnbvsXm1pHwWNCsgotObmmK3OwGuhNKZ+lYmaUioQnak6ORlAXR6kdLUz
        wM+504Bjf3rsPKJX9Z0jAVSCfTIHX8f8G/E3b9kI+VKJAH2/AElS/Fpfk5zrUg56
        eKjzQps7kOcjUWmcWHCIbfui+3yYx5GGDFviRIfi5YW/eDkdeLXdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=4nti1a0Q8uBjJP8q+VZ/JychP8e5B5x42BlssWtnEQw=; b=pXZO7Spb
        IAg4p2h3R/Z+Dqck3OXQaTOmlAuE6Qio9drswNpN3ZQLsQDYnpf6Xd3G5hGlqKkC
        sk43Ibd2RpiQxB2F2YRyBQToT4+MFgu+Q2qu5++A0lbUAwnXL9VjBh5J1CnZfWij
        7jIAygPDZjHwesk1Ntr/R/ukhgxEZqtgRIp/Etpn0VL0EwvP3ZhPIOz81qthP9rX
        jFt8As3/V56b523ZV9muO86ltou2whPV3TXblPwXJZHB5Z67P79YjdUV70KnGvJK
        7HDYTrn/pApXLraIGZ5LMVPV8NMbl4qLil3lMnCHKhAcvhouwn29DdAz87WNQjvm
        MfLsQOR8CYiWCg==
X-ME-Proxy: <xmx:LNYpW6fsKLvIyMZc9lYZi1yEjtBsFohOgZR85DPsNG3xtcyv8wuPUw>
    <xmx:LNYpW9JKxVqXfqaG5U4UB8h0OuoWOeeoghNPvx_Ry2U79nvU7DEaBA>
    <xmx:LNYpW9dyaZry_-2cfOK8w6A3CnNU7t9A3McaaW2vI7lWrMfGTkyXJw>
    <xmx:LNYpW03C26d25KJY4igECZe9q5LL-JTK_pJoNCDPvx6gjabNLN6J9Q>
    <xmx:LNYpW2jg8H8SectE9TWSWbLVbYo_mird6sMmbqthQ5dc3ENne_1zvg>
    <xmx:LNYpW3jVViQmvfpETlweggnWUk44QS0GF1Vhdos3ODiASOGt1QiSRA>
X-ME-Sender: <xms:LNYpWw1armGs5FQhJEqITTXkWIU6RS4Ol4uL9q_GM7_C6j2qYOYczQ>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id 380F1102D9;
        Wed, 20 Jun 2018 00:20:59 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] random: Fix whitespace pre random-bytes work
Date:   Wed, 20 Jun 2018 14:20:43 +1000
Message-Id: <20180620042046.30806-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620042046.30806-1-me@tobin.cc>
References: <20180620042046.30806-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of whitespace issues around the function
get_random_bytes_arch().  In preparation for patching this function
let's clean them up.

Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..ed679099afba 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1736,7 +1736,7 @@ void get_random_bytes_arch(void *buf, int nbytes)
 
 		if (!arch_get_random_long(&v))
 			break;
-		
+
 		memcpy(p, &v, chunk);
 		p += chunk;
 		nbytes -= chunk;
@@ -1747,7 +1747,6 @@ void get_random_bytes_arch(void *buf, int nbytes)
 }
 EXPORT_SYMBOL(get_random_bytes_arch);
 
-
 /*
  * init_std_data - initialize pool with system data
  *
-- 
2.17.1


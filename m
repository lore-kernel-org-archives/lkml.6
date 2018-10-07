Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E3C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75F12084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B58Klm7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75F12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJHGFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:05:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJHGFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PB6k7aFYCey6dVSzaBAL5mt/HapQUg5RWcJbMA6b2QM=; b=B58Klm7JsteWUL+ydl4da+UKD
        LMvanJ32gRioFEzpCK5DF571MzfwKkrbxUEnXTvrLq+i3Wrek0cfMjr59UDx8oyBUpyTLL2RKJHqh
        4c1t9TeixI3O/9QBtQjsRrZN0yQdwjzBXTLxzNbj8SOlHORYan1TyXFl7IvQhPy6utF9Yron9zYad
        oer0KMzpBsjN4Hyu09dEw4KXxCsVgRM4fDuJaC0SxiGdmcy+lvqcladq2xCqjboqCCoAwI+Vt0prD
        UDjBJ5NHmS/UxbY5au2MEJvpDlAAN82tS+fm4ZDK14pzCa2DPTvctNShJgDUTY/KbnuJH7zvyaqAW
        79E+F/++g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Hyz-0000De-4m; Sun, 07 Oct 2018 22:57:05 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] gpio: fix kernel-doc after devres.c file rename
Message-ID: <ec1afc50-993c-c0d5-00e0-ab111579fca4@infradead.org>
Date:   Sun, 7 Oct 2018 15:57:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix gpio kernel-doc generation after rename of the devres.c file.
Fixes these errors & warning:

Error: Cannot open file ../drivers/gpio/devres.c
Error: Cannot open file ../drivers/gpio/devres.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/gpio/devres.c' failed with return code 2

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
---
 Documentation/driver-api/gpio/index.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20181005.orig/Documentation/driver-api/gpio/index.rst
+++ linux-next-20181005/Documentation/driver-api/gpio/index.rst
@@ -38,7 +38,7 @@ Device tree support
 Device-managed API
 ==================
 
-.. kernel-doc:: drivers/gpio/devres.c
+.. kernel-doc:: drivers/gpio/gpiolib-devres.c
    :export:
 
 sysfs helpers



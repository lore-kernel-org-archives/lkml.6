Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9942CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC972084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfqL9iTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC972084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeKYWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:19:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43252 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKYWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:19:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so12513653plb.10;
        Sun, 25 Nov 2018 03:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aq/59RPq4dxet/glAKtloYkdVb6h1n+jWNdOufUL5x0=;
        b=jfqL9iTGwUBvDtO0RWFPhqXMA0PHZrJBwt6nF2vKl7fKIOc3n8UOZPf+l8uT8XXREY
         gkfwikm2crKbslOYyzc4DOf8e4I93khMmn8u8NMTs44GIbqfwzZPDFggFXWKpyMTvim9
         IrAHLb3fGcBUXMidNlSXwMsbhRODSNo3E75z9koY4QVAqjmCaQgIX+GqA1By9UqhNEE0
         o3ODKqs9tcjGy3cD1QSdZc9LNKRZmbVao0xs6TvEk0WMJGlgz+sINcCpHzzahEEXrLQH
         +pX2KVUKPiZhBpoNbsl7+AU5UUEhaWfsJBtcW5S/2uSvKCpwcIvK+1IMvWwK85eFw45p
         wVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aq/59RPq4dxet/glAKtloYkdVb6h1n+jWNdOufUL5x0=;
        b=MmoIksIz1qEFJZK23sNEY7GET4KiMoUWUi8PiC9OK0w9RazaLEIaWvk4835krykoDF
         AgEr7J12fMbB2v0j+WvMac3r3ZC0yiUCuX/yCcpWd1aOGhG4KfSdnXskz4NDPvZLFbSo
         BAs67EPprujVKqWT1zACJ0Y+QgkG/7mnLJXef6Bg6bG9pAlHvK6aYSgI0nTi6B6Voq85
         cBwZiqerj8N2Ok9Q2Gy67qqjFcm1GXzeqkMeCJoDTYYlqwJG8ehq36tIg1CWnGL2L8JK
         j9xbbmJWETvYQY0FFPiVj1YhR0gNz+RymfEeOpcwpJ5XZUrKs9nZeSpXAKk4D4vdMDyJ
         fb8g==
X-Gm-Message-State: AA+aEWbBWCuicpatdSFzlmJWiL8cO//4mtC4ODXIacGNaVb397BGn37J
        agoeh+vpzz2PnBT384EwzEo=
X-Google-Smtp-Source: AFSGD/UE9JKH/NadNU9hKATTw7t4r8vIlpuVTvEAezqEEoUNDep30SovNEUc2ufLZeMkYhMGsHwetw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr23167294plb.125.1543145347074;
        Sun, 25 Nov 2018 03:29:07 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id h74sm12306779pfd.35.2018.11.25.03.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 03:29:06 -0800 (PST)
Date:   Sun, 25 Nov 2018 16:59:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 07/26] Staging: fbtft: fb_sh1106: Switch to the gpio
 descriptor interface
Message-ID: <efb6414a9e3e04f766188c4e6aee8d125b1cdd2d.1543142440.git.nishadkamdar@gmail.com>
References: <cover.1543142440.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543142440.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the fb_sh1106.c to use GPIO descriptors
rather than numerical gpios.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/fbtft/fb_sh1106.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 00096f8d249a..6f7249493ea3 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 
 #include "fbtft.h"
-- 
2.17.1


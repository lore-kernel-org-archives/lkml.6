Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F77BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374D0218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgIKiO75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbfBOOEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:04:53 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:38361 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390785AbfBOOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:04:53 -0500
Received: by mail-it1-f201.google.com with SMTP id m128so15933590itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B2UCPAyeGzsAun8ufT1y2SdOeNjxf0JE35wur1cP6sE=;
        b=MgIKiO751glFXH2JTQhOP5ddJIXupQzAjk0YsbQ0mggkGH246eZFXAPXK6LHXTDBPX
         IvRstCjKuX9UhQWizXD/rSf/VccaZ4OjgWlyH+auWLMFg7O5ftZa+ePRrGEZPnc11Eib
         9Q+PUvgAP7ueFQUpoXITPRgS6tR3bWxq/hPHtIfW3R10ygXkIFsHvudx+HRpghpFMN7f
         +bPQPCBDKK4RdCARz/6ubIqUpxI/mzd1m1ZlAZfshElP7OtYBQjzaoEcXmSpJ75Q0zPT
         cCWnsFpG1s2Dl9Z0+icuGTTYcgbvdM7ZQC8vqmJstw50Eko9+GXQ43Ezy98Ro6qtyc7P
         y0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B2UCPAyeGzsAun8ufT1y2SdOeNjxf0JE35wur1cP6sE=;
        b=spTP8rldfs8udiihznPf1DVS6KOoFLq7cnLlm+MXINyfl1reIBZ2sGq3jHALzO422M
         e/nsEoNUwJ0EGG1ANwIoJ2ndaouEMBhc7i8f7PBKzm80qgjIqLqlkqVPvTw3YWgOhMBS
         2+3zMPda18Jzs5RGFn8Kc21keSCGxa887DJDy633f3rV2BOvlSoCUKfvGBnyZ9y3KMCt
         5/DuUrWt/T/D3PBw1O1CXY4qQNYoM1r4vO7jRlot3wu97qYQerKnVw3PH1Y1U2pqSyJ+
         7SaV0rm8rtzjXJDVlOnvSVdl+HXTK3/3rZHOOwIRIg0duKZiBQuISWq6+wPW1X7NXD9P
         xd4g==
X-Gm-Message-State: AHQUAuaDZaxST7d5ZsIDZobJM6EZ297Bfc3pK0PNqmdx+YHgPkRwf8Vr
        ME1Oic0o/aUT/O+MdzlEVI0xtJHgIw==
X-Google-Smtp-Source: AHgI3IalNu2l4XkXNkhD7ixYneW4r8EVP9r3us9MXRq9Ko10Au3t6BvlfsmS2c94xqM5AY4JuDgvB4ECrQ==
X-Received: by 2002:a24:dcb:: with SMTP id 194mr5362449itx.25.1550239492346;
 Fri, 15 Feb 2019 06:04:52 -0800 (PST)
Date:   Fri, 15 Feb 2019 15:04:44 +0100
Message-Id: <20190215140444.37060-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [PATCH] MAINTAINERS: fix GTA02 entry and mark as orphan
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nelson Castillo <arhuaco@freaks-unidos.net>,
        Nelson Castillo <nelsoneci@gmail.com>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, openmoko-kernel@lists.openmoko.org,
        Andy Green <andy@warmcat.com>, Ben Dooks <ben-linux@fluff.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The entry for GTA02 never had paths listed; fix that.
commit 9d76295ac608 ("[ARM] GTA02/FreeRunner: Add machine definition"),
which added the entry for GTA02, created two new files named
arch/arm/mach-s3c2442/{include/mach/gta02.h,mach-gta02.c},
which were then renamed in commit dd6f01b5ccba ("ARM: S3C2440: move
mach-s3c2440/* into mach-s3c24xx/") to
arch/arm/mach-s3c24xx/{include/mach/gta02.h,mach-gta02.c}.

Also, the GTA02 maintainer's email address is from a domain that doesn't
have an MX record anymore and appears to have expired. Remove the
maintainer and mark the subsystem as orphan.

Signed-off-by: Jann Horn <jannh@google.com>
---
There's a second email address for Nelson Castillo in git history. I'm
CC-ing that address in case the maintainer merely forgot to update his
MAINTAINERS entry.

 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4ad838..f75b5861d789 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,10 +1882,11 @@ F:	drivers/usb/host/ehci-w90x900.c
 F:	drivers/video/fbdev/nuc900fb.c
 
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
-M:	Nelson Castillo <arhuaco@freaks-unidos.net>
 L:	openmoko-kernel@lists.openmoko.org (subscribers-only)
 W:	http://wiki.openmoko.org/wiki/Neo_FreeRunner
-S:	Supported
+S:	Orphan
+F:	arch/arm/mach-s3c24xx/mach-gta02.c
+F:	arch/arm/mach-s3c24xx/gta02.h
 
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
-- 
2.21.0.rc0.258.g878e2cd30e-goog


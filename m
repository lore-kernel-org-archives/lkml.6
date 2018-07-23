Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B781EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8D2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWb3UJkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE8D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGWWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:42:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42093 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388135AbeGWWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:42:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so764830plo.9;
        Mon, 23 Jul 2018 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=RG9go1qbzNWlPgt1ByJ1dgOs9189IFz+a0PH4YawvEw=;
        b=RWb3UJkYIuaK6TMXaEmipGRlfMroaYv6fFa/J3F3v+UT7oPu2DpdzoUUl4Ja3s99Ep
         wFGaH9WDQHqRJBtuWtWjv9Vn/yVQjkP6HesdlnQkIFvnlQ6HFkjO+mtA7D2bzhI2J0+v
         eHNytdgH/sVO2hhonSzjfFoVjNQlKyHwWTfhIC+ol8auduIpkuG5qEylrvTmAt1DSC+z
         FRf7BejaA6CLm4G4ciZAHZ7zNxBNdYEpWGQjLbH1cG1xcnTqMW/HTc6opuvoiXc8bjtM
         QqdX5AUVg0y4o9D4w8vzsxcXZ0z4Ij8NgQhRr7BbzzIXh9J2XXEAPRQqfvrk4WOC4D5Z
         7UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=RG9go1qbzNWlPgt1ByJ1dgOs9189IFz+a0PH4YawvEw=;
        b=tLfCu56oDguac1/du97EMqNbgDqxeAVoM1bLj9KMW8k5yciqPDB7kopeF3nbsxPzKl
         5Rldm376AUDLdoUoKPVPOBsFmsPOjprFIx4Vv/mxF5NtGYywYorZ6vgh29A95hXKvLWD
         h5Jwe2fus5cauPD6K9/gkzilZ5LSUJeq5rL4T0e0vYrpr4T72JrLiq45JUGVGnu4pDjW
         xNB3yRJW/Dbn8yhpUQ9zMX2Vf/xGtYRzgUZDogv2XIuanngozngLn82pbncgaLdLYibL
         1cs001RJdDT00iqLUszkBvvaKWUfiUFl+zztjylHnjHXN1aq4bEATyNVfrefe3gJFbsI
         nP1A==
X-Gm-Message-State: AOUpUlHRnPgB2Yheuh4gYH/fRuW0C1dTluhPrd2DTuaLSWeMXZyKB5nr
        kM23ik+9D4PDa0nXEQzHo60=
X-Google-Smtp-Source: AAOMgpcF/P8ty6d9NDuiLYyvn25KwmwXAVe8bWVIb0kq2YuKaWvqx1P7F+iHvzuE8KhV2YkxC2ic9A==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr14442177pld.205.1532381976727;
        Mon, 23 Jul 2018 14:39:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p64-v6sm15926952pfa.47.2018.07.23.14.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:39:36 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Miller <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h after generic includes
Date:   Mon, 23 Jul 2018 14:39:33 -0700
Message-Id: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including asm/cacheflush.h first results in the following build error when
trying to build sparc32:allmodconfig.

In file included from arch/sparc/include/asm/page.h:10:0,
                 from arch/sparc/include/asm/string_32.h:13,
                 from arch/sparc/include/asm/string.h:7,
                 from include/linux/string.h:20,
                 from include/linux/bitmap.h:9,
                 from include/linux/cpumask.h:12,
                 from arch/sparc/include/asm/smp_32.h:15,
                 from arch/sparc/include/asm/smp.h:7,
                 from arch/sparc/include/asm/switch_to_32.h:5,
                 from arch/sparc/include/asm/switch_to.h:7,
                 from arch/sparc/include/asm/ptrace.h:120,
                 from arch/sparc/include/asm/thread_info_32.h:19,
                 from arch/sparc/include/asm/thread_info.h:7,
                 from include/linux/thread_info.h:38,
                 from arch/sparc/include/asm/current.h:15,
                 from include/linux/mutex.h:14,
                 from include/linux/notifier.h:14,
                 from include/linux/clk.h:17,
                 from drivers/staging/media/omap4iss/iss_video.c:15:
include/linux/highmem.h: In function 'clear_user_highpage':
include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible
	pointer type

Include generic includes files first to fix the problem.

Fixes: fc96d58c10162 ("[media] v4l: omap4iss: Add support for OMAP4 camera interface - Video devices")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/media/omap4iss/iss_video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index a3a83424a926..16478fe9e3f8 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -11,7 +11,6 @@
  * (at your option) any later version.
  */
 
-#include <asm/cacheflush.h>
 #include <linux/clk.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -24,6 +23,8 @@
 #include <media/v4l2-ioctl.h>
 #include <media/v4l2-mc.h>
 
+#include <asm/cacheflush.h>
+
 #include "iss_video.h"
 #include "iss.h"
 
-- 
2.7.4


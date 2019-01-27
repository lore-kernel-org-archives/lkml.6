Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA8C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0824214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O0ep6hFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA0RGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:06:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53312 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfA0RGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:06:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so11429970wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sma05UWp7WpMYi0Ezyl+f9wPmZwqolw3bx+B9uu1bOo=;
        b=O0ep6hFDtGZdW7O6R6Pc6nz2kWDdePCvJh2bmesVv+V00G8i1BVXa/4ean0nYhizg6
         do62DUFyWqSjlwklYdSqBc9hGGAc9OL2GB+d1pCFkstLgQDu66rK91Nel+VVv24wP1j+
         6/krM6azhVX73UKLBMcoL8rU8qNARUaIULKHwn1U20uVazCa0saxD4WFqjNURXGrIHIw
         3ZCCeHQxMl9vtto7MNkLtZqgUsHWgpHI8dpaDVXTNAx2JPDDM6UxyYFiJ7FhamAZz81j
         fs3CEVZZI+/AUT5Ywp6dBJ5thLnbgrQXBKjBnCe7lLMNazDqIczN0/l3gB2ktkYDSZwU
         iOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sma05UWp7WpMYi0Ezyl+f9wPmZwqolw3bx+B9uu1bOo=;
        b=Csd7bFot3aA0TqC8jOyOxEqu3CDnuQIebj5gZQb6nzU77aPhlvtbN1VnuK6xuU8o3r
         7VRSadcw4TJkg/Nwxjp/OrHJGBePqSHgbX60almP2kAVLNtkolZAXifcNS1cqcMtrWoV
         7j6GnjIGyAgsba9zNqmKKEn9+1T0jGR38H2+gqGQIzGwTWvjh2PbyvjqOvH3VFLqlMnG
         RVQ/LR3LILSvICglLYa563Z14NBRyKSVEsmPur8a7tC5uluwgAsi+pB/7PstWdIBB0VR
         Mh9K9qSXdrTXaAGTD5aHOBc/zmbCs1PvldvBmGcGYVnWlDn8n8YXyd1dC0Ft1VN4F4DZ
         I3kg==
X-Gm-Message-State: AJcUukdwDnFp5hF8Jkd9u41+TCnrz9IxRdWb4TR+8Vspj3y6ZRv4Itza
        b/gNZtmurJWBbOJLCGJcJkUp+qkHYoM3Ig==
X-Google-Smtp-Source: ALg8bN7ujDKVYgBlkY16xTuEnwE4sn+5cgWVIV7qcClRKQecgKUf5bSBA72NjVh7aGcUQELUTglTOA==
X-Received: by 2002:a1c:cc2:: with SMTP id 185mr14500876wmm.1.1548608805837;
        Sun, 27 Jan 2019 09:06:45 -0800 (PST)
Received: from winie.fritz.box (i59F4FF78.versanet.de. [89.244.255.120])
        by smtp.gmail.com with ESMTPSA id h1sm47514893wmb.0.2019.01.27.09.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 09:06:44 -0800 (PST)
From:   Florian La Roche <florian.laroche@googlemail.com>
X-Google-Original-From: Florian La Roche <Florian.LaRoche@googlemail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@gmail.com>
Subject: [PATCH 1/1] int_sqrt() adjustments
Date:   Sun, 27 Jan 2019 18:06:18 +0100
Message-Id: <20190127170618.22800-1-Florian.LaRoche@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian La Roche <Florian.LaRoche@gmail.com>

int_sqrt() and int_sqrt64():
Add __attribute_const__ and adjust to use (signed) int for the right param of "<<".

Signed-off-by: Florian La Roche <Florian.LaRoche@gmail.com>
---
 include/linux/kernel.h | 4 ++--
 lib/int_sqrt.c         | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..df03a3cca309 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -513,10 +513,10 @@ extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int func_ptr_is_kernel_text(void *ptr);
 
-unsigned long int_sqrt(unsigned long);
+__attribute_const__ unsigned long int_sqrt(unsigned long);
 
 #if BITS_PER_LONG < 64
-u32 int_sqrt64(u64 x);
+__attribute_const__ u32 int_sqrt64(u64 x);
 #else
 static inline u32 int_sqrt64(u64 x)
 {
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 30e0f9770f88..75d930dd1802 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -16,14 +16,14 @@
  *
  * Computes: floor(sqrt(x))
  */
-unsigned long int_sqrt(unsigned long x)
+__attribute_const__ unsigned long int_sqrt(unsigned long x)
 {
 	unsigned long b, m, y = 0;
 
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (__fls(x) & ~1UL);
+	m = 1UL << ((int)__fls(x) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -45,14 +45,14 @@ EXPORT_SYMBOL(int_sqrt);
  * is expected.
  * @x: 64bit integer of which to calculate the sqrt
  */
-u32 int_sqrt64(u64 x)
+__attribute_const__ u32 int_sqrt64(u64 x)
 {
 	u64 b, m, y = 0;
 
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.17.1


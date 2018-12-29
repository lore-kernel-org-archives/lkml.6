Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F347FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C119A2145D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 18:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZhZPNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeL2SfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 13:35:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40373 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeL2SfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 13:35:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so11289247pgp.7;
        Sat, 29 Dec 2018 10:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lFf9VNRLqoV0QJvVLgw9rhluSBUqDboBgzZBJJTvGfo=;
        b=eyZhZPNW2vfoQma9xNA7HGOklOKmVrlg4dGhbuukNYvxlJyc4WLOFn5D0tx3BxrFWl
         fJZzxleNEz2qQgJSzJiN5psq7IMmlRy/D6cfmAJpSEGkZ9KUlu/2hjPpF/YU6//nHxaK
         qZqh+fdzyBih9pNqcSC/R30D+CsbBvz7EQFziErDo/4LeG8h4ha2I+6rF/ygzCUSRipg
         fM1iYuL3SWv7uNp2i7+BlFLhXUC0x5DBLNsLmb9NgWIwX5bhWJ26MfOTBAblAFUYRzxJ
         Vk4YwW9ivjxdbttVXGkoJutISRM4bHFioMFDmhKooE7u74lEubChok3rpOK+/I8X08F5
         AuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lFf9VNRLqoV0QJvVLgw9rhluSBUqDboBgzZBJJTvGfo=;
        b=MRrkiLXxzLbg/HAnh/Qp88qYR8j8/z3WF2DiSoS4PsVi6pmy6CIUuv0+tvF71ld24E
         aMKpWUZdFOdviudzFsR8y0+fxHi3pA2JYNfhBFPH1pjGbji9habMVIjwMlqzjgwUK0sh
         ph3LQsswBI1eu10oTeKY6xt7QsiXdMyS1oCR++a0zm+D2FDgN7KCEWh2LIT3PJjSBEuq
         GFjHVwabrF8K1qI2Psj3HVLBpbU9soWQLJtp+TszAJ+l/ANhu+DCmTCPoF4wNruPfV6o
         7BNIBK5ZlHpxTZgQAUa8pRZDpxa9W7aXPCL2Bc8VpaUHwVkiU4YTKkn0fhLi0UFE1XSh
         kTIg==
X-Gm-Message-State: AJcUukfLFEoAK5ryqOeALOazYyxlK4r2T445w68hagVn10my5o4QMdGb
        mmi96s6LqysoLqSRB/Pf0A0=
X-Google-Smtp-Source: ALg8bN4kjOAaxWfHNhxzVR2H8acgnoMpZiUUiAWgI+8hU/W0/FO3GohObGNhXtXj38bkQGzJa2uAoA==
X-Received: by 2002:a63:413:: with SMTP id 19mr2422685pge.7.1546108519250;
        Sat, 29 Dec 2018 10:35:19 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b7sm107702617pga.39.2018.12.29.10.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 10:35:18 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, davem@davemloft.net, y2038@lists.linaro.org
Subject: [PATCH] input_event: Provide override for sparc64
Date:   Sat, 29 Dec 2018 10:35:14 -0800
Message-Id: <20181229183514.24644-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usec part of the timeval is defined as
__kernel_suseconds_t	tv_usec; /* microseconds */

Arnd noticed that sparc64 is the only architecture
that defines __kernel_suseconds_t as int rather than long.

This breaks the current y2038 fix for kernel as we only
access and define the timeval struct for non-kernel use cases.
But, this was hidden by an another typo in the use of __KERNEL__
qualifier.

Fix the typo, and provide an override for sparc64.

Fixes: 152194fe9c3f ("Input: extend usable life of event timestamps to 2106 on 32 bit systems")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 include/uapi/linux/input.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index fb78f6f500f3..ffab958bc512 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -26,13 +26,17 @@
  */
 
 struct input_event {
-#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL)
+#if (__BITS_PER_LONG != 32 || !defined(__USE_TIME_BITS64)) && !defined(__KERNEL__)
 	struct timeval time;
 #define input_event_sec time.tv_sec
 #define input_event_usec time.tv_usec
 #else
 	__kernel_ulong_t __sec;
+#ifdef CONFIG_SPARC64
+	unsigned int __usec;
+#else
 	__kernel_ulong_t __usec;
+#endif
 #define input_event_sec  __sec
 #define input_event_usec __usec
 #endif
-- 
2.17.1


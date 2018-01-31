Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932263AbeAaPdz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:33:55 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33097 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeAaPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:33:43 -0500
X-Google-Smtp-Source: AH8x226Ajompsu0OYQsuUOXgN2+H2pqIMojeeDnVpjvuqcxFYcKiCYzOtIN/a2TKSvQtfbt/GfomLg==
From: Antony Pavlov <antonynpavlov@gmail.com>
To: linux-mips@linux-mips.org
Cc: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH v3 1/2] Add notrace to lib/ucmpdi2.c
Date: Wed, 31 Jan 2018 18:33:36 +0300
Message-Id: <20180131153337.29021-2-antonynpavlov@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131153337.29021-1-antonynpavlov@gmail.com>
References: <20180131153337.29021-1-antonynpavlov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

As part of the MIPS conversion to use the generic GCC library routines,
Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
patch rectifies the problem.

CC: Matt Redfearn <matt.redfearn@mips.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Matt Redfearn <amtt.redfearn@mips.com>
---
 lib/ucmpdi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 25ca2d4c1e19..597998169a96 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/libgcc.h>
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.15.1

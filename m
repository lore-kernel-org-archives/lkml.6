Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA6C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84E2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 15:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UsdO/pB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfASPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 10:15:20 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45003 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfASPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 10:15:19 -0500
Received: by mail-wr1-f54.google.com with SMTP id z5so18410595wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=em7x2aUXgTsSXTzo9fb8L9b4+qAvoMSIWXCt28H3BxA=;
        b=UsdO/pB2qcbgl8o8bvQi8/JMMvzlpIS6VXjfxh31G0dGly/na1y8UnMxe2caK+kj7t
         a6aRbI3fmTY/NVrKOuoTyVl889Br67Gcp3nBTsbK1y5K6rA9GSH0A/gAI432T/wks+O9
         fCk1eTbuRtWStuOWXDjLsJPNKBJ9zr/66/Ij4ak0KN8BuqwsgIgWzOJ2DGB9l9blrd3Z
         1GstuK3VHdoADfe5ya5CAQAIfm4Jl4rFLZTVIXAiOS0CW1iXHQXk7gjtn5uaZcqgXNUj
         MDCKwLumptL9nR0Z1Y0M5K3CmFLTqr9/p+u9/fnKh1/vqi+zsT1czGX+5kk7sAkNnKtO
         l9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=em7x2aUXgTsSXTzo9fb8L9b4+qAvoMSIWXCt28H3BxA=;
        b=o0c7gQvM756Ak8svVklJoJchwdoRlu4OTvRnPHRWCFbiHGSb9kQkPAYOOXDrRMqQYM
         DpcThmsHxg3V4PLX+PYvLZyoiHJxiQmpEZAEgTVD0OrhZoEBBzFU//V6oMhT1tkqOA0u
         ub3XhIGclvYlivURbdlS+GWTeK8qNcD5hnf/wIcnkm84ha1tYwnenRsS1M/8yHVvpalz
         9zuvDLCXSulrpG3/SLOXx9vZeiUGqHvXg+zqSZFEwrdt/0lDGTJ5O4Kt+JpV98g1yEyK
         Uk7QMt0VNXT05Eret+Z5uSTc5Xx0ZFWF2OoP0ZEmzivck6iOu1Q1yVaCSAg/WRTI6a9e
         1h1w==
X-Gm-Message-State: AJcUukeQFKBAarwzkF3o8P0X7UXz5+KjFEG5jXcDGurlvdKHzKgPL5U9
        6azQAwKJGSORI7pOzJob3XDnwA6Colg=
X-Google-Smtp-Source: ALg8bN66VyhlPAJQTH3A59GV9XiEQc957HWp6efdFgprN4lOZAbhRRQQhtKbRZWH6RbF1c2+XigReg==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr7109407wrs.86.1547910917636;
        Sat, 19 Jan 2019 07:15:17 -0800 (PST)
Received: from winie.fritz.box (i59F4D63E.versanet.de. [89.244.214.62])
        by smtp.gmail.com with ESMTPSA id s132sm26556746wmf.28.2019.01.19.07.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 07:15:16 -0800 (PST)
From:   Florian La Roche <florian.laroche@googlemail.com>
X-Google-Original-From: Florian La Roche <Florian.LaRoche@googlemail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Florian La Roche <Florian.LaRoche@googlemail.com>
Subject: fix int_sqrt() for very large numbers
Date:   Sat, 19 Jan 2019 16:14:50 +0100
Message-Id: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an input number x for int_sqrt() has the highest bit set, then
__ffs(x) is 64. (1UL << 64) is an overflow and breaks the algorithm.

Just subtracting 1 is an even better guess for the initial
value of m and that's what also used to be done in earlier
versions of this code.

best regards,

Florian La Roche

Signed-off-by: Florian La Roche <Florian.LaRoche@googlemail.com>
---
 lib/int_sqrt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 14436f4ca6bd..ea00e84dc272 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -23,7 +23,7 @@ unsigned long int_sqrt(unsigned long x)
 	if (x <= 1)
 		return x;
 
-	m = 1UL << (__fls(x) & ~1UL);
+	m = 1UL << ((__fls(x) - 1) & ~1UL);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
@@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
 	if (x <= ULONG_MAX)
 		return int_sqrt((unsigned long) x);
 
-	m = 1ULL << (fls64(x) & ~1ULL);
+	m = 1ULL << ((fls64(x) - 1) & ~1ULL);
 	while (m != 0) {
 		b = y + m;
 		y >>= 1;
-- 
2.17.1


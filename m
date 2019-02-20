Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2221C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A3F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K769gt+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBTIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44279 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfBTIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id g2so16881004lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=23+V50N6WAn/6uQttan8JvUAP338C9/jI8+NG3yi1Us=;
        b=K769gt+oYF4pZZc7mr61J1c6tumHP65tnvF2QGrNKqlnSvuXGB36KtOzD6RzIU0GkN
         IXZmM1s/lXZ3tisHJBa5V5nTalWncNKDBGKtKViYCgTWJ/BSgwF1q+5YSNRKBfdFNgWn
         HKBqXbGWY9BYmmxk6uhUMSzHYFW3gmQUZUBTW/eNQEOd6hzmdHcEYtaYZZvEwYAABnT2
         +eXPYvjEaP6AL47g/AOF8TKNgX3SdNomeuvNmpc/lq9+OBzksMJzNeHnSERG5c4NCnyK
         CvkUegDa1Hwk27u/MQBqbJqbwM3wLW0cpBl/0NeS+2VOT7S41lkk/bTUWAvpvb+BoEfn
         bHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=23+V50N6WAn/6uQttan8JvUAP338C9/jI8+NG3yi1Us=;
        b=uS4Uh7Q4CwyQgP2XTAz2O5vARLOd/cgAsWM7+qT8Ao5nIGDt7DO/CZ7sk0EIIM1IOs
         AGSudrDa+Q4M2LU+yCzyFxRC15lmnBRCU6K4qWonp2GDb+oNYhDZcqH7nWe/DthytvTc
         HmsTEHZtbToY5PJ//nCRFdZ/ms98nYW3D5/oSw8XERupUWKDn+fARN5uD14atfHW6eOc
         SvAXAMc98ih7QLRG9CyQWIiCb49Imu0/cT0Y2MpfWHSBJT2BrYHefeSpLEPThw8RBVP5
         j/odzyibNLIDd2SQTzgy4Y05Aw5PsFDSxhf04cmUQOy6mbCnEz+RY8gSixVNe1rarBFr
         eLDQ==
X-Gm-Message-State: AHQUAuZJqAhwzIaubvp20jJ+kslydMA7qP0GIzZmgEGjSQcjQSASAbBi
        daIaYBrQKlbK8/0VfAPKm4Q=
X-Google-Smtp-Source: AHgI3IZXXPn/L8GVlcBuCV2fYc29lC0n5QuJP0vqc/eldjERcC9gZ3eaN4CHkDCO/oKUidD5YfCCyA==
X-Received: by 2002:a19:5504:: with SMTP id n4mr20280768lfe.43.1550651842316;
        Wed, 20 Feb 2019 00:37:22 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id l16sm4971302lfh.58.2019.02.20.00.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/6] lib/test_bitmap: add testcases for bitmap_parselist
Date:   Wed, 20 Feb 2019 11:37:04 +0300
Message-Id: <20190220083705.14050-6-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests for non-number character, empty regions, integer overflow.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index b06e0fd3811b..709424a788ee 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -224,7 +224,8 @@ static const unsigned long exp[] __initconst = {
 	BITMAP_FROM_U64(0xffffffff),
 	BITMAP_FROM_U64(0xfffffffe),
 	BITMAP_FROM_U64(0x3333333311111111ULL),
-	BITMAP_FROM_U64(0xffffffff77777777ULL)
+	BITMAP_FROM_U64(0xffffffff77777777ULL),
+	BITMAP_FROM_U64(0),
 };
 
 static const unsigned long exp2[] __initconst = {
@@ -247,19 +248,34 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "1-31:4/4",			&exp[9 * step], 32, 0},
 	{0, "0-31:1/4,32-63:2/4",	&exp[10 * step], 64, 0},
 	{0, "0-31:3/4,32-63:4/4",	&exp[11 * step], 64, 0},
+	{0, "  ,,  0-31:3/4  ,, 32-63:4/4  ,,  ",	&exp[11 * step], 64, 0},
 
 	{0, "0-31:1/4,32-63:2/4,64-95:3/4,96-127:4/4",	exp2, 128, 0},
 
 	{0, "0-2047:128/256", NULL, 2048, PARSE_TIME},
 
+	{0, "",				&exp[12], 8, 0},
+	{0, "\n",			&exp[12], 8, 0},
+	{0, ",,  ,,  , ,  ,",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   ",		&exp[12], 8, 0},
+	{0, " ,  ,,  , ,   \n",		&exp[12], 8, 0},
+
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
 	{-EINVAL, "10-1", NULL, 8, 0},
 	{-EINVAL, "0-31:", NULL, 8, 0},
 	{-EINVAL, "0-31:0", NULL, 8, 0},
+	{-EINVAL, "0-31:0/", NULL, 8, 0},
 	{-EINVAL, "0-31:0/0", NULL, 8, 0},
 	{-EINVAL, "0-31:1/0", NULL, 8, 0},
 	{-EINVAL, "0-31:10/1", NULL, 8, 0},
+	{-EOVERFLOW, "0-98765432123456789:10/1", NULL, 8, 0},
+
+	{-EINVAL, "a-31", NULL, 8, 0},
+	{-EINVAL, "0-a1", NULL, 8, 0},
+	{-EINVAL, "a-31:10/1", NULL, 8, 0},
+	{-EINVAL, "0-31:a/1", NULL, 8, 0},
+	{-EINVAL, "0-\n", NULL, 8, 0},
 };
 
 static void __init test_bitmap_parselist(void)
-- 
2.17.1


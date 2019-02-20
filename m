Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE32C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174820685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oupRNNI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfBTIh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:37:26 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBTIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:37:22 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so16648725lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieZaSsrV/WeKWZta4n3OTgkHAop3JCEPGBBBuAwt6D4=;
        b=oupRNNI7IYOC0noJTA7Rop3i/ZKkB2Y83RMJ9NIFj3wgBAxKrnjoVJ6GVbs3cknTHD
         X/ceeZfeBWXfpRjiQafO5LgrNRdluOxbcGahc2V/1KCO/f2XMnHOs9cwkCYpWvMH+5sr
         FjXVetWiV3q3xGYTAg4OvkjNWCW7mXTrwWVsSIMODBwp9AixsllEYbjlQr80Md1UoBqV
         gMUP9X84HRRSBIKfSfjsCIBpOj7qaJUTyYgMMJ6kjVtfzO5lMmQXKRRhhkNtDzYOX4Mf
         M2J8ZmJB5GvmcJk7F34yiNO1pjKeLATn0nB/af31+GEqj4RFtixieFBfcGq7bYfVWshx
         pDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieZaSsrV/WeKWZta4n3OTgkHAop3JCEPGBBBuAwt6D4=;
        b=TS85Y7xaYokMXYc2MdPgptaAcpyAPbBsbEGlk6mR64wJzmARgE6Qe5dQ5lEuj2Uw8m
         3WUXBHdYF8fnlLGj88vUlhbkIKvc4Givsnud8/dmY64gbCEH/4czn1Gnjtc8yKu5UbRU
         wP+FFH/LnYjY/I/uvQng5Y1eIIoN0P4J9VHrVG4jOCNqO7T28ScIep8O32n9B0yhF7Xc
         icjRLQwhPIUX+wFrs8vRsGiaOl7A4kX9+znkPt29oIEv8OkU3P+61JBl6N6PVB/2OFqp
         D2VLX8SsFAYkMPm0ZrfFAOgyZYrxQeMMEkkOM50u1Nv+XeaqUFO+cD9AFAwN7VPXvJFf
         Oz3g==
X-Gm-Message-State: AHQUAuZ1BgHfdyCSU9vE3+PjNzIF5cOrLsjdFEwJkW+Ak1Xu1AXFNvx6
        MzVSPF60O/qgovmqNJSXxLU=
X-Google-Smtp-Source: AHgI3IZd+1/HcpOoJ7WyaW0S4Nrh1Rn+v6XmXOZUK0oLU74VYlHYAvkaW9SIba0kz+U61SGzOYHf/A==
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr10581597ljg.153.1550651839991;
        Wed, 20 Feb 2019 00:37:19 -0800 (PST)
Received: from localhost ([188.162.52.148])
        by smtp.gmail.com with ESMTPSA id l20sm3016785ljb.24.2019.02.20.00.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:37:19 -0800 (PST)
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
Subject: [PATCH 4/6] lib/test_bitmap: switch test_bitmap_parselist to ktime_get()
Date:   Wed, 20 Feb 2019 11:37:03 +0300
Message-Id: <20190220083705.14050-5-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220083705.14050-1-ynorov@marvell.com>
References: <20190220083705.14050-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap_parselist currently uses get_cycles which is not
implemented on some platforms, so use ktime_get() instead.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/test_bitmap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6cd7d0740005..b06e0fd3811b 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -266,15 +266,15 @@ static void __init test_bitmap_parselist(void)
 {
 	int i;
 	int err;
-	cycles_t cycles;
+	ktime_t time;
 	DECLARE_BITMAP(bmap, 2048);
 
 	for (i = 0; i < ARRAY_SIZE(parselist_tests); i++) {
 #define ptest parselist_tests[i]
 
-		cycles = get_cycles();
+		time = ktime_get();
 		err = bitmap_parselist(ptest.in, bmap, ptest.nbits);
-		cycles = get_cycles() - cycles;
+		time = ktime_get() - time;
 
 		if (err != ptest.errno) {
 			pr_err("test %d: input is %s, errno is %d, expected %d\n",
@@ -291,8 +291,7 @@ static void __init test_bitmap_parselist(void)
 
 		if (ptest.flags & PARSE_TIME)
 			pr_err("test %d: input is '%s' OK, Time: %llu\n",
-					i, ptest.in,
-					(unsigned long long)cycles);
+					i, ptest.in, time);
 	}
 }
 
-- 
2.17.1


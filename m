Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F674ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDA72083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 05:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv4NLy4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDA72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeIOLFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 07:05:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36052 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeIOLFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 07:05:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id j192-v6so3992626wmj.1;
        Fri, 14 Sep 2018 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yb8M0w3sWCQ3bm/1psrk9hxQUPInvI5JzpjF9Fyqpf4=;
        b=iv4NLy4lmqxxQQlDjR7ibo+oWgRNRauXQEhnYMnolYnoEPL0A65iOzFGXZRbRPJ9Ja
         xdnPCd66hLtr+BDmzCRzNrDixdxa9l7J+yFriCqAIuyLAtfhLpbjusI7h4ucuP2utoco
         YyLJAh7LgGytLuAYHNgJmDuvgdwHvfBehSNZq1FAErCfV8OdXP3o6ChCemPZWh2g/afB
         h1Ddn3SgDtNnl241GSKBmuksRcEUJUDaYhnQvjZUQ5ZO0cIBJYdz91+vPRYkq5ij3sq8
         /McHxYfkql654jnlKRgjGax0envyLw9j629I/Mbhi+1S7IEo6pmn+b/+VcBA7YmkDaQp
         biyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yb8M0w3sWCQ3bm/1psrk9hxQUPInvI5JzpjF9Fyqpf4=;
        b=YKW6hCcxwoWcRZfCSq3l9SpEmexylIPX0NGvP3mFf51YWfu/7Ln00b2htDNyRzh7yt
         ybVyZ9rNc0JwI858DWBSTWrE42mq/zaaLHd7LWWpNMgyGl1apWCkcaiOfxtQMW1ZFYB5
         O4M5BFh6YU2Bq1RdRjFDUMQp73UlqmRYBqSYYYml0hAtt92ii233VgKVpggTW3KPCH+a
         TmE7M1mIsaJ1FJuM1QuEdeLjWxbqAFaaNRwpVTUbB6X3T/iJ2Gx06Go/iH77hZ72ofoH
         /fe2MdtgheqQecZjr36Nf7+yDryM2tcozyDItWi0ezLGdPdPFW2RD7h9LC7DlPnrsf72
         hzsQ==
X-Gm-Message-State: APzg51AZC9Szgx8dmgfa4DqPRiScefi3zdiFN6JFUpY6aNn/B4tZqRUb
        wOOXzCDInRsQpZdFoniZLdE=
X-Google-Smtp-Source: ANB0VdbGezeTYGDjM00me4V3nXvoAneenuxV48lXz3VGTwJbfBtAXwMVWRBzJPCqMHGr7xC9DxEqOw==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr4856745wmf.43.1536990465672;
        Fri, 14 Sep 2018 22:47:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6593948wrs.85.2018.09.14.22.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 22:47:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] [media] dib7000p: Remove dead code
Date:   Fri, 14 Sep 2018 22:47:39 -0700
Message-Id: <20180915054739.14117-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that 'interleaving' is assigned to itself in this function.

drivers/media/dvb-frontends/dib7000p.c:1874:15: warning: explicitly
assigning value of variable of type 'int' to itself [-Wself-assign]
        interleaving = interleaving;
        ~~~~~~~~~~~~ ^ ~~~~~~~~~~~~
1 warning generated.

It's correct. Just removing the self-assignment would sufficiently hide
the warning but all of this code is dead because 'tmp' is zero due to
being multiplied by zero. This doesn't appear to be an issue with
dib8000, which this code was copied from in commit 041ad449683b
("[media] dib7000p: Add DVBv5 stats support").

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/media/dvb-frontends/dib7000p.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 58387860b62d..25843658fc68 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -1800,9 +1800,8 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
 {
 	struct dtv_frontend_properties *c = &demod->dtv_property_cache;
 	u64 time_us, tmp64;
-	u32 tmp, denom;
-	int guard, rate_num, rate_denum = 1, bits_per_symbol;
-	int interleaving = 0, fft_div;
+	u32 denom;
+	int guard, rate_num, rate_denum = 1, bits_per_symbol, fft_div;
 
 	switch (c->guard_interval) {
 	case GUARD_INTERVAL_1_4:
@@ -1871,8 +1870,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
 		break;
 	}
 
-	interleaving = interleaving;
-
 	denom = bits_per_symbol * rate_num * fft_div * 384;
 
 	/* If calculus gets wrong, wait for 1s for the next stats */
@@ -1887,9 +1884,6 @@ static u32 dib7000p_get_time_us(struct dvb_frontend *demod)
 	time_us += denom / 2;
 	do_div(time_us, denom);
 
-	tmp = 1008 * 96 * interleaving;
-	time_us += tmp + tmp / guard;
-
 	return time_us;
 }
 
-- 
2.18.0


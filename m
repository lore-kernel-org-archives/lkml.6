Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2858053-1518872716-2-8571935571182655814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518872715; b=wZk54pajgJjZ2VuOQrOMwZMKzxyC0/rSZ3YEJLU0phhq3M1
    By7bAvmWfOTnC37hvD5W/gEEkvzEno0rph749S4Ii7GF/jHBYiNQtna5vM2HRV4P
    2i+Tqiwc8xbDmH+Wp8FicK1xbd54ex2Q5NhOUhknrX/aNljuzpVwOwpusjLWDEf0
    QbZmiNOVp/lSf3dUsUNL9otakT1MoWspd05jjeqstUktPmDr8IBADXkvpCsai4J6
    lW2FqsYQdr/Wiurp8EykegzfcUHNsvGlA1BmIcFvSLlWWt23rx6JWxi4VUN/XLuY
    2fylQFOMvhX6ttsT87tYKf1HsESuU/BBwh6uWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518872715; bh=77/PUXfXM2uJGYcgs++kIH35IN
    Ztnir3wpyIdA5RxB0=; b=MmFImV362sBoMzTXyZLbPuLnpvxNiLNZw5JyUmrpYl
    4VxRogeNjqgGet0rX60b7PM5ESYCTQ5e9M9AHI91wyB0barzl7c4D7YNej7dhssn
    34zZKKwtscGoVoI/htR1Rwrho2gOqLo8b+NAJXxNr3bk6b1J/o2uM4SFz3LjzA0P
    lwktfWG7MzyWNbc2qcprozfmhTA0hCQH8ZX6hhfBoxPxf5ezb/8tAmoiCECSf2BV
    j0CuU36fvu/Ve31DAR56Ows0tUSK5EXMubWJ4ax4+A5kYYIlmgpzUVsapz3BgUbh
    wyK+jjhuCglBdiAL4xbDdMh7fSBEkYDsKgh2xc9OSa4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeBQNFN (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:05:13 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:45682 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbeBQNFN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 17 Feb 2018 08:05:13 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Rossak <embed3d@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
Date: Sat, 17 Feb 2018 21:05:04 +0800
Message-Id: <20180217130504.8668-1-wens@csie.org>
X-Mailer: git-send-email 2.16.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When support for the A31/A31s CCU was first added, the clock ops for
the CLK_OUT_* clocks was set to the wrong type. The clocks are MP-type,
but the ops was set for div (M) clocks. This went unnoticed until now.
This was because while they are different clocks, their data structures
aligned in a way that ccu_div_ops would access the second ccu_div_internal
and ccu_mux_internal structures, which were valid, if not incorrect.

Furthermore, the use of these CLK_OUT_* was for feeding a precise 32.768
kHz clock signal to the WiFi chip. This was achievable by using the parent
with the same clock rate and no divider. So the incorrect divider setting
did not affect this usage.

Commit 946797aa3f08 ("clk: sunxi-ng: Support fixed post-dividers on MP
style clocks") added a new field to the ccu_mp structure, which broke
the aforementioned alignment. Now the system crashes as div_ops tries
to look up a nonexistent table.

Reported-by: Philipp Rossak <embed3d@gmail.com>
Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Philipp, can you give this a test and report if this fixes thing?
I don't have any A31/A31s boards online to test this.

---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 72b16ed1012b..3b97f60540ad 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -762,7 +762,7 @@ static struct ccu_mp out_a_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-a",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -783,7 +783,7 @@ static struct ccu_mp out_b_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-b",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
@@ -804,7 +804,7 @@ static struct ccu_mp out_c_clk = {
 		.features	= CCU_FEATURE_FIXED_PREDIV,
 		.hw.init	= CLK_HW_INIT_PARENTS("out-c",
 						      clk_out_parents,
-						      &ccu_div_ops,
+						      &ccu_mp_ops,
 						      0),
 	},
 };
-- 
2.16.1

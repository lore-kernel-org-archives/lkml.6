Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0906ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A3D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/uvFBvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A3D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJSDQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:16:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39322 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSDQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:16:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id y144-v6so1406536wmd.4;
        Thu, 18 Oct 2018 12:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZXQeUL2Phm8+NeAfrMgtacBVMU0b1IlXEufV7dqh/4=;
        b=Z/uvFBvu1iVOuUAxd0GUyXadmZWY5o5Jo+djtbVOdGlOH69RW4jKg1KSjxxa1o1NGQ
         LX8AlQSLikK/Pi9N3qc0iArW1a70+hjAyeLC2stWCpKe+SBcpF33fGzJDVlxsfL/o1kk
         JY5zc0RLBgnXlnbPg+nuzVflHe+lCdafFLO6NqXTnvrN+d1oMMbEewd33ry0F3sTdfLE
         E3IB+gSN5DB7ZCdPwgeEcFKVCGd8dngOrzRk5tRkv+cguuAbp0RjSphTjwRjvrYL9vrR
         w9T1uKo0AGLtcn+OsG7vJQgVSl2mJuoID6+CQnXYZrhfGHybUzJ93gA4YrlBUlEPLd0F
         wtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZXQeUL2Phm8+NeAfrMgtacBVMU0b1IlXEufV7dqh/4=;
        b=o2gTHY9CwwpZsyxbzOnjinvosbmEKaqFd/Xy6Nu+KPrw3Gleb6ykFoN2s345NURDZa
         lzP59Li0Xjg5WS5+plD+3TVqjAvCog2EWbh++/uD0RP4pU0ZvfMRiuV0IkBhYVxl0Hfi
         dHU/y7aEnHHLmvTJYSJqGK2KcH9Q64dFTac6wElHarq6a/toZkGiTZ9E7f/LiRLCr/Mp
         DVA4RD78fV5h13L0ZZRwuBk/jJYnmEIl/GuPDeFaqNFLNxZoAkMNqqUg3W5dE9Gpnsnw
         1KnPBO3H5vxwAv5s1/spMTZD5fFs23+RfGXuP4M5jCeIqjro6tCnX/qh3orMvX3ecSUl
         n80Q==
X-Gm-Message-State: ABuFfohqvLImB1ua07NhfwUBSfok06pLD4qaz0iH6yXi6HCgUiKwAqa6
        z7TT52nqA8W6CH+URIMfSVU=
X-Google-Smtp-Source: ACcGV61HKv6oEGdYP6uObias8Ihn/NuapsF4bBXczcyZ/cblIDrMN7u1kXEVkQBuG/HeYyJpyThefQ==
X-Received: by 2002:a1c:5801:: with SMTP id m1-v6mr1616439wmb.118.1539890044130;
        Thu, 18 Oct 2018 12:14:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 5-v6sm541916wra.48.2018.10.18.12.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 12:14:03 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] clk: s2mps11: Add used attribute to s2mps11_dt_match
Date:   Thu, 18 Oct 2018 12:13:40 -0700
Message-Id: <20181018191340.30440-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns after commit 8985167ecf57 ("clk: s2mps11: Fix matching when
built as module and DT node contains compatible"):

drivers/clk/clk-s2mps11.c:242:34: warning: variable 's2mps11_dt_match'
is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct of_device_id s2mps11_dt_match[] = {
                                 ^
1 warning generated.

This warning happens when a variable is used in some construct that
doesn't require a reference to that variable to be emitted in the symbol
table; in this case, it's MODULE_DEVICE_TABLE, which only needs to hold
the data of the variable, not the variable itself.

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_dt_match
00000078 000003d4 R __mod_of__s2mps11_dt_match_device_table

Normally, with device ID table variables, it means that the variable
just needs to be tied to the device declaration at the bottom of the
file, like s2mps11_clk_id:

$ nm -S drivers/clk/clk-s2mps11.o | rg s2mps11_clk_id
00000000 00000078 R __mod_platform__s2mps11_clk_id_device_table
00000000 00000078 r s2mps11_clk_id

However, because the comment above this deliberately doesn't want this
variable added to .of_match_table, we need to mark s2mps11_dt_match as
__used to silence this warning. This makes it clear to Clang that the
variable is used for something, even if a reference to it isn't being
emitted.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/clk-s2mps11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 9c2e6be392e3..5b419b82f7ca 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -239,7 +239,7 @@ MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
  * This requires of_device_id table.  In the same time this will not change the
  * actual *device* matching so do not add .of_match_table.
  */
-static const struct of_device_id s2mps11_dt_match[] = {
+static const struct of_device_id s2mps11_dt_match[] __used = {
 	{
 		.compatible = "samsung,s2mps11-clk",
 		.data = (void *)S2MPS11X,
-- 
2.19.1


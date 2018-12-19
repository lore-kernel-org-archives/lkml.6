Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A38C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B09B217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 05:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw6y9aRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeLSF76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 00:59:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36484 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbeLSF75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 00:59:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so8967884pgm.3;
        Tue, 18 Dec 2018 21:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBdxhU3bmO+dc8jT9cagGtozla6BnpIu8lRuspjGDLo=;
        b=lw6y9aRwNHeVyVhBtPl4Q/ZvcFzayuZ+SPf1G0rcQbqTjiDUbGrdwkKBTIam8o4nIx
         bv0xEV6UJIWCO9+1+pwkvA5OOfreQ6BPRua4uTYhrI6tfGxZYt9pBnfAPtBEG8jeMzDc
         KCnZ9wyOKgFZS8XfCWiu2P+sqoFCZSU9c0hoqFET+vsMDCE7OzErFEImBQBkMIq699Bn
         D6/zq9Lfz+IIFbOaxOI2DkKy84NyFmszGrJ6qWuWoRhHeVRMwBfkhqlo81kMNdMGNCpF
         pXzhRw5TSZ3FtTJqVawWj9ug8VFi+mDFrbwC4bcLhzlhXrJTKTfnN74NOx9Ln2WOh/Fc
         hcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBdxhU3bmO+dc8jT9cagGtozla6BnpIu8lRuspjGDLo=;
        b=ghpg86tAzoEoN34sd0Wl8wXkcjke+p4Boq5+jnkVasvXp2CyT4b/N1D63db6KpSVDS
         LvRfE4JRH2RTLrlNkCgN2Y7sE/QTAkwBG4hDQdNTduo3QPPKRWnOIgMLrLjEjM7WEejE
         313rr95u8NAA+qoE80+eA3GdaGLgSQbw4budvEy6qOCa3tdwsMO5SdgMogI9RsjMVDiC
         Xmf5p5eP39BJgWF3BOI9/HA2ZDtyOn3bSibRnnPGJed6CUrDarFFZRpcZQE9rEK2Yxvl
         EWQ6EfYHrivI1aRQslAqd+VGqo0yRC3+HWdsQu5rvauvJVjGveXsG6BsDnLgfOgFnf0A
         zHGA==
X-Gm-Message-State: AA+aEWYZ2+JM1QzH7hSz5tpEvqErcD/bi+pjd5sSM/TJnWV403z+XlSL
        wnNioovJJVVAI13AOQ0bERE=
X-Google-Smtp-Source: AFSGD/VdBcBqXbYwGhOGHSRooGOxFMQkPQoeDuZd4L2iKXxIIr0L+d6ekO5GVqMoEMAkBcRDAICUhQ==
X-Received: by 2002:a62:5301:: with SMTP id h1mr5081423pfb.17.1545199196666;
        Tue, 18 Dec 2018 21:59:56 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a2:eb51:6018:45d4:55a2:e94b])
        by smtp.gmail.com with ESMTPSA id t67sm29538835pfd.90.2018.12.18.21.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 21:59:56 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v6 0/8] Introduce the for_each_set_clump8 macro
Date:   Wed, 19 Dec 2018 14:59:58 +0900
Message-Id: <cover.1545198260.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v6:
  - Fix typo in for_each_set_clump8 macro definition ('offset' should be
    'start')
  - Fix data type mismatch for format specifier of warning print
    statements in __check_eq_clump8
  - Fix typo in symbol suffix for definition of __check_eq_clump8
  - Fix typo in parameter passed to expect_eq_clump8 (missing '&' for
    clump argument)

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump8 macro and utilizes it
in several GPIO drivers. The for_each_set_clump macro8 facilitates a
for-loop syntax that iterates over a memory region entire groups of set
bits at a time.

For example, suppose you would like to iterate over a 32-bit integer 8
bits at a time, skipping over 8-bit groups with no set bit, where
XXXXXXXX represents the current 8-bit group:

    Example:        10111110 00000000 11111111 00110011
    First loop:     10111110 00000000 11111111 XXXXXXXX
    Second loop:    10111110 00000000 XXXXXXXX 00110011
    Third loop:     XXXXXXXX 00000000 11111111 00110011

Each iteration of the loop returns the next 8-bit group that has at
least one set bit.

The for_each_set_clump8 macro has four parameters:

    * start: set to the bit offset of the current clump
    * clump: set to the current clump value
    * bits: bitmap to search within
    * size: bitmap size in number of bits

In this version of the patchset, the for_each_set_clump macro has been
reimplemented and simplified based on the suggestions provided by Rasmus
Villemoes and Andy Shevchenko in the version 4 submission.

In particular, the function of the for_each_set_clump macro has been
restricted to handle only 8-bit clumps; the drivers that use the
for_each_set_clump macro only handle 8-bit ports so a generic
for_each_set_clump implementation is not necessary. Thus, a solution for
odd-sized clumps (e.g. 3-bit, 7-bit, etc.) mismatching word boundaries
can be postponed until a driver appears that actually requires a generic
for_each_set_clump implementation.

In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
introduced to get and set 8-bit values respectively. Their use is based
on the behavior suggested in the patchset version 4 review. Similarly,
the implementation of the find_next_clump function has been simplified
in order for the function to match the syntax and use of the
find_next_bit function.

William Breathitt Gray (8):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c   |  71 ++++++-------------
 drivers/gpio/gpio-104-idi-48.c    |  36 ++--------
 drivers/gpio/gpio-gpio-mm.c       |  71 ++++++-------------
 drivers/gpio/gpio-pci-idio-16.c   |  73 +++++++-------------
 drivers/gpio/gpio-pcie-idio-24.c  | 109 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  71 ++++++-------------
 include/asm-generic/bitops/find.h |  14 ++++
 include/linux/bitops.h            |   5 ++
 lib/find_bit.c                    |  63 +++++++++++++++++
 lib/test_bitmap.c                 |  65 ++++++++++++++++++
 10 files changed, 279 insertions(+), 299 deletions(-)

-- 
2.20.1


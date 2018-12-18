Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6CFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54312217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFJHXi2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLRKLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:11:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44733 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeLRKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:11:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so7589495pgr.11;
        Tue, 18 Dec 2018 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhf8R5TufUTluG0+Ql4zPiZm7xmwRnclFg2svm4Hkcs=;
        b=jFJHXi2IT2YNosr8LwuF/f1POt+X6mCioANAezgQcR02msNUjTKIgf3ou6easAEv50
         +ObLZK6VEMCENjqMVDouzFV4iawl/RnCGVHH1BiwEdKoFlB4HKGkzqtQ+o0Cvk1IM6fP
         LpTXMjA9v/QCsOMLn7zcfKlnZ91bg6NqXflHNtBoZeBNkQUp77zUHnJ5INVnbrJiTYAE
         YCTw8rMzbryP2XjBE8KN1+jdy/txAqYADfue8vJIQW1HVJvFGewIbIqeSvMwlTBcDIVi
         j33GaGuH8I4flE3L0B8K1LyP5EezDenkjElB+MWpgF6Jo/5ogXImeIuWFcbXKI84Jc2C
         z/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhf8R5TufUTluG0+Ql4zPiZm7xmwRnclFg2svm4Hkcs=;
        b=l0hRj6G6YzJEGIQR4Hxo6g2wvx18wfV9T6xkFjGMcti7ldAD+8BgfP4wtQOnFOGH97
         +Y8g/SPya3Tu0X0a20VjNynhC2a1Blz+80ac07tSgESet8ltyLjquBOtf/BpJHfa0Qln
         WvP5kKMFEpebLFrPLh+MpjG4YBRa2j3ECHalGTihIAywnaCE4aukyklx2LcDTtMT8HbS
         hhedTxQnzB/oFN5jGZ+fZqaK1SbBkHa65OWD8JQjuPbujAHpzqQLhYhGLqG8Dh9ZgZvz
         gYjCMCL1VCHyHmBVzYQ8BNumYzSr/aFJCNwzsfr+T+NJugAUtYaMc+g2hgdHYuy71X9f
         nOxQ==
X-Gm-Message-State: AA+aEWbKQ+tkvFG6Dq5Sh7Y6Cgh24H/jzLl5jP6ooZLlcK1YvZG1BENs
        8h/pbvAPSvPVQTabF8x2eOU=
X-Google-Smtp-Source: AFSGD/X+YBXin41yxF15lvqajrdQWQcTtk+p14MRo27RBOrGv/CtpG3r2ZpuW6cgmVE2cho1P5ERVA==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr15983222pfb.19.1545127882966;
        Tue, 18 Dec 2018 02:11:22 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a5:b5e9:3c79:e26e:bf45:b953])
        by smtp.gmail.com with ESMTPSA id 24sm5879420pfl.32.2018.12.18.02.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 02:11:22 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 0/8] Introduce the for_each_set_clump8 macro
Date:   Tue, 18 Dec 2018 19:11:32 +0900
Message-Id: <cover.1545126272.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
  - Restrict the function of the for_each_set_clump macro to handle only
    8-bit clumps (i.e. for_each_set_clump8)
  - Introduce the bitmap_get_value8 and bitmap_set_value8 functions to
    get and set 8-bit values respectively
  - Reimplement the for_each_set_clump macro to return the bit offset
    and clump value; this simplifies the arguments list and aligns the
    macro use to similar macros such as find_next_bit et al.

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
on the behavior suggested in the previous patchset version review.
Similarly, the implementation of the find_next_clump function has been
simplified in order for the function to match the syntax and use of the
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
 lib/test_bitmap.c                 |  67 ++++++++++++++++++
 10 files changed, 281 insertions(+), 299 deletions(-)

-- 
2.20.1


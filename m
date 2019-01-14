Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7327C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4C520660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/izQO1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfANGTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:19:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32947 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbfANGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:19:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so9681958plo.0;
        Sun, 13 Jan 2019 22:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsXFwmbpsiTV4bqdgsTDehtlnVkqSR+lpAsrgqf2K44=;
        b=C/izQO1ZfK3FJlvOHV3RS95z6px/7oQkxYC4XndHiUu9AwKO0AXmgu6+hkPfcRwRj0
         Ashmt+8vXaaoXWmdSKrg/97ib1IOIPi63NB0i68TSdXQq9U9bV8/6BLjlFxVmKgyOF6c
         0jLJe8s2EGu/X2y96nhqO1F2wr9SRFGB+DaavfeuDcBcFWeZ6yxLJ4kjPH3MRcUjXeWb
         8r9yTgD7znL+tspCAUGn3gFkO6WlJGA9AowpJO1RkoYnN6Y/ztINSztF+eMWcbNHDp2W
         BJyWH9KL0D+a84mpGU/TklERKb9eTARroEjOUPyaSb+Zd+gdFuvckRfIuvpwZx4FXCKC
         beGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsXFwmbpsiTV4bqdgsTDehtlnVkqSR+lpAsrgqf2K44=;
        b=hGpkgh6ZTqGbOXs5piNQWcHFHDgcmaaX0KYDmePYyCSTGUrRbPHbvzLIr5AogiPCfD
         yOAwzIDud1H8ey7xG5YJDW4G/UfE4mFCswXm41E8Uff28HS+ZSooaOyAttCFeHC9FwA3
         cchNQLJTaegTBTxPBbEjbTeASiKRrwYtNkKfOZMNFkD0mnlpt9vuWKTEnNlPHnhNtSJf
         QW0xRe5vnS7Tlj5DUm50yh4c3xsHaY/RrM1ioNl83L/aaH1ruFsShcLR+iYP/IRmF5B+
         cKRylwGz44OfLVKEaP1uGPNlyijvKrjx2XoQryan3JKRAq8/RZ2TOKIUj5abJIbJuQzK
         t4EQ==
X-Gm-Message-State: AJcUukevQhnatWTFNbMzw25Uq+EoQO0hwHKZoVoFR6j4ZuSeK9pb3ReN
        7pO0UCX0FY2Y/HOYRrpzXsk=
X-Google-Smtp-Source: ALg8bN52h9ACekRUFDToLii3Jin/uMLm3jURZH2xgwwGoxfTjYu3uiF9/IKWtT7aS1OzlUHD6hZAOw==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr24416504plb.55.1547446741425;
        Sun, 13 Jan 2019 22:19:01 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:70f2:4411:7de2:8afe:823b])
        by smtp.gmail.com with ESMTPSA id s79sm126849884pgs.50.2019.01.13.22.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 22:19:00 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Date:   Mon, 14 Jan 2019 15:19:17 +0900
Message-Id: <cover.1547445576.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v8:
  - Return unsigned long for bitmap_get_value8 for consistency
  - Add clobbering risk warning to bitmap_set_value8 documentation
  - Reimplement bitmap_get_value8 and bitmap_set_value8 to account for
    clumps that fall across bitmap word boundaries
  - Add a bitmap size argument to the bitmap_get_value8 and
    bitmap_set_value8 functions

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
large clumps (i.e. those larger than the width of a bitmap word) can be
postponed until a driver appears that actually requires such a generic
for_each_set_clump implementation.

For what it's worth, a semi-generic for_each_set_clump (i.e. for clumps
smaller than the width of a bitmap word) can be implemented by simply
replacing the hardcoded '8' and '0xFF' instances with respective
variables. I have not yet had a need for such an implementation, and
since it falls short of a true generic for_each_set_clump function, I
have decided to forgo such an implementation for now.

In addition, the bitmap_get_value8 and bitmap_set_value8 functions are
introduced to get and set 8-bit values respectively. Their use is based
on the behavior suggested in the patchset version 4 review.

William Breathitt Gray (8):
  bitops: Introduce the for_each_set_clump8 macro
  lib/test_bitmap.c: Add for_each_set_clump8 test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump8 macro
  gpio: 104-idi-48: Utilize for_each_set_clump8 macro
  gpio: gpio-mm: Utilize for_each_set_clump8 macro
  gpio: ws16c48: Utilize for_each_set_clump8 macro
  gpio: pci-idio-16: Utilize for_each_set_clump8 macro
  gpio: pcie-idio-24: Utilize for_each_set_clump8 macro

 drivers/gpio/gpio-104-dio-48e.c   |  73 ++++++--------------
 drivers/gpio/gpio-104-idi-48.c    |  37 +++-------
 drivers/gpio/gpio-gpio-mm.c       |  73 ++++++--------------
 drivers/gpio/gpio-pci-idio-16.c   |  75 ++++++++------------
 drivers/gpio/gpio-pcie-idio-24.c  | 111 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  72 ++++++-------------
 include/asm-generic/bitops/find.h |  14 ++++
 include/linux/bitops.h            |   5 ++
 lib/find_bit.c                    |  81 ++++++++++++++++++++++
 lib/test_bitmap.c                 |  65 +++++++++++++++++
 10 files changed, 307 insertions(+), 299 deletions(-)

-- 
2.20.1


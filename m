Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E5C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D3C20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mW6hfZ05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfALBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 20:47:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34476 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALBrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 20:47:12 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so7769610pfg.1;
        Fri, 11 Jan 2019 17:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx26wNIoA4oUba28uY2uY5soa2BNBG7WUH/BiUKUwEE=;
        b=mW6hfZ05/L36YY9YFRXG7GPFQty37BsLE0+dDg/xnPFtfqCXbasEmB+UwJ+0tMe8V3
         iFjTH0qQ6f0IgE8fFKvddM26WE/uBoQmx33NcD4vBXTxfLVHTu3jO8sfLAMEhNFaibhc
         QCtwCH29o7815AbaNPF2ATzykLadzi/NXE4t/SsiNM4rmScNvA0YVR3i9BWedTeNO3/1
         xrtVKGdVo1YrsBIFVgzdrgRJ9ml2ncxFrDk4vgJo9QZSicIvlsl5Fp7md6DRAOJSwZ1f
         VYFmwlkVrx3Zo8bu9u9bpL9I45DAIbqivTjpUT63XdkZoFO7fsSRoc+Ofggbxvxk3Uot
         1AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kx26wNIoA4oUba28uY2uY5soa2BNBG7WUH/BiUKUwEE=;
        b=OZtt838WOFXfbPm6YPCUmxhydGD5S4UAFW+xCkms6gLVbOoFTfkP8X7hSqPpNgn8SK
         wVQpppkT0Hnyp4IUitNlBueKNnlr/I0ePMA9MkBMPuuIy0RiJ6kylLpvZVQZNwiVddJh
         A1E8It7k4F8YwlzEdKUz+TITTsURCCxcuEDQPjwxeEuHy8YJb1mwmIthSKHCpbn7anfC
         300q2/7c9dQgivwjlhKdoMRRKMPs51l2xLRVL19y7mVT8sdamE9NmsEDBIVeE2V6BYH1
         zkSBhx9iCpL+HihaLmeGmYvUesLO45cEkXxqQf5bUy7EXIFOJ2aFYfAJwSujOIESZ50i
         v7Ow==
X-Gm-Message-State: AJcUukckixbPLkNG8mkMgoWucmRJV5AL3OKfpBiRkTYVMM/SjJMfMgHk
        p++KCFd2PgwJKxRhWRh2cmQ=
X-Google-Smtp-Source: ALg8bN4hrdHpA5pM+5cfnFzrZRkRjRDRMy0Ik5sbuTw6UjwXXe/ltW4cZy/5wIeTs3w7S0TzLvlKhg==
X-Received: by 2002:a63:c451:: with SMTP id m17mr15314247pgg.27.1547257631517;
        Fri, 11 Jan 2019 17:47:11 -0800 (PST)
Received: from localhost.localdomain ([2001:268:c0a3:ffc5:36e2:bccb:ba63:9e84])
        by smtp.gmail.com with ESMTPSA id c7sm160770247pfh.18.2019.01.11.17.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 17:47:11 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 0/8] Introduce the for_each_set_clump8 macro
Date:   Sat, 12 Jan 2019 10:47:34 +0900
Message-Id: <cover.1547257386.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v7:
  - Pass bitmap_set_value8 'value' parameter by value
  - Remove bitmap_set_value8 final mask operation; users beware: values
    greater than 8 bits may clobber bitmap

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


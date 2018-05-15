Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2893015-1526401352-2-8621248608796866890
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526401352; b=QTBAhVvMBLIhQ6+aAb6iLCPQjQYIgft0iNE2ozm/0+3twgNBfd
    9XJzPRclm6vlTr6KJGm1yyKT5vrWHYQhscKuOCxlc0PIHXmIrVcmxosUELSjjqEe
    hEfl2gXkhhNlOd/cjB1inlQyeqauwHOfX/+YFHQ0cv/YzyF0eZOvo6zaFFJ+NuZW
    xrt5Ad1ylc6pM2H9E7kuLrtbZ67YmZVRv5Jc9MdvH8Uu4jg/qAYVKoNoyFVq34Ov
    iZVNvVPPuOM+k/7mvUfgQdKDh7fX44x5veD2oYq6YPikkoItgHONb6XA5OKl4XIt
    8K1L8Yv5YD1+78IsJX2c5fLwbkNWPy2atrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526401352; bh=kmr8409u/SN83iMwhd6yn9R2Dod/Qi
    CS/GDYE56T4fI=; b=EUt3c6ajDlfNbdcK6vYo1PybSLASqy8xBxN45w/VAlStk/
    N0ryJVHoMwLk+cgVwUWfuYbMu0cHHTWEVp7A4QidcoD6HD8BS0Q94j6P4dbDIAkS
    PY1GgvGe683kU+Su88FDjDVoEvNcQx5T5NItUTuTwukYRCg5WNEElaXeqkPeVo88
    7ZWbr3HClEJjnt+pp6EkLp6vgrhTgJTRZbXqY1Aho3+RiW+z6thTVMVEW5E5XL1X
    G2rDSqsmiBakaDOx5ygp2h7/dpQaltW55HHRlnPYDe+UwqEfCJn882DhLhEthTZl
    xJP7HO+w0sOroGrLF22JHv7m+XqbPOH4eNlB6yvA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=cvNGmoCA x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=ZfMf1Nj5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=cvNGmoCA x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=ZfMf1Nj5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjaj2hIEDIKGOMnoCEia+zTeF+LTMn9h+TcKeQ8he1m9MFRZJ+OQZ4hZFuw7tDObRBXghMPvKTEfXBfBmFS0G/nCX7XwhEj+2WiVcCk41TrqaWnwmFC
    okijQcV+ooCrVeQgIq+LfJ1K30G23n2PYjjIlzTfc1o6Hk/f7/JDGebzheH01vyFgIgO2lArgXQiKhA19LmZzMAOpL2+6WnRU+sh/lW0+Jq8NW3Aqll9/bB7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=GnLzoMPhKksbaqafB68A:9 a=LkSJBRTudnDl6Wi9:21
    a=Kirf4LupX7PJOtj5:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeEOQWZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 12:22:25 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36843 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeEOQWX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2018 12:22:23 -0400
X-Google-Smtp-Source: AB8JxZqYiU07ovAKr1dFwhZBF/eFC1Vl02sAzzjeBDGMRhWmBsZtaAYZZhwWxmBUl1lANbWCQLcSpQ==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Date: Tue, 15 May 2018 12:22:13 -0400
Message-Id: <cover.1526400945.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes in v4:
  - Fix bitmap_set arguments (last parameter is nbits not endbit)

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_clump macro and utilizes it in
several GPIO drivers. The for_each_set_clump macro facilitates a
for-loop syntax that iterates over entire groups of set bits at a time.

For example, suppose you would like to iterate over a 16-bit integer 4
bits at a time, skipping over 4-bit groups with no set bit, where XXXX
represents the current 4-bit group:

    Example:        1011 1110 0000 1111
    First loop:     1011 1110 0000 XXXX
    Second loop:    1011 XXXX 0000 1111
    Third loop:     XXXX 1110 0000 1111

Each iteration of the loop returns the next 4-bit group that has at
least one set bit.

The for_each_set_clump macro has six parameters:

    * clump: set to current clump index for the iteration
    * index: set to current bitmap word index for the iteration
    * offset: bits offset of the found clump in the bitmap word
    * bits: bitmap to search within
    * size: bitmap size in number of clumps
    * clump_size: clump size in number of bits

The clump_size argument can be an arbitrary number of bits and is not
required to be a multiple of 2.

This patchset was rebased on top of the following three commits:

    * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
    * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
    * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")

When I implemented the test_for_each_set_clump function, I used
bitmap_set to set the expected bitmap for the test. This method of
setting bits only segments at a time was rather tedious and error-prone;
is there a better way to accomplish what I did (set a bitmap after a
DECLARE_BITMAP)?

William Breathitt Gray

William Breathitt Gray (8):
  bitops: Introduce the for_each_set_clump macro
  lib/test_bitmap.c: Add for_each_set_clump test cases
  gpio: 104-dio-48e: Utilize for_each_set_clump macro
  gpio: 104-idi-48: Utilize for_each_set_clump macro
  gpio: gpio-mm: Utilize for_each_set_clump macro
  gpio: ws16c48: Utilize for_each_set_clump macro
  gpio: pci-idio-16: Utilize for_each_set_clump macro
  gpio: pcie-idio-24: Utilize for_each_set_clump macro

 drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
 drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
 drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
 drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
 drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
 include/asm-generic/bitops/find.h |   9 +++
 include/linux/bitops.h            |   7 ++
 lib/find_bit.c                    |  40 ++++++++++++
 lib/test_bitmap.c                 |  71 +++++++++++++++++++++
 10 files changed, 236 insertions(+), 292 deletions(-)

-- 
2.17.0

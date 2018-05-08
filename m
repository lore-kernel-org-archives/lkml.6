Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825552-1525786012-2-1131713145067134883
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525786012; b=bPavu543mTFCuP08nwkc1rsnR2MeqG4yl6Fsf4fUFpgo6YzU9o
    UJYKlBlajzp9Tu0OXjUfsJTnBmJoAZsCZyTTvmZCE26pHyHtRT6xCUtkIe0c7ROZ
    sEsmZ5YFkvhABiSgE4E/HAy55yHgOsfxDhgutTuuybzVCCEZHOxZSiYn6c/txMR5
    xXgcE0Nm8NuQ/XO/Vf0c7bPdXfgdQA3DHHv8x7USI3R9PGExrE7bQrxGdnH0d6M9
    Dc99Sv32amqqapmXTvxBAjjM1+xNIO2Qn5AxsxiCzYFCQIC059RnISP5A+ugcIxo
    Wts3SxwD4Zxyi3QEYSzRuITI0K4DsBVYVM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525786012; bh=u/4+aSQMNk/G8E5D+4UK7p1QBTiB/Y
    3h/gDZCR8OANo=; b=LfHrNp5EvlN5YlRIHo77dCoD91BQIhfgr1qB8I2l3au5MN
    6u9w7hsNFHKSYBmkEoyK5DCr8/DclgqIeSwQ2/Yo8ht7ZeQUB73o9R3EW4ONvvv5
    4B8XtTxrHEWv2mqcWamzgla8faZ9/Vkg6ZbW5H1XperBU6ZPxZvLMMwX3EoNWQk9
    3pkHVmLiIKmXGrin+pqa4H/UNktAp6DRe/vwypB/q8XAsI+0hN8vRU2bErSnv7MI
    xZe/j1yBwF+khWW0WljFgV3tkFJY982esErLP/zc8fqFva8TkuVONWgeFLj0daK9
    GJX7aJGhNE34Z8HbfqkOX08YGFAOXYZSgLyILPOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=B2elQwli x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JGiZRJIq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=B2elQwli x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JGiZRJIq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ2AE+GOk1Ehj8+x0RC/vCS20QMVDJ16qohoopuGeYLqggFjkER0VbnwB2nqMkzfmWuHj2hFAkEUEqn4ZyNwNgQ873HzEZLFg53odYt7YJfGFJG2tduS
    q2RRSW0zy+iJ8u2dI7Y99VcNKz9DW7aA7wHh0MvkbU2FQ7csYCE1/Hd+KthV2K+AJFJMeLoo/nUiq5mef9McP0SpW14hcin8jcSv8Fivz1rMCJ0T3HzR8knm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=4kQkuRkhC1Z25NHHbJUA:9 a=2feUpW2bQENtn62C:21
    a=Gx3JeB4mRl8-tv8M:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755091AbeEHN0t (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 09:26:49 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46381 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754554AbeEHN0r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 09:26:47 -0400
X-Google-Smtp-Source: AB8JxZoidQbLS7lonYmB59qf6SmiDNw7wxKJcjWsXQYFWSwuoqdxntDdX9yY1uH7uSnblIRTbuw2TA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 0/7] Introduce the for_each_set_port_word macro
Date: Tue,  8 May 2018 09:26:34 -0400
Message-Id: <cover.1525785532.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes in v2:
  - Include linux/types.h file in bitops/find.h to define size_t

While adding GPIO get_multiple/set_multiple callback support for various
drivers, I noticed a pattern of looping manifesting that would be useful
standardized as a macro.

This patchset introduces the for_each_set_port_word macro and utilizes
it in several GPIO drivers. The for_each_set_port_word macro facilitates
a for-loop syntax that iterates over entire groups of set bits at a
time.

For example, suppose you would like to iterate over a 16-bit integer 4
bits at a time, skipping over 4-bit groups with no set bit, where XXXX
represents the current 4-bit group:

    Example:        1011 1110 0000 1111
    First loop:     1011 1110 0000 XXXX
    Second loop:    1011 XXXX 0000 1111
    Third loop:     XXXX 1110 0000 1111

Each iteration of the loop returns the next 4-bit group that has at
least one set bit.

The for_each_set_port_word macro has six parameters:

    * port_word: set to current port word index for the iteration
    * word_index: set to current bitmap word index for the iteration
    * word_offset: bits offset of the found port word in the bitmap word
    * bits: bitmap to search within
    * size: bitmap size in number of port words
    * port_size: port word size in number of bits

The port_size argument can be an arbitrary number of bits and is not
required to be a multiple of 2.

I've called the group of bits a "port word" which may be a confusing
naming convention; I was afraid calling that them a "group" may be too
vague. Should a different name be chosen; what would you suggest?

This patchset was rebased on top of the following three commits:

    * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
    * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
    * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")

William Breathitt Gray

William Breathitt Gray (7):
  bitops: Introduce the for_each_set_port_word macro
  gpio: 104-dio-48e: Utilize for_each_set_port_word macro
  gpio: 104-idi-48: Utilize for_each_set_port_word macro
  gpio: gpio-mm: Utilize for_each_set_port_word macro
  gpio: ws16c48: Utilize for_each_set_port_word macro
  gpio: pci-idio-16: Utilize for_each_set_port_word macro
  gpio: pcie-idio-24: Utilize for_each_set_port_word macro

 drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
 drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
 drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
 drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
 drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
 drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
 include/asm-generic/bitops/find.h |  26 ++++++++
 include/linux/bitops.h            |   9 +++
 lib/find_bit.c                    |  28 ++++++++
 9 files changed, 172 insertions(+), 292 deletions(-)

-- 
2.17.0

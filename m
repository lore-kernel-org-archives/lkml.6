Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2820460-1526399385-2-12866127935309444945
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526399385; b=L5BntY6GRoK/XFob3wUaY5Pyw9X2f84ckC2ImxIR4wyHuWDpeU
    iN9wVYLpTD6KezVRbdEzuxa8xHvJuodgsWINqRzkuSFOOLOUXr0R041Z+kvq0RpD
    DkXKls3gOooTKpNdK9LPuK0kbmpY7+07QNHmxIoWyO6clJAokcx1K/fXQrFOY0pR
    Aagm21NS3dBu9pz0NTPkU3FMg3l1sF8KRQfBkZqur8p5yaRtIZoyhyo2MzDU/bs2
    Z4YdV5J6bYSHSu7bZjfRT9ekWpLTjwZX+EUXm1q62L7SSyIw7ix58Sa9uLaQqGTo
    lFb9TFRmoSza01P/ELPKP1DMs/UVlQxPwT2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526399385; bh=myfotCDk7qrZHeyzFiNEHnhLpVuK/I
    Jt3EG4qTgb4BU=; b=Szb9nXaACp8OYhu4A6q7Y0CzDaWEnz1OuubFglchTYwio/
    8BBbYFq4b7rKOktITdwFeGObappRqfK+WYnYeMXxKV1ImYW8m6kZeiTk9F54otUw
    C8Jug3q4Y9KJk6u+Fm3cATNCsgSYCqsBlOsabLwKeKWy8e4Ks8ZlGO+OkhMoCaOw
    Cc7bsL2h+fqOnlJoSzpzM9MX0KSSmvS0d879COf65H0UYXR6zyhGghX/2gotMOFt
    Yq2O8RK8VQiy9HuPVxXWcbQYBkd3zjrJpLF0Ve6k9lsHC9MZdXPYxeTJzjl03ELs
    ftluQ/T/3mnpKXtEgGDVEXUQNJE362DR7jCH44Qg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=Smul1/t+ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=dFPYpXwu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=Smul1/t+ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=dFPYpXwu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFZ2O1XbF2gEJOd6hMjegdD+sutMB/NgGipIL/k4CiwTQ35mlrp1dy05tGQxgVCmJgdnTkHy+9EPgHVM6detyOkK50MJIKFEk0z5w15DQd3g10RiigxC
    Wcaf1UiFAI0c8TAeng2/3PRHzvwo+g+5NuDmJ0jlto6moSZFr/o8cka4PZuZj4JnaDsaVUSAFLoOBEUKPU5/7ehkCfGObKIcaC9ryBYcnX8NrrxoboWU/0qD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=GnLzoMPhKksbaqafB68A:9 a=zN-HhQ4YMnHEEb5r:21
    a=TKha-9LCoD5mcvVl:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeEOPtm (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 11:49:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35389 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeEOPtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 May 2018 11:49:41 -0400
X-Google-Smtp-Source: AB8JxZqJDoTE8hprH8HmmZHZVKeIGRqZFx+hPRpjsu65OGupU+3B6dD27dPzsNzn5Dam2ef8GoXc9g==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/8] Introduce the for_each_set_clump macro
Date: Tue, 15 May 2018 11:49:34 -0400
Message-Id: <cover.1526397764.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes in v3:
  - Replace "port word" nomenclature with "clump"
  - Add test cases for for_each_set_clump in lib/test_bitmap.c
  - Move kernel-doc comment for find_next_clump above C definition

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

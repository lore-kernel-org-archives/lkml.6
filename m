Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1186102-1525707320-2-16481866472245556749
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525707320; b=SupDaMs0vdneJTgO+23aINK5Wkjsfp7KMkRLSzYebZJeqob516
    z1Rqw6nqbuCX7Xm7upoVrKVa4PK9KSsefbjGEM4HXXcIGMaggOjx11Ui6fA77bTo
    15LFCKenQNV5tjX/v6iWP556iWTXluWr3rnRQNLcOHcsa8R+h7l12qdJHcVLR+K1
    fZL3CtbzpD6Eg54uHIN/nqd6dT7BBhMeeaNk0sQeVEvbkhYZtneEiOV1PnK85yEb
    cFEKOEbRp8YY7yO2BhH70TZspfIu2DVD06Uw4jDKUWLSsUVIOMYAH/oVJUjL0I3E
    p6MtmZcQ5TAovwluwk1kmgV10sFRlUApzQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525707320; bh=nr17vJJwcw8x5jSKlMYxR+ezHQSSze
    b6t1G+kmLJBtA=; b=FQrFKAdoVSiu7iIhO64DJBqbXPKF0KVu/54g4NpT8FFCMr
    zS0/vi71rP53aPxsWwtO3uhCxrj7v5J9jqVqATeQws0Id9Om0ESbcltjjSuKhttU
    7xP3lxXUu1tW5+kdkoYtN3TlEdMEZMo0EXoRDV4m8Mdpm/eYMSGv/t3yYkPcKpa3
    Ha52WpNY6JjN6lzkBadd3yO6j73sC5/mIIddrArm/BJCEBjHaiSU7mMb5+0zmUjj
    ZT/2NUQSYkcFO6WCVrM6ydn2ydgNcp4Fuy94GsTrljvUbc/RcxPf9tkk43M7aIyW
    zcL/HpdwBfmKL4jVXakNDBETy8TPOr2Y3/2Ko4zw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=L9zObmCJ x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PykWn/Da;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=L9zObmCJ x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PykWn/Da;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEnl5MrPbFLqfUm9WQvLKkEBKm5IjDpWigtODASGndjZ0tFNfpjVGWYgupc+XFyMQvrEgaEwJc8n67qxp96k7T4fJt114Ao5PwlkzJK0V/dWk6UKXcT1
    FarEojXhhWbwbUYJFZoOxJbB98vTe7Z7c/HVF+gxVxYE3I2Fw+jtxqpUK2dbrMIq2mwvv8zcQyT+mYkQ6OaqXahkzI0/R2BN4CXbaGLSo4n3hjCztPFFAeU3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=i6uMeK6BI1QA:10
    a=VUJBJC2UJ8kA:10 a=DYZ8hesIYH_MQkQPfhUA:9 a=0Q2BJV46FgXys8O8:21
    a=FA2hNFeXpfDbHSaL:21
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeEGPfP (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 11:35:15 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45841 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeEGPfO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 11:35:14 -0400
X-Google-Smtp-Source: AB8JxZrxb3eL4gSiOK85YSc+mSlMQpuuIER64g9bbS8v24h2TgeL8WQXUJ1pbUsjBysnC2T8Q0txFw==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 0/7] Introduce the for_each_set_port_word macro
Date: Mon,  7 May 2018 11:35:02 -0400
Message-Id: <cover.1525704095.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

    * aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
    * 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
    * e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")

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
 include/asm-generic/bitops/find.h |  24 +++++++
 include/linux/bitops.h            |   9 +++
 lib/find_bit.c                    |  28 ++++++++
 9 files changed, 170 insertions(+), 292 deletions(-)

-- 
2.17.0

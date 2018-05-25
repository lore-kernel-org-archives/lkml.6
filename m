Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4125545-1527268886-2-14476123795995386695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527268886; b=NDTQv5zM33ZGNnxloQa1UmLMYtKvxdEENXn33QTP2izCmhUzqb
    xABOKl6WxkgTItLoTrDbpsqqwwQ2c/VbjHQAekGI83PH0WDYhMJO4aZUiPBufYbf
    ZfYTvsUIleo1KWgJpYFLqhqJuHLPOoaoY1TFOOXtHT7nAcUL1Vq2DR3pEX3dL4v8
    PniqhKvwQqWxFX3KPt18aopyb+8m6SDSXyd37NzNs04T7SX29Xd6j3VNn8Fpyvh6
    mUxmARhTU5jtilbWc4tQ+SAbbEG9m822uRgk2KpM2JLBY/meEJYrsB1lm6C0ZdrS
    8mlna9ZSYdNavJRBE3CUjsV98l9vDBEg2VkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527268886; bh=nRENlgdd35aR24/TqobF9omMTjQ0xg
    2cNh/mf9EGTR8=; b=LvvcKOc9xqZb1iO5UsT9+uhrEkyET36lqAWcxxk7fqw7m9
    nAl7RJND2X9idd8PdLZqlsGxMZxFSFLe0bGDs1ajCHy9o9tRC93MYqh1ohPEb6+/
    ZI3R8mlwEODV+5v4aq5DRGhxuHWjVq3wspULoI7heX8QSek4MJnVTE0Jd7ycmH3K
    loTqPy95fYNkm7fS3InAEi8+is+6KRj0zNSaXHutHkRZL+2rjILy4dh6ErO6PPBX
    jtfUhhj5xiwpfY0/C+qY/8zicS9bqEHO8OCF/ZZ8m22xefCd6/1xv/okM5WydZer
    sNoRVZWYGyV7DYQrSnUsBAxaGVxRRHUfUDS0COOQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=T/dxjLfg x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Zl5feraK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=T/dxjLfg x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Zl5feraK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG2r0De6e3fDWb9FudcZLgJ+5ZfDls7X+j/ablfeABfB/1RKwN9oZgc78inPDRQutjcY8OOlcD6VvEBdebrdE1G6PhFLFMQAab1VqCQMcvjjMvRTORcC
    n9if4JwmuK5XONBg+CJ6okWQZJziGAIXdiZUGB3gfVrJKH3vhLsbyV8qTU1tv5KGoUWCZUXv32h2RLefD4sHj6+xJZkrk1sTXVGbCxOWRdD8mSw6VsmeS1uB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=Twlkf-z8AAAA:8 a=z3pt_mKctB9oo2ENzVAA:9 a=QEXdDO2ut3YA:10
    a=DW7FVhy0Zc8A:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967340AbeEYRVW (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 13:21:22 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43942 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbeEYRVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2018 13:21:21 -0400
X-Google-Smtp-Source: AB8JxZpwN+s2Oiiqi3MSIdcLuHpgsx4Cah9rxAJqCwPnXXzaTvYyCcGwaOc2T3iikQslFbBPEWfs3Q==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v3 0/6] arm64: untag user pointers passed to the kernel
Date: Fri, 25 May 2018 19:21:10 +0200
Message-Id: <cover.1527268727.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

This patch makes a few of the kernel interfaces accept tagged user
pointers. The kernel is already able to handle user faults with tagged
pointers and has the untagged_addr macro, which this patchset reuses.

We're not trying to cover all possible ways the kernel accepts user
pointers in one patchset, so this one should be considered as a start.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Changes in v3:
- Rebased onto e5c51f30 (4.17-rc6+).
- Added linux-arch@ to the list of recipients.

Changes in v2:
- Rebased onto 2d618bdf (4.17-rc3+).
- Removed excessive untagging in gup.c.
- Removed untagging pointers returned from __uaccess_mask_ptr.

Changes in v1:
- Rebased onto 4.17-rc1.

Changes in RFC v2:
- Added "#ifndef untagged_addr..." fallback in linux/uaccess.h instead of
  defining it for each arch individually.
- Updated Documentation/arm64/tagged-pointers.txt.
- Dropped “mm, arm64: untag user addresses in memory syscalls”.
- Rebased onto 3eb2ce82 (4.16-rc7).

Andrey Konovalov (6):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arm64: update Documentation/arm64/tagged-pointers.txt

 Documentation/arm64/tagged-pointers.txt |  5 +++--
 arch/arm64/include/asm/uaccess.h        | 14 +++++++++-----
 include/linux/uaccess.h                 |  4 ++++
 lib/strncpy_from_user.c                 |  2 ++
 lib/strnlen_user.c                      |  2 ++
 mm/gup.c                                |  4 ++++
 6 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.17.0.921.gf22659ad46-goog

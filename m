Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA48C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D65820855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYKQFOho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D65820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeLJMvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:51:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeLJMvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:51:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so10338240wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGDIvgYxZZleX0Ulu+jNQ7Fyei62P/2z/8zBNl/93Dc=;
        b=CYKQFOhod6bfTdNiD5E0gl/TAYYFsLLVjJMUWBI9eLEIp3KHIBvGvC+iBrKrMpL3ox
         eXjbO39qD17mcHW5R9lf8ScycOGv1Xt+4+PeVnc1n+vwKOAjYnpivn6dJZkutGfhpY9b
         YGT/kndBtsb0tF01ZCTFX7l+RP3skCVbfBSF1SYguFloq4XzTFko3raYwtEoYf85JXU0
         SdIllWn0YMzWII/KbzXSTyr056I5dOE7jfdjX1eT2/cnwsghF0U8mdJy/a80OQ1pPkVS
         LnAJ/qZT7Ly8CRfqhla3R4vHMx9o9dceJ363jAwGA5U+IubdveZ5QGwkSxGGGyP9jO3i
         YMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGDIvgYxZZleX0Ulu+jNQ7Fyei62P/2z/8zBNl/93Dc=;
        b=WY1DkEWNPtMHA2q6A+LmjWH30EAqz5W/RElx9O+dD2puVIq1NBEPjxEcw/Ef5xWZCJ
         sorUeM6DH+zsosBjqBg6HXKqIDlz4ZxjrZ/o9AODf2NUwvBIpImx1i31xSKCnUiWF5Ik
         4BDbG6PCIWeC4q5xM7F1QjOTVEKpVPYx9cSkU6mwcFgubRxdjAaPgle0+dP25oK0VASj
         SRWYtHsT42VMpQgjzSTbjHilrcyCyPcjWFRPO8mnIgP34wLz53vkQpQgS2/lU1pk8dZ2
         OIg26zpq0l9xzCPxmlRRO8/kudJ4eGcc/4HMhcztzKa8q5/FejYLS+J+WERD9YGMvhot
         aY6A==
X-Gm-Message-State: AA+aEWaCiShVFlzSJAZeys7EvnbrJ1XPSK77g9MRW+gMRxb4+GBRTxgr
        /NWUs1bKAig5wMWf80FNZketNw==
X-Google-Smtp-Source: AFSGD/W+0VMOrP6F6m4iYYBJD4b/AqgZqMY3B5+sANxwG4N5SbFW/Be7uVPSv3yYB39DvjcVRS7LHA==
X-Received: by 2002:adf:82e4:: with SMTP id 91mr10203851wrc.131.1544446269077;
        Mon, 10 Dec 2018 04:51:09 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:3180:41f8:3010:ff61])
        by smtp.gmail.com with ESMTPSA id l197sm36893363wma.44.2018.12.10.04.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 04:51:08 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v9 0/8] arm64: untag user pointers passed to the kernel
Date:   Mon, 10 Dec 2018 13:50:57 +0100
Message-Id: <cover.1544445454.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

Right now the kernel is already able to handle user faults with tagged
pointers, due to these patches:

1. 81cddd65 ("arm64: traps: fix userspace cache maintenance emulation on a
             tagged pointer")
2. 7dcd9dd8 ("arm64: hw_breakpoint: fix watchpoint matching for tagged
              pointers")
3. 276e9327 ("arm64: entry: improve data abort handling of tagged
              pointers")

When passing tagged pointers to syscalls, there's a special case of such a
pointer being passed to one of the memory syscalls (mmap, mprotect, etc.).
These syscalls don't do memory accesses but rather deal with memory
ranges, hence an untagged pointer is better suited.

This patchset extends tagged pointer support to non-memory syscalls. This
is done by reusing the untagged_addr macro to untag user pointers when the
kernel performs pointer checking to find out whether the pointer comes
from userspace (most notably in access_ok). The untagging is done only
when the pointer is being checked, the tag is preserved as the pointer
makes its way through the kernel.

One of the alternative approaches to untagging that was considered is to
completely strip the pointer tag as the pointer enters the kernel with
some kind of a syscall wrapper, but that won't work with the countless
number of different ioctl calls. With this approach we would need a custom
wrapper for each ioctl variation, which doesn't seem practical.

The following testing approaches has been taken to find potential issues
with user pointer untagging:

1. Static testing (with sparse [2] and separately with a custom static
   analyzer based on Clang) to track casts of __user pointers to integer
   types to find places where untagging needs to be done.

2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
   a modified syzkaller version that passes tagged pointers to the kernel.

Based on the results of the testing the requried patches have been added
to the patchset.

This patchset has been merged into the Pixel 2 kernel tree and is now
being used to enable testing of Pixel 2 phones with HWASan.

This patchset is a prerequisite for ARM's memory tagging hardware feature
support [3].

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

[2] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

[3] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a

Changes in v9:
- Rebased onto 4.20-rc6.
- Used u64 instead of __u64 in type casts in the untagged_addr macro for
  arm64.
- Added braces around (addr) in the untagged_addr macro for other arches.

Changes in v8:
- Rebased onto 65102238 (4.20-rc1).
- Added a note to the cover letter on why syscall wrappers/shims that untag
  user pointers won't work.
- Added a note to the cover letter that this patchset has been merged into
  the Pixel 2 kernel tree.
- Documentation fixes, in particular added a list of syscalls that don't
  support tagged user pointers.

Changes in v7:
- Rebased onto 17b57b18 (4.19-rc6).
- Dropped the "arm64: untag user address in __do_user_fault" patch, since
  the existing patches already handle user faults properly.
- Dropped the "usb, arm64: untag user addresses in devio" patch, since the
  passed pointer must come from a vma and therefore be untagged.
- Dropped the "arm64: annotate user pointers casts detected by sparse"
  patch (see the discussion to the replies of the v6 of this patchset).
- Added more context to the cover letter.
- Updated Documentation/arm64/tagged-pointers.txt.

Changes in v6:
  1 From 502466b9652c57a23af3bd72124144319212f30b Mon Sep 17 00:00:00 2001
- Added annotations for user pointer casts found by sparse.
  1 From 502466b9652c57a23af3bd72124144319212f30b Mon Sep 17 00:00:00 2001
- Rebased onto 050cdc6c (4.19-rc1+).
  1 From 502466b9652c57a23af3bd72124144319212f30b Mon Sep 17 00:00:00 2001

Changes in v5:
- Added 3 new patches that add untagging to places found with static
  analysis.
- Rebased onto 44c929e1 (4.18-rc8).

Changes in v4:
- Added a selftest for checking that passing tagged pointers to the
  kernel succeeds.
- Rebased onto 81e97f013 (4.18-rc1+).

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
- Dropped "mm, arm64: untag user addresses in memory syscalls".
- Rebased onto 3eb2ce82 (4.16-rc7).

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Andrey Konovalov (8):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  fs, arm64: untag user address in copy_mount_options
  arm64: update Documentation/arm64/tagged-pointers.txt
  selftests, arm64: add a selftest for passing tagged pointers to kernel

 Documentation/arm64/tagged-pointers.txt       | 25 +++++++++++--------
 arch/arm64/include/asm/uaccess.h              | 14 +++++++----
 fs/namespace.c                                |  2 +-
 include/linux/uaccess.h                       |  4 +++
 lib/strncpy_from_user.c                       |  2 ++
 lib/strnlen_user.c                            |  2 ++
 mm/gup.c                                      |  4 +++
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 ++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 +++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 ++++++++++++++
 11 files changed, 80 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.20.0.rc2.403.gdbc3b29805-goog


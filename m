Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F8F206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpC6ltPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F8F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJBT5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:57:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39406 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeJBT4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so1428383wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXQJN5/mYbcTFUKfsLCjPiu94Tn0A2v77x7OgiEie9w=;
        b=mpC6ltPJGJlGd34YZ/Qs5gI+Ffq9tG+HvFBzQBmI7MRKYSBk9BvtrLVxtgjOEPFk0+
         oUQfcKkF5hvO59b7aO6FA2yAEkyRkElhfhZrZ+IcCjJTNiB+AUgHYl93kBy3qJYPTEll
         Pta+xwmcCczWOhPNBVWZxg6hx7GNaHRlRCoKhY5e6PJNUzg/M6I756svrmxGUkYmY5O1
         0NJpq+8aFGccjVaHa7efnQZjIGCY83PIyzO5Bwt+dvdVDOdHtbLcG4Wet0JljtEk5dTr
         +kZ6ERsNbY9O5HoLE+WHntRqHfgktxYB1Hrlu18nEsO1HxGbTDDxRVn4f1xIYlk2pvXa
         GDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gXQJN5/mYbcTFUKfsLCjPiu94Tn0A2v77x7OgiEie9w=;
        b=YcF7SsznG8rekXoG/WcKFAcBl99TSFIez1Ff1nvZ66+G+6oYTN/tgjyYmk2F0Eojyf
         aVk7PWHZ1wEJbRtWKdXDzWJW6Ow2sUm9X3NNTwhGnsQmtDT7UHB0y6G9j5EyCZyJBpwQ
         /vBwzdj+WGKCSH1noT0U1duAwJjG5tqIII3WM0z+2NfJY6TxjzwrhIVLIpkq0CUzJzdk
         XNK2PUDC7lto7bCu7oFJcsHTuzDABBKVJUAqDm8Ak1L0v5iWg6PUp45AfGuHEO4K4DEo
         lFCK0cctzpsJnAZXC5HyPhX4FNJVv8WCxu/RZCWqc8Zjm7zsfTp+X1OfZ9kUrx7fXK3v
         P0XQ==
X-Gm-Message-State: ABuFfoj5IEDCnZcgmam8UjUhip3mSZAsaDTwRawLAHykPGJ06LPFpJzg
        a5QCE220aiRDSZwhqO9NRwflRA==
X-Google-Smtp-Source: ACcGV630HX4IhsHu3l0v51SFXWagAwZSqYlNgcp3UOU0Jze+SvrS1IrHCRMul6p7phL9fLdRnmoUlg==
X-Received: by 2002:a5d:6608:: with SMTP id n8-v6mr11042178wru.281.1538485966358;
        Tue, 02 Oct 2018 06:12:46 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17458681wrp.0.2018.10.02.06.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 06:12:45 -0700 (PDT)
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
Subject: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
Date:   Tue,  2 Oct 2018 15:12:35 +0200
Message-Id: <cover.1538485901.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
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
from userspace (most notably in access_ok).

The following testing approaches has been taken to find potential issues
with user pointer untagging:

1. Static testing (with sparse [2] and separately with a custom static
   analyzer based on Clang) to track casts of __user pointers to integer
   types to find places where untagging needs to be done.

2. Dynamic testing: adding BUG_ON(has_tag(addr)) to find_vma() and running
   a modified syzkaller version that passes tagged pointers to the kernel.

Based on the results of the testing the requried patches have been added
to the patchset.

This patchset is a prerequisite for ARM's memory tagging hardware feature
support [3].

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

[2] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

[3] https://community.arm.com/processors/b/blog/posts/arm-a-profile-architecture-2018-developments-armv85a

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
- Added annotations for user pointer casts found by sparse.
- Rebased onto 050cdc6c (4.19-rc1+).

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

Andrey Konovalov (8):
  arm64: add type casts to untagged_addr macro
  uaccess: add untagged_addr definition for other arches
  arm64: untag user addresses in access_ok and __uaccess_mask_ptr
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  fs, arm64: untag user address in copy_mount_options
  arm64: update Documentation/arm64/tagged-pointers.txt
  selftests, arm64: add a selftest for passing tagged pointers to kernel

 Documentation/arm64/tagged-pointers.txt       | 24 +++++++++++--------
 arch/arm64/include/asm/uaccess.h              | 14 +++++++----
 fs/namespace.c                                |  2 +-
 include/linux/uaccess.h                       |  4 ++++
 lib/strncpy_from_user.c                       |  2 ++
 lib/strnlen_user.c                            |  2 ++
 mm/gup.c                                      |  4 ++++
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 +++++++++++++++
 11 files changed, 79 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

-- 
2.19.0.605.g01d371f741-goog


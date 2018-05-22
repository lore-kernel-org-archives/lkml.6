Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1741794-1526958796-2-14665103491917143398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526958796; b=QtMJFoFAKBz1oIXXG3J21HI1icpw2slNNiZzYe+F4FaGk/walD
    UlHoVw27tAqqsEfYXNxVpE6ljRKoPdddNmFoYwfGDVRWYwJZA5Y7ElhLH4E5Z+EB
    38o4S+I1A0pFzdFrbl1vTBEFx+dBMjHpVNTEwbxLt7b76udhJNB1oSy0GwQi8qGc
    rtzA+fOPatvrowlwGdv9XWiODoVcxTyaJcl/YogNuQI8GMUN9KAMj6rYR0zaMLD4
    u1i+aurLinOgHQyck1Mx94iLkmz282H7HpB4GwovkzvUk/m0N8pkhx0AJg5+4vRx
    Fr1uK4XvuORy/sxt0D/3M+KR7XKke6OygSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526958796; bh=IEwlwk2oEa9V3fPPDrl7UwrbdnS17t
    ZULJ7vMf6C0+U=; b=YbM6M1bPAJeRHLtkceQOmEKAwP+3Xd4+jQDUUNYxViN1QK
    6lGuzYAcgZ29tKHbD0zrPf3cmh+M9D5Mh2OLfwB7gSTTJDffaknE6so6aw0fLxEF
    XF80Jq8HvMKSvjRZh8JpzTqyewqS0vGmUYwwRY6k5LvaeYBhCPKTtUZybxczo0lT
    YzFxWcSme40arj8YXCPaIXzRkf0hFkSZ18YIaUaHKjzbfZOplmR7RlPyoMgx57ep
    Zt7yrksrgFogehaNXaMPnntVJhuszWM4ycW0O7wLtVluIjPG7xRVQsQSeYDuQlGP
    JVpLFSVBbKqXnhNJEmyrGIhQ7vD/bBxZcsdD1hjA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEi1Ljdw4DrvnYrsh7Oz5tt0ftystHGayYHFsRjHSVSeUzT3cGOgkNhkjpvVcjrm1xpA5WfL02AhpDd67UCn12mhxi7/sS63ZYPV1ZgXaLZu+NPLszxp
    qrQnuhVhrSOHxS9j5DkrB5kM1kAt7iR1dUTYaZKNINKJ3Srrh2/+I8gmxg61tSlBsXSMsgcXW4eW3SRb9CcNYBTOG1PVzI/Plj8WJremH/3dRsKuVL3NyHUF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=i3X5FwGiAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=7CQSdrXTAAAA:8
    a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8 a=CxaZg77CAAAA:8
    a=pGLkceISAAAA:8 a=s8EWgBTSiC7UjTd6gCEA:9 a=tu5o3xbZoH-invnD:21
    a=7L6yVLmnT3y2kCmw:21 a=x8gzFH9gYPwA:10 a=mmqRlSCDY2ywfjPLJ4af:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HxQw6O0h_v37Y3_G5fB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeEVDNP (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 23:13:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:55066 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751932AbeEVDNO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 21 May 2018 23:13:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="41795474"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH V3 0/3] Use efi_rts_wq to invoke EFI Runtime Services
Date: Mon, 21 May 2018 20:13:01 -0700
Message-Id: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Problem statement:
------------------
Presently, efi_runtime_services() silently switch %cr3 from swapper_pgd
to efi_pgd. As a consequence, kernel code that runs in efi_pgd (e.g.,
perf code via an NMI) will have incorrect user space mappings[1]. This
could lead to otherwise unexpected access errors and, worse, unauthorized
access to firmware code and data.

Detailed discussion of problem statement:
-----------------------------------------
As this switch is not propagated to other kernel subsystems; they will
wrongly assume that swapper_pgd is still in use and it can lead to
following issues:

1. If kernel code tries to access user space addresses while in efi_pgd,
it could lead to unauthorized accesses to firmware code/data.
(e.g: <__>/copy_from_user_nmi()).
[This could also be disastrous if the frame pointer happens to point at
MMIO in the EFI runtime mappings] - Mark Rutland.

An example of a subsystem that could touch user space while in efi_pgd is
perf. Assume that we are in efi_pgd, a user could use perf to profile
some user data and depending on the address the user is trying to
profile, two things could happen.
1. If the mappings are absent, perf fails to profile.
2. If efi_pgd does have mappings for the requested address (these
  mappings are erroneous), perf profiles firmware code/data. If the
  address is MMIO'ed, perf could have potentially changed some device state.

The culprit in both the cases is, EFI subsystem swapping out pgd and not
perf. Because, EFI subsystem has broken the *general assumption* that
all other subsystems rely on - "user space might be valid and nobody has
switched %cr3".

Solutions:
----------
There are two ways to fix this issue:
1. Educate about pgd change to *all* the subsystems that could
   potentially access user space while in efi_pgd.
  On x86, AFAIK, it could happen only when some one touches user space
  from the back of an NMI (a quick audit on <__>/copy_from_user_nmi,
  showed perf and oprofile). On arm, it could happen from multiple
  places as arm runs efi_runtime_services() interrupts enabled (ARM folks,
  please comment on this as I might be wrong); whereas x86 runs
  efi_runtime_services() interrupts disabled.

  I think, this solution isn't holistic because
  a. Any other subsystem might well do the same, if not now, in future.
  b. Also, this solutions looks simpler on x86 but not true if it's the
    same for arm (ARM folks, please comment on this as I might be wrong).
  c. This solution looks like a work around rather than addressing the issue.

2. Running efi_runtime_services() in kthread context.
  This makes sense because efi_pgd doesn't have user space and kthread
  by definition means that user space is not valid. Any kernel code that
  tries to touch user space while in kthread is buggy in itself. If so,
  it should be an easy fix in the other subsystem. This also take us one
  step closer to long awaiting proposal of Andy - Running EFI at CPL 3.

What does this patch set do?
----------------------------
Introduce efi_rts_wq (EFI runtime services work queue).
When a user process requests the kernel to execute any efi_runtime_service(),
kernel queues the work to efi_rts_wq, a kthread comes along, switches to
efi_pgd and executes efi_runtime_service() in kthread context. IOW, this
patch set adds support to the EFI subsystem to handle all calls to
efi_runtime_services() using a work queue (which in turn uses kthread).

How running efi_runtime_services() in kthread fixes above discussed issues?
---------------------------------------------------------------------------
If we run efi_runtime_services() in kthread context and if perf
checks for it, we could get both the above scenarios correct by perf
aborting the profiling. Not only perf, but any subsystem that tries to
touch user space should first check for kthread context and if so,
should abort.

Q. If we still need check for kthread context in other subsystems that
access user space, what does this patch set fix?
A. This patch set makes sure that EFI subsystem is not at fault.
Without this patch set the blame is upon EFI subsystem, because it's the
one that changed pgd and hasn't communicated this change to everyone and
hence broke the general assumption. Running efi_runtime_services() in
kthread means explicitly communicating that user space is invalid, now 
it's the responsibility of other subsystem to make sure that it's
running in right context.

Testing:
--------
Tested using LUV (Linux UEFI Validation) for x86_64, x86_32 and arm64
(qemu only). Will appreciate the effort if someone could test the
patches on real ARM/ARM64 machines.
LUV: https://01.org/linux-uefi-validation

Credits:
--------
Thanks to Ricardo, Dan, Miguel and Mark for initial reviews and
suggestions. Thanks to Boris and Andy for making me think through/help
on what I am addressing with this patch set. Please feel free to pour in
your comments and concerns.

Note:
-----
Patches are based on Linus's kernel v4.17-rc6

[1] Backup: Detailing efi_pgd:
------------------------------
efi_pgd has mappings for EFI Runtime Code/Data (on x86, plus EFI Boot time
Code/Data) regions. Due to the nature of these mappings, they fall
in user space address ranges and they are not the same as swapper.

[On arm64, the EFI mappings are in the VA range usually used for user
space. The two halves of the address space are managed by separate
tables, TTBR0 and TTBR1. We always map the kernel in TTBR1, and we map
user space or EFI runtime mappings in TTBR0.] - Mark Rutland

Changes from V2 to V3:
----------------------
1. Rewrite the cover letter to clearly state the problem. What we are
fixing and what we are not fixing.
2. Make efi_delete_dummy_variable() change local to x86.
3. Avoid using BUG(), instead, print error message and exit gracefully.
4. Move struct efi_runtime_work to runtime-wrappers.c file.
5. Give enum a name (efi_rts_ids) and use it in efi_runtime_work.
6. Add Naresh (maintainer of LUV for ARM) and Miguel to the CC list.

Changes from V1 to V2:
----------------------
1. Remove unnecessary include of asm/efi.h file - Fixes build error on
ia64, reported by 0-day
2. Use enum to identify efi_runtime_services()
3. Use alloc_ordered_workqueue() to create efi_rts_wq as
create_workqueue() is scheduled for depreciation.
4. Make efi_call_rts() static, as it has no callers outside
runtime-wrappers.c
5. Use BUG(), when we are unable to queue work or unable to identify
requested efi_runtime_service() - Because these two situations should
*never* happen.

Sai Praneeth (3):
  x86/efi: Call efi_delete_dummy_variable() after creating efi_rts_wq
  efi: Introduce efi_queue_work() to queue any efi_runtime_service() on 
       efi_rts_wq
  efi: Use efi_rts_wq to invoke EFI Runtime Services

 arch/x86/platform/efi/efi.c             |  15 +-
 drivers/firmware/efi/arm-runtime.c      |   3 +
 drivers/firmware/efi/efi.c              |  25 ++++
 drivers/firmware/efi/runtime-wrappers.c | 250 +++++++++++++++++++++++++++++---
 include/linux/efi.h                     |   4 +
 5 files changed, 271 insertions(+), 26 deletions(-)

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Naresh Bhat <naresh.bhat@linaro.org>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

-- 
2.7.4


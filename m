Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1371436-1528085807-2-7853697966912364215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528085807; b=c3fG/yJpTNXbs7fGxK3IRSJqKWOiqMM/HXyWWVPZeQg0H/UoSD
    SoBHpqVFWAwUzinmTQ70q4NWPK2wn+nFq23a9VUQMy9rCQux8dx0zdSie2zg6tvl
    NZQLcKWd+reSYzJhh728F+GriQ+a01wWSlrHvhi3q2d4+WgKOMXtXwHcaWSA9LLo
    sg71uqZgAMV3AN58it2Sqt8kSLrDxQvsiRu7REdFURYznjTbWXsvezqWVDAo8uBn
    GvFRSoKF0H75Bc6PtEh9t+hFoAZMxdjbg7WLZX8th4pTgff7nFOPXdAvAJG3IT6x
    /4+SurCp1si+aDwfd1o9uzlOXrYSpXl7lr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1528085807; bh=RqOLDNqF07l25eoq49UJAxTzK6BSxkiBnpMXqiLUKR
    0=; b=JBfwx1DFYi5ucV1ZObNspJj3+WkWHto7kIHR4/vG/0xCvnnLoWUe1qbkit
    +XXz4AqRHb5ke5mLdalyRnRmdtBYp3DOZTaTjALl7UtC6U7qWMhe0j5NFti3ap5J
    A9ow662vfrsg4CWJ+LgRrtESEtYdsMnaZRSY+5gqLQeB0/4ofd4YZk1RCrwuHcUw
    RF84xdWLuWwzO+0sbp3XJsf6lp7JnVzBja3pCP8sRHk5QT+W0qc8O1UPiDvFcR8N
    d69XZvatkl4uE8DVnKkY9wqdvrmwJn2W8UcmwJT3mDIXr/MSJrGPKTPNxnWS1YxX
    N+aHSDlxcqxTPlV5OPG7fkDRW8gA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEFcWwO2v0MXuMwXijkV9yh+OhaHK0thHn/RpX6UurcaHpxZMfDqeAVN9haOYhe9i3J6qmXnscXUyIg0f0xFCzf2MR7cpcpoacoas2zrrGSflKrELZsV
    bTv/Gifxy+TXBcXWm9AjfDd/x3UxRdGL+cv5R3R3FzVm7dW1GukIPqFA/Tf15iCHjPWqGe9OO0ckVJL6iB173BCZt4tmT+Dxn04rMuaWiu2MxQooyYZ4IcMN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=VwQbUJbxAAAA:8
    a=PCoZbIwMAxAqk9kA-hAA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeFDEQq (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 00:16:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37949 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeFDEQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2018 00:16:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
References: <87o9grmbrp.fsf@xmission.com>
Date: Sun, 03 Jun 2018 23:16:37 -0500
In-Reply-To: <87o9grmbrp.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 03 Jun 2018 23:11:22 -0500")
Message-ID: <87in6zmbiy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPgvD-0002ms-H7;;;mid=<87in6zmbiy.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++y7HX1MbENpPCkm//Lyb1/IX7MLej7rw=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 332 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.2 (1.3%), b_tie_ro: 2.8 (0.8%), parse: 1.26 (0.4%),
        extract_message_metadata: 8 (2.3%), get_uri_detail_list: 5 (1.6%),
        tests_pri_-1000: 3.4 (1.0%), tests_pri_-950: 1.22 (0.4%), tests_pri_-900:
        1.00 (0.3%), tests_pri_-400: 32 (9.6%), check_bayes: 31 (9.3%), b_tokenize:
        11 (3.3%), b_tok_get_all: 11 (3.2%), b_comp_prob: 2.8 (0.8%),
        b_tok_touch_all: 3.8 (1.1%), b_finish: 0.81 (0.2%), tests_pri_0: 269 (81.2%),
        check_dkim_signature: 0.46 (0.1%), check_dkim_adsp: 3.7 (1.1%),
        tests_pri_500: 4.1 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] siginfo work for v4.18-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 26da35010c6d6ce317d511c8186585bdd8ab6629 signal/sh: Stop gcc warning about an impossible case in do_divide_error

Apologies for the resend I spaced and forgot the diffstat earlier.

This set of changes close the known issues with setting si_code to an
invalid value, and with not fully initializing struct siginfo.  There
remains work to do on nds32, arc, unicore32, powerpc, arm, arm64, ia64
and x86 to get the code that generates siginfo into a simpler and more
maintainable state.  Most of that work involves refactoring the signal
handling code and thus careful code review.

Also not included is the work to shrink the in kernel version of struct
siginfo.  That depends on getting the number of places that directly
manipulate struct siginfo under control, as it requires the introduction
of struct kernel_siginfo for the in kernel things.

Overall this set of changes looks like it is making good progress,
and with a little luck I will be wrapping up the siginfo work
next development cycle.

Dmitry V. Levin (1):
      sparc: fix compat siginfo ABI regression

Eric W. Biederman (44):
      signal/alpha: Document a conflict with SI_USER for SIGFPE
      signal/sh: Use force_sig_fault in hw_breakpoint_handler
      signal/nds32: Use force_sig in unhandled_interruption and unhandled_exceptions
      signal/nds32: Use force_sig(SIGILL) in do_revisn
      signal: Ensure every siginfo we send has all bits initialized
      signal: Reduce copy_siginfo_to_user to just copy_to_user
      signal: Stop special casing TRAP_FIXME and FPE_FIXME in siginfo_layout
      signal: Remove SEGV_BNDERR ifdefs
      signal: Remove ifdefs for BUS_MCEERR_AR and BUS_MCEERR_AO
      signal/alpha: Replace FPE_FIXME with FPE_FLTUNK
      signal/ia64: Replace FPE_FIXME with FPE_FLTUNK
      signal/powerpc: Replace FPE_FIXME with FPE_FLTUNK
      signal/unicore32: Use FPE_FLTUNK instead of 0 in ucf64_raise_sigfpe
      signal: Add TRAP_UNK si_code for undiagnosted trap exceptions
      signal/alpha:  Replace TRAP_FIXME with TRAP_UNK
      signal/powerpc: Replace TRAP_FIXME with TRAP_UNK
      signal/alpha: Use send_sig_fault where appropriate
      signal/alpha: Use force_sig_fault where appropriate
      signal/c6x: Use force_sig_fault where appropriate
      signal/hexagon: Use force_sig_fault as appropriate
      signal/m68k: Use force_sig_fault where appropriate
      signal/microblaze: Remove the commented out force_sig_info in do_page_fault
      signal/microblaze: Use force_sig_fault where appropriate
      signal/mips: Use force_sig_fault where appropriate
      signal/nds32: Use force_sig_fault where appropriate
      signal/nios2: Use force_sig_fault where appropriate
      signal/openrisc: Use force_sig_fault where appropriate
      signal/parisc: Use force_sig_mceerr where appropriate
      signal/parisc: Use force_sig_fault where appropriate
      signal/riscv: Use force_sig_fault where appropriate
      signal/riscv: Replace do_trap_siginfo with force_sig_fault
      signal/s390: Use force_sig_fault where appropriate
      signal/sh: Use force_sig_fault where appropriate
      signal/sparc: Use send_sig_fault where appropriate
      signal/sparc: Use force_sig_fault where appropriate
      signal/um: Use force_sig_fault where appropriate
      signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
      signal/xtensa: Use force_sig_fault where appropriate
      signal/signalfd: Remove __put_user from signalfd_copyinfo
      signal/signalfd: Add support for SIGSYS
      signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
      signal: Extend siginfo_layout with SIL_FAULT_{MCEERR|BNDERR|PKUERR}
      signal/um: More carefully relay signals in relay_signal.
      signal/sh: Stop gcc warning about an impossible case in do_divide_error

Guenter Roeck (1):
      signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions

 arch/alpha/include/uapi/asm/siginfo.h     |  14 ---
 arch/alpha/kernel/osf_sys.c               |  11 +-
 arch/alpha/kernel/signal.c                |  20 +---
 arch/alpha/kernel/traps.c                 |  79 ++++---------
 arch/alpha/mm/fault.c                     |  13 +--
 arch/arc/mm/fault.c                       |   2 +
 arch/arm/kernel/ptrace.c                  |   1 +
 arch/arm/kernel/swp_emulate.c             |   1 +
 arch/arm/kernel/traps.c                   |   5 +
 arch/arm/mm/alignment.c                   |   1 +
 arch/arm/mm/fault.c                       |   4 +
 arch/arm/vfp/vfpmodule.c                  |   3 +-
 arch/arm64/kernel/fpsimd.c                |   2 +-
 arch/arm64/kernel/sys_compat.c            |   1 +
 arch/arm64/kernel/traps.c                 |   1 +
 arch/arm64/mm/fault.c                     |  18 ++-
 arch/c6x/kernel/traps.c                   |   9 +-
 arch/hexagon/kernel/traps.c               |   9 +-
 arch/hexagon/mm/vm_fault.c                |  20 ++--
 arch/ia64/include/uapi/asm/siginfo.h      |   7 --
 arch/ia64/kernel/brl_emu.c                |   1 +
 arch/ia64/kernel/signal.c                 |   2 +
 arch/ia64/kernel/traps.c                  |  31 ++++-
 arch/ia64/kernel/unaligned.c              |   1 +
 arch/ia64/mm/fault.c                      |   4 +-
 arch/m68k/kernel/traps.c                  |  58 +++++-----
 arch/m68k/mm/fault.c                      |  25 ++---
 arch/microblaze/kernel/exceptions.c       |   8 +-
 arch/microblaze/mm/fault.c                |  12 +-
 arch/mips/kernel/traps.c                  |  65 +++--------
 arch/mips/mm/fault.c                      |  18 +--
 arch/nds32/kernel/traps.c                 |  35 ++----
 arch/nds32/mm/fault.c                     |  18 +--
 arch/nios2/kernel/traps.c                 |   8 +-
 arch/openrisc/kernel/traps.c              |  30 +----
 arch/openrisc/mm/fault.c                  |  18 +--
 arch/parisc/kernel/ptrace.c               |  10 +-
 arch/parisc/kernel/traps.c                |  61 ++++------
 arch/parisc/kernel/unaligned.c            |  15 +--
 arch/parisc/math-emu/driver.c             |   8 +-
 arch/parisc/mm/fault.c                    |  54 +++++----
 arch/powerpc/include/uapi/asm/siginfo.h   |  15 ---
 arch/powerpc/kernel/process.c             |   1 +
 arch/powerpc/kernel/traps.c               |  13 +--
 arch/powerpc/mm/fault.c                   |   1 +
 arch/powerpc/platforms/cell/spufs/fault.c |   2 +-
 arch/riscv/kernel/traps.c                 |  16 +--
 arch/s390/kernel/traps.c                  |  29 +----
 arch/s390/mm/fault.c                      |  21 +---
 arch/sh/kernel/hw_breakpoint.c            |   9 +-
 arch/sh/kernel/traps_32.c                 |  20 ++--
 arch/sh/math-emu/math.c                   |   8 +-
 arch/sh/mm/fault.c                        |   9 +-
 arch/sparc/include/uapi/asm/siginfo.h     |   7 --
 arch/sparc/kernel/process_64.c            |   9 +-
 arch/sparc/kernel/sys_sparc_32.c          |   8 +-
 arch/sparc/kernel/sys_sparc_64.c          |   8 +-
 arch/sparc/kernel/traps_32.c              | 104 ++++-------------
 arch/sparc/kernel/traps_64.c              | 131 +++++----------------
 arch/sparc/kernel/unaligned_32.c          |  11 +-
 arch/sparc/mm/fault_32.c                  |  12 +-
 arch/sparc/mm/fault_64.c                  |   8 +-
 arch/um/kernel/ptrace.c                   |  13 +--
 arch/um/kernel/trap.c                     |  62 ++++------
 arch/unicore32/kernel/fpu-ucf64.c         |   8 +-
 arch/unicore32/mm/fault.c                 |   3 +
 arch/x86/entry/vsyscall/vsyscall_64.c     |   2 +-
 arch/x86/kernel/ptrace.c                  |   2 +-
 arch/x86/kernel/signal_compat.c           |   2 +-
 arch/x86/kernel/traps.c                   |   3 +
 arch/x86/kernel/umip.c                    |   1 +
 arch/x86/kvm/mmu.c                        |   1 +
 arch/x86/mm/fault.c                       |   1 +
 arch/xtensa/kernel/traps.c                |   9 +-
 arch/xtensa/mm/fault.c                    |  18 +--
 fs/signalfd.c                             |  93 +++++++--------
 include/linux/ptrace.h                    |   1 -
 include/linux/signal.h                    |   3 +
 include/linux/tracehook.h                 |   1 +
 include/uapi/asm-generic/siginfo.h        |   3 +-
 include/uapi/linux/signalfd.h             |   6 +-
 kernel/signal.c                           | 181 +++++++++---------------------
 virt/kvm/arm/mmu.c                        |   1 +
 83 files changed, 493 insertions(+), 1066 deletions(-)

Eric

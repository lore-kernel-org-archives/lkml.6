Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-232839-1524186191-2-186868917903379588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524186191; b=KzY3ZYpP2amu5EvlTsH0vr6powjzZ8i6wdXPl5k4uPIhiRe8gZ
    fi+hAs/qhSG3liLmbpRnFgD0QlnqOiRwbg8jNGI4QTZSWHMwMP9Qi2YgCj4PxS9j
    7OcOvkMDKsP6CJXeDkfQQj0n91YMR0rfQ5F6CuYPFadpAw6wBONQY7f9YRFrB53c
    jqF4l1KWE+kaDmwA8Bzbovgublg5ZBkMM5B4YjDtPyCY1LMpDJHr+v9C2nTR727T
    aehJp+SjwLPHvBEPtIi8jgTsnsgNFaH1zT97snZDIjVNfFeosPdNjxdJt15s3r2e
    no0Cb6Rxg5mlVJdp0TPJxuQROpe8KJSOK8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:mime-version
    :content-type:subject:sender:list-id; s=fm2; t=1524186191; bh=nW
    uYcAUavRlZ1F0emlQ1ktVJRyJEPl0AHp5ND5pA/2g=; b=Jn9MRSb9+r6FF4sv/d
    P1Z7oBn/wBIcU6V5iRN/MQFFdIK4ON+s0L/YGMApWzX13gzzVYDRtE4Jngu3D8pf
    A3lNiTLXYRXKsrflYHaDKGK3xuzBPqy0jtUEPnCEiHYesxUgah6eBnylaHV6urq4
    yUl/d8RWwpb8fGkZrDFnlOFOF2JqKBBrjuuAe7ZP5LbGRQouWZn+I27ZbVR7ucK5
    clHvnQdlwEfT8e/NFIiaeNTncsY9js+4LN9sHqmlAA51//C2sWgRKB2FnWrxkuBB
    l7PjiCeTWodQJFsKGrzLv2sLUOgKZTdvlsqCgU/PNgm/FFUTHV4GZ8NmZifgg96y
    8hzQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMdSB6rwOw0E2BSuKR54N5S9Ns/Lw8McMJTyHjtuS1RD6ZfG6dPScH8yu7QAGTSgnBONnlhSYP716J9iagNakWZ8IUhQoawES2lhe+ukFJMuyx54/2mY
    Vyl8Ui7cewy087LJm6fs+7Eh369qOFD9n8ftr+JodhBW2VtOMXrR7PnT0JHwX5AsXmlUs/33u7iMM2yrAtfxgdRHdidKPYCNj2d9a9JIXVTmP6Sv9EarvCAC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=OgIaEnzjoAqxzlYqlrQA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeDTBCz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 21:02:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44297 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBCx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 21:02:53 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: <linux-arch@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        David Miller <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Vincent Chen <vincentc@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Kumar Gala <kumar.gala@freescale.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>
Date: Thu, 19 Apr 2018 20:01:16 -0500
Message-ID: <878t9ilmhv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9KRk-0002fH-Ok;;;mid=<878t9ilmhv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19kr8xV2lZ6TeKYZurv3Ni0z0sjREifY8g=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,XMNoVowels autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;<linux-arch@vger.kernel.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1391 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.2%), b_tie_ro: 1.91 (0.1%), parse: 0.73 (0.1%),
        extract_message_metadata: 4.3 (0.3%), get_uri_detail_list: 2.7 (0.2%),
        tests_pri_-1000: 4.5 (0.3%), tests_pri_-950: 1.21 (0.1%), tests_pri_-900:
        1.02 (0.1%), tests_pri_-400: 34 (2.5%), check_bayes: 33 (2.4%), b_tokenize:
        13 (1.0%), b_tok_get_all: 11 (0.8%), b_comp_prob: 2.5 (0.2%),
        b_tok_touch_all: 4.2 (0.3%), b_finish: 0.65 (0.0%), tests_pri_0: 1331 (95.7%),
         check_dkim_signature: 0.51 (0.0%), check_dkim_adsp: 2.4 (0.2%),
        tests_pri_500: 4.0 (0.3%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 00/17] siginfo bugfixes and cleanups
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Mostly this dealing with aliases of SI_USER, that make it impossible for
userspace to tell what kind of siginfo it has received.

Also in this series is the change to ensure we have siginfo initialized
so I can rip out the switch in copy_siginfo_to_user for better
performance, and to ensure better backwards compatibility as siginfo as
generated in the callers is passed to userspace.

There are also fixes for a few other siginfo bugs I have found.

There are cleanups of ifdefs on SEGV_BNDERR and BUS_MCERR_AX that are no
longer necessary.

I plan to merge these bug fixes through my siginfo tree, but if you
object to them or would prefer to have them go through your arch tree
please let me know.

The changes are avaiable as a totality at:
    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-review
    
Dmitry V. Levin (1):
      sparc: fix compat siginfo ABI regression

Eric W. Biederman (16):
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

 arch/alpha/include/uapi/asm/siginfo.h     |  14 ----
 arch/alpha/kernel/osf_sys.c               |   3 +-
 arch/alpha/kernel/signal.c                |   2 +
 arch/alpha/kernel/traps.c                 |  11 ++-
 arch/alpha/mm/fault.c                     |   2 +
 arch/arc/mm/fault.c                       |   2 +
 arch/arm/kernel/ptrace.c                  |   1 +
 arch/arm/kernel/swp_emulate.c             |   1 +
 arch/arm/kernel/traps.c                   |   5 ++
 arch/arm/mm/alignment.c                   |   1 +
 arch/arm/mm/fault.c                       |   4 +
 arch/arm/vfp/vfpmodule.c                  |   3 +-
 arch/arm64/kernel/fpsimd.c                |   2 +-
 arch/arm64/kernel/sys_compat.c            |   1 +
 arch/arm64/kernel/traps.c                 |   1 +
 arch/arm64/mm/fault.c                     |  18 +++--
 arch/c6x/kernel/traps.c                   |   1 +
 arch/hexagon/kernel/traps.c               |   1 +
 arch/hexagon/mm/vm_fault.c                |   1 +
 arch/ia64/include/uapi/asm/siginfo.h      |   7 --
 arch/ia64/kernel/brl_emu.c                |   1 +
 arch/ia64/kernel/signal.c                 |   2 +
 arch/ia64/kernel/traps.c                  |  31 ++++++--
 arch/ia64/kernel/unaligned.c              |   1 +
 arch/ia64/mm/fault.c                      |   4 +-
 arch/m68k/kernel/traps.c                  |   2 +
 arch/microblaze/kernel/exceptions.c       |   1 +
 arch/microblaze/mm/fault.c                |   4 +-
 arch/mips/mm/fault.c                      |   1 +
 arch/nds32/kernel/traps.c                 |  19 ++---
 arch/nds32/mm/fault.c                     |   1 +
 arch/nios2/kernel/traps.c                 |   1 +
 arch/openrisc/kernel/traps.c              |   5 +-
 arch/openrisc/mm/fault.c                  |   1 +
 arch/parisc/kernel/ptrace.c               |   1 +
 arch/parisc/kernel/traps.c                |   2 +
 arch/parisc/kernel/unaligned.c            |   1 +
 arch/parisc/math-emu/driver.c             |   1 +
 arch/parisc/mm/fault.c                    |   1 +
 arch/powerpc/include/uapi/asm/siginfo.h   |  15 ----
 arch/powerpc/kernel/process.c             |   1 +
 arch/powerpc/kernel/traps.c               |  13 ++--
 arch/powerpc/mm/fault.c                   |   1 +
 arch/powerpc/platforms/cell/spufs/fault.c |   2 +-
 arch/riscv/kernel/traps.c                 |   1 +
 arch/s390/kernel/traps.c                  |   5 +-
 arch/s390/mm/fault.c                      |   2 +
 arch/sh/kernel/hw_breakpoint.c            |   9 +--
 arch/sh/kernel/traps_32.c                 |   2 +
 arch/sh/math-emu/math.c                   |   1 +
 arch/sh/mm/fault.c                        |   1 +
 arch/sparc/include/uapi/asm/siginfo.h     |   7 --
 arch/sparc/kernel/process_64.c            |   1 +
 arch/sparc/kernel/sys_sparc_32.c          |   1 +
 arch/sparc/kernel/traps_32.c              |  12 ++-
 arch/sparc/kernel/traps_64.c              |  16 +++-
 arch/sparc/kernel/unaligned_32.c          |   1 +
 arch/sparc/mm/fault_32.c                  |   1 +
 arch/sparc/mm/fault_64.c                  |   1 +
 arch/um/kernel/trap.c                     |   2 +
 arch/unicore32/kernel/fpu-ucf64.c         |   8 +-
 arch/unicore32/mm/fault.c                 |   3 +
 arch/x86/entry/vsyscall/vsyscall_64.c     |   2 +-
 arch/x86/kernel/ptrace.c                  |   2 +-
 arch/x86/kernel/signal_compat.c           |   2 +-
 arch/x86/kernel/traps.c                   |   3 +
 arch/x86/kernel/umip.c                    |   1 +
 arch/x86/kvm/mmu.c                        |   1 +
 arch/x86/mm/fault.c                       |   1 +
 arch/xtensa/kernel/traps.c                |   1 +
 arch/xtensa/mm/fault.c                    |   1 +
 fs/signalfd.c                             |  15 +---
 include/linux/ptrace.h                    |   1 -
 include/linux/tracehook.h                 |   1 +
 include/uapi/asm-generic/siginfo.h        |   3 +-
 kernel/signal.c                           | 123 +++---------------------------
 virt/kvm/arm/mmu.c                        |   1 +
 77 files changed, 194 insertions(+), 231 deletions(-)


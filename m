Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1371436-1528085493-2-14960939804716487064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528085493; b=Ez9oJtzHyNg5OaOgS9Hg24MZHqHKfFVkKRDQcD27RDDrgrG2n6
    0AJXv7OEY6VWuXQ1JZC8xFGBgDd0dASsk3sAFO3KhvFFwjxqi7KAiKlcMl+QoFOr
    3S2YGm/ykxBNU6R/JYwvFPzZ6NIIWoPWiXZ+Q6QIcyRdd931cZp6AnA26Ifyj8oV
    aPdDXyqmPRSzRZfNHYMho7YxsufJoXy7KGKFA7H5iTTANWcKZVNkrqmi0IB5uHGG
    2KK0QTy15k8TyFwZXiDugxv7e8HiS2BqNz+ZNx8T8eXUFbA0MVg5dpBpTGehnr4a
    DMbLPEVDRoQ/BhDzW109bpf3ZnLp8956fEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:mime-version
    :content-type:subject:sender:list-id; s=fm2; t=1528085493; bh=/5
    1x5TFL09tVuHTV044LMBonQLp15gS9XtfM/3Oczh8=; b=UGmmPI/Wk5WCHckfWt
    lDCv1kpBWiwY3pDdyLx8a6p0mHOsOAzlw5tRHGcakESaCMmsQ5CY8dFFH0gEPFvs
    /ePYGSS9zcEBQRcA2u8HcCVh3KKuFLn5oiWz+mMBAWOe4OawYstDc/FU161Akfp8
    hEiq5qgTzwQD5qX+M2173T/c4tHSGNaYbOzf1PB6NLS8UtGrnImxq0BdwRMchT5N
    LUKAEPf8RWTHLiBxdStW1FbcWgn8qS3hRFlxvk/VJzJfRb5iSydWaZuKpgOG/UQb
    DW+R3N0gEr0aBMIIDWxXadpPDKQrbZ3GRL+t6IOpqQhzp2LqESXFiffsfplLixzw
    rq7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfGCIWW3FLblyAmKr/WeQ4k4wETJ6899xupJKNb0/BdcCG3VYBgVvcLmSSaEXcWs5v+rTDOupH4mAMo15bL/vsZNe1FwfVkyJxl5QnRi/Te33g3b798KD
    aQhTbNiOUwemnhalv8TvTHBw+fYJY9CEXEzejJZOGUo9aIiDuzEnbIwuW7ZKEi7TSZAodp8pwIoRy2NzflEOwk2oSZcr3Hz5HUoRo8BPA+TE3q83cjJtAlDM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=7mUfYlMuFuIA:10 a=VwQbUJbxAAAA:8
    a=qtaS9w6v_ahccI3MblIA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbeFDELb (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 00:11:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55491 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDELa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2018 00:11:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
Date: Sun, 03 Jun 2018 23:11:22 -0500
Message-ID: <87o9grmbrp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fPgq8-0006Rf-OZ;;;mid=<87o9grmbrp.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Cp8DsJPfndgtiq7eShDSdv+nckXbUp1o=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 707 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 2.9 (0.4%), b_tie_ro: 1.96 (0.3%), parse: 1.20 (0.2%),
        extract_message_metadata: 13 (1.8%), get_uri_detail_list: 4.6 (0.6%),
        tests_pri_-1000: 8 (1.1%), tests_pri_-950: 2.4 (0.3%), tests_pri_-900: 1.96
        (0.3%), tests_pri_-400: 37 (5.3%), check_bayes: 35 (4.9%), b_tokenize: 15
        (2.1%), b_tok_get_all: 8 (1.2%), b_comp_prob: 4.5 (0.6%), b_tok_touch_all:
        2.6 (0.4%), b_finish: 0.94 (0.1%), tests_pri_0: 606 (85.7%),
        check_dkim_signature: 1.07 (0.2%), check_dkim_adsp: 6 (0.8%), tests_pri_500:
        11 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] siginfo work for v4.18-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 26da35010c6d6ce317d511c8186585bdd8ab6629 signal/sh: Stop gcc warning about an impossible case in do_divide_error

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

Eric

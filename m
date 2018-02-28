Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3238909-1519790710-2-3165331631851370885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790710; b=pDcWBYpxhChRuEh82K3DSkcdLt02A5pKOItaw0kXmFhCTWB
    kte+Ic9DTMgrEASGLPyhn5s77uC/p0CYDaZbBy719DA8dB19lPQtnPMoOljxZzPi
    Bz93DD5q1lQC7mGF7qYXM0bAt4yMsIZ9QDhoyygHWYD8fY0Ax9M62e37WYrQsmD8
    2ldTd9BaJUyEc/g870rJST63nLzHmoR45PZcLPJ2V1GZtsqEqsQXrw/VeRskZp/R
    bgG3IZ6ll1OmU/cW/dzXUiOHcAfaqwNdm5sYm+rJPeUxkeBxsHQicun2bzy2P9jI
    HFtrwzdrKu//hj4RQaXaqoBBszt0Z9Mp35DdF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:sender
    :list-id; s=arctest; t=1519790710; bh=352MJLKQ7mG8rhi/+YuHGHKUNW
    yxcg+lpOIfqGz9hWc=; b=dStRTuScoG1MBzfUhKD1XPRoT66JbggY4pYniMUeBp
    4EEWupbrmd8SwCNDTY2lLkT+DyXqSVnr1OwwhYqOwTnl3m8ei4hmSmlYeOj1nsoF
    GmnXYNvlH75JH6xOeXFoGis3gN3UtYjwaxZ9a/8VT2llSlOHBttptEq75rC0eQsj
    txV/QxPJXAw3E9xG4PVrbh2qtRuZzHT1ow6UXARTYDHVJJPAz6ZGcc4Vmqn9QVfD
    n6SwenadXvmcNCkLwD46Y+VOGeNlzHoOWwXlyHC07Y+3hpanqb3AvXcJ9LBYaPs3
    7NJyes55pZLynwARTrqCNshzHDsqGWd2Njn7srqaYjvA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZO9UmQtb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eVtVULCY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ZO9UmQtb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eVtVULCY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeB1D53 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:57:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37439 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB1D52 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:57:28 -0500
X-Google-Smtp-Source: AH8x225eCnibXrXrZQHbeMcUYyomXSKkDWeGvu9v4eXp9nmstV4rD2cVSCFEnhv0BVcRyYnTAnGKQg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9 
Date: Wed, 28 Feb 2018 11:56:22 +0800
Message-Id: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

This backport patchset fixed the meltdown issue, it's original branch:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
A few dependency or fixingpatches are also picked up, if they are necessary
 and no functional changes.

The patchset also on repository:
	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 

No bug found yet from kernelci.org and lkft testing.

Any comments are appreciated!

Regards
Alex

---
AKASHI Takahiro (1):
      module: extend 'rodata=off' boot cmdline parameter to module mappings

Jayachandran C (2):
      arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      arm64: Turn on KPTI only on CPUs that need it

Marc Zyngier (2):
      arm64: Allow checking of a CPU-local erratum
      arm64: Force KPTI to be disabled on Cavium ThunderX

Mark Rutland (1):
      arm64: factor out entry stack manipulation

Suzuki K Poulose (1):
      arm64: capabilities: Handle duplicate entries for a capability

Will Deacon (21):
      arm64: mm: Use non-global mappings for kernel space
      arm64: mm: Move ASID from TTBR0 to TTBR1
      arm64: mm: Allocate ASIDs in pairs
      arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      arm64: entry: Add exception trampoline page for exceptions from EL0
      arm64: mm: Map entry trampoline into trampoline and kernel page tables
      arm64: entry: Explicitly pass exception level to kernel_ventry macro
      arm64: entry: Hook up entry trampoline to exception vectors
      arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
      arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      arm64: kaslr: Put kernel vectors address in separate data page
      arm64: use RET instruction for exiting the trampoline
      arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      arm64: Take into account ID_AA64PFR0_EL1.CSV3
      arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
      arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      arm64: entry: Reword comment about post_ttbr_update_workaround
      arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

Xie XiuQi (1):
      arm64: entry.S: move SError handling into a C function for future expansion

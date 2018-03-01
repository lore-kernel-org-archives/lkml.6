Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2993705-1519909705-5-4219235256299920807
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
    t=1519909704; b=JC33s+tmKBAamPIgsNeOF0nlp006MD5ZUZ735NBoKIZ2mbV
    I8JEcz/L8VPYxV8GWigYQzh7730jyClMNzqgpc26gHpFYqTOjvytpvK/AaXSgx3G
    Mkr2qqFIzi3ITrp+IQUoznCivOa3vuHCw59790mcgF0hE+9vVeu11KC5YFwEOxxr
    5dKJl6wOb8N4A7gyTgoRtHrxjYR3/g31LDp5LupmJqS3dT2kapLu0MFgHxlJ57y1
    dZRGf77AQoTOBVlPOIo1rSnBfZPHIubxHNB5z+u1zm6trvmJ5RoUH21ojc+5GbvD
    Z+kiwg+3JUO9PODqy60rkQvDmVyl1ThsgA+Ry8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:sender
    :list-id; s=arctest; t=1519909704; bh=mitfTljWIPDyOANkhOaMnkqv3T
    v0lfyZA+SaI0FwpK8=; b=k9itdYhJNH4482/Lo2w1/+JPTE6Lec7k7KsWAQLHwE
    j728+Z/MOyPjZY7mcqMosd0A3jTEKjj2Sni/YmynaAJWwglm0WuP0GAS35ufGGTE
    HO7ywJ6l9GTv7p11092JR2mLTyBQ0XWcRD5edSfNNc3GT51AhowrX/sVZBSKpa+o
    oFsLvwvzOOhfvw+cyqYf/LPuUw5GBbLUSIchWpkLbYUzMG9uBxCc5ZoJeINvAoMM
    tYcWcZ5Ux2sHMCkkVlskF+KLecGiMOnxWck0ewEKK58poKFCs0/B6Qq9Ez/cBpmj
    DwpOI2KXFA1fbf/S2aG4p5utFNxYSydoTpA3wu1gr5FA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UrY7ovEm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T8GkCC4e;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=UrY7ovEm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T8GkCC4e;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030512AbeCAMzJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:55:09 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38455 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030492AbeCAMzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:55:07 -0500
X-Google-Smtp-Source: AG47ELvv/63RG9qOHIMkh5YXafAHK9b4kO/4iAzuo1iYLw4hub4P/Rbsg9PwCwx1wtq79lWnbZ/5/w==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Date: Thu,  1 Mar 2018 20:53:37 +0800
Message-Id: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Resent without non-upstream patches.

This backport patchset fixed the spectre issue, it's original branch:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
A few dependency or fixingpatches are also picked up, if they are necessary
 and no functional changes.

No bug found from kernelci.org and lkft testing. It also could be gotten from:

git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only

Comments are appreciated!

Regards
Alex


[PATCH 01/45] mm: Introduce lm_alias
[PATCH 02/45] arm64: alternatives: apply boot time fixups via the
[PATCH 03/45] arm64: barrier: Add CSDB macros to control data-value
[PATCH 04/45] arm64: Implement array_index_mask_nospec()
[PATCH 05/45] arm64: move TASK_* definitions to <asm/processor.h>
[PATCH 06/45] arm64: Factor out PAN enabling/disabling into separate
[PATCH 07/45] arm64: Factor out TTBR0_EL1 post-update workaround into
[PATCH 08/45] arm64: uaccess: consistently check object sizes
[PATCH 09/45] arm64: Make USER_DS an inclusive limit
[PATCH 10/45] arm64: Use pointer masking to limit uaccess speculation
[PATCH 11/45] arm64: syscallno is secretly an int, make it official
[PATCH 12/45] arm64: entry: Ensure branch through syscall table is
[PATCH 13/45] arm64: uaccess: Prevent speculative use of the current
[PATCH 14/45] arm64: uaccess: Don't bother eliding access_ok checks
[PATCH 15/45] arm64: uaccess: Mask __user pointers for __arch_{clear,
[PATCH 16/45] arm64: futex: Mask __user pointers prior to dereference
[PATCH 17/45] drivers/firmware: Expose psci_get_version through
[PATCH 18/45] arm64: cpufeature: __this_cpu_has_cap() shouldn't stop
[PATCH 19/45] arm64: cpu_errata: Allow an erratum to be match for all
[PATCH 20/45] arm64: Run enable method for errata work arounds on
[PATCH 21/45] arm64: cpufeature: Pass capability structure to
[PATCH 22/45] arm64: Move post_ttbr_update_workaround to C code
[PATCH 23/45] arm64: Add skeleton to harden the branch predictor
[PATCH 24/45] arm64: Move BP hardening to check_and_switch_context
[PATCH 25/45] arm64: KVM: Use per-CPU vector when BP hardening is
[PATCH 26/45] arm64: entry: Apply BP hardening for high-priority
[PATCH 27/45] arm64: entry: Apply BP hardening for suspicious
[PATCH 28/45] arm64: cputype: Add missing MIDR values for Cortex-A72
[PATCH 29/45] arm64: Implement branch predictor hardening for
[PATCH 30/45] arm64: KVM: Increment PC after handling an SMC trap
[PATCH 31/45] arm/arm64: KVM: Consolidate the PSCI include files
[PATCH 32/45] arm/arm64: KVM: Add PSCI_VERSION helper
[PATCH 33/45] arm/arm64: KVM: Add smccc accessors to PSCI code
[PATCH 34/45] arm/arm64: KVM: Implement PSCI 1.0 support
[PATCH 35/45] arm/arm64: KVM: Advertise SMCCC v1.1
[PATCH 36/45] arm64: KVM: Make PSCI_VERSION a fast path
[PATCH 37/45] arm/arm64: KVM: Turn kvm_psci_version into a static
[PATCH 38/45] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening
[PATCH 39/45] arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
[PATCH 40/45] firmware/psci: Expose PSCI conduit
[PATCH 41/45] firmware/psci: Expose SMCCC version through psci_ops
[PATCH 42/45] arm/arm64: smccc: Make function identifiers an unsigned
[PATCH 43/45] arm/arm64: smccc: Implement SMCCC v1.1 inline primitive
[PATCH 44/45] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening
[PATCH 45/45] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

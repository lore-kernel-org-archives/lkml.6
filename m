Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1547173-1528102409-2-2360477341970041371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528102408; b=chTEGNhJEOU2ZCKIUAEHASLQbL8T4/vq1DL4Lk831fdy//XR/g
    07905H62T06JSWxWR7FX2izGYmIAXeoolEvDQDMVY/A3tUSC3nTs2g33NbqHyq0V
    J9mMev6Om9LXn9IKlBh+fnUgCJBwwlpqCDgvwDC10xH/eVN7bJWAns3C+SA0O835
    JyBn3T/ikI4umM9XYY9yyNpZ8Gmf02FNDFQt/NeYYPWsm1EcVwKirVjH0ARo7wFs
    xW2mS2tplqqgnGSfv/iuxIiTmShTA9HK3Aq1j/PkEjvIsajCe8yoqHqJZVWqhH63
    5H2AHNIe/gbK6tBknrr/vFCzU7ivV7O6Y7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1528102408;
    bh=Uv7W8ak65Les30jd84UkWPHjv2L0fNMDh5ZLD+3jvPs=; b=mLvD1Ji4h3rE
    qg8RTchWPPVjDfVDW9stcQhT+LVYBBxEx42oKoOTcG6H32D0A6ZB5HfmsKmx20KF
    luCnMFMInEnUfFFQOnGFbKGHk6lDEKmRYLLhO0+Z9ChPFlKStL/A3ZwGaRK3CASL
    5qWOYzqfuCG+kkkVZkuYFumUKSivk9XmeI9juH5r4lIT1jSKMlgI/d4TYfRttyRB
    kj1kQKtrLCNGnwVXxlYlf3QYaNJYDBoRBtfeAv5FSwdLDwW7GAkyc1PYNceGWoYt
    EwZPSn0QKAn9TTbAcT/JAyjvKfqHHtQfH9M1Spqww8sLjOeNdWHxvbOzoJ5DL+Q9
    UlJ14UHYYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=PcXxkZPG
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=DHUBxM5o;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=PcXxkZPG
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=DHUBxM5o;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZRtfr983SS7o4AxAGBZhNZ1gwzV0x9XccMoOc0Z8fpYaYHPLtdd+K7/VUlwQrq4AnQh3l6eoLbXZZg97VpmUIHIkQNNbBq3RX15EtOfaPJZiM3tEcy
    8lub2ng9bRoumFU4C3xGj7QBN+y29X2FcmxQYzasqs78c0N31GVm1+NkjOeyR68E4HjYS4k4h+f5n0dw2yBBBtFqh/ze5+TN8iKIrvfyWMYoFGauu/9G5VST
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=__ed2mWFdbC1Szw74tAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeFDIx0 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 04:53:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55071 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbeFDIxZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Jun 2018 04:53:25 -0400
X-Google-Smtp-Source: ADUXVKKhH83IYtf/hltbi0M5J/x29brr+pqFYBn1Av8bS9IyiGsMEmBT3vV6huBLK0hhtqMidDE0bQ==
Date: Mon, 4 Jun 2018 10:53:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI changes for v4.18
Message-ID: <20180604085321.GA13825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: 83f0a7c7b265a56d757f7e3a80622e5b0b7ebc46 efi/capsule-loader: Don't output reset log when reset flags are not set

The main EFI changes in this cycle were:

 - Decode x86 CPER data (Yazen Ghannam)

 - Ignore unrealistically large option ROMs (Hans de Goede)

 - Initialize UEFI secure boot state during Xen dom0 boot (Daniel Kiper)

 - Additional minor tweaks and fixes.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      efi: Align efi_pci_io_protocol typedefs to type naming convention
      efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function

Borislav Petkov (1):
      efi/cper: Remove the INDENT_SP silliness

Daniel Kiper (1):
      x86/xen/efi: Initialize UEFI secure boot state during dom0 boot

Hans de Goede (1):
      efi/x86: Ignore unrealistically large option ROMs

Shunyong Yang (1):
      efi/capsule-loader: Don't output reset log when reset flags are not set

Wei Yongjun (1):
      efi/libstub/tpm: Make function efi_retrieve_tpm2_eventlog_1_2() static

Yazen Ghannam (8):
      efi: Fix IA32/X64 Processor Error Record definition
      efi: Decode IA32/X64 Processor Error Section
      efi: Decode IA32/X64 Processor Error Info Structure
      efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
      efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
      efi: Decode additional IA32/X64 Bus Check fields
      efi: Decode IA32/X64 MS Check structure
      efi: Decode IA32/X64 Context Info structure


 arch/x86/boot/compressed/eboot.c          | 114 +++-------
 arch/x86/xen/efi.c                        |  57 +++++
 drivers/firmware/efi/Kconfig              |   5 +
 drivers/firmware/efi/Makefile             |   1 +
 drivers/firmware/efi/capsule-loader.c     |  14 +-
 drivers/firmware/efi/cper-arm.c           |   6 +-
 drivers/firmware/efi/cper-x86.c           | 356 ++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c               |  16 +-
 drivers/firmware/efi/libstub/secureboot.c |   3 +
 drivers/firmware/efi/libstub/tpm.c        |   2 +-
 include/linux/cper.h                      |   4 +-
 include/linux/efi.h                       |   6 +-
 12 files changed, 485 insertions(+), 99 deletions(-)
 create mode 100644 drivers/firmware/efi/cper-x86.c


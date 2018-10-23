Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB0AC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668B620813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FojsbSK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668B620813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbeJWSap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:30:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32847 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeJWSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:30:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so1021369wrn.0;
        Tue, 23 Oct 2018 03:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=26Vb9+lKFT25gT2x0m/sJ5udB8pdQWXnC33wJOF1OTk=;
        b=FojsbSK+CR+yNq2NrhL+v8WIDudbv4p6zr2rHkBoi8eNG0e8Rb8zN/NIvVjPm27ng3
         un0j4Ysq4F3aCwQRjd0pgG6C8xokJTGlN+Emhti8/wFzKgQ6XYswOed0ymQ8mwxxZ7+t
         EAao0CV9D9mRTF85K9WtEDb4xPMbgozEcEcY9QTEPhAZTV7Aj3nzuVmJmo//NPYy9gaL
         6b7vmB8PmjGBIsMV98gRhijvXsSWrqAfdwsJOxWezaNkVOcYnxCrKTQayGny2XlruwEQ
         ZZTpQeK0bRPmX4OigWb1AST+QuiVe7rV+0HY91EZosFdTl9mhl2jhyKlVnOw0ZMfWd4T
         AOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=26Vb9+lKFT25gT2x0m/sJ5udB8pdQWXnC33wJOF1OTk=;
        b=EG4/3d1OXI2TmiyGcl2t2WAAIolwVrkhX7Gihc5J0IQqCZnXwQYa86hrKc4WEQm5pV
         YoHmQszmbukEyhDSxVUUD0oZGCEwbf1Q6QV5AsvMQt6x3hORE/ct3pdLWUyULMNFxM1m
         W8AXIAB5Owz4VsYtMPV4lThLrdCOZ/NyPxdG01wBCX5VmiaIUL3/LwjqSE2+TMXJK03j
         f/g7AYFEZLfTl/PfzzkHSIfz+YgnhAIg+xyBTlScg6taaxfutC6Q4i0QPgFQHW0MvoXt
         UoxD69HTBb/N9L9tCdlsonuG7pJoaD+EQLGI1ZXz17e7DSxftoj4tfSxXnY72dR41cZz
         MHjQ==
X-Gm-Message-State: ABuFfojUgPSWWS1bDfZhc8OxWD+q+OmwMOu9PjlGMn17Zu56Ub2qw7u9
        eulqAacecUKQDruG7diuyTE=
X-Google-Smtp-Source: ACcGV60C9bc7XZlXJAUDSc433KlwBX+stTiG2AAxNnyvaqxSKGYplkhOpBD+VnemUWVZxpUFVz9QxA==
X-Received: by 2002:adf:f44b:: with SMTP id f11-v6mr48187122wrp.305.1540289279745;
        Tue, 23 Oct 2018 03:07:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 63-v6sm872510wmd.5.2018.10.23.03.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:07:59 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:07:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI changes for v4.20
Message-ID: <20181023100756.GA10989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: fa70f0d2ce96a892b38fbbaa60584af536f21f97 Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

The main changes are:

 - Add support for enlisting the help of the EFI firmware to create 
   memory reservations that persist across kexec.

 - Add page fault handling to the runtime services support code on x86 so
   we can more gracefully recover from buggy EFI firmware.

 - Fix command line handling on x86 for the boot path that omits the stub's
   PE/COFF entry point.

 - Other assorted fixes and updates.

 Thanks,

	Ingo

------------------>
Aaron Ma (1):
      efi/x86: earlyprintk - Add 64bit efi fb address support

Alistair Strachan (1):
      efi/libstub: arm: support building with clang

Ard Biesheuvel (3):
      efi: honour memory reservations passed via a linux specific config table
      efi/arm: libstub: add a root memreserve config table
      efi: add API to reserve memory persistently across kexec reboot

Ben Hutchings (1):
      x86: boot: Fix EFI stub alignment

Hans de Goede (1):
      efi/x86: Call efi_parse_options() from efi_main()

Ivan Hu (1):
      efi/efi_test: add exporting ResetSystem runtime service

Sai Praneeth (2):
      efi: Make efi_rts_work accessible to efi page fault handler
      efi/x86: Handle page faults occurring while running EFI runtime services

Sebastian Andrzej Siewior (1):
      efi/x86: drop task_lock() from efi_switch_mm()


 arch/x86/boot/compressed/eboot.c        | 10 +++++
 arch/x86/boot/tools/build.c             |  7 +++
 arch/x86/include/asm/efi.h              |  1 +
 arch/x86/mm/fault.c                     |  9 ++++
 arch/x86/platform/efi/early_printk.c    |  8 +++-
 arch/x86/platform/efi/efi_64.c          | 10 ++---
 arch/x86/platform/efi/quirks.c          | 78 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c              | 59 ++++++++++++++++++++++++-
 drivers/firmware/efi/libstub/Makefile   |  3 +-
 drivers/firmware/efi/libstub/arm-stub.c | 27 ++++++++++++
 drivers/firmware/efi/runtime-wrappers.c | 61 +++++++-------------------
 drivers/firmware/efi/test/efi_test.c    | 27 ++++++++++++
 drivers/firmware/efi/test/efi_test.h    | 10 +++++
 include/linux/efi.h                     | 51 +++++++++++++++++++++
 14 files changed, 307 insertions(+), 54 deletions(-)


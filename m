Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D0C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1F321848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545690099;
	bh=W/sRk1LcIEpn+Jjej0v1hOh2w7lKmQB6r/2JSx9/ti0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=tPvCiYXjL++7xFoqQ30yiniQ3OH7m1GyiMkOuy4kceqXnIIX6rn7jWectrYOHhitk
	 FplGg4d4hCCdGUPgwlNfGmaUR1WKe1rvlhWh9djkA0TEtjC48LRt+VGSCCbzdEgNoE
	 PHewPZ2cEPD27/8XY+B27LPFkAK9YiNeDgnoKKdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLXWVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:21:38 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38666 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLXWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:21:38 -0500
Received: by mail-wr1-f53.google.com with SMTP id v13so12568989wrw.5;
        Mon, 24 Dec 2018 14:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7S0B0UpJjS1Sfs05cPeIn5cD45ZB/trnsaR1hTt5XDY=;
        b=GsglTbC1BG42GM/kzOlCZqFZDNrhYK+qM/zVSZWrcBHg/czJUEvk8ZihxmzcLNqoRd
         wbfqWmFkppZcliXimwYuPyGG+mxa2LK34YuZAcSKAUXFOYWLeEmHqNctwmATkCyLBM01
         DM4GhMk4EKf1u9/XG4C6d3sDeedRps/ucBK/DWosAp+8Dmag/fsEH2hpYJokRCK8+FAA
         rdNMtqcYmnZ86SXn4MtF1kBI7APYWJcvr8Fz/Q1zO/E7CFbjPJYqDqSVy76APlLtCHzg
         jGC5nYsSv0c1dlLbPpM8gmJMplCiW2VEv+QKD5LCHBvesZPYQTZOdWfVO29/EJgUH+Y/
         OTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7S0B0UpJjS1Sfs05cPeIn5cD45ZB/trnsaR1hTt5XDY=;
        b=kSNfmfMALrNV+O6MgPYBMsPxM44snWD6AozfzDPo8X9JyV+ieDCfdrQNkInNebp5G1
         F1mSdUJYOXk6kNpAmh6Duv+tFJbad8Zd/IFQkE2FQLbclobYUjujU4kZzn5lSkUQPoRv
         t4CFysjUjYxDnMX0I+hTMKeOq4iqthHWndLX2AH/dFEJnX0UvM2FxkDIvGcRiHTt/wSd
         aEYRFRy23GxQ/vq85+CUw4/NAII/oBRVjf3Wp3vadtMsKVVo2+t36o2jomupNDI29AJi
         DUqEF2iVkPg691XWMKZ/ny/gYVLfOn4gyrMX7j+Z1fSVTR2t3jHkMqEJjQfqQJTlXfSt
         2v5g==
X-Gm-Message-State: AJcUukeIka/vLnaFSMwwa/+7v8JSqkic63l9IfZITALuV2Wce7kWdCaP
        +OC/RnSNDObr52QRf9UEgbg=
X-Google-Smtp-Source: ALg8bN7l2q3wx/fcw2gQNd0AblxCkxtrlhu8UB4WN2rciiNgNZvo3krQulcFFtmkRL0PYMOTjvTMEQ==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr12349462wrl.137.1545690095471;
        Mon, 24 Dec 2018 14:21:35 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 133sm14093088wme.9.2018.12.24.14.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:21:34 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:21:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] EFI changes for v4.21
Message-ID: <20181224222132.GA109386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: 1debf0958fa27b7c469dbf22754929ec59a7c0e7 x86/efi: Don't unmap EFI boot services code/data regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE

The main changes in this cycle were:

  - Allocate the E820 buffer before doing the GetMemoryMap/ExitBootServices
    dance so we don't run out of space

  - Clear EFI boot services mappings when freeing the memory

  - Harden efivars against callers that invoke it on non-EFI boots 

  - Reduce the number of memblock reservations resulting from extensive
    use of the new efi_mem_reserve_persistent() API

  - Other assorted fixes and cleanups.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (2):
      efi: Permit multiple entries in persistent memreserve data structure
      efi: Reduce the amount of memblock reservations for persistent allocations

Arend van Spriel (1):
      firmware/efi: Add NULL pointer checks in efivars API functions

Julien Thierry (2):
      efi/fdt: Indentation fix
      efi/fdt: Simplify the get_fdt() flow

Nathan Chancellor (1):
      efi/libstub: Disable some warnings for x86{,_64}

Sai Praneeth Prakhya (4):
      x86/mm/pageattr: Introduce helper function to unmap EFI boot services
      x86/efi: Unmap EFI boot services code/data regions from efi_pgd
      x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86
      x86/efi: Don't unmap EFI boot services code/data regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE


 arch/x86/include/asm/efi.h              |  2 +
 arch/x86/include/asm/pgtable_types.h    |  8 ++-
 arch/x86/mm/pageattr.c                  | 40 ++++++++++++-
 arch/x86/platform/efi/efi.c             |  2 +
 arch/x86/platform/efi/quirks.c          | 41 ++++++++++++++
 drivers/firmware/efi/efi.c              | 54 +++++++++++++-----
 drivers/firmware/efi/libstub/Makefile   |  5 +-
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 drivers/firmware/efi/libstub/fdt.c      | 30 +++++-----
 drivers/firmware/efi/vars.c             | 99 ++++++++++++++++++++++++++-------
 include/linux/efi.h                     | 19 +++++--
 init/main.c                             |  4 --
 12 files changed, 242 insertions(+), 64 deletions(-)


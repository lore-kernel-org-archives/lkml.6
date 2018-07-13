Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACF42087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBpPuRje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeGMUNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:13:10 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39183 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbeGMUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:13:10 -0400
Received: by mail-wm0-f43.google.com with SMTP id h20-v6so10342151wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=To9b/A8gUUWCZx2Nndt48PTgRhYzZHayGaO8H+q4b+k=;
        b=qBpPuRjeWW64d4yeV4O6psE08G4rVlz1Y/42dj6ILiTLsfYBQarA3qNkXGPFFC5haM
         W8igBu3TiCd7VXnYRUOSh9BEYbviiTZDgikzsLu9cNU6tA92rs8LoIujs8ZofiVehlbU
         iBq42Wj4D2aBKxcIOax8vbZ2neSvkMPDhdvOgumHj11XMe/KTOI8VvUpnBD1y7z/Wqil
         fvERQ/rUWvkahHCXpn1tcYTzGYe1bAhhZaSysyZv2/R5ybFU1GbS4Qn4uMiLuInhGm+A
         kUDQas3RJNCeNEnmXZl7hpysVm3b9l6uehzBY4+GReOE5yuGPUDaW9DI3nN0e2poBY7I
         +sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=To9b/A8gUUWCZx2Nndt48PTgRhYzZHayGaO8H+q4b+k=;
        b=A0Wj2S+2iYFUfmmpk8rXAnv42Hb7+BTsM+VKHL4JFN0eLujzCMlIgBTkcFdGxTxq0j
         PIuOLqvAqhiSRoXN/tNKlz1kLPJklFEebuZEGqnjzumIZJsPIo28aYlMwi3dYctYVeB7
         3oKDVqahhYsgWANcV8vXkKPsIdRVy6RUN2Pj4WXIxOtBrAnUXZs7vTKwugT7fzYhee3v
         vNqMsakvKeWyHs3DnIThujLXZQwMKbR1e0aMaEgjP9Hydc6hNZXi+A9pZbM2AvT6AISk
         n6BzL+LQtCnzbq85z7dEumwhOHyUzQoZ1zYp7HIns+7jN8r3lh6S2GKZb3Bn03ZU3nPO
         dfzA==
X-Gm-Message-State: AOUpUlE3nDDqaRl6nCbipPPO6D+x0zTJqLh3qr85H5reDjptwb1E/ZCz
        y+QPeQNYQnyCdRSosp7PF5A=
X-Google-Smtp-Source: AAOMgpdGuDQr4IsQOZgGYz+0Oc1dWU7o9GysS4I+X5TxM8HIXc/Ccs1PMt17WcBTjNtAHvpURpsSSA==
X-Received: by 2002:a1c:5b88:: with SMTP id p130-v6mr4849145wmb.69.1531511825227;
        Fri, 13 Jul 2018 12:57:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q5-v6sm13847398wrs.87.2018.07.13.12.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 12:57:04 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:57:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [GIT PULL] EFI fix
Message-ID: <20180713195702.GA22962@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: e296701800f30d260a66f8aa1971b5b1bc3d2f81 efi/x86: Fix mixed mode reboot loop by removing pointless call to PciIo->Attributes()

Fix a UEFI mixed mode (64-bit kernel on 32-bit UEFI) reboot loop regression.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efi/x86: Fix mixed mode reboot loop by removing pointless call to PciIo->Attributes()


 arch/x86/boot/compressed/eboot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index e57665b4ba1c..e98522ea6f09 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -114,18 +114,12 @@ __setup_efi_pci(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	struct pci_setup_rom *rom = NULL;
 	efi_status_t status;
 	unsigned long size;
-	uint64_t attributes, romsize;
+	uint64_t romsize;
 	void *romimage;
 
-	status = efi_call_proto(efi_pci_io_protocol, attributes, pci,
-				EfiPciIoAttributeOperationGet, 0ULL,
-				&attributes);
-	if (status != EFI_SUCCESS)
-		return status;
-
 	/*
-	 * Some firmware images contain EFI function pointers at the place where the
-	 * romimage and romsize fields are supposed to be. Typically the EFI
+	 * Some firmware images contain EFI function pointers at the place where
+	 * the romimage and romsize fields are supposed to be. Typically the EFI
 	 * code is mapped at high addresses, translating to an unrealistically
 	 * large romsize. The UEFI spec limits the size of option ROMs to 16
 	 * MiB so we reject any ROMs over 16 MiB in size to catch this.

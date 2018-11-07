Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757EAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208CD20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208CD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbeKHCdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46454 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeKHCdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:43 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zGk3gUZMevgQ; Wed,  7 Nov 2018 18:02:29 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC97A1EC0291;
        Wed,  7 Nov 2018 18:02:28 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/16] x86/microcode/AMD: Improve container verification
Date:   Wed,  7 Nov 2018 18:02:02 +0100
Message-Id: <20181107170218.7596-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi all,

this is work which got started by Maciej a while ago. I have finally had
the time to redo all the ideas properly, split it in self-contained,
logical chunks and test it.

Reveiew and comments are appreciated.

Thx.

Borislav Petkov (11):
  x86/microcode/AMD: Move verify_patch_size() up in the file
  x86/microcode/AMD: Clean up per-family patch size checks
  x86/microcode/AMD: Cleanup verify_patch_size() more
  x86/microcode/AMD: Concentrate patch verification
  x86/microcode/AMD: Simplify patch family detection
  x86/microcode/AMD: Move patch family check to verify_patch()
  x86/microcode/AMD: Move chipset-specific check into verify_patch()
  x86/microcode/AMD: Change verify_patch()'s return value
  x86/microcode/AMD: Convert early parser to the new verification routines
  x86/microcode/AMD: Fix container size's type
  x86/microcode/AMD: Update copyright

Maciej S. Szmigiero (5):
  x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file leftover length
  x86/microcode/AMD: Add microcode container verification
  x86/microcode/AMD: Check microcode container data in the late loader
  x86/microcode/AMD: Convert CPU equivalence table variable into a struct
  x86/microcode/AMD: Check the equivalence table size when scanning it

 arch/x86/kernel/cpu/microcode/amd.c | 469 ++++++++++++++++++----------
 1 file changed, 307 insertions(+), 162 deletions(-)

-- 
2.19.1


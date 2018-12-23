Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D732184E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeLWMvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:51:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:57212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWMvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:51:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93580ACFA;
        Sun, 23 Dec 2018 12:51:38 +0000 (UTC)
Date:   Sun, 23 Dec 2018 13:51:38 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode updates for 4.21
Message-ID: <20181223125138.GB26860@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest x86-microcode-for-linus tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus


This update contains work started by Maciej to make the microcode
container verification more robust against all kinds of corruption and
also unify verification paths between early and late loading.

The result is a set of verification routines which validate the
microcode blobs before loading it on the CPU. In addition, the code is a
lot more streamlined and unified.

In the process, some of the aspects of patch handling and loading were
simplified.

All provided by Maciej S. Szmigiero and Borislav Petkov.

Thanks,
Boris.

------------------>

The following changes since commit 9ff01193a20d391e8dbce4403dd5ef87c7eaaca6:

  Linux 4.20-rc3 (2018-11-18 13:33:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-microcode-for-linus

for you to fetch changes up to 2ffcbce39ea1e355eed8c6527308624f366f1c58:

  x86/microcode/AMD: Update copyright (2018-11-19 10:55:12 +0100)

----------------------------------------------------------------
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

 arch/x86/kernel/cpu/microcode/amd.c | 470 +++++++++++++++++++++++-------------
 1 file changed, 308 insertions(+), 162 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

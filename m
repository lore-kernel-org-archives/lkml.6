Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6EEC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026D2184E
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 12:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbeLWMxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 07:53:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:57430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725868AbeLWMxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 07:53:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36D93ACFA;
        Sun, 23 Dec 2018 12:53:40 +0000 (UTC)
Date:   Sun, 23 Dec 2018 13:53:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 4.21
Message-ID: <20181223125339.GC26860@zn.tnic>
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

please pull the latest ras-core-for-linus tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

This time around we have a subsystem reorganization to offer, with the new
directory being

  arch/x86/kernel/cpu/mce/

and all compilation units' names streamlined under it.

Thanks,
Boris.

------------------>

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to 72a8f089c382c078f8c7c1c759cb726de80d4284:

  x86/mce: Restore MCE injector's module name (2018-12-19 00:04:36 +0100)

----------------------------------------------------------------
Borislav Petkov (3):
      x86/mce: Streamline MCE subsystem's naming
      x86/mce: Unify pr_* prefix
      x86/mce: Restore MCE injector's module name

 arch/x86/kernel/cpu/Makefile                                  |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/Makefile                  | 10 ++++++----
 arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c}           |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c}         |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c}              |  4 +---
 arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c              |  4 +---
 arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c}   |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c}     |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c}       |  2 +-
 arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} |  3 +++
 arch/x86/kernel/cpu/{mcheck => mce}/p5.c                      |  2 ++
 arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} |  2 +-
 arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c             |  2 ++
 arch/x86/kernel/cpu/{mcheck => mce}/threshold.c               |  2 ++
 arch/x86/kernel/cpu/{mcheck => mce}/winchip.c                 |  2 ++
 15 files changed, 26 insertions(+), 17 deletions(-)
 rename arch/x86/kernel/cpu/{mcheck => mce}/Makefile (61%)
 rename arch/x86/kernel/cpu/{mcheck/mce_amd.c => mce/amd.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-apei.c => mce/apei.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce.c => mce/core.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/dev-mcelog.c (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-genpool.c => mce/genpool.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-inject.c => mce/inject.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce_intel.c => mce/intel.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck/mce-internal.h => mce/internal.h} (98%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/p5.c (98%)
 rename arch/x86/kernel/cpu/{mcheck/mce-severity.c => mce/severity.c} (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/therm_throt.c (99%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/threshold.c (96%)
 rename arch/x86/kernel/cpu/{mcheck => mce}/winchip.c (97%)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)

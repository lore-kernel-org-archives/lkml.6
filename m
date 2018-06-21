Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42523219C1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42523219C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbeFUSGw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:06:52 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:36457 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:06:51 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 21 Jun 2018 18:06:38 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 21
 Jun 2018 11:06:38 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Thu, 21 Jun
 2018 11:06:38 -0700
Date:   Thu, 21 Jun 2018 11:06:38 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Tony Luck <tony.luck@gmail.com>,
        Mathieu Malaterre <malat@debian.org>, <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memblock: add missing include <linux/bootmem.h>
Message-ID: <20180621180638.ahxpgzwrztopve55@pburton-laptop>
References: <20180606194144.16990-1-malat@debian.org>
 <CA+8MBbKj4A5kh=hE0vcadzD+=cEAFY7OCWFCzvubu6cWULCJ0A@mail.gmail.com>
 <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180615121716.37fb93385825b0b2f59240cc@linux-foundation.org>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529604398-637138-3828-103276-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194292
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: akpm@linux-foundation.org,sfr@canb.auug.org.au,tony.luck@gmail.com,malat@debian.org,linux-mm@kvack.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Stephen,

On Fri, Jun 15, 2018 at 12:17:16PM -0700, Andrew Morton wrote:
> > Sadly that breaks ia64 build:
> > 
> >   CC      mm/memblock.o
> > mm/memblock.c:1340: error: redefinition of ‘memblock_virt_alloc_try_nid_raw’
> > ./include/linux/bootmem.h:335: error: previous definition of
> > ‘memblock_virt_alloc_try_nid_raw’ was here
> > mm/memblock.c:1377: error: redefinition of ‘memblock_virt_alloc_try_nid_nopanic’
> > ./include/linux/bootmem.h:343: error: previous definition of
> > ‘memblock_virt_alloc_try_nid_nopanic’ was here
> > mm/memblock.c:1413: error: redefinition of ‘memblock_virt_alloc_try_nid’
> > ./include/linux/bootmem.h:327: error: previous definition of
> > ‘memblock_virt_alloc_try_nid’ was here
> > make[1]: *** [mm/memblock.o] Error 1
> > make: *** [mm/memblock.o] Error 2
> 
> Huh.  How did that ever work.  I guess it's either this:
<snip>
> and I'm not sure which.  I think I'll just revert $subject for now.

This is fine now in master after Andrew's revert, but the problematic
patch is still being picked up in linux-next somehow. This breaks MIPS
builds from linux-next, and presumably the ia64 build too.

I'm not sure I understand how it's picked up - next-20180621 appears to
based atop 1abd8a8f39cd:

  $ git show next-20180621:Next/SHA1s | grep -E '^origin\s'
  origin          1abd8a8f39cd9a2925149000056494523c85643a

There we have the Andrew's revert:

  $ git log --pretty=oneline -n5 1abd8a8f39cd mm/memblock.c
  6cc22dc08a247b7b4a173e4561e39705a557d300 revert "mm/memblock: add missing include <linux/bootmem.h>"
  0825a6f98689d847ab8058c51b3a55f0abcc6563 mm: use octal not symbolic permissions
  69b5086b12cda645d95f00575c25f1dfd1e929ad mm/memblock: add missing include <linux/bootmem.h>
  25cf23d7a95716fc6eb165208b5eb2e3b2e86f82 mm/memblock: print memblock_remove
  1c4bc43ddfd52cbe5a08bb86ae636f55d2799424 mm/memblock: introduce PHYS_ADDR_MAX

Yet the revert doesn't show up at all in next-20180621..?

  $ git log --pretty=oneline -n5 next-20180621 mm/memblock.c
  a95f41a659344e221e8ad39e8fbba2e0f419c096 mm: use octal not symbolic permissions
  0b558dea04a405800505c7f56eb1638ae761b5d4 mm/memblock: add missing include <linux/bootmem.h>
  25cf23d7a95716fc6eb165208b5eb2e3b2e86f82 mm/memblock: print memblock_remove
  1c4bc43ddfd52cbe5a08bb86ae636f55d2799424 mm/memblock: introduce PHYS_ADDR_MAX
  49a695ba723224875df50e327bd7b0b65dd9a56b Merge tag 'powerpc-4.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux

I was expecting to see the original commit, then the revert, then
perhaps a re-application of it but instead it looks like the commits
from master are missing entirely after 25cf23d7a957 ("mm/memblock: print
memblock_remove"). Maybe I'm missing something about the way the merges
for linux-next are done..?

In any case, could we get the problematic patch removed from linux-next?

Thanks,
    Paul

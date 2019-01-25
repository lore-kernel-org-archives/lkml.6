Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90745C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CDE218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548437600;
	bh=x2aO5tNv4ArRJwQC6G/BXOJu88IB2OW9/j7p48wyEmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PxqtLWPX8lqV6zHkI+s9AihYpgvfA0+pF1dRReEZaqLwOEAqL/kSbFZ7PK0IA9z//
	 Il6FhOKlVF+Uta6zvJY4XfGHKYvCTItN3l/elFtFmhPNE5fDYDrA23+HHP4AOV7I1n
	 fL2hJugmKC61AWpl3NtBjSP8+Zv49tzG8dgEJGpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfAYRdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:33:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfAYRdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:33:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90D6FB05A;
        Fri, 25 Jan 2019 17:33:16 +0000 (UTC)
Date:   Fri, 25 Jan 2019 18:33:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     robert shteynfeld <robert.shteynfeld@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Subject: Re: kernel panic due to
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
Message-ID: <20190125173315.GC20411@dhcp22.suse.cz>
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz>
 <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz>
 <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz>
 <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125163938.GA20411@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 17:39:38, Michal Hocko wrote:
> On Fri 25-01-19 11:16:30, robert shteynfeld wrote:
> > Attached is the dmesg from patched kernel.
> 
> Your Node1 physical memory range precedes Node0 which is quite unusual
> but it shouldn't be a huge problem on its own. But memory ranges are
> not aligned to the memory section
> 
> [    0.286954] Early memory node ranges
> [    0.286955]   node   1: [mem 0x0000000000001000-0x0000000000090fff]
> [    0.286955]   node   1: [mem 0x0000000000100000-0x00000000dbdf8fff]
> [    0.286956]   node   1: [mem 0x0000000100000000-0x0000001423ffffff]
> [    0.286956]   node   0: [mem 0x0000001424000000-0x0000002023ffffff]
> 
> As you can see the last pfn for the node1 is inside the section and
> Node0 starts right after. This is quite unusual as well. If for no other
> reasons then the memmap of those struct pages will be remote for one or
> the other. Actually I am not even sure we can handle that properly
> because we do expect 1:1 mapping between sections and nodes.
> 
> Now it also makes some sense why 2830bf6f05fb ("mm, memory_hotplug:
> initialize struct pages for the full memory section") made any
> difference. We simply write over a potentially initialized struct page
> and blow up on that. I strongly suspect that the commit just uncovered
> a pre-existing problem. Let me think what we can do about that.

Appart from force aligning node's start the only other option is to
revert 2830bf6f05fb and handling the underlying issue in the hotplug
code. I really wanted to prevent that because memory hotplug assumes
sections to be in a single node at way too many places. Maybe somebody
has a more clever idea though.
-- 
Michal Hocko
SUSE Labs

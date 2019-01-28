Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B99C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9CE20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548702170;
	bh=9nuDj/uoQASX0069rt6dOkWWxTK0AR4ep7ETcGNRHu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YavOGpiclpTZNsA0NSpSt7ER3KxWlbynZiiQxjN91/Zynw2bqGyAQAMLX1RHHDNHk
	 sFkbmBmhHQlOpWUklPg88BNRzaIsmRoCdTko0xOu0JcZAke9rAZ3KcQLssTdGX58R/
	 tTBkIDWRMCJc8zFp1VwInlODD4A2WIR8s+AviVgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfA1TCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:02:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:58850 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfA1TCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:02:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB829B01A;
        Mon, 28 Jan 2019 19:02:46 +0000 (UTC)
Date:   Mon, 28 Jan 2019 20:02:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
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
Message-ID: <20190128190245.GV18811@dhcp22.suse.cz>
References: <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz>
 <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz>
 <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz>
 <20190125173315.GC20411@dhcp22.suse.cz>
 <20190125181549.GE20411@dhcp22.suse.cz>
 <20190128114358.GH18811@dhcp22.suse.cz>
 <CAHk-=wh3iWk6nu1u2OZ9JeyM-aJ_nCm1tMihPir8Yu3Q08f4aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3iWk6nu1u2OZ9JeyM-aJ_nCm1tMihPir8Yu3Q08f4aA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 10:42:25, Linus Torvalds wrote:
> On Mon, Jan 28, 2019 at 3:44 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > >
> > > Linus, could you take the revert please?
> >
> > or should I post the patch as a reply to make your life easier?
> 
> I've taken that revert now, but yes, in general, it's much better if a
> patch is sent separately from the discussion as a very explicit patch
> (ie subject line has that usual "[PATCH] ..." format etc) simply
> because I get too much email and I can often miss things otherwise.
> Particularly inside a thread where the developers are discussing
> things, I go "ah, good, things are still being discussed" without
> looking any closer into the details.

Sure, I usually do it that way. I was just awaiting some review feedback
on the changelog first.

> That's particularly true when traveling - I only noticed this one on
> this second reminder email.. I'm home now, but Friday, when you sent
> it originally, was 45 hours long for me with 24 hours on airplanes and
> airports, so I had entirely missed the original email back then.

No problem. Andrew has already queued it as well so I guess he simply
drops it when it reaches your tree.

Thanks!
-- 
Michal Hocko
SUSE Labs

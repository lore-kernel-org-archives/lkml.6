Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D358C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60968218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548431896;
	bh=uCFQV0uWO6RMwT1ciaI3cvqmfyNDzSqe8FWELcCBMao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1csluP8x4YpddaFN8IPnLGEHi/1ud/MQpIJnzxtwTES7RMgShOIWCtiJvj/yUYDsZ
	 A/CakFn3sLvp7B2VrAx6+Ursl49xBi0Az93dhnZu16IN0K5UdeRDjDmwO8wJTGVVxz
	 P4tUrPARqj7lyo2UnLSu55Hg0K2wSCSSurVS1wYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfAYP6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:58:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfAYP6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:58:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EE8BAFE9;
        Fri, 25 Jan 2019 15:58:13 +0000 (UTC)
Date:   Fri, 25 Jan 2019 16:58:10 +0100
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
Message-ID: <20190125155810.GQ3560@dhcp22.suse.cz>
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz>
 <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz>
 <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 10:52:06, robert shteynfeld wrote:
> The person who pointed to mm/page_alloc.c commits likely causing the
> issue did not have time to build a patched/reverted kernel to confirm
> his hypothesis.  When I tried backing out the two separate commits he
> suggested, the first commit (ie. the one in the subject) was the one
> that when backed out fixed the boot issue.  Reverting the second one
> had no effect.

OK, so can you provide the full dmesg (with revert) along wth
memblock=debug kernel parameter. Also would it be possible to configure
serial or net console to get the actual panic report please?
-- 
Michal Hocko
SUSE Labs

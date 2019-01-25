Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0759F21A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548404370;
	bh=jOWDWPkMATJ24cGjzeElRqh7q+TN7loeAHTcumrgJvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0MFH9YLYVJMFtd0iCNDcZU13B+iDyYDx+lVR8BQvWLURUDNg6zizOAEbY4rXUI5w9
	 SlCuafNd8I5gtVW8B33TDNgmCUUYuC/hcz5nOOg/WpJFmEVrAsWh+QZnhT0N/+/FXT
	 kv0PlrUwSd5TsoclGOMACES0IkjVoshqjNWjTA1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfAYIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:19:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfAYIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:19:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3101DAFF0;
        Fri, 25 Jan 2019 08:19:26 +0000 (UTC)
Date:   Fri, 25 Jan 2019 09:19:24 +0100
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
Message-ID: <20190125081924.GF3560@dhcp22.suse.cz>
References: <CADfvbxqC1+XoSsn0sEDqFE16tN1Pq46-QDAaCu=AXJdZeY3rDQ@mail.gmail.com>
 <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125073704.GC3560@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 08:37:04, Michal Hocko wrote:
> On Fri 25-01-19 17:48:32, Linus Torvalds wrote:
> > [ Just adding a lot of other people to the cc ]
> > 
> > Robert, could you add a dmesg of a successful boot to that bugzilla,
> > or just as an attachement in email to this group of people..
> > 
> > This looks to be with the Fedora kernel config. Two people reporting
> > it, it looks like similar machines.
> > 
> > I assume it's some odd memory sizing detail that happens to trigger a
> > particular case.
> 
> Quite possible.

Forgot to ask. Can we get a dmesg with 2830bf6f05fb ("mm,
memory_hotplug: initialize struct pages for the full memory section")
reverted and memblock=debug kernel command line parameter?
-- 
Michal Hocko
SUSE Labs

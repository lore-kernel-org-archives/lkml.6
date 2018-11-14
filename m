Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB002C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15E5208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15E5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732796AbeKNX0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:26:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeKNX0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:26:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E61AB038;
        Wed, 14 Nov 2018 13:23:07 +0000 (UTC)
Date:   Wed, 14 Nov 2018 14:23:06 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181114132306.GX23419@dhcp22.suse.cz>
References: <20181004094637.GG22173@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com>
 <20181009083326.GG8528@dhcp22.suse.cz>
 <20181015150325.GN18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com>
 <20181016104855.GQ18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
 <20181017070531.GC18839@dhcp22.suse.cz>
 <alpine.DEB.2.21.1810171256330.60837@chino.kir.corp.google.com>
 <20181018070031.GW18839@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018070031.GW18839@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-10-18 09:00:31, Michal Hocko wrote:
> On Wed 17-10-18 12:59:18, David Rientjes wrote:
> > On Wed, 17 Oct 2018, Michal Hocko wrote:
> > 
> > > Do you know of any other userspace except your usecase? Is there
> > > anything fundamental that would prevent a proper API adoption for you?
> > > 
> > 
> > Yes, it would require us to go back in time and build patched binaries. 
> 
> I read that as there is a fundamental problem to update existing
> binaries. If that is the case then there surely is no way around it
> and another sad page in the screwed up APIs book we provide.
> 
> But I was under impression that the SW stack which actually does the
> monitoring is under your controll. Moreover I was under impression that
> you do not use the current vanilla kernel so there is no need for an
> immediate change on your end. It is trivial to come up with a backward
> compatible way to check for the new flag (if it is not present then
> fallback to vma flags).
> 
> I am sorry for pushing here but if this is just a matter of a _single_
> user which _can_ be fixed with a reasonable effort then I would love to
> see the future api unscrewed.

ping
-- 
Michal Hocko
SUSE Labs

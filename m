Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D680C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6292F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 07:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6292F208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJPPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726729AbeJPPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 11:35:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A7184AF43;
        Tue, 16 Oct 2018 07:46:09 +0000 (UTC)
Date:   Tue, 16 Oct 2018 08:46:06 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181016074606.GH6931@suse.de>
References: <20181005232155.GA2298@redhat.com>
 <alpine.DEB.2.21.1810081303060.221006@chino.kir.corp.google.com>
 <20181009094825.GC6931@suse.de>
 <20181009122745.GN8528@dhcp22.suse.cz>
 <20181009130034.GD6931@suse.de>
 <20181009142510.GU8528@dhcp22.suse.cz>
 <20181009230352.GE9307@redhat.com>
 <alpine.DEB.2.21.1810101410530.53455@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1810151525460.247641@chino.kir.corp.google.com>
 <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181015154459.e870c30df5c41966ffb4aed8@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:44:59PM -0700, Andrew Morton wrote:
> On Mon, 15 Oct 2018 15:30:17 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > At the risk of beating a dead horse that has already been beaten, what are 
> > the plans for this patch when the merge window opens?
> 
> I'll hold onto it until we've settled on something.  Worst case,
> Andrea's original is easily backportable.
> 

I consider this to be an unfortunate outcome. On the one hand, we have a
problem that three people can trivially reproduce with known test cases
and a patch shown to resolve the problem. Two of those three people work
on distributions that are exposed to a large number of users. On the
other, we have a problem that requires the system to be in a specific
state and an unknown workload that suffers badly from the remote access
penalties with a patch that has review concerns and has not been proven
to resolve the trivial cases. In the case of distributions, the first
patch addresses concerns with a common workload where on the other hand
we have an internal workload of a single company that is affected --
which indirectly affects many users admittedly but only one entity directly.

At the absolute minimum, a test case for the "system fragmentation incurs
access penalties for a workload" scenario that could both replicate the
fragmentation and demonstrate the problem should have been available before
the patch was rejected.  With the test case, there would be a chance that
others could analyse the problem and prototype some fixes. The test case
was requested in the thread and never produced so even if someone were to
prototype fixes, it would be dependant on a third party to test and produce
data which is a time-consuming loop. Instead, we are more or less in limbo.

-- 
Mel Gorman
SUSE Labs

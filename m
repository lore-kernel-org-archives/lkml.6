Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CCBC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71960218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfAXPeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:34:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727649AbfAXPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:34:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64EAC142BF1;
        Thu, 24 Jan 2019 15:34:36 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E25A661370;
        Thu, 24 Jan 2019 15:34:33 +0000 (UTC)
Date:   Thu, 24 Jan 2019 10:34:32 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 04/24] mm: gup: allow VM_FAULT_RETRY for multiple
 times
Message-ID: <20190124153431.GB5030@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
 <20190121075722.7945-5-peterx@redhat.com>
 <20190121162455.GC3711@redhat.com>
 <20190124070503.GJ18231@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124070503.GJ18231@xz-x1>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 24 Jan 2019 15:34:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:05:03PM +0800, Peter Xu wrote:
> On Mon, Jan 21, 2019 at 11:24:55AM -0500, Jerome Glisse wrote:
> > On Mon, Jan 21, 2019 at 03:57:02PM +0800, Peter Xu wrote:
> > > This is the gup counterpart of the change that allows the VM_FAULT_RETRY
> > > to happen for more than once.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > So it would be nice to add a comment in the code and in the commit message
> > about possible fault starvation (mostly due to previous patch changes) as
> > if some one experience that and try to bisect it might overlook the commit.
> > 
> > Otherwise:
> > 
> > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> 
> Jerome, can I still keep this r-b if I'm going to fix the starvation
> issue you mentioned in previous patch about lock page?
> 

No please, i still want to review properly the oneline ie making sure
that it will not change any of the existing use of FAULT_FLAG_TRIED
I am finishing a bunch of patches myself so i am bit short on time right
now to take a deeper look but i will try to do that in next few days :)

In anycase i will review again your next posting.

Cheers,
Jérôme

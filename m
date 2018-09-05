Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6EAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42BD20890
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42BD20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIEQ6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:46 -0400
Received: from foss.arm.com ([217.140.101.70]:57320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeIEQ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E9217A9;
        Wed,  5 Sep 2018 05:28:43 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50C033F5BC;
        Wed,  5 Sep 2018 05:28:43 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B7DAF1AE3546; Wed,  5 Sep 2018 13:28:57 +0100 (BST)
Date:   Wed, 5 Sep 2018 13:28:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        npiggin@gmail.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v2 0/5] Extend and consolidate mmu_gather into new file
Message-ID: <20180905122857.GH20186@arm.com>
References: <1536061533-16188-1-git-send-email-will.deacon@arm.com>
 <20180904125501.642e1004825350aca476a653@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904125501.642e1004825350aca476a653@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 12:55:01PM -0700, Andrew Morton wrote:
> On Tue,  4 Sep 2018 12:45:28 +0100 Will Deacon <will.deacon@arm.com> wrote:
> 
> > This series builds on the core changes I previously posted here:
> > 
> >   rfc:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/597821.html
> >   v1:	http://lists.infradead.org/pipermail/linux-arm-kernel/2018-August/598919.html
> > 
> > The main changes are:
> > 
> >   * Move the mmu_gather bits out of memory.c and into their own file
> >     (looped in the mm people for this)
> > 
> >   * Add a MAINTAINERS entry for the new file, and all tlb.h headers.
> >     If any mm developers would like to be included here as well, please
> >     just ask.
> > 
> > I'd like to queue these patches on their own branch in the arm64 git so
> > that others can develop on top of them for the next merge window. Peter
> > and Nick have both expressed an interest in that, and I already have a
> > bunch of arm64 optimisations on top which I posted previously.
> 
> All looks good to me - please proceed that way.  Please also add me to
> the MAINTAINERS record so I get more emails.

Cheers, Andrew. I'll add you to the MAINTAINERS entry and get this lot into
-next once the kbuild robot is happy that I've got all the header files
right.

Will

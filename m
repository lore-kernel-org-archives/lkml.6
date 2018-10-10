Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036C32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036C32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeJKHIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:08:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:08:29 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7D3BA85;
        Wed, 10 Oct 2018 23:44:00 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:43:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-Id: <20181010164359.292d938b51cbd57b38a1bd99@linux-foundation.org>
In-Reply-To: <62492f47-d51f-5c41-628c-ff17de21829e@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
        <20181008211623.30796-3-jhubbard@nvidia.com>
        <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
        <20181009083025.GE11150@quack2.suse.cz>
        <20181009162012.c662ef0b041993557e150035@linux-foundation.org>
        <62492f47-d51f-5c41-628c-ff17de21829e@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 17:32:16 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> > I'm not really understanding.  Patch 3/3 changes just one infiniband
> > driver to use put_user_page().  But the changelogs here imply (to me)
> > that every user of get_user_pages() needs to be converted to
> > s/put_page/put_user_page/.
> > 
> > Methinks a bit more explanation is needed in these changelogs?
> > 
> 
> OK, yes, it does sound like the explanation is falling short. I'll work on something 
> clearer. Did the proposed steps in the changelogs, such as:
>   
> [2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
>     Proposed steps for fixing get_user_pages() + DMA problems.
> 
> help at all, or is it just too many references, and I should write the words
> directly in the changelog?
> 
> Anyway, patch 3/3 is a just a working example (which we do want to submit, though), and
> many more conversions will follow. But they don't have to be done all upfront--they
> can be done in follow up patchsets. 
> 
> The put_user_page*() routines are, at this point, not going to significantly change
> behavior. 
> 
> I'm working on an RFC that will show what the long-term fix to get_user_pages and
> put_user_pages will look like. But meanwhile it's good to get started on converting
> all of the call sites.

I see.  Yes, please do put all of it into the changelog[s].



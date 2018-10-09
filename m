Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CEC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1354621476
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1354621476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJIHTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:19:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:19:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4617570E3;
        Tue,  9 Oct 2018 00:05:27 +0000 (UTC)
Date:   Mon, 8 Oct 2018 17:05:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 1/3] mm: get_user_pages: consolidate error handling
Message-Id: <20181008170525.62d1a910f7811d7c66a8c34c@linux-foundation.org>
In-Reply-To: <20181008211623.30796-2-jhubbard@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
        <20181008211623.30796-2-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 14:16:21 -0700 john.hubbard@gmail.com wrote:

> An upcoming patch requires a way to operate on each page that
> any of the get_user_pages_*() variants returns.
> 
> In preparation for that, consolidate the error handling for
> __get_user_pages(). This provides a single location (the "out:" label)
> for operating on the collected set of pages that are about to be returned.
> 
> As long every use of the "ret" variable is being edited, rename
> "ret" --> "err", so that its name matches its true role.
> This also gets rid of two shadowed variable declarations, as a
> tiny beneficial a side effect.

Reviewed-by: Andrew Morton <akpm@linux-foundation.org>

`i' is a pretty crappy identifier as well, but we'll live.


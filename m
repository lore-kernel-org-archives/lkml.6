Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13477C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7492083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AXwFGIuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7492083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936488AbeFRTcI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:32:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33254 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936376AbeFRTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:32:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so18032892wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 12:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BFIL8fYqv5EECsFWtaoAgr3hcwTQIzajnx3mIeiDiW0=;
        b=AXwFGIuQWWxl8K8rm/7rIlSFEc5LLbO832MaUDGSK/Bb0KvDdPcEXGfXAEYWi1UO/r
         h+MSmEqYlBgPOuEcFeHv4SP/yuMwdV0igeDrYemO/vPHJGDCjYVvS0zsoffoU4cM5ROj
         XOl9/SiMS8BBi9sn6tsS+TgJZ5gfdDLujZ5h8g6Z9C1XLz4sZH+ujD4G1HiKfgdhAcfQ
         dSFkdfiySvoHZx9UlGohRU4Ik036sBVYILY3txd5IF/b6CDHeUrWMHFEJlH3KoJlCF84
         OONiN4gHObd+zZWYcRjAoSKjJoIYgRlzkD7RNorVtl2FpmPLI6fyOxT5rCufmYXwQ/Gv
         sCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BFIL8fYqv5EECsFWtaoAgr3hcwTQIzajnx3mIeiDiW0=;
        b=aiYYVqy2uoHHfu0Cg6JRBE2RmJdPW1S5AimP4SSbwVfuvVFWO7taOVekl3Pw3+QH+x
         RmBhob3mqLuBsL2LMH/xpZbh7MJB8gC1HSa0Fq8C1yd2Fm1s23RTeI3BghoO5MK/cgOd
         hwkB17ljY0epad7f9uoAeg0seMpIyYi8LVi16Wnnn8k9Vl7Heeyurn7F8gyMu4OLG5Aa
         V/Ll2A+xJTAb6EeY5fM6wi5YsN2TsRiixsw6/P8YdmHvHTYyMkY8EAE+Fc6rO29UadDH
         CfvZi89/Ac8QmQMsAy6vlol1+MBpbHfHWjRJ39An3qLcNYNWl3qTEwpk1P5AtQEKdkjW
         biHg==
X-Gm-Message-State: APt69E0+oIeTyAeBxuJ1sG75CT9t3YAxwOGdZBJQkxzXRiC/nxhZBqXV
        HEslE+tV+DFLwFEMBCyO+vnAsQ==
X-Google-Smtp-Source: ADUXVKKjODpwleUa1bTYMMKM3btL0J+ZHDSpqb8tLN28ZbEgY4xw+tX3pPiQ2SG2Dhn6DnQHmqoTgw==
X-Received: by 2002:adf:c844:: with SMTP id e4-v6mr11286868wrh.236.1529350323867;
        Mon, 18 Jun 2018 12:32:03 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k17-v6sm12042846wmc.23.2018.06.18.12.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:32:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fUzsc-0002vO-Lu; Mon, 18 Jun 2018 13:31:58 -0600
Date:   Mon, 18 Jun 2018 13:31:58 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
Message-ID: <20180618193158.GE6805@ziepe.ca>
References: <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:21:46PM -0700, Dan Williams wrote:
> On Mon, Jun 18, 2018 at 11:14 AM, John Hubbard <jhubbard@nvidia.com> wrote:
> > On 06/18/2018 10:56 AM, Dan Williams wrote:
> >> On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
> >>> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
> >>>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
> >>>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
> >>>>> these pages are going to be treated specially. In particular, the caller
> >>>>> does not really want or need to support certain file operations, while the
> >>>>> page is flagged this way.
> >>>>>
> >>>>> If necessary, we could add a new API call.
> >>>>
> >>>> That API call is called get_user_pages_longterm.
> >>>
> >>> OK...I had the impression that this was just semi-temporary API for dax, but
> >>> given that it's an exported symbol, I guess it really is here to stay.
> >>
> >> The plan is to go back and provide api changes that bypass
> >> get_user_page_longterm() for RDMA. However, for VFIO and others, it's
> >> not clear what we could do. In the VFIO case the guest would need to
> >> be prepared handle the revocation.
> >
> > OK, let's see if I understand that plan correctly:
> >
> > 1. Change RDMA users (this could be done entirely in the various device drivers'
> > code, unless I'm overlooking something) to use mmu notifiers, and to do their
> > DMA to/from non-pinned pages.
> 
> The problem with this approach is surprising the RDMA drivers with
> notifications of teardowns. It's the RDMA userspace applications that
> need the notification, and it likely needs to be explicit opt-in, at
> least for the non-ODP drivers.

Well, more than that, we have no real plan on how to accomplish this,
or any idea if it can even really work.. Most userspace give up
control of the memory lifetime to the remote side of the connection
and have no way to recover it other than a full teardown.

Given that John is trying to fix a kernel oops, I don't think we
should tie progress on it to the RDMA notification idea.

.. and given that John is trying to fix a kernel oops, maybe the
weird/bad/ugly behavior of ftruncte is a better bug to have than for
unprivileged users to be able to oops the kernel???

Jason

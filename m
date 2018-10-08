Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED05C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C84A2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QxKifvye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C84A2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIEJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:09:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34646 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbeJIEJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:09:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so8925996pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUxI18sQHVz1SffmtDkF2Am1NhRDQc9sGKwucBQLJXI=;
        b=QxKifvyelnKnpzb5/4RqT7+RTDCYbvfAYGq2YUbY/XdNLu+XF9Ylwq3dpY30qeKu6Y
         ZUG3FJ83Zyr92qKMlEXzw1HyvmGXrQyrnbqsoPilTuIIzvUgnQSqBoreTjmqcN5GoCxh
         9CBeXchbDMjC2P1U0ZYT/7QDcL+1GDAICQf9nL6pvOhwfiNE29dKZwSxwJRbJ/F0uWN/
         KVtLOyvL8lFGw1CiVWZ24yZFK1UTU4I+VtC8/g+wXn83II33bHYyLlkEOxvkVVY9ft+y
         0mJTwcfOu1kDeRQTC66TME+3EQlLpdKo/f5U8zhP4ZjXY0xltiXV+Zd1mLt0bB7nK6aw
         ItDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUxI18sQHVz1SffmtDkF2Am1NhRDQc9sGKwucBQLJXI=;
        b=hZw3gXkQpppmkNt5IF/A0116PbKsIlGgyeeEBRvQQtwHsBTDgQPmfsu8I3Ks9wzg7k
         EkBP1Y6oHR2hwDPj2Tb843zIbxOoYeX84jC10KjSPe/uUJOoGrpdbsJCW2vU/y8B6ZBj
         0CWjr9yR9D5akE9VZQQzRLOOlsgdmvi+BBosRcqL7hdZ/JksCJtWK3KcUl7/MD6afRDK
         VWYSdf2u5cFeMUVGAZXv1acN7VVk6I+Tkq/anh8AGOK793A8CmDiqbgtaBUe4RFIZyiF
         H9tEBdrKX9nPG5SeM1igrN6ex9EaOsWv/1muzUyvGytyPjNYLeZEAsZkF9t2tJohfCZ/
         ikqA==
X-Gm-Message-State: ABuFfoi7X7ExurQ0gFZ3aoRihJWyzFDA4p8wiUrxLVgiBmn39v0zNOdu
        xrqZaKz1YxsrRcU5siDNQl3NMg==
X-Google-Smtp-Source: ACcGV60pR5Xt1/Df7Tvjqdgwy4Rvb9zFwGzCyEw9ZwbPvopbfJQre+mt9pKvz/nYULg7/uGGDyfOqA==
X-Received: by 2002:a62:4803:: with SMTP id v3-v6mr27586362pfa.89.1539032164354;
        Mon, 08 Oct 2018 13:56:04 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id c124-v6sm28799856pfa.119.2018.10.08.13.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 13:56:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g9cZO-0000tH-Sn; Mon, 08 Oct 2018 14:56:02 -0600
Date:   Mon, 8 Oct 2018 14:56:02 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH v3 3/3] infiniband/mm: convert put_page() to
 put_user_page*()
Message-ID: <20181008205602.GD27639@ziepe.ca>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
 <20181006024949.20691-4-jhubbard@nvidia.com>
 <20181008194240.GA27639@ziepe.ca>
 <15d3daac-ba59-b1c9-873d-1876b58bde9d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d3daac-ba59-b1c9-873d-1876b58bde9d@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 01:37:35PM -0700, John Hubbard wrote:
> On 10/8/18 12:42 PM, Jason Gunthorpe wrote:
> > On Fri, Oct 05, 2018 at 07:49:49PM -0700, john.hubbard@gmail.com wrote:
> >> From: John Hubbard <jhubbard@nvidia.com>
> [...]
> >>  drivers/infiniband/core/umem.c              |  7 ++++---
> >>  drivers/infiniband/core/umem_odp.c          |  2 +-
> >>  drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
> >>  drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
> >>  drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
> >>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
> >>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  7 ++++---
> >>  7 files changed, 24 insertions(+), 28 deletions(-)
> > 
> > I have no issues with this, do you want this series to go through the
> > rdma tree? Otherwise:
> > 
> > Acked-by: Jason Gunthorpe <jgg@mellanox.com>
> > 
> 
> The RDMA tree seems like a good path for this, yes, glad you suggested
> that.
> 
> I'll post a v4 with the comment fix and the recent reviewed-by's, which
> should be ready for that.  It's based on today's linux.git tree at the 
> moment, but let me know if I should re-apply it to the RDMA tree.

I'm unclear who needs to ack the MM sections for us to take it to
RDMA?

Otherwise it is no problem..

Jason

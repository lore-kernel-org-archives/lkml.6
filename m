Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C82C4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C8F20658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ePBPSpA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C8F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeJKUrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:47:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43339 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeJKUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:47:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so9722396qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xA1Xq3zSEkL+SYbeUZCss7KxMc6kPb35X0Ss6FJLa90=;
        b=ePBPSpA+oMb4alDXBSN65oOkQ+06TxdF1p3pfLNZAayf0TN2r0lJmj9/9cp0A3nf0/
         MN7/ZFxu6PpU0qcN8HYk9QQ3XDiF8TqaUHXS7auChq4hcl6Gu9689wXHe7EwYbZwykmO
         UpshWfSUDmpH2LpHIxpMQCcfWpc6bbFMmsFuoYHSDszMO9T+oAZ8VlkCNbXDl3jeNecB
         JuWbA5sOUKhU3rfxBXgi6ziTetKNGFf/Y5hpeL7KsNuLO/l+6bk6sq79pV5TbXa9umQl
         DlMgAWgdEI8jhdK4ipmcfbfq0EubGhDZ2M7YPpnNgh47+B+IgBS0EQuBhar6UR4uagCu
         pSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xA1Xq3zSEkL+SYbeUZCss7KxMc6kPb35X0Ss6FJLa90=;
        b=YgEs4Z8MYLYO1LIcjEbQ3i+RRbZ03yIW6TmEhQm4amLpkY5GVK3Gkdr46mQCmQ+0iF
         ydfCroLlXyiEw97eMR6pEQLplK3OQGM/jm8jFhCM+wQmprJcFFhUt+2FtTrT6q06f38Q
         9Zr282xlFEe4Hv5S4k267DMaSAlphQfnhJXMigDjr0L0yig4svrTYvT9qBpIvDGM/EsU
         t1lbtZcfl9oyV5KjphMR8pNLXElrL2fFrOuD9aWlbgtbVEC6YDpW95VH30PAM2ohlY0O
         zDiQdbc5ljHEetkN1MkMgj+dZ4I1Q2QJMZVQDeXQCIU1uSI3bo06fB97n+J9kDSD//gu
         x5Iw==
X-Gm-Message-State: ABuFfoiG9yp/Wbbq5mEsAqW6ZGgp8sGpmxwk/r+rQ/1NUAFlkpCX0nYQ
        dM2HEWU+U3DA/dKXL6VnIKVIAg==
X-Google-Smtp-Source: ACcGV60pKyltuVyrd1mrqlxvpI1zwVaKIIq8SSjKm32oq+YDjijT5QG46p0xaOGUTrxvk+9Nl4UdpQ==
X-Received: by 2002:a0c:ec8e:: with SMTP id u14-v6mr1480994qvo.225.1539264016755;
        Thu, 11 Oct 2018 06:20:16 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id s52-v6sm18295106qts.5.2018.10.11.06.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 06:20:14 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gAasv-0001a3-Jr; Thu, 11 Oct 2018 07:20:13 -0600
Date:   Thu, 11 Oct 2018 07:20:13 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>, john.hubbard@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
Message-ID: <20181011132013.GA5968@ziepe.ca>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011084929.GB8418@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:

> > This is a real worry.  If someone uses a mistaken put_page() then how
> > will that bug manifest at runtime?  Under what set of circumstances
> > will the kernel trigger the bug?
> 
> At runtime such bug will manifest as a page that can never be evicted from
> memory. We could warn in put_page() if page reference count drops below
> bare minimum for given user pin count which would be able to catch some
> issues but it won't be 100% reliable. So at this point I'm more leaning
> towards making get_user_pages() return a different type than just
> struct page * to make it much harder for refcount to go wrong...

At least for the infiniband code being used as an example here we take
the struct page from get_user_pages, then stick it in a sgl, and at
put_page time we get the page back out of the sgl via sg_page()

So type safety will not help this case... I wonder how many other
users are similar? I think this is a pretty reasonable flow for DMA
with user pages.

Jason

Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D0CC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523A2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kmhyFYsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523A2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbeLHS0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:26:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LBRTYd/n8sZthRzRMvHQ53RvvZe2kPi8PcMY/Qi5xBw=; b=kmhyFYsNyN3d/ly5PUn+Qsv6w
        mEtcQwA80JMWPgBdmQJUM13DGCCc5wJBwbXmUO8OqfefiVESbKff3A9LsBH0Ci69ljiEWjqgH7/oK
        kw+IYqrUQ5GOT7woyBT6ZeUwBZZf6RQvXjmYsWgf8EHQRzf85Kx9gCQdzJALVLBrvKTTUOwE5A3GG
        7dqoIl4K6/W67pWFTe3ln3TGcs3O/5JtFB2bY4zP/UN+zTdofYldsuk562+uqthy5why7Yd8a/JZs
        Ph++M4vQYaf/RwUqy0/g7TmessSJ2l0k251wfKB9fAP0PQn7YQCc7CKG2qQAGRJoD3ruJNMazra56
        z3A4dtYwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVhIi-0007gY-Nv; Sat, 08 Dec 2018 18:26:04 +0000
Date:   Sat, 8 Dec 2018 10:26:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
Message-ID: <20181208182604.GA24564@infradead.org>
References: <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com>
 <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com>
 <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com>
 <CAPcyv4hwtMA+4qc6500ucn5vf6fRrNdfyMHru_Jhzx86=1Wwww@mail.gmail.com>
 <20181208163353.GA2952@redhat.com>
 <20181208164825.GA26154@infradead.org>
 <20181208174730.GB2952@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208174730.GB2952@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:47:30PM -0500, Jerome Glisse wrote:
> Most of the user of GUP are well behave (everything under driver/gpu and
> so is mellanox driver and many other) ie they abide by mmu notifier
> invalidation call backs. They are a handfull of device driver that thought
> they could just do GUP and ignore the mmu notifier part and those are the
> one being problematic. So to me it feels like bystander are be shot for no
> good reasons.

get_user_pages is used by every single direct I/O, and while the race
windows in that case are small they very much exists.

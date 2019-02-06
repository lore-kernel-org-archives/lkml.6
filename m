Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DABB2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D+opncBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBFTqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:46:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44673 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBFTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:46:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id e24so4769735otp.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 11:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPRk2YeA0ENLaCELegsjd2/mMdISAWmeKeSJ7XCFV30=;
        b=D+opncBvF6bDRVFj2WCKwHoO6oV/Y3U6I7oyuFwqVTqLo57o4BCg4re51jm57NgtA6
         ZVbb1nNsmHaoiADxy9d0RYV5RCd0kophHtPirdWFjW3lcbih/CSNYHfEwIMp5gASIcop
         JyRI4Q/7bnNjz3EJSq87ynSThUyRwZVxhJ5g6GugqC+WYedS12P9ULseURTpQ1pvMw3P
         7IHFTZ4kMiDI5wCJ2cFDbDjY7nKGNrNrfXeNSPcCt6gVVwx9safARDLh6EYsN2yatBil
         943mbvlBkI8D7mzjvKttwI/evQmMOzaYVvLF/HwkxQ4kmHgO9cPYa+yUbb9eqOKF93b0
         Vd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPRk2YeA0ENLaCELegsjd2/mMdISAWmeKeSJ7XCFV30=;
        b=Vsc1SoQvEF/QdoFRH2TJErOzw+moksqfQF26eIjfN+W9WSmkpN/k2WHBXZfEe1t4pc
         zM0mwh8yXB1B3ZCysNZsIeINi00ePDq8jEa+xToGEeY8HUtvr8DTz2W/ydCMJmBULU/B
         KOaW7TKlDI7JptKskEEcY9Yir8j3trjsdR15evBnisMSLN67awvCtpNp9dZuihutTHH1
         788Ey4LHnSxyuWBH/jREEIuquhrAXa30ZagUAdL0nzkKdeeDuRIdoLRsIYM56DlDk01H
         rdmIIwEqSR4UUjCZ5KevYrFp2MNdf3k/EMuLCIYwckjhqrcMs+2AmLcQjmq8bTQ+PCm4
         glgw==
X-Gm-Message-State: AHQUAuaDbV/EdvdviIU5qKzVTBlM7+wHCFuhGQXlPjNnzsH7TDNPzg8m
        DPyMLBeFJsA3SGvEF3u8jd16GxsE5MhkpopJ1WWJgQ==
X-Google-Smtp-Source: AHgI3IbfowQ6doWzN8plMe6p/eR9jKuKihJMQsfeoWqHAFPTBKwxHJ+qAJPMxS3Qqf/ayEhmLl8IwOaQSZV7zgzp2PE=
X-Received: by 2002:a9d:3a0a:: with SMTP id j10mr6481150otc.229.1549482367913;
 Wed, 06 Feb 2019 11:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org> <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <20190206183503.GO21860@bombadil.infradead.org> <20190206185233.GE12227@ziepe.ca>
In-Reply-To: <20190206185233.GE12227@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 11:45:56 -0800
Message-ID: <CAPcyv4j4gDNHu836N4RfgQsE+eZU9Wt0N9Y09KQ43zV+4mK-eg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 10:52 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 06, 2019 at 10:35:04AM -0800, Matthew Wilcox wrote:
>
> > > Admittedly, I'm coming in late to this conversation, but did I miss the
> > > portion where that alternative was ruled out?
> >
> > That's my preferred option too, but the preponderance of opinion leans
> > towards "We can't give people a way to make files un-truncatable".
>
> I haven't heard an explanation why blocking ftruncate is worse than
> giving people a way to break RDMA using process by calling ftruncate??
>
> Isn't it exactly the same argument the other way?

No, I don't think it is. The lease is there to set the expectation of
getting out of the way, it's not a silent un-coordinated failure. The
user asked for it, the kernel is just honoring a valid request. If the
RDMA application doesn't want it to happen, arrange for it by
permissions or other coordination to prevent truncation, but once the
two conflicting / valid requests have arrived at the filesystem try to
move the result forward to the user requested state not block and fail
indefinitely.

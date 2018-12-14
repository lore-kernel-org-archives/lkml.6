Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E50208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dW6tIIT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E50208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLNFVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:21:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34350 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:21:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id h25so3652873oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 21:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpIMAtZzHAdUBjBeuDaGg9PhOGPT/1ioJOjVyBPIhjQ=;
        b=dW6tIIT02QWSryDFFdV/NJUZiXmh2OEDXleF6cKBSCepXMbmIWMx/sJiPlT4lcR/9t
         GT307/MvhkeUubBu7JWcR3eCKOvl7aAlttqJvewJbPfiEoQUGpc4gAAsUmcncXe/eDV/
         6s4X4qtuvrdfI0qY+u+8jxXilwspQSBi21ZAbw4rrejDn7AIkhMTHvCGkBjLJUSSCcMu
         eabyG5QiEITp5l1Ye535prdpHdGVi1O4xZEFTWCfoUMnSQXGA3dy++SAB/fCPTSUFAx1
         8awEunDppQLUsK3LY5Ue0KIenLzw0a0iHKZTuPrcckCBt+nPzuWddo24dHSFKu3+/fVj
         e/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpIMAtZzHAdUBjBeuDaGg9PhOGPT/1ioJOjVyBPIhjQ=;
        b=d1bHxZb4ZHfRPdVJK3+3RfPSdagtQDqGXyAYKnVB1/AVZmyxuHJQaux0VuM7ZHJYQ6
         KHoC4X3x9u3nTfe0eEA7E446wPGGXtE+w2NQdOgnyN4T4odUa0wkKmuMtjbS8fLHkWcZ
         /qKfkvPrCgWk0lHgjJCzvZovn0q7fmkGFOJTxU1x/O+euKkNKQlk5fbWHx71qwD5BCMK
         uSdOmbKahkMED+Bw/GrNcL/eXkOpbLJw12fu5YZ3lbClz1qbyUouHeoSJrZnQXHRFz/y
         OgHw8dafkwZT5DObQfg4/h7gysN+UZ9IuuJItoNjrDa82UQUNKWjt+uZkfKzLze+PQcS
         lh5Q==
X-Gm-Message-State: AA+aEWbcdOVMr/bkqR0mGAyPig35iBFdcOSDLSvnh4QHHPwsGz3MgqbB
        C8Ko7Uyhsjycc+YSz76goRKrTLQ6drcYUl3FHOaBCw==
X-Google-Smtp-Source: AFSGD/Uha3wQbE+rV2ORNNxCuTN4I4vqZTI6b9rVxda/BSASuu2kHNbpiC8Bv8heKUrA0Iabx9c27ymNDs0H86IqJNk=
X-Received: by 2002:aca:4307:: with SMTP id q7mr1019460oia.105.1544764897688;
 Thu, 13 Dec 2018 21:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com> <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz> <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard> <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard> <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
In-Reply-To: <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Dec 2018 21:21:26 -0800
Message-ID: <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     david <david@fromorbit.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 7:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/12/18 4:51 PM, Dave Chinner wrote:
> > On Wed, Dec 12, 2018 at 04:59:31PM -0500, Jerome Glisse wrote:
> >> On Thu, Dec 13, 2018 at 08:46:41AM +1100, Dave Chinner wrote:
> >>> On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
> >>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> >>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> >>>>> So this approach doesn't look like a win to me over using counter in struct
> >>>>> page and I'd rather try looking into squeezing HMM public page usage of
> >>>>> struct page so that we can fit that gup counter there as well. I know that
> >>>>> it may be easier said than done...
> >>>>
>
> Agreed. After all the discussion this week, I'm thinking that the original idea
> of a per-struct-page counter is better. Fortunately, we can do the moral equivalent
> of that, unless I'm overlooking something: Jerome had another proposal that he
> described, off-list, for doing that counting, and his idea avoids the problem of
> finding space in struct page. (And in fact, when I responded yesterday, I initially
> thought that's where he was going with this.)
>
> So how about this hybrid solution:
>
> 1. Stay with the basic RFC approach of using a per-page counter, but actually
> store the counter(s) in the mappings instead of the struct page. We can use
> !PageAnon and page_mapping to look up all the mappings, stash the dma_pinned_count
> there. So the total pinned count is scattered across mappings. Probably still need
> a PageDmaPinned bit.

How do you safely look at page->mapping from the get_user_pages_fast()
path? You'll be racing invalidation disconnecting the page from the
mapping.

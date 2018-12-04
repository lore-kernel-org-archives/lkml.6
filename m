Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D370F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NOd8zfHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D370F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLDU3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:29:11 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36383 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeLDU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:29:11 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so15496542oix.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EaCEfmpImkvTz3VdssIYIYR2oggAbhL8kH3SI+sFS4=;
        b=NOd8zfHc1Zwo1mNFxUxQfpthFk/xHaf51OlhY3msRAvrSSmHPxBNk5fQrFcNVYFBFl
         e8EM25Hq+PTdIyhibwPAnyDaCBIH7KgXMIOEsMG+gOuIX1nAPU4Sk/3MIbL6DYBVv5iD
         nm1owj3h/cu7HFp5c2rsDmY+LDYf81/IDxWQ6M+t9BJQRlySDS5M5jgtK5GumVZ7zas/
         DKt5UO+Alve0cyDxQ89gcIRjaCfpioT9xnJ5vaDCcYsjTFodmStSqcKXiO+882q1BcQs
         BygZEKR3Mfq9XXw5SjopqzcRuPOWQY3Qr/p58tUFbgcn5Ah50NCkxLG5/FkoFsAb3RIO
         e//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EaCEfmpImkvTz3VdssIYIYR2oggAbhL8kH3SI+sFS4=;
        b=rtTqMF3r6VWPlFVJnJP4MbCTCgKDdaQ6/nHJa4oWn5V4iYadLTpnU/gBHcBToxdHli
         NW7ByO25TWFqYDgr5cT/MJIHeD5z34zV2CU8rc3SGF4VVfsulXVImpqglm8TAdGdSGRq
         tbrO0Swrpr9dfgt5kvfEnuLc/ktpycVVCiGAczodp3mhy00o8wbnqPBgZsOHO0aCYIdN
         A7Y34N9JYuOgJf0kNx4IehZqxhBHwXH9aCZ8b9RjxfROI86bBkfZd/LaAmKs3BWTBjaJ
         gf+louktZGkyQMm+zMAknm5o9HRaoRp7TgEqty1Cyny/jVGkJ10fg6dRq5Wla1M/DpLE
         5vYA==
X-Gm-Message-State: AA+aEWbcmQfgf9/lXgLRZlPFlVxxvsOg4vWWJl64dMrvwisy3MPQnUQ9
        Aj6ae+uRLFQalfXd0E5DjGoVVW/nsw9/r7pZp1sLug==
X-Google-Smtp-Source: AFSGD/Vq9YXJSZVGq6/MxUQWzw2KuBCL6VqltJo+DfqW9qS4LbvIG90iUtMqnE2z8n7buJYlUlPAphPR9OE1cZg8s40=
X-Received: by 2002:aca:5205:: with SMTP id g5mr13859562oib.149.1543955350462;
 Tue, 04 Dec 2018 12:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
In-Reply-To: <20181204001720.26138-2-jhubbard@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 12:28:59 -0800
Message-ID: <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     John Hubbard <john.hubbard@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 4:17 PM <john.hubbard@gmail.com> wrote:
>
> From: John Hubbard <jhubbard@nvidia.com>
>
> Introduces put_user_page(), which simply calls put_page().
> This provides a way to update all get_user_pages*() callers,
> so that they call put_user_page(), instead of put_page().
>
> Also introduces put_user_pages(), and a few dirty/locked variations,
> as a replacement for release_pages(), and also as a replacement
> for open-coded loops that release multiple pages.
> These may be used for subsequent performance improvements,
> via batching of pages to be released.
>
> This is the first step of fixing the problem described in [1]. The steps
> are:
>
> 1) (This patch): provide put_user_page*() routines, intended to be used
>    for releasing pages that were pinned via get_user_pages*().
>
> 2) Convert all of the call sites for get_user_pages*(), to
>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>    call sites, and will take some time.
>
> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>    implement tracking of these pages. This tracking will be separate from
>    the existing struct page refcounting.
>
> 4) Use the tracking and identification of these pages, to implement
>    special handling (especially in writeback paths) when the pages are
>    backed by a filesystem. Again, [1] provides details as to why that is
>    desirable.

I thought at Plumbers we talked about using a page bit to tag pages
that have had their reference count elevated by get_user_pages()? That
way there is no need to distinguish put_page() from put_user_page() it
just happens internally to put_page(). At the conference Matthew was
offering to free up a page bit for this purpose.

> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
>
> Reviewed-by: Jan Kara <jack@suse.cz>

Wish, you could have been there Jan. I'm missing why it's safe to
assume that a single put_user_page() is paired with a get_user_page()?

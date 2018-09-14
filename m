Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88BECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A11220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="H6xOLBXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A11220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeINW4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:56:24 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:41242 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeINW4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:56:23 -0400
Received: by mail-ot1-f45.google.com with SMTP id e18-v6so5350303oti.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LNjGpuLxCcWQWpdF58YgOaCxoCjPp8J7c7Q6w8SmxjU=;
        b=H6xOLBXzlW97tBQ97/WUw94R8NspYYsGCOOg25OVWQpCe0LcD/ZTN9p7VtuNx730HW
         6qXaRsmuQxjUKnv0ckMhj3QcMS3wGN3N8lGsPNfzZCB4DsZF6tVHE/yU4hcUxTxCy0z5
         RAbiguTAndXUPngquxvFKrwu3BhKcqoa8VGb0qL8LxGZeBXEPtin5pIcZQ5rm/wj5zos
         +v6OddKOWSpOfU0MbEERxZ+mP3wsENfP2jeDhhFGB279VFcBtzf+2Ifid3iQ/b+I0NlX
         Z7JJwiJoasFJD8ui+eBgBhAT27iS1PYSgA2eHne/8WuzPx8SCj961zHiuRsW791U63+9
         ocRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LNjGpuLxCcWQWpdF58YgOaCxoCjPp8J7c7Q6w8SmxjU=;
        b=rb7UPVFjQRxF1DasoT/ncKNTYFJKExEEgG7s/dASBeAVwuPbPEa8dKra7oXI4JBRjb
         8c8oJK5ubrUAcIE0Nx6W6fyRUXMadf+YocaUjMKTnrtJ7UTh0lFz8YyhQhmD39TAOVqT
         GsnMqfKGOSHNb5d9WFW27a3e0vpEUOwma3/rJBONyCaRYgn917eZ0nzMcatjd0bwlB3g
         L84CUXfybaAoyo3kiGjNl0CQgL3d9GYXSl6YIJTk9wuCP7txCoosXJiLBNWfUqJ6HORE
         Smry8H3qjPDqV5ZqZIqsrWvUC59LJglWH04cxtRgeUAvSYH3T05pQYLoleRb4h2v2sOU
         SotQ==
X-Gm-Message-State: APzg51AbIKlvj+fvukSHd/j2p3O3Amy+4UQ8fk1/5tOOgna47aeMxxrK
        7+8rMvwCuAVfc72OtRFChCEkVCxsioOheGmdQ+IuXg==
X-Google-Smtp-Source: ANB0VdYNzziC2fHIcxoLoIMMwrzj+qmwF+yMkyIRQGXf4fJs2HmWdFL/63XouVUZkOKOgcC9xVxciy+W+CXIB8t9dMU=
X-Received: by 2002:a9d:7353:: with SMTP id l19-v6mr4863094otk.7.1536946853053;
 Fri, 14 Sep 2018 10:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Fri, 14 Sep 2018 10:40:52
 -0700 (PDT)
In-Reply-To: <20180914131420.GC27141@lst.de>
References: <153680531988.453305.8080706591516037706.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153680533172.453305.5701902165148172434.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180914131420.GC27141@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 14 Sep 2018 10:40:52 -0700
Message-ID: <CAPcyv4gj1E75rZ7kUVfO--CDK_u=-Qci06qmu+cQhaH8V=szGA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] mm, devm_memremap_pages: Kill mapping "System RAM" support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 6:14 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Sep 12, 2018 at 07:22:11PM -0700, Dan Williams wrote:
>> Given the fact that devm_memremap_pages() requires a percpu_ref that is
>> torn down by devm_memremap_pages_release() the current support for
>> mapping RAM is broken.
>
> I agree.  Do you remember why we even added it in the first place?

It was initially a copy over from memremap() that catches these
attempts and returns a direct-map pointer.

Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92086C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDD820856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="x2dQ5VNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbfA2Uvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:51:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42220 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfA2Uvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:51:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id v23so19153954otk.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sm0C8uNoBe+bGoNiTlTfD56A+1LmrUUdkZUy9VizQWU=;
        b=x2dQ5VNcnVPbB/3914tiLEowS6woiNf8m3LiZx+ju5NM3v2hVeBlbL5BB+2F3v8tI9
         8bCjWLHXDZraJiv5GcKCkDn+hDrl58AafZEFzNUwaTMcg0ITbieMksWTXZ+WXUO5yymp
         WT6Z1iZa70ZpL7xjPHjzcdu96ri3Gp92IiU5i0Zf5gucfPZ7J5ct3paPY5Lur4Vc1WQA
         g4JwYYZLzKp+AC82ktXAm3QGps1+EiY7OOb/Mdw2QelncymUyJ5Z70158dBvt5zq2icc
         CjlUBzlJXzvaGvW8l+NoooQg0boOnHnARMpgJLX/wBYYIhhMs/2IkGwy+MX1OttGq5Ck
         Ombw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sm0C8uNoBe+bGoNiTlTfD56A+1LmrUUdkZUy9VizQWU=;
        b=KZVAhuKxFi5IWHvLJbZP8kI0MFApA410iAIyshfaSPxyY5ZO/tsljxUlWAvEMfJIS+
         uy79/SpDguuBYshLaSXeYayVxZm7NRSsByhBd0I/kV9PTNHjViC91WRdeUgyilDDv2eS
         f6emwBpsPOSBBS41SW4ifdf4xSz10DR2WINqqpSV1Fc3BDTm2wCAbCfSbXUGtX3N1C7Z
         EB6E7xWeJqR5Ug/w0t1/MiO1HvWWUG2zk0VuHLFGKp5VkO9hyEpTOFORGt1sQazyHt0E
         8RfD2HUHj7Ns5D/e1lXY6ovFsSgcNpkd8gPULYhHk8/+2tg0PlTnCvdh3CRSE7INyOEY
         FLeQ==
X-Gm-Message-State: AJcUukfg+URUkVOYDMmJSAtUHGVDPtVxUQXlRWkE/5P7LcLj9r8ZEEWT
        MdjmnkZPL1fAEbSRFjvAPXmRdZuiweRdE27772MtE7N0
X-Google-Smtp-Source: ALg8bN7nGMnDAxFShZDbVEGc5m0fcNw41rSBLb27K1CZLYgEIBC+fjBSxWrbi+E2BQVSfwLrE6d6AQ/pP4xiQag4yws=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr20886983oti.367.1548795097418;
 Tue, 29 Jan 2019 12:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-10-jglisse@redhat.com>
 <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com> <20190129193123.GF3176@redhat.com>
In-Reply-To: <20190129193123.GF3176@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 12:51:25 -0800
Message-ID: <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:32 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Jan 29, 2019 at 10:41:23AM -0800, Dan Williams wrote:
> > On Tue, Jan 29, 2019 at 8:54 AM <jglisse@redhat.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > >
> > > This add support to mirror vma which is an mmap of a file which is on
> > > a filesystem that using a DAX block device. There is no reason not to
> > > support that case.
> > >
> >
> > The reason not to support it would be if it gets in the way of future
> > DAX development. How does this interact with MAP_SYNC? I'm also
> > concerned if this complicates DAX reflink support. In general I'd
> > rather prioritize fixing the places where DAX is broken today before
> > adding more cross-subsystem entanglements. The unit tests for
> > filesystems (xfstests) are readily accessible. How would I go about
> > regression testing DAX + HMM interactions?
>
> HMM mirror CPU page table so anything you do to CPU page table will
> be reflected to all HMM mirror user. So MAP_SYNC has no bearing here
> whatsoever as all HMM mirror user must do cache coherent access to
> range they mirror so from DAX point of view this is just _exactly_
> the same as CPU access.
>
> Note that you can not migrate DAX memory to GPU memory and thus for a
> mmap of a file on a filesystem that use a DAX block device then you can
> not do migration to device memory. Also at this time migration of file
> back page is only supported for cache coherent device memory so for
> instance on OpenCAPI platform.

Ok, this addresses the primary concern about maintenance burden. Thanks.

However the changelog still amounts to a justification of "change
this, because we can". At least, that's how it reads to me. Is there
any positive benefit to merging this patch? Can you spell that out in
the changelog?

> Bottom line is you just have to worry about the CPU page table. What
> ever you do there will be reflected properly. It does not add any
> burden to people working on DAX. Unless you want to modify CPU page
> table without calling mmu notifier but in that case you would not
> only break HMM mirror user but other thing like KVM ...
>
>
> For testing the issue is what do you want to test ? Do you want to test
> that a device properly mirror some mmap of a file back by DAX ? ie
> device driver which use HMM mirror keep working after changes made to
> DAX.
>
> Or do you want to run filesystem test suite using the GPU to access
> mmap of the file (read or write) instead of the CPU ? In that case any
> such test suite would need to be updated to be able to use something
> like OpenCL for. At this time i do not see much need for that but maybe
> this is something people would like to see.

In general, as HMM grows intercept points throughout the mm it would
be helpful to be able to sanity check the implementation.

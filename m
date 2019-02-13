Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE6222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vq6KrWoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392723AbfBMQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:50:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46109 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388561AbfBMQuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:50:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so5315263otm.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 08:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtYAbd61b340Vd3goSh2N2gZ0biExBnNhPdti+q3fWM=;
        b=vq6KrWoRpJa7Efj9KN5Rx9KajsCeZCXqEFYqOZEKwKqpVb0f2e9tb95B49AOibTbEq
         LZXHlLJHGxc7fdixDC3Y9zWBuiC+AMyP+AxiFG5U+D8vAlz3kFUYQr9aYHHLDniugXj8
         WWuICq9NJwnwc3gzVZF5/8t5GxRY7+LcbuNCQoBzjQVc222d7pyrlJn291tFup8Wcf7Z
         MhFGMcua74XKheGnIy642YVsyNQ1cJ9vd63NC1wVFogKV95KCSWLVxU6edqmofmWeyTj
         b3pHtHFLLxG+XPw9+ULrktNH8eBG1G8muF7N5H+/SQco+9N9cZ34MiU5vxD0joUquTK0
         UzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtYAbd61b340Vd3goSh2N2gZ0biExBnNhPdti+q3fWM=;
        b=skpSSO/Df/P0BC0osjXcaArtFlnokgqCFIvvZ9Xq+p2nFVYAC8TTZ/CxMLN9nP1vwf
         +uk4M1Gs3OuUnK1oqgS0NF/S/ECLFhGMIXw8J9mmi0GjgOIva2w5mXVY2+GK3fzukKjm
         xEZKkYGNXVLqSpbSQI+QvWl/wEPwz317xfAH2FXBY1CSQeScZ74pnxX/vvc/HnaGYiBB
         7E1HjLf2nTUZMlZ+DiQNqDf6lDJisrjpT5+xNqM2UldB+xyH0jFgDVvdakp1blM1K/hy
         FS0x0Z7JXgqBUFxRdM/hMIJvPZ8MgLJc8Qk+m46OXJX8gx5TxQELSdjK79MdpgXOYlVL
         8IVA==
X-Gm-Message-State: AHQUAuZ6ZJvNgSCeIV/FZbxe2hH71l2jXSqcokJ6OUASplTmJFheB85A
        4ZST6WrnsEhdmElONVUaS9aqDnwgO6UyGduFFF0uE64q
X-Google-Smtp-Source: AHgI3Ia0ed/GAdXV+nQu5iOaR0+5225WY3WzLkQZzkMBgFVte6GfZt/3WWPbEklP7enNysMV+oh68M6me5d4LBgnUCY=
X-Received: by 2002:a05:6808:344:: with SMTP id j4mr770099oie.149.1550076599649;
 Wed, 13 Feb 2019 08:49:59 -0800 (PST)
MIME-Version: 1.0
References: <155000668075.348031.9371497273408112600.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155000669646.348031.16690970886357498896.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190213102202.GA13313@quack2.suse.cz>
In-Reply-To: <20190213102202.GA13313@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Feb 2019 08:49:47 -0800
Message-ID: <CAPcyv4jwMx2ohs9QobTohL8jxc5G74XhmY5QFpmiVF9siWLuwA@mail.gmail.com>
Subject: Re: [PATCH 3/7] dax: Check the end of the block-device capacity with dax_direct_access()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 2:22 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 12-02-19 13:24:56, Dan Williams wrote:
> > The checks in __bdev_dax_supported() helped mitigate a potential data
> > corruption bug in the pmem driver's handling of section alignment
> > padding. Strengthen the checks, including checking the end of the range,
> > to validate the dev_pagemap, Xarray entries, and sector-to-pfn
> > translation established for pmem namespaces.
> >
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/dax/super.c |   39 +++++++++++++++++++++++++++++----------
> >  1 file changed, 29 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 6e928f37d084..a27395cfcec6 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -86,12 +86,14 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
> >  {
> >       struct dax_device *dax_dev;
> >       bool dax_enabled = false;
> > +     pgoff_t pgoff, pgoff_end;
> >       struct request_queue *q;
> > -     pgoff_t pgoff;
> > -     int err, id;
> > -     pfn_t pfn;
> > -     long len;
> >       char buf[BDEVNAME_SIZE];
> > +     void *kaddr, *end_kaddr;
> > +     pfn_t pfn, end_pfn;
> > +     sector_t last_page;
> > +     long len, len2;
> > +     int err, id;
> >
> >       if (blocksize != PAGE_SIZE) {
> >               pr_debug("%s: error: unsupported blocksize for dax\n",
> > @@ -113,6 +115,15 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
> >               return false;
> >       }
> >
> > +     last_page = ALIGN_DOWN(part_nr_sects_read(bdev->bd_part)
> > +                     - PAGE_SIZE / 512, PAGE_SIZE / 512);
>
> Why not just (i_size_read(bdev->bd_inode) - 1) >> PAGE_SHIFT?

Because that would be too elegant and straightforward?

> Otherwise the patch looks good to me.

Thanks, I'll fix up the last page calculation.

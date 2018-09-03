Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE322077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDBsSsPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE322077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeICQSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:18:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41426 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeICQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:18:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26-v6so249531lfc.8;
        Mon, 03 Sep 2018 04:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWfFtKEXLIgf34eCbvIIXYJRnv6Mn0W+bU4lB0gtq4c=;
        b=RDBsSsPjcj6d10ax10aWoMLYqx+2XHJM4jfnxxQVLzq2ZAv50atQ3CMUJ1zp9x+WIO
         UDGz9yjYDJrPVhUPx6wXbVMh/nlF+b0XwATOlGblPmIoerHfM2TTeT5bEMaFiyAoUryz
         +J1D1LZp6a13X4JNDHmgkrD4wuZRoffDDn/Utm0LADHBYwTmvQsYeRcSpgPXOjmnGcQL
         MFNt4FNMj3MowmJEXuToFN46/LFyHDy+MbL+LGScIQPVSwkvnzd2/ei8bVyyE5/cc1as
         9ARKj0bYx1o7peSWHMZ7tllUiyJ3AzIeUoqBmKkVkkps+8uvHvhXZPZBVLhrocPuYkdL
         ZFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWfFtKEXLIgf34eCbvIIXYJRnv6Mn0W+bU4lB0gtq4c=;
        b=SLmJyJ9s9MMJJ4W9dxJpw1F8VevL5M+SSWIck7RLX1/91fi+Nw8oModeXRq1SpwSXS
         WaFmS7fVF6EXa/D0cQOCTnh0xJaPnS8a32JyGNY9iV/DBOtSJHQmFwYAZgm4FqJ8Kv6g
         KF4dEadKMzuLo+vbaSRY7dFPQxe0AIqRRmDDm6FMA6sTTsX4s9UDWnrvdqU1wOuGGeFp
         VK6c0W+lIQTKPaZGlKZukqZ6zTo+S49jjOX6GktJMbhYDofHJ3EX3uKJ71rmRsA7ZVZ4
         QxjD9NBtwbrMUVGSWrSsPmc2/Zmpoo8C9VsBYgsDJpoPN4VA7pVLQxhbK+qHoM1Ful08
         Bj5g==
X-Gm-Message-State: APzg51BNM4WuDahsd8ghKOVc7y3pyGy/c23jE3ZeAUG83RzQfYyynvey
        MRlrVsrdjmPv9iVfLUWfwFQjzVIoSO2P0XUkp4Y=
X-Google-Smtp-Source: ANB0VdbI/hH5Yr4fC0d2Bj26/iSW/+dFuCQdG24tZvflZGavJ+wTl5t33mA0XKv36O4B3AKDfJe6Z+KQurPRS4qSK3o=
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr6169529lfa.139.1535975938759;
 Mon, 03 Sep 2018 04:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180830172547.GA4408@jordon-HP-15-Notebook-PC>
 <20180830163352.5a96cc721ce069bed95fdbe8@linux-foundation.org> <20180903.111310.853324894545237861.konishi.ryusuke@lab.ntt.co.jp>
In-Reply-To: <20180903.111310.853324894545237861.konishi.ryusuke@lab.ntt.co.jp>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 3 Sep 2018 17:28:46 +0530
Message-ID: <CAFqt6zY41OnT6F8F7vyUEJcc_RPoF3mALAOS7CUMUvQv8GdG0w@mail.gmail.com>
Subject: Re: [PATCH v2] fs: Convert return type int to vm_fault_t
To:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 7:43 AM Ryusuke Konishi
<konishi.ryusuke@lab.ntt.co.jp> wrote:
>
> Hi Souptick,
>
> On Thu, 30 Aug 2018 16:33:52 -0700, Andrew Morton wrote:
> > On Thu, 30 Aug 2018 22:55:47 +0530 Souptick Joarder wrote:
> >
> >> Return type for fault handlers  in ext4 and nilfs are
> >> changed to use vm_fault_t.
> >>
> >> Return type of block_page_mkwrite() is changed from
> >> int to vm_fault_t. The function signature of
> >> block_page_mkwrite() is changed to add one new parameter
> >> int *err. This will provide a way for caller functions
> >> to get error value along with return value and use it
> >> further.
> >>
> >> Return type of block_page_mkwrite_return() is also changed
> >> to use new vm_fault_t type.
> >> --- a/fs/nilfs2/file.c
> >> +++ b/fs/nilfs2/file.c
> >> @@ -51,13 +51,14 @@ int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
> >>      return err;
> >>  }
> >>
> >> -static int nilfs_page_mkwrite(struct vm_fault *vmf)
> >> +static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
> >
> > nilfs_page_mkwrite() already has return type vm_fault_t in Linus's
> > kernel, due to the now-merged
> > fs-nilfs2-adding-new-return-type-vm_fault_t.patch.  Looks like a simple
> > fix.
>
> In the first patch in this thread, this return type change was
> excluded correctly for nilfs_page_mkwrite() though the changelog was
> inaccurate in that sense.
>
> Please confirm your base point of the revised patch.
>

Ryusuku,
Base point of revised patch is to address your comment by
removing err = 0. Nothing else was suppose to there in v2.

But unfortunately I mixed up my local branches and created v2 against
old branch which leads to confusion of v1 -> v2 delta changes.
Sorry for creating more confusions.

>
> >
> > I'm beginning to feel vm_fault_t exhaustion.  Please remind me what
> > benefit we're going to get out of all this churn?
> >
> >>
> >> ...
> >>

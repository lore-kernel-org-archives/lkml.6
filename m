Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13572086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13572086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeGCVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:52:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43414 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeGCVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:52:05 -0400
Received: by mail-io0-f195.google.com with SMTP id i23-v6so3067610iog.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 14:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZBUt8Pl93+7RpJzzHc1DGd/Rk9f0rUCPOb8qgMAKlBk=;
        b=L8xXK38Nyqotug3AYEJOcAQffDLPGPWKMgCtrD3JZiVvnrmCdhYB/fiO1hjG475k09
         MhClaRf1qLFYuZRlA2tkE9ij/7/zZxHuewUPp0cCoflWd5+eZP8VUFz+tbIkoIlWGNjr
         y4HYCAmPEMo+eAjolk4ZqOmWYxk8ZQwfYI6oRLyXkARKjgOaEGpKQuQ7wn1+IAkWCJWz
         Amm+peilWu6lX4J+240Qvop/wvmOD0l4+JDNebyKDubM3I9exXAzNOEEbFWVepuJvhDC
         bzqsXfLmk977VVSBRi17UhvGY4Q9XDKJmWl+jeC36umD3aY6NX0Le0QD8+rAoguRITSk
         nAsg==
X-Gm-Message-State: APt69E00XRq1jAIV89+xp3ylshHgVFmWBRTWjIeJLFF5d+0wxjk2x/hT
        nA0fUZrzcp8lrfBUU3d+cMl0m9oMDligyhhTfFBGZw==
X-Google-Smtp-Source: AAOMgpdxRnukMxRHnUA73lUTi54FaSEwobBfN6/LANtVDL0FqxjdOWxbSwZAho51JdgDdKO7rxD3Lzjk38jvgEWcKts=
X-Received: by 2002:a6b:9bd1:: with SMTP id d200-v6mr5453722ioe.147.1530654724938;
 Tue, 03 Jul 2018 14:52:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5882:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 14:52:04 -0700 (PDT)
In-Reply-To: <20180703213943.GU32415@magnolia>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com> <20180703213943.GU32415@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 3 Jul 2018 23:52:04 +0200
Message-ID: <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, willy@infradead.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 23:39, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Mon, Jul 02, 2018 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
>> On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> > Return type has been changed to vm_fault_t type for
>> > iomap_page_mkwrite().
>> >
>> > see commit 1c8f422059ae ("mm: change return type to
>> > vm_fault_t") for reference.
>> >
>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>
> I don't recall Christoph [now cc'd] rescinding his NAK of the previous
> version of this patch[1].  Has he changed his mind since May?

Oops, a reply gone wrong -- I was meaning to reply to Souptick
Joarder's gfs2 change which I've added to the gfs2 for-next branch.
Not the iomap change. Sorry for the confusion.

> [1] https://spinics.net/lists/linux-fsdevel/msg126032.html
>
> Now granted I didn't have a problem with the code (and applied the xfs
> version to 4.18 after monitoring to satisfy myself that nothing
> particularly weird happened during 4.17) but seeing as most of the iomap
> changes have gone through hch's review and landed via the xfs tree...
>
>> > ---
>> >  fs/iomap.c            | 2 +-
>> >  include/linux/iomap.h | 4 +++-
>> >  2 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/fs/iomap.c b/fs/iomap.c
>> > index afd1635..58477ee 100644
>> > --- a/fs/iomap.c
>> > +++ b/fs/iomap.c
>> > @@ -443,7 +443,7 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
>> >         return length;
>> >  }
>> >
>> > -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>> > +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
>> >  {
>> >         struct page *page = vmf->page;
>> >         struct inode *inode = file_inode(vmf->vma->vm_file);
>> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>> > index 19a07de..666b717 100644
>> > --- a/include/linux/iomap.h
>> > +++ b/include/linux/iomap.h
>> > @@ -3,6 +3,7 @@
>> >  #define LINUX_IOMAP_H 1
>> >
>> >  #include <linux/types.h>
>> > +#include <linux/mm_types.h>
>> >
>> >  struct fiemap_extent_info;
>> >  struct inode;
>> > @@ -88,7 +89,8 @@ int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>> >                 bool *did_zero, const struct iomap_ops *ops);
>> >  int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
>> >                 const struct iomap_ops *ops);
>> > -int iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops);
>> > +vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
>> > +                       const struct iomap_ops *ops);
>> >  int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>> >                 loff_t start, loff_t len, const struct iomap_ops *ops);
>> >  loff_t iomap_seek_hole(struct inode *inode, loff_t offset,
>> > --
>> > 1.9.1
>> >
>>
>> Added to for-next, thanks.
>
> ...this part caused me to sit up and say "Hey what?" :)
>
> Which tree is this? gfs2?
>
> --D
>
>>
>> Andreas

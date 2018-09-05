Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0BFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5F2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfBcCA7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B5F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeIFAuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:50:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38657 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIFAuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:50:25 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so11189227ite.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtGzftbrx8VqSJw5GgJxp/l4xWPRbYE69E+0izJXeXI=;
        b=XfBcCA7QcSC+XgOEl1/KObH0kBVFJN9Ju6XzLCiSeLseGjiE6jTFIdnm8BXOBWVSe1
         Etre6QRU5CqwbQiTNESu+WMKb7lXZuboDs2CnHi3m8mtF7OShDpidZnLVzBwdqzcYLOs
         XHWOP6h5nH0S054eq8ep/TxeVkGTLxZMLDMzCABwVJ2lsWyNCD3rErw8nxNq+cPH8fH9
         LJnw410U/oYN3ikP+8tYRNwY1doupyYHunqVf+awgK5urqw1uE0GM+Q4WSplK53ROgfm
         MKAGdqa9ExrAvXuuXFgJ+gODryJ54HSsfcTG4mJGL4rC0lidhyA7s2bOjNmr9xnSswWk
         QF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtGzftbrx8VqSJw5GgJxp/l4xWPRbYE69E+0izJXeXI=;
        b=NfmoattsFxfqnHnJHsebW0Uv/gJxDQ3GsXcsyrGIg1IO+YRxtSzO0TOghihshQzd8n
         R0JzKe7DLXJjkK+Vnv+4gHs9lzyVDX0h3kyLi9ybXRZLcUALs0mHkZUYwWy50L37E4hr
         hHbiGai0XGF8oaF9d4CAr0iKnrJEJ3pAEQ86/movsiFyLec7gFtqYsQCDHQS3CyEJtS2
         z1KkFoxfMSpY0UUrpovSKA/mIY/4spsIoO5piZPkcjhwgoW+5YCgldowWzrjbSftwhUw
         2XeFtn/n4ff/macSQT4XlBEbSulvuQNd0d0ix0DN29+w7gK0myqf1WfWQvsnH6D6XSWk
         NtEg==
X-Gm-Message-State: APzg51B+II3rwhx8Kf/WE3gS6ZoOT+/lvJQF5h6BnASa4tJghVUmZdA0
        jZgziLWZmKmOjooTZ4q8DyeguEnLcqsbHL9wmVE=
X-Google-Smtp-Source: ANB0VdZDf9C5GHKLAJjfxTaYulyk7LcWlGLek3IVl5B/xF2gJN5k5Tt3kwxaafKn7wWDZGmOefbQrwBcTBXK1jeGwa4=
X-Received: by 2002:a02:b38c:: with SMTP id p12-v6mr8190829jan.79.1536178716343;
 Wed, 05 Sep 2018 13:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180904181550.4416.50701.stgit@localhost.localdomain>
 <20180904183345.4416.76515.stgit@localhost.localdomain> <20180905062428.GV14951@dhcp22.suse.cz>
In-Reply-To: <20180905062428.GV14951@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 5 Sep 2018 13:18:24 -0700
Message-ID: <CAKgT0UeT1dL0VNMo1RSDkjABYBGLKjMsz5LsE_ML-EV+w2OURg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Create non-atomic version of SetPageReserved for
 init use
To:     mhocko@kernel.org
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 11:24 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 04-09-18 11:33:45, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > It doesn't make much sense to use the atomic SetPageReserved at init time
> > when we are using memset to clear the memory and manipulating the page
> > flags via simple "&=" and "|=" operations in __init_single_page.
> >
> > This patch adds a non-atomic version __SetPageReserved that can be used
> > during page init and shows about a 10% improvement in initialization times
> > on the systems I have available for testing.
>
> I agree with Dave about a comment is due. I am also quite surprised that
> this leads to such a large improvement. Could you be more specific about
> your test and machines you were testing on?

So my test case has been just initializing 4 3TB blocks of persistent
memory with a few trace_printk values added to track total time in
move_pfn_range_to_zone.

What I have been seeing is that the time needed for the call drops on
average from 35-36 seconds down to around 31-32.

> Other than that the patch makes sense to me.
>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>
> With the above addressed, feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!

As far as adding a comment are we just talking about why it is
reserved, or do we need a description of the __SetPageReserved versus
SetPageReserved. For now I was looking at adding a comment like:
@@ -5517,8 +5517,13 @@ void __meminit memmap_init_zone(unsigned long
size, int nid, unsigned long zone,
 not_early:
                page = pfn_to_page(pfn);
                __init_single_page(page, pfn, zone, nid);
+
+               /*
+                * Mark page reserved as it will need to wait for onlining
+                * phase for it to be fully associated with a zone.
+                */
                if (context == MEMMAP_HOTPLUG)
-                       SetPageReserved(page);
+                       __SetPageReserved(page);

                /*
                 * Mark the block movable so that blocks are reserved for

Any thoughts on this?

Thanks.

- Alex

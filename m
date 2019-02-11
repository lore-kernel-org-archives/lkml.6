Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA571C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E8E2229F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EtoIsmNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfBKSPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:15:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46654 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBKSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:15:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so19044694otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul5thXc6++/JQFU35y5jSqKTerpNjS/zr14LWC0b/Yo=;
        b=EtoIsmNkDKQpRH9ypOI5wOHAdlLYheZn+QoXMnH9j3ESgJ+H9ofHEeQ2+z0WgQiKEr
         x9nF4ZYK4if03fgMSHrIocO7JgQkq8nUlENbhQkgchPEbtsIq8nWqKuoL+Jovt6l77PC
         N7xGDCZnhMddxom8jz7HGzV8UCnt66iV8NXbA1KODSySGADwC0E5Y6CoZ4HYts0xJDyd
         4crFfr0dStfGbzratLctbDnEN4KBjQvGMpQEabs0lF0hrPbIYi4QZy7IEaBYhZer3x73
         HknObt5JsH4ENZsCqWCBSk5ZIQ9H6iR5krsJEj/meW/V3iGfAGNFHjvjw7Qs3eii4g1d
         XMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul5thXc6++/JQFU35y5jSqKTerpNjS/zr14LWC0b/Yo=;
        b=QrPd+SIbX4a6wkEENaoI9/ivrZanQ609uhbkNi3Drf55vK0/XnUCzlJYGdyIYABzDp
         tf4YDJEBoobZQS6jc3WjdPHkHDlbA8G87ECPoQ48B63AGu2vg1+c428zi/pkY+31wBBa
         eQ39+uPIMIt53A7NTpejAo0WxFPPJ0ct57nSLRTXkIST07sCy/6KL0FfmfN3b3oTMnBS
         ODJtLHuAF4RaGE3TbIJvhq6wfD+r5p4Ne5sM10+PZ+fgaqHf9aie+J29LVUrKpUhE0Ij
         VQnIrfwY5XvyDfOVl46TBoaZ5gLjolmu9gclUXgPriQP6o0Q0/XsJnbFlPnr8bCcisUp
         BPLw==
X-Gm-Message-State: AHQUAuZhxuQTPtF1eTKuQNnJtPIy5iV8rxob+Y7DRXWwK+4fJadlAsRt
        GSkzxoHYz63kyjQN1BgWIzAcS4fwvwhQuo8VLe6KZA==
X-Google-Smtp-Source: AHgI3Ib8Tv/GTd/LyyhnRUStQh32TJGMr1mf9h0L5JluLyTEcL0lx7jgHtIyGdtYh7vMLGodX085tmaC6phK3LYN9V4=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr14708887otn.95.1549908944982;
 Mon, 11 Feb 2019 10:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20190206220828.GJ12227@ziepe.ca> <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard> <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz> <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
 <20190211180654.GB24692@ziepe.ca>
In-Reply-To: <20190211180654.GB24692@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Feb 2019 10:15:33 -0800
Message-ID: <CAPcyv4hdVwn0L8060_wxqDV0XBOwiUojSYjF+u+ugzLoQpcHzw@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:07 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:
>
> > I honestly don't like the idea that random subsystems can pin down
> > file blocks as a side effect of gup on the result of mmap. Recall that
> > it's not just RDMA that wants this guarantee. It seems safer to have
> > the file be in an explicit block-allocation-immutable-mode so that the
> > fallocate man page can describe this error case. Otherwise how would
> > you describe the scenarios under which FALLOC_FL_PUNCH_HOLE fails?
>
> I rather liked CL's version of this - ftruncate/etc is simply racing
> with a parallel pwrite - and it doesn't fail.
>
> But it also doesnt' trucate/create a hole. Another thread wrote to it
> right away and the 'hole' was essentially instantly reallocated. This
> is an inherent, pre-existing, race in the ftrucate/etc APIs.

If options are telling the truth with a potentially unexpected error,
or lying that operation succeeded when it will be immediately undone,
I'd choose the former.

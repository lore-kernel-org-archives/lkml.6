Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75737C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203BC20831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoQqezSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203BC20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbeKEPC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:02:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeKEPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:02:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so6832607lji.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 21:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJoarYVza2oCXvdZZpU19PDTNKrBqtii6z+LT3Sm1Xg=;
        b=WoQqezSEdAi+NB6f1707wEdQqfN2YwZNUjztX18SkFXY0JMprdTwm7tNoIsgoCD5Vt
         Kf7jHuzcQp5GHZnj8v1IjnxEf/+k6iMJ3NncLaeCDEw78D6wVV8iAb0BQR36x4MBQryk
         N/HgDagXrWRnJS06YY7knER+pZ4W0cGsRWxWmSYzTlgL4Gghl9DXoNOXW7titzYbqN6I
         rvlhBen4NFmghSVjhjEwwFnVbs9q7SuHbySu2Hu+e+a/wOzoLc4FfJeVBOermjvwagdp
         /wZHTMA3fW8C/CnidNEVypCgTX573s5Fvb2fgxewyTpUClk1v5C+bfhPHstcyZX+aGJ3
         PcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJoarYVza2oCXvdZZpU19PDTNKrBqtii6z+LT3Sm1Xg=;
        b=RW4T2FDNQz2+U/jXnzn0By4DdKaetut3fa1iZS8ZVNTKZZ0xI866Uk7d94xA3zdvaT
         e2RugwSmmur+1GSHYftsQ+yJQ0uIn7TMQPB8icmmpR0JowSdoUnq2mEWKxY+cIIRZYuw
         v11t8q2ZnIF1BTM4A00a1LYKuE3Hkjdi/+SYmgFn+2bY/pJTn5eWj6d87yjRRe9Fd1O7
         kW7dfrpU6wc0QgkPFh6YHmzIFk5sj6PGkaaqho3oSHJ5WsqSRxUGyArs105UGNJf29vn
         +6Z4qKynLtbn3SG1I8GQrYRPB1vBBw50/2/6z+10MvPM+TfAfxbKB9EZtnYGsUG0Yi4k
         k7VA==
X-Gm-Message-State: AGRZ1gJWlyrwzgoych5uZPDBWfdpQ5U8W6NwjqgTfP4b9hOJl4VBSl9N
        kkQCc4nmTfw5togKQMTHWdWAogH5jPLGNkbu+0Y=
X-Google-Smtp-Source: AJdET5ffTO+V7qGNWzN1G71l57nGWyAu7zW/Giqu14EUVti6/iFEY5wBHi3zVvSO/sdcdFyzvuDnkH4HXr5axi+u9sU=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr5286768lji.93.1541396670365;
 Sun, 04 Nov 2018 21:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org> <20181104083611.GB7829@rapoport-lnx>
In-Reply-To: <20181104083611.GB7829@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 5 Nov 2018 11:14:17 +0530
Message-ID: <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com>
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
To:     rppt@linux.ibm.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com, vbabka@suse.cz, riel@redhat.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Sun, Nov 4, 2018 at 2:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> > On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
> > > Page fault handlers are supposed to return VM_FAULT codes,
> > > but some drivers/file systems mistakenly return error
> > > numbers. Now that all drivers/file systems have been converted
> > > to use the vm_fault_t return type, change the type definition
> > > to no longer be compatible with 'int'. By making it an unsigned
> > > int, the function prototype becomes incompatible with a function
> > > which returns int. Sparse will detect any attempts to return a
> > > value which is not a VM_FAULT code.
> >
> >
> > > -/* Encode hstate index for a hwpoisoned large page */
> > > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> > ...
> > > +/* Encode hstate index for a hwpoisoned large page */
> > > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> >
> > I think it's important to mention in the changelog that these values
> > have been changed to avoid conflicts with other VM_FAULT codes.
> >
> > > +/**
> > > + * typedef vm_fault_t -  __bitwise unsigned int
> > > + *
> > > + * vm_fault_t is the new unsigned int type to return VM_FAULT
> > > + * code by page fault handlers of drivers/file systems. Now if
> > > + * any page fault handlers returns non VM_FAULT code instead
> > > + * of VM_FAULT code, it will be a mismatch with function
> > > + * prototype and sparse will detect it.
> > > + */
> >
> > The first line should be what the typedef *means*, not repeat the
> > compiler's definition.  The rest of the description should be information
> > for someone coming to the type for the first time; what you've written
> > here is changelog material.
> >
> > /**
> >  * typedef vm_fault_t - Return type for page fault handlers.
> >  *
> >  * Page fault handlers return a bitmask of %VM_FAULT values.
> >  */
> >
> > > +typedef __bitwise unsigned int vm_fault_t;
> > > +
> > > +/**
> > > + * enum - VM_FAULT code
> >
> > Can you document an anonymous enum?  I've never tried.  Did you run this
> > through 'make htmldocs'?
>
> You cannot document an anonymous enum.


I assume, you are pointing to Document folder and I don't know if this
enum need to be documented or not.

I didn't run 'make htmldocs' as there is no document related changes.

>
> > > + * This enum is used to track the VM_FAULT code return by page
> > > + * fault handlers.
> >
> >  * Page fault handlers return a bitmask of these values to tell the
> >  * core VM what happened when handling the fault.
> >
>
> --
> Sincerely yours,
> Mike.
>

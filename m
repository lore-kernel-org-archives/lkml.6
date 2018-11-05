Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E745CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9FD20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoVEzpeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9FD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeKEXK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:10:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46765 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKEXK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:10:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so8032132lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4ua9XwQ4pJKw7DZ1a0IBAGxtUWj5VAR/2o0p9Z3LNg=;
        b=eoVEzpeLAnVeXsRrFKUhzxlTNq8SJLdWI/HNe5o+9YKl5SxwlQX9wKNy8HX3XbVySC
         ScxJEkeSNkTZRbVE5IlrFGwCyQJZ28jeT3QV0ntuh5t4zdHdcWduchaV0HZTm4Bb71KW
         vRZYbLlWB3GwLzUNyweQ5f8bVm0D7IAX3foi9+mjm0MGwRtWCQkpU/0dfH7HwnYcrQDx
         T7U9hU5Okuw57O9OppWpxDTPM7ibjGiBR4LDnr4tnv7zBC1R1eoiyioKh6sxq+epb52F
         HVy2rxiQDJ8bATEujOEn1ABs0l7NakM/cb8wH7BIQ6tw4RAiqpXiS9+5Y3oxrgofc5UG
         1TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4ua9XwQ4pJKw7DZ1a0IBAGxtUWj5VAR/2o0p9Z3LNg=;
        b=i3AVGxq0PGL+U9pQOOZN5j1/AMVD/ww8OzuR5HSSStisdzX8hqoFIU3+IGll03KgyG
         f2JVW7cZWkhjfH99QspspiWrJvplyRLF4Md63efKLHXMhESKyCMS5s8h/Fmqg6aqlrBM
         WT42sglFpee1+z/GtNfSAxU3DlHcZnAPKMTX9kJM90YtUH2XxKN/pCNpW1zgp5/Yofsr
         UantwCxd21x7oKE81Cap0IP4RaOnYejNQfF+wrgB60innhtQZpBjZF56Yc61+3sx2KNE
         sXMke5eH6eD59RHUe5Ykq4/AKSVQxDQrH/8U7RZ+z8upEV383aXfr29YWvNii3FW6YVn
         yqOw==
X-Gm-Message-State: AGRZ1gLgLJnPIZ5JRfJxWUWmwI2nwyz1/ywHw2uwfXLn/5rTwqzSj+ms
        J2nhXiBB6Q38zelovU9JIH06F9SEuBaBEky5dSU=
X-Google-Smtp-Source: AJdET5cvoARynGJqT4c9fGt9Fc2TyOggYNmaHm7t/P5WdJqH+A2xoackdfDw/mBaZ+8v1mj/g8QLzmPfzeIiBDfepso=
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr13771677ljw.75.1541425833392;
 Mon, 05 Nov 2018 05:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org> <20181104083611.GB7829@rapoport-lnx>
 <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com> <20181105091302.GA3713@rapoport-lnx>
In-Reply-To: <20181105091302.GA3713@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 5 Nov 2018 19:23:55 +0530
Message-ID: <CAFqt6zYbb9xpnOhhoESq3BbF4aD0_UKzh=MrwJ-i+NiUqNh7+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: Create the new vm_fault_t type
To:     rppt@linux.ibm.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        vbabka@suse.cz, riel@redhat.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 2:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Nov 05, 2018 at 11:14:17AM +0530, Souptick Joarder wrote:
> > Hi Matthew,
> >
> > On Sun, Nov 4, 2018 at 2:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> > > > On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
> > > > > Page fault handlers are supposed to return VM_FAULT codes,
> > > > > but some drivers/file systems mistakenly return error
> > > > > numbers. Now that all drivers/file systems have been converted
> > > > > to use the vm_fault_t return type, change the type definition
> > > > > to no longer be compatible with 'int'. By making it an unsigned
> > > > > int, the function prototype becomes incompatible with a function
> > > > > which returns int. Sparse will detect any attempts to return a
> > > > > value which is not a VM_FAULT code.
> > > >
> > > >
> > > > > -/* Encode hstate index for a hwpoisoned large page */
> > > > > -#define VM_FAULT_SET_HINDEX(x) ((x) << 12)
> > > > > -#define VM_FAULT_GET_HINDEX(x) (((x) >> 12) & 0xf)
> > > > ...
> > > > > +/* Encode hstate index for a hwpoisoned large page */
> > > > > +#define VM_FAULT_SET_HINDEX(x) ((__force vm_fault_t)((x) << 16))
> > > > > +#define VM_FAULT_GET_HINDEX(x) (((x) >> 16) & 0xf)
> > > >
> > > > I think it's important to mention in the changelog that these values
> > > > have been changed to avoid conflicts with other VM_FAULT codes.
> > > >
> > > > > +/**
> > > > > + * typedef vm_fault_t -  __bitwise unsigned int
> > > > > + *
> > > > > + * vm_fault_t is the new unsigned int type to return VM_FAULT
> > > > > + * code by page fault handlers of drivers/file systems. Now if
> > > > > + * any page fault handlers returns non VM_FAULT code instead
> > > > > + * of VM_FAULT code, it will be a mismatch with function
> > > > > + * prototype and sparse will detect it.
> > > > > + */
> > > >
> > > > The first line should be what the typedef *means*, not repeat the
> > > > compiler's definition.  The rest of the description should be information
> > > > for someone coming to the type for the first time; what you've written
> > > > here is changelog material.
> > > >
> > > > /**
> > > >  * typedef vm_fault_t - Return type for page fault handlers.
> > > >  *
> > > >  * Page fault handlers return a bitmask of %VM_FAULT values.
> > > >  */
> > > >
> > > > > +typedef __bitwise unsigned int vm_fault_t;
> > > > > +
> > > > > +/**
> > > > > + * enum - VM_FAULT code
> > > >
> > > > Can you document an anonymous enum?  I've never tried.  Did you run this
> > > > through 'make htmldocs'?
> > >
> > > You cannot document an anonymous enum.
> >
> >
> > I assume, you are pointing to Document folder and I don't know if this
> > enum need to be documented or not.
>
> The enum should be documented, even if it's documentation is (yet) not
> linked anywhere in the Documentation/
>
> > I didn't run 'make htmldocs' as there is no document related changes.
>
> You can verify that kernel-doc can parse your documentation by running
>
> scripts/kernel-doc -none -v <filename>

I run "scripts/kernel-doc -none -v include/linux/mm_types.h" and it is showing
below error and warning which is linked to enum in discussion.

include/linux/mm_types.h:612: info: Scanning doc for typedef vm_fault_t
include/linux/mm_types.h:623: info: Scanning doc for enum
include/linux/mm_types.h:628: warning: contents before sections
include/linux/mm_types.h:660: error: Cannot parse enum!
1 errors
1 warnings

Shall I keep the documentation for enum or remove it from this patch ?

>
> > >
> > > > > + * This enum is used to track the VM_FAULT code return by page
> > > > > + * fault handlers.
> > > >
> > > >  * Page fault handlers return a bitmask of these values to tell the
> > > >  * core VM what happened when handling the fault.
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
> > >
> >
>
> --
> Sincerely yours,
> Mike.
>

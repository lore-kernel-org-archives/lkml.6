Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D43FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4C2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysupdr93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E4C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbeKFPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:49:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45202 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbeKFPtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:49:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id j4-v6so10334118ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 22:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AC0OUJ+NWBL3ykIA9xzGAB3BIH24eZ02gEAm06OECmk=;
        b=Ysupdr93/wn7TlFoJUQs9H+mZGkalU3IlRoVXBshgBcqsdKPqxMMup1zTSYZaRgsdG
         Nsk8iY9fuRyQjP1G+iAaPN2dpg4WVNWXFDRg9QZQSaC5F78mcfFzNaiPQQCZGZ0rU3uP
         1Rg8kBl/zoCVIQte3ls482I0der1OgtNtn/31rHme32yJrnNCpVCsIskTuOEd5gsjApj
         J6NBm9BnLC/j+gKMu6+gAHavCpKU8UGrfuXU2zJXFKtc3PeRAIFhex4qPueQiwjHpIEs
         l/AKQNE9D81YtlRAuB73tjlk71u59dYxV5240NdZmltpDA0USdagkAQZFXPjxXcNN0pw
         E0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AC0OUJ+NWBL3ykIA9xzGAB3BIH24eZ02gEAm06OECmk=;
        b=tJoslchPEzhpTfqA0WjEuix6HfZ6ONjE6Kh9y4WKBNf9sHd8FsyN7neA1f9CoXx3+p
         Mi8esFO6asDtIVNuUTzeRalCSuc0oPgvq2FCHlPTfHjdYpLEk18XKhwRElmBE6Eiddp2
         DFQ/0+VjkVs6nMUdiYmRZxvtK/82NtxV4otSmqMcmfj6DFJ/zyt2nxZigf5VOLx6GKPz
         Kba3ZFNEpvjHqszIcfb8y7Z3qFXsEI0+tNVY7vrpoF++k7DFI24GRQmTokgzQUgnLLma
         xwhGCjpzrRQ4rOSRhW4QSTe0F0oofxphRZtSrO3F0E5ebdsVvA3aVBhnnv7UDTguJPiX
         oSkg==
X-Gm-Message-State: AGRZ1gLSikpUTOJFCKFZlgU5eYbggXbku5UxaHN8JuBB4N7aA0IWSpUN
        3PzBguuoLcrEgwgwd5hniO+0KEW3NDCsaVLz3Yw=
X-Google-Smtp-Source: AJdET5czS3cDDCS6JDz0I4cz3rl8+8URxXhTk+N+4VhatFtzEfdN7g3G8IiT9da6qIRT+DoroXlCqS0BmbFL6CIzJ5U=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr15219004ljb.11.1541485565898;
 Mon, 05 Nov 2018 22:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20181103050504.GA3049@jordon-HP-15-Notebook-PC>
 <20181103120235.GA10491@bombadil.infradead.org> <20181104083611.GB7829@rapoport-lnx>
 <CAFqt6zaVUT0RGpz+jE4c7rb5prOtDhnxOy-NAiFM9G6jMwofVg@mail.gmail.com>
 <20181105091302.GA3713@rapoport-lnx> <CAFqt6zYbb9xpnOhhoESq3BbF4aD0_UKzh=MrwJ-i+NiUqNh7+Q@mail.gmail.com>
 <20181106062133.GB4499@rapoport-lnx>
In-Reply-To: <20181106062133.GB4499@rapoport-lnx>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 6 Nov 2018 11:59:27 +0530
Message-ID: <CAFqt6zYEB5=rpo6sGZW3Regwd9F7T0+Y_UpjQVBndR_-DYaHZA@mail.gmail.com>
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

On Tue, Nov 6, 2018 at 11:51 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Nov 05, 2018 at 07:23:55PM +0530, Souptick Joarder wrote:
> > On Mon, Nov 5, 2018 at 2:43 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > >
> > > On Mon, Nov 05, 2018 at 11:14:17AM +0530, Souptick Joarder wrote:
> > > > Hi Matthew,
> > > >
> > > > On Sun, Nov 4, 2018 at 2:06 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> > > > >
> > > > > On Sat, Nov 03, 2018 at 05:02:36AM -0700, Matthew Wilcox wrote:
> > > > > > On Sat, Nov 03, 2018 at 10:35:04AM +0530, Souptick Joarder wrote:
>
> > > > > > > +typedef __bitwise unsigned int vm_fault_t;
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * enum - VM_FAULT code
> > > > > >
> > > > > > Can you document an anonymous enum?  I've never tried.  Did you run this
> > > > > > through 'make htmldocs'?
> > > > >
> > > > > You cannot document an anonymous enum.
> > > >
> > > > I assume, you are pointing to Document folder and I don't know if this
> > > > enum need to be documented or not.
> > >
> > > The enum should be documented, even if it's documentation is (yet) not
> > > linked anywhere in the Documentation/
> > >
> > > > I didn't run 'make htmldocs' as there is no document related changes.
> > >
> > > You can verify that kernel-doc can parse your documentation by running
> > >
> > > scripts/kernel-doc -none -v <filename>
> >
> > I run "scripts/kernel-doc -none -v include/linux/mm_types.h" and it is showing
> > below error and warning which is linked to enum in discussion.
> >
> > include/linux/mm_types.h:612: info: Scanning doc for typedef vm_fault_t
> > include/linux/mm_types.h:623: info: Scanning doc for enum
> > include/linux/mm_types.h:628: warning: contents before sections
> > include/linux/mm_types.h:660: error: Cannot parse enum!
> > 1 errors
> > 1 warnings
> >
> > Shall I keep the documentation for enum or remove it from this patch ?
>
> The documentation should be there, you just need to add a name for the
> enum. Then kernel-doc will be able to parse it.
>
> > > > >
> > > > > > > + * This enum is used to track the VM_FAULT code return by page
> > > > > > > + * fault handlers.
> > > > > >
>
> I think that the enum description should also include the text from the
> comment that described VM_FAULT_* defines:
>
> /*
>  * Different kinds of faults, as returned by handle_mm_fault().
>  * Used to decide whether a process gets delivered SIGBUS or
>  * just gets major/minor fault counters bumped up.
>  */
>

Ok, will add  both in v2. Thanks.

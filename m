Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B08C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3992150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7PiHkdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3992150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeI0CCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:02:55 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44023 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeI0CCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:02:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so69984ybe.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/Ni5qmta3WyPruumK25iSu8XeGsUBcijA1J9mhHkHQ=;
        b=k7PiHkdT8lBwpVCut+nwkRkpNLaEAfeMt8nV8gByniagQtlKDnnoaZkwlY7gU0QWpM
         MaKT65QHYdy8dckUFjBYn1QuljAieO4wMNBxD+q/dPhw1kBsP7ikM+HOkVH31N8ORW2h
         mfjZlI7RbYc6Mt7sIaEDM2OfOYtu1q5RXkZSMH6pvuvXskkI2kNMx9aeQBeFvoykbHmo
         RNj4imJpgtKIBTPTlcOC2GBbvcJTXDLGPWoe+voQTt/7MPbkt3X+ZnZgAIk6OOBxJGOd
         7ZEzBwdO8qS3VEAskGiZ2IVteft9nChbTbN9p43CTJoQ/3djkfZ5/v5lSgotgP2YYuEe
         WiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/Ni5qmta3WyPruumK25iSu8XeGsUBcijA1J9mhHkHQ=;
        b=Zqdck7ItAY8yXWaLs/nLud3480Gsdz85dlz1wj//2Nm9FzxNoJM0eSC5uZtC20FEg+
         s2aExzy3o3Te2b2eZ8dOzFE8DDW5atQkNUletHOk1f2HzVlmN2XIzTDgJSd9eD7OBOQT
         O8nunwT29Z6+7kCdzZwWPg8jl0ErfehKWsvsfbsC4N6WaRSg8LrpCIo0KKkYMP8G8cFb
         HW3+nj0k52qtYqxa3T2Sd2BS/2D4MMMny7uKrvVTKRG8eYlSPG7pNO/QbJqVfh3A3oEd
         kpKt1gJUgli+Amiy4V5xsebpOwOb6aqpuVtK530PONceGzOc71qIri4Cg8gIol6rGzUt
         szEg==
X-Gm-Message-State: ABuFfoge/VZwmPgdR2W120Mc8tTk+ez866pRVZotIvFN/Tc4ZRjTRJmy
        C0tRzPV9hgPyFFOGJZ2PlBz4+CsnDzLpHh4/cJQ4
X-Google-Smtp-Source: ACcGV60UZ29PQ94hG4ghTaPVpMkzGFt1kYkc50vQzcbshWDU4BBaJr0GRXooMrJ1kDuOW2Jf1sSx+NupKX+9bUOyMFw=
X-Received: by 2002:a25:a207:: with SMTP id b7-v6mr3979620ybi.186.1537991301810;
 Wed, 26 Sep 2018 12:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180926150051.6ee97aae@canb.auug.org.au> <20180926142540.GB14407@localhost.localdomain>
 <20180926145820.GA14688@localhost.localdomain>
In-Reply-To: <20180926145820.GA14688@localhost.localdomain>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 26 Sep 2018 14:48:10 -0500
Message-ID: <CAErSpo6CAMrNafXPcdkYRgZsNtBj+zOdWoAKqG2r5h-jDCaVJQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To:     Keith Busch <keith.busch@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:56 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Sep 26, 2018 at 08:25:40AM -0600, Keith Busch wrote:
> > On Wed, Sep 26, 2018 at 03:00:51PM +1000, Stephen Rothwell wrote:
> > > Hi Bjorn,
> > >
> > > After merging the pci tree, today's linux-next build (powerpc allnoconfig)
> > > failed like this:
> > >
> > > ld: drivers/pci/pci.o: in function `pci_bus_error_reset':
> > > pci.c:(.text+0x5fba): undefined reference to `pci_slot_mutex'
> > > ld: pci.c:(.text+0x5fc2): undefined reference to `pci_slot_mutex'
> > >
> > > Caused by commit
> > >
> > >   131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")
> > >
> > > I have applied the following hack for today (there is probably a better
> > > way):
> >
> > Thanks for the notice. Does this mean you don't have CONFIG_SYSFS? I
> > must admit I missed that connection for building slot.c.
> >
> >
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Wed, 26 Sep 2018 14:55:37 +1000
> > > Subject: [PATCH] pci: move pci_slot_mutex so it is available where needed
> > >
> > > Fixes: 131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/pci/pci.c  | 2 ++
> > >  drivers/pci/slot.c | 1 -
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8c1e99a637d8..1fa67db6b21e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5190,6 +5190,8 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
> > >     return ret;
> > >  }
> > >
> > > +DEFINE_MUTEX(pci_slot_mutex);
> > > +
> > >  /**
> > >   * pci_bus_error_reset - reset the bridge's subordinate bus
> > >   * @bridge: The parent device that connects to the bus to reset
> > > diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> > > index 3da03fcc6fbf..c46d5e1ff536 100644
> > > --- a/drivers/pci/slot.c
> > > +++ b/drivers/pci/slot.c
> > > @@ -14,7 +14,6 @@
> > >
> > >  struct kset *pci_slots_kset;
> > >  EXPORT_SYMBOL_GPL(pci_slots_kset);
> > > -DEFINE_MUTEX(pci_slot_mutex);
> > >
> > >  static ssize_t pci_slot_attr_show(struct kobject *kobj,
> > >                                     struct attribute *attr, char *buf)
> > > --
> > > 2.18.0
>
> There's unfortunately second bug here when there are no slots, which
> would be the case without CONFIG_SYSFS: the slot list is empty, and the
> function just returned success, but it should have gone to the default
> secondary bus reset behavior in that case. I'll send a patch shortly.

I folded in Keith's patch for this, so you should be able to drop your
workaround, Stephen.

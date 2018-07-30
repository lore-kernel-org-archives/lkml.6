Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9EAC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE57820840
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjmR/vzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE57820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG3UHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:07:41 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33281 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeG3UHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:07:40 -0400
Received: by mail-oi0-f68.google.com with SMTP id l10-v6so23105219oii.0;
        Mon, 30 Jul 2018 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tbtfMztZVlt2N/oAaJpIbXBN96tmLGvYElq2ozMYaIg=;
        b=IjmR/vzZCi1yPNnO5OKlSn/OAo4+4gvGZdTQWe5+cZ6wv+H/h41S4QAYRPity/vRl3
         3vQ7U3Sf55/CPqPrBP/xMi4iozliQC3KgcMQ+2jKx08mM/oRsTiA9D3e3Iq3zJeigZ/v
         VppqlhxV+iU8U2X91gPWvPVPvgglfRAb0K7wUznoY9sYq2KEgszFmCpVrpCHSS9aAdyz
         9BV8tvPLuLuLnTnnPK2uW74KztAhe6w3IsbLV04g96jGFAcWTZgtDZkZt8katI2ouDal
         WSGWACq0pfVAU/ieIpQ90WqcRWcAPZ9Iuq/N/E5wHUGqFd0b+aSDPQA6S4v+oP+4y21j
         iWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tbtfMztZVlt2N/oAaJpIbXBN96tmLGvYElq2ozMYaIg=;
        b=fyGs7mz1prlyv9hO9uCXvX3N8mMTMgm7ZLSNmB+6Dr4AgCxYSKLm3+WvLLvnB07poQ
         QeWlg0nvP+QwdpSi4n2iIRikXD6g/Qu35YNaXNbegfmGD7HXmetoR+y4HD5teTv2U9ZS
         0K4nVfoWgYHgtDaSh9LNP+sVzy8f+DdDkZAA8NcJacEB0zhGi//SEOvTzChI56iCZUqT
         HASEUGLE/5MCvkT5e6TlqC4WFXk4uVQuGCqkkb9xWimbRdym3j5GYQAK/omQMEXNG1Cn
         USLo07JgEOJFvmTv4gikEfrpWpUfrXgU9ylf3v4QYwPLOPk+uvPbjqhWPuJbSHcqca+n
         PnlA==
X-Gm-Message-State: AOUpUlH6EV8t7Obmnu3v4ZBhB0HYjA0qDniYywaolksITbTGE1YSQmcm
        et1Y9HLr+PWXiALn4YnPIRAfqnvdIozJ/VYo6P4=
X-Google-Smtp-Source: AAOMgpe/mcIx1JVtPqK89a/eDrfCCjH9GPDHWm2R2PPvj9eaEMsE0bfOiBUxbH/7uyHclvmNkEx3lnXnHKMtME6NBBg=
X-Received: by 2002:aca:f383:: with SMTP id r125-v6mr18262591oih.6.1532975484581;
 Mon, 30 Jul 2018 11:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180727135157.13051-1-vasilyev@ispras.ru> <CAHtARFGRBk_1yG3sfZetCOKmoKegwEK5uH1Rco5-K4ussyMVxQ@mail.gmail.com>
 <CALy29_0ZOR=3c_2nrfQEmbH8k=Oqx5x9nhhVDp2jV6ksx6XENw@mail.gmail.com>
In-Reply-To: <CALy29_0ZOR=3c_2nrfQEmbH8k=Oqx5x9nhhVDp2jV6ksx6XENw@mail.gmail.com>
From:   adam radford <aradford@gmail.com>
Date:   Mon, 30 Jul 2018 11:31:13 -0700
Message-ID: <CAHtARFGDRWNBZJ=nYagWoZJg-ve1oYheJzuoY0_ehght1Ckt6g@mail.gmail.com>
Subject: Re: [PATCH] scsi: 3ware: fix return 0 on the error path of probe
To:     anton.vasilyev.87@gmail.com
Cc:     vasilyev@ispras.ru,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 8:18 AM Anton Vasilyev
<anton.vasilyev.87@gmail.com> wrote:
>
> Adam,
>
> 3w-9xxx: twa_probe():
>
> There is check of retval:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/scsi/3w-9xxx.c#n2010
>
> retval without assignement is 0 on fail of twa_initialize_device_extensio=
n():
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/scsi/3w-9xxx.c#n2040
>
> And this 0 is returned from probe on the error path.
>
> Same pattern is true for all other cases from patch.
>
> -Anton
>
> 27 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. 9:42 =D0=9F=D0=9F =D0=BF=D0=BE=D0=BB=
=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "adam radford" <arad=
ford@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>
> On Fri, Jul 27, 2018 at 6:52 AM Anton Vasilyev <vasilyev@ispras.ru> wrote=
:
> >
> > tw_probe() returns 0 in case of fail of tw_initialize_device_extension(=
),
> > pci_resource_start() or tw_reset_sequence() and releases resources.
> > twl_probe() returns 0 in case of fail of twl_initialize_device_extensio=
n(),
> > pci_iomap() and twl_reset_sequence().
> > twa_probe() returns 0 in case of fail of tw_initialize_device_extension=
(),
> > ioremap() and twa_reset_sequence().
> >
> >
> > The patch adds retval initialization for these cases.
> >
> > Found by Linux Driver Verification project (linuxtesting.org).
> >
> > Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> > ---
> >  drivers/scsi/3w-9xxx.c | 6 +++++-
> >  drivers/scsi/3w-sas.c  | 3 +++
> >  drivers/scsi/3w-xxxx.c | 2 ++
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
> > index 99ba4a770406..27521fc3ef5a 100644
> > --- a/drivers/scsi/3w-9xxx.c
> > +++ b/drivers/scsi/3w-9xxx.c
> > @@ -2038,6 +2038,7 @@ static int twa_probe(struct pci_dev *pdev, const =
struct pci_device_id *dev_id)
> >
> >         if (twa_initialize_device_extension(tw_dev)) {
> >                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to ini=
tialize device extension");
> > +               retval =3D -ENOMEM;
> >                 goto out_free_device_extension;
> >         }
> >
> > @@ -2060,6 +2061,7 @@ static int twa_probe(struct pci_dev *pdev, const =
struct pci_device_id *dev_id)
> >         tw_dev->base_addr =3D ioremap(mem_addr, mem_len);
> >         if (!tw_dev->base_addr) {
> >                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ior=
emap");
> > +               retval =3D -ENOMEM;
> >                 goto out_release_mem_region;
> >         }
> >
> > @@ -2067,8 +2069,10 @@ static int twa_probe(struct pci_dev *pdev, const=
 struct pci_device_id *dev_id)
> >         TW_DISABLE_INTERRUPTS(tw_dev);
> >
> >         /* Initialize the card */
> > -       if (twa_reset_sequence(tw_dev, 0))
> > +       if (twa_reset_sequence(tw_dev, 0)) {
> > +               retval =3D -ENOMEM;
> >                 goto out_iounmap;
> > +       }
> >
> >         /* Set host specific parameters */
> >         if ((pdev->device =3D=3D PCI_DEVICE_ID_3WARE_9650SE) ||
> > diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
> > index cf9f2a09b47d..40c1e6e64f58 100644
> > --- a/drivers/scsi/3w-sas.c
> > +++ b/drivers/scsi/3w-sas.c
> > @@ -1594,6 +1594,7 @@ static int twl_probe(struct pci_dev *pdev, const =
struct pci_device_id *dev_id)
> >
> >         if (twl_initialize_device_extension(tw_dev)) {
> >                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to ini=
tialize device extension");
> > +               retval =3D -ENOMEM;
> >                 goto out_free_device_extension;
> >         }
> >
> > @@ -1608,6 +1609,7 @@ static int twl_probe(struct pci_dev *pdev, const =
struct pci_device_id *dev_id)
> >         tw_dev->base_addr =3D pci_iomap(pdev, 1, 0);
> >         if (!tw_dev->base_addr) {
> >                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ior=
emap");
> > +               retval =3D -ENOMEM;
> >                 goto out_release_mem_region;
> >         }
> >
> > @@ -1617,6 +1619,7 @@ static int twl_probe(struct pci_dev *pdev, const =
struct pci_device_id *dev_id)
> >         /* Initialize the card */
> >         if (twl_reset_sequence(tw_dev, 0)) {
> >                 TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1d, "Controller re=
set failed during probe");
> > +               retval =3D -ENOMEM;
> >                 goto out_iounmap;
> >         }
> >
> > diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
> > index f6179e3d6953..961ea6f7def8 100644
> > --- a/drivers/scsi/3w-xxxx.c
> > +++ b/drivers/scsi/3w-xxxx.c
> > @@ -2280,6 +2280,7 @@ static int tw_probe(struct pci_dev *pdev, const s=
truct pci_device_id *dev_id)
> >
> >         if (tw_initialize_device_extension(tw_dev)) {
> >                 printk(KERN_WARNING "3w-xxxx: Failed to initialize devi=
ce extension.");
> > +               retval =3D -ENOMEM;
> >                 goto out_free_device_extension;
> >         }
> >
> > @@ -2294,6 +2295,7 @@ static int tw_probe(struct pci_dev *pdev, const s=
truct pci_device_id *dev_id)
> >         tw_dev->base_addr =3D pci_resource_start(pdev, 0);
> >         if (!tw_dev->base_addr) {
> >                 printk(KERN_WARNING "3w-xxxx: Failed to get io address.=
");
> > +               retval =3D -ENOMEM;
> >                 goto out_release_mem_region;
> >         }
> >
> > --
> > 2.18.0
> >
>
> Anton,
>
> 3w-9xxx: twa_probe() initializes retval at the top of the function:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/scsi/3w-9xxx.c#n2007
>
> so does 3w-xxxx: tw_probe():
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/scsi/3w-xxxx.c#n2253
>
> so does 3w-sas: twl_probe():
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/scsi/3w-sas.c#n1562
>
> so I think your patch isn't needed...
>
>
> -Adam
>
>
>

Acked-by: Adam Radford <aradford@gmail.com>

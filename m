Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABBC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BE32148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xoOeNpoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfA1Vy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:54:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41101 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfA1Vy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:54:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so16084718otk.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJGv5UC1ZEba/Eq2hyfcomchZRQQjueOVcfonwYOSrU=;
        b=xoOeNpoHghsK0tPuMK40eoCS4fnK935mbhi08ueLB90kc5ySkvLMi54umUmq8JXnw/
         rtSBEPVCSzTv72pwKfxc4CMDi04VJScnkItMlW/OJ19ptzJLu3xDJFz4FoJqKp80Byn2
         zSkCH2eTfGABgw4/qMRWxRui+brn5ibqwZji7rXAatmz8+GVzv02rXhWBKWydLmH3kj4
         TsswkK/hFE+pU9tKSvwDSTWk9rfpikxZuYkQnGDLq7WyWaNVH/6KApTq8kI6CFNKjoM9
         9ZqSkt15jeVgUlq+NXPA4CIUPsU1v8CzlcyZHKBRr7bjB+ilA3WOYN5DjcMotoUOhn1Y
         I/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJGv5UC1ZEba/Eq2hyfcomchZRQQjueOVcfonwYOSrU=;
        b=UDPk8AshJyMC9oz3BQQ89Gv70Ubrh0Jx+iAhzhcifrTXvZWvt6HndO13mSvAkd0ABv
         Rbz+J6jtR+WqX/rvYhV19mH4uFnjzcITxVzLMtkFjatqvMtZct49UZZrj+1hgI0egaTh
         Kkps7drzg2Nvtn+rKNQLlyybOnlQH7pIslj9ZeULjbdCUA1zewMCggD3ouInAu0y1cln
         dYDUzy67E/4HqDcE+HrBV4XO+JfcSMfrSINVqLiHC8Y5TzaFMkvRM3hAvlu6lIQpUKGa
         VCTYIG9qNjnydDZ7S/fp5KJxmI1SVxSGT/SS9Khelh2ekMOJDIlkov5+ykli0+4UuXjS
         yc4g==
X-Gm-Message-State: AJcUukccWvsFYwnVihECQ5QHRfyZ6BohpuCFNpQRnEw8m8om5czBi5VO
        FSJFOxrY9R3ECp5IU8LjijJQNiCItkmMSJGJxavsig==
X-Google-Smtp-Source: ALg8bN5Nwmwf/cMKtw4LP5bbtcZpoSqzKjOU5SA3vYAArlwA/DRa8O2KzhGDFdbC+whcJfFolGw6Ol2Klf2zhiI0/34=
X-Received: by 2002:a9d:394:: with SMTP id f20mr16802078otf.98.1548712496914;
 Mon, 28 Jan 2019 13:54:56 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB0169DF967C5BAAC8334FCC42BF990@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gnpn9VBHBoSFn_2sAdvfD85wRffvfYfuurwMxXYSBAZQ@mail.gmail.com> <PU1P153MB0169CE6B02AE7D67E25DDD89BF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169CE6B02AE7D67E25DDD89BF960@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Jan 2019 13:54:46 -0800
Message-ID: <CAPcyv4hGYFuW901KZ1xCR4TucgRTkqZ=SOsLOK0MpKq0BBCokw@mail.gmail.com>
Subject: Re: [PATCH] nfit: add Hyper-V NVDIMM DSM command set to white list
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Josh Poulson <jopoulso@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 1:40 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Monday, January 28, 2019 1:01 PM
> >
> > Hi Dexuan,
> > Looks good. Just one update request and a note below...
> >
> > On Wed, Jan 23, 2019 at 12:51 PM Dexuan Cui <decui@microsoft.com> wrote:
> > > ...
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -1840,7 +1840,7 @@ static int acpi_nfit_add_dimm(struct
> > acpi_nfit_desc *acpi_desc,
> > >         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
> > >
> > >         /*
> > > -        * Until standardization materializes we need to consider 4
> > > +        * Until standardization materializes we need to consider 5
> > >          * different command sets.  Note, that checking for function0
> > (bit0)
> > >          * tells us if any commands are reachable through this GUID.
> > >          */
> >
> > This comment is stale. This "HYPERV" family is the first example of
> > the "right" way to define a new NVDIMM command set. Lets update it to
> > mention the process and considerations for submitting new command sets
> > to UEFI (http://www.uefi.org/RFIC_LIST). The fact that there's now a
> > defined process is a step forward from when this comment was initially
> > written. Also, the fact that the process encourages "adopt" vs
> > "supersede" addresses the main concern about vendor-specific
> > command-set proliferation.
>
> I made the below simple change. Is this enough? Please suggest the proper
> wording/sentence, as I'm relatively new to NVDIMM, and I don't really know the
> history of the standardization process.
>
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1732,8 +1732,10 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
>         dev_set_drvdata(&adev_dimm->dev, nfit_mem);
>
>         /*
> -        * Until standardization materializes we need to consider 4
> -        * different command sets.  Note, that checking for function0 (bit0)
> +        * New command sets should be submitted to UEFI
> +        * http://www.uefi.org/RFIC_LIST.
> +        *

How about something a bit more relevant for the code in question:

---

There are 4 "legacy" NVDIMM command sets
(NVDIMM_FAMILY_{INTEL,MSFT,HPE1,HPE2}) that were created before an EFI
working group was established to constrain this proliferation. The
nfit driver probes for the supported command set by GUID. Note, If
you're a platform developer looking to add a new command set to this
probe consider using an existing set, or otherwise seek approval to
publish the command set at http://www.uefi.org/RFIC_LIST.

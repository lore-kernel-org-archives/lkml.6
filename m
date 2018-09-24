Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65157C004D1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE8B214FE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSQD+oNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE8B214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeIYDgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:36:21 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33553 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeIYDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:36:21 -0400
Received: by mail-yw1-f68.google.com with SMTP id x67-v6so8508878ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCQdQoqktnHJG+dO1puQns3GcqMmQH8Oh2YapciV1YU=;
        b=wSQD+oNxbgzRvgvtPg631Fgic62sfnL2k2WgTMWgHkyS9B85ZaAzHQ1HFQDOp/wYka
         qoL8SHvNpOq8618NXtYaJewEm7I5M/JmEuE2ZKJxGMLcrW1zHmqkGBnGklnWjNv0y6PM
         O2oO9A7LMh/jTk3dBTkERyjSPaH7nxN6Lr1c4cWh8nLZV2l0GbaBNePsstoyn74sOcSu
         nOSvlyvvMCsXHQbdkB1KwjlxazLGwe0abztEDwjwelmAI7qnwk02LVZYhuo7CUoRvxSs
         KMVv3hfU7zUzYe/beYANeviQ7xtbuF/jWwHuf6yRftDUBcF5FXiHDP1JFpoK6Cn3FEBT
         +D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCQdQoqktnHJG+dO1puQns3GcqMmQH8Oh2YapciV1YU=;
        b=tojwo3x7x0RFmxqPQhRfkgTiMyEp7oAE8+AEvn6xBNLOdDhOXlMT1qGJ2FINGtEj4H
         Z/SsYuywoiF5x4P6kgXsV4QMeySORHc1Qf0NrOFw/7eNcI9eTe3BwKtYgYzAL/KjXQ4v
         k7RpgYYWCLSrWNW1c9/4BBVE7wvUYRgRhgt4sa6Ga14gQv3fpW4+CoQRdpFP8zeH4y95
         GuzI5VZkCl4E5Ereax5vmwaNa5MQMWQEmLi9HpEPAokv2QbW5+bGow1GfUP4mfuBAJim
         EcnC+0W+oaBDTKYWAblQy+HA2EYgm17jzlO5ItTbgQ+4qdAazVfueNHbFKEBRC71UY7s
         tE2A==
X-Gm-Message-State: ABuFfoiK2YkEemFB1TQfZNQHOplVdKe3YtN539VV/aSUV9P4LyhP4/U5
        W3obT9pW82B6cB8pCiDnblVKNZMcUvSP+ehmzJDbSg==
X-Google-Smtp-Source: ACcGV62pJ6lxtemGTQeYgpDC1eA+xbKYtMtVrY3/ObqE4dz5ZiH8Squ6PSGzSE83MF6kt1mMlOlBAgIW/aeugJZNWDE=
X-Received: by 2002:a81:b64c:: with SMTP id h12-v6mr364166ywk.119.1537824728097;
 Mon, 24 Sep 2018 14:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com> <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
 <CACK8Z6Ej=BVThT8gSHCNZadXbLpzqKe6TmLYGkeBMmJBby1n-g@mail.gmail.com> <CAHp75VdyOAzHDNr4L6Onj=Qgu2DfQxPy-j_jo2HXfyukCZRePg@mail.gmail.com>
In-Reply-To: <CAHp75VdyOAzHDNr4L6Onj=Qgu2DfQxPy-j_jo2HXfyukCZRePg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 24 Sep 2018 14:31:31 -0700
Message-ID: <CACK8Z6E_gnMJN+djsbA0wPmtm=GT+cGfAeFoqP=rxeeVSYHnpg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Banik, Subrata" <subrata.banik@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Bohra, Aamir" <aamir.bohra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 24, 2018 at 8:04 PM Rajat Jain <rajatja@google.com> wrote:
> > On Mon, Sep 24, 2018 at 7:54 AM Banik, Subrata <subrata.banik@intel.com> wrote:
>
> > > First of all, this is pre-production chip, so, I don't think there is a bug in the driver (yet) discovered.
> > >
> > > Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
> > > I have checked two versions of it and found that in both we have the following mapping:
> > > for LP variant: there are only 4 communities are exported for H variant: there are only 5 communities are exported
> > >
> > > So, I guess the problem is in ASL code you provided. It simple should not export that community at all.
> > >
> > > In case you need to do so, there are ways:
> > >  - contact Intel and ask for a change in reference BIOS
> > >  - acquire another ACPI ID for the case, or, perhaps use special constants like
> > >    _HRV for that purpose (also need to contact Intel while doing that)
> >
> > As Subrata clarified (Subrata & Aamir are from Intel's Coreboot team),
> > that is not *the* Intel reference BIOS that you are using, but it is
> > *an* Intel generated BIOS/Coreboot image.
>
> Ah, interesting.
>
> > Andy, can you please let us know in what order are the resources laid
> > out in your reference BIOS for the case when it exports 5 communities
> > (i.e. community-0-2, 4-5)?
>
> We have no hardware with such PCH to answer to this question. LP
> version exports only 4 communities and order of them as per existing
> driver.

Got it, thanks. From your response earlier:

> Looking to the above ASL code I may conclude that is definitely is *not* from our reference BIOS.
> I have checked two versions of it and found that in both we have the following mapping:
> for LP variant: there are only 4 communities are exported
> for H variant: there are only 5 communities are exported

1) Do you know or recall, the order of communities in ACPI in the H
variant? Of course, this is a request for help for getting the info.

2) Trying to understand how would the kernel support both LP and H
variant. Is it the assumption that the H variant will have a different
ACPI ID than the LP variant  (i.e. not "INT3455")? Because it will
also have the same problem that we are seeing I think.

Thanks for all your help,

Rajat


>
>
> --
> With Best Regards,
> Andy Shevchenko

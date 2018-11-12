Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6DFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDKtMvwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782D222419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeKMFez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:34:55 -0500
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B738722419;
        Mon, 12 Nov 2018 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051615;
        bh=Fjjmnozbtsm59SSIS+DW09xLforYib0zL9xCcs3HkqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BDKtMvwpeHzSMZPSs7rK3N4TzR9DFsP4/5YeBT3aKetjwlMG2twzCV68vy6G98Lor
         J1+sSOtt3hpkMEm31aimaLWcyv8Y2qGhmJuCPzGgoSiRtSryi82KKk7BbUf/lWv2nk
         +1lhGL0L6nMZgKj6nBiRQtOTV0nPzSfwvGPdRklQ=
Received: by mail-yw1-f48.google.com with SMTP id u202-v6so1743177ywg.10;
        Mon, 12 Nov 2018 11:40:15 -0800 (PST)
X-Gm-Message-State: AGRZ1gJZnrB+5rNMZaGujT/VV8P5HOGRCvVaZOAmLK844etu4dlPY3qZ
        65Xao6Vh/WwXruJQsH0S9t9ieH0O5KgiIKNNo8o=
X-Google-Smtp-Source: AJdET5exqfQa71aoualzJ5rVeuIhA0Fi//UJGxz1Hu266huCM9oOw1ZEHhxdgtDhC9Cz8hOLo86o5uu6OGymxHCalIk=
X-Received: by 2002:a81:a38f:: with SMTP id a137-v6mr2158713ywh.474.1542051615033;
 Mon, 12 Nov 2018 11:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20180912144327.3130-1-atull@kernel.org> <20180912144327.3130-6-atull@kernel.org>
 <20180930154845.GA13200@kroah.com> <CANk1AXR=psRx319i_2S3fqM+4WsK6YgwJMPn=2o3zw5AQ3mr6w@mail.gmail.com>
 <20181112180206.GA28739@kroah.com>
In-Reply-To: <20181112180206.GA28739@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 12 Nov 2018 13:39:38 -0600
X-Gmail-Original-Message-ID: <CANk1AXSTOEZD9paFVc=G+VDKmj3E4dAMPpvhrCECeiF7=aS8pA@mail.gmail.com>
Message-ID: <CANk1AXSTOEZD9paFVc=G+VDKmj3E4dAMPpvhrCECeiF7=aS8pA@mail.gmail.com>
Subject: Re: [PATCH 5/5] fpga: dfl-fme-region: Use platform_get_drvdata()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 12, 2018 at 09:46:53AM -0600, Alan Tull wrote:
> > On Sun, Sep 30, 2018 at 10:48 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > Hi Greg,
> >
> > >
> > > On Wed, Sep 12, 2018 at 09:43:27AM -0500, Alan Tull wrote:
> > > > From: Moritz Fischer <mdf@kernel.org>
> > > >
> > > > Use platform_get_drvdata() in remove() function of
> > > > the platform driver rather than dev_get_drvdata()
> > > > to match the platform_set_drvdata in the probe().
> > > >
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > Acked-by: Alan Tull <atull@kernel.org>
> > > > ---
> > > >  drivers/fpga/dfl-fme-region.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> > > > index 51a5ac2..3fa0de2 100644
> > > > --- a/drivers/fpga/dfl-fme-region.c
> > > > +++ b/drivers/fpga/dfl-fme-region.c
> > > > @@ -66,7 +66,7 @@ static int fme_region_probe(struct platform_device *pdev)
> > > >
> > > >  static int fme_region_remove(struct platform_device *pdev)
> > > >  {
> > > > -     struct fpga_region *region = dev_get_drvdata(&pdev->dev);
> > > > +     struct fpga_region *region = platform_get_drvdata(pdev);
> > >
> > > This is nice, but not a bugfix.  I'll wait for 4.20-rc1 for this patch.
> >
> > Could you take patch 4/5 and 5/5?  They didn't make it into a 4.20 rc yet.
>
> Can you resend them please?  I don't see either of these in my queue
> anywhere.
>
> thanks,
>
> greg k-h

Sure! Just sent them.

Thanks,
Alan

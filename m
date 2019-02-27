Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9FCC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D441D20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QjG6/wk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfB0RIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:08:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38316 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfB0RIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:08:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id g12so6745055wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6QbPtYAjXGQVyQjxCRDb5DzLYZHyOIsoCwdT99rSNk=;
        b=QjG6/wk72IWmBUVY2abv0awph2rM9Gg1OTRWhvrkpUwPZTK8Bjre+CvMSfxmjxVRjE
         ewc9zURhcCJBV7BNfabaRNvKvWii6VGps6h1W4pCMeaBcR5h3uT5MGV6LsM5ZFgMkq8A
         9C7ZlwtHYT7gV3Dc5JYQY6+qawneuBewW7/Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6QbPtYAjXGQVyQjxCRDb5DzLYZHyOIsoCwdT99rSNk=;
        b=tgawH4J8KvQLuqeVJRD8nq3YmuNGAPQ2/MshFkReEqJmC+TXK07ZnnGbZJfsRESX30
         5H3pdaxfnx/En2ZoASP+kdLyo6fXLxP2nA23D18RbRqybUJxxQN/rH4ahgGs3JzRlRRV
         lwhuF/XpD5uVvJhUOjx8PhdY4E4rmJPZq8rGrlY9/XXJxYaLUFS7xjF9J9ynIbo+b4k0
         RyFOFuv0cQ5vtEzgapNdgeeVYWwl57SUYWDlhKurX5fDqjjM0oW931NSwG2vn+bYz4yL
         qfL+9Cy1c77y3GAcmgtcwZm8qesNM3YEAhDknN6RgdjxbPcIKvcBd4VPd79+gTJXCpbU
         gGvQ==
X-Gm-Message-State: APjAAAWpbZZw++tkmjbW4POCjGuRrzphjSVWONoawt8CO+aAY1wxZQgT
        K3ZK2otQmP3X1WCEOVtW2W7WalsqjsW6S2ungZepNA==
X-Google-Smtp-Source: APXvYqzon1EpeAzNJmiqIxOMViAWXS/aSOiS6LnCVFLpjFvYM7Deo7x2ktO5dMMklSN2nD9XX5zq5CPXHbf3OHP3FzQ=
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr3190735wrf.83.1551287319188;
 Wed, 27 Feb 2019 09:08:39 -0800 (PST)
MIME-Version: 1.0
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com>
 <20190225213807.GA18852@bogus> <CABe79T4j7batxZ7BDhEpwRK8x5UMZLkxLJOt-FD0SCr9JOFizw@mail.gmail.com>
 <CAL_Jsq+ZOWyY7p=ZjRnB85RY=fcNXu7xiH5j-1-OkuAmXqCFxw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ZOWyY7p=ZjRnB85RY=fcNXu7xiH5j-1-OkuAmXqCFxw@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 27 Feb 2019 22:38:27 +0530
Message-ID: <CABe79T7=uhVfy4x+L0Vi6g5fiT=-WKnnZmNn5XpZrvOiUzJOaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb-xhci: Add usb-phy-port-reset property
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
Thanks for the information. Please find my comments below.
Regards,
Srinath.
On Tue, Feb 26, 2019 at 11:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Feb 25, 2019 at 10:57 PM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > Hi Rob,
> > Thanks for the review, Please see my comments below in line.
> >
> > Regards,
> > Srinath.
> > On Tue, Feb 26, 2019 at 3:08 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, Feb 05, 2019 at 11:48:53AM +0530, Srinath Mannam wrote:
> > > > Add usb-phy-port-reset optional property to set quirk in xhci platform
> > > > driver which forces USB port PHY reset on port disconnect event.
> > > >
> > > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > > index fea8b15..ecbdb15 100644
> > > > --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > > +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > > @@ -40,6 +40,7 @@ Optional properties:
> > > >    - usb3-lpm-capable: determines if platform is USB3 LPM capable
> > > >    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
> > > >    - imod-interval-ns: default interrupt moderation interval is 5000ns
> > > > +  - usb-phy-port-reset: set this to do USB PORT PHY reset while disconnect
> > > >    - phys : see usb-hcd.txt in the current directory
> > >
> > > This should be implied by the HCI or phy compatible string (depending
> > > on who exactly needs the quirky behavior).
> > Stingray USB HS PHY connected to xHCI port has an issue, if full speed
> > devices connected to this port then
> > after all High Speed devices connected to this port are detected at
> > full speed instead of high speed.
> > So that we need to do PHY (which is connected to port) reset on xHCI
> > port disconnect event.
> > That is the reason we required to add quirk in xHCI.
>
> So, by looking at the xhci host and phy compatible strings (or maybe
> just the phy) you can determine whether you need to reset the port or
> not. All the information you need is in DT already.
xHCI controller in our SOC has three ports each port has one
PHY(SS/HS) connected to it.
HS PHY has to reset on its corresponding port disconnect event. port
disconnect event is
captured in xHCI host framework so, quirk has to be registered in xHCI
framework only.
But we are using "generic-xhci" generic compatible string for our xHCI
controller.
As per your advice, we will add new compatible string in xhci-plat.c
driver for our xHCI controller
and will add quirk part of that.

Thank you.

>
> Rob

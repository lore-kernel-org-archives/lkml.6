Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150921850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551204190;
	bh=xGi7ixqN94VIJrKEmRQzMD2uzjcIFe7qUvsMWOhLngA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EXZeSoCVqb6VLEHxcF6+IpYdXGUWQ/RbRP9JTbJ214R1OoZFWz1qLattQ6hdGvGmv
	 d6OS3AfV7oH5TdYLMXhHjDi2ooz92sku3BwL8JBnNEA+e4NrhJTRNeX8WwfigDWPJF
	 GlEps5t6W9ltt+gw/dBrX56ykqV3/Vvbb2uqFJB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfBZSDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfBZSDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:03:08 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6BF21850;
        Tue, 26 Feb 2019 18:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551204187;
        bh=xGi7ixqN94VIJrKEmRQzMD2uzjcIFe7qUvsMWOhLngA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GBNIrSXT481Kkj6jUi2M7/pZfDK4HgbElGDOijq5ntKf01f7vCjfmg2lNH/hJsFlk
         IeODhfTRIML8VlwjfZIz580U0vXe2NqBLeuQmrZnvpdrTwym5A1UNGrXHnUKaQ1Dbj
         PXmUxFwr0sd37ZsYKYuEWtS5tdHzgF/C7YHq50BM=
Received: by mail-qt1-f174.google.com with SMTP id u7so6745994qtg.9;
        Tue, 26 Feb 2019 10:03:07 -0800 (PST)
X-Gm-Message-State: AHQUAubEmMcQrFEM1N36ayRwaYpFMqV4kkqYEJSyuI2nOh1tcRyLnsXt
        +pfWh7u5cZTZAB2GiEZrFk6MYVGwhkpvojlayQ==
X-Google-Smtp-Source: AHgI3IYBU5JHSnnvXKePNL3qb9bRxS1NeH8Bq4ZKTC8Ky4Q7YpbZdsNYPvLt84zX5dYePbPlconT0BLTtpIJDx1P9wg=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr19280940qvb.218.1551204186468;
 Tue, 26 Feb 2019 10:03:06 -0800 (PST)
MIME-Version: 1.0
References: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
 <1549347534-11320-2-git-send-email-srinath.mannam@broadcom.com>
 <20190225213807.GA18852@bogus> <CABe79T4j7batxZ7BDhEpwRK8x5UMZLkxLJOt-FD0SCr9JOFizw@mail.gmail.com>
In-Reply-To: <CABe79T4j7batxZ7BDhEpwRK8x5UMZLkxLJOt-FD0SCr9JOFizw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 26 Feb 2019 12:02:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ZOWyY7p=ZjRnB85RY=fcNXu7xiH5j-1-OkuAmXqCFxw@mail.gmail.com>
Message-ID: <CAL_Jsq+ZOWyY7p=ZjRnB85RY=fcNXu7xiH5j-1-OkuAmXqCFxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb-xhci: Add usb-phy-port-reset property
To:     Srinath Mannam <srinath.mannam@broadcom.com>
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

On Mon, Feb 25, 2019 at 10:57 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Hi Rob,
> Thanks for the review, Please see my comments below in line.
>
> Regards,
> Srinath.
> On Tue, Feb 26, 2019 at 3:08 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 05, 2019 at 11:48:53AM +0530, Srinath Mannam wrote:
> > > Add usb-phy-port-reset optional property to set quirk in xhci platform
> > > driver which forces USB port PHY reset on port disconnect event.
> > >
> > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > index fea8b15..ecbdb15 100644
> > > --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> > > @@ -40,6 +40,7 @@ Optional properties:
> > >    - usb3-lpm-capable: determines if platform is USB3 LPM capable
> > >    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
> > >    - imod-interval-ns: default interrupt moderation interval is 5000ns
> > > +  - usb-phy-port-reset: set this to do USB PORT PHY reset while disconnect
> > >    - phys : see usb-hcd.txt in the current directory
> >
> > This should be implied by the HCI or phy compatible string (depending
> > on who exactly needs the quirky behavior).
> Stingray USB HS PHY connected to xHCI port has an issue, if full speed
> devices connected to this port then
> after all High Speed devices connected to this port are detected at
> full speed instead of high speed.
> So that we need to do PHY (which is connected to port) reset on xHCI
> port disconnect event.
> That is the reason we required to add quirk in xHCI.

So, by looking at the xhci host and phy compatible strings (or maybe
just the phy) you can determine whether you need to reset the port or
not. All the information you need is in DT already.

Rob

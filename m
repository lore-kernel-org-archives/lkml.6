Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB144C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1032070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FNdElpzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfBVR3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:29:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37401 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfBVR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:29:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so3233777wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGVxfZASglZpqjStyjEeO8xKjV8wyZk3eOKUfQcYK5E=;
        b=FNdElpzUUEZa4K/6N3xR/mQAHacZfpnKXNsW9KMcHj7pmVOP9qagHQZoH/qOQ4PTBU
         g0jZcC22msjJ6d4bRxms4YLojDb5yS7mjY5BnVfk7FK06I9F0JaIGtaH+lVircBSD1Bz
         rlkHWgcXgek8M8uqeU6TQFInWgIUOvFTe2bWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGVxfZASglZpqjStyjEeO8xKjV8wyZk3eOKUfQcYK5E=;
        b=NsVdFlh0s7Y7Cttuk8O5KRNAhMFvBU9gzaQUJvA9ErSrLKozKxCs+5CcN7DKwxZsX1
         yxv08stshrmw2G5ahcYIAjN3GJ5GJcIaRuj1otpLthshYS79JypOS+Jslc7dLOo+WcTf
         tintY+JwlrvfVknvruWUr+DjUDwzu9vJrxm0nhnau2zZGPRFJB128GAFNfHk/DaaMdhH
         lWMB0iWUUgT4Ts2n7NADJX3GvnwF2i8pFpkRl6pmM522ogMi5mqQ6CQRw/pl87xnkiak
         5nrbhCz7jz8BJ8ZXvuIxTkVoxY1c5RwwXBuh18/5hLUK6HvqqJ4C4k6artYYF2lXOSm9
         X4kw==
X-Gm-Message-State: AHQUAubAFyZJptMDUAGpfilqHKPi/KodQJQhIQFaBakJMNO/ZvaCD8xZ
        pEIk61nsDZ74Qf4lgHkLH23kJIlEjHlP5U/INtiZMQ==
X-Google-Smtp-Source: AHgI3IaQrwAp1a9dDYDK7NlZnEzJgDqMLk5cD29uN65s6W9kKPAH8OsK+SPhwC+11tRax+6IOT/g0N6ka9YT6U9OV2o=
X-Received: by 2002:adf:8251:: with SMTP id 75mr4021208wrb.112.1550856593234;
 Fri, 22 Feb 2019 09:29:53 -0800 (PST)
MIME-Version: 1.0
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
 <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com> <20190222172042.GA6792@bogus>
In-Reply-To: <20190222172042.GA6792@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 22 Feb 2019 22:59:41 +0530
Message-ID: <CABe79T5SqQJhF0GY06-+-aSCV-ya-RODEeV0DLg0Poupjeq+fA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review, Please find my comments below in line.

On Fri, Feb 22, 2019 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 20, 2019 at 04:04:00PM +0530, Srinath Mannam wrote:
> > Add DT binding document for Stingray USB PHY.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > ---
> >  .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> >
> > diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > new file mode 100644
> > index 0000000..da19236
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > @@ -0,0 +1,62 @@
> > +Broadcom Stingray USB PHY
> > +
> > +Required properties:
> > + - compatible : should be one of the listed compatibles
> > +     - "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
> > +     - "brcm,sr-usb-hs-phy" has a single HS PHY.
> > + - reg: offset and length of the PHY blocks registers
> > + - address-cells: should be 1
> > + - size-cells: should be 0
> > +
> > +Sub-nodes:
> > +  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
> > +
> > +Sub-nodes required properties:
> > + - reg: required for brcm,sr-usb-phy model PHY.
> > +     reg value 0 is HS PHY and 1 is SS PHY.
> > + - phy-cells: generic PHY binding; must be 0
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > +
> > +Example:
> > +     usbphy0: usb-phy@0 {
> > +             compatible = "brcm,sr-usb-combo-phy";
> > +             reg = <0x00000000 0x100>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             usb0_phy0: phy@0 {
> > +                     reg = <0>;
> > +                     #phy-cells = <0>;
> > +             };
> > +
> > +             usb0_phy1: phy@1 {
> > +                     reg = <1>;
> > +                     #phy-cells = <0>;
> > +             };
>
> Again, you don't need child nodes here. There are not any per child
> resources. Clients can refer to <&usbphy0 1> just as easily as
> <&usb0_phy1>. This is why we have #phy-cells.
This phy controller is combo PHY it has one Super Speed USB PHY and
one High Speed USB PHY.
We required to create two PHY devices inside driver to initialize and
service(reset) both SS and HS PHYs separately.
That is the reason we used two child nodes.

Regards,
Srinath.
>
> Rob

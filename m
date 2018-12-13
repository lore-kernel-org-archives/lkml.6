Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E28720873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5yVLycB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E28720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeLMJVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:21:09 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53011 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbeLMJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:21:08 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so2676868itg.2;
        Thu, 13 Dec 2018 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssi74EFhzvk4hkl+CKBc5pU0Zt7ykonCrGFTKNL/QfE=;
        b=A5yVLycBb8uEFABHNuxa6+YocnBLhgRW74m8799lEg9aTWzseJ2ko/UT27GVm/I8G7
         w7HtYbuUMGwBbdGs0SNcq0FqEuK7aWNSHiiGDu4lR3spsO1ib1xN2TRZs++ILGw7McuJ
         tr8w1S6o+Zo6LYICOUf86FaaQ23g+rGpLaELnCRl74ZTU6xvlpHXCdjYQF5AK92FCAJp
         UD9lC4RItGeuOn5qDzBYO90EDeywrF/fgLUK8DczT4MfNyIi6SWhE61rfPQ8sM6P3eH2
         MRvrv1m7pUlXqcxKVIUt+CW7cCSlr1q/IuZrMs2kMKPxLd9SzHWbYF8YHxqKafDpbxrP
         lUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssi74EFhzvk4hkl+CKBc5pU0Zt7ykonCrGFTKNL/QfE=;
        b=Wod7/s4msDY4L+ad7n3M5TFlIMcPYx13fHhjJKh9dBUErGqin7PYzb56D4Fento4wO
         5sexlvjRtM0K8p95WeedrEeoeuC81YlQIjA0OW7AwpwSBs9Mq2TJAF9atVKKxxFJ4RdY
         C7s57GS6+pz/47MHBBSxYe8odtiCQ+BpFpKgkUnys+LWNS/qx177U5M1TfB+d4X390tH
         bXMxfI5bdbdrPk4frj4Mep4rFjUlWD6WLi5iekmSC1lAuk0VZ2fu5Lw3jYRECzQPmwN0
         xWwyrCsjCO6NULM6NeynkBSazODv/d1IR3ZiqDGlUYE9lqrcgIQ+jZfpWUjbSR5Ygsy1
         a/JQ==
X-Gm-Message-State: AA+aEWb+jrjUJIdkn8Ydw+28FBFotu72rE8KJZx205tfbilxCjv890PJ
        he8sgGDzHlDQdfHBLioCto966PYVM64fNDqLXaE=
X-Google-Smtp-Source: AFSGD/Xz0dvj72S2mGJxcrbCv1DdrcWlurPaymG5jyp0hxzzlwyZY2AdFv7IoQWj37NYMNVGVIbLeI6PjwKpJnKv6m4=
X-Received: by 2002:a02:97fd:: with SMTP id v58mr23203088jaj.115.1544692867925;
 Thu, 13 Dec 2018 01:21:07 -0800 (PST)
MIME-Version: 1.0
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com> <5C0F8E7B.3030601@ti.com>
In-Reply-To: <5C0F8E7B.3030601@ti.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 13 Dec 2018 17:20:57 +0800
Message-ID: <CAL411-qP3TAt1kz5Q1WcUejSbt4Agpmqry7JVE_6W+2MpCag4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
To:     rogerq@ti.com
Cc:     pawell@cadence.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, balbi@kernel.org,
        lkml <linux-kernel@vger.kernel.org>, adouglas@cadence.com,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 6:19 PM Roger Quadros <rogerq@ti.com> wrote:
>
> Pawel,
>
> On 10/12/18 14:39, Pawel Laszczak wrote:
> > This patch aim at documenting USB related dt-bindings for the
> > Cadence USBSS-DRD controller.
> >
> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > ---
> >  .../devicetree/bindings/usb/cdns3-usb.txt     | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
> >
> > diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> > new file mode 100644
> > index 000000000000..ae4a255f0b10
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
> > @@ -0,0 +1,31 @@
> > +Binding for the Cadence USBSS-DRD controller
> > +
> > +Required properties:
> > +  - reg: Physical base address and size of the controller's register areas.
> > +      Controller has 3 different regions:
> > +      region 1 - HOST registers area
> > +      region 2 - DEVICE registers area
> > +      region 3 - OTG/DRD registers area
> > +  - compatible: Should contain: "cdns,usb3"
> > +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> > +             Driver supports only single interrupt line.
> > +                This single interrupt is shared between Device,
> > +             host and OTG/DRD part of driver.
> > +
> > +Optional propertiesi:
>
> s/propertiesi/properties
>
> > + - maximum-speed : valid arguments are "super-speed", "high-speed" and
> > +                   "full-speed"; refer to usb/generic.txt
> > + - dr_mode: Should be one of "host", "peripheral" or "otg".
> > + - phys: reference to the USB PHY
> > + - phy-names: name of the USB PHY, should be "cdns3,usbphy"
> > +
> > +
> > +Example:
> > +     usb@f3000000 {
> > +             compatible = "cdns,usb3";
> > +             interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
> > +             reg = <0xf3000000 0x10000       //memory area for HOST registers
> > +                     0xf3010000 0x10000      //memory area for DEVICE registers
> > +                     0xf3020000 0x10000>;    //memory area for OTG/DRD registers
>
> Use "/* <comment> */" instead.
>
> > +     };
> > +
> >

When running git am to apply patch, it has below warning, please fix them.

Applying: dt-bindings: add binding for USBSS-DRD controller.
.git/rebase-apply/patch:42: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E222183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 03:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MbGwtIG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfBSDjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 22:39:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46600 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfBSDjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 22:39:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so12308317wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 19:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7u+jUl+pHoifvQw91b5Cy043+xtHUs9SHNI6k3y94I8=;
        b=MbGwtIG9ixkSAKI0UlVbblw2v5+3qBMhgOA/WA11WUnXLcl/qTX59PGn1ANH/mhs6/
         oBvO8MbsvC8jIWII4wFs3a5YV9z7D1TViraz0/kbu29ceHmO2xX7AveiqbuEdly3siGT
         8NPRlHumuUDFGfhavLqwDAVs7Y4oxnwkMWxbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7u+jUl+pHoifvQw91b5Cy043+xtHUs9SHNI6k3y94I8=;
        b=j2qgtYm/SnepmfGkvduSW8fplRAExSH674yWZP9Sq8A7np64fCm3ph4ZBwF3W+/Qbk
         7Zuj7+jYze4CF2PyuKaHv5+2KPowp9DSaH03rCRzbZwaDio4mLc3aD5B1HXsJpOntn99
         9idvDV3pNedwowVVODYWqek/1Ll6T7O6qlrMJrGjeU40k3pxacKIhBUh0vrm0wLOarhm
         lNVRkvs/9u9J0pXEC+0K3PG/HjtHEUugU7Woho1SOetyYgo9C6kdDM/VaoAMt8ilHU+V
         BSsZjvHVWnFXRJ/byJN5HXRhtBif6DH9hjk+c8iD1/Py7MbEQl0JjIgzJgjj9x6dlgQN
         rtDw==
X-Gm-Message-State: AHQUAuYBvlyuCm7jPdfPm01oLZdYP4KZERXu1HpNGcWbOpX5fCaz4jIW
        w0SCm/IRo4Y3OApxI6VmY0SqhEfkEPF8QWJMUzkLBrRtKQY=
X-Google-Smtp-Source: AHgI3IaaKinDr5OVklKBstwktXybRbHDtdlFhoigqsr1ehlJ2YesAw1NB9BX6BveIJgQH2QHaDlHB4bKqAaleg8Hfas=
X-Received: by 2002:adf:8251:: with SMTP id 75mr20013144wrb.112.1550547555689;
 Mon, 18 Feb 2019 19:39:15 -0800 (PST)
MIME-Version: 1.0
References: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
 <1549474347-7224-2-git-send-email-srinath.mannam@broadcom.com> <20190218172221.GA20334@bogus>
In-Reply-To: <20190218172221.GA20334@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 19 Feb 2019 09:09:04 +0530
Message-ID: <CABe79T6W_NrgAsJnfX-tBmTWZCDUGC7wkWfayQ6BNF-7S_iRYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
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

Thanks for review, please see my comments below inline.

On Mon, Feb 18, 2019 at 10:52 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Feb 06, 2019 at 11:02:25PM +0530, Srinath Mannam wrote:
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
> > index 0000000..bfe1367
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > @@ -0,0 +1,62 @@
> > +Broadcom Stingray USB PHY
> > +
> > +Required properties:
> > + - compatible : should be one of the listed compatibles
> > +     - "brcm,sr-usb-phy"
> > +     - "brcm,sr-usb-phy-v2"
>
> SoC specific compatibles are preferred. Version numbers can be used but
> should follow some documented scheme and be meaningful. What we don't
> want is just Linux developers making up numbering.
>
Both versions are different phy controllers and also have separate
register offsets.
I will provide more meaningful compatible IDs and their documentation
in next patchset.
> > + - reg: offset and length of the PHY blocks registers
> > + - address-cells: should be 1
> > + - size-cells: should be 0
> > +
> > +Sub-nodes:
> > +  Each port's PHY should be represented as a sub-node.
> > +
> > +Sub-nodes required properties:
> > + - reg: required for brcm,sr-usb-phy model phy.
> > +     reg value 0 is HS phy and 1 is SS phy.
> > + - phy-cells: generic PHY binding; must be 0
> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > +
> > +Example:
> > +     usbphy0: usb-phy@0 {
> > +             compatible = "brcm,sr-usb-phy";
> > +             reg = <0x00000000 0x100>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             usb0_phy0: phy@0 {
> > +                     reg = <0>;
> > +                     #phy-cells = <0>;
>
> Unless there's DT resources for each child node, you don't need these.
> Just make #phy-cells 1 in the parent.
With the use of phy-cell, PHY argument is available with xlate
function, But controller specific assignments required
to be done while probe. So I will take your first option given in
previous comment.

Regards,
Srinath.
>
> Rob

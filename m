Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCCE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z0UhtBYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCCE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJRVFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbeJRVFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:05:10 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAA621479;
        Thu, 18 Oct 2018 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539867853;
        bh=YlwXWIYpMBQgjvWQbv4gpAodiiwd3kFNzUEwvm+XfL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z0UhtBYM+5gULszMkdndL8Icm8tTflpVpt0QABOjzkaULZksKVvnYx2sac2a9rVEi
         QMV/CzjSD/zgux7MqL/sB935atMlWLPmNL8hXIhdqspPNnmRLE0GnFH8SrCDr0Gchi
         dH3usziNN1GyVWNKFSZ6NYRhDgK/6qqs8UQzOLzY=
Received: by mail-qk1-f175.google.com with SMTP id q184-v6so622101qkd.3;
        Thu, 18 Oct 2018 06:04:12 -0700 (PDT)
X-Gm-Message-State: ABuFfoiH6Fd59HGS9noXMnQIUjiYguUR3Z0LVh0rNofnBZvOZV0gPrp7
        nG5MszoBM9si94Wxgnqw9RPDTdB7wqNQ0nt3Eg==
X-Google-Smtp-Source: ACcGV60OyZuiaMfTarwQVk2BmwaB+TYZN9eXPLrW6OtggynukYr+/Cd+mVrFZF4bzxeTlNQC/kCQLfxOqVk/CY6QG54=
X-Received: by 2002:a37:4dc5:: with SMTP id a188-v6mr28480649qkb.326.1539867852088;
 Thu, 18 Oct 2018 06:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com> <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
In-Reply-To: <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 18 Oct 2018 08:04:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdXEPYsK5q4J9_ZF10NJbj6_cH199zLhZ5+9oQYw9B6w@mail.gmail.com>
Message-ID: <CAL_JsqLdXEPYsK5q4J9_ZF10NJbj6_cH199zLhZ5+9oQYw9B6w@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        KT Liao <kt.liao@emc.com.tw>, linux-input@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:10 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
> > > Some new touchpads IC are connected through PS/2 and I2C. On some of these
> > > new IC, the I2C part doesn't have all of the information available.
> > > We need to be able to forward the touchpad parameters from PS/2 and
> > > thus, we need those new optional properties.
> > >
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > index 797607460735..ace6bcb0b4eb 100644
> > > --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
> > > @@ -13,6 +13,14 @@ Optional properties:
> > >    pinctrl binding [1]).
> > >  - vcc-supply: a phandle for the regulator supplying 3.3V power.
> > >  - elan,trackpoint: touchpad can support a trackpoint (boolean)
> > > +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
> >
> > > +- elan,max_x: the maximum reported value on the X axis
> > > +- elan,max_y: the maximum reported value on the Y axis
> > > +- elan,min_x: the minimum reported value on the X axis
> > > +- elan,min_y: the minimum reported value on the Y axis
> > > +- elan,x_res: the resolution of the X axis (in units per mm)
> > > +- elan,y_res: the resolution of the Y axis (in units per mm)
> > > +- elan,width: max reported width of a blob
> >
> > Can't we use standard touchscreen properties here? (Yes, I get this is a
> > touchpad, not touchscreen).
>
> Hey Rob,
>
> Well, there is that (it's a touchpad driver) and we can't also really
> use the of_touchscreen.c implementation.
> If both concerns are not an issue, we can then move the [min/max/res]
> properties to the touchscreen ones.

Neither is problem for me. Bindings don't have to map 1:1 to kernel code.

> Regarding 'elan,width', this is something missing from the standard ts
> properties, and AFAICT, this controls the maximum reported
> width/height of a touch.
> I should probably rename them to max_width, max_height.

Sure, just use '-' rather than '_' in property names.

> Hans, do you think we should add such properties to of_touchscreen.c
> too? (the width/height ones)
>
> Cheers,
> Benjamin

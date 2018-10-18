Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB6C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23902098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23902098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJRQoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:44:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42231 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeJRQoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:44:24 -0400
Received: by mail-qk1-f196.google.com with SMTP id u20-v6so3689595qkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHxLNVHO3mNqnkyjrL1SXQB+zgzrvPdkQ6I9DxcvlQY=;
        b=Er4B4mX1C9wdR6pFHcf7UKjDrjnTkhyYAjZeay8sZQlmMcU4mSKTL2yZckC7V6NfJH
         vkt/xC7aeI2B677NOt4to5t+GTwBcfOwe+E7OtGSIB4c0lRf6oWgqhODJxsTHrgZOv93
         tS43HHd4yaHEtHMfa5PjZKvu8w+u60ezObvKQpqryszzp0TZpcGxaB70TdPTttROkFR/
         oSDV9Pm9ILQtpWVx1hkb2QwoUoWQcnbbdjnohd+kyvK05skdsLRsWVEeVuTJoWHixOy0
         xijYAMnkRtSyRV2AHIBcRG5iMo7iGPBQYCQJe8R5dBIJvX2V+3GbVIP+AHOmvdEMKBpb
         pxtg==
X-Gm-Message-State: ABuFfojldk61Zh7CzDJwoberK2DllB3KGT4tu2881IYwk44yYZIPDsoB
        NFqWL/AJhwsO1x00gxIoxN7AD3MimMPx6WCkNS09dg==
X-Google-Smtp-Source: ACcGV61g/96gvGYzk6D1pGhX7WZGWnqjk7RNieJnDh71smCElqxhVX4toOXaWAfEtkvrjP5OfvxnNYVBSD644jf5rEk=
X-Received: by 2002:ae9:c107:: with SMTP id z7-v6mr28444739qki.192.1539852267599;
 Thu, 18 Oct 2018 01:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com> <20181017201522.GA26525@bogus>
 <CAO-hwJ+z6YdnLdbzeh-7f99cBBjHfbLKLzKo-fQQaC_W8bt_Uw@mail.gmail.com> <1fb98946-a518-d7d7-3bec-8944be95b91c@redhat.com>
In-Reply-To: <1fb98946-a518-d7d7-3bec-8944be95b91c@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 18 Oct 2018 10:44:16 +0200
Message-ID: <CAO-hwJKXBvuGLensAQv82SoPh-vrt9UFgoC3_XeTA78EHCOANA@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     robh@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:39 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 18-10-18 10:10, Benjamin Tissoires wrote:
> > On Wed, Oct 17, 2018 at 10:15 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
> >>> Some new touchpads IC are connected through PS/2 and I2C. On some of these
> >>> new IC, the I2C part doesn't have all of the information available.
> >>> We need to be able to forward the touchpad parameters from PS/2 and
> >>> thus, we need those new optional properties.
> >>>
> >>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
> >>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >>> ---
> >>>   Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
> >>>   1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
> >>> index 797607460735..ace6bcb0b4eb 100644
> >>> --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
> >>> +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
> >>> @@ -13,6 +13,14 @@ Optional properties:
> >>>     pinctrl binding [1]).
> >>>   - vcc-supply: a phandle for the regulator supplying 3.3V power.
> >>>   - elan,trackpoint: touchpad can support a trackpoint (boolean)
> >>> +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
> >>
> >>> +- elan,max_x: the maximum reported value on the X axis
> >>> +- elan,max_y: the maximum reported value on the Y axis
> >>> +- elan,min_x: the minimum reported value on the X axis
> >>> +- elan,min_y: the minimum reported value on the Y axis
> >>> +- elan,x_res: the resolution of the X axis (in units per mm)
> >>> +- elan,y_res: the resolution of the Y axis (in units per mm)
> >>> +- elan,width: max reported width of a blob
> >>
> >> Can't we use standard touchscreen properties here? (Yes, I get this is a
> >> touchpad, not touchscreen).
> >
> > Hey Rob,
> >
> > Well, there is that (it's a touchpad driver) and we can't also really
> > use the of_touchscreen.c implementation.
> > If both concerns are not an issue, we can then move the [min/max/res]
> > properties to the touchscreen ones.
> >
> > Regarding 'elan,width', this is something missing from the standard ts
> > properties, and AFAICT, this controls the maximum reported
> > width/height of a touch.
> > I should probably rename them to max_width, max_height.
> >
> > Hans, do you think we should add such properties to of_touchscreen.c
> > too? (the width/height ones)
>
> Are there touchscreens which report finger/touch width / height ? if so
> then it probably does make sense.

Well, it's pretty common for hid-multitouch touchscreens to report
such properties (it's a way to indicate the palm). Don't know about
the touchscreens that rely on of_touchscreen though.

> Note that for historical reasons
> Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Looks like your sentence is not finished here :)

>
> Also the touchscreen bindings have: touchscreen-x-mm and touchscreen-y-mm
> rather then res, which can then be used to calculate the resolution.
>

yeah, that's fine, I would need to convert to mm, then go back to res.
Extra effort, but that's the price to pay.

Cheers,
Benjamin

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FFE20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzYUmPJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FFE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeLABsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeLABsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:48:02 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFDB20868;
        Fri, 30 Nov 2018 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543588710;
        bh=0X3KCYxp6TbV6XRmsLFwt8E4eJfVXQlt2+h/AHSJdfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VzYUmPJik3XtuPdKo3gkKVEPR3DHl6fV7VNPOWeSGVaPGOA5wxM2qW0zakXG0u2Mg
         zaLZnGrY/6FnNZDXwbXcOXAn0Pe0rHAob4ggYtxBirPL07bN6krJ82WA9h7CMLmZz7
         3WofH7HGrZCQnyeUAFKDNE46eGClD1Y0hWtqT/3k=
Received: by mail-qt1-f176.google.com with SMTP id r14so6133959qtp.1;
        Fri, 30 Nov 2018 06:38:29 -0800 (PST)
X-Gm-Message-State: AA+aEWYqxCpiAHrqHdFFVau9oFTF6lts8hV/RJfXN2zhEe1vf7ad/nfd
        nD3mjbyJRZRXVNm3Hdyqaw+/PUH35Z+T5M38Mg==
X-Google-Smtp-Source: AFSGD/U3hhEECMXpj9FCp1lGLL/6bpAJMjnenmm/Yaoouvq5GALtr8WPjnd+7EnYstQsg0IrdOTsvr8S+AHdyJRGN6E=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr4863665qtj.76.1543588709102;
 Fri, 30 Nov 2018 06:38:29 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com> <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
In-Reply-To: <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 08:38:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
Message-ID: <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 2:38 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> On 11/13/2018 09:57 PM, Jacek Anaszewski wrote:
> > On 11/12/2018 07:27 PM, Rob Herring wrote:
> >> On Tue, Nov 06, 2018 at 11:07:12PM +0100, Jacek Anaszewski wrote:
> >>> Introduce dedicated properties for conveying information about
> >>> LED function and color. Mark old "label" property as deprecated.
> >>>
> >>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> >>> Cc: Baolin Wang <baolin.wang@linaro.org>
> >>> Cc: Daniel Mack <daniel@zonque.org>
> >>> Cc: Dan Murphy <dmurphy@ti.com>
> >>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> >>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> >>> Cc: Simon Shields <simon@lineageos.org>
> >>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
> >>>  1 file changed, 44 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
> >>> index aa13998..3efc826 100644
> >>> --- a/Documentation/devicetree/bindings/leds/common.txt
> >>> +++ b/Documentation/devicetree/bindings/leds/common.txt
> >>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
> >>>  have to be tightly coupled with the LED device binding. They are represented
> >>>  by child nodes of the parent LED device binding.
> >>>
> >>> +
> >>>  Optional properties for child nodes:
> >>>  - led-sources : List of device current outputs the LED is connected to. The
> >>>             outputs are identified by the numbers that must be defined
> >>>             in the LED device binding documentation.
> >>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
> >>> +       from the header include/dt-bindings/leds/functions.h.
> >>> +       If there is no matching LED_FUNCTION available, add a new one.
> >>> +- color : Color of the LED.
> >>>  - label : The label for this LED. If omitted, the label is taken from the node
> >>>       name (excluding the unit address). It has to uniquely identify
> >>>       a device, i.e. no other LED class device can be assigned the same
> >>> -     label.
> >>> +     label. This property is deprecated - use 'function' and 'color'
> >>> +     properties instead.
> >>
> >> I don't know if I'd go as far a deprecating.
> >>
> >> One thing to consider is how we handle multiple of the same function? Do
> >> we allow an index on function names? What if an index isn't meaningful
> >> and we need "front" vs. "rear" for example? Maybe label is still needed
> >> there.
> >
> > I believe that 'label' property with its old semantics must be preserved
> > for backwards compatibility - it so far has been used inconsistently for
> > conveying variations of devicename:color:function sections. If provided,
> > then it's been taken as-is for LED class device name, or concatenated
> > with the devicename hard-coded in the driver.
> >
> > Regarding the differentiation between the LEDs with functions of
> > same kind - OK, I agree, we will need another section.
> >
> > What seems to fits the best is the reference to the device it is
> > logically associated with.
> >
> > The question is whether the devicename should be provided in DT
> > literally, or by phandle, and then retrieved in runtime, basing on the
> > sysfs entry, like in case of input-leds bridge which for USB keyboard
> > creates LEDs named e.g.:
> >
> > input5::capslock
> > input5::numlock
> > input5::scrolllock
> >
> > Probably we will have to allow for some flexibility in this regard,
> > to allow for providing devicename literally like "rear", "front",
> > or like above input case.
>
> I must admit I have a dilemma  with this devicename part.
> Thinking more of it - the semantics of that section of LED
> class device name needs to be precise. Currently there seem
> to be two types of device names considered:
>
> 1) descriptive name like in case of flash -
>    front-camera::flash, rear-camera::flash, which would allow
>    for providing arbitrary devicenames, i.e. it would not improve
>    LED naming too much, which was the aim of this patch set
> 2) name representing hardware relation or user-defined relation between
>    some device and the LED class device, like in above keyboard
>    LED case:
>
>    - input5::numlock
>
>    or for hard disk:
>
>    - sda1::hdderr,
>
>    In the hdderr case Pavel mentioned the arrangement where the LED
>    is not a part of the hard disk, so the relation would have to be
>    defined in DT.
>    For the flash case the devicename part would be matching /dev/videoN
>    device.
>
> I'm in favour of the option 2) since it seems to be more precise.
> In this case we would need a mechanism for asynchronous LED class
> device registration which would register a LED only after the
> associated device has been probed and its name is known.
> The mechanism would be a simpler form of
> drivers/media/v4l2-core/v4l2-async.c.
>
> In the LED DT node we would need a property holding a phandle
> to the associated device. Then, in the runtime the related device
> would call led_register_associated_device(struct device_node*,
> struct device*) which would in turn match the device_node with
> the phandle assigned to the property in the LED DT node. Having
> the struct device of the associated device we could retrieve
> device node name from dev->kobj.
>
> We would also probably need different DT properties for different
> types of devices, since e.g. for network case the network interface
> name would fit better for the LED name, than the phy name,
> and we would need to know what type of device name we're going
> to look for.
>
> Pavel gave following examples:
>
> eth0:green:link
> adsl0:green:link
> adsl0:red:error
>
> So we would have e.g.:
>
> associated-vl42-device = <&camera1>;
> associated-network-device = <&phy1>;
> associated-block-device = <&phy1>;

Variable property names are kind of a pain to parse.

Perhaps when LEDs are associated with a device, we shouldn't care
within the context of the LED subsystem what the name is. The
association is more important and if you have that exposed, then you
don't really need to care what the name is. You still have to deal
with a device with more than 1 LED, but that becomes a problem local
to that device.

What I'm getting at is following a more standard binding pattern of
providers and consumers like we have for gpios, clocks, etc. So we'd
have something like this:

ethernet {
  ...
  leds = <&green_led>, <&red_led>;
  led-names = "link", "err";
};

We can still support defining LED names as we've done, but we don't
have to come up with some elaborate naming convention that covers
every single case.

Rob

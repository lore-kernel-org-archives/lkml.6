Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DDC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACEA2156E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSZPVVIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACEA2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeHODLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:11:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39861 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:11:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id a11-v6so9842146pgw.6;
        Tue, 14 Aug 2018 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0DE7C+LTBsnAa/zMe+NXmQPTYeEp747HH5Z3a5gnacw=;
        b=aSZPVVIMCc27sf/drsezI3RUSr7MLoqiI+W6bWDolpPiHV7kEVWFyTOaAube8UZtTN
         +IxHt/4zgzF/m6o8vgr3qgfgrkOFuSyMPVl7AIAHSoz43zsdRcgGoWH8VjrJ9XdXgY8Q
         9fQMnlwUoT6Zj1p7A210vdxHWZPVIb+a23XtkDm4+WKJerRn1HoHBDMIx3HLvlr+cIJD
         54UxmsN15HFBsTJo7yWu+ZxizQcLnUlW7mUNqdOzWSEIPz0GbkqzEmEsdfS6L9X17cLr
         ji6Ia/inm5+RNEIMD89POLVmm6hVwK15nOYXDR5h4QnKmPmnAon4WntyRVZQrSS/HolU
         l/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0DE7C+LTBsnAa/zMe+NXmQPTYeEp747HH5Z3a5gnacw=;
        b=OldqlykMOkxM5juWi9b5+vrM8OWYjjx8x15j1OoRgEt3zykyWbf5cs5giPBIq/y1AL
         Alyu0npbjk07t+fk74YuTCUeNC5D6SpJuy8YByQSy+n4L9aEjkqTozSWE4hX7LX0OrRy
         N4Roe9dFEo/cKZ9gVNU83JRYCSljneyjJ6ZMiENqNR8X87ugGszaFS0UKhpMLZprpdIX
         wnQis0lAuKdlnJyqKU+p9ywmT3FuQFUFWG9aJiPrSr9qjqfxuMlwl82a2k0SJvmAUV0m
         j4hnsFMitiCevlDBWB1Msf1/1Ibd6hBqNerfY1NQm4qmj/uYfSr1JoC1udGMDtejFATp
         d7WQ==
X-Gm-Message-State: AOUpUlEpyXTa6U5GLipycDQkTATHSraZ6VD4zJWdStDZA9l+YFNDwx6S
        mHsEhuIKzqkHID3Ns4FS2X4=
X-Google-Smtp-Source: AA+uWPwtyDg7cG+7jowh2TyChWH3zgzWLoBouhgQXJ9jjOoHjIV31GN/Oyh1/nHKAaetYtb/vViBXA==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr23139383pgl.13.1534292528084;
        Tue, 14 Aug 2018 17:22:08 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id v8-v6sm25811118pff.120.2018.08.14.17.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 17:22:06 -0700 (PDT)
Date:   Tue, 14 Aug 2018 17:22:04 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Message-ID: <20180815002204.GA258561@ban.mtv.corp.google.com>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Srinivas, as there are NVMEM questions

Hi Florian,

Thanks for the quick reply.

On Tue, Aug 14, 2018 at 04:00:28PM -0700, Florian Fainelli wrote:
> On 08/14/2018 03:37 PM, Brian Norris wrote:
> > Today, we have generic support for 'mac-address' and 'local-mac-address'
> > properties in both Device Tree nodes and in generic Device Properties,
> > such that network device drivers can pick up a hardware address from
> > there, in cases where the MAC address isn't baked into the network card.
> > This method of MAC address retrieval presumes that either:
> > (a) there's a unique device tree (or similar) stored on a given device
> >     or
> > (b) some other entity (e.g., boot firmware) will modify device nodes
> >     runtime to place that MAC address into the appropriate device
> >     properties.
> > 
> > Option (a) is not feasbile for many systems.
> > 
> > Option (b) can work, but there are some reasons why one might not want
> > to do that:
> >  (1) This requires that system firmware understand the device tree
> >      structure, sometimes to the point of memorizing path names (e.g.,
> >      /soc/wifi@xxxxxxxx). At least for Device Tree, these path names are
> >      not necessarily an ABI, and so this introduces unneeded fragility.
> 
> The path to a node is something that is well defined and should be
> stable given that the high level function of the node and its unit
> address are not supposed to change. Under which circumstances, besides
> incorrect specification of either of these two things, do they not
> consist an ABI? Not refuting your statement here, just curious when/how
> this can happen?

I can think of a few reasons:

 * it's not really standardized whether to use a /soc/ node or to
   just put top-level SoC blocks directly under /. There might be
   "recommendations", but I certainly have seen it both ways.

 * the "high level function name" is not set in stone AFAICT. Or at
   least, I've never seen a list of documented names. So while on one
   system I might see 'wlan@', another might use 'wifi@'.

 * in any of the above (and in any other case of lack of clarity), one
   can make slightly different choices when, e.g., submitting a device
   tree upstream vs. a downstream tree. While we may try our hardest to
   document and stick to documented bindings, I personally can't
   guarantee that one of these choices will be made differently during
   review, possibly breaking any firmware that made assumptions based on
   those choices. So I might end up with a firmware that satisfies
   documented bindings and works with a downstream device tree, but
   doesn't work with a device tree that gets submitted upstream.

> Also, aliases in DT are meant to provide some stability.

How, specifically? I don't see any relevant binding description for
aliases under Documentation/devicetree/bindings/net/.

> >  (2) Other than this device-tree shim requirement, system firmware may
> >      have no reason to understand anything about network devices.
> > 
> > So instead, I'm looking for a way to have a device node describe where
> > to find its MAC address, rather than having the device node contain the
> > MAC address directly. Then system firmware doesn't have to manage
> > anything.
> > 
> > In particular, I add support for the Google Vital Product Data (VPD)
> > format, used within the Coreboot project. The format is described here:
> > 
> > https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> > 
> > TL;DR: VPD consists of a TLV-like table, with key/value pairs of
> > strings. This is often stored persistently on the boot flash and
> > presented via in-memory Coreboot tables, for the operating system to
> > read.
> > 
> > We already have a VPD driver that parses this table and presents it to
> > user space. This series extends that driver to allow in-kernel lookups
> > of MAC address entries.
> 
> A possible alternative approach is to have the VPD driver become a NVMEM
> producer to expose the VPD keys, did you look into that and possibly
> found that it was not a good model? The downside to that approach though
> is that you might have to have a phandle for the VPD provider in the
> Device Tree, but AFAICS this should solve your needs?

I did notice some NVMEM work. The MTD links you point at shouldn't be
relevant, since this table is already present in RAM. But I suppose I
could shoehorn the memory table into being a fake NVMEM...

And then, how would you recommend doing the parameterization I note
here? Is the expectation that I define a new cell for every single type?
Each cell might have a different binary format, so I'd have to describe:
(a) that they contain MAC addresses (so the "reader" knows to translate
    the ASCII strings into equivalent binary representation) and
(b) which key matches (it's not just "mac_address=xxxxx"; there may be
    many MAC addresses, with keys "ether_mac0", "ether_mac1",
    "wifi_mac0")
Part (a) especially doesn't really sound like the typical NVMEM, which
seems to pretend it provides raw access to these memory regions.

Additionally, VPD is not stored at a fixed address, nor are any
particular entries within it (it uses TLV), so it seems like there are
plenty of other bits of the nvmem.txt documentation I'd have to violate
to get there, such as the definition of 'reg':

reg:    specifies the offset in byte within the storage device.

And finally, this may be surmountable, but the existing APIs seem very
device tree centric. We use this same format on ACPI systems, and the
current series would theoretically work on both [1]. I'd have to rewrite
the current (OF-only) helpers to get equivalent support...

BTW, it's quite annoying that we have all of these:

fwnode_get_mac_address()
device_get_mac_address()
of_get_mac_address()
of_get_nvmem_mac_address()

and only 2 of those share any code! Brilliant!

> [1]: https://patchwork.ozlabs.org/cover/956062/
> [2]: https://lkml.org/lkml/2018/3/24/312

Brian

[1] Fortunately, I've only needed this on DT so far.

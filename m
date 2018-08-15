Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726972152A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726972152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeHPBKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:10:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34094 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeHPBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:10:09 -0400
Received: by mail-it0-f68.google.com with SMTP id d70-v6so18563408ith.1;
        Wed, 15 Aug 2018 15:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xj8Pg7/N+Ttp0id8p6NwASY08gzc+07p/yYyocaASFg=;
        b=k1pQM+4AacLx7w9HzmQ8/xnb4AhOUW19cQDZtQvuT/sL/VsJPM/y3+3cSAJFY4zyPl
         gKuO4ukEdSHVsneo/TkBJUFszxgsHIQd+YyQDRf7DiJWvEZFsEsOWZD9c4mp25OBdpGi
         vTDbLeOSfVNkMBkZN+H8WINvf3glM3i+IqUwdMKG+Y7l+ECG04O65x39IL0UKGeC0Xu4
         Rn7syL6n7AZgHBMmc453ETFXpMpo6Oqo0jLOY+Z5smXjnAvfhiOdfK9FeDaPwLP3yYP2
         GpeuX755A8x8154a8wzCKPQfIDW3oCf6L8JvKWCHz/sP8z3+bTRHTc2dZZirL/Ac+/bZ
         hvow==
X-Gm-Message-State: AOUpUlGp3ETHiSTMebwqreQscGU3KP8ljduFG02ANv0Hcm7o6EekPOIq
        pqnNtdyeiE+Iqtlk7atHOw==
X-Google-Smtp-Source: AA+uWPz0zy6u99gA1kIM/wdkspf4GfH4NpqFfq+FWJqapCh/GFHuYV/Z8cf7ZAi3vxEp/E8nSI4AAA==
X-Received: by 2002:a24:b54b:: with SMTP id j11-v6mr19573535iti.79.1534371363570;
        Wed, 15 Aug 2018 15:16:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id n21-v6sm7159067ioj.22.2018.08.15.15.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 15:16:02 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:16:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <20180815221601.GB24830@rob-hp-laptop>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815014436.GA17200@ban.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 06:44:36PM -0700, Brian Norris wrote:
> Hi,

I should have read the rest of this thread first...

> 
> On Tue, Aug 14, 2018 at 05:52:49PM -0700, Florian Fainelli wrote:
> > On 08/14/2018 05:22 PM, Brian Norris wrote:
> > >  * in any of the above (and in any other case of lack of clarity), one
> > >    can make slightly different choices when, e.g., submitting a device
> > >    tree upstream vs. a downstream tree. While we may try our hardest to
> > >    document and stick to documented bindings, I personally can't
> > >    guarantee that one of these choices will be made differently during
> > >    review, possibly breaking any firmware that made assumptions based on
> > >    those choices. So I might end up with a firmware that satisfies
> > >    documented bindings and works with a downstream device tree, but
> > >    doesn't work with a device tree that gets submitted upstream.
> > 
> > Sure, this is kind of a self inflicted problem but agreed this does exist.
> 
> You can say "self-inflicted", but of all the things that need to go
> upstream, the DTS files themselves are the least integral. I mean, why
> else do we ever pretend to have anything close to an ABI for device
> tree bindings?

That sounds like an inadequately documented binding.

> 
> > >> Also, aliases in DT are meant to provide some stability.
> > > 
> > > How, specifically? I don't see any relevant binding description for
> > > aliases under Documentation/devicetree/bindings/net/.
> > 
> > Indeed they are not, likewise, we should probably update devicetree-spec
> > to come up with standard names that of_alias_get_id() already consumes.
> 
> A quick grep shows we already have divergence: both "eth" and "ethernet"
> are in use.

Uggg, it would be nice to clean that up. 

There's several aliases I'd like to get rid of (some platforms went a 
little crazy with them) and I'd like to start requiring alias names to 
be documented. I created an issue for the spec. Patches welcomeTM. :)

> But anyway, would the idea be that you just put 'ethernet{0,1,...}' and
> 'wifi{0,1,...}' aliases in the /chosen node, then require boot firmware
> to insert any {ethernet,wifi}_mac{0,1,...} into the paths represented by
> the corresponding aliases?

In the /aliases node, but yes.

>  I suppose that would reduce the problems with
> (1), but it still doesn't really help with (2).
> 
> In some circles, the gold standard of boot firmware is to be as thin as
> possible, doing only what's needed to get a kernel up and running, and
> this function seems wholly unrelated to the firmware's core
> functionality. I mean, the kernel already knows how to parse VPD, so why
> can't it learn to find the right field?
> 
> > >>>  (2) Other than this device-tree shim requirement, system firmware may
> > >>>      have no reason to understand anything about network devices.
> > >>>
> > >>> So instead, I'm looking for a way to have a device node describe where
> > >>> to find its MAC address, rather than having the device node contain the
> > >>> MAC address directly. Then system firmware doesn't have to manage
> > >>> anything.
> > >>>
> > >>> In particular, I add support for the Google Vital Product Data (VPD)
> > >>> format, used within the Coreboot project. The format is described here:
> > >>>
> > >>> https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> > >>>
> > >>> TL;DR: VPD consists of a TLV-like table, with key/value pairs of
> > >>> strings. This is often stored persistently on the boot flash and
> > >>> presented via in-memory Coreboot tables, for the operating system to
> > >>> read.
> > >>>
> > >>> We already have a VPD driver that parses this table and presents it to
> > >>> user space. This series extends that driver to allow in-kernel lookups
> > >>> of MAC address entries.
> > >>
> > >> A possible alternative approach is to have the VPD driver become a NVMEM
> > >> producer to expose the VPD keys, did you look into that and possibly
> > >> found that it was not a good model? The downside to that approach though
> > >> is that you might have to have a phandle for the VPD provider in the
> > >> Device Tree, but AFAICS this should solve your needs?
> > > 
> > > I did notice some NVMEM work. The MTD links you point at shouldn't be
> > > relevant, since this table is already present in RAM. But I suppose I
> > > could shoehorn the memory table into being a fake NVMEM...
> > > 
> > > And then, how would you recommend doing the parameterization I note
> > > here? Is the expectation that I define a new cell for every single type?
> > > Each cell might have a different binary format, so I'd have to describe:
> > > (a) that they contain MAC addresses (so the "reader" knows to translate
> > >     the ASCII strings into equivalent binary representation) and
> > 
> > I see, in your current patch series that knowledge is pushed to both the
> > VPD producer and the specific object lookup function, so this scales better.
> 
> Yeah, one of the advantages is that my API is specialized to exactly one
> data type ;) With the nvmem API, the data format isn't really specified,
> so you gotta hope that either the NVMEM stores MAC addresses as 6 bytes
> of binary data, or else that the NVMEM driver figures out how to do any
> translation for you implicitly.
> 
> If I understand the NVMEM subsystem correctly, that is.
> 
> > > (b) which key matches (it's not just "mac_address=xxxxx"; there may be
> > >     many MAC addresses, with keys "ether_mac0", "ether_mac1",
> > >     "wifi_mac0")
> > 
> > The key to lookup is definitively node specific, it is just unfortunate
> > that there is not a better way to infer which key to lookup for (as
> > opposed to just having to specify it directly) based on the Device Tree
> > topology. By that I mean, if you have a "mac-address-lookup" property
> > associated with Wi-Fi adapter #1 (with numbering starting at 0), then
> > this automatically means looking up for "wifi_mac1", etc.
> 
> Would that really be a virtue, though? Keys can really be anything (in
> VPD, or in any other hypothetical MAC address store), and it seems nice
> to avoid entangling them with device tree specifics too much. And how
> does one figure out what's Device 0 anyway? Based on the FDT layout? I
> don't actually know what order 'dtc' puts my nodes in.
> 
> > > Part (a) especially doesn't really sound like the typical NVMEM, which
> > > seems to pretend it provides raw access to these memory regions.
> > > 
> > > Additionally, VPD is not stored at a fixed address, nor are any
> > > particular entries within it (it uses TLV), so it seems like there are
> > > plenty of other bits of the nvmem.txt documentation I'd have to violate
> > > to get there, such as the definition of 'reg':
> > > 
> > > reg:    specifies the offset in byte within the storage device.
> > > 
> > > And finally, this may be surmountable, but the existing APIs seem very
> > > device tree centric. We use this same format on ACPI systems, and the
> > > current series would theoretically work on both [1]. I'd have to rewrite
> > > the current (OF-only) helpers to get equivalent support...
> > 
> > All fair points, never mind NVMEM, I was just too keen on thinking this
> > would be finally the way to make the consumers and producers of such
> > information into a single API, but your proposal appears valid too.
> 
> I don't want to throw out any notion of unification from the start, but
> I don't immediately see how one would do that reasonably. I'm still open
> to education though, and I'm definitely not wedded to my specific
> proposal.

Seems to me that nvmem needs to be extended to allow providers to 
retrieve and interpret data. Not everything is at some fixed offset and 
size. Something like this is valid dts:

nvmem = <&phandle> "a-string";

But that's pretty uncommon (I can't think of a binding that actually 
uses that). Perhaps the provider has an array of keys defined and the 
consumer just provides the index.

Or we could do '<key>-nvmem = <&phandle>', but parsing that is a bit 
more complicated.

Rob

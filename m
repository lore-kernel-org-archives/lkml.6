Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D82C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1398216F6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBCW5hXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1398216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeHOEef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:34:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeHOEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:34:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so10047044pff.11;
        Tue, 14 Aug 2018 18:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfYpEMoqchs7fx3GIBpvTVNFsszyP2Wa/nc1B1iox4o=;
        b=WBCW5hXPrEqpbCcz5uvf5Va4PU71YsbipAaX9qfEwMC+5l2/lpVSogF/qJwFE0uhbl
         QNkPj+8pvA8PcR0Kqdy1Op3+LRVbB3m4LIl6Dtj7GtQZxCunuwM2TzjvXsxl0OMr6Qwr
         bafNT9nSUajzwmdJIXZAUyhUIA8vGNdZh8lbAHCmkbdOE0LLfBUIbd+CqErrumET6WDn
         sW/igW7BQazmZfFrnVcqUqnhS399ty7bJdyKRxKsxOF8fJgtthNhn0NGDApxIpFY9jzh
         Nc+w/0P/7A8e8xwnZ9z7zIo75i7AnjJ+zJ5wxdAKC7BPx8M1GkI0KCNGYTYS5BKr7sGu
         AyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfYpEMoqchs7fx3GIBpvTVNFsszyP2Wa/nc1B1iox4o=;
        b=ONIJVa3LZeqwgQXrpmHfaDEjTvICd8euKIcZiSdfpNMoYcpXMT+sV54Eu3QZLq+Ga4
         CgpOQgL9rKi9jUV4lE8lpDWUC9zu7AI/S4GiAWn5J90xYoW/PNtOHhBYRFtSE9a600hO
         OTGrGNDpCba/dWWF9x3mUTR3bfkjhaVcCujPiw4S0rJ8B9YJOJNtDm1TunbIsWo9hxMo
         VOa/zz+t/ouvEGELdgl81PA5kLZBgkHVZ4AQKtlxV08Xg9O1BzkadhJZx29IDWquGuAO
         gt25TbFPO+N9Xs/rmf6m4zgssZrn17kyk9O6wX/9t9UFzlsVWsYuuPwD1IS+0pKcuzZg
         9FSw==
X-Gm-Message-State: AOUpUlE0/wZ2bXU01qnsh0K9mVsxKx94IlVvz7ByRJrDDYK69v8/wRQu
        VyjxjZdZFGEorawNkAhwz04=
X-Google-Smtp-Source: AA+uWPwfb7USG/AbGiSk//H7iBUixLzfKqfHjFhJoWbw+AYQYwN45EBAyPk3GiyfBzP8P5FWO+gWDQ==
X-Received: by 2002:a63:121a:: with SMTP id h26-v6mr23796724pgl.316.1534297479871;
        Tue, 14 Aug 2018 18:44:39 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id a81-v6sm41719463pfa.152.2018.08.14.18.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 18:44:38 -0700 (PDT)
Date:   Tue, 14 Aug 2018 18:44:36 -0700
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
Message-ID: <20180815014436.GA17200@ban.mtv.corp.google.com>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 14, 2018 at 05:52:49PM -0700, Florian Fainelli wrote:
> On 08/14/2018 05:22 PM, Brian Norris wrote:
> >  * in any of the above (and in any other case of lack of clarity), one
> >    can make slightly different choices when, e.g., submitting a device
> >    tree upstream vs. a downstream tree. While we may try our hardest to
> >    document and stick to documented bindings, I personally can't
> >    guarantee that one of these choices will be made differently during
> >    review, possibly breaking any firmware that made assumptions based on
> >    those choices. So I might end up with a firmware that satisfies
> >    documented bindings and works with a downstream device tree, but
> >    doesn't work with a device tree that gets submitted upstream.
> 
> Sure, this is kind of a self inflicted problem but agreed this does exist.

You can say "self-inflicted", but of all the things that need to go
upstream, the DTS files themselves are the least integral. I mean, why
else do we ever pretend to have anything close to an ABI for device
tree bindings?

> >> Also, aliases in DT are meant to provide some stability.
> > 
> > How, specifically? I don't see any relevant binding description for
> > aliases under Documentation/devicetree/bindings/net/.
> 
> Indeed they are not, likewise, we should probably update devicetree-spec
> to come up with standard names that of_alias_get_id() already consumes.

A quick grep shows we already have divergence: both "eth" and "ethernet"
are in use.

But anyway, would the idea be that you just put 'ethernet{0,1,...}' and
'wifi{0,1,...}' aliases in the /chosen node, then require boot firmware
to insert any {ethernet,wifi}_mac{0,1,...} into the paths represented by
the corresponding aliases? I suppose that would reduce the problems with
(1), but it still doesn't really help with (2).

In some circles, the gold standard of boot firmware is to be as thin as
possible, doing only what's needed to get a kernel up and running, and
this function seems wholly unrelated to the firmware's core
functionality. I mean, the kernel already knows how to parse VPD, so why
can't it learn to find the right field?

> >>>  (2) Other than this device-tree shim requirement, system firmware may
> >>>      have no reason to understand anything about network devices.
> >>>
> >>> So instead, I'm looking for a way to have a device node describe where
> >>> to find its MAC address, rather than having the device node contain the
> >>> MAC address directly. Then system firmware doesn't have to manage
> >>> anything.
> >>>
> >>> In particular, I add support for the Google Vital Product Data (VPD)
> >>> format, used within the Coreboot project. The format is described here:
> >>>
> >>> https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> >>>
> >>> TL;DR: VPD consists of a TLV-like table, with key/value pairs of
> >>> strings. This is often stored persistently on the boot flash and
> >>> presented via in-memory Coreboot tables, for the operating system to
> >>> read.
> >>>
> >>> We already have a VPD driver that parses this table and presents it to
> >>> user space. This series extends that driver to allow in-kernel lookups
> >>> of MAC address entries.
> >>
> >> A possible alternative approach is to have the VPD driver become a NVMEM
> >> producer to expose the VPD keys, did you look into that and possibly
> >> found that it was not a good model? The downside to that approach though
> >> is that you might have to have a phandle for the VPD provider in the
> >> Device Tree, but AFAICS this should solve your needs?
> > 
> > I did notice some NVMEM work. The MTD links you point at shouldn't be
> > relevant, since this table is already present in RAM. But I suppose I
> > could shoehorn the memory table into being a fake NVMEM...
> > 
> > And then, how would you recommend doing the parameterization I note
> > here? Is the expectation that I define a new cell for every single type?
> > Each cell might have a different binary format, so I'd have to describe:
> > (a) that they contain MAC addresses (so the "reader" knows to translate
> >     the ASCII strings into equivalent binary representation) and
> 
> I see, in your current patch series that knowledge is pushed to both the
> VPD producer and the specific object lookup function, so this scales better.

Yeah, one of the advantages is that my API is specialized to exactly one
data type ;) With the nvmem API, the data format isn't really specified,
so you gotta hope that either the NVMEM stores MAC addresses as 6 bytes
of binary data, or else that the NVMEM driver figures out how to do any
translation for you implicitly.

If I understand the NVMEM subsystem correctly, that is.

> > (b) which key matches (it's not just "mac_address=xxxxx"; there may be
> >     many MAC addresses, with keys "ether_mac0", "ether_mac1",
> >     "wifi_mac0")
> 
> The key to lookup is definitively node specific, it is just unfortunate
> that there is not a better way to infer which key to lookup for (as
> opposed to just having to specify it directly) based on the Device Tree
> topology. By that I mean, if you have a "mac-address-lookup" property
> associated with Wi-Fi adapter #1 (with numbering starting at 0), then
> this automatically means looking up for "wifi_mac1", etc.

Would that really be a virtue, though? Keys can really be anything (in
VPD, or in any other hypothetical MAC address store), and it seems nice
to avoid entangling them with device tree specifics too much. And how
does one figure out what's Device 0 anyway? Based on the FDT layout? I
don't actually know what order 'dtc' puts my nodes in.

> > Part (a) especially doesn't really sound like the typical NVMEM, which
> > seems to pretend it provides raw access to these memory regions.
> > 
> > Additionally, VPD is not stored at a fixed address, nor are any
> > particular entries within it (it uses TLV), so it seems like there are
> > plenty of other bits of the nvmem.txt documentation I'd have to violate
> > to get there, such as the definition of 'reg':
> > 
> > reg:    specifies the offset in byte within the storage device.
> > 
> > And finally, this may be surmountable, but the existing APIs seem very
> > device tree centric. We use this same format on ACPI systems, and the
> > current series would theoretically work on both [1]. I'd have to rewrite
> > the current (OF-only) helpers to get equivalent support...
> 
> All fair points, never mind NVMEM, I was just too keen on thinking this
> would be finally the way to make the consumers and producers of such
> information into a single API, but your proposal appears valid too.

I don't want to throw out any notion of unification from the start, but
I don't immediately see how one would do that reasonably. I'm still open
to education though, and I'm definitely not wedded to my specific
proposal.

> Is ChromeOS' directly inspired from the PCI's spec VPD?

I really don't have any idea. From glancing at the PCI spec, its format
isn't very similar, relative to how simple each of them are.

> > BTW, it's quite annoying that we have all of these:
> > 
> > fwnode_get_mac_address()
> > device_get_mac_address()
> > of_get_mac_address()
> > of_get_nvmem_mac_address()
> > 
> > and only 2 of those share any code! Brilliant!
> 
> Sounds like you just found another area to improve on ;)

Sure ;) I knew about the useless duplication of of_get_mac_address(),
but I wasn't aware of of_get_nvmem_mac_address(). It seems like it might
have come out of a deficiency that I already noticed in
of_get_mac_address(): that it assumes you can return a const pointer.

I'll probably try to remove as many uses of of_get_mac_address() as
possible and settle on fwnode_get_mac_address() /
device_get_mac_address(). Probably would be good to have
fwnode_get_mac_address() also do the of_get_nvmem_mac_address() work and
deprecate of_get_nvmem_mac_address() too.

Regards,
Brian

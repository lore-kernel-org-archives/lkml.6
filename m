Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08744C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB42156E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPJthrs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FB42156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeHODmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:42:52 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33688 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:42:52 -0400
Received: by mail-qk0-f195.google.com with SMTP id 27-v6so14777114qkv.0;
        Tue, 14 Aug 2018 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQJL6iytY+d96Cmpgfzg72GKmjGQVH0/V1/rgE25vaY=;
        b=PPJthrs4Ojvjv5eB5oYAo9/dNUwl6b7K9a6+M47g9Vc+aPE2GjjUyPLXbZ4luMiMIz
         l47d8KDCm1ZCEccknF92xjguIBGvXuhuR+48rDoVvhC6O01EgBHaAnRQALNrpuroiLei
         PLo0Ov3sYxiYcknC9CI6RDHedmpu5A6lZHqYe7pR07DYJDjAxvG4d+mDAl1OlVWqfD7a
         heLr/IaDm+tjE6BYoHxZYa/O1pM1c1yl1W2118dJA40/eGeNv52ducSnh3erFwByagdU
         UnFP08VpLi24SwpankvgRRsWXSaYeAYDi1Z+7OQejvSJ0s7VM/Tr6uZGD8OkjkLk8SqY
         wk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cQJL6iytY+d96Cmpgfzg72GKmjGQVH0/V1/rgE25vaY=;
        b=FYdTTPSeoYezwoQCDpXVOjxGbuRmc3/9g2E+oIoC/7BBRHbSltBzUVVbOFf4xi4m46
         BxwCBpfePbV3eHe5UKn5BXm7fNGUa1vtiTFBWJbIKh4vFm0kWe3p6GYx4CoiuwtTWWJ4
         imQOOwph6tp/Ct02oSX49pPSxwn3j9R/SMTve3b9uCKx3Wpn8ZVYLtMpnXfZVRI/r1XM
         XONmH0P0SEZ8Jhsdd1xjxJr7GC7eU+BVx6mflRJfZdJDbjopSYiSjwZvYk2vJ0vWKkUQ
         RPgiPNmpKOHW8fjkbiSocGios1xISBDatS8MGr9z8tCz1zkm8Sl1hKkwmoIQQNE1jorF
         TBmw==
X-Gm-Message-State: AOUpUlFubcnPUEcCoUtu1jq+fcIWizhXh/RBZc1lLqr9ulLZC1V1pJLm
        UfeEOMSk9WZE84NpA7nolQc=
X-Google-Smtp-Source: AA+uWPw4+pZ65Bes9/4g6HTqXvK0pU09L0vTmBoyH/NDkf7H5CIed/FRj3+L5KjUT1WLj8h+1bt8pQ==
X-Received: by 2002:a37:a6d3:: with SMTP id p202-v6mr21938970qke.126.1534294385793;
        Tue, 14 Aug 2018 17:53:05 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id s23-v6sm13493169qtk.95.2018.08.14.17.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 17:53:04 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
To:     Brian Norris <computersforpeace@gmail.com>
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
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
Date:   Tue, 14 Aug 2018 17:52:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180815002204.GA258561@ban.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 05:22 PM, Brian Norris wrote:
> + Srinivas, as there are NVMEM questions
> 
> Hi Florian,
> 
> Thanks for the quick reply.
> 
> On Tue, Aug 14, 2018 at 04:00:28PM -0700, Florian Fainelli wrote:
>> On 08/14/2018 03:37 PM, Brian Norris wrote:
>>> Today, we have generic support for 'mac-address' and 'local-mac-address'
>>> properties in both Device Tree nodes and in generic Device Properties,
>>> such that network device drivers can pick up a hardware address from
>>> there, in cases where the MAC address isn't baked into the network card.
>>> This method of MAC address retrieval presumes that either:
>>> (a) there's a unique device tree (or similar) stored on a given device
>>>     or
>>> (b) some other entity (e.g., boot firmware) will modify device nodes
>>>     runtime to place that MAC address into the appropriate device
>>>     properties.
>>>
>>> Option (a) is not feasbile for many systems.
>>>
>>> Option (b) can work, but there are some reasons why one might not want
>>> to do that:
>>>  (1) This requires that system firmware understand the device tree
>>>      structure, sometimes to the point of memorizing path names (e.g.,
>>>      /soc/wifi@xxxxxxxx). At least for Device Tree, these path names are
>>>      not necessarily an ABI, and so this introduces unneeded fragility.
>>
>> The path to a node is something that is well defined and should be
>> stable given that the high level function of the node and its unit
>> address are not supposed to change. Under which circumstances, besides
>> incorrect specification of either of these two things, do they not
>> consist an ABI? Not refuting your statement here, just curious when/how
>> this can happen?
> 
> I can think of a few reasons:
> 
>  * it's not really standardized whether to use a /soc/ node or to
>    just put top-level SoC blocks directly under /. There might be
>    "recommendations", but I certainly have seen it both ways.

That type of stability and standardization, ok

> 
>  * the "high level function name" is not set in stone AFAICT. Or at
>    least, I've never seen a list of documented names. So while on one
>    system I might see 'wlan@', another might use 'wifi@'.

There are some recommended function names defined in devicetree-spec,
not everything is covered since the spec is still lagging a bit behind
as far as recommending names for what a modern SoC/board would embed
(with some definition of "modern").

> 
>  * in any of the above (and in any other case of lack of clarity), one
>    can make slightly different choices when, e.g., submitting a device
>    tree upstream vs. a downstream tree. While we may try our hardest to
>    document and stick to documented bindings, I personally can't
>    guarantee that one of these choices will be made differently during
>    review, possibly breaking any firmware that made assumptions based on
>    those choices. So I might end up with a firmware that satisfies
>    documented bindings and works with a downstream device tree, but
>    doesn't work with a device tree that gets submitted upstream.

Sure, this is kind of a self inflicted problem but agreed this does exist.

> 
>> Also, aliases in DT are meant to provide some stability.
> 
> How, specifically? I don't see any relevant binding description for
> aliases under Documentation/devicetree/bindings/net/.

Indeed they are not, likewise, we should probably update devicetree-spec
to come up with standard names that of_alias_get_id() already consumes.

> 
>>>  (2) Other than this device-tree shim requirement, system firmware may
>>>      have no reason to understand anything about network devices.
>>>
>>> So instead, I'm looking for a way to have a device node describe where
>>> to find its MAC address, rather than having the device node contain the
>>> MAC address directly. Then system firmware doesn't have to manage
>>> anything.
>>>
>>> In particular, I add support for the Google Vital Product Data (VPD)
>>> format, used within the Coreboot project. The format is described here:
>>>
>>> https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
>>>
>>> TL;DR: VPD consists of a TLV-like table, with key/value pairs of
>>> strings. This is often stored persistently on the boot flash and
>>> presented via in-memory Coreboot tables, for the operating system to
>>> read.
>>>
>>> We already have a VPD driver that parses this table and presents it to
>>> user space. This series extends that driver to allow in-kernel lookups
>>> of MAC address entries.
>>
>> A possible alternative approach is to have the VPD driver become a NVMEM
>> producer to expose the VPD keys, did you look into that and possibly
>> found that it was not a good model? The downside to that approach though
>> is that you might have to have a phandle for the VPD provider in the
>> Device Tree, but AFAICS this should solve your needs?
> 
> I did notice some NVMEM work. The MTD links you point at shouldn't be
> relevant, since this table is already present in RAM. But I suppose I
> could shoehorn the memory table into being a fake NVMEM...
> 
> And then, how would you recommend doing the parameterization I note
> here? Is the expectation that I define a new cell for every single type?
> Each cell might have a different binary format, so I'd have to describe:
> (a) that they contain MAC addresses (so the "reader" knows to translate
>     the ASCII strings into equivalent binary representation) and

I see, in your current patch series that knowledge is pushed to both the
VPD producer and the specific object lookup function, so this scales better.

> (b) which key matches (it's not just "mac_address=xxxxx"; there may be
>     many MAC addresses, with keys "ether_mac0", "ether_mac1",
>     "wifi_mac0")

The key to lookup is definitively node specific, it is just unfortunate
that there is not a better way to infer which key to lookup for (as
opposed to just having to specify it directly) based on the Device Tree
topology. By that I mean, if you have a "mac-address-lookup" property
associated with Wi-Fi adapter #1 (with numbering starting at 0), then
this automatically means looking up for "wifi_mac1", etc.

> Part (a) especially doesn't really sound like the typical NVMEM, which
> seems to pretend it provides raw access to these memory regions.
> 
> Additionally, VPD is not stored at a fixed address, nor are any
> particular entries within it (it uses TLV), so it seems like there are
> plenty of other bits of the nvmem.txt documentation I'd have to violate
> to get there, such as the definition of 'reg':
> 
> reg:    specifies the offset in byte within the storage device.
> 
> And finally, this may be surmountable, but the existing APIs seem very
> device tree centric. We use this same format on ACPI systems, and the
> current series would theoretically work on both [1]. I'd have to rewrite
> the current (OF-only) helpers to get equivalent support...

All fair points, never mind NVMEM, I was just too keen on thinking this
would be finally the way to make the consumers and producers of such
information into a single API, but your proposal appears valid too.

Is ChromeOS' directly inspired from the PCI's spec VPD?

> 
> BTW, it's quite annoying that we have all of these:
> 
> fwnode_get_mac_address()
> device_get_mac_address()
> of_get_mac_address()
> of_get_nvmem_mac_address()
> 
> and only 2 of those share any code! Brilliant!

Sounds like you just found another area to improve on ;)

> 
>> [1]: https://patchwork.ozlabs.org/cover/956062/
>> [2]: https://lkml.org/lkml/2018/3/24/312
> 
> Brian
> 
> [1] Fortunately, I've only needed this on DT so far.
> 


-- 
Florian

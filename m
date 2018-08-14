Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5492C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477FB21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZetFc0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477FB21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbeHOBuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:50:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37614 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOBuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:50:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so18546136wrr.4;
        Tue, 14 Aug 2018 16:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbxEI88v7S1LIKhzv01zRqVA9cgfAK0KOTLpuHOSpr4=;
        b=aZetFc0Ggk5E/noyE0rkCM9q0Fga1CErZQae25yaEdcUlJqWPTyshk0IyNuPIOTCEj
         kM16OhT1Fs4An6zko0SA2Rb0tXZBA/xSzr6myImFgbU7pdkvhyvqoCrwkxUTtL/2w8Fs
         5OMtkTOnxM0+ehTRj1wUB/HoCGFaHlgS8trIkfOa46b0Sc0HRMivaT1xUyw5u7tvMbju
         r3vEubv+rxTu0j8+5KGLcZUfmmX7PbT25QhdsZ3L8YHuG3lO+4y3ZA3d9z2FTLSU+9Uw
         teHlm9xT4IH5qVC2UXSVsPKUuq+CT4B/tam6WXCLmNPH5Kdc03+xdcawuswrc/J0r1Ur
         A0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XbxEI88v7S1LIKhzv01zRqVA9cgfAK0KOTLpuHOSpr4=;
        b=AOZB+Bumb1l+rfV2FY9axMa1YyyOCDgDJNSS5h/AO3A9OPM9Kil7HlP8WWV/9d4Sit
         0yPcoE1I1NG0Q2MhblTpaUdCNmrJgw+IGfDb2Y0wz26UUdR2oX0BWKcx3HPjWXhxt7vI
         eCvEB20e7eFLrp94B99uwSeHAgHjCQCHNpe79ucL8jr//xjUZ3ZRWYaNc700aXhULl+k
         f5nYkPw3MzTdOrLq4hQ8VMq8DEvDvpnV66JoJqCePIperVHGCiQfJU5tgWAABButlCrO
         3dntdkY5RHmJIgEtaE7L+QGGto+nGulBV9MS2Uw/WC3w7Hdej6fyqQAmwpFBL/NH6lGX
         6uIw==
X-Gm-Message-State: AOUpUlGj4sPt46WLXv093S79l+0q/fcLV/dbW16D0KLzpy6Vn39RE3l2
        xSBLsIt6DSQq7cAx/KVNQqg=
X-Google-Smtp-Source: AA+uWPwnHyMSay37UcDUtnj5B8lGf5iin+I9/3KsIoKFMGJZbBOLYEqzCKi/bPmzR4j7+LsLzHKuIQ==
X-Received: by 2002:adf:ed8e:: with SMTP id c14-v6mr14254670wro.264.1534287651425;
        Tue, 14 Aug 2018 16:00:51 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm19928097wrn.83.2018.08.14.16.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 16:00:50 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
To:     Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>
References: <20180814223758.117433-1-briannorris@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
Date:   Tue, 14 Aug 2018 16:00:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814223758.117433-1-briannorris@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 03:37 PM, Brian Norris wrote:
> Hi all,
> 
> Preface: I'm sure there are at least a few minor issues with this
> patchset as-is. But I'd appreciate ("RFC") if I can get general feedback
> on the approach here; perhaps there are alternatives, or perhaps I've
> missed similar proposals in the past. (My problems don't feel all that
> unique.)
> 
> ---
> 
> Today, we have generic support for 'mac-address' and 'local-mac-address'
> properties in both Device Tree nodes and in generic Device Properties,
> such that network device drivers can pick up a hardware address from
> there, in cases where the MAC address isn't baked into the network card.
> This method of MAC address retrieval presumes that either:
> (a) there's a unique device tree (or similar) stored on a given device
>     or
> (b) some other entity (e.g., boot firmware) will modify device nodes
>     runtime to place that MAC address into the appropriate device
>     properties.
> 
> Option (a) is not feasbile for many systems.
> 
> Option (b) can work, but there are some reasons why one might not want
> to do that:
>  (1) This requires that system firmware understand the device tree
>      structure, sometimes to the point of memorizing path names (e.g.,
>      /soc/wifi@xxxxxxxx). At least for Device Tree, these path names are
>      not necessarily an ABI, and so this introduces unneeded fragility.

The path to a node is something that is well defined and should be
stable given that the high level function of the node and its unit
address are not supposed to change. Under which circumstances, besides
incorrect specification of either of these two things, do they not
consist an ABI? Not refuting your statement here, just curious when/how
this can happen?

Also, aliases in DT are meant to provide some stability.

>  (2) Other than this device-tree shim requirement, system firmware may
>      have no reason to understand anything about network devices.
> 
> So instead, I'm looking for a way to have a device node describe where
> to find its MAC address, rather than having the device node contain the
> MAC address directly. Then system firmware doesn't have to manage
> anything.
> 
> In particular, I add support for the Google Vital Product Data (VPD)
> format, used within the Coreboot project. The format is described here:
> 
> https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> 
> TL;DR: VPD consists of a TLV-like table, with key/value pairs of
> strings. This is often stored persistently on the boot flash and
> presented via in-memory Coreboot tables, for the operating system to
> read.
> 
> We already have a VPD driver that parses this table and presents it to
> user space. This series extends that driver to allow in-kernel lookups
> of MAC address entries.

A possible alternative approach is to have the VPD driver become a NVMEM
producer to expose the VPD keys, did you look into that and possibly
found that it was not a good model? The downside to that approach though
is that you might have to have a phandle for the VPD provider in the
Device Tree, but AFAICS this should solve your needs?

[1]: https://patchwork.ozlabs.org/cover/956062/
[2]: https://lkml.org/lkml/2018/3/24/312

> 
> Thanks,
> Brian
> 
> 
> Brian Norris (3):
>   dt-bindings: net: Add 'mac-address-lookup' property
>   device property: Support complex MAC address lookup
>   firmware: vpd: add MAC address parser
> 
>  .../devicetree/bindings/net/ethernet.txt      | 12 +++
>  drivers/base/property.c                       | 83 ++++++++++++++++++-
>  drivers/firmware/google/vpd.c                 | 67 +++++++++++++++
>  include/linux/property.h                      | 23 +++++
>  4 files changed, 183 insertions(+), 2 deletions(-)
> 


-- 
Florian

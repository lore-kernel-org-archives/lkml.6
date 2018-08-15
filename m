Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447ECC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240FC2154C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240FC2154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeHOXjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:39:17 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:38899 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:39:17 -0400
Received: by mail-io0-f196.google.com with SMTP id v26-v6so2103597iog.5;
        Wed, 15 Aug 2018 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DZ5r8zGafbo09xhbGqiH9vKzd+YZ77rQ9RmGNYTjyYg=;
        b=fxCI/MUx/99syle92ta/or1QDP7X8j+Fw4UXIiRzrr30dB2PKmw/qLqvAH24lbGC0V
         3mR1C2yK/wgXGFmtJLx1zZt3x9Phqh9FrwgxbWzFAYJ+yOGxTMx3hp+bH6k2G6cKdxyV
         fG138m0VBNcvIETGLpzfnWd2k6mkMkORJlrVZMZsSkpkb4wRTXQ0tldXhuRb+Lp5um1c
         ZvBgJoBYgYgiMiTdyPL+grxX/gErHtAl2gceF+w/45CifhKii2OvznMbukydezEFiIuX
         Ato2owM22SYDocdaq3t8zdwd8vuAjJbG5llviOGXMXXnT042NVlASWGAg7pBL9VdvtMB
         NIAA==
X-Gm-Message-State: AOUpUlFLRy95mo4bysuQTgRpF1DjMqUjjE8rAlno71gwQ29sN/XW38pN
        62y9ye1KMX7WibmTqgSqXg==
X-Google-Smtp-Source: AA+uWPxNulXEun9rCJpd+9dCxT9UOoV4VRcoE9JmQzQhW6g2x5rcc353TayI4kZZmW2/A34ItLVPiA==
X-Received: by 2002:a6b:2c9:: with SMTP id 192-v6mr24550771ioc.123.1534365930649;
        Wed, 15 Aug 2018 13:45:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g23-v6sm8645964iob.88.2018.08.15.13.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:45:30 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:45:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: net: Add 'mac-address-lookup'
 property
Message-ID: <20180815204529.GA24830@rob-hp-laptop>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <20180814223758.117433-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180814223758.117433-2-briannorris@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 03:37:56PM -0700, Brian Norris wrote:
> Some firmwares present data tables that can be parsed to retrieve
> device-specific details, like MAC addresses. While in some cases, one
> could teach the firmware to understand the device tree format and insert
> a 'mac-address'/'local-mac-address' property into the FDT on its own,
> this method can be brittle (e.g., involving memorizing expected FDT
> structure), and it's not strictly necessary -- especially when parsers
> for such firmware formats are already needed in the OS for other
> reasons.

If you have an 'ethernetN' alias then you don't need to know the 
structure. IIRC, that is what u-boot does.

> 
> One such format: the Vital Product Data (VPD) [1] used by Coreboot. It
> supports a table of key/value pairs, and some systems keep MAC addresses
> there in a well-known format. Allow a device tree to specify
>   (1) that the MAC address for a given device is stored in the VPD table
>       and
>   (2) what key should be used to retrieve the MAC address for said
>       device (e.g., "ethernet_mac0" or "wifi_mac1").
> 
> [1] Ref:
> https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> TL;DR: VPD consists of a TLV-like table, with key/value pairs of
> strings. This is often stored persistently on the boot flash and
> presented via in-memory Coreboot tables, for the operating system to
> read.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  Documentation/devicetree/bindings/net/ethernet.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
> index cfc376bc977a..d3fd1da18bf4 100644
> --- a/Documentation/devicetree/bindings/net/ethernet.txt
> +++ b/Documentation/devicetree/bindings/net/ethernet.txt
> @@ -4,6 +4,18 @@ NOTE: All 'phy*' properties documented below are Ethernet specific. For the
>  generic PHY 'phys' property, see
>  Documentation/devicetree/bindings/phy/phy-bindings.txt.
>  
> +- mac-address-lookup: string, indicating a method by which a MAC address may be
> +  discovered for this device. Methods may be parameterized by some value, such
> +  that the method can determine the device's MAC address using that parameter.
> +  For example, a firmware might store MAC addresses in a table, keyed by some
> +  predetermined string, and baked in read-only flash. A lookup method "foo"
> +  with a parameter "bar" should be written "foo:bar".
> +  Supported values for method:
> +    "google-vpd" - Google's Vital Product Data (VPD), as used in the Coreboot
> +      project. Documentation for VPD can be found at:
> +        https://chromium.googlesource.com/chromiumos/platform/vpd/+/master/README.md
> +  Example:
> +    mac-address-lookup = "google-vpd:ethernet_mac0"

This doesn't strike me as a very DT style way of describing this. I 
would expect something like a phandle to the VPD and an identifier. 

Also, an already common way besides local-mac-address is using nvmem 
binding which wouldn't use this and perhaps could be used here? This 
feels very much Google specific, not common (and maybe that is fine).

Rob

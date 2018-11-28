Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43D82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43D82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeK1P0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:26:17 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35678 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeK1P0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:26:17 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so20949259edx.2;
        Tue, 27 Nov 2018 20:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOkLZlsvADrnqKiPbHPJ6IpFB4pq1F+b1THmG8uyKgA=;
        b=LO4KAkD4kJOIGX2wsGzEo3BR3yhDn1AShNQ7HQ1QVGNiOIKgl5ObsolQMuGIUx1zXx
         RozTLeKkIdJp6RSzVTiEbBNUWKWtOH/b0dvjvxcDRyUBbRBvT+k74FH8NvQVK0HVnU+N
         hyYFs6zVi5lEbFR0GdwwLjbcznh0OX7PkXJXllgx+z2Ax4Zr2Y1ZyQ/GP0eShWLnszlB
         mi7oDsce498wUfVGDf62Yeu8YQ6pq1RHRyEHSfshw1m1CA/1B4R1237id/WmaUVLI2R3
         tX/CssfS7nAEgQweh/gAUp2hQ2vWNz1fG2/IjQ53U65VzyjEUDA3QCzVOXR7SXYNB9If
         0Cdg==
X-Gm-Message-State: AA+aEWaBYR/TgN0rZ8OWRL7Mqr3U71P8Xmx+gkyo+JTczK+19paCjLus
        az79KIy6kRjs7D+UzThTz7RepieECgg=
X-Google-Smtp-Source: AFSGD/WIPLRoJHxcGRO16gni09fivxRuz7x7Bly1P6rIXgGOR1jG25S30aFnx0YEL8uw/+PiM3e7hA==
X-Received: by 2002:a50:8799:: with SMTP id a25mr29244544eda.96.1543379161942;
        Tue, 27 Nov 2018 20:26:01 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id e18-v6sm839582ejm.26.2018.11.27.20.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 20:26:01 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id a18so456345wmj.1;
        Tue, 27 Nov 2018 20:26:01 -0800 (PST)
X-Received: by 2002:a1c:2304:: with SMTP id j4mr1183669wmj.14.1543379161075;
 Tue, 27 Nov 2018 20:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20181115093603.26729-1-wens@csie.org>
In-Reply-To: <20181115093603.26729-1-wens@csie.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 28 Nov 2018 12:25:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
Message-ID: <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth controllers
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 15, 2018 at 5:36 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> This is v2 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> based SBCs series.
>
> Changes since v1:
>
>   - Collected tags
>   - Re-organize dt binding clocks and clock-names properties
>   - Simplify check for deferred probe when getting clocks
>   - Add explanation of Cubietruck's clk_out_a pinmux setting placement
>     to commit message.
>   - Add missing "uart-has-rtscts" property to Cubietruck device tree
>
> Original cover letter follows.
>
>
> On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> module from AMPAK. Inside is either one or two Broadcom chips, depending
> on the model. This series enables the Bluetooth controllers for AMPAK
> AP6210, AP6212, and AP6330 found on several boards. More will come later
> as other SoCs require changes to some other parts. I did not cover the
> SCO PCM connections from the controller to the SoC's I2S interface. It
> seems no one is actually doing this, so I was not sure how to proceed.
> Any suggestions?
>
> I deliberately left out the netdev mailing list and Dave Miller, as the
> only thing that is under net is the binding document. Maybe we should
> move that out of Documentation/devicetree/bindings/net/ ?
>
> Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> any discussions.
>
> Patches 1 through 4 are device tree binding changes:
>
> 1 - Make the external clock name unambiguous, and add a second entry for
>     the LPO clock.
>
> 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
>
> 3 - Add a compatible string for BCM20702A1.
>
> 4 - Add a compatible string for BCM4330.
>
> Patches 5 through 13 are changes to the driver, either improvements,
> or updates to handle the updated device tree binding.
>
> 5 - Make the driver handle deferred probing for the external clock.
>
> 6 - Simplify clock error checking for subsequent clk API calls.
>
> 7 - Handle clock-names for the main external clock.
>
> 8 - Support a new external clock, the LPO.
>
> 9 - Support regulator supplies.
>
> 10 - Wait a small amount of time after toggling the GPIO for the device
>      to settle.
>
> 11 - Add support for BCM20702A1, including its default address.
>
> 12 - Add BCM4330 compatible string to the driver.
>
> 13 - Handle default address for BCM43430A0.
>
> 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
>      boards.
>
> 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
>
> checkpatch reports an error for both patch 11 and patch 13:
>
>     ERROR: space required after that close brace '}'
>
> I followed the existing code's style. If this is undesirable, I can send
> a follow-up patch fixing the entire code block.
>
> The first 13 patches should go through the Bluetooth tree, while we, the
> sunxi maintainers, will take the last 2.

It's been close to two weeks. Any comments or concerns from the Bluetooth
maintainers? I'd like to see this in 4.22 if possible.

Thanks
ChenYu

> Thanks
> ChenYu
>
> Chen-Yu Tsai (14):
>   dt-bindings: net: broadcom-bluetooth: Fix external clock names
>   dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
>   dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
>   dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
>   Bluetooth: hci_bcm: Handle deferred probing for the clock supply
>   Bluetooth: hci_bcm: Simplify clk_get error handling
>   Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
>   Bluetooth: hci_bcm: Add support for LPO clock
>   Bluetooth: hci_bcm: Add support for regulator supplies
>   Bluetooth: hci_bcm: Wait for device to come out of reset after power
>     on
>   Bluetooth: hci_bcm: Add compatible string for BCM4330
>   Bluetooth: btbcm: Add default address for BCM43430A0
>   ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards
>   arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
>
> Maxime Ripard (1):
>   Bluetooth: hci_bcm: Add BCM20702A1 variant
>
>  .../bindings/net/broadcom-bluetooth.txt       |  11 +-
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  23 ++++
>  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  18 +++
>  .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  18 +++
>  arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  |  14 +++
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  14 +++
>  drivers/bluetooth/btbcm.c                     |  13 +-
>  drivers/bluetooth/hci_bcm.c                   | 112 +++++++++++++++---
>  8 files changed, 206 insertions(+), 17 deletions(-)
>
> --
> 2.19.1
>

Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5729220658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="rf8YV8Sr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5729220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeH3VYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:24:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37816 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3VYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:24:14 -0400
Received: by mail-yw1-f67.google.com with SMTP id x83-v6so3912243ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p4OmgXaLc9hpICA7WDTcI03ozuY5xmcvRXnuzZAnF8s=;
        b=rf8YV8SrmqAr6vUxgAoSXxkshGacJr6HlI4Oe/J5a0LYi2VFunYW81AdKncge6BbeD
         JuXnYs8SGtDdrDfjQbyxiJS5wXt/6R0Yjn6KUHc2jgunGV3zs7im9QP0Iln8T6tQRP4Z
         8cBXQttGUsqBlVGrmT/E82oKTXNIj3jjhqtM1rWGAXNDihe0s6n5K6ntFpVEZSah2T+V
         bBaDtVXJC8nVwKnXPGDrueBr38ydNsNjaLD+qaFdyUyEY19DaehGzcVRDNVmyxYFxmn1
         b1bGxivsmm01rBjzA18O3/HY3ql6yoTjERVurZTloUDl93gRAorphLmtkIaSryr/b6lk
         2Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p4OmgXaLc9hpICA7WDTcI03ozuY5xmcvRXnuzZAnF8s=;
        b=ggeG5LNyKrP8AqpFb5PtCwV0SyTKAezgwSMX/i4wBqJmCePkPCnZb09CA3nxG1VKwU
         maP7CNSGELFaChhOP+vNnJriHLow5VCXKVjYhPsOCCvfT4VO55TZIp54YAyQB3DbaUTp
         yxi+oiIfsCiXnReCmS3c1tmViz5PNjhCPOC6h+QswPFmnX7jFpZQ6uuARKETseCuWwDa
         x50NysFIRlwcxzR5LW3/Igi/UVueWAAyBu8+wBc1YrEp/NQ1tuAnC20zuQ+QSauczVVV
         9gnuWVh3aTBaOEkjZVzK0DgHf41vLXk2lnMe6gI6J+MQEC6iIuMsEBOULOZILdbkRqfu
         8iIA==
X-Gm-Message-State: APzg51AX6yDTULcvDCynS0yjaUXdBHh8SiI6YuGTemgrhANcRRDrE8d0
        1jO+3iV8g7AN+udKXhnW196Hzs6p4ioeDNKAHm3t0Q==
X-Google-Smtp-Source: ANB0VdZYy9+I+1NdEHS5bNr5r/vYCQqumxC0ZB+OEdzbiJpvXKjjO582UFABUOBSmvbdBDQnYdfvNYs8LqkQPjzQ2zU=
X-Received: by 2002:a25:d657:: with SMTP id n84-v6mr6345362ybg.62.1535649664365;
 Thu, 30 Aug 2018 10:21:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:3c0a:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 10:21:03
 -0700 (PDT)
In-Reply-To: <20180830030420.GB16896@lunn.ch>
References: <20180830004046.9417-1-mdf@kernel.org> <20180830004046.9417-2-mdf@kernel.org>
 <20180830030420.GB16896@lunn.ch>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Thu, 30 Aug 2018 10:21:03 -0700
Message-ID: <CAAtXAHe_fX9_XExvFj20a0L-=b0Z1gX410=wnR=P2DjO-hEByA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: nixge: Add support for fixed-link subnodes
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Aug 29, 2018 at 8:04 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Aug 29, 2018 at 05:40:44PM -0700, Moritz Fischer wrote:
>> Add support for fixed-link cases where no MDIO is
>> actually required to run the device.
>> In that case no MDIO bus is instantiated since the
>> actual registers are not available in hardware.
>
> Hi Moritz
>
> There are a few different use cases here:
>
> The hardware is missing MDIO - You need fixed-link.

Agreed.
>
> The hardware has MDIO, but you don't have a PHY connected on it, and
> use fixed link.

Since it's an FPGA design in that case we'd probably build the hardware without
MDIO to save resources.

> The hardware has MDIO, and it is used e.g. for an Ethernet switch, or
> a PHY for another Ethernet interface. Plus you need fixed link.
We haven't had that yet but I can see that happen.
>
> The binding typically looks like:
>
> &fec1 {
>         phy-mode = "rmii";
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_fec1>;
>         status = "okay";
>
>         fixed-link {
>                 speed = <100>;
>                 full-duplex;
>         };
>
>         mdio1: mdio {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 status = "okay";
>
>                 switch0: switch0@0 {
>                         compatible = "marvell,mv88e6085";
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&pinctrl_switch>;
>                         reg = <0>;
>                         eeprom-length = <512>;
>                         interrupt-parent = <&gpio3>;
>
> It is important you have the mdio subnode, with PHYs and switches as
> children. The driver currently gets this wrong, it uses
> pdev->dev.of_node.

Oh, whoops. Yeah I should look into that. Any good examples of drivers doing
it right? Is the one going with the DT snippet above a good example?
>
> So the first patch should be to extend this behaviour. Look for a
> child node called mdio. If it exists, call nixge_mdio_setup() passing
> that child. Otherwise continue using pdev->dev.of_node, so you don't
> break backwards compatibility.

Ok will do.
>
> Then a patch adding support for fixed-link. If the mdio child node
> exists, you still need to register the MDIO bus. If there is no child
> node, but there is a fixed-link, skip registering the mdio bus with
> pdev->dev.of_node.
>
>         Andrew

Thanks for your feedback, much appreciated!

Moritz

Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A37ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B30D2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pE/S9jbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B30D2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJQP1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:27:37 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50258 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeJQP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:27:36 -0400
Received: by mail-it1-f195.google.com with SMTP id k206-v6so1252012ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LNAoO2HxLAyLKCDSmU0bIMrnD0ZH8ffJN8m0FdILJM=;
        b=pE/S9jbm84IF5tAwWpTVl3qk7VqLn1zDnql19k6dTQIK3ByTazsF3An3SLob7D4SAS
         YtaT5k+VGMcL7gu0ypZpXrnsx7a4zf6cSC+n7hND2lLNN9NaPGcRvI05OCjkwGWZpj9/
         fMx0YMyzEvqYfeBA2HSzVifahhlRpYJ03Y9rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LNAoO2HxLAyLKCDSmU0bIMrnD0ZH8ffJN8m0FdILJM=;
        b=TDJbZwam+solNrCYVEJccq3V6ULCBK3WPw7fEEw4B/5bpXhnyd5vGoe/nVDuNS/dK1
         E1d/6UYEXOi+H7J313ONuewmSiyqiAyt9dwSNZypUKsBBiiIqfwXzxjCubOxeeQXhbQF
         Jjq+RuVRdk0W/nWm1jHTz0i0rQuETkkTwbUN1g5IJkheJwxAbT+RXJ9umYWU9Lkr/V+V
         8OVUK3OVbDktw0SFKkDbsvKwtyNhzWG+G5A7hl4AauDYhm13kQ2qlzOsTN1/VWdKkv8r
         N1EMbEtRukmv5YIpj7VPKaISXD4TsPgmVVVeIluIIm1GOhJXZCBXuMvhr46Ub8jhHCrP
         UDug==
X-Gm-Message-State: ABuFfojImE03Kgd/apfKpzgpVydo64lRucC85i01DeD7p+nLnn0V7lPT
        hAvuzrtRQyzOy3wju7QQvRyA+124xwThGWvX1vJYUg==
X-Google-Smtp-Source: AJdET5cTe2BFaEA2Lp7SHa/K7/CFGxhntDyMHVhxieXZLh0/FaZr3g1Q4RMxMoGQy+SgOxbC6eiMu5LNrN0lUWQR690=
X-Received: by 2002:a24:7f06:: with SMTP id r6-v6mr952483itc.107.1539761594370;
 Wed, 17 Oct 2018 00:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
In-Reply-To: <1537951204-24672-1-git-send-email-yong.deng@magewell.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 Oct 2018 13:03:03 +0530
Message-ID: <CAMty3ZD3TDOC_PSvbEtopT12pCmXCDqZQdPVB9GNC7wOrj_LYQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v11 1/2] dt-bindings: media: Add Allwinner
 V3s Camera Sensor Interface (CSI)
To:     Yong Deng <yong.deng@magewell.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, arnd@arndb.de,
        Hans Verkuil <hans.verkuil@cisco.com>,
        laurent.pinchart@ideasonboard.com, geert@linux-m68k.org,
        jacob-chen@iotwrt.com, Neil Armstrong <narmstrong@baylibre.com>,
        treding@nvidia.com, Philipp Zabel <p.zabel@pengutronix.de>,
        todor.tomov@linaro.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:11 PM Yong Deng <yong.deng@magewell.com> wrote:
>
> Add binding documentation for Allwinner V3s CSI.
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
>
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> new file mode 100644
> index 000000000000..2ff47a9507a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,59 @@
> +Allwinner V3s Camera Sensor Interface
> +-------------------------------------
> +
> +Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> +interface and CSI1 is used for parallel interface.
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * bus: the CSI interface clock
> +    * mod: the CSI module clock
> +    * ram: the CSI DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset line driving the CSI
> +
> +Each CSI node should contain one 'port' child node with one child 'endpoint'
> +node, according to the bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt. As mentioned
> +above, the endpoint's bus type should be MIPI CSI-2 for CSI0 and parallel or
> +Bt656 for CSI1.

But A64 manual claimed that CSI0 is parallel (ofcourse it has only one
controller). On the other-side the register space seems similar. and
also is Bt656 and CCIR656 are same types?

-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.

Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F102AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD7021A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD7021A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeHGFEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:04:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38925 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeHGFEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:04:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so6171045edi.6;
        Mon, 06 Aug 2018 19:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fWZgV4Mals+JqP30LIEMRhWw87nUMDgteXgCr8G1130=;
        b=SSAXm9yLeNfNot51UWrWy1qSABbYKdx0yDCU+oa8ZH3P+VECp7FPb6oaIvnd/TXIoG
         0/yHE8d+/mxnoQaU8wBNqqK2RiZfXK2W/B4Q4bCNfpVpa+2o+jhiOCpjouEpwks05eR1
         nxn8eji9MxJ1nhpBAD6NLrRNaLXmjZDSPVVN6EhZn9+0YfBxg0TPHSLfZTTzKdUsW4Zb
         ZUAfMW09JMb/Hv8/PvEmTI6Vzt6GqT+NufGZu5+aYGTwJvCkgNG4OBIytBPrf72afBib
         sG/y0IF3o2ZjqJrLlA1tf8fEMWCs/ASfQZzdJlCDUY9kvTRFIGgZFHZIFdtWpCfb8dK4
         cnxw==
X-Gm-Message-State: AOUpUlGpwph5iCf2XBViKpgBprMxyeWieHz8ca11N7YvY749tg2Pbwrx
        xg8YSwkI5zw0GglilL/2pNaIG3shp+Y=
X-Google-Smtp-Source: AAOMgpftEofQ7iL55Y16VVuFrodAwYz6oz3/B88Mg46NM1hhzIpPOzccoxrzqW/okB5t7xq2yaBPkA==
X-Received: by 2002:a50:cc4d:: with SMTP id n13-v6mr20466922edi.171.1533610361998;
        Mon, 06 Aug 2018 19:52:41 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id w3-v6sm243576edb.16.2018.08.06.19.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 19:52:41 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id e7-v6so14180228wrs.9;
        Mon, 06 Aug 2018 19:52:41 -0700 (PDT)
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr11222141wrr.105.1533610361161;
 Mon, 06 Aug 2018 19:52:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 19:52:20 -0700 (PDT)
In-Reply-To: <1533109399-21174-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com> <1533109399-21174-1-git-send-email-Akash_Gajjar@mentor.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 7 Aug 2018 10:52:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v66GoZJ4nXs7S0F3JXJ3Jm0ZBRXy0r2e4STqVPV5S0UVUQ@mail.gmail.com>
Message-ID: <CAGb2v66GoZJ4nXs7S0F3JXJ3Jm0ZBRXy0r2e4STqVPV5S0UVUQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: add csi regulator to sopine dts
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 3:43 PM, Akash Gajjar <Akash_Gajjar@mentor.com> wrote:
> sopine board has a csi. enable supply dvdd-1v8-csi, dovdd-2v8-csi and
> avdd-2v8-csi on board to access external camera connected to it.

Unless there are other uses beyond supplying the camera module, this is not
going to be accepted. Enabling power to the camera should be in the same
patch as enabling the camera itself. And since it is a module, it should
be an overlay file.


ChenYu


> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> index 43418bd..256229b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
> @@ -68,6 +68,13 @@
>
>  #include "axp803.dtsi"
>
> +&reg_aldo1 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <2800000>;
> +       regulator-max-microvolt = <2800000>;
> +       regulator-name = "dovdd-csi";
> +};
> +
>  &reg_aldo2 {
>         regulator-always-on;
>         regulator-min-microvolt = <1800000>;
> @@ -112,6 +119,13 @@
>         regulator-name = "vdd-sys";
>  };
>
> +&reg_dldo3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <2800000>;
> +       regulator-max-microvolt = <2800000>;
> +       regulator-name = "avdd-csi";
> +};
> +
>  &reg_eldo1 {
>         regulator-always-on;
>         regulator-min-microvolt = <1800000>;
> @@ -119,6 +133,13 @@
>         regulator-name = "vdd-1v8-lpddr";
>  };
>
> +&reg_eldo3 {
> +       regulator-always-on;
> +       regulator-min-microvolt = <1800000>;
> +       regulator-max-microvolt = <1800000>;
> +       regulator-name = "vdd-csi";
> +};
> +
>  &reg_fldo1 {
>         regulator-min-microvolt = <1200000>;
>         regulator-max-microvolt = <1200000>;
> --
> 2.7.4
>

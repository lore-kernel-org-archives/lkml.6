Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82869C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4AB2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BLmigqZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfARV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:59:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46386 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfARV7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:59:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so15707064otm.13;
        Fri, 18 Jan 2019 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HE+d4pn8R1S0TXQHgoAYCtz3osRElnBuppy55K+02hQ=;
        b=BLmigqZBc3TiOhPbuGJk9gnC67arWjIiFpBd95sC+D5mOIBoxfIj7GuyapSJrdu9EP
         DQ9m6W0AY0+O+bHvD1GTZwZ9KpTcYibhFqR7dvsikRaQArn187ZHeFcj/dLL6RRL1Lze
         stn2HWlOX+eYFPeBiv7l4qT2YtlDUqXZtv7/kRpNkmgAVxZKq/9Ce60lEYf1sGdhCy7I
         KluyvFDlxpJPXsUah6KBisB6GvIdkYPpRvxNB1lCj1xLpL3uPzgSXllxghuAh9HnireV
         I2GWvvCLHhMVQrxc6KuCVL5QPsfMG4I7psJ1cSgQ6EHAUBimVa2wvW1pzmNiWGg7pkOy
         WLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HE+d4pn8R1S0TXQHgoAYCtz3osRElnBuppy55K+02hQ=;
        b=dHt1wphzAy5UvoBld2wi6/dD5BGQSbfrr2JZlf9z50JBR2RgpQHJqYWKIZZmMwGLMl
         HcLk3O1QDjAimebXM61jJmDM6PAMUfLS3sti3xkmpC3UVljIyeC9KbUnvKJCBqFwqvyC
         lgT2WIVdq6aZDDcr/6ziAyUkA+hbZg5N/pMMw6S1OdcfVa8/017CXyc9ejx6talE40UL
         jaYBPEn2B2WMI0BbyK4tgI2IkmUdytNRDt8Pm009+P8I17XhTIyCShOvzE7gLCuzC20R
         GfFieH6U0DFEjr8g6m7jierI31bqNqJ8MS9rLTn69tyuovhCf4SJdzW9z3e4g3Q5isMi
         r7jg==
X-Gm-Message-State: AJcUukfaNb9Sk9vl8kiVijdPJr29n6YQI7PHA7SNGKYUwgKhB4rYxEED
        4pALVaiECLNJ2MZAzcKLRIKe9x4tPkvBdegXwyo=
X-Google-Smtp-Source: ALg8bN4tx7TZmQq7l/bpqJTnxnZSWuDTCkF/OiYcuTZg+odXhBUJ8JTOiRVoAegqkm8XQIw9ZGNxuJR/Ftrsk/RWLlc=
X-Received: by 2002:a05:6830:2115:: with SMTP id i21mr13289563otc.237.1547848782499;
 Fri, 18 Jan 2019 13:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20190118103423.15075-1-jbrunet@baylibre.com> <20190118103423.15075-5-jbrunet@baylibre.com>
In-Reply-To: <20190118103423.15075-5-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jan 2019 22:59:31 +0100
Message-ID: <CAFBinCB=SEGQzLaqbUMFGoc_LpnJtMd-V4ao9a9JhcFKzmYT6Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: meson: g12a: add clk measure support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:34 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add the clock measure device to the g12a SoC family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index bd24de947a5b..59900ddb7b43 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -193,6 +193,11 @@
>                         #interrupt-cells = <3>;
>                         #address-cells = <0>;
>                 };
> +
> +               clk_msr: clock-measure@ffd18000 {
> +                       compatible = "amlogic,meson-g12a-clk-measure";
> +                       reg = <0x0 0xffd18000 0x0 0x10>;
> +               };
I'll wait with my Reviewed-by until we have a result in the G12A bus
discussion in "arm64: dts: meson: g12a: add clk measure support" from
[0]


[0] https://patchwork.kernel.org/patch/10766427/

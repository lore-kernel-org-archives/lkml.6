Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279B4C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8BB24C13
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+vGzc0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8BB24C13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeFWOGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 10:06:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54072 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeFWOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 10:06:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so4783759wmc.3;
        Sat, 23 Jun 2018 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHKV0u1aqA/nObwnCSRKv9FuzAEt6bwPmT8IT7Ekb0A=;
        b=f+vGzc0sOy57tnsYAXgr/86y5lH4PK/mGhv+gEemnQSTJ/CmugyGwf7lRYVMNn0lH2
         +E3E71PxFcOfNSjf7XIvT2GW8vriVIBl5x58TChfz4TXmV09CFmJS6Yfro2xqe61ta3r
         gvfLrCg8EgkdLPEg/P6UCwqSxNlUKRLaOzlA2bCPIHKXndi7pF3nLwc31Q4dc+pexHWv
         r1oJtyNw38aoXltXYGLOnwBfqQjJf7HkHZn9HYkOGr6x/LtBtkh9XumUYWhj19pFZFVD
         pKZjtF/urRHW2NFdSj/VWEZYka4Cq2WYtFSa7p7lpg3k1WKhzozbMUUAcqZHs9JuCGLm
         PxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHKV0u1aqA/nObwnCSRKv9FuzAEt6bwPmT8IT7Ekb0A=;
        b=Dsvr2j1J4QY8psiOY1zYiovFOWUf35j6zn4sGHQuYFV2f2Zhuj18RT9NkURdem1UYg
         XXwC3qKGacjhx7lxhvRoeFe0I6USTlf/Mjp25W88X5S71XexamL4wCNjy9KtNS/ahehx
         e8lM7i2+Ecpbw/3wXecNUrIKxQJOtnVpT4apdoe7MqwW/g4RtZMh39AtMth+obObsAG0
         6n/s7a2suqVFD97uDU8HT75k/IxVcEO2LA13HRbWONTnOmkDdiypdk+WTK0nzZ3O3Jap
         lfmpl9z07a2DEYXhaTQEx4Hzg4s9aZspZvuk07+3Dv/i0zGN+jlNxa3f2lCY+hMZ+WEV
         RCnQ==
X-Gm-Message-State: APt69E0+8HnHeb41Yb8oFKGz5Hm676arbdRm6oY/uHEd2tNjAI7awXtV
        QgTJ+QJcrq8c523CT04ZvZpgN6thUK5W1903eoc=
X-Google-Smtp-Source: ADUXVKKqL8QszzB2FRlAbFygRRu9xz7db2VpcX4zigPu0SJVlbWNHwUJfzpJAmtOJQzy9C1NATL86QVW/4C4xWLC15M=
X-Received: by 2002:a1c:88c9:: with SMTP id k192-v6mr4867011wmd.125.1529762805348;
 Sat, 23 Jun 2018 07:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180622124540.56203-1-icenowy@aosc.io> <20180622124540.56203-4-icenowy@aosc.io>
In-Reply-To: <20180622124540.56203-4-icenowy@aosc.io>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 24 Jun 2018 00:06:27 +1000
Message-ID: <CAGRGNgUuEjmEcvJ3OUcQ9_6bPs9fDvKzUFm_NfCsYyjxVOVw3A@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/7] arm64: allwinner: a64: add necessary
 device tree nodes for DE2 CCU
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, jagan@amarulasolutions.com,
        jernej.skrabec@siol.net, devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Fri, Jun 22, 2018 at 10:49 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> As we have all necessary parts to enable the DE2 CCU on the Allwinner
> A64 SoC, add the needed device tree nodes, including the DE2 CCU itself
> and the DE2 bus.
>
> The "mixer0-lcd0" simplefb device node is updated to use the DE2 CCU.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Drop SRAM controller device tree node addition (as it's already added
>   as part of syscon change.)
> - Fix the clock reference in LCD SimpleFB.
>
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 30 +++++++++++++++----
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index ff2ddde1e117..318c4ba8ae9f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -58,17 +60,12 @@
>                 #size-cells = <1>;
>                 ranges;
>
> -/*
> - * The pipeline mixer0-lcd0 depends on clock CLK_MIXER0 from DE2 CCU.
> - * However there is no support for this clock on A64 yet, so we depend
> - * on the upstream clocks here to keep them (and thus CLK_MIXER0) up.
> - */
>                 simplefb_lcd: framebuffer-lcd {
>                         compatible = "allwinner,simple-framebuffer",
>                                      "simple-framebuffer";
>                         allwinner,pipeline = "mixer0-lcd0";
>                         clocks = <&ccu CLK_TCON0>,
> -                                <&ccu CLK_DE>, <&ccu CLK_BUS_DE>;
> +                                <&display_clocks CLK_MIXER0>;

Doesn't this technically break simplefb if this DT is used with a
Linux that doesn't have the display clock driver?

Do we care about breaking that use-case?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

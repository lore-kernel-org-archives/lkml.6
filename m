Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF12ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1858620685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hSYftw83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1858620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJaRu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:50:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42958 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeJaRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:50:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181031085314euoutp02fb913fbc2901e4df4abf36711fb6912e~ipYCfg2EL2435824358euoutp02G
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:53:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181031085314euoutp02fb913fbc2901e4df4abf36711fb6912e~ipYCfg2EL2435824358euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540975994;
        bh=FVRs0YKnZeRnCumFs24+zLIanT+TkUqAzpHM2rWGxnw=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=hSYftw83xOln9h3PD/xE3pXNDcS4nX/auGXyD5WAKWPESpyexeWnajxPmiIOzn5g9
         f8+W6nhcWDi3BeoMWeT8846uvUHDUMz+cxf6zCP5hBWgHVk7HmC5XDzeUnHCPJsZCg
         F+l4J02J5KNLGbt3xfvxSJLJmSJFaxNVpw+0aTw8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181031085313eucas1p205b833a8e7cf42a4d69cd2ed9d015103~ipYBg0axM1128011280eucas1p2d;
        Wed, 31 Oct 2018 08:53:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 18.BE.04806.87D69DB5; Wed, 31
        Oct 2018 08:53:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181031085312eucas1p298ba1e27686aba9a26f5cd5ceea78966~ipYAsaxRs2089120891eucas1p2J;
        Wed, 31 Oct 2018 08:53:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181031085312eusmtrp2f4723d52946d3c77be9d67ea766a4dc4~ipYAaovJ02751127511eusmtrp2k;
        Wed, 31 Oct 2018 08:53:12 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ec-5bd96d78d344
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A4.05.04128.87D69DB5; Wed, 31
        Oct 2018 08:53:12 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181031085311eusmtip2eb45b506b49de89c47e3122ab8ebced5~ipX-jUf4y0578505785eusmtip2P;
        Wed, 31 Oct 2018 08:53:11 +0000 (GMT)
Subject: Re: [PATCH v3 17/25] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3c4c8a08-8c1e-1ac6-2b53-81389d69c97b@samsung.com>
Date:   Wed, 31 Oct 2018 09:53:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026144344.27778-18-jagan@amarulasolutions.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+85tR2nrNK29aZSOgq6a1R8fFZHR5UAEURHSiFx20Mip7aip
        QVpiqWVlZuIQLcyZly4uswtZsWo6LcuuWt5SK5aJiM5YqbXtGPnf732f9/3e54GPJZW5jA97
        ICpW0EdpI9WMJ1VjcTQtTdC1apZl9q7BWU1WAqdZviI8YDyNcNHTJhq/tQ8weOhyB4GHTecY
        /O6njcSmnvc0HjzdQeM39wsY/LvbIsMlH5oJ3GV7hHDDsTQKNzdsxGm1T2V4/H0VhR3mlwS2
        DdZT67z5a4OdNF/sGCf4ysJKxA+0pMn4wsoj/M3uCpq/Z2iX8Q+yrQxvKs9g+DsjXTTfeaqO
        4G9dSeYfZ+VQ/JBpzjbFbs81+4XIA/GCPnBtqGfExbwUJqZHlWB8vjMF1XtlIg8WuJVg66mh
        XazkriIwmxWZyNPJwwiuWmyUVAwh+GHKZv5tPMu4TkhCKYJrfU2kVPQjyLKmIteUF6eDshaH
        zCV4c300XGh84xYYbiGM3Wp1PyXn1sJwoYlwMcXNh8a2MzIXz+BCIL2zYmJmOljzeykXe3DB
        UG9qd5slublwp7+AlFgFH3uL3JaAe8xCQ76RkrxugOuf2yfYC77XVcskng1/7hUREifD8fy3
        pLScjqC+uHQi6Gp4UtfsvMY6LyyEG/cDpXYwlH2qdbeBU0BL/3TJgwLO1+SRUlsO6SeU0rQ/
        dL64TUqsgpJX9onHeci259HnkL9hUkrDpGSGSckM/z1cQlQ5Uglxoi5cEFdECYcDRK1OjIsK
        DwiL1pmQ87M2jtfZ76KHo/vMiGOReqq8K6xFo6S18WKizoyAJdXe8twEZ0u+X5uYJOij9+rj
        IgXRjHxZSq2SGwurNEouXBsrHBSEGEH/TyVYD58UtCV08+LQ+NoCZFywIHn0V1J7qiNWs2RL
        5NHtmafifbstyw62jUEwVOVvCuEzNvj17RnJ+RYyGlj9OuBb0NYvJT5hQbl7dvn6aT/M3eE3
        1DWmmPFVKWrkZ/VLI/TRT+b5B+Ts+l66SiifeTwWqg/dHls+K+aktWpa6vqkKa8N9lUje9WU
        GKENWkTqRe1fm/VcyqgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xe7oVuTejDb42sFj0njvJZNF67Bmj
        xftlPYwW84+cY7W48vU9m8XnhfeYLL5smsBmcfX7S2aLTY+vsVp87LnHanF51xw2i9+PjrFb
        LL1+kcniwcv9jBanGltZLC6ecrVo3XuE3eLftY0sFj8PnWeyePnxBIuDiMfaj/dZPRb//Mfk
        sWbeGkaP9zda2T3mran22PBoNavHzll32T32TDzJ5rFpVSebx/ZvD1g97ncfZ/LYvKTe40Dv
        ZBaPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL
        9O0S9DKmTW9gK3gsXrHsTEgD4wnhLkZODgkBE4mjneuYuhi5OIQEljJKHHr0nxkiIS6xe/5b
        KFtY4s+1LjaIoteMEgvnvWMFSQgL5EqsvPGTHcQWEXjLKvHsrhhE0SlGicsz/7OAJNgENCX+
        br7JBmLzCthJfJm3iQnEZhFQlTh9pw+sWVQgQuLsy3WMEDWCEidnPgHr5RRwlDix6S7YMmYB
        dYk/8y4xQ9jyEtvfzoGyxSVuPZnPNIFRcBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73i
        xNzi0rx0veT83E2MwJSx7djPLTsYu94FH2IU4GBU4uF9kHwjWog1say4MvcQowQHs5II79QK
        oBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA9NZXkm8oamhuYWlobmxubGZhZI473mDyigh
        gfTEktTs1NSC1CKYPiYOTqkGRpnrSw7u8/nnx5Lv4NvJcX3SNsaGviy5M59mcv26wKfhYtny
        79Xdi5KV/cqLjHJ9byer6j8zW9s7tXSe6NbTz7dMspT/W6exQ+DGB+3GzbNSgnyjI63rHr5b
        ekevgftl1tkjrG9FtZayb9vfaakrID9N9+B/3pOnw2o/2JVzHNUNXLN4/3e2eiWW4oxEQy3m
        ouJEAAplHtYvAwAA
X-CMS-MailID: 20181031085312eucas1p298ba1e27686aba9a26f5cd5ceea78966
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
        <CGME20181029111305epcas5p2ee0ca644470de4e036762e000afbb71b@epcas5p2.samsung.com>
        <20181026144344.27778-18-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 16:43, Jagan Teki wrote:
> Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB
> bridge panel, which is available on same PCB with 24-bit RGB interface.
>
> So, this patch adds DSI specific binding details on existing
> dt-bindings file.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Use existing binding doc and update dsi details
> Changes for v2:
> - none
>
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> index 35bc0c839f49..b7855dc7c66f 100644
> --- a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> +++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> @@ -1,12 +1,39 @@
>  Banana Pi 7" (S070WV20-CT16) TFT LCD Panel
>  
> +S070WV20-CT16 is 7" 800x480 panel connected through a 24-bit RGB interface.
> +
> +Depending on the variant, the PCB attached to the panel module either
> +supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> +an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> +itself

As I understand this is display board, which contains 'pure' RGB panel
S070WV20-CT16 and optionally ICN6211 DSI->RGB bridge.
These are separate devices, just connected by vendor to simplify its
assembly. Why don't you create then bridge driver for ICN6211 and RGB
panel driver for S070WV20-CT16 - it looks more generic.
Then you can describe both in dts and voila.
Creating drivers for every combo of devices (panel + bridge), just
because some vendor sells them together seems incorrect - we have
devicetree for it.

Regards
Andrzej


> +
>  Required properties:
> -- compatible: should be "bananapi,s070wv20-ct16"
> +- compatible:
> +  for 24-bit RGB interface, use "bananapi,s070wv20-ct16"
> +  for ICN6211 MIPI-DSI to RGB bridge, use "bananapi,s070wv20-ct16-icn6211"
> +
> +Required properties for RGB:
>  - power-supply: see ./panel-common.txt
>  
> +Required properties for MIPI-DSI to RGB:
> +- reg: for DSI virtual channel used by that screen
> +- avdd-supply: analog regulator dc1 switch
> +- dvdd-supply: 3v3 digital regulator
> +- reset-gpios: a GPIO phandle for the reset pin
> +
>  Optional properties:
> -- enable-gpios: see ./simple-panel.txt
> +- enable-gpios: see ./simple-panel.txt(not available in MIPI-DSI to RGB bridge)
>  - backlight: see ./simple-panel.txt
>  
>  This binding is compatible with the simple-panel binding, which is specified
>  in ./simple-panel.txt.
> +
> +Example:
> +panel@0 {
> +	compatible = "bananapi,s070wv20-ct16-icn6211";
> +	reg = <0>;
> +	avdd-supply = <&reg_dc1sw>;
> +	dvdd-supply = <&reg_dldo1>;
> +	reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
> +	backlight = <&backlight_dsi>;
> +};



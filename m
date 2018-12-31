Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3BFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB7021738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546256686;
	bh=KtbHy2NcN9vE1DB4rHXVdpM8ttC1Xu7qdVEPrBBIaD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AmUSrnyMKHsdX8TTN9Nk6CkWYRbyHyYAdaJfzlJ8iBQO4+GtDwsZaDtjNrb4KfXma
	 1RHVSm+OZQ6UospGtMyKqDewE8wCWmr7tPPW4+5smDvhCf0iT92ImiUjpnzdMr9MKe
	 CcGc88vWjvwg4pSlAkTlO51CtUf0Ou2/ym3Vhvpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLaLop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 06:44:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLaLop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 06:44:45 -0500
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6661521738;
        Mon, 31 Dec 2018 11:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546256683;
        bh=KtbHy2NcN9vE1DB4rHXVdpM8ttC1Xu7qdVEPrBBIaD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EFfVKaHctd6UiV7OvDnomHb9KGhS/a5uYdWyE1pw28t8KJrpn+wDTIIIau+Dftxfk
         b3biAnZlu/jSTlnJcboOKSx2fHRmhN+tiE+YrTA4Q5QQ5IQGXFnvy8OXdUJ0239Z25
         BFtnnEVnrTmdFNlAb01hGHlNhufePxkPZ62MCzjE=
Received: by mail-lj1-f175.google.com with SMTP id c19-v6so23463331lja.5;
        Mon, 31 Dec 2018 03:44:43 -0800 (PST)
X-Gm-Message-State: AJcUukfbhtbS5mAJ8WB7v+/FdMlgjPxRrfKZHDc4rjK9qLgjVBMLZdat
        4BYZK5rm3VN8TOo8kxVhoxYRTxVEI2BxT6OmfmI=
X-Google-Smtp-Source: ALg8bN5VSAr3Zw9Le0NspEtRgdIgX7F19JSX6+66G2elsSz+QAN3uLMz0tu3PJ4OEMai3X7KQlovHMSHUItjWXWodrc=
X-Received: by 2002:a2e:6503:: with SMTP id z3-v6mr20430411ljb.153.1546256681550;
 Mon, 31 Dec 2018 03:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com> <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-5-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Dec 2018 12:44:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdWt1A=RPzzbv+DBJj6z1gUPF3OofGthYeyOCYcCiYwAQ@mail.gmail.com>
Message-ID: <CAJKOXPdWt1A=RPzzbv+DBJj6z1gUPF3OofGthYeyOCYcCiYwAQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] ARM: dts: s5pv210: aries: Add reserved memory for mfc
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 at 17:18, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> This commit adds memory reservation required by MFC to run.
> On S5PV210 both regions needs to be on separate memory banks.
> Size of both regions is taken from stock sources.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5p=
v210-aries.dtsi
> index 575094ea7024..35ba009a1a33 100644
> --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -23,6 +23,24 @@
>                         0x50000000 0x08000000>;
>         };
>
> +       reserved-memory {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +
> +               mfc_left: region_mfc_left@43000000 {

Although you used the same naming convention as existing
exynos-mfc-reserved-memory.dtsi, the name of nodes should be generic,
so:
mfc_left: region@43000000

Best regards,
Krzysztof


> +                       compatible =3D "shared-dma-pool";
> +                       no-map;
> +                       reg =3D <0x43000000 0x2000000>;
> +               };
> +
> +               mfc_right: region_mfc_right@51000000 {
> +                       compatible =3D "shared-dma-pool";
> +                       no-map;
> +                       reg =3D <0x51000000 0x2000000>;
> +               };
> +       };
> +
>         wifi_pwrseq: wifi-pwrseq {
>                 compatible =3D "mmc-pwrseq-simple";
>                 reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
> @@ -329,6 +347,10 @@
>         status =3D "okay";
>  };
>
> +&mfc {
> +       memory-region =3D <&mfc_left>, <&mfc_right>;
> +};
> +
>  &pinctrl0 {
>         wlan_bt_en: wlan-bt-en {
>                 samsung,pins =3D "gpb-5";
> --
> 2.17.1
>

Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BA8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55A021783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 11:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546256274;
	bh=b7yKPqndEmKWUgmsRkmbbqWx5vMBaYn8Bsc4wUnPXVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ovth8/fRVhI5olKGgVOzuUFSnQCXZez+X+q/1/LDTij1XNS00Ve9FJ8rlAlSDbDQ0
	 muiFmAbZ8RRU/IjmxbllfiooGqFlf+Bd4WyloN3iSjPPp1bZPfTdAoWXLg4QEbuYkj
	 28IfuRvXLQ37zMR6rUi0AlOmq6HBYCspwHRvRlVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeLaLhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 06:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeLaLhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 06:37:42 -0500
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF0D218A1;
        Mon, 31 Dec 2018 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546256261;
        bh=b7yKPqndEmKWUgmsRkmbbqWx5vMBaYn8Bsc4wUnPXVo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XQC9Z2zQgmZ0omf/lIam185INV2bPQZ7qrjpelkV2UcjVQwh6NQWdFxNJ1z1AwR3G
         mCIxnTYzPvNpH7JX5XXt44AbVFkzr6gmMlOHpjIiHljovvSERY0pSaJquN5iK3FAMX
         hzLAJnFmHY8zMlBD8oCN05k2bKCcJVxoUI96WMaI=
Received: by mail-lj1-f180.google.com with SMTP id x85-v6so23470038ljb.2;
        Mon, 31 Dec 2018 03:37:41 -0800 (PST)
X-Gm-Message-State: AJcUukcwxpIp4YCWjvd7GPzOAl4RtU7NTJgxhwuJ5/L4KJskztNKEoes
        er+QqU+jI8KzoGsjxVfB5U7ApPf9Ld8xTQd4dx8=
X-Google-Smtp-Source: ALg8bN5+XVupxHZv0BKqm8A3CnCshN6LRhIwrndlRk4MwMDraAc//ZP3AttZr0BGPI5Yc8ANrGa4zQPK6buk3gaq/Js=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr10434615ljg.138.1546256259610;
 Mon, 31 Dec 2018 03:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com> <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
In-Reply-To: <20181228161819.18931-2-pawel.mikolaj.chmiel@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 31 Dec 2018 12:37:28 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf+Ut1ghXJnEqrUiz=r_ts-Bz3cum1LvUMOjEqWp8q+Vw@mail.gmail.com>
Message-ID: <CAJKOXPf+Ut1ghXJnEqrUiz=r_ts-Bz3cum1LvUMOjEqWp8q+Vw@mail.gmail.com>
Subject: Re: [PATCH 1/6] ARM: dts: s5pv210: Use correct fimd variant
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
> Since we have separate compatible for our SOC,
> let's use it rather using one from exynos4210.

Please fix
your editor
to wrap lines
matching Linux
style because
it is difficult
to read.

You have unusual configuration because most of the editors wrap git
commit as expected.
https://elixir.bootlin.com/linux/latest/source/Documentation/process/submit=
ting-patches.rst#L633

Best regards,
Krzysztof

>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.d=
tsi
> index 75f454a210d6..3d6e5ad1ea35 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -511,7 +511,7 @@
>                 };
>
>                 fimd: fimd@f8000000 {
> -                       compatible =3D "samsung,exynos4210-fimd";
> +                       compatible =3D "samsung,s5pv210-fimd";
>                         interrupt-parent =3D <&vic2>;
>                         reg =3D <0xf8000000 0x20000>;
>                         interrupt-names =3D "fifo", "vsync", "lcd_sys";
> --
> 2.17.1
>

Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD04C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBA2080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcAonZ62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeLOR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 12:28:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLOR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 12:28:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so4130048pgc.12;
        Sat, 15 Dec 2018 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qYghXkgYKE5YJ4zyFutekobEJ9d+5L86URck2P74ZQQ=;
        b=EcAonZ62Tg54VJm73MHpichzLK6KZYW6692R9LuggWnRz9JVwzMkMP0/1kDGBptjzO
         2ug18R245omjFMSkLfnavMCuCP7df7Z+JClMqy4jhpR30s515uAApsyDUGoH1F4IEUek
         LvwNwBwJ0tfEIMbotMpN41X8ii8GepWopdfoWTVxnv/Xw9EfOYsAXsaTPHSseBYPXX8D
         N//qmMchzZpK2F7fbSj0MoC3+Pcv86mHP47r5cc/iFA6zrr6KSZE3sxvwZLkkLYLs7um
         D8Hqef9bpd3XBzkK6jZ5IJTchf7GTSV8HbZItOsuULAkwN+OsZDgdVLmH/NgAwU76+xX
         hB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qYghXkgYKE5YJ4zyFutekobEJ9d+5L86URck2P74ZQQ=;
        b=G+g9GTaOCPTtS2TnNyJVdSWEUT4Fzv6gwy9fvNqaAUUxvTsv4lvqQ5wLED8FVdMAJq
         DK6a3h78RUyzToAd8hfEOfhFXGB+2nMDnRtrocKv4wXAsV3GglUIS/fDTE1Sd/3jcXwV
         /5Xi4ZrYx+URYAeX4BKW6Sd0ojczmESW9bq3LACv14PFSLRVs9EM184Z+fLQB29q9yX6
         mFN3Niwqudd+HQG/6hU3NxS1+XM256YuykCLc26RfT454hgfS9Iinxe1NtfoVjaqDh4V
         bsUalAEKG0vLyp59TpPhwPHMtnuFjJ3/vk7dvhW4R37jiZnReszGqiO4iWukj7C3lrhn
         arpw==
X-Gm-Message-State: AA+aEWbgsX5yqXshhv/YTXuYnOvMEkFZZLrviXsZxYuqHqUOj8bpigx9
        UroJKL2xnTGanD3ncDSHuC8=
X-Google-Smtp-Source: AFSGD/UZFLP8f1j+MPaYxZ5BqMgCbE2p+WHyQpZBE1MaVfsf9YAsdOkZ1qQocWCLbgDso2Wvv4TI/A==
X-Received: by 2002:a62:d005:: with SMTP id p5mr7087516pfg.175.1544894896968;
        Sat, 15 Dec 2018 09:28:16 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id a4sm8902627pgv.70.2018.12.15.09.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 09:28:16 -0800 (PST)
Date:   Sat, 15 Dec 2018 09:28:14 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: tegra: Add thermal zones on Tegra194
Message-ID: <20181215172812.GA10700@localhost.localdomain>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
 <20181123121839.18573-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181123121839.18573-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 01:18:38PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The NVIDIA Tegra194 SoC defines six thermal zones. Define all of them in
> device tree.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

The patch 1 I added in my -linus branch.

> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 39 ++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index cbba7395a286..39169f6b6166 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>  #include <dt-bindings/reset/tegra194-reset.h>
>  #include <dt-bindings/power/tegra194-powergate.h>
> +#include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
> =20
>  / {
>  	compatible =3D "nvidia,tegra194";
> @@ -938,6 +939,44 @@
>  		mbox-names =3D "rx", "tx";
>  	};
> =20
> +	thermal-zones {
> +		cpu {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_CPU>;
> +			status =3D "disabled";
> +		};
> +
> +		gpu {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_GPU>;
> +			status =3D "disabled";
> +		};
> +
> +		aux {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_AUX>;
> +			status =3D "disabled";
> +		};
> +
> +		pllx {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_PLLX>;
> +			status =3D "disabled";
> +		};
> +
> +		ao {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_AO>;
> +			status =3D "disabled";
> +		};
> +
> +		tj {
> +			thermal-sensors =3D <&{/bpmp/thermal}
> +					   TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX>;
> +			status =3D "disabled";
> +		};
> +	};
> +
>  	timer {
>  		compatible =3D "arm,armv8-timer";
>  		interrupts =3D <GIC_PPI 13

Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D403FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25ED218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549480718;
	bh=5ue2r0PP91E/tWGZA+YxrtG/lBYKmGBGoE6ioBqCvns=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=IHO2y2NvLE24OLG8UMXWypptY7OIVsugkTLUyjbKNuDanuADFb2FVvqlNRqz05C3s
	 KkXDf1iPRoJOSRTt1DNh4gzjg1lErYld/cBTem1E3bbIElgZNAjBv8Romr1EfDIH/l
	 Pp3ntbsayzNdbwHruL8Ak8lpqF9wq7nNbfdk8ZtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBFTSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfBFTSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:18:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B94B20B1F;
        Wed,  6 Feb 2019 19:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549480715;
        bh=5ue2r0PP91E/tWGZA+YxrtG/lBYKmGBGoE6ioBqCvns=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=hk86GIdMazxFH0UEeyn3pBETKKaaQd7kvGEcXHYVXUzvE9+FtCYSlQtGrFiNpY4vT
         KTL4qZ4a/H55Dw/BI+vwgw6Oxt9M5OLq2ZZCJ9rp40kgFoFPIBWYviqloLa0CO4DOy
         23DBykRyLEsLhhk4oHS87MwVWmtjPzMTkjH6c11g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
In-Reply-To: <20190201063540.19636-2-jiaxun.yang@flygoat.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v3 1/3] clk: loongson1: add configuration option for loongson1 clks
Message-ID: <154948071478.115909.15205970894327083365@swboyd.mtv.corp.google.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com> <20190201063540.19636-1-jiaxun.yang@flygoat.com> <20190201063540.19636-2-jiaxun.yang@flygoat.com>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:18:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiaxun Yang (2019-01-31 22:35:38)
> diff --git a/drivers/clk/loongson1/Kconfig b/drivers/clk/loongson1/Kconfig
> new file mode 100644
> index 000000000000..e2220332d797
> --- /dev/null
> +++ b/drivers/clk/loongson1/Kconfig
> @@ -0,0 +1,27 @@
> +menu "Loongson-1 Clock drivers"
> +       depends on MACH_LOONGSON32
> +
> +config LOONGSON1_CLOCK_COMMON
> +       bool
> +
> +config LOONGSON1_CLOCK_LS1B
> +       bool "Loongson 1B driver"
> +       default y

Should be default CONFIG_LOONGSON1_LS1B?
> +       select LOONGSON1_CLOCK_COMMON

Drop the selects and have the menuconfig make the "COMMON" config option
enabled then?

> +       help
> +         Support the clocks provided by the clock hardware on Loongson-1B
> +         and compatible SoCs.
> +
> +         If building for a Loongson-1B SoC, you want to say Y here.
> +
> +config LOONGSON1_CLOCK_LS1C
> +       bool "Loongson 1C driver"
> +       default y

And default CONFIG_LOONGSON1_LS1C?

> +       select LOONGSON1_CLOCK_COMMON
> +       help
> +         Support the clocks provided by the clock hardware on Loongson-1C
> +         and compatible SoCs.
> +
> +         If building for a Loongson-1C SoC, you want to say Y here.
> +
> +endmenu

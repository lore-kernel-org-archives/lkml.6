Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C05C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A108120871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="enOsQ7i2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A108120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeGJIbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:31:43 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42184 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeGJIbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:31:41 -0400
Received: by mail-io0-f195.google.com with SMTP id r24-v6so19572936ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oyiwvm7THiupXaKy9J1yZU76ybaXRbibAyw/egA7zI0=;
        b=enOsQ7i218zX+cBpOE8bW4Mgo261UTfzeWZRiEYYRDbYKAnGI70zp1HeiLl58Pb8k9
         OtBPDplSrCBANzrrpKBnxyNylROtijkKDNHGXArcf0PAySprzdM5hRjNNSj3+GlBJylg
         gDw0oW6RDuUR/7ay6FlPFqx6ewsR6PsFu3dWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oyiwvm7THiupXaKy9J1yZU76ybaXRbibAyw/egA7zI0=;
        b=tI3oL8A4Oocy+Uh3OgQsyaY9o6XuiQTesXr0dqqCd+86eAbDaWYMWrUAY+5KS6uNy5
         l6kNyP442psg2V3lB3y9WsBa9v0QWf6rubP5OR8NpTLbCxKYCrJfo6VWfR6eHhzYE7cb
         KYoKt2lYgQrmz0vDrlR1GwIeDA/qV+an3ayWa11LWtk7QSp8c+vxghtRwrdKuUNbOXdq
         +pzGSFHYls64X7fxUTXNX0LP11unqIa1DuqSHsvZsgpjrjZa4CKU7vxrZsANONc81aC2
         W+BjqfGBKIlQFV72CuUOFVm1WMqXfFyXpP/Vih1EzLh9+riHauS/0a9mvfKGTXM8KALa
         9JEQ==
X-Gm-Message-State: AOUpUlHvABvNcSshNoLhXj4G7ROzMZsjQKb5mzuzapvq1YDDIFqqU6Fc
        oUOSOCYE3qJfiwFQnYqdeohH4ArXjFwWa81ybGL0kw==
X-Google-Smtp-Source: AAOMgpdjVrgaWLbcaayDMYIPNFOkZPpDhmZjzAW6sQurcctcABKh5BgQhWYP5hKVNiCUY/KRN9suhhkEtez30v1km/A=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr20542443iof.266.1531211500415;
 Tue, 10 Jul 2018 01:31:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 01:31:39
 -0700 (PDT)
In-Reply-To: <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com> <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 10:31:39 +0200
Message-ID: <CAPDyKFoGJOE-h4rLqzMO=wzNjkfcuU_oQ3NLK5=OQfSMj3dDHg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay
 values from DT
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Moritz Fischer <mdf@kernel.org>, stefan.krsmanovic@aggios.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 June 2018 at 14:11, Manish Narani <manish.narani@xilinx.com> wrote:
> This patch adds support for reading Tap Delay values from Device Tree
> and write them via eemi calls. The macros containing these tap delay
> values are removed from the driver.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 131 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e3332a5..fc0fd01 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -36,6 +36,8 @@
>
>  #define PHY_CLK_TOO_SLOW_HZ            400000
>
> +#define MMC_BANK2              0x2
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -90,6 +92,10 @@ struct sdhci_arasan_data {
>         struct sdhci_host *host;
>         struct clk      *clk_ahb;
>         struct phy      *phy;
> +       u32 mio_bank;
> +       u32 device_id;
> +       u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
> +       u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
>         bool            is_phy_on;
>
>         bool            has_cqe;
> @@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
>         return ret;
>  }
>
> +/**
> + * arasan_zynqmp_set_tap_delay - Program the tap delays.
> + * @deviceid:          Unique Id of device
> + * @itap_delay:                Input Tap Delay
> + * @oitap_delay:       Output Tap Delay
> + */
> +static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 otap_delay)
> +{
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();

No thanks!

Isn't there a more generic framework we can use to change the tap
values, rather than calling SoC specific functions from the driver?

BTW, what is a tap value, more exactly?

What does changing a tap value mean and where does the property belong, really?

Of course this doesn't even compile, as you have a dependency to
another series. Next time, please clarify that in a cover-letter
(maybe you did, but I can't find it).

> +       u32 node_id = (deviceid == 0) ? NODE_SD_0 : NODE_SD_1;
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return;
> +
> +       if (itap_delay)
> +               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +                               PM_TAPDELAY_INPUT, itap_delay, NULL);
> +
> +       if (otap_delay)
> +               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
> +                               PM_TAPDELAY_OUTPUT, otap_delay, NULL);
> +}

Another overall comment for the series.

I would recommend to change the order of the patches in the series.
Let the DT doc change come first, next the driver change and finally
the change to the DTS file(s). This makes it easier to follow and
review.

[...]

Kind regards
Uffe

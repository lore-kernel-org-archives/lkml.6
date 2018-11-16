Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CBC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6442086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="moXuqMY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6442086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbeKQDME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:12:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKQDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:12:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so25584464wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tgb9X3UvWTf6+JIdC4xWWabdMeSOeRsAQ7Bo1ZGD4ak=;
        b=moXuqMY1prKWzsRt/AIGRICmWL1JsRg6Od2c8yDC04CT6VGwu68Puh1ULcG7Szmr9w
         RCuj4axhe8y1szffnW+3P1U4mv2JunbbLaQdoPm1um4rFknBghLR/11tcwqevlbFxu3e
         pEbleG7zlRXgD4u1QJW5tASjMZU3znFTTEtw8+FHSvmL0UTCB5vpqqUn38NC2LEG4IbS
         NfyR3jrUgJgoDaM/Rybsw+lOO2CyKjW6cZGqT1LKNi58jb611rnwutejX1eeCzM18OU4
         ypCO3EdHNylTjMy4Ap/mLyFUYXdAkSx3mDajQ+SWeh7gicoxQdhZfeltN3h2L15k5+Yi
         NUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tgb9X3UvWTf6+JIdC4xWWabdMeSOeRsAQ7Bo1ZGD4ak=;
        b=LZOFk0SPuwLFXZW63U3Yq5lZuzOuOkdNc+ndNuYkaFod1/QbhcRfC6tL0M0QVruB8E
         wHtx9KPdRb6f5b7dWOfCncq0TmuoqZZRZ1v/ThotRmO9bb17UuHjW9Hieq487PXVAoQl
         ZszgbcWpEtOBH8w83Vfa5KM7ArW6oCjqjCHrHreKVenA36/cEqsUXC+0tzI7LWtBZH61
         CeQRd1DmPoefyp/Kz+tds3FI1755XoKiDZNo8fXGmS/9zxkOyPTZZNB90uPFM37W1UKI
         c2DzfIvU9BDbkFI1GJVDmxntT9RxibNvNE6rYXo3vNYSaZTQhJ3NjfdBFkqECRIpiweL
         NdNw==
X-Gm-Message-State: AA+aEWbXUy4rpPpPR6xPPMTMguVDlgwn/MQdjtaxrPmNA6DvpU9QawrW
        rQ8Pen0AuUd2mbVnn/YOi2Shpg==
X-Google-Smtp-Source: AFSGD/V8oDGHEgpmz/LTRYzOy6LWAB/Nf/viIg1Lw56HB+n+BH5V1uZv3axmaf/jNbt2pO2CJm/xrw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr3489272wrr.97.1542387533205;
        Fri, 16 Nov 2018 08:58:53 -0800 (PST)
Received: from jaya ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id e66-v6sm45900893wmf.40.2018.11.16.08.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 08:58:52 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:58:50 +0100
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch
 method when useful
Message-ID: <20181116165850.GB5894@jaya>
References: <20181022134026.GB18413@jaya>
 <20181023100729.28864-4-anisse@astier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023100729.28864-4-anisse@astier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Oct 23, 2018 at 12:07:29PM +0200, Anisse Astier wrote:
> If there's no ACPI DSM for voltage switch, it will just cause a lot of
> debug info down the line, we only need one at startup.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index f2c1fb339d66..95fdbb883c7e 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
>  static void byt_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
> +	struct intel_host *intel_host = sdhci_pci_priv(slot);
>  
>  	byt_read_dsm(slot);
>  
> @@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>  				mmc_hostname(slot->host->mmc));
>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  	}
> +	/* Check if we have the appropriate voltage switch DSM methods */
> +	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
> +	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
> +		/* No voltage switching supported at all, there's no
> +		 * point in installing the callback: return.
> +		 */
> +		pr_debug("%s: No voltage switching ACPI DSM helper\n",
> +				mmc_hostname(slot->host->mmc));
> +		return;
> +	}
>  	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>  }
>  
> -- 
> 2.17.2
> 

What do you think of picking this last patch ? Or maybe you had
different cleanups in mind when you said you wanted to rework this ?

Regards,

Anisse

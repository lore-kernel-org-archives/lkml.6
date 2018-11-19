Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA47C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864CE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astier-eu.20150623.gappssmtp.com header.i=@astier-eu.20150623.gappssmtp.com header.b="pT7Lq2bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864CE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeKST43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:56:29 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55083 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKST43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:56:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so4552814wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=astier-eu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+YkQIieV9jhQ8eitBPzVM0jS7ANYINOLJ2PFNbaG+E=;
        b=pT7Lq2bWS9j+pIBcmQk1lbDlp3e9+vjTaf+7L5O6nrtfH8v3ctE9guBJ5CZ40dEBDV
         EFJdcSq450So9gUxwg/LrAMfjdWptpyYVTISURJtV0qacZppL4Te16x2Mm+/cw4O2wel
         bb6iuUw9Q5TNeYN3NY6ep7gJ+e25SUTM8ZxjUGAuYWkhwuDHf1R5GVseKp4cdpO7VcBu
         ocnSxzlsPk7fbX83KPqvzeitWVsUjUW1S+XW0Vy9Aj4Z/gNIcV8z4poJfE/NzwNqZnf+
         EGW7dN4nZlG7Kz3JwyoNzob8A6bkBtlpRIWamBr1CHQVpsGm9A7ompdXtl+LCHt7hAEx
         iQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+YkQIieV9jhQ8eitBPzVM0jS7ANYINOLJ2PFNbaG+E=;
        b=KW50PS46btwtCkVt7goppE5QSmgSGssMtqU0mWYBQDhxwEzEiKn1JDt+a9CWHoDGRz
         QM4aRsyd2xYD0tRcKQ61wQjiMYzELu3Z6C0/HAM6jZVfgVu+fKUtJYyIN1oLvcF/IdI/
         YvOF4U+IrR0wRyIjj5huwdLDcBO5JOVRDTksl2wl+iYzlGXAfecrir7RczT3egysDNyi
         PdXsQ4XZBbVeK1K9k53B6ntfrvH2e81lBuhLpf3ktNxzIui5+SDDdCCnCZCq2aZoaWH4
         1pNcOtUyyxs52cGXNof4YGvxsxH5tayXkKC04O66sO2C3JKSvLBHtNPC3KPNKdGtMDKc
         jCEA==
X-Gm-Message-State: AGRZ1gJ9RyBYaSlckDbZpSCcCdM5RIlfobPp3h+W73qhJoB8dZ76SdzW
        3glb1G8e02ZZ9ofx4yyBadhyLTPnw+0=
X-Google-Smtp-Source: AJdET5dHsfATVKJfyB4HKeorjlhmYum6IKnLxphF1P8mopZXrRBueQR668czZClEYSP3O7HYHYDpkg==
X-Received: by 2002:a1c:bb85:: with SMTP id l127mr6220295wmf.98.1542620002406;
        Mon, 19 Nov 2018 01:33:22 -0800 (PST)
Received: from jaya ([92.103.140.194])
        by smtp.gmail.com with ESMTPSA id l37sm6121562wre.69.2018.11.19.01.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 01:33:21 -0800 (PST)
Date:   Mon, 19 Nov 2018 10:33:19 +0100
From:   Anisse Astier <anisse@astier.eu>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch
 method when useful
Message-ID: <20181119093319.GA3356@jaya>
References: <20181022134026.GB18413@jaya>
 <20181023100729.28864-4-anisse@astier.eu>
 <20181116165850.GB5894@jaya>
 <94fa0484-c532-683f-3a3f-fd9f4b263d16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94fa0484-c532-683f-3a3f-fd9f4b263d16@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:45:03AM +0200, Adrian Hunter wrote:
> On 16/11/18 6:58 PM, Anisse Astier wrote:
> > Hi Adrian,
> > 
> > On Tue, Oct 23, 2018 at 12:07:29PM +0200, Anisse Astier wrote:
> >> If there's no ACPI DSM for voltage switch, it will just cause a lot of
> >> debug info down the line, we only need one at startup.
> >>
> >> Signed-off-by: Anisse Astier <anisse@astier.eu>
> >> ---
> >>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> >> index f2c1fb339d66..95fdbb883c7e 100644
> >> --- a/drivers/mmc/host/sdhci-pci-core.c
> >> +++ b/drivers/mmc/host/sdhci-pci-core.c
> >> @@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
> >>  static void byt_probe_slot(struct sdhci_pci_slot *slot)
> >>  {
> >>  	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
> >> +	struct intel_host *intel_host = sdhci_pci_priv(slot);
> >>  
> >>  	byt_read_dsm(slot);
> >>  
> >> @@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
> >>  				mmc_hostname(slot->host->mmc));
> >>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> >>  	}
> >> +	/* Check if we have the appropriate voltage switch DSM methods */
> >> +	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
> >> +	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
> >> +		/* No voltage switching supported at all, there's no
> >> +		 * point in installing the callback: return.
> >> +		 */
> >> +		pr_debug("%s: No voltage switching ACPI DSM helper\n",
> >> +				mmc_hostname(slot->host->mmc));
> >> +		return;
> >> +	}
> >>  	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
> >>  }
> >>  
> >> -- 
> >> 2.17.2
> >>
> > 
> > What do you think of picking this last patch ? Or maybe you had
> > different cleanups in mind when you said you wanted to rework this ?
> 
> Voltage switches are relatively rare, and dynamic debug allows control over
> exactly which debug messages display, so I am not sure this patch is needed.

I just thought this message was a bit clearer than:
mmc0: intel_start_signal_voltage_switch DSM fn 4 error -95 result 0

But you're correct, with dynamic debug it shouldn't be an issue, and the
original message is easily searchable in the code. It only happens every
two seconds.

I'm ok to drop this patch.

Regards,

Anisse

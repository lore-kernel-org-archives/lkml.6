Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9317208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9317208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeGMJ1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:27:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41621 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeGMJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:27:40 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so7854904edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ITT0JYaaMvKaRVyyTIPUPNphIYsZzp2kVtWlPkBwb4=;
        b=IE+41G1+Y1JcFq6YExkCI4okrtSZH0c16QRHeOchLLcTBIebVdF/4+HWlE3pFMdVYb
         rVga36J23Iw/27nFUjYH20M3e/TtBXz7PjUMcvVzeZaNS5/FEfvVieTAXbxaPor3Omok
         vyK4O2WQOrItaZpMfOv0Ufg6c/h85RsDRdtPQzZUUww5b7oKfKJUUqed05UhSL+OhJku
         hEkngjQF03b5aYAOvAKbvoGg2KIfeIqEDGOJXhoEfgXMQj4Bt7uHdpdYQHnQ0OEKAggR
         nsg2g+ftCWmLx+jqt8HbdOmGvyWor6PeRJksKADiPbJZMwU2+cjAbkIuQ81spl+vKJWG
         Djrw==
X-Gm-Message-State: AOUpUlE3a+0mZZYunJwdXfOEx43DnmKS9hWfKLFYGCo/WeHA9fFXZhla
        piImfcAImCXUpAxhx+1KWRehtA==
X-Google-Smtp-Source: AAOMgpe8BhVYphhe9D6jYBr44+pcyJPvegILChaXH/jP4o5kY957Tc32RsXUECelOyJ+q/twEhCmVw==
X-Received: by 2002:a50:b1f3:: with SMTP id n48-v6mr6038099edd.197.1531473233660;
        Fri, 13 Jul 2018 02:13:53 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b7-v6sm9686602edj.87.2018.07.13.02.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:13:53 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/2] ata: ahci: Enable DEVSLP by default on x86
 with SLP_S0
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tj@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
 <20180712222712.65310-3-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f9277260-29d0-f655-f2a1-b9db1187236a@redhat.com>
Date:   Fri, 13 Jul 2018 11:13:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712222712.65310-3-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13-07-18 00:27, Srinivas Pandruvada wrote:
> From: Srinivas <srinivas.pandruvada@linux.intel.com>
> 
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> 
> Several of these system don't have traditional ACPI S3, so it is
> important that they enter SLP_S0 state, to avoid draining battery even
> during suspend. So it is important that out of the box Linux installation
> reach this state.
> 
> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
> user has to either use scsi-host sysfs or tools like powertop to set
> the sata-host link_power_management_policy to min_power.
> 
> This change sets by default link power management policy to min_power
> with partial (preferred) or slumber support on idle for some platforms.
> To avoid regressions, the following conditions are used:
> - The kernel config is already set to use med_power_with_dipm or deeper
> - System is a SLP_S0 capable using ACPI low power idle flag
> This combination will make sure that systems are fairly recent and
> since getting shipped with SLP_S0 support, the DEVSLP function
> is already validated.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/ata/ahci.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b2b9eba1d214..e8d425823f9b 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1604,6 +1604,19 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>   	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
>   }
>   
> +static void ahci_update_mobile_policy(struct ahci_host_priv *hpriv)
> +{
> +#ifdef CONFIG_ACPI
> +	if (mobile_lpm_policy > ATA_LPM_MED_POWER &&
> +	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +		if (hpriv->cap & HOST_CAP_PART)
> +			mobile_lpm_policy = ATA_LPM_MIN_POWER_WITH_ASP;
> +		else if (hpriv->cap & HOST_CAP_SSC)
> +			mobile_lpm_policy = ATA_LPM_MIN_POWER;

You are checking hpriv flags here and changing global state based on that.

Instead it would be better to add a new:

int ahci_get_initial_lpm_policy(struct ahci_host_priv *hpriv);

Function and replace this:

                 if ((hpriv->flags & AHCI_HFLAG_IS_MOBILE) &&
                     mobile_lpm_policy >= ATA_LPM_UNKNOWN &&
                     mobile_lpm_policy <= ATA_LPM_MIN_POWER)
                         ap->target_lpm_policy = mobile_lpm_policy;

With:

		ap->target_lpm_policy = ahci_get_initial_lpm_policy(priv);

And do the original checks + your new checks all in the
ahci_get_initial_lpm_policy() function.

Regards,

Hans



> +	}
> +#endif
> +}
> +
>   static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	unsigned int board_id = ent->driver_data;
> @@ -1796,6 +1809,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (pi.flags & ATA_FLAG_EM)
>   		ahci_reset_em(host);
>   
> +	ahci_update_mobile_policy(hpriv);
> +
>   	for (i = 0; i < host->n_ports; i++) {
>   		struct ata_port *ap = host->ports[i];
>   
> 

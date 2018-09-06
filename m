Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D99DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5613320659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5613320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeIGAn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:43:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbeIGAn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:43:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so12665870wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 13:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CphhSCVD/lJVIdanHypKuk57KRiiwbM//ZdQo9THFc=;
        b=ArxL4MzDicDeUBqhIvfwu2MTMdbvlARoTa9yZ2Pe/vI2tFgg1jBvgbONOmW115jLdU
         kOSDuIVoVvigVk3H3ILbPJ/Z2kjiY/AIIQ0x4Uo8/ffYfjcVPgNh7fcZIyMgcOpKxG94
         ZP15Ay480K0aTOr+Z1xwBozEqLPxg1UTjRa+/zTMjOAk5TDonkHfuh4pnDd0fqqU1p0O
         4TIlom5IGbOBvZXQ6IcYszfMIillCfOAGci1KRYetfiCjr+fYG4ffl8otovI5CDukgzd
         bBwLoCR0NyMKAtr3+LtXttlFfxBbaFYeSl9pQA/Ta8Q/NP/Pu5ewpfIAV8E4c4Ip8UoS
         Eywg==
X-Gm-Message-State: APzg51DJ0sLVIeP4v+Oj5aHPN01kqGPtMbm1pxJIdaRH9zzJ7Rw6EiO7
        XE3vTUxMvOKlI/WfJF0nng8+7Q==
X-Google-Smtp-Source: ANB0VdaxLNaLyCE+bLfgLHbvIdfVtKlOCG8hYEXD6jnKjt280MPIFyrZNAeiz2KDLd8SIVKoPCKL6Q==
X-Received: by 2002:adf:92c2:: with SMTP id 60-v6mr3678860wrn.153.1536264383704;
        Thu, 06 Sep 2018 13:06:23 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v192-v6sm5200470wmf.40.2018.09.06.13.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 13:06:23 -0700 (PDT)
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
Date:   Thu, 6 Sep 2018 22:06:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-09-18 20:05, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support
> AHCI ALPM feature. This patch disables the AHCI ALPM feature for
> eMAG SATA.
> 
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>

Sorry, but the patch is still coming through mangled. Did you use
git send-email ?

Regards,

Hans




> 
> ---
> Changes for v3:
> 
> * Fix the indentation and whitespace warnings.
> 
> Changes for v2:
> 
> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
> * Include this object for eMAG SATA inside the acpi match table.
> * Retrieve the ata_port_info from the acpi match table.
> 
> ---
>   drivers/ata/ahci_platform.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 99f9a89..9ba283f 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -33,6 +33,13 @@ static const struct ata_port_info ahci_port_info = {
>   	.port_ops	= &ahci_platform_ops,
>   };
> 
> +static const struct ata_port_info ahci_port_info_nolpm = {
> +	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
> +	.pio_mask	= ATA_PIO4,
> +	.udma_mask	= ATA_UDMA6,
> +	.port_ops	= &ahci_platform_ops,
> +};
> +
>   static struct scsi_host_template ahci_platform_sht = {
>   	AHCI_SHT(DRV_NAME),
>   };
> @@ -41,6 +48,7 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
> +	const struct ata_port_info *port;
>   	int rc;
> 
>   	hpriv = ahci_platform_get_resources(pdev);
> @@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> 
> -	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
> +	port = acpi_device_get_match_data(dev);
> +	if (!port)
> +		port = &ahci_port_info;
> +
> +	rc = ahci_platform_init_host(pdev, hpriv, port,
>   				     &ahci_platform_sht);
>   	if (rc)
>   		goto disable_resources;
> @@ -85,6 +97,7 @@ static const struct of_device_id ahci_of_match[] = {
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
> 
>   static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
>   	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>   	{},
>   };
> --
> 2.7.4
> 

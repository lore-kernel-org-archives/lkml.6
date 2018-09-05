Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C612073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C612073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeIFArt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:47:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44360 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIFArs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:47:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so8935956wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 13:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WaO5ifc5QHgBJCGbo28A4GiI6XTbM/o9npOjIdeS+84=;
        b=EXjkRAj/HrT8Z+ymDYAvFKGIZ0vxzoKZP8pB/+Ld2hEOpPCPPu2Piw5zYwkhi7wvQU
         robB3mJBfGfPOdW7mcx5ynY6RP20cXcwBLC4awR2gzm01ncXElMZDqidKEBzfa+pcIls
         fTHE8B89hu8jeJTSzee+28KYSag1rgKWdDgLC5BTumxYq5fZaVWo0MkaLOP5xNv4DSiP
         bd9CA+ykii5CMcUHIb7rvNzDOK7eU4TVbMKrGZrsa5Ty1ktPw7eSL8OO/dqkRhJMG6wO
         wOH0mww3URg6QF3yeKlzRog1x0/Lp7ljEFgllA/NH569Y1wle2CoImOZOKvmlkJmTwPq
         n+pQ==
X-Gm-Message-State: APzg51D/fy/bk+6YXjw9r2TD8t0shvyJhJogMWABuZ2Q57j9ghK+yWDu
        IqnPiSShk7zPJhyENIxCc4dlVA==
X-Google-Smtp-Source: ANB0Vdaet95cf7U+4p6yNt7G2ZcW6xC7xdw4wHq5lhT9Ly3d5YUz9ZOts0NgAY7zkilyG1GvDEQNzw==
X-Received: by 2002:adf:e30e:: with SMTP id b14-v6mr27442210wrj.158.1536178560718;
        Wed, 05 Sep 2018 13:16:00 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id o3-v6sm4158213wrn.58.2018.09.05.13.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:16:00 -0700 (PDT)
Subject: Re: [PATCH v2] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
References: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e865f801-dc68-7583-62a0-40579c324e84@redhat.com>
Date:   Wed, 5 Sep 2018 22:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1536178375-31700-1-git-send-email-stripathi@amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05-09-18 22:12, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support
> AHCI ALPM feature. This patch disables the AHCI ALPM feature for
> eMAG SATA.
> 
> Changes for v2:
> 
> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
> * Include this object for eMAG SATA inside the acpi match table.
> * Retrieve the ata_port_info from the acpi match table.
> 
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
> ---
>   drivers/ata/ahci_platform.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 99f9a89..c3043f6 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -33,6 +33,13 @@
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
> @@ -41,7 +48,8 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
> -	int rc;
> +	const struct ata_port_info *port;
> +        int rc;

You are accidentally changing the indentation of rc here.

Please fix this and run scripts/checkpatch.pl on the patch before
submitting v3. Otherwise v2 looks good.

Regards,

Hans






>   
>   	hpriv = ahci_platform_get_resources(pdev);
>   	if (IS_ERR(hpriv))
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
> @@ -85,6 +97,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>   
>   static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
>   	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>   	{},
>   };
> 

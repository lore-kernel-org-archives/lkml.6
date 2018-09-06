Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8FEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F128720659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F128720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeIFMFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:05:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37806 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:05:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20-v6so8081902edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 00:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jy2YTvO2KQeN90vU2kitlPfIcNygyIARPBo9zqoNF2E=;
        b=ZT8P+maKn4Y5zQiOeHiDSkb0dok+L1Fx/BUfrRG8YhWC/iR55WBQm45tteoPtVI4Jx
         xK++F/rJeC9UxqTW4gLlqasa1a66d++2nvX/dUOZcFfY/ZDocrpN8Q90Guy4bD6IDqCu
         YaxnO6Ni9/R1uMpxGCptLokl2lFr5FAtRrCEP9BGo7csFVyhfmvrwzR3aNNBf4GNOZ6j
         CklF8ZA5oN2rhwGzF5LbedgpsNRcTOCMfyq+Je7c61vEqLLgD7HvVBPGj1ABLUBu0uM1
         Vm//DX8noAcx39WASZGXf19zqWzLV9bOIyRWRcGkigVOvAfXbkB0iuDd0HQQpPABhuDk
         LGaw==
X-Gm-Message-State: APzg51AJBlAqzUVLggiednvffADyBqBy+EIklOsYMBtNNzDb/V9aoYJ9
        NnAVt93KiK6s4zdrWogaNaAOLw==
X-Google-Smtp-Source: ANB0VdZbpFUy9hDbJxAQbniYp41sh8py3QgtQ+d55693sCqcSVr9bp1cF6QirGpZp6gf6qHgBZ86PA==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr2043908eda.87.1536219095538;
        Thu, 06 Sep 2018 00:31:35 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s7-v6sm2163720eda.19.2018.09.06.00.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 00:31:34 -0700 (PDT)
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>, axboe@kernel.dk,
        tj@kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
References: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a1c6012f-3b50-0e5e-677c-41903b4ccf64@redhat.com>
Date:   Thu, 6 Sep 2018 09:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1536208421-24867-1-git-send-email-stripathi@amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06-09-18 06:33, Suman Tripathi wrote:
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
> Changes for v3:
> 
> * Fix the indentation and whitespace warnings.
> 
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>

Small remark, normally the changelog is put after the Signed-off-by messages like
this:

"""
Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>
---
Changes for v3:
* Fix the indentation and whitespace warnings.

Changes for v2:

* Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
* Include this object for eMAG SATA inside the acpi match table.
* Retrieve the ata_port_info from the acpi match table.
"""

This will cause git am to remove it, so that the git history just
has your original commit message.

By itself this would not be a reason to request a new version, but it
seems you've copy and pasted the patch from "git format-patch" output
into you mail client. I tried to run checkpatch myself to make
sure you caught all whitespace issues and I got this:

[hans@shalem linux]$ scripts/checkpatch.pl ~/\[PATCH\ v3\]\ ata\:\ Disable\ AHCI\ ALPM\ feature\ for\ Ampere\ Computing\ eMAG\ SATA.eml
ERROR: patch seems to be corrupt (line wrapped?)
#177: FILE: drivers/ata/ahci_platform.c:34:


ERROR: DOS line endings
#178: FILE: drivers/ata/ahci_platform.c:35:
+static const struct ata_port_info ahci_port_info_nolpm = {^M$

ERROR: DOS line endings
#179: FILE: drivers/ata/ahci_platform.c:36:
+^I.flags^I^I= AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,^M$

ERROR: DOS line endings
#180: FILE: drivers/ata/ahci_platform.c:37:
+^I.pio_mask^I= ATA_PIO4,^M$

ERROR: DOS line endings
#181: FILE: drivers/ata/ahci_platform.c:38:
+^I.udma_mask^I= ATA_UDMA6,^M$

Followed by lots more errors, line 177 of the email is empty,
while it should contain a single space. This stripping
of whitespace typically is the result of copy pasting
or some other processing of the patch.

Please try to re-send v3 using the "git send-email" command,
so that we get a patch which we can actually apply.

Regards,

Hans





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

Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37896C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8664208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8664208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH0W4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:56:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55442 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeH0W4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:56:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so9282wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OtDY3ixZhrvDqq62MihNwSrVjKh6PMmJKDwrqfbGo3A=;
        b=h1CnXbMIuQAbhsksYlkTvxpUuLiPGBeubJqKUxO9yeM8J5npeyJGn3y+nnjezroMCI
         zQwPa+8wEdOW+c2+r2yIFbYCUIkF45dIamSekl9xSACUhAtBqauEoaEIesJi5TirNBFr
         9JKnK49k/hu+Fyusi1Lrsz6OTEkqfzZefFfDFbB9x+HfnjLI7aD/p45KBAEwF/gcqoVr
         rq0QI7bHOyl7yM7at7lC+B5oDt26ppG5cwASaFXgP+T4dFzD7z7TQX7o9z3Dr4FTk2IH
         af/Dhxep9kBFvGfFEAPnY0u++4ELYEIg9gHWlHdR7HOWyTvRz2iR3upjRdWAG/Hkru8y
         vwGA==
X-Gm-Message-State: APzg51ABsxoRjmaSKBDdtuUXunUpv0rAZ4slswBPi1PuQOPOuqOMrZ1t
        RjXCaZw8oY1yHTn7r5Q6J6w30w==
X-Google-Smtp-Source: ANB0VdYRsdDhNT5iPYHlMHnc0G2F9wAgEULoxJTNvGC7NmRRhuDSCWiNt/2VshwLvU6nLp7kRU2RBQ==
X-Received: by 2002:a1c:c203:: with SMTP id s3-v6mr6971350wmf.65.1535396917322;
        Mon, 27 Aug 2018 12:08:37 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v5-v6sm15951wru.60.2018.08.27.12.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:08:36 -0700 (PDT)
Subject: Re: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
To:     Suman Tripathi <stripathi@amperecomputing.com>, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     patches@amperecomputing.com,
        Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>,
        Jens Axboe <axboe@kernel.dk>
References: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
Date:   Mon, 27 Aug 2018 21:08:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-08-18 20:47, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support
> AHCI ALPM feature. This patch disables the AHCI ALPM feature for
> eMAG SATA.
> 
> Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>

Thank you for the patch. 2 remarks:

1) The ata code is maintained by Jens Axboe (added to the Cc) now, this
is a very recent change, which still has to hit MAINTAINERS

2) See below


> ---
>   drivers/ata/ahci_platform.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 99f9a89..0d0233e 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -26,7 +26,7 @@
> 
>   #define DRV_NAME "ahci"
> 
> -static const struct ata_port_info ahci_port_info = {
> +static struct ata_port_info ahci_port_info = {
>   	.flags		= AHCI_FLAG_COMMON,
>   	.pio_mask	= ATA_PIO4,
>   	.udma_mask	= ATA_UDMA6,

Please do not remove const here, if you need to make a shared info struct
like this non const you are usually doing something wrong (see below).

> @@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
> +	struct acpi_device_info *info;
> +	acpi_status status;
>   	int rc;
> 
>   	hpriv = ahci_platform_get_resources(pdev);
> @@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> 
> +	status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
> +	if (ACPI_SUCCESS(status)) {
> +		if (info->valid & ACPI_VALID_HID) {
> +			if (!strcmp("APMC0D33", info->hardware_id.string))
> +				ahci_port_info.flags |= ATA_FLAG_NO_LPM;
> +		}
> +		ACPI_FREE(info);
> +	}
> +
>   	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
>   				     &ahci_platform_sht);
>   	if (rc)

The normal way to get specific behavior for a specific ACPI HID is
to put the HID in the ahci_acpi_match table and use the acpi_device_id
field to pass some flags (or a pointer).

So the proper way to fix this is to do something like this:

1) Add:

static const struct ata_port_info ahci_port_info_nolpm = {
         .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
         .pio_mask       = ATA_PIO4,
         .udma_mask      = ATA_UDMA6,
         .port_ops       = &ahci_platform_ops,
};

2) Modify ahci_acpi_match table to:

static const struct acpi_device_id ahci_acpi_match[] = {
	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
         {},
};

3) In ahci_probe() do:

	const struct ata_port_info *port;

	...

	port = acpi_device_get_match_data(dev);
	if (!port)
		port = &ahci_port_info;

	rc = ahci_platform_init_host(pdev, hpriv, port, &ahci_platform_sht);


Regards,

Hans

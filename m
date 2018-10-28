Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC94EC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A641C20664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A641C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeJ1XxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 19:53:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45702 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbeJ1XxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 19:53:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so5121342eds.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 08:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D1YIRyMSotDRU3pksar3f9a3Jt81tNxr6Y/ld8N6zCk=;
        b=qfCV4ckjl7eaZb6G8gsuDwRT1uZ32pyRxZRwyk6uGvMEJupfMXrbE8j0XlI6/+O3D3
         MkIk1+Cjd0LvO2vuxGld4AAAtpHMElB1c3rMUQwXbaPnYbQCR64e0TG4aVyBV78I2kEd
         CPeYZZzrISng0hBeqweZDsVrOq/6wDOc+uEG+233d96eriF3sYfE25BppZHSrqMcLgQP
         XxOFC8rkltoV3Qd0/9L6ThrgDcEQsjQc5Z62Vmob4FnIkEIuUa8+XY+0oGJJ9tz7INfF
         KMeFdEQj8nGwMfAPeFb7dwIBk8UAV1fxQ77ZGp2YSuc5U1hczKnBnPSu6rOHnQgizNli
         eDNA==
X-Gm-Message-State: AGRZ1gIAVcvhwf8AaMihzkZ1O8+4KaVm6X4ZLOTlnerfom8IwcLZAhB5
        0m4BBh6+CGME22xINzdrq2ZmQ1doR3s=
X-Google-Smtp-Source: AJdET5dm3ZnvM7vOBfatXK5VJc3UgCV4uaExmHaG5aC981+aCOBj0d4+dvLn2ZNbkONtfAetAoPKwQ==
X-Received: by 2002:a17:906:18f1:: with SMTP id e17-v6mr8254101ejf.230.1540739301783;
        Sun, 28 Oct 2018 08:08:21 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f5-v6sm2230182edi.85.2018.10.28.08.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 08:08:21 -0700 (PDT)
Subject: Re: [PATCH] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     Diego Viola <diego.viola@gmail.com>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181028143403.2285-1-diego.viola@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e3db790-606c-24aa-b612-b88bf528dbdf@redhat.com>
Date:   Sun, 28 Oct 2018 16:08:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181028143403.2285-1-diego.viola@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-10-18 15:34, Diego Viola wrote:
> med_power_with_dipm still causes freezes after updating the firmware to
> the latest version (DXT04L5Q).
> 
> Set model_rev to NULL and blacklist the device.
> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>

Thank you for the patch.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/ata/libata-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6e594644cb1d..a7f5202a4815 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4553,7 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>   	/* These specific Samsung models/firmware-revs do not handle LPM well */
>   	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
>   	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
> -	{ "SAMSUNG MZ7TD256HAFV-000L9", "DXT02L5Q", ATA_HORKAGE_NOLPM, },
> +	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
>   
>   	/* devices that don't properly handle queued TRIM commands */
>   	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> 

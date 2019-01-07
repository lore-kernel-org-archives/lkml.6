Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB492173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0Y2GbiAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfAGPmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:42:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37551 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbfAGPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:42:00 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so1591318iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65pTjOwvERfOhCME2vOI3ySk9gqLIB4TjiOb1MI/TjY=;
        b=0Y2GbiAx7UcXDit8afl9RzmdQvVb52gV6e9fE86QoDSlwEcGmHEIIFzheE1+ye7HLC
         9ZasuZ3wh0VKspTWeDsKow2KCxipLx7IadjO14LVmp83pD8Bhq0FWj9osdEbaY1O9ISo
         kY8MvSv3Z5EpSXOeNRXxl149S+y4qPfwUXPrpPOJdjZ8M5FVX2cZhcq9WLZIE4sULpSJ
         URJ7r59XELp0g3gu9D33eCM5NI3RMMeDAY7c8jEDBtvA8bSTjmOgEazfNYh/Q1PHOUqz
         JQ9hfe6eqq9WRNzo+5zGpuHkN11cKcmuY4/ylqvK6pREIOvjW1a7JMw4sSL9Ge9GBklI
         j5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65pTjOwvERfOhCME2vOI3ySk9gqLIB4TjiOb1MI/TjY=;
        b=DDnQ++A+NgWv88Z1qiAwdW8DzE8FFgTvqrMTXbN1O4l+sBEsRP4e7466+CD+DNSW/k
         1KqA+k4eFZvSQ8WC1CeDk42mjv7rXlAgr8XIis8bT2rj2ZqycZrLz2l4IIJvlhKwarKd
         5jMEO6bosTVp1ZwDqiQ7wsbL+lH6HsiLbctH1/GJcZO9QjAQ+C4EgjmxnW0ZcC/oXebS
         aB3KzThC9mjT8DCWSvYz8Kmx+q6byyLyGZjG7/hQfb259mtiw4CMPKAlkigvdhrx3bbQ
         2bCwG/mLeucX9eYokGhpFdUNb/gZPxWaGV+2EgfpT8ssyx4qcGCVagj25cdMX5sgOA+G
         cZqQ==
X-Gm-Message-State: AJcUukdn2j/S1PTyG5NSBZo2w6tysuwZhR/x31t5qqm59IZtoYUj42lT
        DaIplgrGaRF2jpocjksa4dk1DoVPt3D4hw==
X-Google-Smtp-Source: ALg8bN5QRV00sjYacG+ksrltR9LfjsTNsjClFMFWG2vX21h6MVwBlzwmriCIKlNCPUFRVWYnGN4kFQ==
X-Received: by 2002:a02:4c9:: with SMTP id 192mr33327577jab.2.1546875718837;
        Mon, 07 Jan 2019 07:41:58 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o63sm4738091ita.8.2019.01.07.07.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:41:57 -0800 (PST)
Subject: Re: [PATCH v5 02/11] ata: pata_acpi: Make PCI dependency explicit
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-3-okaya@kernel.org>
 <CAJZ5v0gkGaxgr+-CzsabqrfVFQFo_R+G3VEg3qF_sGWa6bT-Dg@mail.gmail.com>
 <CGME20190107141740eucas1p15f2975c3d87e7a8fce9daeaea41525d4@eucas1p1.samsung.com>
 <7d6b9323-7760-944d-daa4-6fc663a32481@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa5ecfd1-fbb5-1f7a-500b-9eaee1cd8e0a@kernel.dk>
Date:   Mon, 7 Jan 2019 08:41:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7d6b9323-7760-944d-daa4-6fc663a32481@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 7:17 AM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 01/07/2019 12:12 PM, Rafael J. Wysocki wrote:
>> On Wed, Jan 2, 2019 at 7:11 PM Sinan Kaya <okaya@kernel.org> wrote:
>>>
>>> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
>>> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
>>> satisfied implicitly through dependencies on CONFIG_ACPI have to be
>>> specified directly. PATA_ACPI is a PCI device driver but the PCI
>>> dependency has not been explicitly called out.
>>>
>>> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>>> ---
>>>  drivers/ata/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>> index 4ca7a6b4eaae..8218db17ebdb 100644
>>> --- a/drivers/ata/Kconfig
>>> +++ b/drivers/ata/Kconfig
>>> @@ -1091,7 +1091,7 @@ comment "Generic fallback / legacy drivers"
>>>
>>>  config PATA_ACPI
>>>         tristate "ACPI firmware driver for PATA"
>>> -       depends on ATA_ACPI && ATA_BMDMA
>>> +       depends on ATA_ACPI && ATA_BMDMA && PCI
>>>         help
>>>           This option enables an ACPI method driver which drives
>>>           motherboard PATA controller interfaces through the ACPI
>>> --
>>
>> Any objections against this one from anyone?
> 
> Patch looks correct to me (pata_acpi is indeed a PCI driver):
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> but it is best to wait for Jens' ACK if you want to merge it
> through ACPI tree..

You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to merge it through the ACPI tree.

-- 
Jens Axboe


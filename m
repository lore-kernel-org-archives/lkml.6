Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD94C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2F820834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2F820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHaA21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:28:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46688 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeHaA21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:28:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so7450712edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 13:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hdW5eCDjop+R/+DmAEI6XNJQV6jvHOGNPZC69A1yWr4=;
        b=tnHlOR4CQw32CMpACbqc7Jnrtyq/Q/zJRfMWic+NykDPJc1wc5wtxpGmyeanLphrj0
         JhbHbiQu4kaAMYZi4mG2vVDua4VaCn5G9gx+Fg0MwClYC6rVvb0KrPHMGvE8m/RvN+Um
         X3JMAGJdJV4BEt58GoHvOfAu46NWGjaTkbESwOKurbZEVDiqnRyR5iwSJqUeq2RYeyOq
         kXPhGpqVMrSwjBzwr4xIZcUpqCnC84N8iU23/XgkLV9c7TuePgHNX52bjVQdyZPppbHQ
         ZZlNb49u9zdcSMmqO/h2VAlaELj6ezQ4Uz33aRdMxr/8Kq0Ac0SaopUs54QIa7H5a6M8
         UyWQ==
X-Gm-Message-State: APzg51CbaeaBPE1k94LN7Craa2xssFMF+E2b3kSRbnp9pti9Tuxfa+KA
        GywTiRwnVlmuqhqF7R9MYniFhQ==
X-Google-Smtp-Source: ANB0VdaQlKlU/lOlpok2S1pADYsbnE6mLGBAnEiYcsshQhJxqAsaklnEh/P5v6JIKFwZ28Q0Z1idVg==
X-Received: by 2002:aa7:c881:: with SMTP id p1-v6mr14782200eds.295.1535660671487;
        Thu, 30 Aug 2018 13:24:31 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id e38-v6sm3631192eda.74.2018.08.30.13.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 13:24:30 -0700 (PDT)
Subject: Re: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, axboe@kernel.dk,
        kishon@ti.com, mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4cddc0bb-534e-2ce3-fc02-03d73a8eed0b@redhat.com>
Date:   Thu, 30 Aug 2018 22:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-08-18 21:01, Corentin Labbe wrote:
> Hello
> 
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> but will be resent for inclustion when all patchs will have hit linus
> tree.

Thank you for your work on this, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note I've one remark for the final do-not-merge patch I will reply
to that patch separately.

Regards,

Hans



> 
> Changes since v3:
> - Moved PHY code to a new sun4i-a10-phy-sata driver
> - Removed reset code since ahci_platform support now reset controller.
> 
> Changes since V2
> - Moved all ressources management to ahci_platform
> 
> Corentin Labbe (13):
>    dt-bindings: ata: ahci-platform: fix indentation of target-supply
>    ata: ahci_platform: add support for AHCI controller regulator
>    dt-bindings: ata: ahci-platform: document ahci-supply
>    phy: Add sun4i-a10-phy-sata driver
>    dt-bindings: phy: document sun4i-a10-sata-phy
>    dt-bindings: ata: update ahci_sunxi bindings
>    ata: ahci_sunxi: Bypass PHY init when using the new binding
>    ata: ahci_sunxi: add support for r40
>    ARM: dts: sun8i: r40: add sata node
>    ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI
>    ARM: dts: sun7i: a20: add sata-port/sata-phy nodes
>    ARM: dts: sun4i: a10: add sata-port/sata-phy nodes
>    ata: ahci_sunxi: remove PHY code
> 
>   .../devicetree/bindings/ata/ahci-platform.txt      |  11 +-
>   .../devicetree/bindings/phy/sun4i-sata-phy.txt     |  20 ++
>   arch/arm/boot/dts/sun4i-a10.dtsi                   |  13 ++
>   arch/arm/boot/dts/sun7i-a20.dtsi                   |  13 ++
>   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  21 +++
>   arch/arm/boot/dts/sun8i-r40.dtsi                   |  23 +++
>   drivers/ata/ahci.h                                 |   1 +
>   drivers/ata/ahci_sunxi.c                           |  87 +--------
>   drivers/ata/libahci_platform.c                     |  26 ++-
>   drivers/phy/allwinner/Kconfig                      |   7 +
>   drivers/phy/allwinner/Makefile                     |   1 +
>   drivers/phy/allwinner/phy-sun4i-sata.c             | 208 +++++++++++++++++++++
>   12 files changed, 343 insertions(+), 88 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/phy/sun4i-sata-phy.txt
>   create mode 100644 drivers/phy/allwinner/phy-sun4i-sata.c
> 

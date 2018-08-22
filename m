Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA50C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12699214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12699214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbeHVQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:58:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43355 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbeHVQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:58:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id j21-v6so1378363edp.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 06:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WfxuJhSHJTjc6e2HhFs2X53sRWwszkLzIA7y7aHTV5A=;
        b=BwrxtjJLRQ46ChGGuaLv0r6t4Cih5+ZAXYN2kB/Iw5zSvWc7IdmZCkSHfG/ZmXP4wn
         2Nk+mz5xWEBAJfUSL/TcARWXrHzWpNxXUCzxb1arIXLpdzU697EnoA5ghFtTS+gMFi+k
         bBb9UbIB7epO0fY0fj5AO4yhrBAkx9m+sIUZ05DLi63rfe7olawDWVwQ+vu8Rtsu2r0h
         E3hBXf6RIM56nxXODohWWddeLdrqLqJDmbnrxjOrfU2u0Dt/+yx3w/H8E0SC1JEC5g2O
         0/Nfldjx4PdTbDWKDOjwmuL9jULdzznyuB0XU+xgLjc6WMOEqRF1n9JmZ9SPSXlCJa+4
         QM1g==
X-Gm-Message-State: APzg51D4nz/XMtArQf0YPcTgkx9KAnPOpolil16oXeloAghEXvSNEPku
        v7t6zlBFFuJ53UlWp5tOfvm3uIV950o=
X-Google-Smtp-Source: ANB0VdbIE2Hkkg1IwnuLeByFMbp8QoWQeT3kPWd/9WeeQGS/2jP1mSo/b6zNprbcHM273m4vg6r8sg==
X-Received: by 2002:a50:c006:: with SMTP id r6-v6mr7267840edb.202.1534944812418;
        Wed, 22 Aug 2018 06:33:32 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h1-v6sm782039eds.69.2018.08.22.06.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 06:33:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] ata: ahci-platform: add reset control support
 except for existing drivers
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <02526d3d-70cb-e22b-39bd-583d516ba639@redhat.com>
Date:   Wed, 22 Aug 2018 15:33:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-08-18 14:13, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device, and
> add the flag indicating whether to use the reset. Existing SoC-dependent
> drivers set 0 to this flag.
> 
> This series solves the issue of the previous patch [1] that was already
> reverted [2].
> [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> 
> Changes since v1:
> - collect patches for each soc-dependent driver
> - separate into 3 patches not to affect existing code

Thanks, series looks good to me now:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> 
> Kunihiko Hayashi (3):
>    ata: add an extra argument to ahci_platform_get_resources()
>    ata: libahci_platform: add reset control support
>    ata: ahci_platform: enable to get and control reset
> 
>   .../devicetree/bindings/ata/ahci-platform.txt      |  1 +
>   drivers/ata/ahci.h                                 |  1 +
>   drivers/ata/ahci_brcm.c                            |  2 +-
>   drivers/ata/ahci_ceva.c                            |  2 +-
>   drivers/ata/ahci_da850.c                           |  2 +-
>   drivers/ata/ahci_dm816.c                           |  2 +-
>   drivers/ata/ahci_imx.c                             |  2 +-
>   drivers/ata/ahci_mtk.c                             |  2 +-
>   drivers/ata/ahci_mvebu.c                           |  2 +-
>   drivers/ata/ahci_platform.c                        |  3 +-
>   drivers/ata/ahci_qoriq.c                           |  2 +-
>   drivers/ata/ahci_seattle.c                         |  2 +-
>   drivers/ata/ahci_st.c                              |  2 +-
>   drivers/ata/ahci_sunxi.c                           |  2 +-
>   drivers/ata/ahci_tegra.c                           |  2 +-
>   drivers/ata/ahci_xgene.c                           |  2 +-
>   drivers/ata/libahci_platform.c                     | 35 ++++++++++++++++++----
>   include/linux/ahci_platform.h                      |  4 ++-
>   18 files changed, 49 insertions(+), 21 deletions(-)
> 

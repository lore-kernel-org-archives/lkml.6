Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC447C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46172086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 02:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YuzjeMj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfAMCFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 21:05:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34042 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfAMCFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 21:05:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so8732908pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 18:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zszfRhMaE9aB13Ry/rWPq+wd6QALGdG8qzifHLAv5gQ=;
        b=YuzjeMj53TWRRBrQzNjHx22gb1EJUI3t1ZytBaLh3jRLRtXMKwsN1mMCGj4yhee5tb
         s5BitRlfSuAPHoP1Fd9npdlVEyc2wtUmDqcBo85hdzSHXmbGvkkapEcithZA95xe3zwO
         CfTWeSzL41OhK3YlWqK3T7+BQCVXa34PGdj9rh/PdbjoMf76/yngZionEfKFCMXwP/az
         1oS1FdsvnQjPe8NdG2HHtwUdM05gP58tSZFrjm6xQgEuayHbN7g4OgeQI1llFBuNZ5ZX
         QSygNSBZ0kRUaaJF88ab5n9LY3fQ/WQ8jaJIvekyCaBbLOvTiQRt++BOZ8xt+mkdBIqL
         ZOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zszfRhMaE9aB13Ry/rWPq+wd6QALGdG8qzifHLAv5gQ=;
        b=RCXTrofwBehbtM3D9Z+NVnzT7D1n7D4rbxCcQwegb58HDX1hMQEhOyCrnxiHbjrlru
         IktXuuNbUfvqXPoyzMp+p8sSdahxHZPJYuRDLKKrLpLZdOCw2Dvg0Ct8bN8Na4Gdqdtq
         3VSsRnKXUB9nKta0cPbOWqDWKFEX+e6CmGV2pRrJEbu9+onRwisXFnGuqXNmVBDd7n7i
         7EiUOdzjPsrrLmDm+CLJ9mwlqay5Kcy3VC7+jvOeTtkswW5nzofx6aKcvLN4MeBqI7fb
         zdfLwdJDUyHFpV0RxIBwolIVoz8CHBot+Kqy/k8TyfnY60nE/cFBUob47OlI8K/kALSL
         xphg==
X-Gm-Message-State: AJcUukdwP7ggIuMYj8p/3i94m6qma5Wro3qFUGaSZNBLtW9SMpNsXP0z
        Vn8Dl50J23nBUVF4kZpadHhFxZrWdW25AQ==
X-Google-Smtp-Source: ALg8bN48gdIFuLTQXGNU3sVq2MbmhRzmjZoibAFwaQ/ytSWfhf+U6n/mGB4G/ADcWLsbPo1t6lhzoQ==
X-Received: by 2002:a63:5f50:: with SMTP id t77mr18472414pgb.76.1547345146117;
        Sat, 12 Jan 2019 18:05:46 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b2sm137430073pgg.87.2019.01.12.18.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 18:05:45 -0800 (PST)
Subject: Re: [PATCH 1/1] phy: fix build breakage: add PHY_MODE_SATA
To:     john.hubbard@gmail.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Rob Herring <robh@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190113012909.11986-1-jhubbard@nvidia.com>
 <20190113012909.11986-2-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9518922c-ab17-ba06-0670-f0202b436a8c@kernel.dk>
Date:   Sat, 12 Jan 2019 19:05:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113012909.11986-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/19 6:29 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Commit 49e54187ae0b ("ata: libahci_platform: comply to PHY framework") uses
> the PHY_MODE_SATA, but that enum had not yet been added. This caused a
> build failure for me, with today's linux.git.
> 
> Also, there is a potentially conflicting (mis-named) PHY_MODE_SATA, hiding
> in the Marvell Berlin SATA PHY driver.
> 
> Fix the build by:
> 
>     1) Renaming Marvell's defined value to a more scoped name,
>        in order to avoid any potential conflicts: PHY_BERLIN_MODE_SATA.
> 
>     2) Adding the missing enum, which was going to be added anyway as part
>        of [1].
> 
> [1] https://lkml.kernel.org/r/20190108163124.6409-3-miquel.raynal@bootlin.com
> 
> Fixes: 49e54187ae0b ("ata: libahci_platform: comply to PHY framework")

Linus, this is probably a better option in terms of what should go in to
fix that commit.

> 
> Cc: Grzegorz Jaszczyk <jaz@semihalf.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/phy/marvell/phy-berlin-sata.c | 5 +++--
>  include/linux/phy/phy.h               | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-berlin-sata.c b/drivers/phy/marvell/phy-berlin-sata.c
> index a91fc67fc4e0..d70ba9bc42d9 100644
> --- a/drivers/phy/marvell/phy-berlin-sata.c
> +++ b/drivers/phy/marvell/phy-berlin-sata.c
> @@ -32,7 +32,7 @@
>  
>  /* register 0x01 */
>  #define REF_FREF_SEL_25		BIT(0)
> -#define PHY_MODE_SATA		(0x0 << 5)
> +#define PHY_BERLIN_MODE_SATA	(0x0 << 5)
>  
>  /* register 0x02 */
>  #define USE_MAX_PLL_RATE	BIT(12)
> @@ -102,7 +102,8 @@ static int phy_berlin_sata_power_on(struct phy *phy)
>  
>  	/* set PHY mode and ref freq to 25 MHz */
>  	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x01,
> -				    0x00ff, REF_FREF_SEL_25 | PHY_MODE_SATA);
> +				    0x00ff,
> +				    REF_FREF_SEL_25 | PHY_BERLIN_MODE_SATA);
>  
>  	/* set PHY up to 6 Gbps */
>  	phy_berlin_sata_reg_setbits(ctrl_reg, priv->phy_base, 0x25,
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e8e118d70fd7..3f350e2749fe 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -42,6 +42,7 @@ enum phy_mode {
>  	PHY_MODE_PCIE,
>  	PHY_MODE_ETHERNET,
>  	PHY_MODE_MIPI_DPHY,
> +	PHY_MODE_SATA
>  };
>  
>  /**
> 


-- 
Jens Axboe


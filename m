Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721EAECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2BlRd72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2935D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbeIUBEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36953 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbeIUBEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so684375wmc.2;
        Thu, 20 Sep 2018 12:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cd6Os+XKzNk3gM+8c5KtKpgh8mvTfSK+lTx7zfj3BIU=;
        b=a2BlRd72deBfxXI1q+E7m92TFE24mBhl0DqEOAlXt8JcUFkgAzogJml3MOsjHe2qnP
         aGbQIiYjzNq4SsP0GxFM9iyNBqliegNw3/2ale/bPkCoWgB8x2IxSBK1dSbYeeNnP6Oo
         D2O9Zceu3onOGQwGdWro2rmRSW6yUJ8mhZtzAhZ+bUBx5dQGp67ITBV4ix9UnxEHuwph
         kMXUfqgM0ZfSlViLvcc9pUb7spJ/bw5zPupx4TDUwpVrv6bxlIdwZsPN8WVvpow3k/wu
         MnbVL7aP5niLxuFuFwVaPpYKKBTL3Z4qt3LR/KXVg8JxHujv588WCPPhzWc2uzPgiBtO
         6pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Cd6Os+XKzNk3gM+8c5KtKpgh8mvTfSK+lTx7zfj3BIU=;
        b=O+pNdqLUGpod6FrvWCdr1PqpOlt7ZahnvzWrlSnsHIBQCmVwwC6r6oWGZmL/Z8iExh
         qwNL7ZDc2wqaTQIGeOgnCy3dNez/jmw57g894S443Qx3DOQ+VNg7EI5qtDF/qZREwy6t
         SvmKDapWX7063CUxAbcOF5R1Jt23ZkvxbwItHH+ckfc9fBV8dIqrOpp3NYAJNoa706aS
         l2AVuwfgeWAmrNwvEAdFEI4rCiBB+aDfpV4bo2nIzV5wan2c0sDYCLOGr/9FH0pIH9h3
         m17vTjno9awQL5mzbgoxKUac28n/5KQCaSscHbJdOiFgMWVoB2UX4t49fIE9wXPEXhLe
         MJJQ==
X-Gm-Message-State: APzg51BLuwT+GYqj20csU4AxqqaeqLkLe4QCN5lBWgFP/6t8wKVSDdLw
        mu1kXXpDV8Vx6J1eGjll2/w=
X-Google-Smtp-Source: ANB0VdaNzGm4epZ1aXRY98dc5/6RV2+rscxLq4Tm0DYs4ONtQnSYs1maeHIrXX/aaeNI7S62LVua4w==
X-Received: by 2002:a1c:bd89:: with SMTP id n131-v6mr4235798wmf.97.1537471193075;
        Thu, 20 Sep 2018 12:19:53 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id q200-v6sm3928767wmd.2.2018.09.20.12.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:19:52 -0700 (PDT)
Subject: Re: [PATCH 0/9] AHCI and SATA PHY support for BCM63138
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com
References: <20180920191646.18198-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <7b6e1671-8efe-20d2-d3a2-51a521ce7f22@gmail.com>
Date:   Thu, 20 Sep 2018 12:19:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 12:16 PM, Florian Fainelli wrote:
> Hi Kishon, Tejun,
> 
> This patch series adds support for the SATA AHCI and PHY found on the
> ARM-basd BCM63138 DSL SoCs.
> 
> It would probably make sense for patches 1-3 to go through Kishon's
> tree, patches 4-7 through Tejun's tree, and I would be merging the last
> two patches through the Broadcom ARM-SoC tree.
> 
> Let me know if this is not a workable plan, thank you very much!

Looks like I had left patches with the incorrect subject, please
disregard the following patches:

[PATCH 2/9] phy: broadcom: allow PHY_BRCM_SATA driver to be built for
DSL SoCs
[PATCH 5/9] ata: sata_brcmstb: Allow optional reset controller to be used
[PATCH 6/9] ata: ahci_brcmstb: Match 63138 compatible strings

since they have incorrect/inconsistent titles, the other patches are
fine though. Sorry about that.

> 
> Florian Fainelli (9):
>   dt-bindings: phy: Document BCM63138 compatible string
>   phy: brcm-sata: allow PHY_BRCM_SATA driver to be built for DSL SoCs
>   phy: brcm-sata: Add BCM63138 (DSL) PHY init sequence
>   dt-bindings: ata: Document BCM63138 compatible string
>   ata: ahci_brcm: Allow optional reset controller to be used
>   ata: ahci_brcm: Match BCM63138 compatible strings
>   ata: ahci_brcm: Allow using driver or DSL SoCs
>   ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
>   ARM: bcm63138: Enable SATA AHCI and PHY
> 
>  .../bindings/ata/brcm,sata-brcm.txt           |  1 +
>  .../devicetree/bindings/phy/brcm-sata-phy.txt |  1 +
>  arch/arm/boot/dts/bcm63138.dtsi               | 30 ++++++++
>  arch/arm/boot/dts/bcm963138dvt.dts            |  8 +++
>  drivers/ata/Kconfig                           |  3 +-
>  drivers/ata/ahci_brcm.c                       | 10 +++
>  drivers/phy/broadcom/Kconfig                  |  3 +-
>  drivers/phy/broadcom/phy-brcm-sata.c          | 70 +++++++++++++++++++
>  8 files changed, 124 insertions(+), 2 deletions(-)
> 


-- 
Florian

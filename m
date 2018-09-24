Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EE5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A02098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKJaxZ/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09A02098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeIYBVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:21:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbeIYBVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:21:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so12915278wrx.1;
        Mon, 24 Sep 2018 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mI0VhqjqHJgFeHfXnmatpmd9I9QlezueoYPSRX+mdhw=;
        b=NKJaxZ/J36AZwdCf86InvwcudL9Vk8Z44AK2l76QDrXLOTbd/T3Ivkv7i6stfUS7T4
         hN4zaPyojPPuse0tTaerOwmFj5CBHDlU8LkKMSgha+d7jVTBA001n6at/mGvVGUSuAy1
         PCjVGI7AaIlV6c/FYneXKQV6b+qftxS9IXmfmdeUOiAIs8WrdIecHUMMODYy46sCZ+nM
         aimc5BeqbNES7kzCuKi+L8OaQsNVtO7141Pux12znwusTNQzU9bB1EJAwz8GmTHlBbgP
         EFKFnAvLYDkexI+4gODl3caS76oBhyEEiwc8OVM1q/f3+klMCQrTO2zBI6OcfGONykCG
         mMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mI0VhqjqHJgFeHfXnmatpmd9I9QlezueoYPSRX+mdhw=;
        b=MEAcq69vMaw1dLOJ2rQS2TaWzwBMZtM7mZnPJ75kYCjS07MwkgGYaUZTpetF7aV80g
         CEx6kKu8qPIhtMm0z7oH38uJadcgd9eAnLHlkrDu5HIPqZZCoJPIbf2qokRorS0cz3a8
         P2Lq6FLqr2hcK5YBUz68SwthLO0cQxSNZItQJJrCr0YNWQ+kfHnrF3a70C+ryYUu7Kaz
         LGiXJ4KdvWOlgc8Xhp2NdrMEyO0/vLRH8gygODUaDg70wpK3PUI6jCDEv+tUKQhTrAzw
         uT3vLzEzaZFUlysvhSaNeG5jsJEyyy4qYqmcPUGfWKi37NQRs3slP4xsVbQu/OpywHsg
         Yt4g==
X-Gm-Message-State: ABuFfohpQhRUWnnFUXcg8pSOuDqV67PmPtPSShqfx2t2GtwyGbZ0p9FJ
        5PUctoRMqPobzNFx0j0+FrA=
X-Google-Smtp-Source: ACcGV63NSRHd9HA2aVNbJS4wHAPwNXhmvt2eeRvcVtBsM/mfo801Z6srqUkCE/3drM+C47z09U/okA==
X-Received: by 2002:adf:fa84:: with SMTP id h4-v6mr209057wrr.74.1537816644318;
        Mon, 24 Sep 2018 12:17:24 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id g2-v6sm4512990wmh.16.2018.09.24.12.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:17:23 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] net: stmmac: dwmac-meson8b: use xxxsetbits32
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <a8d06d0a-b13b-384c-ade6-b0a3b0ee61f6@gmail.com>
Date:   Mon, 24 Sep 2018 12:17:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-8-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 12:04 PM, Corentin Labbe wrote:
> This patch convert meson stmmac glue driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    | 56 +++++++++-------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index c5979569fd60..abcf65588576 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -23,6 +23,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <linux/stmmac.h>
> +#include <linux/setbits.h>
>  
>  #include "stmmac_platform.h"
>  
> @@ -75,18 +76,6 @@ struct meson8b_dwmac_clk_configs {
>  	struct clk_gate		rgmii_tx_en;
>  };
>  
> -static void meson8b_dwmac_mask_bits(struct meson8b_dwmac *dwmac, u32 reg,
> -				    u32 mask, u32 value)
> -{
> -	u32 data;
> -
> -	data = readl(dwmac->regs + reg);
> -	data &= ~mask;
> -	data |= (value & mask);
> -
> -	writel(data, dwmac->regs + reg);
> -}

Why not make mseon8b_dwmac_mask_bits() a wrapper around
clrsetbits_le32() whose purpose is only to dereference dwmac->regs and
pass it to clrsetbits_le32()? That would be far less changes to review
and audit for correctness, same goes with every other patch in this
series touching the meson drivers.
-- 
Florian

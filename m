Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7549ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055C20844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxuvTcJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5055C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeGPMqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:46:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43224 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbeGPMqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:46:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so31721756wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=caBKpWwaHSpjQh0KeAWGrQRHNRY7iRsR+IIl5LC46Vw=;
        b=gxuvTcJ7ff2pfbiMveMXStKVAGzYdfPsOegiCwouqErX/zqaBV4p8Lf4CyxJhyd4AM
         JMCW7U7z8Aav7JaDtLUqWpnPQq1J4QiE89w2LvIDtIfCxjoDr/U5Z8A23JWmtltv9jZh
         wZgkL2ZE+7F1rWCpDYHPLBIsBKcuryqQXNdCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=caBKpWwaHSpjQh0KeAWGrQRHNRY7iRsR+IIl5LC46Vw=;
        b=LfZJQgb+hFF2B8tc6ntQp0otTreDWjyoAarof/v0nBXZ8nkWglJVG41W4hsXo/5IBT
         wA1ResnA/YBCmETPkRmSdgLYCqNrOvyQnubXZTemZzOxVuupF2QB4vXgrySzKdM58W/v
         qlV+YUUHinp46f4UlrufFrxdPJn8mtnS1NITRLQc5Dw03B9xZzzOnF9v1ii09+l4TACm
         0moQoiQFC9jaVpQejOg8b3osP+ovIuf4nnD9KreDOM8gb2jpTBNKObwbVoZ1bk8d3e9i
         ob6RhhlL14/QDKq/DpR9JwMxh9fJz/0DRTmG84nLdKkwf2vUc6S5yN8mmUEK6hSm6D6n
         WlOg==
X-Gm-Message-State: AOUpUlGTndnJyfSrfLyCw+fmArkBxASN6ZqGCZxrT24quRJsEFygrbqq
        KkxA5pDTyGswI5JisshNsSgYQg==
X-Google-Smtp-Source: AAOMgpfd/XhHqt1PukE133Vd6hTy0vDpvSH+YZSc2HgpFo+kRAXG29Q6MEMNozE1YK/QTtJgb0/YRA==
X-Received: by 2002:adf:959a:: with SMTP id p26-v6mr11625588wrp.202.1531743541197;
        Mon, 16 Jul 2018 05:19:01 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 185-v6sm20164030wmh.22.2018.07.16.05.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 05:19:00 -0700 (PDT)
Subject: Re: [PATCH v4 02/18] Documentation: nvmem: document lookup entries
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-3-brgl@bgdev.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d5c1a83c-7c63-32ab-1d41-8e9bf4cdd6b7@linaro.org>
Date:   Mon, 16 Jul 2018 13:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180629094039.7543-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/18 10:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Describe the usage of nvmem cell lookup tables.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   Documentation/nvmem/nvmem.txt | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/nvmem/nvmem.txt b/Documentation/nvmem/nvmem.txt
> index 8d8d8f58f96f..9d5e3ca2b4f3 100644
> --- a/Documentation/nvmem/nvmem.txt
> +++ b/Documentation/nvmem/nvmem.txt
> @@ -58,6 +58,34 @@ static int qfprom_probe(struct platform_device *pdev)
>   It is mandatory that the NVMEM provider has a regmap associated with its
>   struct device. Failure to do would return error code from nvmem_register().
>   
> +Additionally it is possible to create nvmem cell lookup entries and register
> +them with the nvmem framework from machine code as shown in the example below:
> +
> +static struct nvmem_cell_lookup foobar_lookup = {
> +	.info = {
> +		.name = "mac-address",
> +		.offset = 0xd000,
> +		.bytes = ERH_ALEN,
> +	},
> +	.nvmem_name = "foobar",
> +};
> +
> +static void foobar_register(void)
> +{
> +	...
> +	nvmem_add_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
> +A lookup entry table can be later removed if needed:
> +
> +static void foobar_fini(void)
> +{
> +	...
> +	nvmem_del_lookup_table(&foobar_lookup, 1);
> +	...
> +}
> +
>   NVMEM Consumers
>   +++++++++++++++
>   
> 

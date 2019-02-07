Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A863C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34DB21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB3+HXd7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGSuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:50:15 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:32899 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:50:15 -0500
Received: by mail-lf1-f53.google.com with SMTP id q12so714963lfm.0;
        Thu, 07 Feb 2019 10:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+J+e0a/vJbdxod41KsemvmUeFjLyEw3km+wgDgJZtXs=;
        b=AB3+HXd72JxmrO2zYm62/gsiTmQLI4CLey3XY9t8MQpaK3daHu2uTdLQRzi72xWBow
         GB3GjKBOJKqv+ySWxbXWPouzTjnpgfBBpZELBYOBo3rr0IXr1VxsiugATdg3P90TtDnd
         638yX2IOYSJq+Ivh+YeNX+QuZsweSDtkRLAgq4akP8ri5dqFZQIOoCsEt02ZcI3EhNBZ
         hRCn0cK1Ek3k0GPnHyNeyiiaswZ8/o4WYR9jtnLE7UiRkb7q4Zos83MEur8oIzxlwarc
         ajRyUyglcdWQDm2Yssay5wMGZzNGPCvlfLGjAYOFXLQOURfrf3OlDK2BhDKQaN19nYAe
         N4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+J+e0a/vJbdxod41KsemvmUeFjLyEw3km+wgDgJZtXs=;
        b=ZD1C205IIJ1jI7kspZb/hnMxh4o9/QhHcAJ256XyZSalfJHF+KH/18kBzw/O0Q+dmu
         KJ1rZxmf2pZ+Y5c17cKmcU4bg35qv/+8B1C7Xa2o84f8VSCOHf2pHXbF6U1Czjz3CYd+
         gBIR6owizaR3qDKxiGyLXD0s8uZ22Kt9wY9paAPENm/qNWw11iMC+EvgFzvv4EtkexPl
         /wAHmd5lPM1JgZWw1tMd13QKUoVRS0c4roNLoRRKj8pzHsUhG1ztj/iy+AZoAASzcIsO
         ZeGaM3smYx0rJKoQ0eXnOmwBXNcySjjh2pINDDx05HjY99XbfdxLLIUtBp/0AYF222x6
         P6AQ==
X-Gm-Message-State: AHQUAuavEKERhRckGWRRi0b8qh1SXcfLXxjfQLi4UQG5K8ZZCrdO6gHY
        jKRmymsAoULG2eG+ao0xGr3CnGM4
X-Google-Smtp-Source: AHgI3IbDq3vwkgS69o9ZZSl7sRk6yVlsUDi8U4k3ofJsAt8vfMHYEiBV298Lu3+Pbb8Ylrw4q65Ang==
X-Received: by 2002:a19:1cd3:: with SMTP id c202mr11002991lfc.33.1549565412209;
        Thu, 07 Feb 2019 10:50:12 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w16-v6sm4485261ljw.11.2019.02.07.10.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:50:11 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e09062b7-9c74-6aee-477a-72fb72bbd5d3@gmail.com>
Date:   Thu, 7 Feb 2019 21:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
> @@ -920,6 +1238,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = false,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
> @@ -935,6 +1254,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = false,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
> @@ -950,6 +1270,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
> @@ -965,6 +1286,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };
>  
>  static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
> @@ -980,6 +1302,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
>  	.has_mst_fifo = false,
>  	.quirks = &tegra_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = true,
>  };

T186 is missed here.

>  
>  static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
> @@ -995,6 +1318,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
>  	.has_mst_fifo = true,
>  	.quirks = &tegra194_i2c_quirks,
>  	.supports_bus_clear = true,
> +	.has_apb_dma = false,
>  };


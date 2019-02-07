Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B313C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591CA2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZfoCB1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGSzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:55:31 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:34706 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:55:31 -0500
Received: by mail-lf1-f52.google.com with SMTP id p6so724326lfc.1;
        Thu, 07 Feb 2019 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fuDfjeDnj5WwqQ121xvpEgogqRvKF6hOqnvG2p/86rg=;
        b=iZfoCB1o6UiT5Qfz7/5yC0eJAdRP7luxaznBdWVG9CMG2ky8+ArZToS0DuB8XDz6Fh
         4vKAfcaqMNkzYmLc5Cl/SHta2h/ogToYbR7LPGk+4NflRk+S94+tGWUsiNyslzp5bSbd
         UBhGQEEImGEGU9PbixsYyA5qPspCzHOGVeIDg0hYl+9YotwZRLAhpxO1YUY7Wg7iIh4l
         +MP3IEKVNQJPVespH3tD4C+TClex9zKwPL0DoukvsfTstbVivXVAII3f24WL9FXXeVvR
         LAuFrisFC1Go/N4RK8xBKakN30mMd6sudmERYA5LyE110QOY0hwPvdoKhGW513kfg3Tl
         NpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuDfjeDnj5WwqQ121xvpEgogqRvKF6hOqnvG2p/86rg=;
        b=h6ni767DsFd8rSgRgiuqfuMoSsB9UCE31jXYAjiI+/VpuzAL7CTcx08gZVBm6Okqns
         UEkxQGecH8GczrEuxVetZ14nKFKZa7AFTFGqkZaUyeqa7mTj1beGvERTHUsVq6WWEsUa
         UVSnG81zjGtZs/GdfuSSiwfJQxy7EDi52AiJ8Wlrl2KlEiHP0IolOfLohHGtF5HxZWDj
         KdMbSor/xQIFvaug4JuSoIQzC0+uUu5ZHPPNN9EVg+gWl2OmrjBzY64OPZRSC6nL4CQK
         4koABotiHuGULxMNNxzHmm/ecNIm3hJdcCM0wDhGXdX5J082mp8I/0xjjHfi8lzt2wPV
         mDVA==
X-Gm-Message-State: AHQUAuaT3qwraGEwyruSPMLP57Q+lRzHKLa4iUcJuhkpf+sAxcKLWtwC
        UsTOq4FYOLVSLu9xlcjVRVQ8pBZy
X-Google-Smtp-Source: AHgI3IbVCYLtQtSxxACh9asPlomSepne4iRSGkQvhjit/VIx0sU26r/DaALHF6EJggNSj/ub9jx4Xw==
X-Received: by 2002:a19:2893:: with SMTP id o141mr11015946lfo.63.1549565728449;
        Thu, 07 Feb 2019 10:55:28 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm4456865ljj.48.2019.02.07.10.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:55:27 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <701bf743-c54b-169d-6f82-9611c5eb20e9@gmail.com>
Date:   Thu, 7 Feb 2019 21:55:26 +0300
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
>  /**
> @@ -191,6 +207,7 @@ struct tegra_i2c_hw_feature {
>   * @fast_clk: clock reference for fast clock of I2C controller
>   * @rst: reset control for the I2C controller
>   * @base: ioremapped registers cookie
> + * @base_phys: Physical base address of the I2C controller

Minor nit: "physical" with lower case for consistency, please

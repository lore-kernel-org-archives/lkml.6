Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8CCC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C23420863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlcR7owN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfBHQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:55:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37560 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:55:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1958419plr.4;
        Fri, 08 Feb 2019 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pulm6HOf/6nO7CFL+OWCO30RBWKiP3+NiGVFtJLPlEc=;
        b=JlcR7owNrLK1sY4nEl2ziFcrSh8MqlJLbINZ4RdiMB828pOTs4CstdzJMmkQn2ZAc/
         g6SuMOKUgzp9MmA2md6Du4WpXWJMDHMSDt8u88ILvWZ/8NXGZDh6Xk8VtJuYBNjHdI6E
         lWAimA65b/tGVKWcchcnacnN6p3MZlP/TGNk+R3QdsDz5qSKSafHyWcQOvLuAAMfDunf
         0co+bZavUZhzHDt8aIS1WcczpXJCAnRTU9Z4x7KqlX8wpM9CVqyt1tpx7nzo54O2imqT
         eSpN9xLj18CzzIYyDRLezlfASuPqM0uY7eHJR6b+Nz0ejmhFiUFEOSLM9xl3ilE3Oyme
         govw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pulm6HOf/6nO7CFL+OWCO30RBWKiP3+NiGVFtJLPlEc=;
        b=UOnEYiSdfPKI9igzEOL3A4aoKsm2ZluOZ6UvWO4ku6ki05UvjSGAN01lRwqCf6a/N3
         O4E9ZGarDVnATgo+Qpsmgv0X00NnK62kkahTLWy1uJ2EQA/Yo3EgsXc/maKFMbjVaBoV
         puqyUX9QBEsbw8v6rGGoNHDe9FcN7xxfoZsGnw47+MTGxr7R0z3UJfh2cO2U2MuCnCL5
         vvj9+1Ju3KGY0Xhym3OgUefsQ0h0VXgkUCRpo0vvT6DrTkIVVmclhzwG89Lu+smtDwkm
         RDD1eYVzjFRUpKPLMna/WrfsHVv4A7u9ULD1tTyyHZmGi56X7HkTTbEm4Oh0uDRSoS2f
         Z2Cw==
X-Gm-Message-State: AHQUAubhNhmf3hbRWDHnBWBChwRJHg8r1Oflcom7F9O7yaTCm5h2yAyj
        zkhc+yI7QijSJV/Deq2xP2BFlpRh
X-Google-Smtp-Source: AHgI3IZ4+h3I63Gm9TaQrfOIftPOPI+r6mQtgA9kIMllm7+sQjVHhBR7gnLFoLGrJSaC+fgxGbw9OA==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr13108999pls.273.1549644927491;
        Fri, 08 Feb 2019 08:55:27 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id r3sm10852843pgn.48.2019.02.08.08.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 08:55:26 -0800 (PST)
Subject: Re: [PATCH V16 6/6] i2c: tegra: add i2c interface timing support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549644314-1481-1-git-send-email-skomatineni@nvidia.com>
 <1549644314-1481-6-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <98c866b4-7924-91df-5680-f7f23dddfaaf@gmail.com>
Date:   Fri, 8 Feb 2019 19:55:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549644314-1481-6-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

08.02.2019 19:45, Sowjanya Komatineni пишет:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the I2C spec
> setup and hold times based on the tuning performed on Tegra210,
> Tegra186 and Tegra194 platforms.
> 
> I2C_INTERFACE_TIMING_0 register contains TLOW and THIGH field
> and Tegra I2C controller design uses them as a part of internal
> clock divisor.
> 
> I2C_INTERFACE_TIMING_1 register contains the setup and hold times
> for start and stop conditions.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>



Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071FE2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJhAp+VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBGS0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:26:09 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46301 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:26:09 -0500
Received: by mail-lj1-f182.google.com with SMTP id v15-v6so684541ljh.13;
        Thu, 07 Feb 2019 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s0ZaF4XdmGmBP6DNFkSP1QbcWtKrllQ+ixeL2B5oCQQ=;
        b=fJhAp+VQciDbU6r/WIJr1v/nEJqb4EtE6uXZmJ/RlpoxVqW+n1ELHgji/2WgXyTEwL
         PqyKvrYJ5Fw2+Ywz6r7CvRrXrXUEgz4RRSWA9WUwjGhQkjKAnBpXSIITqk64a0y8iqae
         wKe3MSa3l4yAygppXORw3JvZ/mlNXd4ee85ewfnWkGSyOp6JPyRrdVweHvpz6M1UjWMc
         VdSdJvqtdz0Dzd4nMQoV0hJPJnNbivg7+Cmz/uS015v4QaaRVFTgCcHpMYErBvxrGJRA
         Eenu/yW7bX4s+252CaYz4Ogx9NpCZXhbVAV84XReKvUFYtdx5EoqmWnsf8jyeZZCST+K
         8dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0ZaF4XdmGmBP6DNFkSP1QbcWtKrllQ+ixeL2B5oCQQ=;
        b=HOBi9dBJhrqthX9o+KZXxaHJWod1QbEl73kyPDBZrs5mhjyXFuemJWeHuSktGy5j4i
         cp6R2zqj1rihGFlxFOjYaLhGJ1KNFF0Mxwsi5o3Dt/9c6gS/Rz0Cmeln67Dcp4Ejn1Bm
         A/0CmvxFNA0slHZT3nKwltw95c7gj92/WZniTXgkx82SgtJoSUTYN2KOqKcrAoNrjGZT
         3J3GYRi0Jm3UEeK8uwvccH/pJHv6KG5VaKnhXCSOIDXMWBngsi+ySKRjJAxjJpWyBF4C
         2T5NIFB2+KHkkaTiiz27ZxT/sVGE+ryX9Hv5Pair+b+uSN+i+nXrJ5TkViCM9+YIKIrY
         imIQ==
X-Gm-Message-State: AHQUAua72/9UelPNja/IwB37YQlc3JtfMVXLMhc22Z6GUVKZx02PWGX8
        jnoWidzNYKtOUKVaJEoYTiwCnTsj
X-Google-Smtp-Source: AHgI3IZvqm7p3HeDJAZkUe2tGOIC2BJIh0BlqqOSAM4ML7zLYcHfTA6zPkMYg6wcofFCE3THXDpvEA==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr11107471ljg.160.1549563966551;
        Thu, 07 Feb 2019 10:26:06 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id s3-v6sm4452257lje.73.2019.02.07.10.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:26:05 -0800 (PST)
Subject: Re: [PATCH V14 2/5] i2c: tegra: add bus clear Master Support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <bc380ff9-48e2-d938-279b-4022c6862c66@gmail.com>
Date:   Thu, 7 Feb 2019 21:26:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
> +		reg = i2c_readl(i2c_dev, I2C_BUS_CLEAR_STATUS);
> +		if (!(reg & I2C_BC_STATUS)) {
> +			dev_err(i2c_dev->dev,
> +				"Un-recovered arbitration lost\n");

Minor nit: let's keep messages starting with the lowercase letter everywhere, for consistency

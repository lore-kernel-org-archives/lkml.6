Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DF7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41602086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckSGG9VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBGSYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:24:16 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42776 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:24:15 -0500
Received: by mail-lj1-f177.google.com with SMTP id l15-v6so704289lja.9;
        Thu, 07 Feb 2019 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/KV2WTA+D7mFN6hRPz/Jw2Hf+sVnSULcXNSh/eHozdg=;
        b=ckSGG9VYOBFwGAItU06Qr5w8qYtziOZS5j+qT7cKikzsekkKsl3lsZ/9nGcc31mvlP
         MxxAfNcsFMINHoQdysmDcbVXqUlZQl0PYVAvhz5s9HZqSPOlF8saQ2b2JsSQFRUTFrjo
         Jt1AAgfIQ1dGTEnoxfyN01Pe6Afr6Q2H0Zwp/MkjCV1lzGbQTod7zbTwjTa6llimZAf2
         PkeVlNmNicWCOnE1vVHAexFxy7tEx0tujZ50Xy/EKYMuEytnm2LFa+L8ptRGCiTFxufm
         rV9sWvDL6GCVV1/YYXmue2Q5ovtaMxF9P+a9I32eUxPKcAETTUqmOm1lGEJkN4tWBZnS
         TN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/KV2WTA+D7mFN6hRPz/Jw2Hf+sVnSULcXNSh/eHozdg=;
        b=SKctJCmtag3xGvuMidqQ54KMtZrfc9HkG+c5kwHwvl8ZywJQxGdc3+BmTTNuowK5C3
         KaPa+yN1JV1bO+6D+lfEKscqE9HL0b1jBQfb6qqun59IeKlhmLM2cFX/WyO6fRMfwlMj
         IdPpzIBIsu7wEEepkxJMhDV7NL26qw+4ViOhZYzpKiJetrfxh81lwMKLXTElRf48IQzl
         +bvcRMkzuDzUMdKmTaJeGLC7GYlU8x64AfjpwZQcDbpP0QGfwpcvrM962AwfS1n9Hzz1
         U0mZwhqgp9+r8GnDxoD45WLWRplTPTGOiSxBb3kkYcoQJpN+SIxY/rtiKy9GVMH+9Emt
         bf4g==
X-Gm-Message-State: AHQUAuYuVdXRdK2sj8KaSOxQ8/4xhhzSETW6WKFUL72t4LhLBwmg7xjE
        dlrgeYoIhWDyrt5qHb8Rn9efQxBy
X-Google-Smtp-Source: AHgI3Ias0w47YV3gQHI5YY9C1KVLOAjfuaxbJuq2QVZZKBKlsGVjG8Nz1GLEOjP3OSftKLn59jkk5A==
X-Received: by 2002:a2e:8893:: with SMTP id k19-v6mr240254lji.55.1549563852949;
        Thu, 07 Feb 2019 10:24:12 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id x24-v6sm4745246ljc.54.2019.02.07.10.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:24:12 -0800 (PST)
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5483b9d5-816f-3969-2d1e-9712d93dd0a6@gmail.com>
Date:   Thu, 7 Feb 2019 21:24:11 +0300
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

> +		if (i2c_dev->msg_read && i2c_dev->msg_err == I2C_ERR_NONE) {
> +			dma_sync_single_for_cpu(i2c_dev->dev,
> +						i2c_dev->dma_phys,
> +						xfer_size,
> +						DMA_FROM_DEVICE);
> +			memcpy(i2c_dev->msg_buf, i2c_dev->dma_buf,
> +			       msg->len);
> +		}
> +
> +		if (i2c_dev->msg_err != I2C_ERR_NONE) {
> +			dmaengine_synchronize(i2c_dev->msg_read ?
> +					      i2c_dev->rx_dma_chan :
> +					      i2c_dev->tx_dma_chan);
> +		}

Minor nit: parentheses are not really around the dmaengine_synchronize()

Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99ADC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69D20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DERTFpYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E69D20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeGZA4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:56:39 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38183 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731447AbeGZA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:56:39 -0400
Received: by mail-qt0-f195.google.com with SMTP id y19-v6so9466476qto.5;
        Wed, 25 Jul 2018 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nEvVcADHpiAg2OUTdEkjeUfDQlmgdPyL35NL5TnrHSo=;
        b=DERTFpYOg+3H3K/FkhgvYBlDuNM+dKX+CDlxRhLIR++BJx7QdCQGeUSpcvyzDLGYOf
         uVrPejqn0jZN5P7vHg+sFXC3wv/Zs7RLLy0VB/EdPNgbB73w3UBb0+3ZBDhv7qC+EFDt
         UEO7ZS2oig/mChUplIwvrMQA9RuB+wT/nQebXx1r9O6+chdXLHy4kztTXhjsgmf3aRov
         GbbJkPNC7ODG3py0C7v8MhHO9YHpeQl2fmuiFzaUyCX//vpUsM64I7Ip4TNoosYxrd6q
         simjaackAC6IYZY1Kg5rxj5HCdvft5u5KFQ/Bkch1eU87AghsdRZegfZ32bXnaquNEbR
         rF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nEvVcADHpiAg2OUTdEkjeUfDQlmgdPyL35NL5TnrHSo=;
        b=j7AAnR2dCRxlWy5jlqBFK3nKHIS+0f2FCPVd+1HefRuL0RxJXkaJ5s2KWcpBHAClCO
         YbhXkPYhoiaGP6mbRpaPZk2mjaNKcseYfr+84Ic95p5JPF0DDZtiyYKZP2vZSRRxPAsa
         kIUtn9GRGYux76+fiZbPT8P9Y4P/wCTMhxWPjebB/uxDVz3c7B3w/WtecURraCCgLnlH
         o9YPOQsQv25ZfnWtmDovAKgaS3gZYLgsO2GhYvF8mYqfK+GV/cjJZj//Ywz0loKBca8V
         qE0/Jjkqx3yPfMlOipNf/NBsFDqhnRY/GM6nif0+INURufPJjY+brQsghP01nUDUG4rQ
         iC7A==
X-Gm-Message-State: AOUpUlHAU3nZ3fA8x989PHY7UDxWstYBx+v75RXOjTM74vbr4BmohZPW
        1D/6cqL+A/SXVLhY5YeV9JAgqRMKatUXbQ==
X-Google-Smtp-Source: AAOMgpfEGFjjTyScYu19O8rk37zI0K4mBCujzg3ClT1h8G9K6a42yOm/vq0z9LPVFCDdQJcH9sj5+Q==
X-Received: by 2002:ac8:23ed:: with SMTP id r42-v6mr22334571qtr.392.1532562157393;
        Wed, 25 Jul 2018 16:42:37 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::1008? ([2601:153:601:7d2a::1008])
        by smtp.gmail.com with ESMTPSA id a17-v6sm11235214qkb.62.2018.07.25.16.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:42:36 -0700 (PDT)
Subject: Re: [PATCH] clk: tegra: probe deferral error reporting
To:     Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel@ziswiler.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
References: <20180720075422.26563-1-marcel@ziswiler.com>
 <153256109511.48062.12389268791907553857@swboyd.mtv.corp.google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <b202fe11-108f-c62c-bb6d-9e3a7de5a964@gmail.com>
Date:   Wed, 25 Jul 2018 19:42:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153256109511.48062.12389268791907553857@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2018 7:24 PM, Stephen Boyd wrote:
> Quoting Marcel Ziswiler (2018-07-20 00:54:22)
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Actually report the error code from devm_regulator_get() which may as
>> well just be a probe deferral.
>>
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> ---
>>
>>   drivers/clk/tegra/clk-dfll.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
>> index 48ee43734e05..b2123084e175 100644
>> --- a/drivers/clk/tegra/clk-dfll.c
>> +++ b/drivers/clk/tegra/clk-dfll.c
>> @@ -1609,8 +1609,9 @@ int tegra_dfll_register(struct platform_device *pdev,
>>   
>>          td->vdd_reg = devm_regulator_get(td->dev, "vdd-cpu");
>>          if (IS_ERR(td->vdd_reg)) {
>> -               dev_err(td->dev, "couldn't get vdd_cpu regulator\n");
>> -               return PTR_ERR(td->vdd_reg);
>> +               ret = PTR_ERR(td->vdd_reg);
>> +               dev_err(td->dev, "couldn't get vdd_cpu regulator: %d\n", ret);
> 
> Do you want to know that a probe defer is happening? Usually patches are
> sent to make that error path silent.
> 

Just asking as the newbie here, but shouldn't probe deferral be 
regulated to dev_debug?
Then pass any other error code as dev_err.

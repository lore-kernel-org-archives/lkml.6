Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD639C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D2C2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="obteummj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D2C2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbeKFCE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:04:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34713 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeKFCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:04:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so6791606wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nCQKjn/yVP4Uw6WHwBsolHOHoA8+hJGUlzwiIV5Dsds=;
        b=obteummjYH4ajGx9KlVtz1+X92UP5rECsNgtiM+5yLAUYMefQeL8qPW35hqLX/K+S3
         gy/7bGorrqpPlQhWOWqPloSdoCCS2Rh491Z8WV4yg3hlcc+xCLoTNrDWjR2kdU3yQYcZ
         nl87lQJaZzrNUslZKlEXskKiWQM9qvj1JV0ozJ/lfpUJo6+cF5Ga9+EVa7dLZdJK+klN
         sc0HdThAkoxxcws0qplVyv9+yWlWoFO5YuFXKQ9zNvCfGFegjFD/xTD/D7zw9H92NpaU
         6jljrEHzCgyLQypjU9ayEwqTjkxrR8YztI9d5WXssNNGh3pBncff7wqlkcUW84T2Z1ZZ
         Mr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nCQKjn/yVP4Uw6WHwBsolHOHoA8+hJGUlzwiIV5Dsds=;
        b=ps7QBRzI513kHRub7sbQ2ho0EZIiXYeHxWekWbgy+GFAFWQg8FJaUBIs09cugEsa7y
         9VEANcTDI1hucpSDl9IILt0gB1kGeYgkBulFfARkzGUprDM5dRIuEvSCf5h8xI23H6X4
         gkoxEFZlv+5hJP88UR5+/4rLTbzMFBzG4OHm/sUIcg/bjNNr2xqkP7PB9T4Ru+cNQPUm
         +mAKNzO5ESf07xMx2NM1TL8AWlo28N5GdTelma8Y3MQ/RRN745UQTVcX33QWl0cr7Q3+
         w432vlysNpfSLj605B07fRAIt+1QmlTYl5dBRCcAzTOuSQvbrcc/mMlJkpeVfXohWsiM
         VJVA==
X-Gm-Message-State: AGRZ1gJv4bT3JiXtwxAFe6bMz7g/v9uDvjwd+Lkk4IQnVGoNCDV0qFxH
        032lYzeZxEPCKj+HwtJjAkzYbqpAlTI=
X-Google-Smtp-Source: AJdET5ffftqMjs8kGEQevwKIYAYGfU47PLCgv44kes8/C+T/7onLpHj6AQtpREHblfVODKFdY2nAzA==
X-Received: by 2002:a1c:9182:: with SMTP id t124-v6mr6575297wmd.8.1541436263818;
        Mon, 05 Nov 2018 08:44:23 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l4-v6sm56771925wrb.92.2018.11.05.08.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 08:44:23 -0800 (PST)
Subject: Re: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
 <20181013160810.88481.14237@resonance>
 <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
 <8A3A1316-DC7F-4C5A-9DD8-C115EBB613BB@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT7CwHsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIXOwE0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAcLAXwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8g
Organization: Baylibre
Message-ID: <2fe1510e-13b0-cc3a-a079-e786c5c6beef@baylibre.com>
Date:   Mon, 5 Nov 2018 17:44:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8A3A1316-DC7F-4C5A-9DD8-C115EBB613BB@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2018 06:54, Christian Hewitt wrote:
> On 15 Oct 2018, at 9:07 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>
>> On Sat, 2018-10-13 at 18:08 +0200, Michael Turquette wrote:
>>> Quoting Christian Hewitt (2018-10-13 12:04:46)
>>>> On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
>>>> with reboot; e.g. a ~60 second delay between issuing reboot and the
>>>> board power cycling (and in some OS configurations reboot will fail
>>>> and require manual power cycling).
>>>>
>>>> Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
>>>> meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
>>>> Co-Processor seems to depend on FCLK_DIV3 being operational.
>>>>
>>>> Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
>>>> meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
>>>> bad commit. This added support for the missing clock gates before the
>>>> fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
>>>> disabled all the unused fixed dividers, thus it disabled a critical
>>>> clock path for the SCPI Co-Processor.
>>>>
>>>> This change simply sets the FCLK_DIV3 gate as critical to ensure
>>>> nothing can disable it.
>>>

[...]

>>
>> Christian, is Ok if I amend your patch, or do you prefer to post a v2 ?
>> Mike, with explained, is this change OK with you ?
> 
> I’m happy for you to amend, it’s easier for me.
> Christian

Gentle ping, could this go into 4.20 fixes ?

Thanks,
Neil

> 
>>>
>>> Regards,
>>> Mike
>>>
>>>>
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> ---
>>>> drivers/clk/meson/gxbb.c | 1 +
>>>> 1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
>>>> index 86d3ae5..4c8925d 100644
>>>> --- a/drivers/clk/meson/gxbb.c
>>>> +++ b/drivers/clk/meson/gxbb.c
>>>> @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
>>>>                .ops = &clk_fixed_factor_ops,
>>>>                .parent_names = (const char *[]){ "fixed_pll" },
>>>>                .num_parents = 1,
>>>> +               .flags = CLK_IS_CRITICAL,
>>>>        },
>>>> };
>>>>
>>>> -- 
>>>> 2.7.4
> 


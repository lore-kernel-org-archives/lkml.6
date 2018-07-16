Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C674CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC29208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rMkDupsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC29208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbeGPJok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:44:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45031 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeGPJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:44:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so31084166wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jm0pMCICfGDkDrbpUq3JceKtEkBwyxWrRXJb1H+Tegk=;
        b=rMkDupsvRpVhVMD5DSi1ZgskARkMSrLe6uPxgVAwqVkyrxq8MSt9rT2AI2ptSUr4U2
         GBufW0TRc0r5kNXiKB4TTvB9StjmSh3lR9zcbsj5tZSt05QTqGzTmWfq+Qn4hEMpfAiv
         kORSiOzPtixcYO/2d+McV7CNynIi+SrBZJfbAH81BxIGPt33nLcOHkS/DSoAwE7q6jNW
         /j467ORxE7qnvbaQSu0R96nbcn4v3qewmhn2W0PeTyspBrFMkyuDVSBEr02q0OYCHmdC
         bHqkPMaNA+KG9Ups6aBeX9m24AjSFWZOAdICuolaihKqFRPhUVMCbfNYVnul/8UI1x6e
         eY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Jm0pMCICfGDkDrbpUq3JceKtEkBwyxWrRXJb1H+Tegk=;
        b=WktOs5nYdsoVJPV3UBrcOZinS4WLACXLUjKk8z5+2fKxUgS/WAK4rbAcyFKDvvQnkC
         cMjn296tvNVUgLZ4QgBv6x+luyn6ydYCewSfc30PWeRHsy1Enj31PqW+IhTAXsb1CMI1
         uoqULJvypttJbV+kVkBtKzDoj3CsjRJgScPySIo4ephS2fblQgbXnwSR74gljngCEwCQ
         d/5UMmqBj7EgzgrkzmEZ0/oq+1BZ4QAT73P/p0RqGVAeFeCgtxO4L3xj8CSrphTW3Isi
         YRwzJHMGM3tDlDlH37JJ1lFVmjtqlRxMQHhDcQAml5B3GcO7dHkZvxWgutHriZUbI4F/
         sFcQ==
X-Gm-Message-State: AOUpUlE2G+zVBkHpPRggbuumrues8Sm3M2ZBrZnaUq4kp5xy/oEAjFkP
        h99hVUDTE5t37/C+ty27F36vXiiN0wY=
X-Google-Smtp-Source: AAOMgpfhu2xHBEo3YBI5gRk17IxvDafsLvUji8C1BkETV1LifI9ljsTENIehGxvu7OGpRQEAwVHHgQ==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr11170671wrp.161.1531732689542;
        Mon, 16 Jul 2018 02:18:09 -0700 (PDT)
Received: from [192.168.1.24] (AMarseille-156-1-200-251.w109-208.abo.wanadoo.fr. [109.208.203.251])
        by smtp.gmail.com with ESMTPSA id e7-v6sm6231878wrm.14.2018.07.16.02.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 02:18:08 -0700 (PDT)
Subject: Re: [PATCH RESEND] drm/meson: Make DMT timings parameters and pixel
 clock generic
To:     Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1531726814-14638-1-git-send-email-narmstrong@baylibre.com>
 <1531730163.12853.10.camel@baylibre.com>
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
Message-ID: <ca08e095-2e7b-58b8-e5cf-db44fe67280b@baylibre.com>
Date:   Mon, 16 Jul 2018 11:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531730163.12853.10.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2018 10:36, Jerome Brunet wrote:
> On Mon, 2018-07-16 at 09:40 +0200, Neil Armstrong wrote:
>> Remove the modes timings tables for DMT modes and calculate the HW
>> paremeters from the modes timings.
>>
>> Switch the DMT modes pixel clock calculation out of the static frequency
>> list to a generic calculation from a range of possible PLL dividers.
>>
>> This patch is an intermediate step towards usage of the Common Clock
>> Framwework for PLL setup, by reworking the code to have common
>> sel_pll() function called by the CEA (HDMI) freq setup and the generic
>> DMT frequencies setup, we should be able to simply call clk_set_rate()
>> on the PLL clock handle in a near future.
>>
>> The CEA (HDMI) and CVBS modes needs very specific clock paths that CCF will
>> never be able to determine by itself, so there is still some work to do for
>> a full handoff to CCF handling the clocks.
> 
> Patch seems to be a good step forward making the display compatible with CCF
> indeed. While full automatic handling through CCF might not possible, it would
> be good if, someday,  we could handle the SoC quirks in CCF, removing the need
> check is the SoC is gxbb, gxl or gxm while setting the clocks.
> 
> If the display driver needs a detailed control over the clock setup, maybe we
> could solve the problem by exporting the intermediate clock elements in CCF
> (such as muxes, ODs, etc...) and let the display driver claim them all ?
> 
> Anyway, the situation is improving so:
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 
>>
>> This setup permits setting non-CEA modes like :
>> - 1600x900-60Hz
>> - 1280x1024-75Hz
>> - 1280x1024-60Hz
>> - 1440x900-60Hz
>> - 1366x768-60Hz
>> - 1280x800-60Hz
>> - 1152x864-75Hz
>> - 1024x768-75Hz
>> - 1024x768-70Hz
>> - 1024x768-60Hz
>> - 832x624-75Hz
>> - 800x600-75Hz
>> - 800x600-72Hz
>> - 800x600-60Hz
>> - 640x480-75Hz
>> - 640x480-73Hz
>> - 640x480-67Hz
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c |  22 +-
>>  drivers/gpu/drm/meson/meson_vclk.c    | 672 +++++++++++++++-------------------
>>  drivers/gpu/drm/meson/meson_vclk.h    |   4 +
>>  drivers/gpu/drm/meson/meson_venc.c    | 377 +++----------------
>>  drivers/gpu/drm/meson/meson_venc.h    |   3 +-
>>  5 files changed, 358 insertions(+), 720 deletions(-)
>>
[...]


Applied to drm-misc-next with some trivial checkpatch fixes.


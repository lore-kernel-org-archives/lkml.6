Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AC7C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04DB208A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="APr2W/5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04DB208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934809AbeGDMi5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:38:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44161 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934796AbeGDMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:38:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id r16-v6so2054845wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lMIN8+ETMUSSh8nHSRHxrEIk8iImSIeG2ByfObIVfJk=;
        b=APr2W/5AFLWvfVY+/U79scRHw1aP/F2Blzgp+zj+KyFNGsMKgpTDmwkGesh/exbJfZ
         p3rOWFeYbppeMKt65o6GPa4hFOtvSyHyXUN9KJPQufUQilIlBGFvRt/Eb2fYOtXZaaPk
         NH29MgTLvEH43r1ZBjctjGhMVOfOEhRC5CxwTKR4+ERWol12a40L5W7fkQZcfXDjgHg3
         ZaErGvoYvw9qmIc11k8uOmvVMCFl/L2B0S0puj/amM/n3kCC6xB0eAjlnIpyURCNbPdv
         knZFDNRseZ2qMCbsKtGTSgdJmNmU2ZGZV4vxhPXF/WwKG3pvrJ9lU2vClpasqkrGuU08
         vX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lMIN8+ETMUSSh8nHSRHxrEIk8iImSIeG2ByfObIVfJk=;
        b=LDrZxlm8fPo3J8i12mexsRGj/Vr3ziLSiCUSpp3daXRKuME81tULpQbzqlcrzoB376
         2XptDrUHoQE4O1nmvMpgVV5I1ScxolohcyciuG2kRPIP/xkIgB5tP1ARv36ebtJ+lvg2
         QOemMjVU6Sx2xb5dwNUWyoRzKat8nbVziSzq2SxU2GlI3jSrSdX66yduV4E4t6Mp0MWL
         Js0f3HqRpcGsShf8HzI2dVgeShUtasILG+2V0ct59JOM03EQAQ9xon+f5wdDc7jOu57w
         E9ZWFbQgXvH6kCszaeRWgqBxpIaoOlGkJZZBgJ+XNXQg9QCMD9TCjINgkOVqWRn+T8QL
         A4YQ==
X-Gm-Message-State: APt69E1XPN4VWgsN6Cfv0hbFeNttJU+EmZBLwyGaUwRSj42BESXgDeMN
        bU9rOIZYP1RHJWt9cVISi3dEwQ==
X-Google-Smtp-Source: AAOMgpc0EeAE3GrtypQybF9qCyk/6C8s0Q6QHhp6mdJzTCTic8QSTc3Ly4AQOUZk8KrsId+KX69njA==
X-Received: by 2002:adf:8e49:: with SMTP id n67-v6mr1470756wrb.131.1530707926344;
        Wed, 04 Jul 2018 05:38:46 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r123-v6sm6629395wmb.21.2018.07.04.05.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 05:38:45 -0700 (PDT)
Subject: Re: [PATCH v7 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
To:     Lee Jones <lee.jones@linaro.org>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-6-git-send-email-narmstrong@baylibre.com>
 <20180704074717.GP20176@dell>
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
Message-ID: <eef093a4-55ea-fb59-97ee-408abeccc080@baylibre.com>
Date:   Wed, 4 Jul 2018 14:38:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704074717.GP20176@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 04/07/2018 09:47, Lee Jones wrote:
> On Fri, 01 Jun 2018, Neil Armstrong wrote:
> 
>> The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
>> when the CEC feature bit is present.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
>> ---
>>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 

Should I keep these Acked-for-MFD-by for the v8 ?

Neil

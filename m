Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D60DC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834322159D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1W+vZCmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834322159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeI1Siz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:38:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36888 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Siz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:38:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so6142380wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GY8L9ZTHrCCiMgiE/LIlWVU4ZINU3GWl56jg8Feu4Zw=;
        b=1W+vZCmqC61l+qb49QVc4G4MpPyQu19+ULWyhQ3nSj2DlZnZ5f/4P2+5gCdfRsp1cS
         DiE89nF3VsWySrxjX8oXpwFIOqd2KnLY89yyQYanIszAzlJ7UGhEpzGbQGXRX9xcnZYj
         CSAGdIl/uTO+forsTcYY/fxF8y8sbSFdRs1iz95Zfz5AWT8YYlrXy/JzBJE97o7n/1fr
         A/jTPZQKoreBvoD6g+W6pxkq1K0+k+KhIPf8Y72DiAchhRWOa5xjxGOnBeEktPpBKj8A
         4knS3gLGveDozhDWiuX0KJGRRZQ//vGNX/kuWrCAmnO0pKSA7InrpcyP3UyCWrlYX+Kp
         a7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GY8L9ZTHrCCiMgiE/LIlWVU4ZINU3GWl56jg8Feu4Zw=;
        b=tBGRljmCYmbYxnmCRafd/t8PSqXY3i1/QO6znzhgP1r1H8xuKjLSGUeFf1s3leN2gU
         bv4DXofz9xW/M62hGreRd7xcmhLOdBzHbY6ICvrUDfJ8AcjPI+IpIVsz93KK+eAYIfCZ
         dHPCmz5xwKIjdSf5S3xmn+eBWC6lC6RW93mk9yYpx4IvL42HtaWIRHq69unz3YO6l537
         I7q9Le2wejC1Tux8nbn0Yr/YZNz6ILUd2t/8uXrRhX4rDpLMZ8hQ8IPHJ5kBf8kusXA+
         2dDh/i56eulXSrDDng3++MljJf/cENGTvUTlaR4zS9qRD1pXWEZxGVPkOsPrM0rj3xlv
         8BTg==
X-Gm-Message-State: ABuFfojrygBA067+cJiwUZm8eJSwCaNuBCwRyNPiUnbdrmiDrU02KfEn
        czYbFWlEgDIJLQIbY4nkjMctNA==
X-Google-Smtp-Source: ACcGV61JiBPKGG6hxk4dJTg4blN6xHrkyPE3+5Qj8/OZ2PdlXQLvfvhMiaOp6Rda/DmLDOlCPpK5rQ==
X-Received: by 2002:a5d:6902:: with SMTP id t2-v6mr3965522wru.323.1538136923593;
        Fri, 28 Sep 2018 05:15:23 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6? ([2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6])
        by smtp.gmail.com with ESMTPSA id h71-v6sm1363361wmg.4.2018.09.28.05.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 05:15:22 -0700 (PDT)
Subject: Re: [PATCH] mfd: cros-ec: copy the whole event when msg->version is 0
To:     Emil Karlson <jekarlson@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        bleung@chromium.org, olof@lixom.net,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <20180927092427.507-1-jekarlson@gmail.com>
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
Message-ID: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
Date:   Fri, 28 Sep 2018 14:15:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927092427.507-1-jekarlson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 27/09/2018 11:24, Emil Karlson wrote:
> Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
> be truncated on many chromebooks so that Left and Right keys on Column 12 were
> always 0. This commit fixes the issue by restoring the old semantics when the
> protocol version is 0.

OK for me, can someone confirms it fixes the issue ??

Thanks,
Neil

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 398393ab5df8..457e4940dba4 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -519,8 +519,14 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
>  
>  	ret = cros_ec_cmd_xfer(ec_dev, msg);
>  	if (ret > 0) {
> +		unsigned int copy_size;
> +
>  		ec_dev->event_size = ret - 1;
> -		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
> +		if (!version)
> +			copy_size = sizeof(struct ec_response_get_next_event);
> +		else
> +			copy_size = ec_dev->event_size;
> +		memcpy(&ec_dev->event_data, msg->data, copy_size);
>  	}
>  
>  	return ret;
> 


Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1291C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC7E20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qdPdvpo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC7E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436885AbeKXBXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:23:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeKXBXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:23:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so12153128wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p2f763PCLZLS18RgGy9XXwamXl5nzJ/5rkjS8Fhqqzs=;
        b=qdPdvpo9+tU/wwt8UHaEg9t4/17vznNhx9/7xjE2zZQNBrPJo3zF8rakhIveUx3Sy9
         TOATlJyc9i495aLVoAIsS3QHfXx+Sp1nuMjSeu5Oe6/3Gu8yoVi8OjP/Cze5pz88rAJc
         8/EFeeJwDIhnzf12gCeDEaPAl6pWygkooDWarIBWt9rKHUHkskQjXz5hniFyoKZ0AuZ5
         +k5PXDPiMJb2wTI5CVfB51Rl56SXdw3L21IOSXfk867ayqlp0KyuixQUt4WpitLxJ7E7
         tvPI9EoWj4rxi+aRlDen3p3+dftqKoOXueTxY/OWujk6sDX7JrbckqH3CSKa6hZDTeJL
         MUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p2f763PCLZLS18RgGy9XXwamXl5nzJ/5rkjS8Fhqqzs=;
        b=HXcUmaFKeN4ieR/Kn4K89kjMiBpoFeBpqH2W2fc0lyV1otdz+Q/7J/T5jvoC6cLpFq
         QGq3VJ16XMDI2t8pjyKtds51C1zZzT9j6kPp5O0ZLxyUv3xD/cltSdY+AzQ21Rg0pIFH
         3GDcJHy9R062CRjHy94GoX0++xWozGWh53yJyoDIKwrTinYSeqT/0RmAzq9GvseseMxp
         BMg8I0fdF3KCUr+OVyUaVS214xWAL3fxmD3I5CZmBSr9LaDRFM2NfFMr6gax6nKXqoCG
         ekmYQWUEq8j33SuGIshgGo9HfAT0nfxXL6+HcuAx6q5PRONoTQVFrs49Mb4qallXLZmB
         1a3A==
X-Gm-Message-State: AGRZ1gJZtHbyPKvM2RJGyCzSChbmu1aaPAXH8SjQl0KYXvxHMEifE/CP
        cV6pc844qPwA1J/5MHD645bL8BbpPPrbJw==
X-Google-Smtp-Source: AJdET5cu7m+CeOaHSV4jhQi/bCjVTtywJbI73sgcuRez3Nyj9o8vZIPUcqlwupTOFBia33lCViBUQg==
X-Received: by 2002:a1c:5d4f:: with SMTP id r76-v6mr13954126wmb.25.1542983964047;
        Fri, 23 Nov 2018 06:39:24 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126-v6sm4758515wmo.3.2018.11.23.06.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 06:39:23 -0800 (PST)
Subject: Re: [PATCH RFC 1/8] drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling
 support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Huicong Xu <xhc@rock-chips.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
 <1880382.AeP59NOuia@avalon>
 <ca86b176-603b-8983-f6af-95e2bdce4aab@baylibre.com>
 <18593437.RcPPLLf6y1@avalon>
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
Message-ID: <931fd1f8-3c13-2d46-68ab-d375bffc2e53@baylibre.com>
Date:   Fri, 23 Nov 2018 15:39:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <18593437.RcPPLLf6y1@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2018 15:33, Laurent Pinchart wrote:
> Hi Neil,
> 
> On Friday, 23 November 2018 16:29:15 EET Neil Armstrong wrote:
>> On 23/11/2018 15:25, Laurent Pinchart wrote:
>>> On Friday, 23 November 2018 16:02:14 EET Neil Armstrong wrote:
>>>> Add support for SCDC Setup for TMDS Clock > 3.4GHz and enable TMDS
>>>> Scrambling when supported or mandatory.
>>>>
>>>> This patch also adds an helper to setup the control bit to support
>>>> the hight TMDS Bit Period/TMDS Clock-Period Ratio as required with
>>>
>>> s/hight/high/ ?
>>
>> Thanks for catching !
>>
>>>> TMDS Clock > 3.4GHz for HDMI2.0 3840x2160@60/50 modes.
>>>
>>> Why do you need a helper for this, is there no way it could be handled
>>> internally ?
>>
>> I could, but all the platforms would also do it internally... seems better
>> to have common helper, no ? And it will be usable by the PHY models handler
>> in the dw-hdmi driver aswell.
> 
> I meant internally in the dw-hdmi driver, not in the glue layer.

No since the spec says you must setup div40 support in the SCDC right before
enabling the TMDS stream and wait 100ms minimum, it would eventually work
from the dw-hdmi driver, but we cannot presume how the platforms PHYs are
setup.

> 
>>>> These changes were based on work done by Huicong Xu <xhc@rock-chips.com>
>>>> and Nickey Yang <nickey.yang@rock-chips.com> to support HDMI2.0 modes
>>>> on the Rockchip 4.4 BSP kernel at [1]
>>>>
>>>> [1] https://github.com/rockchip-linux/kernel/tree/release-4.4
>>>>
>>>> Cc: Nickey Yang <nickey.yang@rock-chips.com>
>>>> Cc: Huicong Xu <xhc@rock-chips.com>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++++++++++++--
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  1 +
>>>>  include/drm/bridge/dw_hdmi.h              |  1 +
>>>>  3 files changed, 44 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>>> 5971976284bf..523508af70b0 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> 
> [snip]
> 
>>>> @@ -1562,6 +1581,26 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>>>  		vsync_len /= 2;
>>>>  	}
>>>>
>>>> +	/* Scrambling Control */
>>>> +	if (hdmi_info->scdc.supported) {
>>>> +		if (vmode->mpixelclock > 340000000 ||
>>>> +		    hdmi_info->scdc.scrambling.low_rates) {
>>>> +			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
>>>> +				       &bytes);
>>>> +			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
>>>> +					bytes);
>>>
>>> Shouldn't the source version be min(sink version, highest supported source
>>> version) ?
>>
>> How should the "highest supported source version" be defined ?
> 
> That's the highest version supported by the DW HDMI TX controller, and is an 
> intrinsic property of the IP core. With the above code, a sink newer than the 
> DW HDMI TX will incorrectly be told that the source supports the same version 
> as the sink.

You are right, we could be ourselves on the already-know dw-hdmi IP version we know
to determine a currently known max version for the current platforms using dw-hdmi.

> 
>>>> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
>>>> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
>>>> +				    HDMI_MC_SWRSTZ);
>>>> +			hdmi_writeb(hdmi, 1, HDMI_FC_SCRAMBLER_CTRL);
>>>> +		} else {
>>>> +			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
>>>> +			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
>>>> +				    HDMI_MC_SWRSTZ);
>>>> +			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
>>>> +		}
>>>> +	}
>>>> +
>>>>  	/* Set up horizontal active pixel width */
>>>>  	hdmi_writeb(hdmi, mode->hdisplay >> 8, HDMI_FC_INHACTV1);
>>>>  	hdmi_writeb(hdmi, mode->hdisplay, HDMI_FC_INHACTV0);
> 
> [snip]
> 


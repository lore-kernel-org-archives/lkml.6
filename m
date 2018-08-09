Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67682C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B15721A38
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EoTt+U2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B15721A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeHIKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:17:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53273 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:17:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id s9-v6so5364337wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aDu1BRBbRkHxdODTabtBZS6ibNT6zNfR4rjlqTvYhog=;
        b=EoTt+U2UvsYKHc56EQw1VeZAIsE82AH5KORjoBX55mWBNxcGoaXUb54QJFsOGuR2kj
         ZhPVOPCKYoA9Nw9w2IMK0AHDPJFuh8QCGhT0reL1dORtPcBCQJJV6XpvFeuRY8HKuNdM
         5nK25GetWv4NIdNgt9N8kcPR/PMQgoNkmWrrbFEGrQq5/sEu/tOoWlhM8GNUDmxxTHNf
         FHcyxOm9mfjcfl65+kDAH0D/lf2YL31DtSCJ96FRNL3HFBhZM3SLZWbfeaKoVPfnLMru
         lsM6dnD5W2GRTvxutrBGKU6h5cguoAl9uIN1CiBma83Ng1ofXLECdfUlCcmlVitb1cTV
         dbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aDu1BRBbRkHxdODTabtBZS6ibNT6zNfR4rjlqTvYhog=;
        b=de8EAuOZU0BoQQQ1nZPfl0beil1IRKaMhIiLibmdOgJIFswjBB7dEtzATlGvgzVnt4
         XSxrKBH9SDOwQCjohaQ5o5OKRQU0UOjV8O5XW0ZeRkrP1OSFzVFxi4O2lPprGqyAJGIS
         ZMxm/TMhc7q0VHsw1tCOBwcc9S/KMpdnCIpvKPu1f15RijRSjSAloWtkqIA6/3HHF5QH
         e7l6WUzHFlA1YgbXuvbPW7aIXrz/auR9bmpwvILLHt+Bqh4+HeXfxymisktNS1iM0dBd
         XvcmLEwM3PDxwBIo+NOQzJ5LKAYHQWx39ycx5UhrgnjvQPShkaaRNO2lDKYH8BmGLes/
         UcEA==
X-Gm-Message-State: AOUpUlGHK57RQ2SOiltIzQ2Sfc7HlsPecP4v7sP4TJI2NgmQCaFPTeXH
        FT8MWvxGEcR6oa9TDB2qtlV04JCZvhI=
X-Google-Smtp-Source: AA+uWPwdDQaQBAoEyOGa1kdmGVV5/hJg6BR1rioBEreKcmrTvc/bSVizpVKfWFBoCumhu6aUXEMgtA==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr901747wmm.117.1533801203211;
        Thu, 09 Aug 2018 00:53:23 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w17-v6sm4752051wmc.43.2018.08.09.00.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 00:53:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-4-maxi.jourdan@wanadoo.fr>
 <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
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
Message-ID: <fcbfff13-aec5-c571-3a5e-a3d571505342@baylibre.com>
Date:   Thu, 9 Aug 2018 09:53:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 10:41, Jerome Brunet wrote:
> On Wed, 2018-08-08 at 00:00 +0200, Maxime Jourdan wrote:
>> Wrap the canvas node in a syscon node.
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index b8dc4dbb391b..c98198662ae2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -423,6 +423,23 @@
>>  			};
>>  		};
>>  
>> +		dmcbus: bus@c8838000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xc8838000 0x0 0x1000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
>> +
>> +			sysctrl_DMC: system-controller@0 {
>> +				compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
>> +				reg = <0x0 0x0 0x0 0x1000>;
>> +
>> +				canvas: canvas-provider@0 {
>> +					compatible = "amlogic,canvas";
> 
> If there is only one canvas provider under "sysctrl_DMC" and it has no reg
> property , you should not put a unit-address (@0) here. (same for the
> documentation patch)
> 
> You may have seen unit-address without a reg property used elsewhere (ASoC
> simple-card, my recent axg-sound-card), when there is multiple node with the
> same node-name (ex: dai-link).
> 
> As Martin pointed out, the DT spec says we should not use unit-address unless
> there is a reg property. We did not get Rob's view on this and we might have to
> update this later on. In your case, unless I missed something, you should
> definitely not have it
> 
> nitpick regarding the node-name (canvas-provider). If appropriate, we should try
> to stick to one of the generic names proposed in the spec. I wonder if the
> canvas provider could be viewed as a "memory" or "memory-controller"

It's not really a memory or memory-controller, it's a Lookup Table on top of the memory controller,
nothing really matches here...

> 
> So, what about this ? Just a proposition, feel free to comment ;)
> 
> 	sysctrl_DMC: system-controller@0 {							compatib
> le = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";> 		reg =
> <0x0 0x0 0x0 0x1000>;
> 	
> 		canvas: memory-controller {
> 			compatible = "amlogic,canvas";
> 		}
> 
> [...]
> 
> 
>> +				};
>> +			};
>> +		};
>> +
>>  		hiubus: bus@c883c000 {
>>  			compatible = "simple-bus";
>>  			reg = <0x0 0xc883c000 0x0 0x2000>;
> 
> 


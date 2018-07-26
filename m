Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91EEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4095A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cMLW4Tu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4095A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeGZQID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:08:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56111 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:08:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so2260288wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=98yui5HTt+k57W08+BnB7kUieIt/Lw5Uf4Oq0ly47G4=;
        b=cMLW4Tu++rOKLhBiVfPf1Bzd2TLbgxGt1DIt70vo4oDPAZycW/GoNwjIQ5ogTaFx8F
         kw0uv/9LLlxtkHRVWMPM6OlZX2gXhsH8vbFWcQUwN6r+52RCDSxHvKcrNhlbZZm0df9A
         mE5xiQWI/YXBOkadKwC+z9rQc6TKA1WRmlsuUJ0xpEj1wkcuI85tPcU3+LhshE7CcgzT
         IK/aOHkPj8gOFLq3jlbcvMp3EsXZRSbfMa4LaRM4TM4UzTn62BIrQctD1JVXILGUiQ9z
         iomQOVWF0jjG1ujD2rxV4BXsWN79wofmXIPJcvAYSKaXnjlFWVOoVjBpIILsdzOAtx0m
         Sy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=98yui5HTt+k57W08+BnB7kUieIt/Lw5Uf4Oq0ly47G4=;
        b=e582KHjFylKAkkwn7ZlajKzquqJZCqMLS5iqxKpxymLTkOf6cdsfQE9RRYEc5hjwY6
         /hcegOj7n/5QEQ/kWDpyQMNcPNWDif2HSf6zBxkBU5QclYI27jHAezvx2N/PZlYA+0CH
         AKBG+K7P2XGrrPSyguvwwiDH531vmfL6rBiv3qIEhHfHxotslj3x2K00m2aY1NgG8Vx6
         7HTfKJMEeQyg3NyFva9KJin4CksAJeS+QSmXttrR3mHKPaXQ1cAIIeknMFxW8oduyluC
         sRDPMisoI35waHoURrhy8fUKBFR+jXTXIUNnmDjHEJrsP2NjJQA86x46aUC6H5lZB8Gb
         E0jQ==
X-Gm-Message-State: AOUpUlENA6e0GOMe2AfzaG5DtqluLnNG+OBrnNo6Fnm7zoh3PTiWT8xQ
        hHN4GE5M6fsqovF6jPn430UHzQ==
X-Google-Smtp-Source: AAOMgpdprz3y5dPAFqD2QtCBeMGjhVkSIY028FoZaupvUqbnOtPCAUuM6MxomZmQlzhrrzSiT6fHvA==
X-Received: by 2002:a1c:5c7:: with SMTP id 190-v6mr1842106wmf.24.1532616648251;
        Thu, 26 Jul 2018 07:50:48 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r5-v6sm1232800wmc.39.2018.07.26.07.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 07:50:47 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
To:     Yixun Lan <yixun.lan@amlogic.com>, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
 <494ff778-1888-7743-3a91-62364431d82e@amlogic.com>
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
Message-ID: <c1d08bc7-b868-7781-e69a-0e6bacde5b40@baylibre.com>
Date:   Thu, 26 Jul 2018 16:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <494ff778-1888-7743-3a91-62364431d82e@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/07/2018 16:41, Yixun Lan wrote:
> HI Neil
> 
> On 07/26/2018 10:13 PM, Neil Armstrong wrote:
>> The order between "syscon" and "simple-mfd" is important because in these
>> particular cases, the node needs to be first a "simple-mfd" to expose
>> it's sub-nodes, and later on a "syscon" to permit other nodes to access
>> this register space through the "syscon" mechanism.
>>
> 
> could you explain a bit which specific case that it need compatible
> "simple-mfd" come first? is this a problem in kernel side? because I see
> you have a comment below about problem in U-Boot..

It's not a problem for Linux, but Linux is just an implementation, the device tree
should work on multiple OSs like U-Boot or BSD kernels. We should base ourselves on
the bindings documentation and the Device tree specification to specify the HW.

In this case, we need to switch the order to specify it correctly.

> 
> 
> also while Rob review the mmc-clkc patch, he raise a suggestion to  drop
> "syscon" in drivers/mfd/syscon.c, see [1], will that solve or affect
> your problem?

Rob wants us to drop the "syscon" because he wants us to move all nodes
depending of HHI as subnode, which is impossible for HDMI and the VPU power controller,
they are only "syscon" clients, their own registers are not in HHI.

Neil

> 
> [1]
> https://lkml.kernel.org/r/CAL_Jsq+r+7BaJAPBn3L26sdxATVyDiuC=V3xE+yz0-27q0RJhA@mail.gmail.com
> 
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> This also has a consequence for U-Boot since the U-Boot DM is much simpler
>> and can only associate a single device to a node, thus here we want these
>> nodes to be an mfd bus to be able to probe the sub-nodes.
>>
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> index 6adc8d3..3f0de9d 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>> @@ -342,7 +342,7 @@
>>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>>  
>>  			sysctrl: system-controller@0 {
>> -				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
>> +				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
>>  				reg = <0 0 0 0x400>;
>>  
>>  				clkc: clock-controller {
>> @@ -1180,7 +1180,7 @@
>>  			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
>>  
>>  			sysctrl_AO: sys-ctrl@0 {
>> -				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
>> +				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
>>  				reg =  <0x0 0x0 0x0 0x100>;
>>  
>>  				clkc_AO: clock-controller {
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index b8dc4db..d88699f 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -344,7 +344,7 @@
>>  			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
>>  
>>  			sysctrl_AO: sys-ctrl@0 {
>> -				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
>> +				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
>>  				reg =  <0x0 0x0 0x0 0x100>;
>>  
>>  				pwrc_vpu: power-controller-vpu {
>> @@ -431,7 +431,7 @@
>>  			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
>>  
>>  			sysctrl: system-controller@0 {
>> -				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
>> +				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
>>  				reg = <0 0 0 0x400>;
>>  			};
>>  
>>
> 


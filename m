Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06DEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA62205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pm3fBSit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA62205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJPQV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:21:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbeJPQV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:21:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id 63-v6so24362465wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5MQAaKzcDPyT2hhv8KY13H50I3oEKelqMvKMaGa+Ad4=;
        b=pm3fBSit7pGqrP2ixEFijaZLBO/S2VIpQokai6P8P+IJMxzERrCLMTEh0TmijPDD8k
         THstDvhR8h9maIZFLjIU7lwIFncY7Df2J1jHb/hyIouk9Vajx7ZoffVbz41ExyxGJEFu
         y0KFYyugMzpkN82DHP0BN1mdW8mbA5hq7s1fR4csPMf6YD3CPRHSnBI0MaA5wcRGR5be
         pE5KBeFzqWu7AYO6srLVqDoMgfRyBN79G+A637XIw8YoUS/Afpi7afmNdyAenU1Tc729
         sP9bgwOfXfmzSHBEmtA2k5lDrvMmpztTarozkeOLUyC+v5nAUw3a3av+klc3GytGXvki
         2ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5MQAaKzcDPyT2hhv8KY13H50I3oEKelqMvKMaGa+Ad4=;
        b=fhVQc/RvKOeeZqcMjP3a8sd6AWfeG9pJU6Bx3EMx6OtXeVM34EOpjOpAACfKYlKFVy
         fnH+j4K9n1jR9ijpDMqC1rX8Yw1Mdlata6hUVYn+ej2uT7Nrr3ABO/GnQOPAeR+LRhcZ
         aF1T+xW+/kvoHE/YDMM1B0uArdamDyOBPbrTpSQVFn7va0uWdafjK2YURh5gQhPCZosA
         k1dU06k4KU6gmB22X39mfSDOpV/R0opfoqQsXv2s6Q9qQLwa5tw/woqkOSaRWx9UNSJd
         YAoeIIcbyT2mAqP6gZur5eqgidGhnlBuNAKibqmdSfbAlx615PK7C9r6eO5i/GGuGWVy
         +l0Q==
X-Gm-Message-State: ABuFfohoKIRSXWn1uXjUNT4Kz/Wvt7L4F+mlppZDGXF86bb9JVXZvpDb
        9UQl4i4Z6O0jF3B6YeFQVADvZg==
X-Google-Smtp-Source: ACcGV63gtVAAOu/raskbON0tIcNpS94ECllGzOiYQ/skDjEiJ16jUNOU5hIqaqCo/ovo65rrGMEIDQ==
X-Received: by 2002:adf:cf0b:: with SMTP id o11-v6mr17546770wrj.272.1539678231994;
        Tue, 16 Oct 2018 01:23:51 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a1-v6sm10684645wrt.79.2018.10.16.01.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 01:23:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
To:     Mark Rutland <mark.rutland@arm.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20181015162833.7544-1-jbrunet@baylibre.com>
 <20181015162833.7544-2-jbrunet@baylibre.com>
 <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
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
Message-ID: <06a189c5-d5b0-d5cd-d3b2-e2ed21721aeb@baylibre.com>
Date:   Tue, 16 Oct 2018 10:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 15/10/2018 18:42, Mark Rutland wrote:
> On Mon, Oct 15, 2018 at 06:28:32PM +0200, Jerome Brunet wrote:
>> Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via /proc/iomem")
>> was merged Amlogic's boards using mainline u-boot started showing the
>> following warning:
>>
>> WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_reserved_regions+0xd8/0x144
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-dirty #254
>> pstate: 40000005 (nZcv daif -PAN -UAO)
>> pc : reserve_memblock_reserved_regions+0xd8/0x144
>> lr : reserve_memblock_reserved_regions+0xd0/0x144
>> [...]
>>
>> This is due to u-boot setting some /reservedmem/ region while our
>> dts declares reserved memory on the same region with no-map.
>>
>> The conflict produce the warning. This is fixed by using /reservedmem/
>> in our dts as well, which is probably something we should have done from
>> the beginning.
> 
> A /memreserve/ does not ensure no-map, and the kernel will map regions
> which are described in a memory node and only protected with a
> /memreserve/ entry.
> 
> Is it safe for the kernel to map these? e.g. speculative fetches won't
> trigger a TrustZone controller to reboot the system?
> 
> ... or are they not in memory nodes to begin with?

Do you ask if these memory zones are protected by an Hardware Protection on the AXI bus
instead of simply protected by the ARM TZ MMU entries ?

In the later case, a speculative fetch won't fail, is that right ?
These zones are mapped on the DDR, and seems to be simply protected by the MMU
from the ATF code, there are other HW protected RAM zones we haven't modeled.

BTW Can the Cortex-A53 do speculative fetches ? I thought no.

Neil

> 
> Thanks,
> Mark.
> 
>>
>> Cc: stable@vger.kernel.org
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>
>> Hi Kevin,
>>
>> I would have liked to put a Fixes tag above but I could not figure out
>> which commit to pick, considering how much we changed those regions in
>> the past. If you have suggestion, I'll be happy to repost this patch.
>> If you prefer, feel free to amend this patch directly.
>>
>> Cheers
>> Jerome
>>
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 24 +++++--------------
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
>>  2 files changed, 15 insertions(+), 36 deletions(-)
>>
[...]

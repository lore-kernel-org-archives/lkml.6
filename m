Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC08C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44E20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JC2je59J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C44E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392988AbeKVTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:04:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44059 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392975AbeKVTEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:04:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so4015431wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0a3PJe+Xp1fjyWlLiiMfPFDIl+AthNJzaFJFpLvZI+g=;
        b=JC2je59Jd4fFS6yx18noC7fvs73KTxzVByaHLTZXi+45nKbimoxrRazc1At1o8RnqT
         be9PD4PSyHznBzwuJMV308r0MLbZAEPDIpzcbkHcXMhzmbD0fytWycSC7hDKZPeyQrZV
         NsxVlFeQ+EYJr690NU03VocNjYjeWM8uv5tzbG2fYCiej8QMpp5ipX30/Nl6ZTpdFGkk
         BKeJ4HN4swF3lAgKp6MTUH2/2qMlf11fubJlfwUelMGKwbN+fJ1vkI0M6n+x0kTuas0l
         +GBKsaRk9EiCTyP9F2mFtYUsln9q9jImWm4NHpoV6ccBk4qnEWCGwCPON5pLe+Yzp4i7
         zlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0a3PJe+Xp1fjyWlLiiMfPFDIl+AthNJzaFJFpLvZI+g=;
        b=CTlNAo4ksypbaf3ExuQeUQngyBMpY26DMvlboE0ckWbIwYb76JkxI3BV8anTv+k0jg
         yI25Hj//lUBFBGxjN6PWHDBHPmh7r79t/vXOcHvQfDDeDlwntyWrwe3RSeLOQM8vYwgQ
         eQmY/P1MPUx1kCiRgX+1XgPzwvmQHnw6eaFU4CftzXWvQiV18LpLJjmtaQkD4lkyFTjE
         QWE8C2iuf234SQWTI320iEkSbSsvpw8TZqev+tcROxtIhML4M/2sOaSmjxnF9zDMPHye
         dBCIPN8Kluw8lXE85p2MHiKremMyizGfahg4i+8e0EeUyiWJX6N07W/GLkXtwpWF5b1/
         MoJw==
X-Gm-Message-State: AA+aEWZqRbnK0IdSiLxYipaYcY86V21I5HqaJQWdnweuDIDhUjWVesGL
        oocnVWIc99gY7ngY3CE6veczFQ==
X-Google-Smtp-Source: AFSGD/WohQypV+etcQJ8LFJLG8SyRopv8DI+zBmQy7TRaFbdAlpXUEj4oSiBWSZQm1T2CyQ85amlGg==
X-Received: by 2002:adf:d112:: with SMTP id a18mr9143396wri.17.1542875183005;
        Thu, 22 Nov 2018 00:26:23 -0800 (PST)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m66sm3210248wmd.15.2018.11.22.00.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 00:26:22 -0800 (PST)
Subject: Re: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181121111922.1277-1-narmstrong@baylibre.com>
 <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com>
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
Message-ID: <5e87ffda-4a38-f45b-00c4-6b73dc721656@baylibre.com>
Date:   Thu, 22 Nov 2018 09:26:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 21/11/2018 22:53, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Wed, Nov 21, 2018 at 12:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The GXL Documentation specifies 12 bits for the Fractional bit field,
>> bit the last bits have a different purpose that we cannot handle right
>> now, so update the bitwidth to have correct fractional calculations.
> I assume you have more accurate documentation than what's available publicly:
> - the S805 datasheet doesn't have any documentation for this register at all
> - the S905 datasheet states that HHI_HDMI_PLL_CNTL2[11:0] are DIV_FRAC
> - the S905X and S912 datasheets state that SDMNC_POWER is at
> HHI_HDMI_PLL_CNTL2[6:0], SDMNC_ULMS is at HHI_HDMI_PLL_CNTL2[9:7] and
> SSC_DEP_SEL is at HHI_HDMI_PLL_CNTL2[13:10]
> - the S905X and S912 datasheets state that HHI_HDMI_PLL_CNTL1[11:0] are DIV_FRAC

On S905, the HHI_HDMI_PLL_CNTL2 is at address 0xc9 << 2, but on S905X/S905D/S912 the
equivalent register at same address is named HHI_HDMI_PLL_CNTL1.

They changed the numbering of registers between these 2 SoCs, but the register
content and addresses are similar for m/n/frac/reset.

> 
> can you confirm that the public S905X and S912 documentation is wrong
> and that the .frac field is really part of HHI_HDMI_PLL_CNTL2 instead
> of HHI_HDMI_PLL_CNTL1?

Is is part of HHI_HDMI_PLL_CNTL1 but at address of S905 HHI_HDMI_PLL_CNTL2.

When jerome pushed the PLL support earlier, he added a comment.
I simply forgot to put it back when I added back the GXL HDMI PLL DCO.

Neil

> 
> 
> Regards
> Martin
> 


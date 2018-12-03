Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE3C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8157720851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kI7eFcq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8157720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLCKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:11:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36087 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:11:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so11463023wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mvaKlhv8OlNGQazGyVnaJD/NLE9F36VZF3LvCNtcvNo=;
        b=kI7eFcq7k83mU2Dx2T97v/UCxJUvaKSL7ZjlS6wUqH70c6PDSpyFkK8TMv2WEHbdOx
         VmBp6G7yMYq8aXzhf/s6gnF1GDlnxYNRqKDXBtmzS62PrNPENGfIRyGoukU4kRZR+jx/
         R2bBPk6NNP+z157O4dsESnHFjubEzBfYFDwo1pxIE7tY4hIy7Q89VqBHv810GaLF7RX2
         iul9PNjbQx00UvxOznKAGuaNN7Aqmjs+YB4eXVTY+uE91ClvFjbwRHvZkcDzVRaac5LX
         00MRm/OR0O8y4bQiNcbDZNThUapz2k8bHtphLRueNjBsgcGByto6bXbjsqyxGV88VS/G
         xqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mvaKlhv8OlNGQazGyVnaJD/NLE9F36VZF3LvCNtcvNo=;
        b=d2bCHauPNgDXdgUuK0hksu8bzMOa38EQbe7SOE1+1WN56WAK9RGuRQXlASQNhGYiXz
         34+iGvlLzQpOTFp1DwU2a/d5s2AqyBtrgauOcY0KkNumrjykmhCW7wK9qJLZJVArzz8+
         Ngr1hOala2N4Z1Ood3zBKREp7GUVH2VE6z/3lZyHXGX0eD3tznemxvmP9j47W9nEvc3k
         MZynQ5QHPRt3Un5K4yZYafEatmMCAShVIcncrmHeaIVq44bvgJe+Ih1hkGTTxsFZ3Tph
         T23Fx39y+580dsz7yZoiB8Kp+t3P6HUdIrYXNJHEeDjbPRnNxn/ODCB41TLt5TI9zyiB
         CZhw==
X-Gm-Message-State: AA+aEWZkSt5VwXrXWgubr2GgiSgmECPdIpjJXhPFB1ygMaupoQV1dKq3
        Z+VrsPUEqJtfCoDAj3bEiWsavYz2YF7Iow==
X-Google-Smtp-Source: AFSGD/UaQ3ggxqXbSsQWy9L+9V25bMT1uWvPNDVNpsnk/j/u2ENGNXih0qWqMuDnDPeVydP24MAdVg==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr13036672wrq.69.1543831858905;
        Mon, 03 Dec 2018 02:10:58 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u204sm5346968wmu.30.2018.12.03.02.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:10:58 -0800 (PST)
Subject: Re: [PATCH v2] drm/meson: Fix an Alpha Primary Plane bug on Meson
 GXL/GXM SoCs
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181128100734.6536-1-narmstrong@baylibre.com>
 <CAMO6nawdGnr2nPvsZGT4WcnuetdvN=-e7j0SNWbCRvDBFw8GJw@mail.gmail.com>
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
Message-ID: <2f948a4a-5a9e-529f-0810-a4ddc3387b15@baylibre.com>
Date:   Mon, 3 Dec 2018 11:10:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMO6nawdGnr2nPvsZGT4WcnuetdvN=-e7j0SNWbCRvDBFw8GJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 10:04, Maxime Jourdan wrote:
> Hi Neil,
> On Wed, Nov 28, 2018 at 11:07 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On the Amlogic GXL & GXM SoCs, a bug occurs on the primary plane when
>> alpha is used where the alpha is not aligned with the pixel content.
>>
>> The woraround Amlogic implemented is to reset the OSD1 plane hardware
>> block each time the plane is (re)enabled, solving the issue.
>>
> 
> typo: woraround -> workaround

I'll fix when applying !

> 
>> In the reset, we still need to save the content of 2 registers which
>> depends on the status of the plane, in addition to reload the scaler
>> conversion matrix at the same time.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>> Changes since v1 at [1]:
>> - Fix flickering and shaking by moving reset when plane is disabled
>>
>> [1] https://patchwork.freedesktop.org/patch/263550/
>>
>>  drivers/gpu/drm/meson/meson_plane.c | 12 ++++++++++++
>>  drivers/gpu/drm/meson/meson_viu.c   | 27 +++++++++++++++++++++++++++
>>  drivers/gpu/drm/meson/meson_viu.h   |  1 +
>>  3 files changed, 40 insertions(+)
>>
> 
> I can confirm the fix works on GXL (aml-s905x-cc), tested with
> LibreElec, 1080p resolution.
> 
> Anything using alpha on the primary plane used to be randomly
> "shifted" with black patches, and this was particularly visible with
> subtitles.
> 
> Things seem OK now. Thanks!
> 
> Tested-by: Maxime Jourdan <mjourdan@baylibre.com>
> Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
> 

Thanks,

Applied on drm-misc-next

Neil

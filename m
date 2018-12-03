Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E52C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DE62147C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IrTMr2qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DE62147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLCKvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:51:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLCKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:51:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so11587599wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PpJXPEBKm0YV7zWjZGCDQm3zabwlJCEUsGi4KlSMAkQ=;
        b=IrTMr2qzzQyg5LuhiaNjRlSxCD5NtLTVO3Pt6CVMk1Joz9tVX6FDFsiQX5mtB8EvtI
         txS8CiiI5386/lBFzk03TNfnizkvn80m4fPgn+NqdbpvEAYLiuCZn+arFQgwe74PLtji
         e12gK8csMJn3yk6J2K9JETgQXAFoPq4q3SCtkNZ93c9OP0KjCdiJtvu8kldsj4rGnekf
         UtcXHm1cxQ+nNcvf/47ckLVy/iCBO6v9CazU9nhahcgj3heYXQoIxMpvSp4ee9Mb+NFp
         Yu69jczTckD82ZROLyOvGqvy3eyGHhydycCYnhN1St0ed+m78vGJ1pnmzfGbZmNgziOm
         6kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PpJXPEBKm0YV7zWjZGCDQm3zabwlJCEUsGi4KlSMAkQ=;
        b=awAZEGNaNDoMVshCka4gaaikU4DhJZBROydijWcwgW2vVjcEyFOhLOT1Yj3wzpQID/
         gp0APDEGPirkK+friXy6+2YOOGnrxXaT/UFGNyiaFsSfNVuHXJIg89a+NQUBl6UvViQz
         uJv7vz8Yyk1OvDL5oZ6SglRQxKzfP2jgJX2pF1qz2kjdgkWn4POUzK+leNl0q+YgGgxv
         Tb307qfAxD4xQIUmtzuqDJJpMIcPqoSUWS2/V702IATeU6NAzMblwu5SZLiZAJfRpwi/
         92dM8toIOmtrjja3qiUTCREjDAPah6CtAYHO7ZpDCVvnrFhdSGf6B+/BmnwdlGd1Si7N
         MFYw==
X-Gm-Message-State: AA+aEWa9ndDdLHyGrS0MI5iQ5C4m6Q3yF+0RS9htad2xPN4fR1dQTqah
        DTruBL8fSiTyLQcTWni51IcHbw==
X-Google-Smtp-Source: AFSGD/VJLZG7gcXeociyEgZjIjXppPPBqbbfWpXxr9QJTcRERYQerUIETedTQcNWph4gVXQTq7Yp3w==
X-Received: by 2002:adf:ef88:: with SMTP id d8mr13510970wro.163.1543834279625;
        Mon, 03 Dec 2018 02:51:19 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q185sm7198774wmg.14.2018.12.03.02.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:51:18 -0800 (PST)
Subject: Re: [PATCH 0/3] - clk: meson8b: add the (read-only) video clock trees
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
 <d52679a197a46fa19fb44c446c52fd286ad639f2.camel@baylibre.com>
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
Message-ID: <913fbbd7-88a3-b6a8-74d3-4687ea62bcdd@baylibre.com>
Date:   Mon, 3 Dec 2018 11:51:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d52679a197a46fa19fb44c446c52fd286ad639f2.camel@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 10:42, Jerome Brunet wrote:
> On Sun, 2018-12-02 at 22:42 +0100, Martin Blumenstingl wrote:
>> Martin Blumenstingl (3):
>>   - clk: meson: meson8b: fix the offset of -- vid_pll_dco's N value
>>   - clk: meson: meson8b: add the fractional divider for -- vid_pll_dco
>>   - clk: meson: meson8b: add the read-only video clock trees
>>
>>  drivers/clk/meson/meson8b.c | 746 +++++++++++++++++++++++++++++++++++-
>>  drivers/clk/meson/meson8b.h |  54 ++-
>>  2 files changed, 789 insertions(+), 11 deletions(-)
> 
> Looks good to me
> 
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> 

Same,

Applied to next-drivers !

I'll be great when we finally have video support on Meson8/Meson8b !

Neil

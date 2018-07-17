Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBFCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EEB2147E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vXFHaELe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37EEB2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeGQMCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:02:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35880 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbeGQMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:02:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so1166678wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=95+E1ruZi8LuVoZSlghIFXZ84/SiSmGwcNL168Usn4Y=;
        b=vXFHaELeSKv3Mf30gem+nxPkiARfdzVfe6v3NL1z42jExNzHWe0/wgDSzYHYBLOK0v
         B85mC4uGRR85ArFQcYeHG6WYKwqJZD8MjAg/fzgsHD4gPLzUPoQWlpgKe5HgQhSxGwUe
         S4Chf1pYzQ4WaQmHpQm2wHztPXpZ9k4MKzZnOZVQG6Knid4XLehEhWOfrbMsdh+x3u6k
         9jyIZMJziqW0IqRNqVy7CIKHhS6GuzI5BFP9DdGqkFJotF6jIo/BSn5wG5cpVPn2oq1+
         kOa3isLDEL+SWELg0J9Ckqjoi59f+uAqLlFArleu7lgDJE9t9E4rNgrt/ftLar3+SNHV
         mlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=95+E1ruZi8LuVoZSlghIFXZ84/SiSmGwcNL168Usn4Y=;
        b=dK1vyZ8RnJyMjuvsbes0tdVA3yDPNALZeETsZlVY/ivHrz2qyaFxnRYJ0CIeNwxGnm
         BzkkHxfjkbfiJo6J3pXg+9CeRuIbuukwxZK88o4CTK/S/xHRPROba37fFqUS89XDCOzt
         XoUsLk+Q3v7faeOf/jtG1WqBI+ceKryXuUiNYEtMfE95CHsdjwOkZRllU63bC24IrM0I
         WZueObmNJsgIC+BtfDWXaDNNkZcTFkiH4Bf6Qcd1CrDE5K+5CojptpmYGk1eENuwYmOk
         torMh3LcjwcvDa3k98ud4nmXzz4VB0Ok5XwTYeGB8qTWlQgOfLhHXKB7B/gRQ9XGoCEB
         UW6A==
X-Gm-Message-State: AOUpUlH81d0ERByNDV1+PtsB3Y1KU6VvtlVxmJlWgBHEXdSgsS/J+ckx
        Yl2rMrLND8AwtHPFGYJDJ34OIA==
X-Google-Smtp-Source: AAOMgpeeTQ3XVSpXLSB6imfVLX0JveHtQ9TZ4+xI/Qv0ouglKnzWslsg5Ge93qdhtebq/Rzis7+U4w==
X-Received: by 2002:a1c:d1c1:: with SMTP id i184-v6mr1085261wmg.111.1531827041308;
        Tue, 17 Jul 2018 04:30:41 -0700 (PDT)
Received: from [192.168.2.33] (138.51-251-89.rdns.acropolistelecom.net. [89.251.51.138])
        by smtp.gmail.com with ESMTPSA id d14-v6sm1003643wrr.12.2018.07.17.04.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 04:30:40 -0700 (PDT)
Subject: Re: [PATCH 2/3] dt-bindings: amlogic: Add Internal Clock Measurer
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1530624110-4687-1-git-send-email-narmstrong@baylibre.com>
 <1530624110-4687-3-git-send-email-narmstrong@baylibre.com>
 <20180716214516.GA31738@rob-hp-laptop>
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
Message-ID: <964512dd-fddb-4919-446a-96db7cc22a8b@baylibre.com>
Date:   Tue, 17 Jul 2018 13:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716214516.GA31738@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 16/07/2018 23:45, Rob Herring wrote:
> On Tue, Jul 03, 2018 at 03:21:49PM +0200, Neil Armstrong wrote:
>> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
>> clock paths frequencies.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../devicetree/bindings/soc/amlogic/clk-measure.txt       | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>> new file mode 100644
>> index 0000000..ba9183a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
>> @@ -0,0 +1,15 @@
>> +Amlogic Internal Clock Measurer
>> +===============================
>> +
>> +The Amlogic SoCs contains an IP to measure the internal clocks.
>> +The precision is multiple of MHz, useful to debug the clock states.
> 
> What a simple yet useful debug tool.
> 
>> +
>> +Required properties:
>> +- compatible: Shall contain "amlogic,meson-gx-clk-measure"
>> +- reg: base address and size of the Clock Measurer register space.
>> +
>> +Example:
>> +	clock-measure@8758 {
>> +		compatible = "amlogic,meson-gx-clk-measure";
>> +		reg = <0x0 0x8758 0x0 0x10>;
> 
> This doesn't really look like its own block though. Can't the parent 
> device instantiate the driver for this?

As weird as it seems, on the GX family the registers are not on a aligned boundary, but yes it's its own block.
On newer SoCs, they have a more aligned register address, with the exact same register set.

Neil

> 
> 
>> +	};
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


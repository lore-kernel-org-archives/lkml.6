Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1976AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52FF2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0Kr2Wxja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52FF2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbeKGB7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:59:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38509 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389278AbeKGB7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:59:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so14257386wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tbm0gcZ8RP7u0a+FCInwKrRH/5B40I3Ox+03Raq8YwE=;
        b=0Kr2Wxja7KN8n6CEXmjgQ+Qi+hEABJLxLZz4HyMv0PXmv9dOdvb0sot6qJsGNcaJX8
         Ag4Fwr70PZfdUuEoo3Xfi51SXfjNZyONUwH4X1EO8KXh0FHyGaG4YMqAbF19SSoc5I3m
         4waUXC3hHHJZPRc5esRkRkfbnh3GdmqsZdvNF45BqnhdLI6Wi2wg71NR/NWj5qPKV4Ic
         aGxqVTx7x39ikdGofY3Eyq9HTnIL72fWhsoTlSGOZm3PgJnq/x6nXORDE9d0PB7Ox907
         fdIuegpUnBw/giXyzHy1FRzqNQw7FDbFvR22vz7ewdyzY5wZfe2FsU3zlNlZhXDtv3bR
         4+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tbm0gcZ8RP7u0a+FCInwKrRH/5B40I3Ox+03Raq8YwE=;
        b=IpBkIiwmtmshaE+xsQ4KkuG4lzAWylPdW3YbrkB688ItX4lFfSHk7CQOHW96VRvPby
         tPKkL2wbh8Q3lGDVjNwXBdB01MSsiaeavkH8KKmMTL8H6Xhx9uNcaUSl9jihENh1xXyC
         SdTwNlYfsE3NjXcefd9j3EBe2Tim4Ou2LgHXLmuxE+9+vQlERbXzGDMwC6LsVve6XpYP
         2r0ff5j+vT8foliYbksJC+6Q+fXK2AiuNLQTeEkSuavNjQYy3ALvqtanzqu0s+CGOZUJ
         0Xet4DOQf9o0iYmm6E3mrZd/ohmqwyvmDmfGm/ELBkQ11seJWE1FxcxxlSFGZAPbDXMf
         aAsA==
X-Gm-Message-State: AGRZ1gIkEYsHdoss7xrc2mD8ik8dA1/FvxC+Z/YrxJ2pPeQR/OAuYj49
        f6Jmyju9FhNFIR4bAMv/8APuwQ==
X-Google-Smtp-Source: AJdET5fWr+iRCfCM9VSfTBQ/Pl/38pxn/MnbtBr4TC/jC6HlZI5XWa81DOWoiIbjbVjO/5djtNnDHQ==
X-Received: by 2002:adf:9387:: with SMTP id 7-v6mr22843448wrp.269.1541521990842;
        Tue, 06 Nov 2018 08:33:10 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l5-v6sm21843277wrv.84.2018.11.06.08.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 08:33:10 -0800 (PST)
Subject: Re: [PATCH v4 0/3] Add Amlogic video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20181106075926.19269-1-mjourdan@baylibre.com>
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
Message-ID: <d248b541-d9f4-a4fc-2b9a-cd8eac377fb0@baylibre.com>
Date:   Tue, 6 Nov 2018 17:33:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181106075926.19269-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:59, Maxime Jourdan wrote:
> Hi everyone,
> 
> This patch series adds support for the Amlogic video decoder,
> as well as the corresponding dt bindings for GXBB/GXL/GXM chips.
> 
> It features decoding for the following formats:
> - MPEG 1
> - MPEG 2
> 
> The following formats will be added in future patches:
> - MJPEG
> - MPEG 4 (incl. Xvid, H.263)
> - H.264
> - HEVC (incl. 10-bit)
> 
> The following formats' development has still not started, but they are
> supported by the hardware:
> - VC1
> - VP9
> 
> The code was made in such a way to allow easy inclusion of those formats
> in the future.
> 
> The decoder is single instance.
> 
> Files:
>  - vdec.c handles the V4L2 M2M logic
>  - esparser.c manages the hardware bitstream parser
>  - vdec_helpers.c provides helpers to DONE the dst buffers as well as
>  various common code used by the codecs
>  - vdec_1.c manages the VDEC_1 block of the vdec IP
>  - codec_mpeg12.c enables decoding for MPEG 1/2.
>  - vdec_platform.c links codec units with vdec units
>  (e.g vdec_1 with codec_mpeg12) and lists all the available
>  src/dst formats and requirements (max width/height, etc.),
>  per compatible chip.
> 
> Firmwares are necessary to run the vdec. They can currently be found at:
> https://github.com/chewitt/meson-firmware
> There is an ongoing effort to bring those firmwares to linux-firmware
> but they're not in yet, currently blocked by licensing issues.
> 
> It was tested primarily with ffmpeg's v4l2-m2m implementation. For instance:
> $ ffmpeg -c:v mpeg2_v4l2m2m -i sample_mpeg2.mkv -f null -

Testing on Linux 4.20-rc1 with the proper DT patches using :
- gstreamer 1.10.4 V4L2 Video Decoder support from gst-plugins-good
- v4l2-compliance

Tested-by: Neil Armstrong <narmstrong@baylibre.com>

> 
> The v4l2-compliance results are available below the patch diff.
> 

[...]

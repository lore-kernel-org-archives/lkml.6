Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FDC2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AbKiYC+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FDC2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbeKMXat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:30:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40165 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:30:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so4153702wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 05:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yY9/Ss7eBqgchUcpCR92og7pAuXJd89ke1WzaDEatWU=;
        b=AbKiYC+TNEfUf00Jq4dnY0NiyyE8KU/MxVE03JIrxW5+q/yDdAeM8/0vlJmAHUUTox
         T0A6G6g8M1pphiTl91woSMY5Z+Uo2P7CNKZXZEsUWrMLuQItzRZSQrGEUdDC0PCmmIzh
         fLIbWASr5XQaturg5B8hyRCpfzbHWbfllYr3nzyzt4PJ3gpZMpaO5tTYDPrfUXzaBWnd
         6mrX0Y6vbWTTufsmkPyxFwbEbJfQQcHlROxCfMq/22BORb4tYNaWAq1vNld1QgqIKGoN
         8LzYJFTdJskrfW1qwC/ZzA7yiX5lU3dGwkzhG91Ad+QtuKLaoGcVeU26Wu1YxWj8bEje
         On7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yY9/Ss7eBqgchUcpCR92og7pAuXJd89ke1WzaDEatWU=;
        b=sKdb+Z3VtGnqPHslHQtshYWyGKaiBMw0nKRALOA92neQCLcSdduAmXvkLZoiF8O+DM
         0aY3WbRXdl7wWvbYnN9G+UZ/qOjNbdH//kYX+3rBAKrraifqL+yImqSYQu3YveKyDSL9
         OiXVf9FS0fXXYiaVHyMVsZ+sSVkyxDRAvmsTI80+so23y/AocVhePhcH+h3bTfrQ9hFO
         Uean0DIP9mcd9/vYiVFjDfVxSQMK/SOfoTr0GrFzLB/Yjv0d762QJAMC3siKouT580dK
         XKPwj9tkoIa7m5SkPepIs9hzUIV36GcKqhKZI+9ENcHM5OHFbnXVr4CMVrFiiDLB76Oj
         s9iA==
X-Gm-Message-State: AGRZ1gLi5+1hDWHlFM4djLrRd0uZAQWHTSrYVSbKZmSrdRtQioJtxnbP
        uLDIGRIFhtireqv6M3WZUkL/og==
X-Google-Smtp-Source: AJdET5cIBkLTmonlA7ODmoT+X6/0X8byrrs6jSb2NEPMLWCms9ie9OtXDDCTLzGxkgf7xOuD9UTpOQ==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr4779405wrp.219.1542115958262;
        Tue, 13 Nov 2018 05:32:38 -0800 (PST)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z18-v6sm16148062wru.83.2018.11.13.05.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 05:32:37 -0800 (PST)
Subject: Re: [PATCH 0/2] drm/meson: Allow using optional canvas provider
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20181105104508.23090-1-mjourdan@baylibre.com>
 <1a3d3b7a-5050-7b4c-bda6-8ef532403d01@baylibre.com>
 <CAMO6nax_Q4kbDkeBmYQezo9dpMztD4DMFh+1dewax4p6d_S7mw@mail.gmail.com>
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
Message-ID: <ec49e7c1-8ca6-b442-10dc-1f15a15917bc@baylibre.com>
Date:   Tue, 13 Nov 2018 14:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMO6nax_Q4kbDkeBmYQezo9dpMztD4DMFh+1dewax4p6d_S7mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 15:02, Maxime Jourdan wrote:
> Hi Neil,
> 
> On Mon, Nov 5, 2018 at 1:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Maxime,
>>
>> On 05/11/2018 11:45, Maxime Jourdan wrote:
>>> The meson DRM driver currently uses constant, static canvas indexes.
>>>
>>> This is not optimal and could conflict with other drivers also using
>>> canvases.
>>
>> Indeed, it's now time to use the canvas provider merged in 4.20-rc1 !
>>
>>>
>>> This patch series allows the driver to optionnally use a canvas provider
>>> module that is able to dispatch canvases, on demand and free of conflict.
>>>
>>> In the future, the current way of doing things will be deprecated.
>>
>> Do you confirm you will send a patch to remove the legacy canvas code when
>> everything is merged (including DT changes) ?
>>
>> I'll wait until the bindings are reviewed, then I'll push the serie to drm-misc-next.
>>
> 
> Yes, ultimately it will be removed.
> 
> The plan is:
> 
> 4.21: allow using both modes, add the "amlogic,canvas" property to the dts files
> 4.22: remove the old way and change the amlogic,canvas property to mandatory
> 
> This should allow for a nice transition.
> 
> Maxime
> 
>> Thanks,
>> Neil
>>
>>>
>>> Maxime Jourdan (2):
>>>   dt-bindings: display: amlogic, meson-vpu: Add optional canvas provider
>>>     node
>>>   drm/meson: Use optional canvas provider
>>>
>>>  .../bindings/display/amlogic,meson-vpu.txt    |  2 +
>>>  drivers/gpu/drm/meson/Kconfig                 |  1 +
>>>  drivers/gpu/drm/meson/meson_crtc.c            | 14 ++++--
>>>  drivers/gpu/drm/meson/meson_drv.c             | 46 ++++++++++++-------
>>>  drivers/gpu/drm/meson/meson_drv.h             |  4 ++
>>>  drivers/gpu/drm/meson/meson_plane.c           |  8 +++-
>>>  6 files changed, 53 insertions(+), 22 deletions(-)
>>>

Applied

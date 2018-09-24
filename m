Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBACECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622B52098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m2z4cYeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622B52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeIYBLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:11:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35305 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729023AbeIYBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:11:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id o18-v6so11184283wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9tO1OxNRZEW2K309hw9cqNAiL4Xe9Gj7Z3SHCzwLQjk=;
        b=m2z4cYeUtwdhURzszsG79NMjSi91laP3HVB1hKU/Grp8/jN9fR+O7a+dSEt+0exX3e
         R1ayozJlvbxIW5vc16Fz5UMmLXatvlq2wx+0yYXJSEdJHFEvbCNtZZe4Acl33UzCuL+F
         jK4M0e1/XQGVFYQs9Lwir6Y3i3Cf/A51Grl0pBZq7RlzicH4QtaBGbhfJ/Kr90pqN+jW
         XCVJcqMLnmSi0ch/HAnxmeFvxbGJeHV7JaOVEd2JHgwfUJ7pVbyq6x9ktH2BosieH05y
         MSYfVcw3FskWogth6mBo7ZbMJ80sXEugU4IvRR1jfwIrVQYMhPtNQVKm9ZJl5JKUmxML
         dV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9tO1OxNRZEW2K309hw9cqNAiL4Xe9Gj7Z3SHCzwLQjk=;
        b=VCxOXORAShtTcbLGjsYmxS81uIxxESZVmwg8sxIh0lc5DO8QGBt+zJ36Zt9j3ms8aE
         Q9CIuHFnnfh70PPzN5rEabjdXN0c8tssLaocxw7nXB3C1wrYU+4/dhBT1oPB4fFJTTfC
         sWs01g/Iq0MkckslseyZZtKgBghIG9PaXKG486fIOS8vD3bG/2W+GNVXoSLo57GF9PL5
         39ZlgEuKlz6j5ZUffd/lLdvAcyzEfgomhQMVmOkFbIh8OvMuDomZmjfFziOA9Vr1r5um
         Jd6c7+qTxlR7CMQyPjvuvtmttqiAr0AK0wyIMVoHo5ALRkK2SlCSUR32xbdNYqqYPsQK
         qh2w==
X-Gm-Message-State: APzg51DlTb6VCOfzrdvWD40aNvMTNvWq2NpXM8n2g6WM+FzI/0xMYZMu
        relNU1lUDr8CS9JOROE0FHYoL8AN4w0=
X-Google-Smtp-Source: ACcGV60AUkpw26cgCFME9c4F2FjKhVV592pOA5aLuhDUCl2T+cAZel1iNxt/H0GFAKoFWlw0QqEmtA==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203-v6mr8360725wma.73.1537816056434;
        Mon, 24 Sep 2018 12:07:36 -0700 (PDT)
Received: from ?IPv6:2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6? ([2a01:cb1d:4ce:ea00:6c78:1f23:6bb3:14f6])
        by smtp.gmail.com with ESMTPSA id h73-v6sm37704178wma.11.2018.09.24.12.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:07:35 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] drm: meson: use xxxsetbits32
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        oss@buserror.net, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
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
Message-ID: <9925d909-5f50-499d-744d-f59170e8899a@baylibre.com>
Date:   Mon, 24 Sep 2018 21:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-7-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corentin,

On 24/09/2018 21:04, Corentin Labbe wrote:
> This patch convert meson DRM driver to use all xxxsetbits32 functions.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c      | 14 ++++---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c   | 33 +++++++++--------
>  drivers/gpu/drm/meson/meson_plane.c     | 13 ++++---
>  drivers/gpu/drm/meson/meson_registers.h |  3 --
>  drivers/gpu/drm/meson/meson_venc.c      | 13 ++++---
>  drivers/gpu/drm/meson/meson_venc_cvbs.c |  4 +-
>  drivers/gpu/drm/meson/meson_viu.c       | 65 +++++++++++++++++----------------
>  drivers/gpu/drm/meson/meson_vpp.c       | 22 +++++------
>  8 files changed, 86 insertions(+), 81 deletions(-)
> 
[...]

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>

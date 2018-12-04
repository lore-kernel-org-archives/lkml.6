Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E12C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186820851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0raXW8j4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D186820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLDNAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:00:38 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:41315 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeLDNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:00:38 -0500
Received: by mail-wr1-f49.google.com with SMTP id x10so15854039wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 05:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QSJl7gsFJLjy81PeOFY/dQLvqX9V9lTfZQjpfvMgY/0=;
        b=0raXW8j4/tMqfZQ/4XXrBOvA+j3CU5tNDqP03yWrAJxvM2LzhSACmT8ZYx62Puh9Sp
         w6dfjZyglgET4ecYc3FVwGwaVcUFWo/vg9+sDVSUBz3uvs5E0sgjsoB6f1+jBZlaeXrc
         8zlI6sqZnjg/1MKGa9gUC751yUugHC7a68zy42exXFjMMRw9V0HpXcPcWNMJoDZUCPRk
         zWh+hye3KkU8L/MiGTcQ50TcsoXhvt4ZB0PINrtXhzippS/EL+FTAQ7/VEiaQpTJVCsC
         HDW2UqIqpMA/Ydi7LbZGwvZjX/GyhkyRGn20Fs4KKPSC6EK5Pa48hNIIbb/JAGo4vsqj
         6YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QSJl7gsFJLjy81PeOFY/dQLvqX9V9lTfZQjpfvMgY/0=;
        b=TLhKz+fKW4D7Qg0zBmf+p109y+tLiejR1X/msY0xqLhJUcE7RVwMWHpHrPWoxpBHVR
         LwhWUCQy2addS5XMbAxmtxMRQ1JOlc+dJ2sc1NeXxlni2OALz3QEcdB1K8ZI1/tFU9Vr
         9PJh3Z0fm3SGwYp1qfN6Gj79YI3t+s3dG8cBjd8SolIDF8K3EJs8bfLewkbuFhvKHEEO
         rOmy7x0OWKqDNGUWBQMTjYUcHfU+S6EeTAsQTSgCGv5LVdYT7curByPxaL/VSUdH9Q3j
         BVIx5oKmPNpb+jSePnfUjOJeEq5GO60H+nB0aGDv/1NMAuubc2A0As9eKXoVGk6xhWMM
         wzgA==
X-Gm-Message-State: AA+aEWZrbiP4N/q49ogJkxpkoLWCb7etwUdLjfPcF28xWf1OklH2DOF2
        VB/9eyTONW9vAFcK8iSZxd2b/g==
X-Google-Smtp-Source: AFSGD/U/F0ep5VyIZxEdtAEPyoKD9Db9EmKCDXMng6peCHtRXZG6SllJl4X4JaREXMZwBsOWCOp64A==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr17150462wru.270.1543928436434;
        Tue, 04 Dec 2018 05:00:36 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n8sm15498953wrw.59.2018.12.04.05.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 05:00:35 -0800 (PST)
Subject: Re: [PATCH -next] drm/fb-helper: Fix typo in parameter description
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1543905135-35293-1-git-send-email-weiyongjun1@huawei.com>
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
Message-ID: <1a361bb9-6ccd-7042-56b9-562f2437d496@baylibre.com>
Date:   Tue, 4 Dec 2018 14:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543905135-35293-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 04/12/2018 07:32, Wei Yongjun wrote:
> Fix typo in parameter description.
> 
> Fixes: 4be9bd10e22d ("drm/fb_helper: Allow leaking fbdev smem_start")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/drm_fb_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 9a69ad7..f90d596 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -71,7 +71,7 @@
>  #if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
>  static bool drm_leak_fbdev_smem = false;
>  module_param_unsafe(drm_leak_fbdev_smem, bool, 0600);
> -MODULE_PARM_DESC(fbdev_emulation,
> +MODULE_PARM_DESC(drm_leak_fbdev_smem,
>  		 "Allow unsafe leaking fbdev physical smem address [default=false]");
>  #endif
> 
> 
> 

Food catch !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applying to drm-misc-fixes

Neil

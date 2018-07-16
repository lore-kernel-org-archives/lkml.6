Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17AECDFB4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6668E208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1c9itRP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6668E208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeGPIEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35942 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbeGPIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so30794068wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NKVl5/dfUUjD8D6v1yU5DkP4sZOIsXUJunNZ7FkybOA=;
        b=1c9itRP9EU0xj4HVUZYtGGNBSt13Q28uIy6hT3KuEVQ6L/LOZ8AgFeJKfc7BJce4s/
         hI2k5Db5umk3+bvCfrqAt2N/NdywxjB5g9dqDRYCnzRB/KyfiOTLMgZaMi4jMqp6oi2Q
         ZtSil1LsxAz8gwOhpwKNGibs1hHdTNmj57Q7PRM4pQaLo2/4S8Y+LvT3sMS3IQgNXqtO
         sEFjr72BqQjAINlMeOJGg6jamHJFYIQaKHgmjXpz58FXXGZWP2ECwla0+oOfSTSkJcKo
         C6uXcjXLppQThumerrUatHwkf9bCtSFaNED26RH/S76CzMzGiYHA78lt6rcXyh2W/fXe
         OwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NKVl5/dfUUjD8D6v1yU5DkP4sZOIsXUJunNZ7FkybOA=;
        b=U/x7WS4/uWl6/QxnuZyaz7LmDP60tPj4RaQ41QxQKI0Bgx8Tnkvl+4PPEwB1WX9ArI
         yO6RM8fNf+7v/+kbA1wc3htDWpDpW4fqSt2IN4sf1elavKq5VWE2AY98e6YjQBqsIYqR
         mi0WJWnLypQOMltUMRNo2y7UTcXorPsRhT0uHKqzrd8uaULGRCJuSjcJ6rFYo2OZw5kb
         N/dSwYcEWVvq08a4/XRbCOgvIw2Ez+mggrjWVb+4s3YVG4YyMWZHlbdcoYiCVjqmhrE7
         ohl8q9LpQ5iJ/TrUWZe5d7hcPRwVYbtzkMYrsswi+0KwnpRfTCVs4doF28+aDZR6gN57
         AG0g==
X-Gm-Message-State: AOUpUlF02IngPsaKvhCGnnUjrkFk4yh5fiCZn/0RWNwnRKYmqupveybE
        6+3X+Rk57Gb6MpMOCGAm9ZiZCg==
X-Google-Smtp-Source: AAOMgpd/U3L8BXGEU6ZDyFFaM+YJ0zjesrZp61nlVUmjpAs1e1HkzCV7boDH263Oftp+BJNHBI6sbw==
X-Received: by 2002:adf:adae:: with SMTP id w43-v6mr11860075wrc.251.1531726688935;
        Mon, 16 Jul 2018 00:38:08 -0700 (PDT)
Received: from [192.168.1.24] (AMarseille-156-1-200-251.w109-208.abo.wanadoo.fr. [109.208.203.251])
        by smtp.gmail.com with ESMTPSA id u3-v6sm19930030wre.21.2018.07.16.00.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 00:38:08 -0700 (PDT)
Subject: Re: [GIT PULL] Immutable branch between MFD and DRM/i915, Media and
 Platform due for the v4.19 merge window
To:     airlied@linux.ie, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, hans.verkuil@cisco.com,
        olof@lixom.net, seanpaul@google.com, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
 <20180713074620.GW4641@dell>
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
Message-ID: <274ecbb8-7fa7-b706-6572-cb32f379001b@baylibre.com>
Date:   Mon, 16 Jul 2018 09:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713074620.GW4641@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Rodrigo.

On 13/07/2018 09:46, Lee Jones wrote:
> Enjoy!
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-i915-media-platform-v4.19
> 
> for you to fetch changes up to cd70de2d356ee692477276bd5d6bc88c71a48733:
> 
>   media: platform: Add ChromeOS EC CEC driver (2018-07-13 08:44:46 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and DRM/i915, Media and Platform due for the v4.19 merge window


This PR is here to solve a complex interdependency over this patchset,
Hans agreed all the media patches go to the MFD tree and Rodrigo acked the i915
patch so it could be applied to another tree,
but who is suposed to take this PR to the DRM tree ?

Neil

> 
> ----------------------------------------------------------------
> Neil Armstrong (6):
>       media: cec-notifier: Get notifier by device and connector name
>       drm/i915: hdmi: add CEC notifier to intel_hdmi
>       mfd: cros-ec: Increase maximum mkbp event size
>       mfd: cros-ec: Introduce CEC commands and events definitions.
>       mfd: cros_ec_dev: Add CEC sub-device registration
>       media: platform: Add ChromeOS EC CEC driver
> 
>  drivers/gpu/drm/i915/Kconfig                     |   1 +
>  drivers/gpu/drm/i915/intel_display.h             |  24 ++
>  drivers/gpu/drm/i915/intel_drv.h                 |   2 +
>  drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
>  drivers/media/cec/cec-notifier.c                 |  11 +-
>  drivers/media/platform/Kconfig                   |  11 +
>  drivers/media/platform/Makefile                  |   2 +
>  drivers/media/platform/cros-ec-cec/Makefile      |   1 +
>  drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
>  drivers/mfd/cros_ec_dev.c                        |  16 ++
>  drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
>  include/linux/mfd/cros_ec.h                      |   2 +-
>  include/linux/mfd/cros_ec_commands.h             |  97 +++++++
>  include/media/cec-notifier.h                     |  27 +-
>  14 files changed, 578 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
>  create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> 


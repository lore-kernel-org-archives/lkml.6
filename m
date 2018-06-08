Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1nNxKp46GlvDJAAAmS7hNA
	; Fri, 08 Jun 2018 08:17:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6B067607E4; Fri,  8 Jun 2018 08:17:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lFDuBYYc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A2927606FA;
	Fri,  8 Jun 2018 08:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2927606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeFHIRd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:17:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53106 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeFHIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:17:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so1782027wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bCwA8+vOM11p7Qs3Tmb22/nVPCf0Yza6lcHKivwfdoE=;
        b=lFDuBYYcmsWakdj2GOLHw9r4UPlY8s6aIu2tf5hy5tn3yxkuMDPYBcOl9a1KP4SBDx
         m1bdbqkbNsgA0wcmPngpE/gShcMZQm7xsfqDYeOzIHOzvbCNZYBkj5g+YNpmOX0+N5w5
         ZOFXfJ6weht/ZYvY+jPcLHoCoNPgzLJr6gtz+OXNyL5gcUqUvxo6JDSsoFhFKlryEGi+
         mvCWPpTq8k/xjAWLasRp83gLG6d1tcitK5doX6spAI/BsoIl+ody87k/cNqpP7vSeoG0
         wv05Zx91UNwGx4nQRZCq4kzJj6dz0C44pu+cYGLGP3XdJ+iExqnhltfkeHEQKuUz59ud
         5edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bCwA8+vOM11p7Qs3Tmb22/nVPCf0Yza6lcHKivwfdoE=;
        b=P5tG5RDWAPx32iF6EHqpR0erbI2fdVWDNJdtRTStFvWt3skNtQC3rYzd8lyL69Tn6G
         WEiqWyTCrKVb+0kGptNYuzPermBG1Kw9cg2k8EEbCSKZ18dQyHzNIIx0umbXRcfy2j31
         LKCZ66nGojDSHJP83YdFgoDMoUHyMc1tsgU7Ff/rDCkQsMv78rc/mzD9bTSbKu29yBPS
         KdqbxmWiKUUTpxhW1eKjJXU3Mx4um8oJOFH9M4XgewPgDYEy2bpC38tQCDqs1EYuQUGl
         Qj+cZzWgKB96AZuPHFPpoPOxLiR88b0if5JHqUDd3XIBlTTDb3QZPUqal2xohtyM8bvN
         p7uA==
X-Gm-Message-State: APt69E1WsfEiQATL/9diOtZMaOZKYAph+sn8ihoMYtdFtvP5suovkk59
        W5L5qL/eJZVBK4Fwi5T4cCO23Q==
X-Google-Smtp-Source: ADUXVKLM+CJ9RYrdyLDPa+IjmVWKwCRTojAWWHizQ1X/H90BFpt0LBD3/BCJ7qM8p4pgSa3th4Uxtg==
X-Received: by 2002:a1c:5c93:: with SMTP id q141-v6mr778949wmb.77.1528445845881;
        Fri, 08 Jun 2018 01:17:25 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g75-v6sm1341756wmd.15.2018.06.08.01.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 01:17:24 -0700 (PDT)
Subject: Re: [PATCH v7 0/6] Add ChromeOS EC CEC Support
To: Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
From: Neil Armstrong <narmstrong@baylibre.com>
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
Message-ID: <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
Date: Fri, 8 Jun 2018 10:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 08/06/2018 09:53, Hans Verkuil wrote:
> On 06/01/2018 10:19 AM, Neil Armstrong wrote:
>> Hi All,
>>
>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
>> with it and get the CEC Physical Address from the correct HDMI Connector, the
>> following must be added/changed:
>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
>> - Add the CEC related commands and events definitions into the EC MFD driver
>> - Add a way to get a CEC notifier with it's (optional) connector name
>> - Add the CEC notifier to the i915 HDMI driver
>> - Add the proper ChromeOS EC CEC Driver
>>
>> The CEC notifier with the connector name is the tricky point, since even on
>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
>> connectors from the same DRM driver. The solution I implemented is pretty
>> simple and only adds an optional connector name to eventually distinguish
>> an HDMI connector notifier from another if they share the same device.
> 
> This looks good to me, which brings me to the next question: how to merge
> this?
> 
> It touches on three subsystems (media, drm, mfd), so that makes this
> tricky.
> 
> I think there are two options: either the whole series goes through the
> media tree, or patches 1+2 go through drm and 3-6 through media. If there
> is a high chance of conflicts in the mfd code, then it is also an option to
> have patches 3-6 go through the mfd subsystem.

I think patches 3-6 should go in the mfd tree, Lee is used to handle this,
then I think the rest could go in the media tree.

Lee, do you think it would be possible to have an immutable branch with patches 3-6 ?

Could we have an immutable branch from media tree with patch 1 to be merged in
the i915 tree for patch 2 ?

Or patch 1+2 could me merged into the i915 tree and generate an immutable branch
for media to merge the mfd branch + patch 7 ?

Neil

> 
> Any opinions?
> 
> Regards,
> 
> 	Hans
> 
>>
>> Feel free to comment this patchset !
>>
>> Changes since v6:
>> - Added stable identifier comment in intel_display.h
>> - Renamed to cec_notifier in intel_hdmi.c/intel_drv.h
>> - Added Acked-by/Reviewed-By tags
>>
>> Changes since v5:
>>  - Small fixups on include/linux/mfd/cros_ec_commands.h
>>  - Fixed on cros-ec-cec driver accordingly
>>  - Added Reviewed-By tags
>>
>> Changes since v4:
>>  - Split patch 3 to move the mkbp event size change into a separate patch
>>
>> Changes since v3 (incorrectly reported as v2):
>>  - Renamed "Chrome OS" to "ChromeOS"
>>  - Updated cros_ec_commands.h new structs definitions to kernel doc format
>>  - Added Reviewed-By tags
>>
>> Changes since v2:
>>  - Add i915 port_identifier() and use this stable name as cec_notifier conn name
>>  - Fixed and cleaned up the CEC commands and events handling
>>  - Rebased the CEC sub-device registration on top of Enric's serie
>>  - Fixed comments typo on cec driver
>>  - Protected the DMI match only with PCI and DMI Kconfigs
>>
>> Changes since v1:
>>  - Added cec_notifier_put to intel_hdmi
>>  - Fixed all small reported issues on the EC CEC driver
>>  - Moved the cec_notifier_get out of the #if .. #else .. #endif
>>
>> Changes since RFC:
>>  - Moved CEC sub-device registration after CEC commands and events definitions patch
>>  - Removed get_notifier_get_byname
>>  - Added CEC_CORE select into i915 Kconfig
>>  - Removed CEC driver fallback if notifier is not configured on HW, added explicit warn
>>  - Fixed CEC core return type on error
>>  - Moved to cros-ec-cec media platform directory
>>  - Use bus_find_device() to find the pci i915 device instead of get_notifier_get_byname()
>>  - Fix Logical Address setup
>>  - Added comment about HW support
>>  - Removed memset of msg structures
>>
>> Neil Armstrong (6):
>>   media: cec-notifier: Get notifier by device and connector name
>>   drm/i915: hdmi: add CEC notifier to intel_hdmi
>>   mfd: cros-ec: Increase maximum mkbp event size
>>   mfd: cros-ec: Introduce CEC commands and events definitions.
>>   mfd: cros_ec_dev: Add CEC sub-device registration
>>   media: platform: Add ChromeOS EC CEC driver
>>
>>  drivers/gpu/drm/i915/Kconfig                     |   1 +
>>  drivers/gpu/drm/i915/intel_display.h             |  24 ++
>>  drivers/gpu/drm/i915/intel_drv.h                 |   2 +
>>  drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
>>  drivers/media/cec/cec-notifier.c                 |  11 +-
>>  drivers/media/platform/Kconfig                   |  11 +
>>  drivers/media/platform/Makefile                  |   2 +
>>  drivers/media/platform/cros-ec-cec/Makefile      |   1 +
>>  drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
>>  drivers/mfd/cros_ec_dev.c                        |  16 ++
>>  drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
>>  include/linux/mfd/cros_ec.h                      |   2 +-
>>  include/linux/mfd/cros_ec_commands.h             | 100 +++++++
>>  include/media/cec-notifier.h                     |  27 +-
>>  14 files changed, 581 insertions(+), 16 deletions(-)
>>  create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
>>  create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
>>
> 

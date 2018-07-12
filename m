Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A709FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514DA20875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SUm+L8ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514DA20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeGLMwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:52:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39001 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGLMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:52:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so5848451wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8W8nOlrds1Za3ZN6cMdzYPORLvepxksSH79QAUjh9Mw=;
        b=SUm+L8ieKdpP54S6wNvf22fG/+gUwUPnmVp/stLHfN7pjxBvpswaHs05pd4lhkkLHy
         MhasMmYpJ6ez/Wwzkn6k8nkNSRJ6dkR8t6B0eGbwL/y5si1ZakfbhqzXZxTU7XVNYjMt
         /Xe9oqr5/mlKch3I8HZppHv7y7rqsRPK9CtZ8MJxYb/cWdBWkNdSMrRruQGLpWnHKOoN
         x6o4YCfgUbvQvQbkQ01UDp3ok9R+U05IRXxUZEVRoesDWdRGwhFQQRP/LqJzSyloXbHR
         kCu1ttV2VBz2tWXL0N1VW14d1ReFTtfoY4SelrLGxkqHs7Y4l2oluJi0rb3TKeqHb7M6
         mI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8W8nOlrds1Za3ZN6cMdzYPORLvepxksSH79QAUjh9Mw=;
        b=OENajlnZehIlQvpHApN4y0rg38Ist34drsJbieI0Pn373xL44R+dP4oc0fbf6MjGPr
         t4hPM71zF6tXixubTCr+06s1uOt7qBhFkeDWCJVDtEKFBqz32QejFTdKv/YCRaK8rXva
         5oZ+z+NHKny7l7lNwEIP5A+6zhCycUMAweNfZbrDym4jgaSnxcSFUx4kP5sBaIF7QxrQ
         n7va2Tui8M0PIbNehJz1OPygmnrMFrA0HeI17YGnuegsI0wHo41BAauWrT75OHItJc7E
         fnOthc3zYySTUFg1NsU981SIFmn4gEPfqr0EQWi0fPv2JM5NlFIpZO2Xj6yVGCrL0Lie
         lHfQ==
X-Gm-Message-State: AOUpUlEXZSsAZH6GTmkdS8xaxHHM+fvJ67r72ebTSS9+J6HRKvcc86nD
        2mRLKpcR2cE1LFEiG2+CUJudVQ==
X-Google-Smtp-Source: AAOMgpeEEa0up8Ssshstz01v3RiGI9PIV718LaJM8qnq8VEGH3ftHDmSDW53Eq06Y4bI9s1YgZQOPg==
X-Received: by 2002:a1c:9754:: with SMTP id z81-v6mr1342722wmd.35.1531399378650;
        Thu, 12 Jul 2018 05:42:58 -0700 (PDT)
Received: from [10.1.2.12] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 35-v6sm17374552wri.78.2018.07.12.05.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 05:42:57 -0700 (PDT)
Subject: Re: [PATCH v8 0/6] Add ChromeOS EC CEC Support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
 <20180712122645.GE4641@dell>
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
Message-ID: <35fcf84e-f8a3-af79-013a-1c54ed5063ae@baylibre.com>
Date:   Thu, 12 Jul 2018 14:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712122645.GE4641@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/07/2018 14:26, Lee Jones wrote:
> On Wed, 04 Jul 2018, Neil Armstrong wrote:
> 
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
>>
>> Feel free to comment this patchset !
>>
>> Changes since v7:
>> - rebased on v4.18-rc1
>> - Fixed whitespace issues on patch 3
>> - Added Lee's tags
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
>>  include/linux/mfd/cros_ec_commands.h             |  97 +++++++
>>  include/media/cec-notifier.h                     |  27 +-
>>  14 files changed, 578 insertions(+), 16 deletions(-)
>>  create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
>>  create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
> 
> How would you like to handle this set?
> 

Hans proposed you take all the patches throught mfd,
then drm-intel could merge your immutable branch to avoid any conflicts.

Rodrigo Vivi gave an ack to merge it through other trees on the v6 patchset.

Hans, should the media tree also merge the branch ?

Neil

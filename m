Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEOHak (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:30:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36889 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeEOHag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:30:36 -0400
X-Google-Smtp-Source: AB8JxZqlPvviMv+5Ghu9e1/SXn7RpZaaMhPv5Y5KRWVmn65BWZ4rQn5Co+J2flWyTB7cNuXlkUcDsA==
Subject: Re: [RFC PATCH 3/5] drm/i915: hdmi: add CEC notifier to intel_hdmi
To: Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526337639-3568-1-git-send-email-narmstrong@baylibre.com>
 <1526337639-3568-4-git-send-email-narmstrong@baylibre.com>
 <b38aa2db-903a-c882-69d6-170b3c2aa70c@xs4all.nl>
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
Message-ID: <85da38a7-f396-882a-723e-437cc53d9c63@baylibre.com>
Date: Tue, 15 May 2018 09:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b38aa2db-903a-c882-69d6-170b3c2aa70c@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2018 08:29, Hans Verkuil wrote:
> On 05/15/2018 12:40 AM, Neil Armstrong wrote:
>> This patchs adds the cec_notifier feature to the intel_hdmi part
>> of the i915 DRM driver. It uses the HDMI DRM connector name to differentiate
>> between each HDMI ports.
>> The changes will allow the i915 HDMI code to notify EDID and HPD changes
>> to an eventual CEC adapter.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/i915/intel_drv.h  |  2 ++
>>  drivers/gpu/drm/i915/intel_hdmi.c | 10 ++++++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
>> index d436858..b50e51b 100644
>> --- a/drivers/gpu/drm/i915/intel_drv.h
>> +++ b/drivers/gpu/drm/i915/intel_drv.h
>> @@ -39,6 +39,7 @@
>>  #include <drm/drm_dp_mst_helper.h>
>>  #include <drm/drm_rect.h>
>>  #include <drm/drm_atomic.h>
>> +#include <media/cec-notifier.h>
>>  
>>  /**
>>   * __wait_for - magic wait macro
>> @@ -1001,6 +1002,7 @@ struct intel_hdmi {
>>  	bool has_audio;
>>  	bool rgb_quant_range_selectable;
>>  	struct intel_connector *attached_connector;
>> +	struct cec_notifier *notifier;
>>  };
>>  
>>  struct intel_dp_mst_encoder;
>> diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
>> index 1baef4a..9b94d72 100644
>> --- a/drivers/gpu/drm/i915/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/intel_hdmi.c
>> @@ -1868,6 +1868,8 @@ intel_hdmi_set_edid(struct drm_connector *connector)
>>  		connected = true;
>>  	}
>>  
>> +	cec_notifier_set_phys_addr_from_edid(intel_hdmi->notifier, edid);
>> +
>>  	return connected;
>>  }
>>  
>> @@ -1876,6 +1878,7 @@ intel_hdmi_detect(struct drm_connector *connector, bool force)
>>  {
>>  	enum drm_connector_status status;
>>  	struct drm_i915_private *dev_priv = to_i915(connector->dev);
>> +	struct intel_hdmi *intel_hdmi = intel_attached_hdmi(connector);
>>  
>>  	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
>>  		      connector->base.id, connector->name);
>> @@ -1891,6 +1894,9 @@ intel_hdmi_detect(struct drm_connector *connector, bool force)
>>  
>>  	intel_display_power_put(dev_priv, POWER_DOMAIN_GMBUS);
>>  
>> +	if (status != connector_status_connected)
>> +		cec_notifier_phys_addr_invalidate(intel_hdmi->notifier);
>> +
>>  	return status;
>>  }
>>  
>> @@ -2358,6 +2364,10 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
>>  		u32 temp = I915_READ(PEG_BAND_GAP_DATA);
>>  		I915_WRITE(PEG_BAND_GAP_DATA, (temp & ~0xf) | 0xd);
>>  	}
>> +
>> +	intel_hdmi->notifier = cec_notifier_get_conn(dev->dev, connector->name);
>> +	if (!intel_hdmi->notifier)
>> +		DRM_DEBUG_KMS("CEC notifier get failed\n");
> 
> You 'get' the notifier here, but where is the cec_notifier_put when the connector is deleted?

Because I failed to find a safe place for this !

I will have a second look...

> 
> Regards,
> 
> 	Hans
> 
>>  }
>>  
>>  void intel_hdmi_init(struct drm_i915_private *dev_priv,
>>
> 

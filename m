Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEPHk0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:40:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45469 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeEPHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:40:23 -0400
X-Google-Smtp-Source: AB8JxZrLeETYoxGzq4hEGyq6otFjX6uWzpeTxDcoc1C9y05XDN8LAJLz4yd2DVTy+EiaABUEFmWV4Q==
Subject: Re: [Intel-gfx] [PATCH v2 2/5] drm/i915: hdmi: add CEC notifier to
 intel_hdmi
From: Neil Armstrong <narmstrong@baylibre.com>
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com, sadolfsson@google.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, fparent@baylibre.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        linux-media@vger.kernel.org
References: <1526395342-15481-1-git-send-email-narmstrong@baylibre.com>
 <1526395342-15481-3-git-send-email-narmstrong@baylibre.com>
 <20180515153521.GB23723@intel.com>
 <aff8c86f-b282-c901-5ef5-c5ee334aeedc@baylibre.com>
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
Message-ID: <e0f99123-1463-c082-122e-67cf0d106e25@baylibre.com>
Date: Wed, 16 May 2018 09:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <aff8c86f-b282-c901-5ef5-c5ee334aeedc@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2018 09:31, Neil Armstrong wrote:
> Hi Ville,
> 
> On 15/05/2018 17:35, Ville Syrjälä wrote:
>> On Tue, May 15, 2018 at 04:42:19PM +0200, Neil Armstrong wrote:
>>> This patchs adds the cec_notifier feature to the intel_hdmi part
>>> of the i915 DRM driver. It uses the HDMI DRM connector name to differentiate
>>> between each HDMI ports.
>>> The changes will allow the i915 HDMI code to notify EDID and HPD changes
>>> to an eventual CEC adapter.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  drivers/gpu/drm/i915/Kconfig      |  1 +
>>>  drivers/gpu/drm/i915/intel_drv.h  |  2 ++
>>>  drivers/gpu/drm/i915/intel_hdmi.c | 12 ++++++++++++
>>>  3 files changed, 15 insertions(+)
>>>
> 
> [..]
> 
>>>  }
>>>  
>>> @@ -2031,6 +2037,8 @@ static void chv_hdmi_pre_enable(struct intel_encoder *encoder,
>>>  
>>>  static void intel_hdmi_destroy(struct drm_connector *connector)
>>>  {
>>> +	if (intel_attached_hdmi(connector)->notifier)
>>> +		cec_notifier_put(intel_attached_hdmi(connector)->notifier);
>>>  	kfree(to_intel_connector(connector)->detect_edid);
>>>  	drm_connector_cleanup(connector);
>>>  	kfree(connector);
>>> @@ -2358,6 +2366,10 @@ void intel_hdmi_init_connector(struct intel_digital_port *intel_dig_port,
>>>  		u32 temp = I915_READ(PEG_BAND_GAP_DATA);
>>>  		I915_WRITE(PEG_BAND_GAP_DATA, (temp & ~0xf) | 0xd);
>>>  	}
>>> +
>>> +	intel_hdmi->notifier = cec_notifier_get_conn(dev->dev, connector->name);
>>
>> What are we doing with the connector name here? Those are not actually
>> guaranteed to be stable, and any change in the connector probe order
>> may cause the name to change.
> 
> The i915 driver can expose multiple HDMI connectors, but each connected will
> have a different EDID and CEC physical address, so we will need a different notifier
> for each connector.
> 
> The connector name is DRM dependent, but user-space actually uses this name for
> operations, so I supposed it was kind of stable.
> 
> Anyway, is there another stable id/name/whatever that can be used to make a name to
> distinguish the HDMI connectors ?

Would "HDMI %c", port_name(port) be OK to use ?

Neil

> 
> Neil
> 
>>
>>> +	if (!intel_hdmi->notifier)
>>> +		DRM_DEBUG_KMS("CEC notifier get failed\n");
>>>  }
>>>  
>>>  void intel_hdmi_init(struct drm_i915_private *dev_priv,
>>> -- 
>>> 2.7.4
>>>
>>> _______________________________________________
>>> Intel-gfx mailing list
>>> Intel-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
>>
> 

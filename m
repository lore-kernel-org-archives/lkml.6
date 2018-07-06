Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE65C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811924001
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st5PIMXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5811924001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeGFNFb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:05:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46267 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGFNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:05:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id l16-v6so9760258lfc.13;
        Fri, 06 Jul 2018 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fWUf6QygrQrIM8XsMVaJ1ZgEIaks3NgwaRdkccDqboM=;
        b=st5PIMXX/kSTouPy02aWUUsAjeL53xeKq0lIZfuAHxnB73MBUJs7aszLrLgDo6/Kg2
         xrizD7A4Nf+MwU7WXARPkOvES+u/GgnQuueT/VIxQyyrkXGkBHXu9FGlWWxU6IapUNyI
         GAa2cBiHM5XxLB9zha+3PCmQ0Y6oie8p2pr30ajbVZMd0WQa9F1/5HdwayyqKJu7OcSF
         HmaLNEfxVFwWqURbCxVXCHb6X1Bo+Wkm3bvk+XwLXf8q1tLeRqypkVTTfZpva9cp6FqL
         rENPym6fqd8u8vrSzX2Trn17cYFmQj2HcBniSzTha8RGn/Z/RBdVpgtsiuBg/NJT43YH
         SwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fWUf6QygrQrIM8XsMVaJ1ZgEIaks3NgwaRdkccDqboM=;
        b=nX3Anpw2/ijWouA+M6YJ0B2E12GmwuJnW0+GuLbYal7wT8rg54q6cJExvTkxapt/PV
         NiJ2g9C/RQNEqXsJFPnqccAmCu2CrqVvfDN0I6/HVJpjyiaLMd2JAakUbgaNFWmN+6xW
         /onhA1fDcshlV869O89NaqS9KIs6Iej207swVk9f6W4oTdVTquVDq7/ERB9NABpuwU8t
         7E1+v3N8AOGS0rrnzEq3GBXLMjZYfbL9pWf4flsGVx5AHxOEAIL9Dm4hGoVEAapeUkp/
         gQp/UqRD8O2D2Gv3gvlJf+G3/oFkYj650fFXcJiYRtk/9Yl3+G3HB5f/qGrMfr/FdlCR
         a+cA==
X-Gm-Message-State: APt69E3LV6SwOI3ye9Yt8t86l+RNRUy/iqL4eaS+ZJnWLhDivQwU4sNp
        Te67jxF6p9KzgjWE7jXKiCGWh1b3
X-Google-Smtp-Source: AAOMgpcLan5vdNDGh6EzXiuXwWGlS3s8QX6oCxdicDyb0DGeWgyyeJ/VFZoMq1Yc83H3mA/2VMztPA==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr7289099lfl.78.1530882323364;
        Fri, 06 Jul 2018 06:05:23 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.84])
        by smtp.googlemail.com with ESMTPSA id a9-v6sm2165554lfi.59.2018.07.06.06.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 06:05:22 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/2] drm: Add generic colorkey properties for DRM
 planes
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
References: <20180603220059.17670-1-digetx@gmail.com>
 <20180603220059.17670-2-digetx@gmail.com>
 <8b80e766-be05-b5be-5a0f-102a5135d230@linux.intel.com>
 <20180706122318.GI5565@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <a2e6e02b-bc6c-a411-0797-99e1bdb6674a@gmail.com>
Date:   Fri, 6 Jul 2018 16:05:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706122318.GI5565@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.2018 15:23, Ville Syrjälä wrote:
> On Fri, Jul 06, 2018 at 02:11:44PM +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> Op 04-06-18 om 00:00 schreef Dmitry Osipenko:
>>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>>
>>> Color keying is the action of replacing pixels matching a given color
>>> (or range of colors) with transparent pixels in an overlay when
>>> performing blitting. Depending on the hardware capabilities, the
>>> matching pixel can either become fully transparent or gain adjustment
>>> of the pixels component values.
>>>
>>> Color keying is found in a large number of devices whose capabilities
>>> often differ, but they still have enough common features in range to
>>> standardize color key properties. This commit adds three generic DRM plane
>>> properties related to the color keying, providing initial color keying
>>> support.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/gpu/drm/drm_atomic.c | 12 +++++
>>>  drivers/gpu/drm/drm_blend.c  | 99 ++++++++++++++++++++++++++++++++++++
>>>  include/drm/drm_blend.h      |  3 ++
>>>  include/drm/drm_plane.h      | 53 +++++++++++++++++++
>>>  4 files changed, 167 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>>> index 895741e9cd7d..b322cbed319b 100644
>>> --- a/drivers/gpu/drm/drm_atomic.c
>>> +++ b/drivers/gpu/drm/drm_atomic.c
>>> @@ -799,6 +799,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>>>  		state->rotation = val;
>>>  	} else if (property == plane->zpos_property) {
>>>  		state->zpos = val;
>>> +	} else if (property == plane->colorkey.mode_property) {
>>> +		state->colorkey.mode = val;
>>> +	} else if (property == plane->colorkey.min_property) {
>>> +		state->colorkey.min = val;
>>> +	} else if (property == plane->colorkey.max_property) {
>>> +		state->colorkey.max = val;
>>>  	} else if (property == plane->color_encoding_property) {
>>>  		state->color_encoding = val;
>>>  	} else if (property == plane->color_range_property) {
>>> @@ -864,6 +870,12 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>>>  		*val = state->rotation;
>>>  	} else if (property == plane->zpos_property) {
>>>  		*val = state->zpos;
>>> +	} else if (property == plane->colorkey.mode_property) {
>>> +		*val = state->colorkey.mode;
>>> +	} else if (property == plane->colorkey.min_property) {
>>> +		*val = state->colorkey.min;
>>> +	} else if (property == plane->colorkey.max_property) {
>>> +		*val = state->colorkey.max;
>>>  	} else if (property == plane->color_encoding_property) {
>>>  		*val = state->color_encoding;
>>>  	} else if (property == plane->color_range_property) {
>>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
>>> index a16a74d7e15e..12fed2ff65c8 100644
>>> --- a/drivers/gpu/drm/drm_blend.c
>>> +++ b/drivers/gpu/drm/drm_blend.c
>>> @@ -107,6 +107,11 @@
>>>   *	planes. Without this property the primary plane is always below the cursor
>>>   *	plane, and ordering between all other planes is undefined.
>>>   *
>>> + * colorkey:
>>> + *	Color keying is set up with drm_plane_create_colorkey_properties().
>>> + *	It adds support for replacing a range of colors with a transparent
>>> + *	color in the plane.
>>> + *
>>>   * Note that all the property extensions described here apply either to the
>>>   * plane or the CRTC (e.g. for the background color, which currently is not
>>>   * exposed and assumed to be black).
>>> @@ -448,3 +453,97 @@ int drm_atomic_normalize_zpos(struct drm_device *dev,
>>>  	return 0;
>>>  }
>>>  EXPORT_SYMBOL(drm_atomic_normalize_zpos);
>>> +
>>> +static const char * const plane_colorkey_mode_name[] = {
>>> +	[DRM_PLANE_COLORKEY_MODE_DISABLED] = "disabled",
>>> +	[DRM_PLANE_COLORKEY_MODE_FOREGROUND_CLIP] = "foreground-clip",
>>> +};
>>> +
>>> +/**
>>> + * drm_plane_create_colorkey_properties - create colorkey properties
>>> + * @plane: drm plane
>>> + * @supported_modes: bitmask of supported color keying modes
>>> + *
>>> + * This function creates the generic color keying properties and attach them to
>>> + * the plane to enable color keying control for blending operations.
>>> + *
>>> + * Color keying is controlled by these properties:
>>> + *
>>> + * colorkey.mode:
>>> + *	The mode is an enumerated property that controls how color keying
>>> + *	operates.
>>> + *
>>> + * colorkey.min, colorkey.max:
>>> + *	These two properties specify the colors that are treated as the color
>>> + *	key. Pixel whose value is in the [min, max] range is the color key
>>> + *	matching pixel. The minimum and maximum values are expressed as a
>>> + *	64-bit integer in ARGB16161616 format, where A is the alpha value and
>>> + *	R, G and B correspond to the color components. Drivers shall convert
>>> + *	ARGB16161616 value into appropriate format within planes atomic check.
>>> + *
>>> + *	When a single color key is desired instead of a range, userspace shall
>>> + *	set the min and max properties to the same value.
>>> + *
>>> + *	Drivers return an error from their plane atomic check if range can't be
>>> + *	handled.
>>> + *
>>> + * Returns:
>>> + * Zero on success, negative errno on failure.
>>> + */
>>> +int drm_plane_create_colorkey_properties(struct drm_plane *plane,
>>> +					 u32 supported_modes)
>>> +{
>>> +	struct drm_prop_enum_list modes_list[DRM_PLANE_COLORKEY_MODES_NUM];
>>> +	struct drm_property *mode_prop;
>>> +	struct drm_property *min_prop;
>>> +	struct drm_property *max_prop;
>>> +	unsigned int modes_num = 0;
>>> +	unsigned int i;
>>> +
>>> +	/* modes are driver-specific, build the list of supported modes */
>>> +	for (i = 0; i < DRM_PLANE_COLORKEY_MODES_NUM; i++) {
>>> +		if (!(supported_modes & BIT(i)))
>>> +			continue;
>>> +
>>> +		modes_list[modes_num].name = plane_colorkey_mode_name[i];
>>> +		modes_list[modes_num].type = i;
>>> +		modes_num++;
>>> +	}
>>> +
>>> +	/* at least one mode should be supported */
>>> +	if (!modes_num)
>>> +		return -EINVAL;
>>> +
>>> +	mode_prop = drm_property_create_enum(plane->dev, 0, "colorkey.mode",
>>> +					     modes_list, modes_num);
>>> +	if (!mode_prop)
>>> +		return -ENOMEM;
>>> +
>>> +	min_prop = drm_property_create_range(plane->dev, 0, "colorkey.min",
>>> +					     0, U64_MAX);
>>> +	if (!min_prop)
>>> +		goto err_destroy_mode_prop;
>>> +
>>> +	max_prop = drm_property_create_range(plane->dev, 0, "colorkey.max",
>>> +					     0, U64_MAX);
>>> +	if (!max_prop)
>>> +		goto err_destroy_min_prop;
>>> +
>>> +	drm_object_attach_property(&plane->base, mode_prop, 0);
>>> +	drm_object_attach_property(&plane->base, min_prop, 0);
>>> +	drm_object_attach_property(&plane->base, max_prop, 0);
>>> +
>>> +	plane->colorkey.mode_property = mode_prop;
>>> +	plane->colorkey.min_property = min_prop;
>>> +	plane->colorkey.max_property = max_prop;
>>> +
>>> +	return 0;
>>> +
>>> +err_destroy_min_prop:
>>> +	drm_property_destroy(plane->dev, min_prop);
>>> +err_destroy_mode_prop:
>>> +	drm_property_destroy(plane->dev, mode_prop);
>>> +
>>> +	return -ENOMEM;
>>> +}
>>> +EXPORT_SYMBOL(drm_plane_create_colorkey_properties);
>>> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
>>> index 330c561c4c11..8e80d33b643e 100644
>>> --- a/include/drm/drm_blend.h
>>> +++ b/include/drm/drm_blend.h
>>> @@ -52,4 +52,7 @@ int drm_plane_create_zpos_immutable_property(struct drm_plane *plane,
>>>  					     unsigned int zpos);
>>>  int drm_atomic_normalize_zpos(struct drm_device *dev,
>>>  			      struct drm_atomic_state *state);
>>> +
>>> +int drm_plane_create_colorkey_properties(struct drm_plane *plane,
>>> +					 u32 supported_modes);
>>>  #endif
>>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>>> index 26fa50c2a50e..9a621e1ccc47 100644
>>> --- a/include/drm/drm_plane.h
>>> +++ b/include/drm/drm_plane.h
>>> @@ -32,6 +32,48 @@ struct drm_crtc;
>>>  struct drm_printer;
>>>  struct drm_modeset_acquire_ctx;
>>>  
>>> +/**
>>> + * enum drm_plane_colorkey_mode - uapi plane colorkey mode enumeration
>>> + */
>>> +enum drm_plane_colorkey_mode {
>>> +	/**
>>> +	 * @DRM_PLANE_COLORKEY_MODE_DISABLED:
>>> +	 *
>>> +	 * No color matching performed in this mode.
>>> +	 */
>>> +	DRM_PLANE_COLORKEY_MODE_DISABLED,
>>> +
>>> +	/**
>>> +	 * @DRM_PLANE_COLORKEY_MODE_FOREGROUND_CLIP:
>>> +	 *
>>> +	 * This mode is also known as a "green screen". Plane pixels are
>>> +	 * transparent in areas where pixels match a given color key range
>>> +	 * and there is a bottom (background) plane, in other cases plane
>>> +	 * pixels are unaffected.
>>> +	 *
>>> +	 */
>>> +	DRM_PLANE_COLORKEY_MODE_FOREGROUND_CLIP,
>> Could we add background clip as well?
> 

Sure, but I think adding a new mode should be a distinct change made on top of
the initial series.

> Also could we just name them "src" and "dst" (or some variation of
> those). I'm betting no one has any kind of idea what these proposed
> names mean without looking up the docs, whereas pretty much everyone
> knows immediately what src/dst colorkeying means.
> 

Okay, I'll rename the mode to DRM_PLANE_COLORKEY_MODE_SRC in the next revision.

>>
>> Would be nice if we could map i915's legacy ioctl handler to the new color key mode.
>>> +	/**
>>> +	 * @DRM_PLANE_COLORKEY_MODES_NUM:
>>> +	 *
>>> +	 * Total number of color keying modes.
>>> +	 */
>>> +	DRM_PLANE_COLORKEY_MODES_NUM,
>>> +};
>>> +
>>> +/**
>>> + * struct drm_plane_colorkey_state - plane color keying state
>>> + * @colorkey.mode: color keying mode
>>> + * @colorkey.min: color key range minimum (in ARGB16161616 format)
>>> + * @colorkey.max: color key range maximum (in ARGB16161616 format)
>>> + */
>>> +struct drm_plane_colorkey_state {
>>> +	enum drm_plane_colorkey_mode mode;
>>> +	u64 min;
>>> +	u64 max;
>>> +};
>> Could we have some macros to extract the components for min/max?
>> A, R, G, B.
> 

I'll add the macros in the next revision.

> And where did we lose the value+mask?
> 

There is no use for the mask on Tegra. I'd prefer to keep initial patches simple
and minimal, other modes and additional properties could be added in the further
patches on by as-needed basis. Mask could be added later with the default value
of 0xffffffffffffffff. Does it sound good for you?

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeEOGeN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:34:13 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:55267 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752206AbeEOGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:34:11 -0400
Subject: Re: [RFC PATCH 3/5] drm/i915: hdmi: add CEC notifier to intel_hdmi
To: Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1526337639-3568-1-git-send-email-narmstrong@baylibre.com>
 <1526337639-3568-4-git-send-email-narmstrong@baylibre.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <38dcd327-004c-3fb3-8e22-3b3b92542fc9@xs4all.nl>
Date: Tue, 15 May 2018 08:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1526337639-3568-4-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEDiYGIEtMJLKoCjG56nQnmwDS0BTwYrz7Kdy21pP1RXjA70Wn1MEBJ0VXtwKdx7XvN4M667qTqNrJd/x7eDKkAzoM3AZOAMfXnWaz4c8wOi/1GlYUZO
 vw21FFYlzjJrKnq3QGJH3YbWvCcL3+8F8MCK94QB4AAWay2/Ohe/zHih0zeHSS+x/Mrzlq9NPuZJREQdykfdufle1Cv/6C72OaYu4fdt3XpFco9Pf5QPLiuo
 Dku5xh5NfurkhQdNdOYO1lnIbLAn99W+Qj1ZfrpxI60Gn4upuSuAua6uYD6RCYMIBBpYt7QkU7Sz/aIrSH9MUofoBb2DAIs31M9A3RGLsEXYbPN8g5jdTmrl
 QH2Vmbi0XuwnsVXiYALbco5di82Tc7iPd0U5hyUV3YDE93Z4LlOQVoOqZrZaZv2Wl+8lDuHXhZal01YQvG89OPxdmxoMxQpL2TITJxRf9Nh8zZhLoWlku79k
 CxfwlouAqgzGjMCSm3LXhHloMxNTl7UFGiksGgZyYy/Xq7DiXR2ipVLxiJ9LOFkTAiYTk9+3SV4ZDIw83/BhuDqYfdiC9ZRzLWrGKtYqRtsxShp5Z9A7yvfu
 OH0Ep5RAQit5aeGhPoCgWmbpN1MhcXOpwZAuxRieBd5DOH2aAoL9R54wNIVTxWcPjbxyskadRbNArog7L9e6ohLB3AkVOQudnEHiU8zW7eRBxkDbo9+ChXKE
 Avs554EDHMo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/2018 12:40 AM, Neil Armstrong wrote:
> This patchs adds the cec_notifier feature to the intel_hdmi part
> of the i915 DRM driver. It uses the HDMI DRM connector name to differentiate
> between each HDMI ports.
> The changes will allow the i915 HDMI code to notify EDID and HPD changes
> to an eventual CEC adapter.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/i915/intel_drv.h  |  2 ++
>  drivers/gpu/drm/i915/intel_hdmi.c | 10 ++++++++++

The Kconfig also needs to be changed. In the DRM_I915 you need to add:

	select CEC_CORE if CEC_NOTIFIER

Otherwise you'll get problems if the cec driver is a module and i915 is built-in.

Regards,

	Hans

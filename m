Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2224E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2224E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeLEQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:12:40 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50222 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbeLEQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:12:39 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id BB09426069E
Subject: Re: [PATCH] drm: add capability DRM_CAP_ASYNC_UPDATE
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, dnicoara@chromium.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        alexandros.frantzis@collabora.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tomasz Figa <tfiga@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        kernel@collabora.com,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20181123215326.14274-1-helen.koike@collabora.com>
 <20181127133418.GT9144@intel.com>
From:   Helen Koike <helen.koike@collabora.com>
Openpgp: preference=signencrypt
Autocrypt: addr=helen.koike@collabora.com; keydata=
 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
Message-ID: <6aa39654-6949-88b3-b949-b338d915ffd2@collabora.com>
Date:   Wed, 5 Dec 2018 14:12:28 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127133418.GT9144@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville

On 11/27/18 11:34 AM, Ville Syrjälä wrote:
> On Fri, Nov 23, 2018 at 07:53:26PM -0200, Helen Koike wrote:
>> Allow userspace to identify if the driver supports async update.
> 
> And what exactly is an "async update"?

I agree we are lacking docs on this, I'll send in the next version as
soon as we agree on a name (please see below).

For reference:
https://lists.freedesktop.org/archives/dri-devel/2017-April/138586.html

> 
> I keep asking people to come up with the a better name for this, and to
> document what it actually means. Recently I've been think we should
> maybe just adopt the vulkan terminology (immediate/fifo/mailbox) to
> avoid introducing yet another set of names for the same thing. We'd
> still want to document things properly though.

Another name it was suggested was "atomic amend", this feature basically
allows userspace to complement an update previously sent (i.e. its in
the queue and wasn't commited yet), it allows adding a plane update to
the next commit. So what do you think in renaming it to "atomic amend"?
Or do you suggest another name? I am not familiar with vulkan terminology.


Thanks
Helen

> 
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> [prepared for upstream]
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>
>> ---
>> Hi,
>>
>> This patch introduces the ASYNC_UPDATE cap, which originated from the
>> discussion regarding DRM_MODE_ATOMIC_AMEND on [1], to allow user to
>> figure that async_update exists.
>>
>> This was tested using a small program that exercises the uAPI for easy
>> sanity testing. The program was created by Alexandros and modified by
>> Enric to test the capability flag [2].
>>
>> The test worked on a rockchip Ficus v1.1 board on top of mainline plus
>> the patch to update cursors asynchronously through atomic plus the patch
>> that introduces the ATOMIC_AMEND flag for the drm/rockchip driver.
>>
>> To test, just build the program and use the --atomic flag to use the cursor
>> plane with the ATOMIC_AMEND flag. E.g.
>>
>>   drm_cursor --atomic
>>
>> [1] https://patchwork.freedesktop.org/patch/243088/
>> [2] https://gitlab.collabora.com/eballetbo/drm-cursor/commits/async-capability
>>
>> Thanks
>> Helen
>>
>>
>>  drivers/gpu/drm/drm_ioctl.c | 11 +++++++++++
>>  include/uapi/drm/drm.h      |  1 +
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
>> index 94bd872d56c4..4a7e0f874171 100644
>> --- a/drivers/gpu/drm/drm_ioctl.c
>> +++ b/drivers/gpu/drm/drm_ioctl.c
>> @@ -31,6 +31,7 @@
>>  #include <drm/drm_ioctl.h>
>>  #include <drm/drmP.h>
>>  #include <drm/drm_auth.h>
>> +#include <drm/drm_modeset_helper_vtables.h>
>>  #include "drm_legacy.h"
>>  #include "drm_internal.h"
>>  #include "drm_crtc_internal.h"
>> @@ -229,6 +230,7 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>>  {
>>  	struct drm_get_cap *req = data;
>>  	struct drm_crtc *crtc;
>> +	struct drm_plane *plane;
>>  
>>  	req->value = 0;
>>  
>> @@ -292,6 +294,15 @@ static int drm_getcap(struct drm_device *dev, void *data, struct drm_file *file_
>>  	case DRM_CAP_CRTC_IN_VBLANK_EVENT:
>>  		req->value = 1;
>>  		break;
>> +	case DRM_CAP_ASYNC_UPDATE:
>> +		req->value = 1;
>> +		list_for_each_entry(plane, &dev->mode_config.plane_list, head) {
>> +			if (!plane->helper_private->atomic_async_update) {
>> +				req->value = 0;
>> +				break;
>> +			}
>> +		}
>> +		break;
>>  	default:
>>  		return -EINVAL;
>>  	}
>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>> index 300f336633f2..ff01540cbb1d 100644
>> --- a/include/uapi/drm/drm.h
>> +++ b/include/uapi/drm/drm.h
>> @@ -649,6 +649,7 @@ struct drm_gem_open {
>>  #define DRM_CAP_PAGE_FLIP_TARGET	0x11
>>  #define DRM_CAP_CRTC_IN_VBLANK_EVENT	0x12
>>  #define DRM_CAP_SYNCOBJ		0x13
>> +#define DRM_CAP_ASYNC_UPDATE		0x14
>>  
>>  /** DRM_IOCTL_GET_CAP ioctl argument type */
>>  struct drm_get_cap {
>> -- 
>> 2.19.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

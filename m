Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TIc2EDM9GluhPgAAmS7hNA
	; Fri, 08 Jun 2018 08:24:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 75246606FA; Fri,  8 Jun 2018 08:24:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="B3J2ho11"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AA0E860590;
	Fri,  8 Jun 2018 08:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA0E860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeFHIYt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:24:49 -0400
Received: from aer-iport-3.cisco.com ([173.38.203.53]:47600 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932133AbeFHIYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6080; q=dns/txt; s=iport;
  t=1528446286; x=1529655886;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yPuy0bfGHYoMzosKBsYzvwatPPjoEjq1DhvgSh0fNQA=;
  b=B3J2ho11OjR7+IwlWIaAfJ4/bM0RXBSrr7CNNnbUEwzQvPeYPspv+pXC
   MiC66IcjmuPcpFjvWrAKaOXk20AHMa6ufUnBPWHOPpxHTIYSOibXqCBe1
   LVVE/lOTK+HTJiqmB4wuTOQ3sy27U7TVJqQLa9Rtl31bdHxAKSNQgzVj3
   g=;
X-IronPort-AV: E=Sophos;i="5.49,490,1520899200";
   d="scan'208";a="4347784"
Received: from aer-iport-nat.cisco.com (HELO aer-core-2.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 08:24:44 +0000
Received: from [10.61.91.47] (ams3-vpn-dhcp6960.cisco.com [10.61.91.47])
        (authenticated bits=0)
        by aer-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id w588Og7v013510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 8 Jun 2018 08:24:43 GMT
Subject: Re: [PATCH v7 0/6] Add ChromeOS EC CEC Support
To: Neil Armstrong <narmstrong@baylibre.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, lee.jones@linaro.org, olof@lixom.net,
        seanpaul@google.com
Cc: sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
 <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
From: Hans Verkuil <hansverk@cisco.com>
Message-ID: <898f025f-9c59-be61-a2b4-5fbbcbc659c2@cisco.com>
Date: Fri, 8 Jun 2018 10:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-User: hansverk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 10:17, Neil Armstrong wrote:
> Hi Hans,
> 
> On 08/06/2018 09:53, Hans Verkuil wrote:
>> On 06/01/2018 10:19 AM, Neil Armstrong wrote:
>>> Hi All,
>>>
>>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
>>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
>>> with it and get the CEC Physical Address from the correct HDMI Connector, the
>>> following must be added/changed:
>>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
>>> - Add the CEC related commands and events definitions into the EC MFD driver
>>> - Add a way to get a CEC notifier with it's (optional) connector name
>>> - Add the CEC notifier to the i915 HDMI driver
>>> - Add the proper ChromeOS EC CEC Driver
>>>
>>> The CEC notifier with the connector name is the tricky point, since even on
>>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
>>> connectors from the same DRM driver. The solution I implemented is pretty
>>> simple and only adds an optional connector name to eventually distinguish
>>> an HDMI connector notifier from another if they share the same device.
>>
>> This looks good to me, which brings me to the next question: how to merge
>> this?
>>
>> It touches on three subsystems (media, drm, mfd), so that makes this
>> tricky.
>>
>> I think there are two options: either the whole series goes through the
>> media tree, or patches 1+2 go through drm and 3-6 through media. If there
>> is a high chance of conflicts in the mfd code, then it is also an option to
>> have patches 3-6 go through the mfd subsystem.
> 
> I think patches 3-6 should go in the mfd tree, Lee is used to handle this,
> then I think the rest could go in the media tree.
> 
> Lee, do you think it would be possible to have an immutable branch with patches 3-6 ?
> 
> Could we have an immutable branch from media tree with patch 1 to be merged in
> the i915 tree for patch 2 ?
> 
> Or patch 1+2 could me merged into the i915 tree and generate an immutable branch

I think patches 1+2 can just go to the i915 tree. The i915 driver changes often,
so going through that tree makes sense. The cec-notifier code is unlikely to change,
and I am fine with that patch going through i915.

> for media to merge the mfd branch + patch 7 ?

Patch 7? I only count 6?

If 1+2 go through drm and 3-6 go through mfd, then media isn't affected at all.
There is chance of a conflict when this is eventually pushed to mainline for
the media Kconfig, but that's all.

Regards,

	Hans

> 
> Neil
> 
>>
>> Any opinions?
>>
>> Regards,
>>
>> 	Hans
>>
>>>
>>> Feel free to comment this patchset !
>>>
>>> Changes since v6:
>>> - Added stable identifier comment in intel_display.h
>>> - Renamed to cec_notifier in intel_hdmi.c/intel_drv.h
>>> - Added Acked-by/Reviewed-By tags
>>>
>>> Changes since v5:
>>>  - Small fixups on include/linux/mfd/cros_ec_commands.h
>>>  - Fixed on cros-ec-cec driver accordingly
>>>  - Added Reviewed-By tags
>>>
>>> Changes since v4:
>>>  - Split patch 3 to move the mkbp event size change into a separate patch
>>>
>>> Changes since v3 (incorrectly reported as v2):
>>>  - Renamed "Chrome OS" to "ChromeOS"
>>>  - Updated cros_ec_commands.h new structs definitions to kernel doc format
>>>  - Added Reviewed-By tags
>>>
>>> Changes since v2:
>>>  - Add i915 port_identifier() and use this stable name as cec_notifier conn name
>>>  - Fixed and cleaned up the CEC commands and events handling
>>>  - Rebased the CEC sub-device registration on top of Enric's serie
>>>  - Fixed comments typo on cec driver
>>>  - Protected the DMI match only with PCI and DMI Kconfigs
>>>
>>> Changes since v1:
>>>  - Added cec_notifier_put to intel_hdmi
>>>  - Fixed all small reported issues on the EC CEC driver
>>>  - Moved the cec_notifier_get out of the #if .. #else .. #endif
>>>
>>> Changes since RFC:
>>>  - Moved CEC sub-device registration after CEC commands and events definitions patch
>>>  - Removed get_notifier_get_byname
>>>  - Added CEC_CORE select into i915 Kconfig
>>>  - Removed CEC driver fallback if notifier is not configured on HW, added explicit warn
>>>  - Fixed CEC core return type on error
>>>  - Moved to cros-ec-cec media platform directory
>>>  - Use bus_find_device() to find the pci i915 device instead of get_notifier_get_byname()
>>>  - Fix Logical Address setup
>>>  - Added comment about HW support
>>>  - Removed memset of msg structures
>>>
>>> Neil Armstrong (6):
>>>   media: cec-notifier: Get notifier by device and connector name
>>>   drm/i915: hdmi: add CEC notifier to intel_hdmi
>>>   mfd: cros-ec: Increase maximum mkbp event size
>>>   mfd: cros-ec: Introduce CEC commands and events definitions.
>>>   mfd: cros_ec_dev: Add CEC sub-device registration
>>>   media: platform: Add ChromeOS EC CEC driver
>>>
>>>  drivers/gpu/drm/i915/Kconfig                     |   1 +
>>>  drivers/gpu/drm/i915/intel_display.h             |  24 ++
>>>  drivers/gpu/drm/i915/intel_drv.h                 |   2 +
>>>  drivers/gpu/drm/i915/intel_hdmi.c                |  13 +
>>>  drivers/media/cec/cec-notifier.c                 |  11 +-
>>>  drivers/media/platform/Kconfig                   |  11 +
>>>  drivers/media/platform/Makefile                  |   2 +
>>>  drivers/media/platform/cros-ec-cec/Makefile      |   1 +
>>>  drivers/media/platform/cros-ec-cec/cros-ec-cec.c | 347 +++++++++++++++++++++++
>>>  drivers/mfd/cros_ec_dev.c                        |  16 ++
>>>  drivers/platform/chrome/cros_ec_proto.c          |  40 ++-
>>>  include/linux/mfd/cros_ec.h                      |   2 +-
>>>  include/linux/mfd/cros_ec_commands.h             | 100 +++++++
>>>  include/media/cec-notifier.h                     |  27 +-
>>>  14 files changed, 581 insertions(+), 16 deletions(-)
>>>  create mode 100644 drivers/media/platform/cros-ec-cec/Makefile
>>>  create mode 100644 drivers/media/platform/cros-ec-cec/cros-ec-cec.c
>>>
>>
> 

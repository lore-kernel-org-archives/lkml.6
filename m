Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeC2Htv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:49:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeC2Htq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:49:46 -0400
X-Google-Smtp-Source: AIpwx49UJWIKDqAPkc8Lz0+Ohd2Z1ftUQzpT5W53ZxViEouhvZLw914ZVkJDdH6NHWgz8gje28eNgw==
Subject: Re: [PATCH v4 2/2] drm/xen-front: Add support for Xen PV display
 frontend
To: daniel.vetter@intel.com, jgross@suse.com, konrad.wilk@oracle.com,
        airlied@linux.ie,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
References: <1522219661-26827-1-git-send-email-andr2000@gmail.com>
 <1522219661-26827-3-git-send-email-andr2000@gmail.com>
 <20180328074251.GE14155@phenom.ffwll.local>
 <32481355-27f6-695b-c6c1-8113ea268a33@gmail.com>
 <20180329071748.GG3881@phenom.ffwll.local>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d5efc0d5-bfbc-9281-fb1e-3a09de3d43d9@gmail.com>
Date: Thu, 29 Mar 2018 10:49:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329071748.GG3881@phenom.ffwll.local>
Content-Type: multipart/mixed;
 boundary="------------0F431B0390EA6413AB0422ED"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0F431B0390EA6413AB0422ED
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/29/2018 10:17 AM, Daniel Vetter wrote:
> On Wed, Mar 28, 2018 at 01:29:46PM +0300, Oleksandr Andrushchenko wrote:
>> Hi, Daniel!
>>
>> I just noticed I have missed one change in the patch:
>> the below must be static.
>>
>> On 03/28/2018 10:42 AM, Daniel Vetter wrote:
>>> +enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
>>> +		const struct drm_display_mode *mode)
>>> +{
>>> +	struct xen_drm_front_drm_pipeline *pipeline =
>>> +			container_of(crtc,
>> Could you please amend the patch in attachment
>> when merging, so I don't resend?
> Merging is up to you, as soon as you have your commit rights.
Thank you, meanwhile I'll need to rebase onto the latest drm-tip
fixing 2 more minor issues (attached) and making the driver work after
the API change [1]. So, I'll post v4 right after fd.o is back online
with the v3..v4 diff to make review simpler
> -Daniel
Thank you,
Oleksandr
>> Thank you in advance,
>> Oleksandr
>>  From 3a82d76bd3d954056b760e5d1d09e2f96a2786ef Mon Sep 17 00:00:00 2001
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Date: Wed, 28 Mar 2018 13:24:04 +0300
>> Subject: [PATCH] drm/xen-front: Make display_mode_valid static
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> index 545049dfaf0a..bd676be5a0db 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
>> @@ -273,7 +273,7 @@ static void display_update(struct drm_simple_display_pipe *pipe,
>>   	drm_dev_exit(idx);
>>   }
>>   
>> -enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
>> +static enum drm_mode_status display_mode_valid(struct drm_crtc *crtc,
>>   		const struct drm_display_mode *mode)
>>   {
>>   	struct xen_drm_front_drm_pipeline *pipeline =
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
[1] 
https://github.com/freedesktop/drm-misc/commit/0c9c7fd00e17907efb35697ecb9f2df39a0b536c

--------------0F431B0390EA6413AB0422ED
Content-Type: text/x-patch;
 name="0001-drm-xen-front-Free-page-on-event-channel-error-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-drm-xen-front-Free-page-on-event-channel-error-path.pat";
 filename*1="ch"

>From e16847ef23d19106c6855951674624bfd37e4209 Mon Sep 17 00:00:00 2001
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Date: Thu, 29 Mar 2018 08:54:25 +0300
Subject: [PATCH 1/2] drm/xen-front: Free page on event channel error path

While creating an event channel a page was leaked in case
of error. Fix this by freeing the page.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_evtchnl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
index e521785fd22b..02b6f3d9fe4c 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_evtchnl.c
@@ -186,8 +186,10 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 				sring, XEN_PAGE_SIZE);
 
 		ret = xenbus_grant_ring(xb_dev, sring, 1, &gref);
-		if (ret < 0)
+		if (ret < 0) {
+			free_page(page);
 			goto fail;
+		}
 
 		handler = evtchnl_interrupt_ctrl;
 	} else {
@@ -195,8 +197,10 @@ static int evtchnl_alloc(struct xen_drm_front_info *front_info, int index,
 
 		ret = gnttab_grant_foreign_access(xb_dev->otherend_id,
 				virt_to_gfn((void *)page), 0);
-		if (ret < 0)
+		if (ret < 0) {
+			free_page(page);
 			goto fail;
+		}
 
 		gref = ret;
 		handler = evtchnl_interrupt_evt;
-- 
2.7.4


--------------0F431B0390EA6413AB0422ED
Content-Type: text/x-patch;
 name="0002-drm-xen-front-Align-documentation-title-w-other-driv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-drm-xen-front-Align-documentation-title-w-other-driv.pa";
 filename*1="tch"

>From a6668b48003b46cd711f7e56faaf35dbad769c03 Mon Sep 17 00:00:00 2001
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Date: Thu, 29 Mar 2018 09:13:11 +0300
Subject: [PATCH 2/2] drm/xen-front: Align documentation title w/ other drivers

Align title of the documentation for the driver with the rest of the drivers,
e.g. have drm/xen-front in front of the title.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 Documentation/gpu/xen-front.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/xen-front.rst b/Documentation/gpu/xen-front.rst
index 8188e03c9d23..009d942386c5 100644
--- a/Documentation/gpu/xen-front.rst
+++ b/Documentation/gpu/xen-front.rst
@@ -1,6 +1,6 @@
-====================================
-Xen para-virtualized frontend driver
-====================================
+====================================================
+ drm/xen-front Xen para-virtualized frontend driver
+====================================================
 
 This frontend driver implements Xen para-virtualized display
 according to the display protocol described at
-- 
2.7.4


--------------0F431B0390EA6413AB0422ED--

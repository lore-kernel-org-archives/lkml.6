Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30127C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C781B215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C781B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeHOJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:41:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37834 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeHOJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:41:04 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7F6o3tm107845;
        Wed, 15 Aug 2018 01:50:03 -0500
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7F6o2vS020117;
        Wed, 15 Aug 2018 01:50:02 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 15
 Aug 2018 01:50:01 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 15 Aug 2018 01:50:01 -0500
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7F6nxQA023627;
        Wed, 15 Aug 2018 01:49:59 -0500
Subject: Re: [PATCH RFC] driver core: Reprobe consumer if it was unbound by
 dropped device_link
To:     Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>
CC:     Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <cover.1519321145.git.jsarha@ti.com>
 <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
 <20180225092223.GB923@wunner.de>
 <36c24c0e-59a1-12de-cfff-01c942862349@ti.com>
 <CAKMK7uGiYbRCS=eGLPn3XW29VvX3yo5TZVObc5LJJvZf2eswAQ@mail.gmail.com>
From:   Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8e3bbebb-80b6-1747-6a5b-ee63fa70af6c@ti.com>
Date:   Wed, 15 Aug 2018 09:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uGiYbRCS=eGLPn3XW29VvX3yo5TZVObc5LJJvZf2eswAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/18 17:17, Daniel Vetter wrote:
> On Mon, Feb 26, 2018 at 8:52 AM, Jyri Sarha <jsarha@ti.com> wrote:
>> On 25/02/18 11:22, Lukas Wunner wrote:
>>> On Thu, Feb 22, 2018 at 07:42:46PM +0200, Jyri Sarha wrote:
>>>> Put consumer device to deferred probe list if it is unbound due to a
>>>> dropped link to a supplier.
>>>>
>>>> When a device link supplier is unbound (either manually or because one
>>>> of its own suppliers was unbound), its consumers are unbound as
>>>> well. Currently if the supplier binds again after this the consumer
>>>> does not automatically probe again. With this patch it does.
>>>
>>> Yes I think this makes sense, based on the rationale that the consumer
>>> was automatically unbound, so by symmetry it should also be automatically
>>> rebound.
>>>
>>> The only thing I don't understand is you wrote in an earlier e-mail of a
>>> difference in behavior depending on whether driver_deferred_probe_add()
>>> is called before or after device_release_driver_internal().
>>> That's really odd, it shouldn't make a difference.
>>>
>>
>> In that version there was a couple of other bugs elsewhere in the
>> system. I tried to reproduce that situation again multiple times, but I
>> could not (even write those bugs back in there, and move the link
>> creation back to panel bridge code). But even from reading the code that
>> difference did not make any sense. I suspect a heisen-bug, after I have
>> read the code and understood that the crash is not possible, it does not
>> happen anymore :).
>>
>> With the current version I could not find any difference in behaviour
>> depending on the order of device_release_driver_internal() and
>> driver_deferred_probe_add() calls. I just thought having them in this
>> order just lookes nicer.
>>
>> I stress tested the code by unloading and loading the panel driver in a
>> tight loop, for several minutes, but it simply wont crash (not in this
>> setup anyway). The probe of tilcdc eventually gracefully fails in a CMA
>> failure.
> 
> Is this still moving or stuck? Pinging since Sean just brought up the
> drm_bridge lifetime issues, and I think it'd be nice if we could solve
> those by using device_link, like we've added already for drm_panel.
> From my very layman understanding of the discussions, device_link not
> quite working for deferred probing is the blocker for this plan.
> 

I would say stuck. As there is has not been any traffic regarding this
patch after Lukas' reply. And I've been busy with other things since
then. Perhaps I did not know to cc the right people.

A reviewed-by or tested-by from someone would probably help to get this
spinning again. I am happy to do changes or improvements etc., but for
that I would need suggestions.

As far as I can tell the patch is good to apply as it is, but then again
I am no device core expert.

Best regards,
Jyri

> Also adding Sean.
> -Daniel
> 
>>
>> Best regards,
>> Jyri
>>
>>> Thanks,
>>>
>>> Lukas
>>>
>>>>
>>>> If this patch is not acceptable as such, how about adding this
>>>> behavior behind a new device link flag?
>>>>
>>>> The idea to this patch was gotten from this post by Lucas Wunner:
>>>> https://www.spinics.net/lists/dri-devel/msg166318.html
>>>>
>>>> Part of the code and the description is borrowed from him.
>>>>
>>>> cc: Lukas Wunner <lukas@wunner.de>
>>>> cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> cc: Thierry Reding <thierry.reding@gmail.com>
>>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>>> ---
>>>>  drivers/base/base.h | 1 +
>>>>  drivers/base/core.c | 2 ++
>>>>  drivers/base/dd.c   | 2 +-
>>>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>>>> index d800de6..39370eb 100644
>>>> --- a/drivers/base/base.h
>>>> +++ b/drivers/base/base.h
>>>> @@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
>>>>
>>>>  extern void driver_detach(struct device_driver *drv);
>>>>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>>>> +extern void driver_deferred_probe_add(struct device *dev);
>>>>  extern void driver_deferred_probe_del(struct device *dev);
>>>>  static inline int driver_match_device(struct device_driver *drv,
>>>>                                    struct device *dev)
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index b2261f9..0964ed5 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
>>>>
>>>>                      device_release_driver_internal(consumer, NULL,
>>>>                                                     consumer->parent);
>>>> +                    driver_deferred_probe_add(consumer);
>>>> +
>>>>                      put_device(consumer);
>>>>                      goto start;
>>>>              }
>>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>>> index de6fd09..846ae78 100644
>>>> --- a/drivers/base/dd.c
>>>> +++ b/drivers/base/dd.c
>>>> @@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>>>>  }
>>>>  static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>>>>
>>>> -static void driver_deferred_probe_add(struct device *dev)
>>>> +void driver_deferred_probe_add(struct device *dev)
>>>>  {
>>>>      mutex_lock(&deferred_probe_mutex);
>>>>      if (list_empty(&dev->p->deferred_probe)) {
>>
>>
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

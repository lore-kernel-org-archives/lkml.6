Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90441C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACF92151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L4YdPUO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACF92151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeHNREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:04:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38504 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:04:52 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so19777320itb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=umXyBEc0JJbbFgPztlnbgnrZRzrCEdgg6kb2GWDHwww=;
        b=L4YdPUO6teL8AyKAKNzKmfzanTjn5vSaFKUNDfvvQRWcx/20Q9bT972HDJ1BTmBQka
         jiJT85LLSMj0wYpED4fDvVfNrCWcDSbEDZqOt/fsGBR/UH9lKWLepNMvCGI9S11dlL2x
         GXwAqWXdX6qHmSBEyBs1GLclSicX6FLcsW3W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=umXyBEc0JJbbFgPztlnbgnrZRzrCEdgg6kb2GWDHwww=;
        b=jHx4c2je2Tjq5BntIcCjN+2QAUMI3gqTDIog1ya7+r3+RI0CMDW45Pju40R6weeCbQ
         9H14lTA8HZ21p6pneflKGmAI04W6WYfmkIAvpXYsdewJk40V46ehswg80A3sOSTapxqV
         1K1bEypjDhFy7QoifjS2oXF/rp5LPHu5q6cOu/glEhiRLIpxcGK6rFyq9k1XyX9ncQ4R
         SWIdKcw6gLoWpqg+5wUXE5Gv+iI/Nh+mFtvIinP6a+js/yz4mZ3STsDt0+7zX+vTjf4A
         MXp2LIghxd+JpYZSLgDQ6MM8/XnoaqlB57CFVgaGezdNm/McPMeKxhTFlVG9NkUvVGZE
         hweg==
X-Gm-Message-State: AOUpUlE1yL4gBL9fbTly+MhXUIRhAmn5D286mzcylIZ6+Y3Hrvnm+nf5
        YhrMNeqCoKiahaqe8Q9/Nf9I5NLZMcsKvrxWDnNOiw==
X-Google-Smtp-Source: AA+uWPzuMd/LSlEqE6bikbzC09e2PYktzVz6KD0ASHOt+mIVcS8Z5UciowfDopkUg56BBTMP0qv0BWQpy/iHiE/KJNw=
X-Received: by 2002:a24:55d2:: with SMTP id e201-v6mr14472163itb.2.1534256249938;
 Tue, 14 Aug 2018 07:17:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e502:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 07:17:29
 -0700 (PDT)
X-Originating-IP: [2a02:168:56fc:0:d707:d7d8:b180:96e5]
In-Reply-To: <36c24c0e-59a1-12de-cfff-01c942862349@ti.com>
References: <cover.1519321145.git.jsarha@ti.com> <57c1d52a5a8f5985dc1dd53260d7d68795be8ea2.1519321145.git.jsarha@ti.com>
 <20180225092223.GB923@wunner.de> <36c24c0e-59a1-12de-cfff-01c942862349@ti.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 14 Aug 2018 16:17:29 +0200
X-Google-Sender-Auth: ZOfggAXIRBPMPcr2K2NzCgIkRRE
Message-ID: <CAKMK7uGiYbRCS=eGLPn3XW29VvX3yo5TZVObc5LJJvZf2eswAQ@mail.gmail.com>
Subject: Re: [PATCH RFC] driver core: Reprobe consumer if it was unbound by
 dropped device_link
To:     Jyri Sarha <jsarha@ti.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 8:52 AM, Jyri Sarha <jsarha@ti.com> wrote:
> On 25/02/18 11:22, Lukas Wunner wrote:
>> On Thu, Feb 22, 2018 at 07:42:46PM +0200, Jyri Sarha wrote:
>>> Put consumer device to deferred probe list if it is unbound due to a
>>> dropped link to a supplier.
>>>
>>> When a device link supplier is unbound (either manually or because one
>>> of its own suppliers was unbound), its consumers are unbound as
>>> well. Currently if the supplier binds again after this the consumer
>>> does not automatically probe again. With this patch it does.
>>
>> Yes I think this makes sense, based on the rationale that the consumer
>> was automatically unbound, so by symmetry it should also be automatically
>> rebound.
>>
>> The only thing I don't understand is you wrote in an earlier e-mail of a
>> difference in behavior depending on whether driver_deferred_probe_add()
>> is called before or after device_release_driver_internal().
>> That's really odd, it shouldn't make a difference.
>>
>
> In that version there was a couple of other bugs elsewhere in the
> system. I tried to reproduce that situation again multiple times, but I
> could not (even write those bugs back in there, and move the link
> creation back to panel bridge code). But even from reading the code that
> difference did not make any sense. I suspect a heisen-bug, after I have
> read the code and understood that the crash is not possible, it does not
> happen anymore :).
>
> With the current version I could not find any difference in behaviour
> depending on the order of device_release_driver_internal() and
> driver_deferred_probe_add() calls. I just thought having them in this
> order just lookes nicer.
>
> I stress tested the code by unloading and loading the panel driver in a
> tight loop, for several minutes, but it simply wont crash (not in this
> setup anyway). The probe of tilcdc eventually gracefully fails in a CMA
> failure.

Is this still moving or stuck? Pinging since Sean just brought up the
drm_bridge lifetime issues, and I think it'd be nice if we could solve
those by using device_link, like we've added already for drm_panel.
From my very layman understanding of the discussions, device_link not
quite working for deferred probing is the blocker for this plan.

Also adding Sean.
-Daniel

>
> Best regards,
> Jyri
>
>> Thanks,
>>
>> Lukas
>>
>>>
>>> If this patch is not acceptable as such, how about adding this
>>> behavior behind a new device link flag?
>>>
>>> The idea to this patch was gotten from this post by Lucas Wunner:
>>> https://www.spinics.net/lists/dri-devel/msg166318.html
>>>
>>> Part of the code and the description is borrowed from him.
>>>
>>> cc: Lukas Wunner <lukas@wunner.de>
>>> cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> cc: Thierry Reding <thierry.reding@gmail.com>
>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>> ---
>>>  drivers/base/base.h | 1 +
>>>  drivers/base/core.c | 2 ++
>>>  drivers/base/dd.c   | 2 +-
>>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>>> index d800de6..39370eb 100644
>>> --- a/drivers/base/base.h
>>> +++ b/drivers/base/base.h
>>> @@ -114,6 +114,7 @@ extern void device_release_driver_internal(struct device *dev,
>>>
>>>  extern void driver_detach(struct device_driver *drv);
>>>  extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>>> +extern void driver_deferred_probe_add(struct device *dev);
>>>  extern void driver_deferred_probe_del(struct device *dev);
>>>  static inline int driver_match_device(struct device_driver *drv,
>>>                                    struct device *dev)
>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>> index b2261f9..0964ed5 100644
>>> --- a/drivers/base/core.c
>>> +++ b/drivers/base/core.c
>>> @@ -570,6 +570,8 @@ void device_links_unbind_consumers(struct device *dev)
>>>
>>>                      device_release_driver_internal(consumer, NULL,
>>>                                                     consumer->parent);
>>> +                    driver_deferred_probe_add(consumer);
>>> +
>>>                      put_device(consumer);
>>>                      goto start;
>>>              }
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index de6fd09..846ae78 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -140,7 +140,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>>>  }
>>>  static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>>>
>>> -static void driver_deferred_probe_add(struct device *dev)
>>> +void driver_deferred_probe_add(struct device *dev)
>>>  {
>>>      mutex_lock(&deferred_probe_mutex);
>>>      if (list_empty(&dev->p->deferred_probe)) {
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

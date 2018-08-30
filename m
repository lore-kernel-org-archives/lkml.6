Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F35C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A68620645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A68620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeH3Mh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:37:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32934 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3Mh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:37:27 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fvIRC-0003cE-To
        for linux-kernel@vger.kernel.org; Thu, 30 Aug 2018 08:36:23 +0000
Received: by mail-pf1-f200.google.com with SMTP id q21-v6so4371019pff.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3aE21avEOVo0rb89/e5y4ptR+DKkFzWD27rSXvaREKg=;
        b=UksGQQ0czaQK2ul6q1hwdtu5N1VRW4Dw614w4uOefR7ydB6/AhGl2Ae+sUSCeB2q5T
         PyzEsjmq2pzBhGOTqnQMAtmu+XdgNnN+cwSiaqV8SJ5y4j0RT1JJDUKzBrd/+p4XM292
         dt64DhZQeqyb/gfyf35sXKZuq2yzHeIM0FHbGchZnFpgCbuNCMjjcqZ8tQiK/aZjgHnK
         lKGj3EC1NE4Y4nFfrghVIkWi9rSUG9HYOMRuFP9rg9WwQqVFElkC+fhMeVBegAKCksxk
         5hLAjgy80qCR0PwLflPFcXPYsedeBRqSd7Xou3C4NOvNeWheDuhnnpVoEU18bYJ1vyUr
         p2wA==
X-Gm-Message-State: APzg51DA9ZI4AZ/vJaIdKAFQHshhXPRgjw+GXYMZCjz9Pj84OfQ5EZ3X
        Xztpuaktu9sFWm/9YsakF9aaoUuQhbvvVfcgCQez7zWJqHJWT1PF6iCwANVAEwukC99dsfN4kUg
        rWnEfYNQQQDDtnPN5A1/5r4Etq8Qx6y2csif7PJKqHg==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr9235395plo.4.1535618181622;
        Thu, 30 Aug 2018 01:36:21 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdY+fzi13jWyhk3NkAzCcthcdxbOL+brJPXiqiKOVnQt41kNfqwss5EEgNkGGXNdEsv/CSXthg==
X-Received: by 2002:a17:902:8f8c:: with SMTP id z12-v6mr9235374plo.4.1535618181326;
        Thu, 30 Aug 2018 01:36:21 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id v7-v6sm10026401pgh.57.2018.08.30.01.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 01:36:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power
 management
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPDyKFqXBMOP+_1h4WVF1Ob_dhBfr1JC+MFfSYdp1uRmzZhZ-Q@mail.gmail.com>
Date:   Thu, 30 Aug 2018 16:36:16 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Bauer.Chen" <bauer.chen@realtek.com>, ricky_wu@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <3F123073-8A73-4E4C-B4A6-9777022D9927@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
 <20180731061721.15831-5-kai.heng.feng@canonical.com>
 <CAPDyKFqv5apJp=zbyoZi-UE8+omu7JauJ5_7+ymY9B2BSS48bA@mail.gmail.com>
 <E133AFB3-27F6-4DD3-BB85-A85EDB51EE57@canonical.com>
 <CAPDyKFqXBMOP+_1h4WVF1Ob_dhBfr1JC+MFfSYdp1uRmzZhZ-Q@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 14:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 23 August 2018 at 10:03, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>> Hi Ulf,
>>
>> Sorry for the late reply.
>>
>>
>> at 21:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> On 31 July 2018 at 08:17, Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> wrote:
>>>> In order to let host's parent device, rtsx_usb, to use USB remote wake
>>>> up signaling to do card detection, it needs to be suspended. Hence it's
>>>> necessary to add runtime PM support for the memstick host.
>>>>
>>>> To keep memstick host stays suspended when it's not in use, convert the
>>>> card detection function from kthread to delayed_work, which can be
>>>> scheduled when the host is resumed and can be canceled when the host is
>>>> suspended.
>>>>
>>>> Use an idle function check if there's no card and the power mode is
>>>> MEMSTICK_POWER_OFF. If both criteria are met, put the device to suspend.
>>>>
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>>  drivers/memstick/host/rtsx_usb_ms.c | 138 ++++++++++++++--------------
>>>>  1 file changed, 71 insertions(+), 67 deletions(-)
>>>>
>>>> diff --git a/drivers/memstick/host/rtsx_usb_ms.c
>>>> b/drivers/memstick/host/rtsx_usb_ms.c
>>>> index cd12f3d1c088..126eb310980a 100644
>>>> --- a/drivers/memstick/host/rtsx_usb_ms.c
>>>> +++ b/drivers/memstick/host/rtsx_usb_ms.c
>>>> @@ -40,15 +40,14 @@ struct rtsx_usb_ms {
>>>>
>>>>         struct mutex            host_mutex;
>>>>         struct work_struct      handle_req;
>>>> -
>>>> -       struct task_struct      *detect_ms;
>>>> -       struct completion       detect_ms_exit;
>>>> +       struct delayed_work     poll_card;
>>>>
>>>>         u8                      ssc_depth;
>>>>         unsigned int            clock;
>>>>         int                     power_mode;
>>>>         unsigned char           ifmode;
>>>>         bool                    eject;
>>>> +       bool                    suspend;
>>>>  };
>>>>
>>>>  static inline struct device *ms_dev(struct rtsx_usb_ms *host)
>>>> @@ -524,7 +523,7 @@ static void rtsx_usb_ms_handle_req(struct  
>>>> work_struct
>>>> *work)
>>>>         int rc;
>>>>
>>>>         if (!host->req) {
>>>> -               pm_runtime_get_sync(ms_dev(host));
>>>> +               pm_runtime_get_noresume(ms_dev(host));
>>>
>>>
>>> I don't think this is safe.
>>>
>>> The memstick core doesn't manage runtime PM, hence there are no
>>> guarantee that the device is runtime resumed at this point, or is
>>> there?
>>
>>
>> No guarantees there.
>> Right now this only gets call when the host is powered on.
>>
>>>>               do {
>>>>                         rc = memstick_next_req(msh, &host->req);
>>>>                         dev_dbg(ms_dev(host), "next req %d\n", rc);
>>>> @@ -545,7 +544,7 @@ static void rtsx_usb_ms_handle_req(struct  
>>>> work_struct
>>>> *work)
>>>>                                                 host->req->error);
>>>>                         }
>>>>                 } while (!rc);
>>>> -               pm_runtime_put(ms_dev(host));
>>>> +               pm_runtime_put_noidle(ms_dev(host));
>>>
>>>
>>> According to the above, I think this should stay as is. Or perhaps you
>>> want to use pm_runtime_put_sync() instead, as to avoid the device from
>>> being unnecessary resumed and hence also its parent.
>>
>>
>> The tricky part is that pm_runtime_put_sync() calls  
>> rtsx_usb_ms_set_param()
>> which calls pm_runtime_* helpers again
>
> Why does a pm_runtime_put_sync() triggers a call to
> rtsx_usb_ms_set_param()? It should not.
>
> Ahh, that's because you have implemented the ->runtime_suspend()
> callback to wrongly call memstick_suspend_host(). Drop that change,
> then you should be able to call pm_runtime_put_sync() here and at
> other places correctly.

Thanks for the catch! I'll address that.

>
>> So maybe add runtime PM support to memstick core is the only way to  
>> support
>> it properly?
>
> It shouldn't be needed, and I wonder about if the effort is worth it,
> especially since it seems that the only memstick driver that using
> runtime PM is rtsx_usb_ms.
>
> BTW, are you testing this change by using a memstick card, since I
> haven't seen them for ages. :-)

Yes, Realtek borrowed me a MMC/MS combo device to let me work on this.

Kai-Heng

>
> [...]
>
> Kind regards
> Uffe



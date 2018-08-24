Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E58EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6F621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGyKDbvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6F621564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHXKBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:01:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:32909 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeHXKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:01:17 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so3955332ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W8ijDITyOtqKv6E4f3ebHKT/0a/MA/1Zilrht7nVXMI=;
        b=KGyKDbvn5BDPeMlxrFf5dYbBmejqD253nPKcOwa0qEv7h3hfGBxdBHB9nJVkjprwE6
         LR5uyaYJymIHGqiinxhwiBr+1LYQXLw8ZBc4MWJO9pvqTUe0lPcdqQPBu5ehEksmbaEF
         vifl3MK1U0mzf5Gxq/L771Of9ZXqyzEoPlIY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W8ijDITyOtqKv6E4f3ebHKT/0a/MA/1Zilrht7nVXMI=;
        b=gOgATkJ6RH6nIYXnLMNV0TETGLZ6oKXe7A6cxDBIF2oN8sdLta5VHcNpYp3UT07Gdh
         vG0Pdj1dOnzKhQEe6arvsZjJgCyqlxvXPgxY/ngSSBdNfOtSs81hPR2i2FPj7bXt/l1e
         pOYOqJ9axwgUJv1s3x3db9ljDUeQfzT4dlLV7+ftSOTO8jSuvgNu1fGZOJRehbuwZw0V
         1ONIscvhd6zt6/mZ7TDIfcDssQwDh1YEYDr4GCO3pDgo28GoRrPGIRSiRAtXvcpnoyJV
         FhutpQZ43z26+LtV26ytmmtdOKOuSfH00iobHAId5RIL+KgDg9hdsZLD7RfL9Oq/Tk1Y
         FRFA==
X-Gm-Message-State: APzg51DhG4dNlcXsU1IaY7r5pMiyknR04Q5tB7CkdBEKLkzAJ9YI3WCv
        g1uk/pN/QUhWTWEotP9XcvjajXuyL0jgbS/2P0qJE2VQ2HM=
X-Google-Smtp-Source: ANB0VdZ3mkSEiaVUZhfJBjp49blCJEmQjEmgP2Pec1vftySsfNX6IdcBm7MfuQZpAroLcnPzNCTdCMWDRRhdzD6cw5o=
X-Received: by 2002:a24:3fc6:: with SMTP id d189-v6mr414707ita.64.1535092087141;
 Thu, 23 Aug 2018 23:28:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 23:28:06
 -0700 (PDT)
In-Reply-To: <E133AFB3-27F6-4DD3-BB85-A85EDB51EE57@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
 <20180731061721.15831-5-kai.heng.feng@canonical.com> <CAPDyKFqv5apJp=zbyoZi-UE8+omu7JauJ5_7+ymY9B2BSS48bA@mail.gmail.com>
 <E133AFB3-27F6-4DD3-BB85-A85EDB51EE57@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 08:28:06 +0200
Message-ID: <CAPDyKFqXBMOP+_1h4WVF1Ob_dhBfr1JC+MFfSYdp1uRmzZhZ-Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power management
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Bauer.Chen" <bauer.chen@realtek.com>, ricky_wu@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 10:03, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> Hi Ulf,
>
> Sorry for the late reply.
>
>
> at 21:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> On 31 July 2018 at 08:17, Kai-Heng Feng <kai.heng.feng@canonical.com>
>> wrote:
>>>
>>> In order to let host's parent device, rtsx_usb, to use USB remote wake
>>> up signaling to do card detection, it needs to be suspended. Hence it's
>>> necessary to add runtime PM support for the memstick host.
>>>
>>> To keep memstick host stays suspended when it's not in use, convert the
>>> card detection function from kthread to delayed_work, which can be
>>> scheduled when the host is resumed and can be canceled when the host is
>>> suspended.
>>>
>>> Use an idle function check if there's no card and the power mode is
>>> MEMSTICK_POWER_OFF. If both criteria are met, put the device to suspend.
>>>
>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> ---
>>>  drivers/memstick/host/rtsx_usb_ms.c | 138 ++++++++++++++--------------
>>>  1 file changed, 71 insertions(+), 67 deletions(-)
>>>
>>> diff --git a/drivers/memstick/host/rtsx_usb_ms.c
>>> b/drivers/memstick/host/rtsx_usb_ms.c
>>> index cd12f3d1c088..126eb310980a 100644
>>> --- a/drivers/memstick/host/rtsx_usb_ms.c
>>> +++ b/drivers/memstick/host/rtsx_usb_ms.c
>>> @@ -40,15 +40,14 @@ struct rtsx_usb_ms {
>>>
>>>         struct mutex            host_mutex;
>>>         struct work_struct      handle_req;
>>> -
>>> -       struct task_struct      *detect_ms;
>>> -       struct completion       detect_ms_exit;
>>> +       struct delayed_work     poll_card;
>>>
>>>         u8                      ssc_depth;
>>>         unsigned int            clock;
>>>         int                     power_mode;
>>>         unsigned char           ifmode;
>>>         bool                    eject;
>>> +       bool                    suspend;
>>>  };
>>>
>>>  static inline struct device *ms_dev(struct rtsx_usb_ms *host)
>>> @@ -524,7 +523,7 @@ static void rtsx_usb_ms_handle_req(struct work_struct
>>> *work)
>>>         int rc;
>>>
>>>         if (!host->req) {
>>> -               pm_runtime_get_sync(ms_dev(host));
>>> +               pm_runtime_get_noresume(ms_dev(host));
>>
>>
>> I don't think this is safe.
>>
>> The memstick core doesn't manage runtime PM, hence there are no
>> guarantee that the device is runtime resumed at this point, or is
>> there?
>
>
> No guarantees there.
> Right now this only gets call when the host is powered on.
>
>>
>>>                do {
>>>                         rc = memstick_next_req(msh, &host->req);
>>>                         dev_dbg(ms_dev(host), "next req %d\n", rc);
>>> @@ -545,7 +544,7 @@ static void rtsx_usb_ms_handle_req(struct work_struct
>>> *work)
>>>                                                 host->req->error);
>>>                         }
>>>                 } while (!rc);
>>> -               pm_runtime_put(ms_dev(host));
>>> +               pm_runtime_put_noidle(ms_dev(host));
>>
>>
>> According to the above, I think this should stay as is. Or perhaps you
>> want to use pm_runtime_put_sync() instead, as to avoid the device from
>> being unnecessary resumed and hence also its parent.
>
>
> The tricky part is that pm_runtime_put_sync() calls rtsx_usb_ms_set_param()
> which calls pm_runtime_* helpers again

Why does a pm_runtime_put_sync() triggers a call to
rtsx_usb_ms_set_param()? It should not.

Ahh, that's because you have implemented the ->runtime_suspend()
callback to wrongly call memstick_suspend_host(). Drop that change,
then you should be able to call pm_runtime_put_sync() here and at
other places correctly.

>
> So maybe add runtime PM support to memstick core is the only way to support
> it properly?
>

It shouldn't be needed, and I wonder about if the effort is worth it,
especially since it seems that the only memstick driver that using
runtime PM is rtsx_usb_ms.

BTW, are you testing this change by using a memstick card, since I
haven't seen them for ages. :-)

[...]

Kind regards
Uffe

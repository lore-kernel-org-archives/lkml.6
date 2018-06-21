Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C275EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D4B208A6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D4B208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbeFUMER (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:04:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43477 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeFUMEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:04:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id s190-v6so1546831qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 05:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DBDOuyEoYmcB074GVAM+ZPB/JH92msp+g5JD+PEgBV4=;
        b=JJFcVhlxMfUbwWPliZ5F/3BGp4Wb5VE2ASzQHvOVmcxR2w/WS9pYjcYOb+iYPbyU7Z
         cdLFadjWl/HivulhgKqpatCre1dkxExIcp3lqy/jCZqfAjfObf7Smt7i850kMCtewEXa
         SiBg9sqRr+/5YFiouPBeorLQpLQS72GmIGsxbc8H72YbPTovwsV/ubaJ/A9DWi0byd0Z
         aCqam0sk1oxQEWoqj7BpssjFWZIheKpGMUbiTRbLkfFzgZ3nTJfcDL7oviLZdGbOJKB+
         XDKeDwB9lYZmgXW10YfeQ7y8oNi4tHm1vKky6N5mQiD+m5BEf8cZE6IgxByu+Y5twFEB
         bg6A==
X-Gm-Message-State: APt69E3/srbuGmh99wqo4X/fHClw6/3IJvHQdnLU12RmyA2+jIsiLdq4
        Vlu6rxc9B2Nc621TSKVdL9r0Uo/pL5eXJWRurzcC1A==
X-Google-Smtp-Source: ADUXVKK4k3kxn6oJIsthVEZ+0AaXBxQ5TcnpY81YSEh9sjsfQSEMS8a3f6An2hfYf3KM9EaHut3c4TUp0nfiUzWf0/o=
X-Received: by 2002:a37:91c3:: with SMTP id t186-v6mr21869028qkd.37.1529582655447;
 Thu, 21 Jun 2018 05:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2bc7:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 05:04:14
 -0700 (PDT)
In-Reply-To: <4635b69c79704cc3beee5f97d9e739f2@ausx13mpc120.AMER.DELL.COM>
References: <20180531114929.30545-1-benjamin.tissoires@redhat.com> <4635b69c79704cc3beee5f97d9e739f2@ausx13mpc120.AMER.DELL.COM>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 21 Jun 2018 14:04:14 +0200
Message-ID: <CAO-hwJJjD9qsVMM_YRzRDpYiZQVLCGUs-j74=yq_pUdSVLoZ3g@mail.gmail.com>
Subject: Re: [PATCH] HID: core: allow concurrent registration of drivers
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 4, 2018 at 10:37 PM,  <Mario.Limonciello@dell.com> wrote:
> Benjamin,
>
> I had to make a minor change since I didn't see
>>  #define HID_STAT_DUP_DETECTED        BIT(2)
> In Linus's tree.
>
> I tested with master today though and it seems to be working now with your patch across
> several boot attempts.
>
> Tested-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks a lot Mario.

Jiri, I do not see this patch in your tree. Could you take it soon-ish
so we can backport it in 4.17 ASAP?

Cheers,
Benjamin

>
> Thanks,
>
>> -----Original Message-----
>> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
>> Sent: Thursday, May 31, 2018 6:49 AM
>> To: Jiri Kosina; Limonciello, Mario
>> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin Tissoires
>> Subject: [PATCH] HID: core: allow concurrent registration of drivers
>>
>> Detected on the Dell XPS 9365.
>> The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
>> When those 2 devices are presented to the userspace, udev loads both
>> wacom and hid-multitouch. When this happens, the code in
>> __hid_bus_reprobe_drivers() is called concurrently and the second device
>> gets reprobed twice.
>> An other bug in the power_supply subsystem prevent to remove the wacom
>> driver if it just finished its initialization, which basically kills
>> the wacom node.
>>
>> Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")
>>
>> Cc: stable@vger.kernel.org # v4.17
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> ---
>>
>> Hi Mario,
>>
>> can you please test this on your faulty XPS?
>> I think it'll fix the issue, but I can not reproduce, so better wait for
>> your confirmation.
>>
>> Jiri, ideally I would love to see this in v4.17 final, but Mario seems
>> to be on PTO until next week. I guess we'll just push this in v4.17.1
>> then. Also, if you can double check that it makes sense, that would be
>> nice :)
>>
>> Cheers,
>> Benjamin
>>
>>  drivers/hid/hid-core.c | 5 ++++-
>>  include/linux/hid.h    | 3 ++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 2f7367b1de00..7afed0c0f9e5 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1960,6 +1960,8 @@ static int hid_device_probe(struct device *dev)
>>       }
>>       hdev->io_started = false;
>>
>> +     clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
>> +
>>       if (!hdev->driver) {
>>               id = hid_match_device(hdev, hdrv);
>>               if (id == NULL) {
>> @@ -2223,7 +2225,8 @@ static int __hid_bus_reprobe_drivers(struct device *dev,
>> void *data)
>>       struct hid_device *hdev = to_hid_device(dev);
>>
>>       if (hdev->driver == hdrv &&
>> -         !hdrv->match(hdev, hid_ignore_special_drivers))
>> +         !hdrv->match(hdev, hid_ignore_special_drivers) &&
>> +         !test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
>>               return device_reprobe(dev);
>>
>>       return 0;
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index ee2510019033..aee281522c6d 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -517,6 +517,7 @@ struct hid_output_fifo {
>>  #define HID_STAT_ADDED               BIT(0)
>>  #define HID_STAT_PARSED              BIT(1)
>>  #define HID_STAT_DUP_DETECTED        BIT(2)
>> +#define HID_STAT_REPROBED    BIT(3)
>>
>>  struct hid_input {
>>       struct list_head list;
>> @@ -585,7 +586,7 @@ struct hid_device {
>>               /* device report descriptor */
>>       bool battery_avoid_query;
>>  #endif
>>
>> -     unsigned int status;                                            /* see
>> STAT flags above */
>> +     unsigned long status;                                           /* see
>> STAT flags above */
>>       unsigned claimed;                                               /*
>> Claimed by hidinput, hiddev? */
>>       unsigned quirks;                                                /* Various
>> quirks the device can pull on us */
>>       bool io_started;                                                /* If IO has started
>> */
>> --
>> 2.14.3
>

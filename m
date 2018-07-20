Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD04ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D341620673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 02:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfhh2lAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D341620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGTDaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 23:30:55 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34642 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbeGTDaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 23:30:55 -0400
Received: by mail-yb0-f193.google.com with SMTP id e9-v6so4106174ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YjBp1fZI2B0hZ/Jq/mAFr0aWUwtn99NicIyIcGZqrf0=;
        b=Tfhh2lAUqY+SlEmR/anZMh8ZLEnWOjD0kCr4ik9onFLrv9NgXG1tWY2BjdbEuYRGvl
         KAOFG4/Fdj/xP47Uam19JQH9wLqGppVZkUY1ElYtkO2wNxWmPRPOMYyez8HqgsFgulJf
         Gwxnu6QbaEIBgqADjs1sY0HC1dWmIN6DGoPZ06/WrfQaX0yuuX6bjLZC3aW2Px9HyQQm
         A8wc7dbcvbcMBMlAXHJ3sTe1s0dxOuN+xDZNUa3OK7l+ZkbQ4ValgGdoUj8bo8DKeEMh
         5Q4aXefD+ZGsHyaVUSBXgl63tpRY9veTMUbflpEbQ+0yvhToYLGh6cUUxq3QOEhoj31G
         O86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YjBp1fZI2B0hZ/Jq/mAFr0aWUwtn99NicIyIcGZqrf0=;
        b=ZvabFQPkaF0CgSSW6j/tTiJV+dSkcwMfKZtiU4+duXtR9dDhb1wvMBw44pOSZyyVO5
         ACcgb6ag1MK9j/ju68pSQSfssQJ5gAb4RU2PziGA+snPcfGVeUwleZ2vZ+JgD9BcsB2t
         W9HoTSD0McSXfu/Pzs4DzAmX8c05Bj1fsxIw5PJHefmqvOr1h8et3xxAuN+/00oU/xrX
         SuDAm9YhnXw6Tx4noxt4xM87hzRKlaZysJ3C1Eoh72lVq7i8A9Azmlck8/IZ9PBTjlFA
         p/+eSVbXEplXwxKDbTyIkMkXXemGvvdG8/za4EucG1eCkBpvvieTUVA91rkprmCgNuqd
         /dDg==
X-Gm-Message-State: AOUpUlHlnHrH5jAsA+khSGYrpLOPyOa0gP/WlXUPBsILpYECdVbgr/6T
        WfAUCvmegu+Axx+P2/Dl0mcObH2/1ym3PZvw7N0=
X-Google-Smtp-Source: AAOMgpdxukv6UnxQM8JxGYlVS5HRrdNHDpVZDvc1jqoUfbs4yWA8I5eZs2e9qrYOZPL4RcMOzh2lcMOsZ1BfnWF519E=
X-Received: by 2002:a25:e406:: with SMTP id b6-v6mr89988ybh.397.1532054694503;
 Thu, 19 Jul 2018 19:44:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 19:44:53
 -0700 (PDT)
In-Reply-To: <20180719093743.GC14301@kroah.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com> <20180717205712.29495-18-toddpoynor@gmail.com>
 <20180719093743.GC14301@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Thu, 19 Jul 2018 19:44:53 -0700
Message-ID: <CAO3upoYdSkDqyLtD8cQh4kws5gdOcAEPSUHnsru23Uo=3c-uMQ@mail.gmail.com>
Subject: Re: [PATCH 17/32] staging: gasket: annotate ioctl arg with __user
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 2:37 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 17, 2018 at 01:56:57PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> For sparse checking.
>
> Close, but you can do better :)
>
>>
>> Reported-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>> ---
>>  drivers/staging/gasket/apex_driver.c  | 11 ++--
>>  drivers/staging/gasket/gasket_core.c  |  6 ++-
>>  drivers/staging/gasket/gasket_core.h  |  4 +-
>>  drivers/staging/gasket/gasket_ioctl.c | 72 ++++++++++++++-------------
>>  drivers/staging/gasket/gasket_ioctl.h |  4 +-
>>  5 files changed, 52 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
>> index 612b3ab803196..c91c5aff5ab9c 100644
>> --- a/drivers/staging/gasket/apex_driver.c
>> +++ b/drivers/staging/gasket/apex_driver.c
>> @@ -5,6 +5,7 @@
>>   * Copyright (C) 2018 Google, Inc.
>>   */
>>
>> +#include <linux/compiler.h>
>>  #include <linux/delay.h>
>>  #include <linux/fs.h>
>>  #include <linux/init.h>
>> @@ -142,9 +143,9 @@ static int apex_get_status(struct gasket_dev *gasket_dev);
>>
>>  static uint apex_ioctl_check_permissions(struct file *file, uint cmd);
>>
>> -static long apex_ioctl(struct file *file, uint cmd, ulong arg);
>> +static long apex_ioctl(struct file *file, uint cmd, void __user *arg);
>>
>> -static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg);
>> +static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg);
>
> Make this a __user pointer to the correct struct type you are handling
> here.  You know what the type is, use it.

Got it.

>
>>  static int apex_enter_reset(struct gasket_dev *gasket_dev, uint type);
>>
>> @@ -635,7 +636,7 @@ static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>>  /*
>>   * Apex-specific ioctl handler.
>>   */
>> -static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
>> +static long apex_ioctl(struct file *filp, uint cmd, void __user *arg)
>>  {
>>       struct gasket_dev *gasket_dev = filp->private_data;
>>
>> @@ -655,7 +656,7 @@ static long apex_ioctl(struct file *filp, uint cmd, ulong arg)
>>   * @gasket_dev: Gasket device pointer.
>>   * @arg: User ioctl arg, in this case to a apex_gate_clock_ioctl struct.
>>   */
>> -static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
>> +static long apex_clock_gating(struct gasket_dev *gasket_dev, void __user *arg)
>
> As above, this should be a different type.
>
>>  {
>>       struct apex_gate_clock_ioctl ibuf;
>>
>> @@ -663,7 +664,7 @@ static long apex_clock_gating(struct gasket_dev *gasket_dev, ulong arg)
>>               return 0;
>>
>>       if (allow_sw_clock_gating) {
>> -             if (copy_from_user(&ibuf, (void __user *)arg, sizeof(ibuf)))
>> +             if (copy_from_user(&ibuf, arg, sizeof(ibuf)))
>>                       return -EFAULT;
>>
>>               gasket_log_error(
>> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> index 947b4fcc76970..ff34af42bbe7c 100644
>> --- a/drivers/staging/gasket/gasket_core.c
>> +++ b/drivers/staging/gasket/gasket_core.c
>> @@ -14,6 +14,7 @@
>>  #include "gasket_page_table.h"
>>  #include "gasket_sysfs.h"
>>
>> +#include <linux/compiler.h>
>>  #include <linux/delay.h>
>>  #include <linux/fs.h>
>>  #include <linux/init.h>
>> @@ -1823,14 +1824,15 @@ static long gasket_ioctl(struct file *filp, uint cmd, ulong arg)
>>                * check_and_invoke_callback.
>>                */
>>               if (driver_desc->ioctl_handler_cb)
>> -                     return driver_desc->ioctl_handler_cb(filp, cmd, arg);
>> +                     return driver_desc->ioctl_handler_cb(
>> +                         filp, cmd, (void __user *)arg);
>
> You can use a temp variable and then only have to cast things once then,
> instead of twice, if you care.  Not a big deal.

But then I have to name it, and I suck at that. :P  I'm trying
switching to "arg" for ulong/int arguments and "argp" for pointer
arguments.

>
>>
>>               gasket_log_error(
>>                       gasket_dev, "Received unknown ioctl 0x%x", cmd);
>
> This is a fun way to cause a DoS on your system, you should fix this up
> in later changes.

Yeah there's another patch coming soon that converts a bunch of errors
and infos to debugs.

>
>>               return -EINVAL;
>>       }
>>
>> -     return gasket_handle_ioctl(filp, cmd, arg);
>> +     return gasket_handle_ioctl(filp, cmd, (void __user *)arg);
>>  }
>>
>>  int gasket_reset(struct gasket_dev *gasket_dev, uint reset_type)
>> diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
>> index 50ad0c8853183..68b4d2ac9fd6c 100644
>> --- a/drivers/staging/gasket/gasket_core.h
>> +++ b/drivers/staging/gasket/gasket_core.h
>> @@ -315,7 +315,7 @@ struct gasket_dev {
>>
>>  /* Type of the ioctl permissions check callback. See below. */
>>  typedef int (*gasket_ioctl_permissions_cb_t)(
>> -     struct file *filp, uint cmd, ulong arg);
>> +     struct file *filp, uint cmd, void __user *arg);
>>
>>  /*
>>   * Device type descriptor.
>> @@ -549,7 +549,7 @@ struct gasket_driver_desc {
>>        * return -EINVAL. Should return an error status (either -EINVAL or
>>        * the error result of the ioctl being handled).
>>        */
>> -     long (*ioctl_handler_cb)(struct file *filp, uint cmd, ulong arg);
>> +     long (*ioctl_handler_cb)(struct file *filp, uint cmd, void __user *arg);
>
> Why are you not using the typedef above?

There's a typedef for the permissions check callback, but not for the
handler callback.  It's a bit confusing, so I tried adding a typedef
for the handler, but now checkpatch is spanking me for adding new
typedefs -- maybe I should drop the existing typedef?

>
>>
>>       /*
>>        * device_status_cb: Callback to determine device health.
>> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
>> index d0fa05b8bf1d3..ab2376c32c00b 100644
>> --- a/drivers/staging/gasket/gasket_ioctl.c
>> +++ b/drivers/staging/gasket/gasket_ioctl.c
>> @@ -7,6 +7,7 @@
>>  #include "gasket_interrupt.h"
>>  #include "gasket_logging.h"
>>  #include "gasket_page_table.h"
>> +#include <linux/compiler.h>
>>  #include <linux/fs.h>
>>  #include <linux/uaccess.h>
>>
>> @@ -23,17 +24,18 @@
>>  #endif
>>
>>  static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd);
>> -static int gasket_set_event_fd(struct gasket_dev *dev, ulong arg);
>> +static int gasket_set_event_fd(struct gasket_dev *dev, void __user *arg);
>>  static int gasket_read_page_table_size(
>> -     struct gasket_dev *gasket_dev, ulong arg);
>> +     struct gasket_dev *gasket_dev, void __user *arg);
>>  static int gasket_read_simple_page_table_size(
>> -     struct gasket_dev *gasket_dev, ulong arg);
>> +     struct gasket_dev *gasket_dev, void __user *arg);
>>  static int gasket_partition_page_table(
>> -     struct gasket_dev *gasket_dev, ulong arg);
>> -static int gasket_map_buffers(struct gasket_dev *gasket_dev, ulong arg);
>> -static int gasket_unmap_buffers(struct gasket_dev *gasket_dev, ulong arg);
>> +     struct gasket_dev *gasket_dev, void __user *arg);
>> +static int gasket_map_buffers(struct gasket_dev *gasket_dev, void __user *arg);
>> +static int gasket_unmap_buffers(struct gasket_dev *gasket_dev,
>> +                             void __user *arg);
>>  static int gasket_config_coherent_allocator(
>> -     struct gasket_dev *gasket_dev, ulong arg);
>> +     struct gasket_dev *gasket_dev, void __user *arg);
>
>
> For most of these you know the real type, please just use it.

Roger.

>
>>  /*
>>   * standard ioctl dispatch function.
>> @@ -43,9 +45,10 @@ static int gasket_config_coherent_allocator(
>>   *
>>   * Standard ioctl dispatcher; forwards operations to individual handlers.
>>   */
>> -long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
>> +long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *arg)
>>  {
>>       struct gasket_dev *gasket_dev;
>> +     ulong intarg = (ulong)arg;
>
> Ick, really?  That's a horrible name for a variable, especially as it
> doesn't describe what it is...
>
> and "unsigned long" please, ulong is not a "real" kernel type.
>
>>       int retval;
>>
>>       gasket_dev = (struct gasket_dev *)filp->private_data;
>> @@ -74,16 +77,16 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
>>        */
>>       switch (cmd) {
>>       case GASKET_IOCTL_RESET:
>> -             trace_gasket_ioctl_integer_data(arg);
>> -             retval = gasket_reset(gasket_dev, arg);
>> +             trace_gasket_ioctl_integer_data(intarg);
>> +             retval = gasket_reset(gasket_dev, intarg);
>>               break;
>>       case GASKET_IOCTL_SET_EVENTFD:
>>               retval = gasket_set_event_fd(gasket_dev, arg);
>>               break;
>>       case GASKET_IOCTL_CLEAR_EVENTFD:
>> -             trace_gasket_ioctl_integer_data(arg);
>> +             trace_gasket_ioctl_integer_data(intarg);
>>               retval = gasket_interrupt_clear_eventfd(
>> -                     gasket_dev->interrupt_data, (int)arg);
>> +                     gasket_dev->interrupt_data, (int)intarg);
>
> See, look at that cast, why would you ever think to cast a variabled
> with "int" in the name of it, to an int?  Naming is hard :(

Yeah now that I look at it that was a pretty horrible name.  I hate
naming things.

>
>
>>               break;
>>       case GASKET_IOCTL_PARTITION_PAGE_TABLE:
>>               trace_gasket_ioctl_integer_data(arg);
>> @@ -91,7 +94,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, ulong arg)
>>               break;
>>       case GASKET_IOCTL_NUMBER_PAGE_TABLES:
>>               trace_gasket_ioctl_integer_data(gasket_dev->num_page_tables);
>> -             if (copy_to_user((void __user *)arg,
>> +             if (copy_to_user(arg,
>>                                &gasket_dev->num_page_tables,
>
> Nit, you can move this line up one now.

OK.

>
> I'll stop now, you get the idea.  This should be broken up a lot.

I'll split up in some fashion.

Thanks -- Todd

>
> thanks,
>
> greg k-h

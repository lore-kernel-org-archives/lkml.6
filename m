Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5972084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2pKqgjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5972084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGTAcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:32:47 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38323 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeGTAcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:32:46 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so3978436ybo.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lHoXsuv8lFp0q5YmO0RkRLhIog8Cm0pOg5mv2JiPR5c=;
        b=l2pKqgjvnClZMbd+PF6gZN1jsHEz3YkmoMzfKMp8v52CuVMPWpbMMyq0PEwbOMMF1d
         0dAb7sDuXoqhlu3q1+t3XpjcDdeDXPXG5GBEBpCx+x75KlHw+pY479W622vE8M4gKSjJ
         w3ZOnP0MdXN6xOGL32+wuBLbEKUm8wDtVFQMrGg/kzYjYdXIYg9GEPalsxxgG816mCG6
         a6rGoyjAHq7RYhy4d6ZdVnQrUKylHqEPmFkkkHZZV+lU8fJ8vE3aR4KstKMdDUaflzPM
         WMMu7ItTTDI2flwAOKNg2sYmN8DdPkDXmYtwXGKIcouPPDm01XvmUWGX1NGqsDsGf+A2
         o6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lHoXsuv8lFp0q5YmO0RkRLhIog8Cm0pOg5mv2JiPR5c=;
        b=kavBl2EZU5GQGAULnxaD6yKqjaLRplEx6KW/wWjJ9MDUeEwUO9lCxitjoiOdMkja09
         3r9B9TPHr9udpqP3LdbYudEarPyXo7uA14EBFrkwemoLG7oh65aq+vCdYGwNhd86qp52
         Pb3QBgyqebjkajDg8TlwLkuzBDzaS/Urp9tmuncFzaojnAKFTndtUBpTV9tSHzcPPeR5
         P5o0lAv18KmwpzP/lja9/D8wxX0kA5ZPSERuZBm0WeQzT3XqUbR5by7Gdhhge98t1BVN
         ONbZ4zloXd2Q5JKb3USik0M6KIOulCsu+x6k1fgLWbyHKr2RVg5+Az0T2PvtYqfThUiK
         ntoQ==
X-Gm-Message-State: AOUpUlGiLTTVFwRV5gL7Koiht3iMCdp+YodPk1DK/cGp5w6Itfz8rT2S
        yCg5yfOu+UUw5PcaxkWN4lxjIcdNIh+rd1fkG/Q=
X-Google-Smtp-Source: AAOMgpcvw7CdsFiAAT/TuBaRPjJ75pKpZK5NIIUIzKHheAWQDNt4zJZTZRav8KdEFiSLmif/4JuArdvShETrEjHbkPU=
X-Received: by 2002:a25:9c44:: with SMTP id x4-v6mr3062557ybo.230.1532044038114;
 Thu, 19 Jul 2018 16:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 16:47:17
 -0700 (PDT)
In-Reply-To: <20180719092930.GB14301@kroah.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com> <20180717205712.29495-17-toddpoynor@gmail.com>
 <20180719092930.GB14301@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Thu, 19 Jul 2018 16:47:17 -0700
Message-ID: <CAO3upoYkfoxu7xas24Mc14fCLJRjL9ZRwURF1kh-=rTgbDdA3A@mail.gmail.com>
Subject: Re: [PATCH 16/32] staging: gasket: always allow root open for write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 2:29 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 17, 2018 at 01:56:56PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Always allow root to open device for writing.
>>
>> Drop special-casing of ioctl permissions for root vs. owner.
>>
>> Reported-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> ---
>>  drivers/staging/gasket/apex_driver.c  |  9 +--------
>>  drivers/staging/gasket/gasket_core.c  |  8 +++++---
>>  drivers/staging/gasket/gasket_ioctl.c | 19 ++++++++-----------
>>  3 files changed, 14 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
>> index 3a83c3d4d5561..612b3ab803196 100644
>> --- a/drivers/staging/gasket/apex_driver.c
>> +++ b/drivers/staging/gasket/apex_driver.c
>> @@ -629,14 +629,7 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>>   */
>>  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>>  {
>> -     struct gasket_dev *gasket_dev = filp->private_data;
>> -     int root = capable(CAP_SYS_ADMIN);
>> -     int is_owner = gasket_dev->dev_info.ownership.is_owned &&
>> -                    current->tgid == gasket_dev->dev_info.ownership.owner;
>> -
>> -     if (root || is_owner)
>> -             return 1;
>> -     return 0;
>> +     return !!(filp->f_mode & FMODE_WRITE);
>
> Shouldn't this return a boolean instead of uint?

There's a patch farther down in the stack that does that, I wasn't
sure if I should collapse the two things together into a single patch,
will fold that patch into this one.

>
>>  }
>>
>>  /*
>> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> index 0d5ba7359af73..947b4fcc76970 100644
>> --- a/drivers/staging/gasket/gasket_core.c
>> +++ b/drivers/staging/gasket/gasket_core.c
>> @@ -1085,6 +1085,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
>>       char task_name[TASK_COMM_LEN];
>>       struct gasket_cdev_info *dev_info =
>>           container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
>> +     int is_root = capable(CAP_SYS_ADMIN);
>>
>>       gasket_dev = dev_info->gasket_dev_ptr;
>>       driver_desc = gasket_dev->internal_desc->driver_desc;
>> @@ -1098,7 +1099,7 @@ static int gasket_open(struct inode *inode, struct file *filp)
>>               "Attempting to open with tgid %u (%s) (f_mode: 0%03o, "
>>               "fmode_write: %d is_root: %u)",
>>               current->tgid, task_name, filp->f_mode,
>> -             (filp->f_mode & FMODE_WRITE), capable(CAP_SYS_ADMIN));
>> +             (filp->f_mode & FMODE_WRITE), is_root);
>>
>>       /* Always allow non-writing accesses. */
>>       if (!(filp->f_mode & FMODE_WRITE)) {
>> @@ -1112,8 +1113,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
>>               gasket_dev, "Current owner open count (owning tgid %u): %d.",
>>               ownership->owner, ownership->write_open_count);
>>
>> -     /* Opening a node owned by another TGID is an error (even root.) */
>> -     if (ownership->is_owned && ownership->owner != current->tgid) {
>> +     /* Opening a node owned by another TGID is an error (unless root) */
>> +     if (ownership->is_owned && ownership->owner != current->tgid &&
>> +         !is_root) {
>>               gasket_log_error(
>>                       gasket_dev,
>>                       "Process %u is opening a node held by %u.",
>> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
>> index 0c2f85cf54480..d0fa05b8bf1d3 100644
>> --- a/drivers/staging/gasket/gasket_ioctl.c
>> +++ b/drivers/staging/gasket/gasket_ioctl.c
>> @@ -171,7 +171,7 @@ long gasket_is_supported_ioctl(uint cmd)
>>   */
>>  static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
>>  {
>
> Also return bool?

Will fix, I had meant to send a patch for this, will just do that here.

>
>> -     uint alive, root, device_owner;
>> +     uint alive;
>>       fmode_t read, write;
>>       struct gasket_dev *gasket_dev = (struct gasket_dev *)filp->private_data;
>>
>> @@ -183,33 +183,30 @@ static uint gasket_ioctl_check_permissions(struct file *filp, uint cmd)
>>                       alive, gasket_dev->status);
>>       }
>>
>> -     root = capable(CAP_SYS_ADMIN);
>> -     read = filp->f_mode & FMODE_READ;
>> -     write = filp->f_mode & FMODE_WRITE;
>> -     device_owner = (gasket_dev->dev_info.ownership.is_owned &&
>> -                     current->tgid == gasket_dev->dev_info.ownership.owner);
>> +     read = !!(filp->f_mode & FMODE_READ);
>> +     write = !!(filp->f_mode & FMODE_WRITE);
>
> These should be bool as well, right?

Right.

>
> I'll drop this patch, thanks.
>
> greg k-h



-- 
Todd

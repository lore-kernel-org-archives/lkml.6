Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E6C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1014214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/uAJ0IO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1Mvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:51:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42982 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Mvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:51:46 -0500
Received: by mail-vk1-f193.google.com with SMTP id y14so3626662vky.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=833JmPXDfJK1xDvNV+XcS+Li/zEUd/at/EpZqv41oCo=;
        b=V/uAJ0IO8hCuHa618VVGjrc1hc9Pr77XLOlzlEBCOqbpLbmj+NWISWccMZd/HnUHnr
         FvpDPqpDwYPTwjYBNM9lErMvtNW+cBq5c28ineWSb3SrrHVqJa1lyE3FKLsuiFlPQYNA
         Grm//rlFQCxONouZ8B2nTMbxRSLyAdWIOA+kG9epY4MiVfIybHn5kR9hwFFHx4j2Upv8
         aSSRudtFuYVpkfKjd0NmWhDdJSd6wyhsfdMderbZ5pdP3Xk8sc5z3JL98v0V11evM7wk
         tHOinyVg12LVsmwGrE8twtttN5eAdN2JR5aiv3gPaOswc+5Di8kzSs1JlEGURdoli9yt
         7sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=833JmPXDfJK1xDvNV+XcS+Li/zEUd/at/EpZqv41oCo=;
        b=qr/JnwJsSS/wT9ft6sOaWmqcv/f6IK1NQIYzJP9KusjUCSQSLHd4qgYA6p/ZYPaur4
         //NErmhmhfcubXh8ssRtS6IstqTAA1UPmctUhDK0yETA0IHu6MbVS2eHSgGsvtVj+FvN
         S98RTolfDbERO6k6s9EfPpVfNPwBXvzWYNYFGF1hB9s1PLRgfp9kXKE/Pijtrq89YBLc
         5XHgT6IAGk/bDjw3Sl+fKkcgkFhNI3Ky6UZ+BOqoyq0JVSel4c8KWOBCasF8mAiHIziU
         /d3ZsIh1Ou3ZactLofJFNk6nAVAHvOwRAg1SB9t9laBMJeqIIjcK6A83WGAGl0uPgPE/
         kzUg==
X-Gm-Message-State: AJcUukd27GzRJYSA+3syqdV0XNQbk9P45jDbvv5DjkQfC4iRjbf/wEVd
        8SvZd5tPR7KOKnmWIJnmTdS/jW2T31oFXfHePplSZQub
X-Google-Smtp-Source: ALg8bN7AULTRYuGxMamVIiAtEcVHvnjPw4IwKnE0wzfzAye34DkzAlrROyVrR6wZ1apctxaIPCjmbmYu3KepOi5iG9k=
X-Received: by 2002:a1f:b248:: with SMTP id b69mr8551489vkf.30.1548679904158;
 Mon, 28 Jan 2019 04:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20190123000057.31477-1-oded.gabbay@gmail.com> <20190123000057.31477-11-oded.gabbay@gmail.com>
 <20190127075059.GA28461@rapoport-lnx>
In-Reply-To: <20190127075059.GA28461@rapoport-lnx>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 28 Jan 2019 14:53:16 +0200
Message-ID: <CAFCwf13xG4oV-1q6yqRCPcqW2j_SBdN2oR8R6vyb=20rKijK_g@mail.gmail.com>
Subject: Re: [PATCH 10/15] habanalabs: add device reset support
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 9:51 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Wed, Jan 23, 2019 at 02:00:52AM +0200, Oded Gabbay wrote:
> > This patch adds support for doing various on-the-fly reset of Goya.
> >
> > The driver supports two types of resets:
> > 1. soft-reset
> > 2. hard-reset
> >
> > Soft-reset is done when the device detects a timeout of a command
> > submission that was given to the device. The soft-reset process only resets
> > the engines that are relevant for the submission of compute jobs, i.e. the
> > DMA channels, the TPCs and the MME. The purpose is to bring the device as
> > fast as possible to a working state.
> >
> > Hard-reset is done in several cases:
> > 1. After soft-reset is done but the device is not responding
> > 2. When fatal errors occur inside the device, e.g. ECC error
> > 3. When the driver is removed
> >
> > Hard-reset performs a reset of the entire chip except for the PCI
> > controller and the PLLs. It is a much longer process then soft-reset but it
> > helps to recover the device without the need to reboot the Host.
> >
> > After hard-reset, the driver will restore the max power attribute and in
> > case of manual power management, the frequencies that were set.
> >
> > This patch also adds two entries to the sysfs, which allows the root user
> > to initiate a soft or hard reset.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/command_buffer.c  |  11 +-
> >  drivers/misc/habanalabs/device.c          | 308 +++++++++++++++++++++-
> >  drivers/misc/habanalabs/goya/goya.c       | 201 ++++++++++++++
> >  drivers/misc/habanalabs/goya/goya_hwmgr.c |  18 +-
> >  drivers/misc/habanalabs/habanalabs.h      |  35 +++
> >  drivers/misc/habanalabs/habanalabs_drv.c  |   9 +-
> >  drivers/misc/habanalabs/hwmon.c           |   4 +-
> >  drivers/misc/habanalabs/irq.c             |  31 +++
> >  drivers/misc/habanalabs/sysfs.c           | 120 ++++++++-
> >  9 files changed, 712 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
> > index 535ed6cc5bda..700c6da01188 100644
> > --- a/drivers/misc/habanalabs/command_buffer.c
> > +++ b/drivers/misc/habanalabs/command_buffer.c
> > @@ -81,9 +81,10 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
> >       bool alloc_new_cb = true;
> >       int rc;
> >
> > -     if (hdev->disabled) {
> > +     if ((hdev->disabled) || ((atomic_read(&hdev->in_reset)) &&
> > +                                     (ctx_id != HL_KERNEL_ASID_ID))) {
> >               dev_warn_ratelimited(hdev->dev,
> > -                     "Device is disabled !!! Can't create new CBs\n");
> > +                     "Device is disabled or in reset !!! Can't create new CBs\n");
> >               rc = -EBUSY;
> >               goto out_err;
> >       }
> > @@ -187,6 +188,12 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
> >       u64 handle;
> >       int rc;
> >
> > +     if (hdev->hard_reset_pending) {
> > +             dev_crit_ratelimited(hdev->dev,
> > +                     "Device HARD reset pending !!! Please close FD\n");
> > +             return -ENODEV;
> > +     }
>
> Probably this check should be done at the top-level ioctl()?
fixed
> And, what will happen if the devices performs hard reset, but the used
> keeps the file descriptor open?
I take care of that in the reset function. Basically, I don't do the
hard-reset until all user processes (and currently I only support a
single one) close their FDs.
And if they don't close it after a timeout, I kill the user processes.
Take a look at hl_device_hard_reset_pending()
>
> > +
> >       switch (args->in.op) {
> >       case HL_CB_OP_CREATE:
> >               rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
> > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > index ff7b610f18c4..00fde57ce823 100644
> > --- a/drivers/misc/habanalabs/device.c
> > +++ b/drivers/misc/habanalabs/device.c
> > @@ -188,6 +188,7 @@ static int device_early_init(struct hl_device *hdev)
> >
> >       mutex_init(&hdev->device_open);
> >       mutex_init(&hdev->send_cpu_message_lock);
> > +     atomic_set(&hdev->in_reset, 0);
> >       atomic_set(&hdev->fd_open_cnt, 0);
> >
> >       return 0;
> > @@ -238,6 +239,27 @@ static void set_freq_to_low_job(struct work_struct *work)
> >                       usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
> >  }
> >
> > +static void hl_device_heartbeat(struct work_struct *work)
> > +{
> > +     struct hl_device *hdev = container_of(work, struct hl_device,
> > +                                             work_heartbeat.work);
> > +
> > +     if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
> > +             goto reschedule;
> > +
> > +     if (!hdev->asic_funcs->send_heartbeat(hdev))
> > +             goto reschedule;
>
> AFAIU, asic_funcs->send_heartbeat() it set once at init time. The work
> should not be scheduled it it's NULL, I suppose.
I don't check her if the function pointer is NULL. I check the return
value of the call to the function. The function itself is always
implemented

>
> > +
> > +     dev_err(hdev->dev, "Device heartbeat failed !!!\n");
> > +     hl_device_reset(hdev, true, false);
> > +
> > +     return;
> > +
> > +reschedule:
> > +     schedule_delayed_work(&hdev->work_heartbeat,
> > +                     usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
> > +}
> > +
> >  /**
> >   * device_late_init - do late stuff initialization for the habanalabs device
> >   *
> > @@ -273,6 +295,12 @@ static int device_late_init(struct hl_device *hdev)
> >       schedule_delayed_work(&hdev->work_freq,
> >                       usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
> >
> > +     if (hdev->heartbeat) {
> > +             INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
> > +             schedule_delayed_work(&hdev->work_heartbeat,
> > +                             usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
> > +     }
> > +
> >       hdev->late_init_done = true;
> >
> >       return 0;
> > @@ -290,6 +318,8 @@ static void device_late_fini(struct hl_device *hdev)
> >               return;
> >
> >       cancel_delayed_work_sync(&hdev->work_freq);
> > +     if (hdev->heartbeat)
> > +             cancel_delayed_work_sync(&hdev->work_heartbeat);
> >
> >       if (hdev->asic_funcs->late_fini)
> >               hdev->asic_funcs->late_fini(hdev);
> > @@ -397,6 +427,254 @@ int hl_device_resume(struct hl_device *hdev)
> >       return 0;
> >  }
> >
> > +static void hl_device_hard_reset_pending(struct work_struct *work)
> > +{
> > +     struct hl_device_reset_work *device_reset_work =
> > +             container_of(work, struct hl_device_reset_work, reset_work);
> > +     struct hl_device *hdev = device_reset_work->hdev;
> > +     u16 pending_cnt = HL_PENDING_RESET_PER_SEC;
> > +     struct task_struct *task = NULL;
> > +
> > +     /* Flush all processes that are inside hl_open */
> > +     mutex_lock(&hdev->device_open);
> > +
> > +     while ((atomic_read(&hdev->fd_open_cnt)) && (pending_cnt)) {
> > +
> > +             pending_cnt--;
> > +
> > +             dev_info(hdev->dev,
> > +                     "Can't HARD reset, waiting for user to close FD\n");
> > +             ssleep(1);
> > +     }
> > +
> > +     if (atomic_read(&hdev->fd_open_cnt)) {
> > +             task = get_pid_task(hdev->user_ctx->hpriv->taskpid,
> > +                                     PIDTYPE_PID);
> > +             if (task) {
> > +                     dev_info(hdev->dev, "Killing user processes\n");
> > +                     send_sig(SIGKILL, task, 1);
>
> Shouldn't the user get a chance for cleanup?
I give them 5 seconds - It's eternity :)
This is a question where I deliberated with myself a lot about. Should
I kill the process to do the hard-reset automatically, or wait until
the FD is closed, and potentially never hard-reset because the user
will never close the FD.
Currently I decided to do the former. I guess that if users won't like
this behavior, I may add a kernel parameter to control this behavior.

>
> > +                     msleep(100);
> > +
> > +                     put_task_struct(task);
> > +             }
> > +     }
> > +
> > +     mutex_unlock(&hdev->device_open);
> > +
> > +     hl_device_reset(hdev, true, true);
> > +
> > +     kfree(device_reset_work);
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
> > index 866d1774b2e4..9482dbb2e03a 100644
> > --- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
> > +++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
> > @@ -38,7 +38,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
> >       struct hl_device *hdev = dev_get_drvdata(dev);
> >       long value;
> >
> > -     if (hdev->disabled)
> > +     if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
> >               return -ENODEV;
> >
> >       value = hl_get_frequency(hdev, MME_PLL, false);
> > @@ -57,7 +57,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
> >       int rc;
> >       long value;
> >
> > -     if (hdev->disabled) {
> > +     if ((hdev->disabled) || (atomic_read(&hdev->in_reset))) {
>
> There are quite a few of those, maybe split this check to a helper
> function?
Fixed
>
> >               count = -ENODEV;
> >               goto fail;
> >       }
> > @@ -87,7 +87,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
> >       struct hl_device *hdev = dev_get_drvdata(dev);
> >       long value;
> >
> > -     if (hdev->disabled)
> > +     if ((hdev->disabled) || (atomic_read(&hdev->in_reset)))
> >               return -ENODEV;
> >
> >       value = hl_get_frequency(hdev, TPC_PLL, false);
> > @@ -106,7 +106,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
> >       int rc;
> >       long value;
> >
> > -     if (hdev->disabled) {
> > +     if ((hdev->disabled) || (atomic_read(&hdev->in_reset))) {
> >               count = -ENODEV;
> >               goto fail;
> >       }
>
> --
> Sincerely yours,
> Mike.
>

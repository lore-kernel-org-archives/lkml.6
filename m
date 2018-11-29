Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBF1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45689206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iD9N56T3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45689206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeK2NAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:00:55 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38913 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbeK2NAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:00:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id g27so306297oth.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV4bcAmjBk5UdDKTKG+VrvFHlK+fUrt4dvSHJ3FHTQc=;
        b=iD9N56T3ZtE/EwsO2Ikmf7lPpW759YU3247nVY/TEeHl17uEffZz+vmBYNciHbGfxe
         atQq1YbS7P4xbSJZ/Qc15GlHqJAk+z2gbPeocjwjbnHRBHqgS4V3Qx7yXBEpF+Bz5bIw
         ptKPrPTQF2LehVoaffP1+AbFbKdijvj/l72J1OmupCwC+UgZCuy9jCOyqisMJG0jmWwt
         X6hzC/KeqiiYl3Qfou3xz1h5EheAp26LyLwzesi7eJ9ecwOIu7ISeXSevrOoyFagurGm
         ZVVzJBiST01yj2oYd+8f8UcG00W82YsYCJJXIwy/u9GSktku1Fz/Mzt+5VlK6P2rmf/W
         zRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV4bcAmjBk5UdDKTKG+VrvFHlK+fUrt4dvSHJ3FHTQc=;
        b=pHxgX1Sk+q/z5mL/dbet7J83RtMhYjjKEsqPs3rvnhG4lAu7cbiZQxoDTAsM5pFUWW
         a/CT2YiJZZoWeyEPD2+EH7rFpJ/pRJOyjMwjrRbfgiWyy9+EcZl1GunJOCDXHXQvBLph
         itO2D9A0NHg4Ni1w0jaetzw0B6tsHzuzpYE3NSJ3+EeH8LMOXbnGqPOEkBZGWrhmDdz7
         Tytua9a1I0D0MJa3QrcSkdcU2zedgHqFBnKcORudHCOazd7KvHnoBx07+XOMpLJcnbUX
         Jhr0v/25XlqYjUErTU1n2zt14awiXqrWHvhctZg6zaFe+DTQ4+su808ikzBYxrZUPTkR
         1IVQ==
X-Gm-Message-State: AA+aEWYcKJmDrIRMUNTHoneblKJI5BzE0ySPCArJUi/J+TIHHQOEXBUR
        +YNa/SOacmdQFQdZnukTMmk7cx+nN9zegLz8BxRICQ==
X-Google-Smtp-Source: AJdET5cDvkxDaPoou/lNt3hxNislvohwDyuwUcFRbZH/QDUnyoSwwkSKQyz/HVS7IsXPGtsYphEy4PYV5iwpxYCkGgY=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr23020995otn.214.1543456634946;
 Wed, 28 Nov 2018 17:57:14 -0800 (PST)
MIME-Version: 1.0
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
In-Reply-To: <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Nov 2018 17:57:03 -0800
Message-ID: <CAPcyv4gMswOJ3VTaY6P7f=iG_jNBKZyynn22CLrEBB13Fq-8vQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 4:32 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Add an additional bit flag to the device struct named async_probe. This
> additional flag allows us to guarantee ordering between probe and remove
> operations.
>
> This allows us to guarantee that if we execute a remove operation on a

You missed the review comment on the usage of "us". I've long been an
abuser of this as well saying "we" and "us" to casually refer to
whatever part of the kernel I'm currently modifying. The problem is
that it is ambiguous and assumes the reader happens translates the
"us" / "we" to the same specific subject you had in mind. It leaves
room for confusion that can be eliminated by explicitly referencing
the expected agent, subject, object in mind.

I long blew off suggestions to correct usages like this, but it
finally sunk in for me after reading Thomas' rewrite of a "we" and
"this" laden changelog, and why he and other tip-maintainers want to
push back on the usage in the tip tree, see the "Changelog" section of
the guidance in "[patch 2/2] Documentation/process: Add tip tree
handbook": https://lkml.org/lkml/2018/11/7/932.

Patch review is quicker without the speed bumps of translating
occurrences of the "we" and "us"

> given interface it will not attempt to update the driver member
> asynchronously following the earlier operation. Previously this guarantee
> was not present and could result in us attempting to remove a driver from
> an interface only to have it attempt to attach the driver later when we
> finally complete the deferred asynchronous probe call.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/dd.c      |   16 ++++++++++++++++
>  include/linux/device.h |    3 +++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 88713f182086..ef3f70a7cb5a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         device_lock(dev);
>
> +       /* nothing to do if async_probe has been cleared */
> +       if (!dev->async_probe)
> +               goto out_unlock;
> +
>         if (dev->parent)
>                 pm_runtime_get_sync(dev->parent);
>
> @@ -785,6 +789,9 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>         if (dev->parent)
>                 pm_runtime_put(dev->parent);
>
> +       /* We made our attempt at an async_probe, clear the flag */
> +       dev->async_probe = false;
> +out_unlock:
>         device_unlock(dev);
>
>         put_device(dev);
> @@ -829,6 +836,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>                          */
>                         dev_dbg(dev, "scheduling asynchronous probe\n");
>                         get_device(dev);
> +                       dev->async_probe = true;
>                         async_schedule(__device_attach_async_helper, dev);
>                 } else {
>                         pm_request_idle(dev);
> @@ -929,6 +937,14 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  {
>         struct device_driver *drv;
>
> +       /*
> +        * In the event that we are asked to release the driver on an
> +        * interface that is still waiting on a probe we can just terminate
> +        * the probe by setting async_probe to false. When the async call
> +        * is finally completed it will see this state and just exit.
> +        */
> +       dev->async_probe = false;
> +
>         drv = dev->driver;
>         if (drv) {
>                 while (device_links_busy(dev)) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 1b25c7a43f4c..4d2eb2c74149 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -957,6 +957,8 @@ struct dev_links_info {
>   *              device.
>   * @dma_coherent: this particular device is dma coherent, even if the
>   *             architecture supports non-coherent devices.
> + * @async_probe: This device has an asynchronous probe event pending. Should
> + *              only be updated while holding device lock.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
>   * instance of struct device. The device structure contains the information
> @@ -1051,6 +1053,7 @@ struct device {
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>         bool                    dma_coherent:1;
>  #endif
> +       bool                    async_probe:1;

I think this flag is misnamed, the wrong polarity and should be set in
the device removal path, not the driver detach path. The wider problem
is the removal of a device while actions initiated by its arrival may
still be in flight, or have yet to start. It's not just the probe path
in the driver-core that might be interested in this state, but also
bus implementations that kick off their own async operations.

I think the flag should be named "cancel" and set it in the
device_del() path. Otherwise this is encoding code flow state in the
struct rather than device-state that the code needs to comprehend.

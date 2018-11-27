Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D67FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABEF2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DJEZtaaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABEF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeK0Nbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:31:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40480 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeK0Nbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:31:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so18726782oth.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1b1NHktt1/h4wTdlHusrlwjuKRh9FmZI2kwzuIPtQls=;
        b=DJEZtaaAm1DwQqQxQs9xWD6ganKM1y3uuADwIorBiy3pJ7acAZjYIzf0zN+beQ0ykz
         rOGnaljTs0A74six8OYfLxhPNRcyVt8bEtscBB4xLCm5XJ4TQmlQ7RPsanrAYj7kCs1G
         Au+lXp1RiuR8JYHNNbF8CbVjq2iP2zDzhc63wqwTNkP9gsON13lxLKP7usp0QeWoRGWD
         aEMa/aC1bU4lKtnNROBatsl2e4VrxfqxsuVEcUtPIS87bNhMdWAVS/jdyxGoYTw90vw3
         WFNskGiRCd1K7hGMpJ2V0hiOGppaEd1jivFUxj4P+eevCXOhIbg5gxabSc/j7aIJUlhl
         VmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1b1NHktt1/h4wTdlHusrlwjuKRh9FmZI2kwzuIPtQls=;
        b=qdx0NYTlTEWcN1mCYPiQE5jQ2WZZx9aLF/4rS4Fl2doLoukN8GcudTLtCIRaZgbWZM
         CM6PPNt2+AVIRoWlH2XcVHVL15vKPTF4Xho9WMJnGxvRN/1S0ckd06d5B6zefeMGsQO6
         2d+IPD7OGgKDHZGmiUGcujTXWOh3M0nhu+F9bNPGz4jgELU0Be0Is/uEpX3Ns5TpwZtM
         4YkrXoqCwD8P6JjeWtkr6n2fzatgAPbLYgR4fIqW18IWPHyjFxhztx1fQ54BAFM1zokx
         hxGgnOBXDyDjBRm3KgHKp5GbWJ3PxJsFs1zas9PHJaCz8MaSS1yeLyqHZGel4L13OxyR
         YWhw==
X-Gm-Message-State: AA+aEWbn95VbsFOFfrCVy+tWz94AA7yzj+HUoefVr9Iqr8bcxKCMC8J3
        hjpfiRacKXwXROs39+QxFmOIWkPelX6GTRRFCnRxeA==
X-Google-Smtp-Source: AFSGD/V8n1FqhNMu/9zXJmEoUWIlt3SX7GqlfBNmuB3N4Vgm4XcSC0Y9j5VY8YOAeVEYmSUB6X9Er8g9KgOlI0qq6Qk=
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr12991186otf.98.1543286116603;
 Mon, 26 Nov 2018 18:35:16 -0800 (PST)
MIME-Version: 1.0
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
 <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 18:35:05 -0800
Message-ID: <CAPcyv4ieNzbx5iN74ZCAKDesgYt_67iM_DC-A35M=Z9jfR+YAQ@mail.gmail.com>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Nov 5, 2018 at 1:12 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch adds an additional bit to the device struct named async_probe.
> This additional bit allows us to guarantee ordering between probe and
> remove operations.
>
> This allows us to guarantee that if we execute a remove operation or a
> driver load attempt on a given interface it will not attempt to update the
> driver member asynchronously following the earlier operation. Previously
> this guarantee was not present and could result in us attempting to remove
> a driver from an interface only to have it show up later when it is
> asynchronously loaded.
>
> One change I made in addition is I replaced the use of "bool X:1" to define
> the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
> warnings.

The usage of "us" in the changelog through me off, please reword this
to explicitly state the subject like: "The additional bit allows the
driver core to guarantee ordering between probe and remove
operations."

> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/dd.c      |  104 +++++++++++++++++++++++++++---------------------
>  include/linux/device.h |    9 ++--
>  2 files changed, 64 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e74cefeb5b69..ed19cf0d6f9a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -472,6 +472,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>                  drv->bus->name, __func__, drv->name, dev_name(dev));
>         WARN_ON(!list_empty(&dev->devres_head));
>
> +       /* clear async_probe flag as we are no longer deferring driver load */
> +       dev->async_probe = false;
>  re_probe:
>         dev->driver = drv;
>
> @@ -771,6 +773,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
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
> @@ -781,7 +787,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
>
>         if (dev->parent)
>                 pm_runtime_put(dev->parent);
> -
> +out_unlock:
>         device_unlock(dev);
>
>         put_device(dev);
> @@ -826,6 +832,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>                          */
>                         dev_dbg(dev, "scheduling asynchronous probe\n");
>                         get_device(dev);
> +                       dev->async_probe = true;
>                         async_schedule(__device_attach_async_helper, dev);
>                 } else {
>                         pm_request_idle(dev);
> @@ -971,62 +978,69 @@ EXPORT_SYMBOL_GPL(driver_attach);
>   */
>  static void __device_release_driver(struct device *dev, struct device *parent)
>  {
> -       struct device_driver *drv;
> +       struct device_driver *drv = dev->driver;
>
> -       drv = dev->driver;
> -       if (drv) {
> -               while (device_links_busy(dev)) {
> -                       __device_driver_unlock(dev, parent);
> +       /*
> +        * In the event that we are asked to release the driver on an
> +        * interface that is still waiting on a probe we can just terminate
> +        * the probe by setting async_probe to false. When the async call
> +        * is finally completed it will see this state and just exit.
> +        */
> +       dev->async_probe = false;
> +       if (!drv)
> +               return;

Patch 4 deleted the async_synchronize_full() that would have flushed
in-flight ->probe() relative to the current ->remove(). If remove runs
before probe then would seem to be deadlock condition, but if
->remove() runs before probe then dev->driver is NULL and we abort. So
I'm struggling to see what value dev->async_probe provides over
dev->driver?

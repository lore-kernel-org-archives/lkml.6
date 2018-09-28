Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E5F20657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="monnTLAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E5F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeI2AHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:07:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46756 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeI2AHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:07:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id k64-v6so6091322oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b38m5An15MVsLxUJudFCQifpF1mmgYpGMzMWnjtgpzY=;
        b=monnTLAdTu9wFgDFu1ApeC/Ju+TIY1mlGQ4jYnCshA7XE33czgccO8kURQLKQ2ReVa
         7zxEen+VrtUUUcIR8GV3o7WY5xw1vteNo1OHBNlKh/vJVVW5hGCQTww55Psn53vzvBjX
         zaawIMZdZwaxfM1fmwgSNswxMLB07eSPZuDWdiXk1b2AwkwFuQb9yid7Ok81QyldjZtM
         1p7gV8Iplhx7PMl5Jt0wZRN8ngVrK63kwvJYYId4MWuYFx8EoPHzcicd7NkXiYmM8Nai
         o5ShVKOysQFAEE0Yo3Vx1iUFCvrS7J1ZTywtu6oo2gI4bQHEFoeylDbonG0137oKzbJ/
         ihvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b38m5An15MVsLxUJudFCQifpF1mmgYpGMzMWnjtgpzY=;
        b=lYWXPfybghzJG08lZy2bSNWpasQXp9qg/Seq1CbeyLA0QqaPT8XkoIwaT4PWVNKfUb
         zpMn3e8xcxVgYID+t1xUcjBlFUK9NxUSmhD1tWbVwqwHbze+9B51fDgQa4wXK9W/dQ30
         QuFTky0ih57F+98snt3QkUt8+CGLMacqmnEhYh2PbwN8Z0iTXNoiRd+hH8HihJyFkCCX
         Tl0kEDBX+8xIFZPtSQqrvqwKPlmPdziS3itmaxTuXImVUGc08kcwQso3BZsA+cCxI8xZ
         NJ1K0ixQJHHT1gQww3pSFKd873605AX3LUyyHabuTaay4+EsJoQsW9iEPwyaPh3p500Q
         Zz6Q==
X-Gm-Message-State: ABuFfoiYca0pv6u3B26POKBKoAa6lzcwPgqSCuJ8K0fCE42eulxadUlQ
        A5HP0V29eNS4W4KUqa38TPlBrVlL5hCS4J9oXOLIiA==
X-Google-Smtp-Source: ACcGV62z7BGzd/VkFlmx2AbczK+5HNX4+wyZMAXKUjGvucuC5xLNe6NBcVOc/vt56GaxppfWpq4uENswwkQoTvjFEZo=
X-Received: by 2002:aca:4792:: with SMTP id u140-v6mr6653627oia.215.1538156570644;
 Fri, 28 Sep 2018 10:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain> <20180926215155.13512.30900.stgit@localhost.localdomain>
In-Reply-To: <20180926215155.13512.30900.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Sep 2018 10:42:39 -0700
Message-ID: <CAPcyv4hZFQ99jnJnWBDDvrpiXq4zSAxo4C870tzfsN7eQ-8Y7Q@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 4/5] driver core: Use new
 async_schedule_dev command
To:     alexander.h.duyck@linux.intel.com
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        jiangshanlai@gmail.com, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:52 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we use the device specific version of the
> async_schedule commands to defer various tasks related to devices. By doing
> this we should see a slight improvement in performance as any device that
> is sensitive to latency/locality in the setup will now be initializing on
> the node closest to the device.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/base/dd.c         |    4 ++--
>  drivers/base/power/main.c |   12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5ba366c1cb83..81472dc44a70 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -826,7 +826,7 @@ static int __device_attach(struct device *dev, bool allow_async)
>                          */
>                         dev_dbg(dev, "scheduling asynchronous probe\n");
>                         get_device(dev);
> -                       async_schedule(__device_attach_async_helper, dev);
> +                       async_schedule_dev(__device_attach_async_helper, dev);
>                 } else {
>                         pm_request_idle(dev);
>                 }
> @@ -927,7 +927,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 if (!dev->driver) {
>                         get_device(dev);
>                         dev_set_drvdata(dev, drv);
> -                       async_schedule(__driver_attach_async_helper, dev);
> +                       async_schedule_dev(__driver_attach_async_helper, dev);
>                 }

Above looks good to me...

>                 device_unlock(dev);
>                 return 0;
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3f68e2919dc5..8495d9b1e9d0 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c

Let's split these changes into their own patch, just in case it causes
a suspend regression we can revert it independently of the async
probing change. It might also be worthwhile to have a positive
indication that this improves the latency of power transitions.

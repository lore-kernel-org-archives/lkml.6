Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B07AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C600C21564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hnFsFEF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C600C21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeI0HEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43167 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeI0HEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id e21-v6so853299otk.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnlSiDCsaNrCV9Y4QJBrkovx4BRdhAhELWYH3DceLpI=;
        b=hnFsFEF0jNPz5Kk001hvIGgUdHls4PAZ//vMg3gu1Qvr+aqXeN8MMyx/aNFDEtCGz4
         R1PbfX8QIn5UGuLTtcYlL3cwlgkeZwOTFtHFXYKqhVIi1ZpabIZ4J9xTtUOBeK5nBWl0
         tO2Cl51gH+TQmrGCXYewqGwm4hBX1wFC1RSDhZwyNyq2R9Ws/iV14BsJFXZa/ZGtB8cM
         BjTPeNkgg0qSr13vGMWiwC54bX/jO5kNraURhnsdCMexXjiikKY5hp9y5i05R+YXLFPB
         zSqm6BFLPIRDwWfx90wFWeJF+jQ8jFq8eP5f/Fy3zGU8K3NvgM96IsIJuHrypHzOyOU0
         e6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnlSiDCsaNrCV9Y4QJBrkovx4BRdhAhELWYH3DceLpI=;
        b=VexNcNssAtII8kfW1DK5uQG4tCi7CTo4Z9mVOjno4W0FZ783blE5c6nX9EnLwHM8Qf
         PoIVS/NgeVsa28pzvrRGk/OSvckFgA4EZ79YZp5txkvLbod6uTQ3a5f22hUrJtRXCijb
         24ggkyhfMIf87NeY6wwyHveWg740QnYIHtJ5e0DIn8g0y8UpEJ6iVgRvxJsysLsqEHBk
         whzqmoHCKXT7ZIW5jiNdGFXL0b468K63cOTZ4/FJLFuUORYjsDBRz/31pqofxvN3nimA
         cltWP0Uo/1Ld0FgLnBd3HaSOmdHaT3zj2Mm3Ln44eYH/B3lLdhu4WRLU35wTZIRH+cQb
         r2Lg==
X-Gm-Message-State: ABuFfoiutBEeM4ICo+6YKVHMk8Q3PIiBrFTmFqQziY0m3RXU6rqntJpr
        N8SoyzwdPDD9XpFstU2+asNHVxt633u6xEPsuXfkLw==
X-Google-Smtp-Source: ACcGV61cW607t231DD+u3TMm+5MgQmwHCIT8p+5M3i6JYyzssSzHc54urK8kq8DtiJJcOlOLrEMk3a+4GoY8HjX9ijI=
X-Received: by 2002:a9d:7353:: with SMTP id l19-v6mr5560420otk.7.1538009315189;
 Wed, 26 Sep 2018 17:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180926214433.13512.30289.stgit@localhost.localdomain> <20180926215149.13512.51991.stgit@localhost.localdomain>
In-Reply-To: <20180926215149.13512.51991.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Sep 2018 17:48:24 -0700
Message-ID: <CAPcyv4h5U4Fph52H80QodBRXK+PjS6Zw_6qK2+DXtr=qZT7Gzw@mail.gmail.com>
Subject: Re: [RFC workqueue/driver-core PATCH 3/5] driver core: Probe devices
 asynchronously instead of the driver
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

On Wed, Sep 26, 2018 at 2:51 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This change makes it so that we probe devices asynchronously instead of the
> driver. This results in us seeing the same behavior if the device is
> registered before the driver or after. This way we can avoid serializing
> the initialization should the driver not be loaded until after the devices
> have already been added.
>
> The motivation behind this is that if we have a set of devices that
> take a significant amount of time to load we can greatly reduce the time to
> load by processing them in parallel instead of one at a time. In addition,
> each device can exist on a different node so placing a single thread on one
> CPU to initialize all of the devices for a given driver can result in poor
> performance on a system with multiple nodes.
>
> One issue I can see with this patch is that I am using the
> dev_set/get_drvdata functions to store the driver in the device while I am
> waiting on the asynchronous init to complete. For now I am protecting it by
> using the lack of a dev->driver and the device lock.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
[..]
> @@ -891,6 +914,25 @@ static int __driver_attach(struct device *dev, void *data)
>                 return ret;
>         } /* ret > 0 means positive match */
>
> +       if (driver_allows_async_probing(drv)) {
> +               /*
> +                * Instead of probing the device synchronously we will
> +                * probe it asynchronously to allow for more parallelism.
> +                *
> +                * We only take the device lock here in order to guarantee
> +                * that the dev->driver and driver_data fields are protected
> +                */
> +               dev_dbg(dev, "scheduling asynchronous probe\n");
> +               device_lock(dev);
> +               if (!dev->driver) {
> +                       get_device(dev);
> +                       dev_set_drvdata(dev, drv);
> +                       async_schedule(__driver_attach_async_helper, dev);

I'm not sure async drivers / sub-systems are ready for their devices
to show up in parallel. While userspace should not be relying on
kernel device names, people get upset when devices change kernel names
from one boot to the next, and I can see this change leading to that
scenario.

If a driver / sub-system wants more parallelism than what
driver_allows_async_probing() provides it should do it locally, for
example, like libata does.

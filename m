Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C881720664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XLIkv7mE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C881720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeK0Nof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:44:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36529 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbeK0Nof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:44:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id x23so17985099oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yHNS6NSMBCCEh+8RdxWC4D7mUFckUEQJEGw1LBWnRA=;
        b=XLIkv7mEhULtPtzMVfJeYuHgb2CE0REqrd/4T99OAA1ORCT11XSwG/NPtdZaFWFMXc
         Ax0NESWoeDe0Es1ekTN17h7HxIApvd0D4VYqGnHg4L5dAz0vpRKdbml2gsYwNisHzdOq
         6gW8Cvea/ulIR77f/VQ5zSvDvJ97YzaUHrex9EADiN09tbKNFvTS6uJ3hCNx2HKyF3Jb
         SEOSdUImH/+woswNCVAPvutmFT/fjsJr44Ies9At1MBd7i3Ab65AxdS7mrqX7pK+xclb
         XTh7v5/aF6jQOWkcmSzkGAk6LZzmMVfgn52gihf63IbLQSxdn+0MQ+TWbsXA/aWP3h7X
         mFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yHNS6NSMBCCEh+8RdxWC4D7mUFckUEQJEGw1LBWnRA=;
        b=kV4gRTCtXbe/KkevnmMKGPnn7i9c37dGu9Nd3+ZKQpww+iKA/vdWjGCXG2HdmiI1BH
         kuwhjrP5dK/mQSNQHBLIFSg8bDJrMsLnKsbivOkMV++a0ZSrIFp9zuqD95Hmy20KJuGg
         bUVZC8NmNkbLBIB54Vdq3nrQfi3SeNEa21R0LfyEoLcPZqi5MbmKZw/kkchXbvsJfWkG
         0himcAy454vk2KgiUg2mC3go5kClV4kErWw3kbHa96yTB9Ds+Hd5x0XzMSE/uaK5IHra
         h7z58A9R3eFQUttLh3IGX/j+1mh+W321ASQJWJE92f7+mE4vjlBgx7/+J9MbECqUWc7p
         g/qA==
X-Gm-Message-State: AGRZ1gKzky6XcXZoECJ+n9WMIjHCbQItfjxq+kK5pWJv0+Uvbxm1Sc3s
        Tn4e07oDOGorZRsJSCZBCTFce6v5HJBg8c4ET5QT7g==
X-Google-Smtp-Source: AJdET5fQLO3B9h4zUYS8u8PzV+pnmelyWtUKX5VHij/PzdY0N7qtsAAJSvDVf9htwOYB4WZxLUKC9gmjcNfSuCCsXsQ=
X-Received: by 2002:aca:d944:: with SMTP id q65-v6mr17695408oig.0.1543286895985;
 Mon, 26 Nov 2018 18:48:15 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
In-Reply-To: <154170043123.12967.3591757325647337726.stgit@ahduyck-desk1.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 26 Nov 2018 18:48:05 -0800
Message-ID: <CAPcyv4g0LNJZ38NKMXsBY+GgmGbHR4VrTM1gkm3m4bg6fOrfsw@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 6/9] driver core: Probe devices
 asynchronously instead of the driver
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

On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> Probe devices asynchronously instead of the driver. This results in us
> seeing the same behavior if the device is registered before the driver or
> after. This way we can avoid serializing the initialization should the
> driver not be loaded until after the devices have already been added.
>
> The motivation behind this is that if we have a set of devices that
> take a significant amount of time to load we can greatly reduce the time to
> load by processing them in parallel instead of one at a time. In addition,
> each device can exist on a different node so placing a single thread on one
> CPU to initialize all of the devices for a given driver can result in poor
> performance on a system with multiple nodes.

Do you have numbers on effects of this change individually? Is this
change necessary for the libnvdimm init speedup, or is it independent?

> I am using the driver_data member of the device struct to store the driver
> pointer while we wait on the deferred probe call. This should be safe to do
> as the value will either be set to NULL on a failed probe or driver load
> followed by unload, or the driver value itself will be set on a successful
> driver load. In addition I have used the async_probe flag to add additional
> protection as it will be cleared if someone overwrites the driver_data
> member as a part of loading the driver.

I would not put it past a device-driver to call dev_get_drvdata()
before dev_set_drvdata(), to check "has this device already been
initialized". So I don't think it is safe to assume that the core can
stash this information in ->driver_data. Why not put this
infrastructure in struct device_private?

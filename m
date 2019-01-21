Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB18C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A952089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YO95x1KF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfAUSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:04:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36894 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfAUSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:04:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id y23so15243373oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eZbr9IlqZkiHLUSATqRtFo5RPhXCxT327ubvp0394Y=;
        b=YO95x1KFQNGHZKJXtr4YnGnLjNqzergs4SfxO4XyId/1JLxBqV6ToHfajAMhVpoxhY
         zXsfvs8igZ0nC0RKQTjEvpfE9KW90tHKu3yodfSDtlIagp04zAaUGnSz3707c0I7xBhr
         1DP8f96nC7h8627q94WC+sRvFIYuwEvyKaRfz5JyrO6p9d6snOS6/RW1Uw6VYihDQeU9
         vX9UbVb0uttGH72GEMMYZSx1tAI9zKetfq1Rihb79G3fEjP35r0uf7W9C+id+uASj+OT
         r6zcgICU7axAJHE/DLQ5j53wjIElJ49wFfJltpVD94tR2XvyNn1YCA+vTf9Hp5GAiaiT
         8MCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eZbr9IlqZkiHLUSATqRtFo5RPhXCxT327ubvp0394Y=;
        b=qWywjySLQKVZQI56VtHvXgviXmYIVg747FwVPvMgQsprU/8/xp6QSkx9a4jaqBig95
         gme63+jRW3bk/4nH+wRWZH8dgi9JdPI3Ovmti+jXFCZ4oouUfo0yFx5ZaMAjuo/eiXSG
         bVjOyaF+z1/oQz9c/hMpGxOyK05jYukzUDDbCLq+BNfatYCF7FD8PqIsHNgUVdScQ9NB
         kRfVtQC0Pju1FdgVEzaac6LSI0Axfh9s8Mk2oC3WJYlJxH5Qs/dXdbsZZZKWV7ciAALR
         zUc6JLgh919OkDXWAK5sSx69+uooNzQYrMwjIfxUOrE6xP6u6XOykCq8i0SSgJffqJdL
         9Tkw==
X-Gm-Message-State: AJcUukewM9k1S4f+8QEVfmfsNVEMHAepY0QkX9FTAgit18fJEyyCwA4+
        wADp7PjeGLswOm66LBJ+96vJY3+znLtL9lB77afgZKYcBVo=
X-Google-Smtp-Source: ALg8bN6n4ozWdOmRESIAX8GuDLW5UMwosYaNu+wC7UcFXjvYPBcYkE8K90ujWWWI8oT/VWOGqMW+1OUp+l50dvBcB/w=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr6538239oih.244.1548093891955;
 Mon, 21 Jan 2019 10:04:51 -0800 (PST)
MIME-Version: 1.0
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard>
In-Reply-To: <20190121075102.GA3758@richard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Jan 2019 10:04:40 -0800
Message-ID: <CAPcyv4iGZdEw-agURohZdC7hkjrDp74M_gVdSbCB5DP-bk5YYw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 11:51 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
[..]
> Also, I have one confusion about your saying: two probes.
>
> If the two probes are:
>
>     * for dax%d.%d: 1. nd_dax_probe 2. dax_pmem_probe
>     * for pfn%d.%d: 1. nd_pfn_probe 2. nd_pmem_probe
>
> Then, if the first probe fails, the device itself would be destroyed. How the
> second probe do its job?
>
> >       rc = nd_pfn_validate(nd_pfn, sig);
> >       if (rc != -ENODEV)
> >               return rc;

Here is an example path for a device-dax instance:

    /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.1/dax0.0

In this case the order of events is:

1/ region0 discovers it contains a pmem namespace and registers namespace0.0
2/ The pmem namespace driver calls nd_dax_probe() to check for the
presence of a device-dax configuration
3/ If present, nd_pfn_validate() returns 0 and nd_dax_probe()
registers the dax0.1 device (this is a libnvdimm 'personality device).
4/ When nd_pmem_probe() sees nd_dax_probe() return 0 it in turn fails
the probe of namespace0.0 with -ENXIO. All devm allocations during the
probe of namespace0.0 are released.
5/ Meanwhile the created dax0.1 device is recognized by the dax_pmem device.
6/ dax_pmem_probe() uses nd_pfn_init() to validate the configuration
and ultimately creates the dax0.0 character device

The pmem namepsace driver is effectively a router to other personality
drivers that may be layered on top of the base namespace capacity.

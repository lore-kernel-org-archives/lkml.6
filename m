Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296BB21535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IEYgHn87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296BB21535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbeIUEpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:45:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36149 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeIUEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:45:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id w17-v6so11190249otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kEVg4AfF+ri/1ag9LL/dsQqlcNAWtcz0lxcG+tsols=;
        b=IEYgHn87JPHz2nLAHlDvx5WFxmZojpXDb9K/pa5K+PTjWe+h9ZIwlD47olcKsfdbMQ
         YyNHw4ZRsF3WEQ5tb2AUcQjiSpcimhwFXX9SJ4t6sQvsnLLDiKGOZLfJd8l14w8LP7ht
         IpvNDrdvWu1FDYZAwJGOugdmlkLxKm8C7hclHRUvKAQUdOYd3hYx2fdqVLzxI610vqQu
         Dk+ClNkVHRcw8QeuGHioW/vvg1HvHuWv4pFyFe2g/LCY41kqAdTm+/fK/ZN8l4bWkFct
         2L3NS32lc1d11TX2kMmqTVmVcodQxwI5DxY9wGH1Vbxbaso9zCBDNH2Wdw7h9gaZpIny
         Q3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kEVg4AfF+ri/1ag9LL/dsQqlcNAWtcz0lxcG+tsols=;
        b=ImKB3Wsgp2h7OHSF95Jv+WRDoLFTaAbpyd/+U0vb9iSZ1SJrZ0Nq9zN4bN20Hj8Kah
         PmJL2Mni9LYq9ul8iTVae6gJ2h/zlEVCKeULZ3JtJAPDHcskqMTjmGUyVn0iTMDOTcGA
         PHNU4sSyHL9Nyl+nHgFwoRk4EQUj2MyouIa+OkWuuloF/0IgomfCE26M/tt333f7JqUd
         OBAPRVks8ReQFh1HAA/kmQjkzLdF4sGMAzlQZnYj57geNGbyd/LrmLXM3k0M/xAuDtVK
         HDukSeY9+myR0AJsjYmsze5t20c5TWzLFVEkndmYoD+E8jk9A3763QV8uttIXKebOUdt
         89ug==
X-Gm-Message-State: APzg51B/pj90NTugzBAG6KYahqVqt6663StxogT6mvbwZZn74/uB/Hyd
        tboXVh2NYAfeE7UAuGMT/1rX8Wowr37ZKEOoYPQ0MA==
X-Google-Smtp-Source: ANB0VdZxOg2ZeOQ45ckJQsvaw9Kqy5VPyDNxVnPvZpegjDMZJjs82ysLNHtFl97vdfEy2ldWa782YTKdTFP8zQXCuzQ=
X-Received: by 2002:a9d:50ac:: with SMTP id b44-v6mr24540445oth.267.1537484385582;
 Thu, 20 Sep 2018 15:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180920215824.19464.8884.stgit@localhost.localdomain> <20180920222951.19464.39241.stgit@localhost.localdomain>
In-Reply-To: <20180920222951.19464.39241.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Sep 2018 15:59:34 -0700
Message-ID: <CAPcyv4hAEOUOBU4GENaFOb-xXi33g_ugCexfmY3DrLH27Z6MKg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] nvdimm: Schedule device registration on node local
 to the device
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:31 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> This patch is meant to force the device registration for nvdimm devices to
> be closer to the actual device. This is achieved by using either the NUMA
> node ID of the region, or of the parent. By doing this we can have
> everything above the region based on the region, and everything below the
> region based on the nvdimm bus.
>
> One additional change I made is that we hold onto a reference to the parent
> while we are going through registration. By doing this we can guarantee we
> can complete the registration before we have the parent device removed.
>
> By guaranteeing NUMA locality I see an improvement of as high as 25% for
> per-node init of a system with 12TB of persistent memory.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/nvdimm/bus.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> index 8aae6dcc839f..ca935296d55e 100644
> --- a/drivers/nvdimm/bus.c
> +++ b/drivers/nvdimm/bus.c
> @@ -487,7 +487,9 @@ static void nd_async_device_register(void *d, async_cookie_t cookie)
>                 dev_err(dev, "%s: failed\n", __func__);
>                 put_device(dev);
>         }
> +
>         put_device(dev);
> +       put_device(dev->parent);

Good catch. The child does not pin the parent until registration, but
we need to make sure the parent isn't gone while were waiting for the
registration work to run.

Let's break this reference count fix out into its own separate patch,
because this looks to be covering a gap that may need to be
recommended for -stable.


>
>  static void nd_async_device_unregister(void *d, async_cookie_t cookie)
> @@ -504,12 +506,25 @@ static void nd_async_device_unregister(void *d, async_cookie_t cookie)
>
>  void __nd_device_register(struct device *dev)
>  {
> +       int node;
> +
>         if (!dev)
>                 return;
> +
>         dev->bus = &nvdimm_bus_type;
> +       get_device(dev->parent);
>         get_device(dev);
> -       async_schedule_domain(nd_async_device_register, dev,
> -                       &nd_async_domain);
> +
> +       /*
> +        * For a region we can break away from the parent node,
> +        * otherwise for all other devices we just inherit the node from
> +        * the parent.
> +        */
> +       node = is_nd_region(dev) ? to_nd_region(dev)->numa_node :
> +                                  dev_to_node(dev->parent);

Devices already automatically inherit the node of their parent, so I'm
not understanding why this is needed?

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF44C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33B92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NZeVbgxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfAVAp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:45:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44496 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfAVAp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:45:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so16017972oig.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 16:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b77udigcM7sAcY/bFN9oF/nGh8nDTd+troa+F/Wg35g=;
        b=NZeVbgxFCXcf9brLStC91eSF47mMLqQ2z5hqSY2bctxSkp2GCiwRsZnPgfCUpECrEE
         07qWkPaus/8/jd+lfN1uhvjE0Q00qiXYr+VpXptnGUy6PH+7RqekH1ZOYdBpqOv9bZqz
         g+jas897FgdYTftFfvDdIKaECuIoEQmHLAI1MEA5W0VdwJylmyHKrQtVXK5OO9WZ+SnZ
         5Os1+PDNhkncQgBfZSr6j3gttptH1wD5jDieZ+bsjY+LB905/WnpTbetzitehv6aMbKQ
         cLLEJz1MS1yO+rzMZIJwqC+HMhw+hCDaXwLM7K6YKse3inQPgyk6wdaFdvgP4xVTUtnK
         3oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b77udigcM7sAcY/bFN9oF/nGh8nDTd+troa+F/Wg35g=;
        b=j3c3irJWr6fKDcSLQ9dQZcpIntCZ/KejCtoi7mSEra/hwgPYhCx/XEMgJP7+8SZcgD
         1BQ4ur0TRn2L3P6FNnoJrj67qYrGjbva5Rc2pKNxMdKbNIW2oS1j4QvEBl8hek3hacGl
         8RZopRPXnS3GTduJuOjyQtCskmyrIz5yJoEHpOoqYvZWIcmntox/zH6mqHb8eY6vsCmp
         355ICnasCDWP9z8eNjrFKOcnc6qy9Y5taZPF8yh3WHMVJDpYfPd+ICrTXyLAwjoJgFGw
         Ikxc65/QA1oZyK8+krkh0EPnsiREu8qr4hJYadSZpAlUkBuzWdKdAggTsdETrhMRRos6
         +qZg==
X-Gm-Message-State: AJcUukf+0/X+C6jNpKjBDZowlrOibydvdulWq8osT37sfdXaAcQ/tbaA
        EzA+KUkepvYsjhPVGvAwvYdZy9JiHOtybXHqLr8d4USc
X-Google-Smtp-Source: ALg8bN6jLOeNlsGN7gs7Bcec1I29jDDCC89yKRjciVaRRtBoxXTgZTET8p69KqMcZhYmNUM7acTSFYs5BDdpbQM3KkA=
X-Received: by 2002:aca:d905:: with SMTP id q5mr7262774oig.0.1548117957791;
 Mon, 21 Jan 2019 16:45:57 -0800 (PST)
MIME-Version: 1.0
References: <154785884329.2202034.3295476681016958230.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190121075102.GA3758@richard> <20190122002915.GA5984@richard>
In-Reply-To: <20190122002915.GA5984@richard>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Jan 2019 16:45:46 -0800
Message-ID: <CAPcyv4gANCKeEE5xgC9W99XdiR+rNyN5TEzho18039S2+7TaPA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm: Clarify nd_pfn_init() flow
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:30 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Mon, Jan 21, 2019 at 03:51:02PM +0800, Wei Yang wrote:
> >On Fri, Jan 18, 2019 at 04:47:23PM -0800, Dan Williams wrote:
> >>In recent days, 2 engineers, including the original author of
> >>nd_pfn_init(), overlooked the internal call to nd_pfn_validate() and the
> >>implications to memory allocation.
> >>
> >>Clarify this situation to help anyone that reads through this code in
> >>the future.
> >>
> >>Reported-by: Wei Yang <richardw.yang@linux.intel.com>
> >>Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >>---
> >> drivers/nvdimm/btt_devs.c |    5 +++++
> >> drivers/nvdimm/dax_devs.c |    5 +++++
> >> drivers/nvdimm/pfn_devs.c |   21 +++++++++++++++++++++
> >> 3 files changed, 31 insertions(+)
> >>
> >>diff --git a/drivers/nvdimm/btt_devs.c b/drivers/nvdimm/btt_devs.c
> >>index 795ad4ff35ca..e0a6f2491e57 100644
> >>--- a/drivers/nvdimm/btt_devs.c
> >>+++ b/drivers/nvdimm/btt_devs.c
> >>@@ -354,6 +354,11 @@ int nd_btt_probe(struct device *dev, struct nd_namespace_common *ndns)
> >>              put_device(btt_dev);
> >>      }
> >>
> >>+     /*
> >>+      * Successful probe indicates to the caller that an nd_btt
> >>+      * personality device has been registered and the caller can
> >>+      * fail the probe of the baseline namespace device.
> >>+      */
> >>      return rc;
> >> }
> >> EXPORT_SYMBOL(nd_btt_probe);
> >>diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> >>index 0453f49dc708..65010d955fa7 100644
> >>--- a/drivers/nvdimm/dax_devs.c
> >>+++ b/drivers/nvdimm/dax_devs.c
> >>@@ -136,6 +136,11 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
> >>      } else
> >>              __nd_device_register(dax_dev);
> >>
> >>+     /*
> >>+      * Successful probe indicates to the caller that a device-dax
> >>+      * personality device has been registered and the caller can
> >>+      * fail the probe of the baseline namespace device.
> >>+      */
> >>      return rc;
> >> }
> >> EXPORT_SYMBOL(nd_dax_probe);
> >>diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> >>index 6f22272e8d80..a8783b5a76ba 100644
> >>--- a/drivers/nvdimm/pfn_devs.c
> >>+++ b/drivers/nvdimm/pfn_devs.c
> >>@@ -576,6 +576,11 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
> >>      } else
> >>              __nd_device_register(pfn_dev);
> >>
> >>+     /*
> >>+      * Successful probe indicates to the caller that an nd_pfn
> >>+      * personality device has been registered and the caller can
> >>+      * fail the probe of the baseline namespace device.
> >>+      */
> >>      return rc;
> >> }
> >> EXPORT_SYMBOL(nd_pfn_probe);
> >>@@ -706,6 +711,22 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
> >>              sig = DAX_SIG;
> >>      else
> >>              sig = PFN_SIG;
> >>+
> >>+     /*
> >>+      * Check for an existing 'pfn' superblock before writing a new
> >>+      * one. The intended flow is that on the first probe of an
> >>+      * nd_{pfn,dax} device the superblock is calculated and written
> >>+      * to the namespace. In this case nd_pfn_validate() returns
> >>+      * -ENODEV because no valid superblock exists currently.
> >>+      *
> >>+      * On subsequent probes nd_pfn_validate() will find a valid
> >>+      * superblock and return 0.
> >>+      *
> >>+      * If an assumption of the superblock has been violated, like a
> >>+      * change to the physical alignment of the namespace,
> >>+      * nd_pfn_validate() will return an error other than -ENODEV to
> >>+      * fail probing.
> >>+      */
> >
> >Let me reply in this thread. Sorry for my poor understand, I don't get it
> >clearly now.
> >
> >To be honest, the structure is a little bit complicated, if my understanding
> >is not correct, please forgive my poor understand.
> >
> >Below is a code flow. To simply analysis, I setup kernel parameter memmap to
> >emulate, and configure one namespace to mode devdax. So that we would have the
> >same root for code flow.
> >
> >Let's start with nd_region_driver:
> >
> >    nd_region_probe
> >        nd_region_register_namespaces
> >           create_namespaces
> >       nd_region->btt_seed = nd_btt_create(nd_region);
> >       nd_region->pfn_seed = nd_pfn_create(nd_region);
> >       nd_region->dax_seed = nd_dax_create(nd_region);
>
> May I ask a question about the purpose to create these three device here?
>
> I see nd_pfn_create() doesn't allocate pfn_sb here, and the probe on these
> devices failed. Confused why we need these three devices.

These allow for the namespace creation flow. Namespace creation with
the pfn personality, for example, goes like this:

1/ Find available region capacity

2/ Allocate capacity to a namespace

3/ Assign that namespace to a free pfn instance
echo namespace0.0 > /sys/bus/nd/devices/pfn0.0/namespace

4/ Start the pfn0.0 device
echo pfn0.0 > /sys/bus/nd/drivers/nd_pmem/bind

5/ At this point nd_pfn_validate() returns -ENODEV, so the driver
writes the configuration to the device to be autodetected next time.

This explicit force binding operation is how the driver determines the
difference between the namespace creation case and the namespace
auto-probing case at the next driver load.

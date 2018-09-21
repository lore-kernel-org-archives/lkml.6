Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B145ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ADB21479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1s8GzjbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ADB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbeIUIcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:32:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42049 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeIUIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:32:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id h26-v6so11558173otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 19:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dnzl/BvBothJi1BIB6FfDXXcPYHXapCltSDZH+taKI=;
        b=1s8GzjbVsAXQ2erR+W0/KN7o/vgpIu/txW0tmRJX/j9vjwnHC7BPlK6MJlN1SAjp0u
         F/q+0WyF9lFe29cy5hqVSyQpXgvdM/79BawOzynQ6sa4tM/MTs62vwh2WuBoSZj/PUSj
         EeItNAlIuSl4OwtJ59pGPbuazk819YNpgRAxfE9sN7DhQ/DTGIlTQ9FAYP3SO2w6YFWZ
         BY4bBKIf4fXfpQZlXdv1bZk+GY7a4F3C212AKM61fZGJVKjp3zhIYdCsBS+INibUAh70
         dI+1njKp0RaTRe+wFxZSggO7lArqVmI7t2kTsIkvhisvduaFS1s9z65sJhN6VEtx6P2o
         lXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dnzl/BvBothJi1BIB6FfDXXcPYHXapCltSDZH+taKI=;
        b=AT6KHc2J/YGIn6DpE1Tls8Ne8EiUiPSUqueassQW0pdk9rOZ/ViLZzjEROBWrSo28P
         5/4Nmj9QniwcYUQ7019g/t4m638I3AA9RD/C94AOeXePo++0OtLLBRzn+8KfnUFt5SvE
         4QJSlYtu2AkrzN4GuB5fAvZ+TosnvR7Rbe9scr5uoRV9WdgnW4Hf8tQNBHjEjDk9G4PF
         s7IUgjXycLAh2rw00AdyS0Xgfqct0+nPcMYV3MBdXV+CX1cw8ePoikdUY/brxvptMEz5
         0iR8lCbDI2Ncp026B39Nikc44JvNVEiU/kXwl+JCCLZXAq4eS4TJNrqNedWYb1o+5kop
         tW7g==
X-Gm-Message-State: APzg51B+BBryo/Xil0n4MivgL2Ro2yPCLDwHPYtpa6Ul1zqZRTNs+fn8
        1k+86jjdyEY4ZCiNmHkmO44gG4BtSebh1llN4VwwZw==
X-Google-Smtp-Source: ANB0Vda8MZMnNmsJlQJSfd21AEHCUl/xEfDFoeF6HPfTSj0v2xllnuSjoacqVcRa2GHFw6w/0d4x3NAuxMomif3px64=
X-Received: by 2002:a9d:44ad:: with SMTP id v45-v6mr23213760ote.33.1537497974243;
 Thu, 20 Sep 2018 19:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222951.19464.39241.stgit@localhost.localdomain> <CAPcyv4hAEOUOBU4GENaFOb-xXi33g_ugCexfmY3DrLH27Z6MKg@mail.gmail.com>
 <b7e87e64-95d7-5118-6c7d-ad78d68dc92e@linux.intel.com> <CAPcyv4iE=mrvdfXQ94O1r_u1geLbxpF0so3_3z4JLky4SuUNdw@mail.gmail.com>
 <0d6525c1-2e8b-0e5d-7dae-193bf697a4ec@linux.intel.com>
In-Reply-To: <0d6525c1-2e8b-0e5d-7dae-193bf697a4ec@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Sep 2018 19:46:02 -0700
Message-ID: <CAPcyv4hqERm3YbgsE19M=8SRfrhyEo__LrLdcEj_YsLr2bLviA@mail.gmail.com>
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

On Thu, Sep 20, 2018 at 6:34 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
>
>
> On 9/20/2018 5:36 PM, Dan Williams wrote:
> > On Thu, Sep 20, 2018 at 5:26 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> >>
> >> On 9/20/2018 3:59 PM, Dan Williams wrote:
> >>> On Thu, Sep 20, 2018 at 3:31 PM Alexander Duyck
> >>> <alexander.h.duyck@linux.intel.com> wrote:
> >>>>
> >>>> This patch is meant to force the device registration for nvdimm devices to
> >>>> be closer to the actual device. This is achieved by using either the NUMA
> >>>> node ID of the region, or of the parent. By doing this we can have
> >>>> everything above the region based on the region, and everything below the
> >>>> region based on the nvdimm bus.
> >>>>
> >>>> One additional change I made is that we hold onto a reference to the parent
> >>>> while we are going through registration. By doing this we can guarantee we
> >>>> can complete the registration before we have the parent device removed.
> >>>>
> >>>> By guaranteeing NUMA locality I see an improvement of as high as 25% for
> >>>> per-node init of a system with 12TB of persistent memory.
> >>>>
> >>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >>>> ---
> >>>>    drivers/nvdimm/bus.c |   19 +++++++++++++++++--
> >>>>    1 file changed, 17 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> >>>> index 8aae6dcc839f..ca935296d55e 100644
> >>>> --- a/drivers/nvdimm/bus.c
> >>>> +++ b/drivers/nvdimm/bus.c
> >>>> @@ -487,7 +487,9 @@ static void nd_async_device_register(void *d, async_cookie_t cookie)
> >>>>                   dev_err(dev, "%s: failed\n", __func__);
> >>>>                   put_device(dev);
> >>>>           }
> >>>> +
> >>>>           put_device(dev);
> >>>> +       put_device(dev->parent);
> >>>
> >>> Good catch. The child does not pin the parent until registration, but
> >>> we need to make sure the parent isn't gone while were waiting for the
> >>> registration work to run.
> >>>
> >>> Let's break this reference count fix out into its own separate patch,
> >>> because this looks to be covering a gap that may need to be
> >>> recommended for -stable.
> >>
> >> Okay, I guess I can do that.
> >>
> >>>
> >>>>
> >>>>    static void nd_async_device_unregister(void *d, async_cookie_t cookie)
> >>>> @@ -504,12 +506,25 @@ static void nd_async_device_unregister(void *d, async_cookie_t cookie)
> >>>>
> >>>>    void __nd_device_register(struct device *dev)
> >>>>    {
> >>>> +       int node;
> >>>> +
> >>>>           if (!dev)
> >>>>                   return;
> >>>> +
> >>>>           dev->bus = &nvdimm_bus_type;
> >>>> +       get_device(dev->parent);
> >>>>           get_device(dev);
> >>>> -       async_schedule_domain(nd_async_device_register, dev,
> >>>> -                       &nd_async_domain);
> >>>> +
> >>>> +       /*
> >>>> +        * For a region we can break away from the parent node,
> >>>> +        * otherwise for all other devices we just inherit the node from
> >>>> +        * the parent.
> >>>> +        */
> >>>> +       node = is_nd_region(dev) ? to_nd_region(dev)->numa_node :
> >>>> +                                  dev_to_node(dev->parent);
> >>>
> >>> Devices already automatically inherit the node of their parent, so I'm
> >>> not understanding why this is needed?
> >>
> >> That doesn't happen until you call device_add, which you don't call
> >> until nd_async_device_register. All that has been called on the device
> >> up to now is device_initialize which leaves the node at NUMA_NO_NODE.
> >
> > Ooh, yeah, missed that. I think I'd prefer this policy to moved out to
> > where we set the dev->parent before calling __nd_device_register, or
> > at least a comment here about *why* we know region devices are special
> > (i.e. because the nd_region_desc specified the node at region creation
> > time).
> >
>
> Are you talking about pulling the scheduling out or just adding a node
> value to the nd_device_register call so it can be set directly from the
> caller?

I was thinking everywhere we set dev->parent before registering, also
set the node...

> If you wanted what I could do is pull the set_dev_node call from
> nvdimm_bus_uevent and place it in nd_device_register. That should stick
> as the node doesn't get overwritten by the parent if it is set after
> device_initialize. If I did that along with the parent bit I was already
> doing then all that would be left to do in is just use the dev_to_node
> call on the device itself.

...but this is even better.

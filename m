Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B8C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83272086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="czVfC3gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83272086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeIZDmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:42:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43656 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIZDmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:42:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id e21-v6so13279883otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmUb/pc8AqticCm2EH/yfPOthcBGsqHrJwPuD7sh9Os=;
        b=czVfC3gqMMJAVUvnWHDFMfPpQL3lNW59G6XcC4MlF7YLJyS8A9D/0k+lQPzjmHxqHv
         QiWQ3GSutkOE5OOuFLmt5VX/cH3rPBWPM11VGUZdoLpckLqaq6SA6Bl2VlLP5cdUdJW5
         4dw7AE9Tzmgo0+naLAmjcZpr4rI4sxjCQeyBh0AqnM6oq5i/hue1oyJTxCgOUVhyoCDi
         WCwqPlp5pWmJ1dzJygf8UOOEv4TzHORVUrHZAiCD3RWQpzUKq7z/gTbjiZG1JHZjHlUR
         BNHmVZ2RHlTi3J+DHytye6SkdBj89LC7dVZw5rt2CuQMg9GRBEwcboN3JTtIe9Ed2uub
         D4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmUb/pc8AqticCm2EH/yfPOthcBGsqHrJwPuD7sh9Os=;
        b=KbpqnlHNFFJpAKwgzLr/498qK0sogBp2DfuZM9dgW1w6aXtGlBo8F6CKxEQ3UPsJvf
         VqI41ULHIcjMEu8/XuKcDkSEcVrUn33RjtnWSYWutSn05rHMEbtiE+SWtIZgmOWIcY05
         cE/YQ/px0wDK2MZCPSJlvYZAlY7y1UctivEH51u1rgX0YWEPJutSQYX0O/mnKs6Px0//
         jE+I85DvcJgnBeLaFJJ6wEOWhyf2OUr1EFf4AafGKcoOLCdf+Z/zLEePVDv/KD1c6Pcz
         u24RyCrY4Qg66rXjgg1haMAazDwzHFmTANmrb/swy9d6qJE0RQZgNJYlaESC2mzqofGt
         EmiA==
X-Gm-Message-State: ABuFfoj2PfzFnRiGTvjsMFX9tRaVrPxFKYkMAQwYHsHC5KbZyAJpto3N
        pBsYKVxcoGOjpImw5ie9Zpr/MJfbWk3AvcoHwPE1OQ==
X-Google-Smtp-Source: ACcGV63C94GRkoXT4foLFzk0FgRXwswFKcO8j5HuV9JYLBqDgxMpkGBKJwiscBtZD3ReiCRt3O/6eniRk45r844DjrY=
X-Received: by 2002:a9d:e4:: with SMTP id 33-v6mr1995943otk.372.1537911189399;
 Tue, 25 Sep 2018 14:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180925204801.6182.73167.stgit@localhost.localdomain>
 <20180925205307.6182.26453.stgit@localhost.localdomain> <CAPcyv4jpUNP4mySPr5jYogpf5ZMPgpTu9oOjC89ZYHa=vL1JwQ@mail.gmail.com>
 <bcd44872-1961-79ff-f1a5-8ab2c2a99c20@linux.intel.com>
In-Reply-To: <bcd44872-1961-79ff-f1a5-8ab2c2a99c20@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 14:32:58 -0700
Message-ID: <CAPcyv4jhxGubqLiHC=jqy2Bn7XQALUUoFcfEVKCUSeqGWCstLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvdimm: Set device node in nd_device_register
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:11 PM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
>
>
> On 9/25/2018 2:08 PM, Dan Williams wrote:
> > On Tue, Sep 25, 2018 at 1:56 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> >>
> >> This change makes it so that we don't repeatedly overwrite the device node
> >> for nvdimm regions. The earliest we can set the node is immediately after
> >> calling device init, so I have moved the code there so we can avoid
> >> rewriting the node with each uevent.
> >>
> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> ---
> >>   drivers/nvdimm/bus.c |   16 ++++++++++------
> >>   1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
> >> index 9148015ed803..96f4d0e1706a 100644
> >> --- a/drivers/nvdimm/bus.c
> >> +++ b/drivers/nvdimm/bus.c
> >> @@ -54,12 +54,6 @@ static int to_nd_device_type(struct device *dev)
> >>
> >>   static int nvdimm_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>   {
> >> -       /*
> >> -        * Ensure that region devices always have their numa node set as
> >> -        * early as possible.
> >> -        */
> >> -       if (is_nd_region(dev))
> >> -               set_dev_node(dev, to_nd_region(dev)->numa_node);
> >>          return add_uevent_var(env, "MODALIAS=" ND_DEVICE_MODALIAS_FMT,
> >>                          to_nd_device_type(dev));
> >>   }
> >> @@ -519,6 +513,16 @@ void __nd_device_register(struct device *dev)
> >>   void nd_device_register(struct device *dev)
> >>   {
> >>          device_initialize(dev);
> >> +
> >> +       /*
> >> +        * Ensure that region devices always have their NUMA node set as
> >> +        * early as possible. This way we are able to make certain that any
> >> +        * memory associated with the creation and the creation itself of
> >> +        * the region is associated with the correct node.
> >> +        */
> >> +       if (is_nd_region(dev))
> >> +               set_dev_node(dev, to_nd_region(dev)->numa_node);
> >> +
> >>          __nd_device_register(dev);
> >
> > Any reason to not put this inside __nd_device_register()? If you're ok
> > with that I can just fix up when applying.
>
> I put it here since regions never call __nd_device_register directly,
> they always call nd_device_register. I figured that by placing it here
> we reduce the impact of this on the other devices that aren't going to
> need it.

I can't imagine there's much of an impact because we're already
reading the cacheline that has dev->parent so dev->type is already
there. If we're going to add support for looking up the parent node to
schedule namespace registration work to the proper core I would expect
that to appear in the __nd_device_register() common code as well.

In general the only consideration for calling nd_device_register() vs
__nd_device_register() is whether or not you want a
device_initialize() to occur.

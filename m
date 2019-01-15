Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2300C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MvKMISO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfAOWDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:03:02 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37508 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729068AbfAOWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:03:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so1962308pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJmXJeT0SSTONHjw5vGPCW8WRjLsHrstLIrZeQ0NIjo=;
        b=MvKMISO4HPuoS1gY8m0rOVaa8bvuzrWS/P3S2cNu4CM5PN6TtouORZdv/J0r5jfPgU
         XJ4PrX47yHXSrJR9/CHNiEj1/YHUAkrhyeyw3W9eKzJiuPiOoRIFFaoI2tpH27fEFRvj
         s+dkTaOvsCk7aGcYzrUJQTpUFgjvHeNP6a48Ne/FNAkSCnufXZp1BlHTomXJLrrGLuIY
         MUzoJOOr1t+vYjDAgXXMjLHaJaBxmOvmXikPYsoRBZGMARKs7UEN+rs2c7usG4tm5z/u
         QVv1jSdA1HSwJDAL/tcWlhHmxazbQ96oqvPq/YRa5IAlaGQysQ7nuQzGB37R921Ms6Uj
         5Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJmXJeT0SSTONHjw5vGPCW8WRjLsHrstLIrZeQ0NIjo=;
        b=qKVvUEtq+tJM5WhQh+2EsjlKRPSUG8D/oLOLVUy3V9AOL1hqEoCexmXrPPy/yqRcpH
         dUhUWAOWNUAz8bfBuJySnc6VozUPFboj6qQ4RIbfwu8DekLdUTKO29ddeQrE7YQx5djt
         C42gaV8iEk1dsLOerW7mG4LCmkcBUDjHwZLkx1Pz2mlfIFKBxnvOUz3pi3YjHwnl40g2
         ZHEEEzqJK7o6hEHFLva0RZdh/o+HswOQ6FRXrY9tMLE2MsD0q7aGc2+HAT2T+7b5FnUz
         yYnyTODO/SjA14405KZmnWWqOExiLxS+Wt77IW3UvQIU8EnCOVdmCp8R5h4yUr/XGev3
         X+iQ==
X-Gm-Message-State: AJcUukdIlxTCik9LW6FIz9AUyO9bCT/rzDCVbV7lBXVl23oWD6MQgn2S
        Nxa8rDdcG+x3y1GK1nXX1DoPqg==
X-Google-Smtp-Source: ALg8bN6qxoYBdmTRvCrhBGIJvZCq9ISDSq756TGxPIH6POelGyFVmYOXXWK0fjhI7opcQdsKxQH7JQ==
X-Received: by 2002:a63:5252:: with SMTP id s18mr5751206pgl.326.1547589780960;
        Tue, 15 Jan 2019 14:03:00 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e86sm6070305pfb.6.2019.01.15.14.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:03:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjWnT-0001KT-FS; Tue, 15 Jan 2019 15:02:59 -0700
Date:   Tue, 15 Jan 2019 15:02:59 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-rc 1/3] RDMA/hns: Fix the Oops during rmmod or
 insmod ko when reset occurs
Message-ID: <20190115220259.GH22045@ziepe.ca>
References: <1547128663-69220-1-git-send-email-xavier.huwei@huawei.com>
 <1547128663-69220-2-git-send-email-xavier.huwei@huawei.com>
 <20190111213411.GA22310@ziepe.ca>
 <5C399D73.5000902@huawei.com>
 <20190114220655.GD1208@ziepe.ca>
 <5C3D3BD1.4000508@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C3D3BD1.4000508@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 09:48:01AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/15 6:06, Jason Gunthorpe wrote:
> > On Sat, Jan 12, 2019 at 03:55:31PM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2019/1/12 5:34, Jason Gunthorpe wrote:
> >>> On Thu, Jan 10, 2019 at 09:57:41PM +0800, Wei Hu (Xavier) wrote:
> >>>> +	/* Check the status of the current software reset process, if in
> >>>> +	 * software reset process, wait until software reset process finished,
> >>>> +	 * in order to ensure that reset process and this function will not call
> >>>> +	 * __hns_roce_hw_v2_uninit_instance at the same time.
> >>>> +	 * If a timeout occurs, it indicates that the network subsystem has
> >>>> +	 * encountered a serious error and cannot be recovered from the reset
> >>>> +	 * processing.
> >>>> +	 */
> >>>> +	if (ops->ae_dev_resetting(handle)) {
> >>>> +		dev_warn(dev, "Device is busy in resetting state. waiting.\n");
> >>>> +		end = msecs_to_jiffies(HNS_ROCE_V2_RST_PRC_MAX_TIME) + jiffies;
> >>>> +		while (ops->ae_dev_resetting(handle) &&
> >>>> +		       time_before(jiffies, end))
> >>>> +			msleep(20);
> >>> Really? Does this have to be so ugly? Why isn't there just a simple
> >>> lock someplace that is held during reset?
> >>>
> >>> I'm skeptical that all this strange looking stuff is properly locked
> >>> and concurrency safe.
> >> Hi, Jason
> >>
> >> The hns3 NIC driver notifies the hns RoCE driver to perform
> >> reset related processing by calling the .reset_notify() interface
> >> registered by the RoCE driver.
> >>
> >> There is a constraint on the hip08 chip, the NIC driver needs to
> >> stop the flow before hardware startup reset, otherwise the chip
> >> may hang up.
> >>
> >> We've also thought about using locks, but found using locks can
> >> lead to more serious problems because of that restriction of the
> >> chip.
> >> If using locks here, reset processing may wait for uninstallation
> >> to complete, this may lead that NIC driver fails to stop the flow
> >> in time in the reset process, thus causing the chip to hang up.
> > If you are sleeping then I'm sure a lock can be used instead, how
> > would it be any different?
> Hi, Jason
>     If using locks here, reset process may wait until uninstallation to
> complete,
>         it may trigger the chip constraint, causing chip to hang up.
>     But if using sleeping here, there will notthe case that reset
> process wait until
>        uninstallation to complete, then will not trigger the chip
> constraint.

But how is this even right? If ops->ae_dev_resetting can change at any
time, and you need to wait for it here, without locks can't it just
change instantly after the if statement?

I think it shows the concurrancy & locking is not done right when I
see loops reading shared data and spinning on them with msleep.

Jason

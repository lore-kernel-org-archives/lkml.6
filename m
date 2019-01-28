Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16F8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8155720855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Eszo1Yl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfA1S2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:28:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41975 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfA1S2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:28:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so8373382pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptsk2SlNNOuTUVXA7em1XNiAmtxH8MkYLGmVaFJWEqI=;
        b=Eszo1Yl34rb4MUH/OjjZftb7UqQ9oULfpxilM7Co+Jhzt0nUCKA1N4Bv7pFEDiD/sD
         hltsKm9HdxE2kBKBqRUIFMMm1xu7b1dmI05dZ5c+WiMObr2GXKo2RZWbNrZPJz0ToWo5
         9yGkWaTJAmoHoOe+mWPAkStp/2rR5IGpkV3YepUXNmEKedmt+U7RxoQJAFbdYUsBg+Z8
         ebYptuJyuL/AU1aXzPCq+dzYL62fymZ8/5jc2O53EE880IgWNKmp1gnzKJFVEw+d+lMJ
         1iTJgEKpekx29zJDSjc15+BhmeU8Y7vstA1FIFLYZL4gn0XnN+qWfiiBs1kZMX7+usF/
         ArrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptsk2SlNNOuTUVXA7em1XNiAmtxH8MkYLGmVaFJWEqI=;
        b=jJnjGakFEkgrBOhRPbBDwMYaimFHUpsjNGum39W5nUOkiGIEcrlkME2Jy5PZ3NJyvv
         tUOaHytzyIzEVn9C3pvnJETLsvdRR8BevG+nRaTVRQofxIj2oHpS1mzlc3FJLw+/uuXz
         Tl4WdkWFN9xHmFJqdbPCPTGug+X2iVl1GEFJLNxovSqawfK9QO1kuc/N3dAckBvcg1km
         KjCdVGKG3czq+MTXtLcZ7phZxnhTHY8xiVppE1otZ9FxP83NxN/W2aqrHAmrXDtlQn2o
         0eVAn7E/vF9zYV+xvg8yYjJoFZ7OTmU/C0bE1qpMUEK5RgmPPp1Gff0td9YygfrQGraP
         yxug==
X-Gm-Message-State: AJcUukdW2SUNRn/9r3gx7ukmUuXYQlcUdK1ghce4i0Rfc6McAwaRrPcR
        qKtU4Wb9v0rBfYgusOjj+3WlNw==
X-Google-Smtp-Source: ALg8bN7q7XbMmkVlBHfkPd6fByrk9dkFO9WwcCDgeppNsx1rHo9gO6r+Fzkci4MgYVCnUM79yncnTA==
X-Received: by 2002:a62:15d5:: with SMTP id 204mr23242716pfv.103.1548700081981;
        Mon, 28 Jan 2019 10:28:01 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id w88sm71587926pfk.11.2019.01.28.10.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:28:00 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goBdX-0007vz-RM; Mon, 28 Jan 2019 11:27:59 -0700
Date:   Mon, 28 Jan 2019 11:27:59 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        xavier_huwei@163.com
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused
 by sending mailbox&CMQ during reset
Message-ID: <20190128182759.GA25106@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
 <20190123224041.GA11605@ziepe.ca>
 <5C492D59.8030707@huawei.com>
 <20190124183120.GD17167@ziepe.ca>
 <5C4A714C.2070109@huawei.com>
 <20190125215018.GF23001@ziepe.ca>
 <5C4BBC3E.2000004@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C4BBC3E.2000004@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 09:47:42AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/26 5:50, Jason Gunthorpe wrote:
> > On Fri, Jan 25, 2019 at 10:15:40AM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2019/1/25 2:31, Jason Gunthorpe wrote:
> >>> On Thu, Jan 24, 2019 at 11:13:29AM +0800, Wei Hu (Xavier) wrote:
> >>>> On 2019/1/24 6:40, Jason Gunthorpe wrote:
> >>>>> On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:
> >>>>>
> >>>>>> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
> >>>>>> +					unsigned long instance_stage,
> >>>>>> +					unsigned long reset_stage)
> >>>>>> +{
> >>>>>> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
> >>>>>> +	struct hnae3_handle *handle = priv->handle;
> >>>>>> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> >>>>>> +	unsigned long end;
> >>>>>> +
> >>>>>> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
> >>>>>> +	 * to hardware, and wait until hardware reset finished. If now
> >>>>>> +	 * in .init_instance() function, we should exit with error. If now at
> >>>>>> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
> >>>>>> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
> >>>>>> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
> >>>>>> +	 * related process will exit with error to notify NIC driver to
> >>>>>> +	 * reschedule soft reset process once again.
> >>>>>> +	 */
> >>>>>> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> >>>>>> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
> >>>>>> +		udelay(1);
> >>>>> I thought you were getting rid of these loops?
> >>>> Hi, Jason
> >>>>
> >>>>     Upper applications maybe notify driver to issue mailbox or CMD
> >>>>     commands to hardware, some commands used to cancel resources,
> >>>>     destory bt/destory cq/unreg mr/destory qp etc. when such
> >>>>     commands are executed successfully, the hardware engine will
> >>>>     no longer access some memory registered by the driver.
> >>>>
> >>>>     When reset occurs, it is possible for upper applications notify driver
> >>>>     to issue mailbox or CMD commands, we need to wait until hardware
> >>>>     reset finished to ensure that hardware no longer accesses related
> >>>> memory.
> >>> You should not wait for things using loops like the above.
> >> Hi, Jason
> >>
> >>     Are your comments foucsing on udelay? If not, thanks for your detail
> >> information.
> >>     In hns3 RoCE driver, some CMQ/mailbox operation are called inside
> >> the lock,
> >>     we can't use msleep in the lock, otherwise it will cause deadlock.
> >>     When reset occurs, RDMA service cannot be provided normally, I think
> >> in this
> >>     case using udelay will not have a great impact.
> > You should not use any kind of sleep call in a loop like this.
> Hi, Jason
> 
>     OK, I got your opinion and will modify it in v3 patch as below:   
> 
>     end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
>     while (time_before(jiffies, end))
>         if (!ops->get_hw_reset_stat(handle))
>             break;           

You shouldn't be looping like this at all, a busy loop is worse, don't
try and open code spinlocks.

Jason

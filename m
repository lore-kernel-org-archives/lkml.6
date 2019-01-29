Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB7C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44F92175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l1WT+Gby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfA2DpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:45:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40930 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfA2DpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:45:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so8734249plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag/OoE0BZaOYWPHi7HQ6/y8oewTzFELmcmGVsk453bY=;
        b=l1WT+GbyMVebD6hUdWHWK+jR6+XM4eatD4OqeYxM7/ILHY2fN4dkAjW4e6yqBVGJJG
         9PKth5DG5D7luIBBa8vUmmqIuD+mshcgGPc83cbG90jkMtSFEpPjsgtv9zC9oZnJhugO
         mF3ZmSMgxVrNr12L9bkEJAagqUxx/KRjpzUS/EBDoWf5JGXCvG6WVulcTkG3cY4XzhLy
         E4b8fktMP5+Gm4x5QrquCoW5fBvPlp9vlqvdNf5yBB/mv92gRMi2OppWymRE3jeqfWxw
         L6Jq7Gy4ZMhEIOCOA7TWIAR3WHF3ZEdhWWE4XgJ8RPI6/8fZ8Z87wLFPWKEOTuih0HNQ
         kulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag/OoE0BZaOYWPHi7HQ6/y8oewTzFELmcmGVsk453bY=;
        b=TkL+RzUDmblYRw5xwFO0tXn5nr14Y1KKaCZrKQYSvh09hfIAhtq2RZ0KGZg+cYHryO
         LkF8kNwO68ptwR71TwijdLDD1xdD7lV2/jp/1HemN/WAVP4rR/2b6BQ8bK3Qfgb15KBw
         xjXkuiLQe7imHtoa73XQI/CK7xNm2dBytz2K5sK7k+69uI3RfUMJwViCUPw0sTwyPi1d
         ZVkzLz89VWPVjVKR84AyZgpIA7k9dQPiXR1dPXb/fOQxRwp75GeGDsGdFMFhUWy6ahQP
         OQJ+2pLUjgn4odp7+REW7MfvWFCcVKEq1KNvsFtXMDyvjDDbemIpI6pzUe+YVx9xuNnt
         eTEg==
X-Gm-Message-State: AJcUukdGOl3IH2C7Pg95CE2IFruRhvUAqfeMKuXWGPQoyvAcjSnEb9qE
        F3yvwhv7TXUUaDEwHfPqGP7Xyg==
X-Google-Smtp-Source: ALg8bN7BRmYmIOVCFQI6foHo5ZmMj8ynyHdKzDj7EMqRLQboNl8YgzUxqUeTxjHGGtzNLa+U08P4yQ==
X-Received: by 2002:a17:902:6946:: with SMTP id k6mr24873902plt.101.1548733506641;
        Mon, 28 Jan 2019 19:45:06 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id l185sm48710558pfl.54.2019.01.28.19.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 19:45:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1goKKf-0004wg-61; Mon, 28 Jan 2019 20:45:05 -0700
Date:   Mon, 28 Jan 2019 20:45:05 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        xavier_huwei@163.com
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused
 by sending mailbox&CMQ during reset
Message-ID: <20190129034505.GK25106@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
 <20190123224041.GA11605@ziepe.ca>
 <5C492D59.8030707@huawei.com>
 <20190124183120.GD17167@ziepe.ca>
 <5C4A714C.2070109@huawei.com>
 <20190125215018.GF23001@ziepe.ca>
 <5C4BBC3E.2000004@huawei.com>
 <20190128182759.GA25106@ziepe.ca>
 <5C4FB800.3060506@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C4FB800.3060506@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 10:18:40AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/29 2:27, Jason Gunthorpe wrote:
> > On Sat, Jan 26, 2019 at 09:47:42AM +0800, Wei Hu (Xavier) wrote:
> >>
> >> On 2019/1/26 5:50, Jason Gunthorpe wrote:
> >>> On Fri, Jan 25, 2019 at 10:15:40AM +0800, Wei Hu (Xavier) wrote:
> >>>> On 2019/1/25 2:31, Jason Gunthorpe wrote:
> >>>>> On Thu, Jan 24, 2019 at 11:13:29AM +0800, Wei Hu (Xavier) wrote:
> >>>>>> On 2019/1/24 6:40, Jason Gunthorpe wrote:
> >>>>>>> On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:
> >>>>>>>
> >>>>>>>> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
> >>>>>>>> +					unsigned long instance_stage,
> >>>>>>>> +					unsigned long reset_stage)
> >>>>>>>> +{
> >>>>>>>> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
> >>>>>>>> +	struct hnae3_handle *handle = priv->handle;
> >>>>>>>> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> >>>>>>>> +	unsigned long end;
> >>>>>>>> +
> >>>>>>>> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
> >>>>>>>> +	 * to hardware, and wait until hardware reset finished. If now
> >>>>>>>> +	 * in .init_instance() function, we should exit with error. If now at
> >>>>>>>> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
> >>>>>>>> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
> >>>>>>>> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
> >>>>>>>> +	 * related process will exit with error to notify NIC driver to
> >>>>>>>> +	 * reschedule soft reset process once again.
> >>>>>>>> +	 */
> >>>>>>>> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> >>>>>>>> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
> >>>>>>>> +		udelay(1);
> >>>>>>> I thought you were getting rid of these loops?
> >>>>>> Hi, Jason
> >>>>>>
> >>>>>>     Upper applications maybe notify driver to issue mailbox or CMD
> >>>>>>     commands to hardware, some commands used to cancel resources,
> >>>>>>     destory bt/destory cq/unreg mr/destory qp etc. when such
> >>>>>>     commands are executed successfully, the hardware engine will
> >>>>>>     no longer access some memory registered by the driver.
> >>>>>>
> >>>>>>     When reset occurs, it is possible for upper applications notify driver
> >>>>>>     to issue mailbox or CMD commands, we need to wait until hardware
> >>>>>>     reset finished to ensure that hardware no longer accesses related
> >>>>>> memory.
> >>>>> You should not wait for things using loops like the above.
> >>>> Hi, Jason
> >>>>
> >>>>     Are your comments foucsing on udelay? If not, thanks for your detail
> >>>> information.
> >>>>     In hns3 RoCE driver, some CMQ/mailbox operation are called inside
> >>>> the lock,
> >>>>     we can't use msleep in the lock, otherwise it will cause deadlock.
> >>>>     When reset occurs, RDMA service cannot be provided normally, I think
> >>>> in this
> >>>>     case using udelay will not have a great impact.
> >>> You should not use any kind of sleep call in a loop like this.
> >> Hi, Jason
> >>
> >>     OK, I got your opinion and will modify it in v3 patch as below:   
> >>
> >>     end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> >>     while (time_before(jiffies, end))
> >>         if (!ops->get_hw_reset_stat(handle))
> >>             break;           
> > You shouldn't be looping like this at all, a busy loop is worse, don't
> > try and open code spinlocks.
> Hi, Jason
>    
>         OK,  we will modify some places calling CMQ/mailbox operation,
>         replace spinlock with mutex, and add msleep here:
> 
>     end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
>     while (time_before(jiffies, end)) {
>         if (!ops->get_hw_reset_stat(handle))
>             break;
> 	msleep(20); 
>     }

How many more times do I have to say not to code spin loops like
this???? Use proper locking!

Jason

Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04892218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YHMjCOkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfAXSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:31:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAXSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:31:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so3012305pgk.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A6QBegBSPrD1wbNcx6Imf1vbJfpaI+cP3PrvCbpYma4=;
        b=YHMjCOkzJ+kHUYohq/Msrb8CiQ2QBEzaw3D5pCTN1IljKv/Oq231pfzmRUWr3aYybY
         zaTa/rxerL/Vmm/fBaVSXiLzJ8PDIiOaJ+g4nMeyXoafAeFQQQOoFg1wkQSrm0rydY7U
         kOlaVIp8pqa/5M4Te3my1u4a45MrKZMO4ADTFHWzEoskwCIY9YmE8qZDJrt7V7NNBrJn
         WoQGGQD//b+c0DYwL1mT612JspSmHr/dgSOaDnXsp0Q/gXSesmYMna2x4kZSOjDKvvMn
         x5oRE+lcuMnxgIjmhGi65vMF1q6rWNHZwOZsDGppfXx06NWeKIeZY6pg+TqzqTj3fMaQ
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A6QBegBSPrD1wbNcx6Imf1vbJfpaI+cP3PrvCbpYma4=;
        b=dQwwmgErK2XwtZsm2LAtntkQwurfqFheTn8uWN4NFFOMej9A9DPffuqlhAj56TpSrc
         mm1QTEpfbHT78sAtWWeG0iq0KazPSf0RENup1CVUFY2D8l5NkNL1H9BLj03qNfZs8560
         LHZc974KKRaEkCj9O7TEM1eCV4qjT9nA04QSqLH/n9ExUGopCY+mEWgKet8062t9hZzp
         TFvGUAw3i4fZXBH5lkUMIOOMOfBe7rfBuPRpNMdLIvE6utleGrgUHesMjiZ0WO+Gu/KI
         yQR4ieo3ij3Tz1cYf24rTyTrdFMgpnXE2O+BhNbqJpTS//TC8jyFPIRsmZxhEwsfbJuq
         HZhA==
X-Gm-Message-State: AJcUukeU2dnDKjNdzPlP4/pJTx2J8QfWuWAczjN6shN2d28sZaF54KKV
        NypbIwPuk0BuJJpe4cmLhlRXjQ==
X-Google-Smtp-Source: ALg8bN7MwzTeSVlhhq139gRi1XP0vsh0XDyiJDzhXOwhYlr9fwvmr4nnB4nJZFfdmCgPlN5DIJqN3g==
X-Received: by 2002:a63:f658:: with SMTP id u24mr6976117pgj.267.1548354681822;
        Thu, 24 Jan 2019 10:31:21 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i5sm32156005pfg.34.2019.01.24.10.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 10:31:21 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmjma-0005sS-9U; Thu, 24 Jan 2019 11:31:20 -0700
Date:   Thu, 24 Jan 2019 11:31:20 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, liudongdong3@huawei.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        xavier_huwei@163.com
Subject: Re: [PATCH V2 rdma-next 2/3] RDMA/hns: Fix the chip hanging caused
 by sending mailbox&CMQ during reset
Message-ID: <20190124183120.GD17167@ziepe.ca>
References: <1547868967-115951-1-git-send-email-xavier.huwei@huawei.com>
 <1547868967-115951-3-git-send-email-xavier.huwei@huawei.com>
 <20190123224041.GA11605@ziepe.ca>
 <5C492D59.8030707@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C492D59.8030707@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 11:13:29AM +0800, Wei Hu (Xavier) wrote:
> 
> 
> On 2019/1/24 6:40, Jason Gunthorpe wrote:
> > On Sat, Jan 19, 2019 at 11:36:06AM +0800, Wei Hu (Xavier) wrote:
> >
> >> +static int hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
> >> +					unsigned long instance_stage,
> >> +					unsigned long reset_stage)
> >> +{
> >> +	struct hns_roce_v2_priv *priv = (struct hns_roce_v2_priv *)hr_dev->priv;
> >> +	struct hnae3_handle *handle = priv->handle;
> >> +	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> >> +	unsigned long end;
> >> +
> >> +	/* When hardware reset is detected, we should stop sending mailbox&cmq
> >> +	 * to hardware, and wait until hardware reset finished. If now
> >> +	 * in .init_instance() function, we should exit with error. If now at
> >> +	 * HNAE3_INIT_CLIENT stage of soft reset process, we should exit with
> >> +	 * error, and then HNAE3_INIT_CLIENT related process can rollback the
> >> +	 * operation like notifing hardware to free resources, HNAE3_INIT_CLIENT
> >> +	 * related process will exit with error to notify NIC driver to
> >> +	 * reschedule soft reset process once again.
> >> +	 */
> >> +	end = msecs_to_jiffies(HNS_ROCE_V2_HW_RST_TIMEOUT) + jiffies;
> >> +	while (ops->get_hw_reset_stat(handle) && time_before(jiffies, end))
> >> +		udelay(1);
> > I thought you were getting rid of these loops?
> Hi, Jason
> 
>     Upper applications maybe notify driver to issue mailbox or CMD
>     commands to hardware, some commands used to cancel resources,
>     destory bt/destory cq/unreg mr/destory qp etc. when such
>     commands are executed successfully, the hardware engine will
>     no longer access some memory registered by the driver.
> 
>     When reset occurs, it is possible for upper applications notify driver
>     to issue mailbox or CMD commands, we need to wait until hardware
>     reset finished to ensure that hardware no longer accesses related
> memory.

You should not wait for things using loops like the above.

Jason

Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A165AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1282146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DYqwMV66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1282146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbeIRCh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:37:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42718 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeIRCh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:37:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so7983420plq.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ghJwUjV6tbM+kp4hb+91uM3gpdooa8rCPZVG8PR1RtE=;
        b=DYqwMV663/GU+yd6ty107gL2LoqVrer7+3dqIW9mdR1Cy0PlAVqxow+Kd4thj64q1p
         5peDyfnyTOQbvCSzMkU0Wr6uZujvfXUQnoh5rdjsB0OpKNCVhcsOuRcTwGb1wFZHUQAa
         rKMNUeD+XyEIvr1PU4XborP8gD8WPyeKMJgEvhdiWq+3SMWp2M4VY8WTOx+j+/SX50QR
         WCq4X80gXzJp8vLJSXfCI8li4vyEX0ulQi9sGdQGDLZVlPHYGrVzd4uPinXtU5Lr+rlg
         LVa025lK/4UKD8Dy8VrJ+Ztc45zMLy0Doo4VXZUInVawRPonbL5RYMpd4q7F0sbVKCii
         64ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghJwUjV6tbM+kp4hb+91uM3gpdooa8rCPZVG8PR1RtE=;
        b=NtSNaut3+vWP8XIoM/bbV76elH40hzNiSL/CWkvNMMtu25CYM0iM7/GGq2S7vU4Zl+
         aRxZOjuLONnqRdessQfP719tdv1n71hRmyKl1pLk769Ayu4QVQ1YeV3B3iZY8BZFjSuR
         y9bIWZshm3M/jGZVbNro775P1G7U89FLR/Jes4NhCd0J12+n16e0RapMPqS3YINYbFbt
         J5NK6PpTwRTZ/LApYzsUSjOtUTlKYJMYwxQfDQqqVmPcJBJdCDTrZkU8OGkeJZX7busi
         sDGaApzoX6MuWLHgVFLmD/v0oBxNEn/BZKamhaY+BFu6tDH1AkbEmM3LdbgsfD1VmK5b
         FVZw==
X-Gm-Message-State: APzg51Cu3vbdYLNrmLo57OET1c6fkL57R+m80kf+qKVcQm2cQeYWDqTF
        dq9wXTQAQb20fi/pDSehb5bWOg==
X-Google-Smtp-Source: ANB0Vdb6JuxWXezyWLZlFk8G5VNEQ7t0GVaDSCYMA3C+jk0+sENHUD38JD+0v42h5CGnm/OaqT/e6w==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr26786221plk.127.1537218506039;
        Mon, 17 Sep 2018 14:08:26 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g25-v6sm26899123pfd.23.2018.09.17.14.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 14:08:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g20kq-0008C8-OV; Mon, 17 Sep 2018 15:08:24 -0600
Date:   Mon, 17 Sep 2018 15:08:24 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Walker, Benjamin" <benjamin.walker@intel.com>
Cc:     "Howell, Seth" <seth.howell@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Message-ID: <20180917210824.GF11367@ziepe.ca>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
 <20180816180126.GB10507@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD0086118B12@FMSMSX105.amr.corp.intel.com>
 <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f85f780435a5ded567bc8559d7c770d3bc4464.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 08:38:16PM +0000, Walker, Benjamin wrote:
> On Mon, 2018-08-20 at 14:32 -0700, Howell, Seth wrote:
> > Hi Jason,
> > 
> > I apologize for the few days of radio silence on this one. I was able to apply
> > your patch on my local configuration and can confirm that it fixes the issue
> > of send with invalidate being improperly mapped between a user-space process
> > and the kernel rxe driver.
> > 
> > Thanks again for your time and help.
> > 
> > Seth Howell
> > 
> > From: linux-rdma-owner@vger.kernel.org [mailto:
> > linux-rdma-owner@vger.kernel.org] On Behalf Of Jason Gunthorpe
> > Sent: Thursday, August 16, 2018 11:01 AM
> > To: Howell, Seth <seth.howell@intel.com>
> > Cc: Walker, Benjamin <benjamin.walker@intel.com>; Doug Ledford <
> > dledford@redhat.com>; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> > ; Moni Shoua <monis@mellanox.com>
> > Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
> > 
> > On Wed, Aug 15, 2018 at 11:27:36PM +0000, Howell, Seth wrote:
> > 
> > > Thank you for taking the time to review this issue. The patch you 
> > > submitted will definitely fix the problem I was facing.
> > 
> > Can you test it to be certain?
> > 
> > Thanks,
> > Jason
> 
> We've recently run into this same issue on i40iw, which appears to make the same
> mistake of using the kernel version of the enum instead of the userspace
> version. 

Confused by this?? i40iw_upost_send does not handle the kernel numbers
at all, as far as I can see? How does it develop a kernel dependency??

> What's the current status here? Can it be merged? I just checked and
> do not see it merged to Linux master.

Oh! This apparently got lost, thanks for bringing it up again.

> Running a user-space NVMe-oF target with RDMA and a recent Linux kernel
> initiator is not currently possible on rxe or i40iw because it requires send
> with invalidate support.

Okay, but i40iw doesn't seem to support send with invalidate at all in
userspace?

i40iw_upost_send() swithces on opcode, doesn't handle SEND_INV and
then blows up in the default clause - how does this patch make any
difference???

Jason

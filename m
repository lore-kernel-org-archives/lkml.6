Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF1DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922B12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922B12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeKTFuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:50:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeKTFuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:50:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92D1C305C3B8;
        Mon, 19 Nov 2018 19:25:20 +0000 (UTC)
Received: from redhat.com (ovpn-124-1.rdu2.redhat.com [10.10.124.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1008D84F9;
        Mon, 19 Nov 2018 19:25:14 +0000 (UTC)
Date:   Mon, 19 Nov 2018 14:25:13 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Tim Sell <timothy.sell@unisys.com>, linux-doc@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Zaibo Xu <xuzaibo@huawei.com>, zhangfei.gao@foxmail.com,
        linuxarm@huawei.com, haojian.zhuang@linaro.org,
        Hao Fang <fanghao11@huawei.com>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Doug Ledford <dledford@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        David Kershner <david.kershner@unisys.com>,
        Kenneth Lee <nek.in.cn@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>, guodong.xu@linaro.org,
        linux-netdev <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-crypto@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [RFCv3 PATCH 1/6] uacce: Add documents for WarpDrive/uacce
Message-ID: <20181119192512.GD4593@redhat.com>
References: <20181114160017.GI3759@mtr-leonro.mtl.com>
 <20181115085109.GD157308@Turing-Arch-b>
 <20181115145455.GN3759@mtr-leonro.mtl.com>
 <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b>
 <20181119104801.GF8268@mtr-leonro.mtl.com>
 <20181119164853.GA4593@redhat.com>
 <20181119182752.GA4890@ziepe.ca>
 <20181119184215.GB4593@redhat.com>
 <010001672d69716a-743e5098-eb2f-41ca-bf98-6e17eaaba00f-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010001672d69716a-743e5098-eb2f-41ca-bf98-6e17eaaba00f-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 19 Nov 2018 19:25:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:19:04PM +0000, Christopher Lameter wrote:
> On Mon, 19 Nov 2018, Jerome Glisse wrote:
> 
> > > IIRC this is solved in IB by automatically calling
> > > madvise(MADV_DONTFORK) before creating the MR.
> > >
> > > MADV_DONTFORK
> > >   .. This is useful to prevent copy-on-write semantics from changing the
> > >   physical location of a page if the parent writes to it after a
> > >   fork(2) ..
> >
> > This would work around the issue but this is not transparent ie
> > range marked with DONTFORK no longer behave as expected from the
> > application point of view.
> 
> Why would anyone expect a range registered via MR behave as normal? Device
> I/O is going on into that range. Memory is already special.
> 
> 
> > Also it relies on userspace doing the right thing (which is not
> > something i usualy trust :)).
> 
> This has been established practice for 15 or so years in a couple of use
> cases. Again user space already has to be doing special things in order to
> handle RDMA is that area.

Yes RDMA as an existing historical track record and thus people
should now be aware of its limitation. What i am fighting against
is new addition to kernel that pretend to do SVA (share virtual
address) while their hardware is not realy doing SVA. SVA with
IOMMU and ATS/PASID is fine, SVA in software with device driver
that abide to mmu notifier is fine. Anything else is not.

So i am just worrying about new user and making sure they under-
stand what is happening and not sell to their user something
false.

Cheers,
Jérôme

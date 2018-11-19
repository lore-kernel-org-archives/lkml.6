Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A890C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D918720831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cYDpWsvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D918720831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbeKTFoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:44:05 -0500
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:47942 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbeKTFoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1542655144;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=qRQrNnesmmbz4mj5W8/w3iEhMIgEJfVN23yLPbGC3zE=;
        b=cYDpWsvI69YoDSGXKAboo3pyiuwaZYfIeAc4HkodWYp9TcnP/Y3rbQfWeAJvqe39
        7degP7/ARUn3xks8+OaAKXPDHwfk2KNQSSUrWdm6dgIIqs/24jDmRVM8kb7LgvRBmlk
        RlkhfoamoQQUK6kaRH/5cgmoO3g/FS664p8V070c=
Date:   Mon, 19 Nov 2018 19:19:04 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Jerome Glisse <jglisse@redhat.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
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
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
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
In-Reply-To: <20181119184215.GB4593@redhat.com>
Message-ID: <010001672d69716a-743e5098-eb2f-41ca-bf98-6e17eaaba00f-000000@email.amazonses.com>
References: <20181113002354.GO3695@mtr-leonro.mtl.com> <95310df4-b32c-42f0-c750-3ad5eb89b3dd@gmail.com> <20181114160017.GI3759@mtr-leonro.mtl.com> <20181115085109.GD157308@Turing-Arch-b> <20181115145455.GN3759@mtr-leonro.mtl.com> <20181119091405.GE157308@Turing-Arch-b>
 <20181119091910.GF157308@Turing-Arch-b> <20181119104801.GF8268@mtr-leonro.mtl.com> <20181119164853.GA4593@redhat.com> <20181119182752.GA4890@ziepe.ca> <20181119184215.GB4593@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.11.19-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Jerome Glisse wrote:

> > IIRC this is solved in IB by automatically calling
> > madvise(MADV_DONTFORK) before creating the MR.
> >
> > MADV_DONTFORK
> >   .. This is useful to prevent copy-on-write semantics from changing the
> >   physical location of a page if the parent writes to it after a
> >   fork(2) ..
>
> This would work around the issue but this is not transparent ie
> range marked with DONTFORK no longer behave as expected from the
> application point of view.

Why would anyone expect a range registered via MR behave as normal? Device
I/O is going on into that range. Memory is already special.


> Also it relies on userspace doing the right thing (which is not
> something i usualy trust :)).

This has been established practice for 15 or so years in a couple of use
cases. Again user space already has to be doing special things in order to
handle RDMA is that area.



Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83038C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531DE20861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548237187;
	bh=HF9eJMFJxhcLLoRHjywiWFMXig3DHPntZ6ReryupSo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LICRQLgKc3M3U7MyuG5PXy+IOJIrtH46cjJI9YvvJ9L/lzOXI4O1T885yDHwJpfP/
	 AUu4GaqCFtdIRMa6jI9dZB9UsWV2c5/MTxgg3WeTFHXxuGl+4VILVFl8QtlCWUebQP
	 i/CbhkIhOoqJjagYL5m2bCBOuhBx1rXiadgnSL3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfAWJxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfAWJxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:53:03 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D22220861;
        Wed, 23 Jan 2019 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548237182;
        bh=HF9eJMFJxhcLLoRHjywiWFMXig3DHPntZ6ReryupSo4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AAOQb4aL46H8730kX9v8dQYrlcrWKckmvMVuCxONgxV1uj7voN9aChjhPj3+lsUKS
         c+wSCwluwefmmiIER48K8je53BT9nk+1LXOmQ+YoV6k3eyWxDPyeIuniZ1KKpNS/ts
         B/7H/E0voNVMlPBfZe44gXjjtd+wgPXFklpfEP+g=
Date:   Wed, 23 Jan 2019 10:52:53 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: docg3: Fix passing zero to 'PTR_ERR' warning
 in doc_probe_device
Message-ID: <20190123105253.1f4487f2@bbrezillon>
In-Reply-To: <86533285-e800-5cc0-f495-88fff8326b5a@huawei.com>
References: <20190123065827.16748-1-yuehaibing@huawei.com>
        <20190123101253.243add9d@bbrezillon>
        <86533285-e800-5cc0-f495-88fff8326b5a@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 17:43:58 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> On 2019/1/23 17:12, Boris Brezillon wrote:
> > On Wed, 23 Jan 2019 14:58:27 +0800
> > YueHaibing <yuehaibing@huawei.com> wrote:
> >   
> >> Fix a static code checker warning:
> >> drivers/mtd/devices/docg3.c:1875
> >>  doc_probe_device() warn: passing zero to 'ERR_PTR'
> >>
> >> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/mtd/devices/docg3.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> >> index 4c94fc0..60ddc38 100644
> >> --- a/drivers/mtd/devices/docg3.c
> >> +++ b/drivers/mtd/devices/docg3.c
> >> @@ -1872,7 +1872,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
> >>  nomem2:
> >>  	kfree(docg3);
> >>  nomem1:
> >> -	return ERR_PTR(ret);
> >> +	return ret ? ERR_PTR(ret) : NULL;
> >>  }
> >>    
> > 
> > This is not the right fix, you should instead set ret to -EINVAL:  
> 
> Thanks , will fix it in v2.
> 
> And seems doc_probe_device cannot return NULL. The NULL check of doc_probe_device
> in docg3_probe also can been removed, right?

Hm, looks like the ret = 0 was intentional (to identify when ID is
invalid). Let's just keep your initial patch.

Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55629ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D219621476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbio0bqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D219621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeIPO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 10:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbeIPO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 10:59:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0EF208AE;
        Sun, 16 Sep 2018 09:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537090616;
        bh=1NTm8ULzhEcwxCEAQ9yA2iQO1Nt+iCn3W0OVBJh5IpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jbio0bqiffAMBuxnyVl2Z6LLzZCIA22zIOvXrWgZgJYbPRtcu95oMcLq719GJSdiV
         qJdX1RZCEu7czi2vKBNO3FzH2Rc/3MoT95P5dx9hpqlt54iElqCWtWw5S6ESQRw0eZ
         qPZoEgvaktFoVliPTWNWbdK6noe8H7OpfM4URW7g=
Date:   Sun, 16 Sep 2018 10:36:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to
 of_match_device and of_device_get_match_data
Message-ID: <20180916103657.10cfb5ed@archlinux>
In-Reply-To: <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
References: <20180915105241.22584-1-yuehaibing@huawei.com>
        <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 13:35:06 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-09-15 12:52, YueHaibing wrote:
> > Drop call to of_match_device, which is subsumed by the subsequent
> > call to of_device_get_match_data.  The code becomes simpler, and a
> > temporary variable can be dropped.
> > 
> > Found by coccinelle.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>  
> 
> Acked-by: Peter Rosin <peda@axentia.se>
Similar change already in place from Julia Lawall back in May but
looks like that just missed the last set for the merge window
after I managed to loose it and only picked up again when Peter
pointed it out in August.

However, something odd is going on as these are not currently in
next.

Ah, looks line staging-next was updated 2 days ago and last linux-next
is just before that.  So I'm afraid you hit some very unfortunate
timing or this would have been there when you were looking.

Thanks,

Jonathan

> 
> Cheers,
> Peter


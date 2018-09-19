Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58732ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D382150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2RAWDwGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D382150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbeITDMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731811AbeITDMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:12:17 -0400
Received: from X250 (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987DD20877;
        Wed, 19 Sep 2018 21:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537392747;
        bh=hJASQyj7vyKWYGbWklCOqMCsiIyGR6tMbuzlB1AR/qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2RAWDwGbmThNRDGSHel1OmrBnz+tazNVtjc/8LJxm6Kd5s3Kp8FcwFLeorCJmPxPe
         VAEbFHx5Jz2oog353Gv2a7EoMVnQIU0Uk0kC3MLIIgIgffSgP2e+yxZRv2dmbo8mpS
         wDSP6ZgLsSTpEqJAvR6okdjC+aw0QdU8Qr4x9uyM=
Date:   Wed, 19 Sep 2018 14:32:25 -0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     zhong jiang <zhongjiang@huawei.com>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: do not double put device node in zx_drm_probe
Message-ID: <20180919213224.GA16678@X250>
References: <1534472646-10368-1-git-send-email-zhongjiang@huawei.com>
 <20180827071824.GG3850@dragon>
 <CAKMK7uFVVKgZy3tVsG4f-TFbaYZYxBHrcS0FgCVZOU7M9mq_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFVVKgZy3tVsG4f-TFbaYZYxBHrcS0FgCVZOU7M9mq_pg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:19:09PM +0200, Daniel Vetter wrote:
> On Mon, Aug 27, 2018 at 9:18 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> > On Fri, Aug 17, 2018 at 10:24:06AM +0800, zhong jiang wrote:
> >> for_each_available_child_of_node will get and put the node properly,
> >> the following of_node_put will lead to the double put. So just
> >> remove it.
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Shawn, I'm assuming you'll push this to drm-misc-next? You're the
> maintainer with commit rights after all.

Just pushed to drm-misc-next.  Sorry for the delay.

Shawn

Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8334C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC830214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw9vmUtN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC830214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeKLFSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:18:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeKLFSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:18:24 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FF1214DB;
        Sun, 11 Nov 2018 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541964541;
        bh=G9pDL2aLnv1gMScONo+2gNK3O2jCamH4fnZlxKgReBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sw9vmUtNT53MuqNR2DYgQLELty8+e2Cij8YENo1v+WJz2yhQR1g6QZxIR6yc0K4WO
         z/I09CClH7I9D3zgEnD+vT1cby0vQD94q15fieJgsgSEzerGdJ3c5fAdApk/tgw2dY
         2M50LYROQcA3lENqLiDq52FnO9z8jXV3gI4tor2E=
Date:   Sun, 11 Nov 2018 11:29:01 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>
Subject: Re: [PATCH V2] cacheinfo: Keep the old value if of_property_read_u32
 fails
Message-ID: <20181111192901.GA8332@kroah.com>
References: <1539955889-9968-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539955889-9968-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:31:29PM +0800, Huacai Chen wrote:
> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> property_read_u32 instead of get_property,read_number") makes cache
> size and number_of_sets be 0 if DT doesn't provide there values. I
> think this is unreasonable so make them keep the old values, which is
> the same as old kernels.
> 
> Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/cacheinfo.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

What changed from v1?  Always put that below the --- line.

Please fix this up and resend a v3.

thanks,

greg k-h

Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A016C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDABB21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548161516;
	bh=WNzRiRpLCAs94iE/Ig16FXpeDECydSfGTxbHfT7WH6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ewi41GjLHT0u4bZD/QhCxnodVt0t2gBLw9kn0/m1Uu+7KOoUF5v2LBfW/8UgJvORs
	 FpbEP/fHSvp7ZXNp7+PsRFctwcu1BR+3PfeUhjcx3eT0wGy9dUnnb5Zvk4a1DPapPI
	 2jf3uALh5+00i4FyPCGlKeHI750DewiEcK67JTD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfAVMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfAVMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:51:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2DE20855;
        Tue, 22 Jan 2019 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548161513;
        bh=WNzRiRpLCAs94iE/Ig16FXpeDECydSfGTxbHfT7WH6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUlnXdHg4AGkrYdAM4q89FI51NEYtEAQF6iezH5jhzR3JMVgl9Q3yjfKcgPy+tYaA
         hYWNo2Nr14aqAcftaygXq1fQ9VXzxbEiTYH+73iEPR7nbf7bFQnmXSc4f8vGdnnC7q
         bbziiuYibRFrQXbEpi3LzoAo8RR/arfxOZi88BsM=
Date:   Tue, 22 Jan 2019 13:51:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V3] cacheinfo: Keep the old value if of_property_read_u32
 fails
Message-ID: <20190122125150.GA15913@kroah.com>
References: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545207363-7402-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 04:16:03PM +0800, Huacai Chen wrote:
> Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> property_read_u32 instead of get_property,read_number") makes cache
> size and number_of_sets be 0 if DT doesn't provide there values. I
> think this is unreasonable so make them keep the old values, which is
> the same as old kernels.
> 
> Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
> V2: Add Cc and Reviewed-by
> V3: Add ChangeLog

Sorry for the delay, now queued up.

greg k-h

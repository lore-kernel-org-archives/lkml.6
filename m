Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E512146D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544184250;
	bh=4crPoX0+sOS1/pd25WHPi/c6Th6ra8iqRQPjQvyz+ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dGE0NrjO7SDHP2zwsG39BTZYYH0UxYzU6SSGR4bHFV3f2IbE4gmUbuB44o0XSHQfG
	 WrBykQspeFc21vHamhTaODtmA7WYDB3DHBe1YjCcQTpdBSRvm5wvVZd0GM1Q7sD4uB
	 xh+8Rl9lTwnA25qX9sKXei4xGpkkHCzItAeSjg8o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E512146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeLGMEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeLGMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:04:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E6520868;
        Fri,  7 Dec 2018 12:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544184248;
        bh=4crPoX0+sOS1/pd25WHPi/c6Th6ra8iqRQPjQvyz+ao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xZp7WelIcIXlhel4jfZ5ojxgWXny70w0uzsf6V9bRQbZfVLFsLRhuL9hmO2f26Sr4
         5VuCz6LtAZhzi8h1BTW+W530XA2RcQRUA4AXKgMVXKxwvARwR3t4FFckqezzsFmhwt
         D6Gqdzhexf5VOBl4TLWmXWdKhUykCpt2ZqtPzlFA=
Date:   Fri, 7 Dec 2018 13:04:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, joe@perches.com,
        yuzibode@126.com
Subject: Re: [PATCH v3 2/2] kobject: drop newline from msg string
Message-ID: <20181207120405.GC15336@kroah.com>
References: <cover.1544175417.git.tsu.yubo@gmail.com>
 <f03d23a34df36d55274c5cce7d4081d9017668c1.1544175417.git.tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f03d23a34df36d55274c5cce7d4081d9017668c1.1544175417.git.tsu.yubo@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 05:21:49AM -0500, Bo YU wrote:
> There is currently a missing terminating newline in non-switch case
> match, when msg == NULL.
> 
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
> Changes in v3:
> Improve the commit log,requested by rafael.
> 
> Changes in v2:
> According to Joe's suggestion,drop newline from msg
> 
>  lib/kobject_uevent.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index b7c088c902a2..1837765ebf01 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>  	enum kobject_action action;
>  	const char *action_args;
>  	struct kobj_uevent_env *env;
> -	const char *msg = NULL, *devpath;
> +	const char *msg = NULL;

Why did you move the devpath variable from here to lower down?  That
really doesn't do anything :(

thanks,

greg k-h

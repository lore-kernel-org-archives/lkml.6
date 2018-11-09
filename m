Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4BC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F7920883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbH8p3uD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F7920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeKIUwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:52:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbeKIUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:52:34 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1108A20827;
        Fri,  9 Nov 2018 11:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541761946;
        bh=4FKFgeXgL0Ty6W9E+h1lyh8Pf3JRN80uoPclbfIrYOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbH8p3uDWb9GQ0X3xScHuIe6N2VlraGoZCQVo4rps4NG1i8LvimD/MCqu2ycYD0Xf
         my4bavSL0N8VJWWjY8IHFybUTnZByonhmpwW4JGxBFOzl/6PB4LfaBg02u+12NBC84
         F2U1tJWt99WPfE/skFs2nzJ7c5vxCGzgueu3mUYU=
Date:   Fri, 9 Nov 2018 03:12:25 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     wang.yi59@zte.com.cn, matz@suse.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181109111225.GA26335@kroah.com>
References: <20181108172225.GH7543@zn.tnic>
 <201811090843126464658@zte.com.cn>
 <20181109105538.GA21243@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109105538.GA21243@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:55:38AM +0100, Borislav Petkov wrote:
> On Fri, Nov 09, 2018 at 08:43:12AM +0800, wang.yi59@zte.com.cn wrote:
> > Yeah, so that is. However, I suppose we should not enable this by default
> > before we fix ALL of these warning,
> 
> Yeah, the build is really noisy now.
> 
> > which is really a  hard work. :)
> 
> Yeah, I wonder if adding this to a kernel janitors TODO list or somesuch
> would help speeding up the process.
> 
> Maybe Greg knows.
> 
> Greg, the question is whether we can get people to help out with
> 
>   -Wmissing-prototypes
> 
> fixes around the tree. Currently, there are ~1400 warnings and we want
> to have 0 and then add that option to the main Makefile.
> 
> It is very easy to do: you simply build the kernel with W=1, choose one
> -Wmissing-prototypes warning and fix it by adding a function prototype
> or declaring the function static.
> 
> It should be a pretty easy for newbies to get involved...

Sure, sounds like a good task.  Post it to the driverdevel mailing list
and see if people are interested.

thanks,

greg k-h

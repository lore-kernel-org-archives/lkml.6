Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1111E20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550762808;
	bh=rbobMsho1M+WxwTDgzg1WY+CgaW0QD7P0xeN+rTdyj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wDTRzSQQ9XxltSiMMjU3pWkAon5dpEHigibPDN/ZqUl5sKYE0iSainZOGZWUIurEH
	 ZhcTBxIOAGh0XsIQEejH+iysJFXw1AbBQ2LmUplTh3NP5VTzgv7V6cVdSzq+FRY7FK
	 EYQf1ShQmyj8P8AIM5YTpywFC5XncZo1/VSlYOnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfBUP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfBUP0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C0F2083E;
        Thu, 21 Feb 2019 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550762805;
        bh=rbobMsho1M+WxwTDgzg1WY+CgaW0QD7P0xeN+rTdyj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0HoPwHDfpvkUWbYQEJppqOqijR68xvEf0qJmhm/F60qfkY49jkwfGgeqtSzOM4iu
         gw/jyni4kdf3myn4vukTbkGKxDUoPLHftrUj7tI1t+Cqf/OHrq+AFFBKWppctmSFFW
         5ZyI5/AlppSpodLAYl+sWUhi4y2qshkObpZetRJM=
Date:   Thu, 21 Feb 2019 16:26:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 23/30] x86_64: increase stack size for KASAN_EXTRA
Message-ID: <20190221152642.GA23121@kroah.com>
References: <20190221125250.543158526@linuxfoundation.org>
 <20190221125251.864751477@linuxfoundation.org>
 <953de00c-82df-3ac2-8dd7-a023c511cbb9@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953de00c-82df-3ac2-8dd7-a023c511cbb9@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:00:06PM +0300, Andrey Ryabinin wrote:
> On 2/21/19 5:36 PM, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> 
> Drop it please. It increases kernel stack up to 4-order which is above PAGE_ALLOC_COSTLY_ORDER.
> This changes behavior of the fork() by making it fail with -ENOMEM due of high memory fragmentation.
> 
> The patch that removes KASAN_EXTRA (not in Linus's tree yet) would be a better fix for the problem.

Ok, should this also be dropped from 4.20.y?

thanks,

greg k-h

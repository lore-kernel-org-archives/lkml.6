Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CE620657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547654577;
	bh=L7UfAr36fAaMgzpTcyBzFg6DZjC1dxtV1jAtGZnUAPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rSShYUofJOj5Ktu8r5jQsOAeGtXubfwkhI5EqbPstnBgZNjy5xELVmFZ4CdokBVTm
	 dnhxcghEYlRdevMhpsa/IVtD2okSQh4GJRZ+yExzeKSa3gTCQZ1hVGVk5flvQ4ZmEQ
	 f/b+G9UX5Cz65omLQXegqhF2J8gFv+yKZpr8mvCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404959AbfAPQCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:02:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfAPQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:02:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51DB205C9;
        Wed, 16 Jan 2019 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547654574;
        bh=L7UfAr36fAaMgzpTcyBzFg6DZjC1dxtV1jAtGZnUAPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgmaGAltPk+gpeak4IY3W7gvyOtkOpCRG3MvknKx2msYq4R3o2w9v1f6p4lcIJ9tA
         XgXPWR3HU3evsmAfUmyZB3vecqImE++mCVcXbmKcEWd5DjhZTrYxs4gm0V2PbC/9Is
         Tn2BUN+7tir3DVGbWf0nAlxU/TrIrJZP/Dk7vqr4=
Date:   Wed, 16 Jan 2019 17:02:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
Message-ID: <20190116160252.GB4594@kroah.com>
References: <20190115154901.189747728@linuxfoundation.org>
 <794339d5-a1f8-7ae1-8c8c-fbef141cc81d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794339d5-a1f8-7ae1-8c8c-fbef141cc81d@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 09:25:12AM +0000, Jon Hunter wrote:
> 
> On 15/01/2019 16:35, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.94 release.
> > There are 27 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.14:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.14.94-rc1-gec31b1a
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing two of these.

How about 4.19 and 4.20?  Does modern kernels work on this hardware as
well?  :)

thanks,

greg k-h

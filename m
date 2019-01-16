Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A22C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE03206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547660840;
	bh=IQIMnH4oYxDXtwZb8TtPv+OtRJPQTXhkEjyFtvZiPKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SI3hhc8JM+yVKTbH2V5DsAaShnyxFwNf0o5UtuJxyLOiezmiAU3YYV1J+u2ZC8/dH
	 du17OdvV41cNXdBjSQNvMnZewfXNCGaxFqJkwuvZkXmGA2fVMjVcU0iujj0o+NqnXo
	 dzXEQLYK/TUWCrp5KznYRnLYNidCpuLsUERCldY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfAPRrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:47:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfAPRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:47:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FC820657;
        Wed, 16 Jan 2019 17:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547660837;
        bh=IQIMnH4oYxDXtwZb8TtPv+OtRJPQTXhkEjyFtvZiPKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1DALQGPE4Zr3NMXuzZ36s9x1HIneUZgDWv8whqVIbsGOVPdDvfrdU6PSucN0Fydp
         /wGnPI1uj9v1Qwd9kFKD3YS0lZ4dMrq9l7wHY0qS5/kfh4ZngMx7NaXlmQxeyf3wTv
         PBD8MHbe+Pc0AkcirtLY33v2KGPeOKdJ4+2mQUro=
Date:   Wed, 16 Jan 2019 18:47:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/27] 4.14.94-stable review
Message-ID: <20190116174714.GA13163@kroah.com>
References: <20190115154901.189747728@linuxfoundation.org>
 <794339d5-a1f8-7ae1-8c8c-fbef141cc81d@nvidia.com>
 <20190116160252.GB4594@kroah.com>
 <26826b67-6a6b-dc79-84de-4ce48212203e@nvidia.com>
 <20190116171153.GA10164@kroah.com>
 <f2e8bd8a-90f1-c7a8-1157-36e9c19eb384@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e8bd8a-90f1-c7a8-1157-36e9c19eb384@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:38:34PM +0000, Jon Hunter wrote:
> 
> On 16/01/2019 17:11, Greg Kroah-Hartman wrote:
> > On Wed, Jan 16, 2019 at 04:56:08PM +0000, Jon Hunter wrote:
> >>
> >> On 16/01/2019 16:02, Greg Kroah-Hartman wrote:
> >>> On Wed, Jan 16, 2019 at 09:25:12AM +0000, Jon Hunter wrote:
> >>>>
> >>>> On 15/01/2019 16:35, Greg Kroah-Hartman wrote:
> >>>>> This is the start of the stable review cycle for the 4.14.94 release.
> >>>>> There are 27 patches in this series, all will be posted as a response
> >>>>> to this one.  If anyone has any issues with these being applied, please
> >>>>> let me know.
> >>>>>
> >>>>> Responses should be made by Thu Jan 17 15:48:28 UTC 2019.
> >>>>> Anything received after that time might be too late.
> >>>>>
> >>>>> The whole patch series can be found in one patch at:
> >>>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.94-rc1.gz
> >>>>> or in the git tree and branch at:
> >>>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> >>>>> and the diffstat can be found below.
> >>>>>
> >>>>> thanks,
> >>>>>
> >>>>> greg k-h
> >>>> All tests are passing for Tegra ...
> >>>>
> >>>> Test results for stable-v4.14:
> >>>>     8 builds:	8 pass, 0 fail
> >>>>     16 boots:	16 pass, 0 fail
> >>>>     14 tests:	14 pass, 0 fail
> >>>>
> >>>> Linux version:	4.14.94-rc1-gec31b1a
> >>>> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
> >>>>                 tegra210-p2371-2180, tegra30-cardhu-a04
> >>>
> >>> Thanks for testing two of these.
> >>>
> >>> How about 4.19 and 4.20?  Does modern kernels work on this hardware as
> >>> well?  :)
> >>
> >> We are not that advanced yet ;-)
> > 
> > So not everything for those platforms is upstream?  :(
> 
> No sorry! I really was joking. We have enough upstream to test all these
> platforms (plus a couple more) today :-)
> 
> >> Only joking, absolutely and in fact we have more devices/boards
> >> supported in newer kernels so it would make sense. We are also testing
> >> mainline and -next.
> >>
> >> Unfortunately, it is a bit of a process to add new branches at the
> >> moment simply because we are piggy backing on existing infrastructure
> >> for testing that I personally do not own and so it needs to be approved.
> >> However, nonetheless it is doable.
> >>
> >> We were talking about adding v4.19 and then v4.20 popped up. I am not
> >> sure if you have any ideas yet about the EOL for v4.20? I was just
> >> wondering if we should prioritise v4.20 now over v4.19?
> > 
> > I was just curious, if everything was upstream (like the boards that
> > linaro tests for), then running 4.19 should be just the same as 4.20.
> > But if you have big out-of-tree patchsets, that's a totally different
> > story.
> 
> Yes testing stable-v4.19/v4.20 is straight forward and will work today.
> I just need to go through the process of setting it up and requesting
> this. However, while you were asking, I was curious if you had any idea
> of the projected EOL for stable-v4.20 yet?

Sorry, the EOL for 4.20 will be once 5.0 is out, usually around the
5.0.3 timeframe or such, like any other "normal" stable kernel
lifecycle.

thanks,

greg k-h

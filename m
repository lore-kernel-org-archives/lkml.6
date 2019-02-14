Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56960C10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257BE222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550139117;
	bh=dQM2EUU9TcrKOJQXxFL1yuMTdUbHlfrcqxdNCPdzGyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r1BWU5Ln4NPBOOwtuQ8RcnQZD84qCHAmipLwkZqa9PZeaozGisWb9TtjN/sgAqbZa
	 GVdPjzozN5vVyGPl0JaGEKwViiMJgLFIK8rQozZQNd8/9ClS4k8Yzeqs9PYWoW/CdU
	 nMSPr3rSzp3Tkbjvef5FAwhVIHzrX4+JNR2kboiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406425AbfBNKLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfBNKLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:11:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14422222D5;
        Thu, 14 Feb 2019 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550139114;
        bh=dQM2EUU9TcrKOJQXxFL1yuMTdUbHlfrcqxdNCPdzGyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzAw27X3kADMM+FdqMaQYp3dx07gmDPIEotY4iwKNHa4OZ5Q6A6YelwfpPtXP+Jq/
         TVaz20rKzP7qTuUryG339K0d9x7EfQoycg6bliwPrTKqHC+bsG6hT/gN3z4U8BcZ6a
         d7XsLPVzjhVh42noACK8HpO7G6G51BDzI82kbtyw=
Date:   Thu, 14 Feb 2019 11:11:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/35] 4.14.100-stable review
Message-ID: <20190214101152.GA4476@kroah.com>
References: <20190213183706.176685027@linuxfoundation.org>
 <182ff2cd-e6dc-8bc5-14fd-2b1bc9f85ae7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182ff2cd-e6dc-8bc5-14fd-2b1bc9f85ae7@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:06:08AM +0000, Jon Hunter wrote:
> 
> On 13/02/2019 18:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.100 release.
> > There are 35 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Feb 15 18:36:47 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.100-rc1.gz
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
> Linux version:	4.14.100-rc1-g3a58a4d
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Wonderful, thanks for testing both of these and letting me know.

greg k-h

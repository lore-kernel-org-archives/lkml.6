Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4EA222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996771;
	bh=e2I+X/qfkHIkO6SHECsuOvIC/NkB5mW1Nt1Bxta7v+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TtkFKsLTBMfffDF1HP0ht8p+/p0Qf1MF4eX5k/c2OFaTBtQ3YoDXpk1zMOll1sn7o
	 Lv1v6HLSQ17A6IPIV0732ZwjLUb8iyP2Y4oQKBcOyeuIDN+rXP6xODMXKTvUzlMEfL
	 KYl710Yy//LEbgVMaj6aL8/uKSZX2qJgFl5LgQeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfBLSja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:39:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7AF2190B;
        Tue, 12 Feb 2019 18:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996768;
        bh=e2I+X/qfkHIkO6SHECsuOvIC/NkB5mW1Nt1Bxta7v+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rws4lYI4wfWONyB4D/6uJ5TKowCP3p9LbhT6SEQrWN0KtbUu74bKAlOxgorDYkuro
         N1epJmSC1Ebo4NBZmmYaCc/4aLby0x55RFLTvVXyKlXhZdDRYF93CKaD2BthkJZ421
         cCbk5rwxx/NLqZF/zB74CVJEjVwRwwIVmUdo6fr0=
Date:   Tue, 12 Feb 2019 19:39:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/205] 4.14.99-stable review
Message-ID: <20190212183926.GE14892@kroah.com>
References: <20190211141827.214852402@linuxfoundation.org>
 <d91e568f-643c-1226-2592-6e24baadb01a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91e568f-643c-1226-2592-6e24baadb01a@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:19:57AM +0000, Jon Hunter wrote:
> 
> On 11/02/2019 14:16, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.99 release.
> > There are 205 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 13 14:17:19 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.99-rc1.gz
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
> Linux version:	4.14.99-rc1-g151d638
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing 2 of these.

> BTW, I did not seem to receive a 'stable review' for v4.4.175-rc1. I am
> not sure if it is just me, but that last one I see in the archive for
> v4.4 [0] is v4.4-174-rc1.

No, I didn't do a "real" 4.4-rc just yet, I wanted to get these 4
kernels out first.

thanks,

greg k-h

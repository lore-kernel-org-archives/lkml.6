Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF30C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD41217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550580463;
	bh=igN7hy51XV7A6Awn4HE1l/f+f1lfb2cPtmRhe3NWOZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wUjKyebgovqkcbjFXogFkU0sG78JW40KAA+yRZ23pdNk0eXAFT80bE7oEEviKj4KU
	 xrAH3wpWB6xRvvJ3oTtJuHhyxO198Hi6EROn6TiYFcTcMX7h0kFIT7XS/L6wS/TC3c
	 FxCm0QBl9v0xmEdvM4QkfkeuwoT6U9G0/Z7Ku7+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfBSMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfBSMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BACF02146E;
        Tue, 19 Feb 2019 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550580459;
        bh=igN7hy51XV7A6Awn4HE1l/f+f1lfb2cPtmRhe3NWOZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAZscM7bM2Cch7OrAeRXdKV08pOBbWuYErfntYj79ga1owfYsY4R8fsD1hNBx08Yr
         fkKvS49654ntHIYbR2ZGyY+dvosLXXu0CfbUjXv8ekgQPq86I0u3hzdkGWfhiFSVma
         /HC4G7Ayp6jVc4MAsrEKZ154qwDMXe+z0zQgYbSk=
Date:   Tue, 19 Feb 2019 13:47:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/62] 4.14.102-stable review
Message-ID: <20190219124735.GB16246@kroah.com>
References: <20190218133505.801423074@linuxfoundation.org>
 <fd971c7a-3ac1-b44e-03c0-993888cad053@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd971c7a-3ac1-b44e-03c0-993888cad053@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 09:32:25AM +0000, Jon Hunter wrote:
> 
> On 18/02/2019 13:43, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.102 release.
> > There are 62 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 20 13:34:36 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.102-rc1.gz
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
> Linux version:	4.14.102-rc1-gfea4e6b
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing 3 of these and letting me know.

greg k-h

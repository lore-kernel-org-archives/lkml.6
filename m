Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F11C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4C92077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550823874;
	bh=CW9VBY9LWWF2VkmLlFgbqf0romTLRKAwv9I+DBs4oqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kR6Bs33OYekm5SWwyF0zeZexj1VEGctzs44W6FbXkIMZgVtlLLoKA+h2lXWPKB7CN
	 kxQgXK436f3H4M6rQfKMFU8zqBqoWMtPSnVO3JBwxFK/34wo6rb1+mHEk0Fee34Cs7
	 oKK2wvGLa0qtXYmmxo1V2NGZRsxDs8ZnseOI2iTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBVIYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:24:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVIYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:24:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B0E920700;
        Fri, 22 Feb 2019 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550823871;
        bh=CW9VBY9LWWF2VkmLlFgbqf0romTLRKAwv9I+DBs4oqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bIR0iBX2w58NV1JIWnhaSsnjXoBVycWiqAVD7lIZwqTNL6QFIRr3FJIMwRH+UrsmQ
         rS6zi8GXeqHi2nW+b1xxB8HL3fidcu04u8SGHDMqhuEaaeIm2pUbW4/ZorP9C3npKp
         x6sT0AGDWSHjD6CLS2oRoODBl+Fp/pge2tcwnhXU=
Date:   Fri, 22 Feb 2019 09:24:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/30] 4.19.25-stable review
Message-ID: <20190222082428.GA6632@kroah.com>
References: <20190221125250.543158526@linuxfoundation.org>
 <bf719e14-29f8-d984-f559-13b8366c56ba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf719e14-29f8-d984-f559-13b8366c56ba@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:14:05AM +0000, Jon Hunter wrote:
> 
> On 21/02/2019 14:35, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.25 release.
> > There are 30 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 23 12:52:29 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.25-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.19:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     22 tests:	22 pass, 0 fail
> 
> Linux version:	4.19.25-rc1-g38e5064
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Great!  Thanks for testing these and letting me know.

greg k-h

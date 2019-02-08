Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C018EC282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8679C21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549621733;
	bh=yH8stMyJkig1aoJZrZXuwOreRfMtr/tkABpkm3zk98A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HYSpXzl1cqKhsYApw2oVvWSc6yXNq4Fb1ME4gMZB+aWVPkbajIny93jDRzTkLCyWp
	 WTmP0oj8pvJalS35G4vGpIVEOit7gFo0hXqY7FQ0zOtWzglXJIBlAny8Kwb/x6IIzF
	 zGoatJAB1uB6lqISXzfmtUQ4DNc93fq8vEyRIbXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfBHK2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfBHK2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:28:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702D520823;
        Fri,  8 Feb 2019 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549621730;
        bh=yH8stMyJkig1aoJZrZXuwOreRfMtr/tkABpkm3zk98A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUk+4nsvkraj1Eyp8rzccfDNR7uXRu2PX1MOv01W4cZ6U1tuKmCZVL/3iWrR8WOu5
         4pHOihMeRDhZ42awCvlxRj8NwFzMvqTStbMx9voTgIKq+WPav/7eKRsWL8oP/osblW
         rUf1u6y4ZTlpiRil9aPHewdDzZCiGjS+SvcOjWQY=
Date:   Fri, 8 Feb 2019 11:28:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.4 00/34] 4.4.174-stable review
Message-ID: <20190208102848.GA10341@kroah.com>
References: <20190207113025.552605181@linuxfoundation.org>
 <21d81a53-adfd-9d87-17ea-4b7e78b167f3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d81a53-adfd-9d87-17ea-4b7e78b167f3@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:03:33AM +0000, Jon Hunter wrote:
> 
> On 07/02/2019 11:41, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.174 release.
> > There are 34 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb  9 11:30:10 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.174-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.4:
>     6 builds:	6 pass, 0 fail
>     12 boots:	12 pass, 0 fail
>     10 tests:	10 pass, 0 fail
> 
> Linux version:	4.4.174-rc1-g968fa3b
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra30-cardhu-a04
> 

Great, thanks for testing and letting me know.

greg k-h

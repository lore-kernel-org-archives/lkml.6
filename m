Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD0C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F4E217FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549377780;
	bh=RkKrE+qS6IoOdK/6a01Tgvp+LjAO9+UEZB91NMkI9IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1/Mz7EXtwRM1qZSqJ7lZxyC/YAIHODa4j11VWmV8YlaqsOUqX9GEXToED7Zz8t5OH
	 jHJOvTBKeyTobGrLfYTbgUR8dvYlat43nKGTzTc+mYnlP4/zf3ZBjxogslvurv/b/0
	 GurbUFTpCMPH+JTTi4EKZpeUA86XQNd0mb04LiJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfBEOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBEOm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:42:58 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C552080F;
        Tue,  5 Feb 2019 14:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549377777;
        bh=RkKrE+qS6IoOdK/6a01Tgvp+LjAO9+UEZB91NMkI9IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1iL4EUEcIvOylWqXxNZZYzCsnszVhvmufhTdLP3xmwBzmd0YdaLNH1oAKnRUsNzr
         83+DkQCZXCfEXFlmFQvzm7J10YMPt4teZqE1JR8uv6BgSMJqCWKZz/w0iCQwFZ43VN
         3W6iCTa/J6b/+l/ogLv4Q8M8xrkApdKzVHXe0J0Q=
Date:   Tue, 5 Feb 2019 15:42:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/46] 4.14.98-stable review
Message-ID: <20190205144254.GC17950@kroah.com>
References: <20190204103608.651205056@linuxfoundation.org>
 <40f772ce-5b57-8ee0-5fc4-5cfab53ca06d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f772ce-5b57-8ee0-5fc4-5cfab53ca06d@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 10:20:50AM +0000, Jon Hunter wrote:
> 
> On 04/02/2019 10:36, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.98 release.
> > There are 46 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb  6 10:35:31 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.98-rc1.gz
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
> Linux version:	4.14.98-rc1-g0576694
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing 3 of these and letting me know.

greg k-h

Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF666217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551186542;
	bh=UMbk4W7RueqBuxaEnQSaher/AI2OjN40p4jL4etZiM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TxDrSjlo0brw+GcVmsuTV/1YBXDAC/ipiSfHw2Q1PHWbYbH/a08szgzIaBo3/EJf5
	 3iQuVs5ES8aUjCaUn9DPMlP2otuDjlpiHHItem0gEPMLCo/Nw70IND+UkZLfnOWHY8
	 4/OdZzeXsTb3H/pgZd/d96BuC9mDLOXA06N9CQWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfBZNJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZNJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:09:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30A8220651;
        Tue, 26 Feb 2019 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551186539;
        bh=UMbk4W7RueqBuxaEnQSaher/AI2OjN40p4jL4etZiM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+v2vKVdJudMJ9nuxV95Jw2K5KSSZsJSVwgVh6QZx1HAJ/KAm20SPoujUAMkS+HeF
         9TdeUHW4iWwN47vP+jQZ/YbS+y5sgt5RsJtj06g35MvPnm+pHug8O0/jgD8Ju/YN7J
         kOtDrfJalm4+dvfT8ziXXMkj/pdZ5yqJrCDy253I=
Date:   Tue, 26 Feb 2019 14:08:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190226130857.GB10343@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <1619e5d9-a8a2-ca2a-1550-b77062891530@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619e5d9-a8a2-ca2a-1550-b77062891530@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:27:30PM +0000, Jon Hunter wrote:
> 
> On 25/02/2019 21:09, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.13 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.20:
>     11 builds:	11 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     22 tests:	22 pass, 0 fail
> 
> Linux version:	4.20.13-rc1-g6d10f1d
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Nice to see a new branch working for you :)

Thanks for testing all of these and letting me know.

greg k-h

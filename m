Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186E72190C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545386428;
	bh=zsRD0zLUsnXvaXB6gSjnEdSgiSguCylx6EZ7F4LGtz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zUEdJbKDPAGVwjunL75Wasbm6FRPXGnolVVutKzKbLDdhSzMoWONeULcDDnaDm/qK
	 C51ZtsEAeQb+J7ehKyOQrYiZrCHloRbPPE+vGL9igIKsWimooEEHE0IUPmnsjHkCCL
	 NrRKdhEiWwaTY5wSUBcV9X34YPqsOtrIDb4gfsWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbeLUKA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389218AbeLUKAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:00:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F1121908;
        Fri, 21 Dec 2018 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545386424;
        bh=zsRD0zLUsnXvaXB6gSjnEdSgiSguCylx6EZ7F4LGtz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLVuvYtm1pnIn8uppDET9fqI1Ti5IGXaL/f3tW8GQGdHYJIao6iKhsa8/CL9cBtjc
         GsR8cZLXRUX+UAOhnu3n36wuvPDKd0t10bAl19inHRmXLvJ27eH4aUoqcYKciKeSwO
         lwyK8xyQ2bWrxYFwB2pUkmeIMCBLTn/ADHcQoak8=
Date:   Fri, 21 Dec 2018 11:00:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/72] 4.14.90-stable review
Message-ID: <20181221100021.GB24805@kroah.com>
References: <20181220085922.332225035@linuxfoundation.org>
 <bb824156-2a6c-ab70-a685-ce7ac2ff63e5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb824156-2a6c-ab70-a685-ce7ac2ff63e5@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:27:07AM +0000, Jon Hunter wrote:
> 
> On 20/12/2018 09:17, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.90 release.
> > There are 72 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec 22 08:59:06 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.90-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests passing for Tegra ...
> 
> Test results for stable-v4.14:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.14.90-rc1-gdafc7cb
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Great, thanks for testing these and letting me know.

greg k-h

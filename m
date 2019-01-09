Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9983C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A04320859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547044832;
	bh=mfPS87K8PM+aB5wMGdNAgVcq/l0BTHbyrIYJeTndueU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufJpqV4IJ+x/jdrMR0CgdPeOL77vqGCNFCMJjkpWh1AMMx03j49CoGVR7KQuPZ5/h
	 zzYYJRr54SpCAx8moGz7X7JLWTpp8VC1vq7RLyW2rW1tX+h41R+nKdWZELvz//rbQO
	 KXOA5lI/LGGxUTV8IM8qf/vVY//Y8UyhjmDavW2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfAIOkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:40:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730605AbfAIOk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:40:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A994206BA;
        Wed,  9 Jan 2019 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547044828;
        bh=mfPS87K8PM+aB5wMGdNAgVcq/l0BTHbyrIYJeTndueU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1SFdmKR6/5HA830iLJRoiD7ArOivCB4Po1OjnGblUCB5qGrNrSrSAOJo49aBOQOT
         fK5J+0cmeTXUUP/SHKRsBpzHvOYfzRqyUQzjPnuFSgYFYAiB/XW0TG0167QxeBvAzK
         wLGR4b39hwzUQZlJwZrqHRzTKMkbyPLoIL4qqyeU=
Date:   Wed, 9 Jan 2019 15:40:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
Message-ID: <20190109144026.GE29274@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190108121905.GC3884@kroah.com>
 <c146718b-5fbc-aff5-9236-54037234bf88@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c146718b-5fbc-aff5-9236-54037234bf88@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:47:44AM +0000, Jon Hunter wrote:
> 
> On 08/01/2019 12:19, Greg Kroah-Hartman wrote:
> > On Mon, Jan 07, 2019 at 01:31:48PM +0100, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.14.92 release.
> >> There are 101 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Wed Jan  9 10:53:00 UTC 2019.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc1.gz
> > 
> > -rc3 is out to hopefully fix the last reported build issue:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.92-rc3.gz
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.14:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.14.92-rc3-gd679908
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing these and letting me know.

greg k-h

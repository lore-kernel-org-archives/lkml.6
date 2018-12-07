Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33751C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC176208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544193690;
	bh=vU0yN2+4IgaLTbxA7jRrntIVRr2zOiPZAxGE2epUXIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kHt+y3RwBKTuKf13oKHPKQBeOkZMtc0F/LBjtPv2KFkOa3JYLfWCmfHlXOytM1DUV
	 HMTas1s/3vceTmb55f8oqHXya3jeMWP6RpVTYd0mMVXcqHYvgQCUf9V1VYE+bdYTRh
	 NzpYVXg3TLKoU+KMFhlLYg0DxJJ61vA8l2lOGWiE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC176208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeLGOl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeLGOl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:41:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A10F20838;
        Fri,  7 Dec 2018 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544193687;
        bh=vU0yN2+4IgaLTbxA7jRrntIVRr2zOiPZAxGE2epUXIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SAx44n7DScTM+vdlWJk1rBNuN/rojfYl6hccRZ8e8nzkSGf+5UZCpXIVekGPITDR+
         /Zv79dce1x9k3sFw36CEu2gKQpqg2V3W87vWvXOIA9ReuiP3czXLPy9V17Xo+uOMNz
         FZjgttWTdVySvGBeJPavOyR3oDOTWe9A2c4cu+ro=
Date:   Fri, 7 Dec 2018 15:41:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
Message-ID: <20181207144123.GA20201@kroah.com>
References: <20181206143011.174892052@linuxfoundation.org>
 <85d7624a-c826-78d8-54a9-2aab10ba9914@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d7624a-c826-78d8-54a9-2aab10ba9914@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 09:03:27AM +0000, Jon Hunter wrote:
> 
> On 06/12/2018 14:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.144 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.144-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests are passing for Tegra ...
> 
> Test results for stable-v4.9:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.9.144-rc1-gcf137e4
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Thanks for testing two of these and letting me know.

greg k-h

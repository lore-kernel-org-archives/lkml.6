Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8F6C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159A8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548921114;
	bh=VkabEjVgX+eyt/E8og1efUnYv/VJd/sTANumcdSdW+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ESKh9FocEoGXj4KODhjhZxEGz2dko/Wsh0l2h4eQRjlcvGWXsgXO5vvhyGnM699Wj
	 dJU5xAtl9tqbEAq3/bFgsHNE1YpnO/4qbQiLCCyGsjsjtGroKhQdA3FOpLZSXgBcAB
	 V7KUtv/vZJnYS8VENzXuq3QrCIM7zd6mWd/mh4Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfAaHvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfAaHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:51:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADAD20870;
        Thu, 31 Jan 2019 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548921111;
        bh=VkabEjVgX+eyt/E8og1efUnYv/VJd/sTANumcdSdW+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cG0KkA4sDrar5+oVY7bmFjOanIV8O2PxpY8Ba16UuKz2SyRRNRdnTa/2KZ4ZKWNIM
         ZDIAy2q9Ud75Jq1wM0buOzen6dIpKPW9GR5Ig1fQyfmwKq4kwXBmYxGH3WcwDuV4LE
         Gr6hJNRFoQPHzCHxOFKUv0Z7xZ9QozhCG8Rg/N+M=
Date:   Thu, 31 Jan 2019 08:51:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
Message-ID: <20190131075149.GC8088@kroah.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <f2147f04-09a1-e5a9-8e47-b9b195e3c04f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2147f04-09a1-e5a9-8e47-b9b195e3c04f@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 12:51:12PM +0000, Jon Hunter wrote:
> 
> On 29/01/2019 11:35, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.97 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.97-rc1.gz
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
> Linux version:	4.14.97-rc1-g958f665
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04

Thanks for testing two of these and letting me know.

greg k-h

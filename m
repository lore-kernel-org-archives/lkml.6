Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0319321848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548248140;
	bh=8KmCeuQjaH4AqQ5T4/ZTC+Z8iw501hJhaTm0Hi/yMDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GG+Gcs+2lujWxRe7OFCL06D8RS39aMYOusJpWJHaTHCjc/ztijovq85VskjneybBa
	 j+PungKBsBgpDSB4tR00mGKVRKMFU2jqTiv5O4nfjFcBRxn4Yj8Pn2Li2XCd8np5q5
	 96vR/6p0Z73af1yxJNI1NmJe3DwDJdCfCXDKwPjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbfAWMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:55:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEDAB2183F;
        Wed, 23 Jan 2019 12:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548248137;
        bh=8KmCeuQjaH4AqQ5T4/ZTC+Z8iw501hJhaTm0Hi/yMDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSWDpOaF3K2Vb4kmFvy5kRH3T7gvFRKzzGYn0f4PMcWhA46Fhx2tq3ptQx94xEx+K
         M/ZBMZRX1EJ30Sw2PzZwBCpWKbh8BT3/PlQeSAfLzifub4NyxNeywZIypKXm8d2IeD
         a5rPlIZg1wBWG8V8sccsIm6cLd+oi6+6bEG5iK1U=
Date:   Wed, 23 Jan 2019 13:55:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/59] 4.14.95-stable review
Message-ID: <20190123125534.GA21318@kroah.com>
References: <20190121122456.529172919@linuxfoundation.org>
 <514faa89-bfed-1741-3a93-930f20177259@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514faa89-bfed-1741-3a93-930f20177259@nvidia.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:07:33AM +0000, Jon Hunter wrote:
> 
> On 21/01/2019 13:43, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.95 release.
> > There are 59 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jan 23 12:23:55 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.95-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> All tests passing for Tegra ...
> 
> Test results for stable-v4.14:
>     8 builds:	8 pass, 0 fail
>     16 boots:	16 pass, 0 fail
>     14 tests:	14 pass, 0 fail
> 
> Linux version:	4.14.95-rc1-gb18179b9
> Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
>                 tegra210-p2371-2180, tegra30-cardhu-a04
> 

Great, thanks for testing and letting me know.

greg k-h

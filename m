Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77AC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80D921903
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548490613;
	bh=ZZ7MuG1XMsqgpe2ofduCQ2l1Jvd0PBXokoNDlsM4+3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y+8eyqVpDIlmYgEmPgj1Wy7gpEe7+vvBCsLGa6m0FakjJBqW63QmIRrS3uC2BoglI
	 wDO4+A+Do5//ZnRbbsvndRD9Jp1aaX2gl6UkNnQ8iCRJVD0Wpz3iwzJzb8Kkmff3jK
	 N3g9rvayICmpfVrzJzShrfP95ZlHcV4Y0kVjsPL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAZIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:16:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAZIQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:16:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2316D218B0;
        Sat, 26 Jan 2019 08:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548490609;
        bh=ZZ7MuG1XMsqgpe2ofduCQ2l1Jvd0PBXokoNDlsM4+3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3DuFM9tT5ysNRO73y11OOgAjZ8i9IPhFOZoHMJsPU8tTeyO2++UfK+cq6FyEKStw
         Zwf3l9K/oyUamWUq8BWiRdvJoh4FxICeVDQAwtnjcjFxc04XzO/xYk1U+2WCnuqq7Z
         FJMs38mNFQcFz6HdST44BUJpen5zoja/nyuanQso=
Date:   Sat, 26 Jan 2019 09:16:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
Message-ID: <20190126081646.GA31782@kroah.com>
References: <20190124190211.984305387@linuxfoundation.org>
 <e87a0ccb-9588-d260-8bd8-4163ab1af6ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87a0ccb-9588-d260-8bd8-4163ab1af6ab@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 07:55:15AM -0700, shuah wrote:
> On 1/24/19 12:19 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.5 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.5-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h

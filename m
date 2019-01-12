Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD31C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123DD2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 08:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547280217;
	bh=SWg7ulla7VJGcRsYqr4sNvHEcu5M3xkWsVYg2FUyy24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOQMxhQD12X+lbE6Klv9DA36MkkDAfZz3pqgaVNrlzIzwcpxftVAA6cuqtCl/ckaS
	 VhffEmXkAEMeJagxclXWtknFDw/AGB5njmjMyvxjo8my/Bi/LGXy+C7EOoSa10y3cY
	 /zyJjAPoMiOEhYOc/+Mi2k5SS5wAgYgPjiHQOMc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfALIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 03:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALIDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 03:03:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2181F205F4;
        Sat, 12 Jan 2019 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547280215;
        bh=SWg7ulla7VJGcRsYqr4sNvHEcu5M3xkWsVYg2FUyy24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqkVflz1mNk7V0VHNdydx2z1ACUwh5dBhp/57WaXt4AMMwLhWy3Fze/lbUG6cJfux
         HKMrAPqHz5WDmpnwR2cH3lwLqpBF+bsOH+TuZcwKLkHzMsSQOiMtSkBPLL7z3JGfKm
         4eBX18F3bVEeWuZzR9W7U+96JuaKNolV8H98sRpM=
Date:   Sat, 12 Jan 2019 09:03:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/65] 4.20.2-stable review
Message-ID: <20190112080333.GC17489@kroah.com>
References: <20190111131055.331350141@linuxfoundation.org>
 <bbc9cd6c-003f-6130-0e52-b3687556e3d1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc9cd6c-003f-6130-0e52-b3687556e3d1@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 02:35:25PM -0700, shuah wrote:
> On 1/11/19 7:14 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.2 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Jan 13 13:10:14 UTC 2019.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.2-rc1.gz
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

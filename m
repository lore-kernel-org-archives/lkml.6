Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E821EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D3821479
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtweHqYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D3821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeK3Vpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:48652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbeK3Vpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:45:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5234F206B7;
        Fri, 30 Nov 2018 10:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543574222;
        bh=mmawdeKRJk+yOQgMP7wIIdK4h90zmWPsp9e+/aXEPvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtweHqYdb7E4wv6kZp9HO16WfAYMeF9RvYHPnKO6jCf+NZo4odP4VhICDzoaE6AJb
         C0Cv/F5NV8FPNsMF4BHw8LJ+cm/IuKP9/vaBAGaNQjBANCmwJOJRI8nEV7vnk17vi1
         DG9JE/Fnc2c1dRNRl8x4YX4LKbm8NrSwig+HaF9k=
Date:   Fri, 30 Nov 2018 11:37:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
Message-ID: <20181130103700.GB11558@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <CA+G9fYvjmnpHEaSHvfibx1vdPjvGt7WyrUX=o2+fQEARg3N0Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvjmnpHEaSHvfibx1vdPjvGt7WyrUX=o2+fQEARg3N0Nw@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:22:59PM +0530, Naresh Kamboju wrote:
> On Thu, 29 Nov 2018 at 20:05, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.6 release.
> > There are 110 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Dec  1 13:58:54 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.19.6-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.19.y
> git commit: ac4af649901b05aa42f4ed3e153ce0150d67aa03
> git describe: v4.19.5-111-gac4af649901b
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.5-111-gac4af649901b
> 
> No regressions (compared to build v4.19.5)
> 
> No fixes (compared to build v4.19.5)
> 
> Ran 20180 total tests in the following environments and test suites.

thanks for testing 4 of these and letting me know.

greg k-h

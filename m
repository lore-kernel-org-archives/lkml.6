Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08A7218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548921138;
	bh=81mP5RuGzD7pa3A9kAEnrkYtKRGJM9tHWha+xK/P+ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=isebaxQ7ib7mx1uAvVURJfhXcW62HHu0oFETVRv6jWqJT+2++RUcqdJYMJY4IExOZ
	 Oc6Nj0C6bIJjIKwxKJlhoWH3A99VKPvZUZp8pq3c8ziqkdcjdDUVOA5VX482ut1LpV
	 XExj7S4NbYpN6V6GVVd85jYbAIXq3zmSdX6QBYeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfAaHwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfAaHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:52:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6109220870;
        Thu, 31 Jan 2019 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548921135;
        bh=81mP5RuGzD7pa3A9kAEnrkYtKRGJM9tHWha+xK/P+ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwnUOtQzpIGabfK9Z+L5mJH4GMkZ6zVoWaxJwJi2bOxtht0xUtOhVcQoy3NTFtq/C
         vzq3AHOU4COcBEeuVHKtCxEQc+/HnoFgL2grhRCzY8QVWaa07dvMFhug5C/ziwPvQ0
         lnkHJj1mnAmyFPm+5cwqXS2GT7O9+WzTTejtPZoY=
Date:   Thu, 31 Jan 2019 08:52:13 +0100
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
Subject: Re: [PATCH 4.20 000/117] 4.20.6-stable review
Message-ID: <20190131075213.GD8088@kroah.com>
References: <20190129113207.477505932@linuxfoundation.org>
 <CA+G9fYsUa=upA5=juDqNtU1tEEXoPzQbXRoajjSLyyaiOw9BSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsUa=upA5=juDqNtU1tEEXoPzQbXRoajjSLyyaiOw9BSw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 07:04:39PM +0530, Naresh Kamboju wrote:
> On Tue, 29 Jan 2019 at 17:08, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.6 release.
> > There are 117 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Jan 31 11:31:34 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
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
> kernel: 4.20.6-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.20.y
> git commit: ef18d4260339bf79aa387199f912d366aa7e4b93
> git describe: v4.20.5-119-gef18d4260339
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/build/v4.20.5-119-gef18d4260339
> 
> No regressions (compared to build v4.20.5)
> 

Thanks for testing these and letting me know.

greg k-h

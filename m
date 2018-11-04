Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBFECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466242085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 07:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaB4moiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466242085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeKDQZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 11:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbeKDQZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 11:25:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FFA20854;
        Sun,  4 Nov 2018 07:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541315477;
        bh=LVOgaNSzHWaZupF8u/ArQK1ULrNHchhqcfGQP8sFaKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaB4moiDcZO7oxBcef035lkOPKP9DAiAV6jwhVdcTJxY/3hfOPJ4E9dOUv4X6XTqp
         kUEpYHYe8piYB4FHHzrWidqACD0373UBudHQoe2YrDVZjCCT8uHaBLWc2HvFH1zapM
         xhcAHnXclwQ07qsImOHuAR2izKmmEMoi/jHO8P9s=
Date:   Sun, 4 Nov 2018 08:10:57 +0100
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
Subject: Re: [PATCH 4.19 00/24] 4.19.1-stable review
Message-ID: <20181104071057.GD8678@kroah.com>
References: <20181102182839.725385066@linuxfoundation.org>
 <CA+G9fYuTFgPor-OZBb2j8PNLOZX4JN_W26zJi6U4JkNmXcC5HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuTFgPor-OZBb2j8PNLOZX4JN_W26zJi6U4JkNmXcC5HA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 09:54:12AM +0530, Naresh Kamboju wrote:
> On Sat, 3 Nov 2018 at 00:06, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.1 release.
> > There are 24 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Nov  4 18:28:10 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.1-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64 and i386.
> 
> NOTE: kernel selftest version updated to 4.19
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.19.1-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.19.y
> git commit: 6eebea1ddae93f3931387c0672ff2d130a4888ce
> git describe: v4.19-25-g6eebea1ddae9
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19-25-g6eebea1ddae9
> 
> No regressions (compared to build v4.19-25-ga3c575473f6c) and mainline.

Thanks for testing all of these and letting me know.

greg k-h

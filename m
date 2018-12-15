Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CB921726
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544893909;
	bh=oEZiDE5FNwT7ih/+gCLxYt8tIy6MTmPzMkZO3FzlO94=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=FX1nC3h5aA2loi6zfhn59/TX44zCjmqzNd2PnZrmGhGx+mkmBJZu0le6iFbeuTt7R
	 QS0OUgFDj77EV1gx5vr8tVYD5iCEdsxsyoJund+YPW/DRhWuuSzqf8KVsQ73lFROvO
	 5IT78gpgsClt1J7yVzRkJGBW0YWtfpZj4t9We+Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeLORLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 12:11:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeLORLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 12:11:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A07206C2;
        Sat, 15 Dec 2018 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544893907;
        bh=oEZiDE5FNwT7ih/+gCLxYt8tIy6MTmPzMkZO3FzlO94=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=x0LkcS+sYzZ5rWcOC7LWSa+Pg6SdV1YBVyaV9KXALu+NYi/dSzE09kxlVVd1Jzle7
         uwHhK1ch5qTCPh9P0adzaszTgA96wwkQ/Lj1qw8JVceOF/48Ii5T64wnbeFJxP5QX0
         htRINpGglKMeOTNFaXvve+PQ7MvP7d6If9ZGdU9Q=
Date:   Sat, 15 Dec 2018 18:11:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
Message-ID: <20181215171145.GA2086@kroah.com>
References: <20181214115747.053633987@linuxfoundation.org>
 <20181215170102.es7drxdtiz7gzaib@xps.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215170102.es7drxdtiz7gzaib@xps.therub.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 11:01:02AM -0600, Dan Rue wrote:
> On Fri, Dec 14, 2018 at 12:58:05PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.10 release.
> > There are 142 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Dec 16 11:57:12 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> Regressions detected.

They were?

> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.19.10-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.19.y
> git commit: 4875bf1f86d7bdc8dbf3222ab4028239446fab3f
> git describe: v4.19.9-143-g4875bf1f86d7
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/build/v4.19.9-143-g4875bf1f86d7
> 
> No regressions (compared to build v4.19.9)
> 
> No fixes (compared to build v4.19.9)
> 
> Ran 18346 total tests in the following environments and test suites.

This said there were no regressions.

confused,

greg k-h

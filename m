Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD3C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CAC20872
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547314541;
	bh=nrLr2cNcVtzEjFN9AIfmc+VjJcWSlWLJOeCSxkrvm+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RSxUONaYLML6y7pZwkiSXG3HivevRK28jJIGmSFJRrryYthBja8KfQOD+wBv8iBVx
	 Skb0Q+Lh9UKghGfZKtNnz8ekeTc+lcc5Z3S7Uzv2sq1v+OhOFkDkwidecoZsONTgeU
	 abf6luAWxvj8/JgD4aRLPgiDIpc+VMu5zdRTqpRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfALRfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:35:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfALRfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:35:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFBFE20836;
        Sat, 12 Jan 2019 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547314539;
        bh=nrLr2cNcVtzEjFN9AIfmc+VjJcWSlWLJOeCSxkrvm+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zpJTUE5zj3j4sHTDZhSDhgX1Xz2Q6nLEoChGngwXXQOdq84I+jag/7K2tgRReIEoN
         j2o1zNc4yCkkgIf5loZvasxR3yTP8M4po1oUHcO6doBpFOxUoW6r8YWmhkCLtEKg6M
         4g3LeKU1LYPxnlmAkJ0S9ZXbMb8SdCJz5SsKX1x0=
Date:   Sat, 12 Jan 2019 18:35:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.20 00/65] 4.20.2-stable review
Message-ID: <20190112173537.GA24406@kroah.com>
References: <20190111131055.331350141@linuxfoundation.org>
 <CA+G9fYtoFMzGQYxWKw3MHYnPeChqjAO2+TDBs3aO8qiX7pEH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtoFMzGQYxWKw3MHYnPeChqjAO2+TDBs3aO8qiX7pEH6w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 01:58:59PM +0530, Naresh Kamboju wrote:
> On Fri, 11 Jan 2019 at 20:13, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.2 release.
> > There are 65 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Jan 13 13:10:14 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.2-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h

Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291782086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547655187;
	bh=leITiaSzL1D0igE7/c9p/Psmimv5reZcg5ebuT1RXxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nZZaxjhPuJw8nYpIsCZlZUG1L86cfts9jNV+la5E4rj37w5ft8Dfgj38FJupDWzLZ
	 QMhuu81fXH7BLlMEGH/A0Li8fyBvrz1KRzXLMZtH39R5hwMa427ei2zyvsu5/DAVtT
	 Lg0ewnAzmTrHv51l8QNp+YvGYIzH5Bn5zl9WTGyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAPQNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfAPQNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:13:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78AFC2082F;
        Wed, 16 Jan 2019 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547655183;
        bh=leITiaSzL1D0igE7/c9p/Psmimv5reZcg5ebuT1RXxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQkWTGES2R+smP0y4K3+WcLaUi02ORB2Xh7vq2s1kbGWxq9BB7tXbDROZNnNdD9tW
         ZMGk++xtNxlh1Mr/H8jnM1SYEM9Su1ckZrzxX3aNgdjdJJDnD3vBmrOVYdcdZR7r5R
         sVN8S3xV0PhMw12533uXE/zl9thDNkqgawEKVyUU=
Date:   Wed, 16 Jan 2019 17:13:01 +0100
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
Subject: Re: [PATCH 4.20 00/57] 4.20.3-stable review
Message-ID: <20190116161301.GC4594@kroah.com>
References: <20190115154910.734892368@linuxfoundation.org>
 <CA+G9fYuk5XJswcM5-F66F4apYxSaDkKO8DRe67dYXKVMM-7buw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuk5XJswcM5-F66F4apYxSaDkKO8DRe67dYXKVMM-7buw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 05:17:49PM +0530, Naresh Kamboju wrote:
> On Tue, 15 Jan 2019 at 22:15, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.3 release.
> > There are 57 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Jan 17 15:48:32 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h

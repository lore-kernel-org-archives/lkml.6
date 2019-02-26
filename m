Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070B2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551198901;
	bh=kehbKKWfhassYH37pJ9vjuy4Fb4Bc+7ySxTjjOsPgzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k9OSD87R7IqGfrHYg/ODRL1ZJrLNUFiWI1rwNJWd9hERKEqis08N6JS0MOs+PmoIW
	 M7BmamsOpT6b2FM8NrZBDlfuSIcdvaoBvWyHMMDYqPPOhZqcznbKtJQ9n8wPJKTVn3
	 1TcCfOp+cdwpYaw/y+7wNHfvt0NdgXUlty4oK5tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfBZQe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:34:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfBZQe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:34:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1D220C01;
        Tue, 26 Feb 2019 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551198898;
        bh=kehbKKWfhassYH37pJ9vjuy4Fb4Bc+7ySxTjjOsPgzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0XQCMWRKZYygdiQoXmMOopUCsKJ7uVkfllqb4BkYmsGoykJApfLoKVnsM9p4vIK6
         XZ62uFU/zrxmMtCLHIYFas1mTpWZ/XgOdJNAjq9MVIZX05yMVzP5MBhLQxemg3uzJy
         asSdAz4QQc86zv5VwjngE3VeIa2P2x3YCYOqyhhs=
Date:   Tue, 26 Feb 2019 17:34:55 +0100
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
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190226163455.GB12491@kroah.com>
References: <20190225195054.748060397@linuxfoundation.org>
 <CA+G9fYv7Nn9kz_ox6Kvge4pkH4OUEW_F2aZBtRE6eB+ELKXYwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYv7Nn9kz_ox6Kvge4pkH4OUEW_F2aZBtRE6eB+ELKXYwQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 07:23:53PM +0530, Naresh Kamboju wrote:
> On Tue, 26 Feb 2019 at 02:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.13 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.13-rc1.gz
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

Thanks for testing these and letting me know.

greg k-h

Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB7C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB5218FF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548490711;
	bh=xtHBvHoVUxtFsdcP90couFgmDeB0qAOqg+iI3evRePQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qWIXBpmiJcpewjjXOMnCmtoPqZMEhtKYArZaceHoYEq17nOk4l4XE8PIvyUUedVGs
	 BM3Nj7lOGGRkzl5cq20FkXllfJ82X+v45EdH13lx+f67GrcZuavM5usDc9K62IuG9o
	 lNS4ocv52wP5EGWxRP0u61FuW1Mx48mn/cuhT8gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfAZIS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfAZIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:18:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B4D218B0;
        Sat, 26 Jan 2019 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548490708;
        bh=xtHBvHoVUxtFsdcP90couFgmDeB0qAOqg+iI3evRePQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWMhJ+Me/07eMaDFjKkQuOmD64OZbG7N+kuOP0PmaHdAbFIkG4Vd6ErIlIqCqaScU
         NWdP+d76v/+AaqD5xxVWMz49dC1EeGLmSuwVkc2R9oBXZtOaHLyPBtuAkjOF6MW0/d
         C5z3dflz6tTKuVDELJJxrNVZmSzRrrcBh0Q+4Csw=
Date:   Sat, 26 Jan 2019 09:18:25 +0100
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
Subject: Re: [PATCH 4.20 000/127] 4.20.5-stable review
Message-ID: <20190126081825.GD31782@kroah.com>
References: <20190124190211.984305387@linuxfoundation.org>
 <CA+G9fYteq20MGKUx6sy9sxdbyGoarWA+4yGPnNKB-ZUEbt47Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYteq20MGKUx6sy9sxdbyGoarWA+4yGPnNKB-ZUEbt47Kw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:15:00PM +0530, Naresh Kamboju wrote:
> On Fri, 25 Jan 2019 at 01:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.5 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Jan 26 19:01:19 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.5-rc1.gz
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
> 
> NOTE: Kselftest source have been updated to version 4.20

Great, thanks for testing all of these and letting me know.

greg k-h

Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4A2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D18222C5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549996726;
	bh=kL9J7JSUhBhCoJcdHOYnUpii/fgj2l/qM0lPh+G9ZsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YuBGlJ1iCniVLLzdlbNw9xc0mdjJ57giQZhW81jAIuC+qZBTEkY2B1REzcvVkFKrK
	 EwcFxICWrWmG2z5yQEUPW1DxoJ1rKSyZehq23nn8JFPaQBw5uV2LnNHaCH9eAz2RBA
	 Igl9VJfVW1dDu7LDpA4WEOd6b9X+esG7om38SYLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfBLSio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:38:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfBLSio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:38:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141ED2190B;
        Tue, 12 Feb 2019 18:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549996723;
        bh=kL9J7JSUhBhCoJcdHOYnUpii/fgj2l/qM0lPh+G9ZsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O5Of7L2Z96d3czYu1CbfoGBqq6syDNCADsBTgE6Zg2BLqHzG7LmH3vQVKLTtFGvms
         pLKYTdi9iNka55130alepUqNJ/WPEKKGCZ5RGCBp4uCqaj5MKf1ky/GyajYaNrIJbc
         1mXc7YBqBXFS4NNTyoSdMB+YmS8q9aE03Lpbjba8=
Date:   Tue, 12 Feb 2019 19:38:41 +0100
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
Subject: Re: [PATCH 4.20 000/352] 4.20.8-stable review
Message-ID: <20190212183841.GD14892@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <CA+G9fYttjJkBob7Yngnt5uszy+m=qkrpKodx+e5_w+1Fin+4AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYttjJkBob7Yngnt5uszy+m=qkrpKodx+e5_w+1Fin+4AQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 09:55:11PM +0530, Naresh Kamboju wrote:
> On Mon, 11 Feb 2019 at 19:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.8 release.
> > There are 352 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb 13 14:17:03 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.8-rc1.gz
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
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.20.8-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.20.y
> git commit: 2a1c4a78ff2929597b3ae4347873168b976cbe90
> git describe: v4.20.7-351-g2a1c4a78ff29
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.20-oe/build/v4.20.7-351-g2a1c4a78ff29
> 
> 
> No regressions (compared to build v4.20.7)
> 
> No fixes (compared to build v4.20.7)

Thanks for testing all of these and letting me know.

greg k-h

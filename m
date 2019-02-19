Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E126C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7BA2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550580481;
	bh=ctNDfEhGVYLjxvdFL20DG1jTXcWyPo72lc4zm3u/4M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ON7lDN8U+lkgpjhQluCUa0Ylv8nOIQntrKBbbJNBpe48hqgIA6fZxhF+BW30s2sm
	 2u7ZU920gUEJ5St5m8YlKQYYRU0VzT4Tl/ZsFu+AUxbL7ZnkCDzAisxadSdgcdB2T2
	 zV7QL9J35sFjF6suzucMUHau9BLLreaBrRHoOhNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfBSMsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:48:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBSMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D052183F;
        Tue, 19 Feb 2019 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550580478;
        bh=ctNDfEhGVYLjxvdFL20DG1jTXcWyPo72lc4zm3u/4M8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sKNyiqAa1sZUztQ3a8U1peK/Cknuu3ocq5M1jXIwidB9VSbkJN9fFCN+/SKV8QS08
         8QVPAtRbCnJqyunOWX86ynyl1S8SHvSg888JW/pd4K/8Z0iGwJCRyveFEShMJ4RunY
         B8gRy1U6gpCm80f9MtGz12a5Ak0MTrgbWuU9UbA0=
Date:   Tue, 19 Feb 2019 13:47:55 +0100
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
Subject: Re: [PATCH 4.20 00/92] 4.20.11-stable review
Message-ID: <20190219124755.GC16246@kroah.com>
References: <20190218133454.668268457@linuxfoundation.org>
 <CA+G9fYsELzsA7CN4CYoC0QNTsEnuORBBYmj5OUKD47Js6zjY=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsELzsA7CN4CYoC0QNTsEnuORBBYmj5OUKD47Js6zjY=g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:18:30AM +0530, Naresh Kamboju wrote:
> On Mon, 18 Feb 2019 at 19:15, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.11 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb 20 13:34:25 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.11-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing 5 of these and letting me know.

greg k-h

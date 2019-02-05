Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F4C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BA5217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549377813;
	bh=Pm/HspBwDb7qzeK487wTH4+4a4Ixr3ZGUbL6NVNm/H4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=htB/ooyLw2KcSV97yeaDBfeqMinqjAPUd9Rt8qSszKdr8XvsMah1FwkgkEFloP63H
	 e4SzmvxR2BXIFOhpDJZbsYBR4UErPAHRM5QqjAkqjmi8SP/iCkTMoePhtgNQCedS3Z
	 CV8bG5pGKuzJTn+VharUQUY+rp+eZixekMUI1mn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfBEOnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBEOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:43:31 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7A5A2080F;
        Tue,  5 Feb 2019 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549377811;
        bh=Pm/HspBwDb7qzeK487wTH4+4a4Ixr3ZGUbL6NVNm/H4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EX+Gnqdw4E7a96uUaRJYUabAXkQMtDvAcs1pYMz+MSzbxduI5tvTF3+TIUSOOQuLc
         DOxB3OnbEC7QM8LF05KBTJ4CFnlWuQu7z0ArJwQUbM+74d7snIb9KnNBAETI7VI8Wj
         xwRX2Rn2PMOXmkUSHGvGoVL2nxVSoPL+EsHMT82w=
Date:   Tue, 5 Feb 2019 15:43:28 +0100
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
Subject: Re: [PATCH 4.20 00/80] 4.20.7-stable review
Message-ID: <20190205144328.GD17950@kroah.com>
References: <20190204103620.287366543@linuxfoundation.org>
 <CA+G9fYtiWY7c-fEn+ao4UFqWikuB56oyDawt1u+Kp-_d_HQrtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtiWY7c-fEn+ao4UFqWikuB56oyDawt1u+Kp-_d_HQrtw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:50:57AM +0530, Naresh Kamboju wrote:
> On Mon, 4 Feb 2019 at 16:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.20.7 release.
> > There are 80 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Feb  6 10:35:33 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.7-rc1.gz
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

Thanks for testing these and letting me know.

greg k-h

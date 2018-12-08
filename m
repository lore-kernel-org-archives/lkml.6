Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E54C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAA320892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544258384;
	bh=UX0JQ+3F1k5E0pIBIAH915ukeBPXwoZBQgEac3iHa9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZvrfcB5LsB3uFKP2LvBAP83yOGUrWLUk4uZzh9lENjm6ZjmzksH+AGz2zIx2VF8Tv
	 3LzTMzATd3sJ7OXIRdg1jbhaMQVG+sQhyBNqoo0Q88Zxm6udLAVTaFP3p2wiTk44jJ
	 zGwMdn0Remh0V9zTIuMTF6MA5YXyjRjL4Ti+vDxI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAA320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLHIjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 03:39:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHIjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 03:39:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F269B2082D;
        Sat,  8 Dec 2018 08:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544258381;
        bh=UX0JQ+3F1k5E0pIBIAH915ukeBPXwoZBQgEac3iHa9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnwC31X5SZ+hOiu5QNyESnEJSFU9SLbqN2Wv+JPs+hZmcH1El0gX1izdPOEQbD8/H
         ABPOlSJBlh7TGUueS2V7wsewfzPhEyfxUYW/LaAVIYDghzidzq0iwJoxd+7J7vJoTM
         NAYtnbp8QTs+ZytmBhFBX1GaJNGncWiG1iRzLWRo=
Date:   Sat, 8 Dec 2018 09:39:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Ben Hutchings <ben.hutchings@codethink.co.uk>,
        mike.kravetz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Eric Munson <emunson@mgebm.net>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
Message-ID: <20181208083939.GA19877@kroah.com>
References: <20181206143011.174892052@linuxfoundation.org>
 <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
 <20181207144157.GB20201@kroah.com>
 <1544196864.2867.70.camel@codethink.co.uk>
 <20181207155141.GA30688@kroah.com>
 <CA+G9fYtLrnx7Qihw3xwAQ+vudZ+KR+Va1Z+NM+_dm12ve8UrgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtLrnx7Qihw3xwAQ+vudZ+KR+Va1Z+NM+_dm12ve8UrgA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 11:23:26PM +0530, Naresh Kamboju wrote:
> On Fri, 7 Dec 2018 at 21:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Dec 07, 2018 at 03:34:24PM +0000, Ben Hutchings wrote:
> > > On Fri, 2018-12-07 at 15:41 +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Dec 07, 2018 at 02:40:26PM +0530, Naresh Kamboju wrote:
> > > > > On Thu, 6 Dec 2018 at 20:15, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > This is the start of the stable review cycle for the 4.9.144 release.
> > > > > > There are 101 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.144-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > > >
> > > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > > >     hugetlbfs: check for pgoff value overflow
> > > > > >
> > > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > > >     hugetlbfs: fix offset overflow in hugetlbfs mmap
> > > > > >
> > > > > > Mike Kravetz <mike.kravetz@oracle.com>
> > > > > >     mm/hugetlb.c: don't call region_abort if region_chg fails
> > > > >
> > > > > Results from Linaro’s test farm.
> > > > > Regressions detected on arm32 and i386.
> > > > >
> > > > > truncate_above_4GB (2M: 32): FAIL mmap() offset 4GB: Invalid argument
> > > >
> > > > Can this be tracked down to a commit in this tree that caused this
> > > > regression?
> > >
> > > The test failure is part of a hugetlb test group, so one of the above
> > > is responsible.
> > >
> > > Ah, I missed this fix (it's already in 4.14-stable:
> > >
> > > commit 5df63c2a149ae65a9ec239e7c2af44efa6f79beb
> > > Author: Mike Kravetz <mike.kravetz@oracle.com>
> > > Date:   Thu Apr 5 16:18:21 2018 -0700
> > >
> > >     hugetlbfs: fix bug in pgoff overflow checking
> > >
> > > Ben.
> >
> > Thanks for this, I've queued this up and pushed out a -rc2.
> >
> > Naresh, can you see if this fixes the issue for you or not?
> 
> Yes This test getting pass on -rc2 on all devices arm64, arm32, x86_64 and i386.
> truncate_above_4GB (2M: 32): PASS

Wonderful, thanks for testing and catching this and letting me know.

greg k-h

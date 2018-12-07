Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F34C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8077208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544193722;
	bh=u8r9PCwgDN8ZiAKrxnHicROrFzyj0QtR1Lyfy9IUzEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DboyyAPL7rSQhsDTuzmxE2PsKEFB+0PwOsgYwm/O+dxvaVWxS0FALV0Q0Y2NtoZvj
	 1J4BjPzVsNfxVaaOuNBQykJT8vfLbe2WZLjQeN5kbBS4Lf5NlGtubaKKmoJA4JbhWa
	 2VTYEjo2lLJVBfHe+xupd0i+ICg4CroD/mjCf3GI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8077208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbeLGOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeLGOmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:42:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01C120882;
        Fri,  7 Dec 2018 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544193719;
        bh=u8r9PCwgDN8ZiAKrxnHicROrFzyj0QtR1Lyfy9IUzEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWSmJ5VmbKlsg5A9EKbdX5VRJBwQxNwdrBA1P2E5niCckRzjaHjAixUniCe6rXNpR
         CBGQcg7WE5NumybjRF3/DinP55EQtEaKqbHIoT9/OeEuC4x71TBuFuW0Wj2cPCXoJL
         PFzMHnQBNTNdZhySJKq7CPwIW19GTymQS6FVEzZk=
Date:   Fri, 7 Dec 2018 15:41:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     mike.kravetz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Eric Munson <emunson@mgebm.net>
Subject: Re: [PATCH 4.9 000/101] 4.9.144-stable review
Message-ID: <20181207144157.GB20201@kroah.com>
References: <20181206143011.174892052@linuxfoundation.org>
 <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtzxd9a=OVr=Uwcouqikpe2EB_WJyuBhO7BX96mYWJ1NQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 02:40:26PM +0530, Naresh Kamboju wrote:
> On Thu, 6 Dec 2018 at 20:15, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.9.144 release.
> > There are 101 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat Dec  8 14:29:43 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.144-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> > Mike Kravetz <mike.kravetz@oracle.com>
> >     hugetlbfs: check for pgoff value overflow
> >
> > Mike Kravetz <mike.kravetz@oracle.com>
> >     hugetlbfs: fix offset overflow in hugetlbfs mmap
> >
> > Mike Kravetz <mike.kravetz@oracle.com>
> >     mm/hugetlb.c: don't call region_abort if region_chg fails
> 
> Results from Linaro’s test farm.
> Regressions detected on arm32 and i386.
> 
> truncate_above_4GB (2M: 32): FAIL mmap() offset 4GB: Invalid argument

Can this be tracked down to a commit in this tree that caused this
regression?

thanks,

greg k-h

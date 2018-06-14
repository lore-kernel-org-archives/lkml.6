Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AD98DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C47208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHjkPRri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C47208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeFNGfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752684AbeFNGfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:35:11 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188AD208D4;
        Thu, 14 Jun 2018 06:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528958110;
        bh=+OlYiy6Z5UVFTxPfsiBRBQl9AnyAfoarhZm9NI3EmAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHjkPRriTyPwBgGZvXyb0XN/ALVV4yaGA6SFrF+HbgWBXQLIB0u31GZxsqCMDrr3X
         CIZ+696PUxokIbl0EjV/qlKVznHXqTBWcyb40Ge43EVeUtb3z0Fg2iC1wQg13xX0Po
         dHy3qswWC2CdFncMFYrwbGAIot6x5pYFKpvNyBxY=
Date:   Thu, 14 Jun 2018 08:34:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rafael Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, ltp@lists.linux.it
Subject: Re: [PATCH 4.4 00/24] 4.4.137-stable review
Message-ID: <20180614063448.GB6021@kroah.com>
References: <20180612164816.587001852@linuxfoundation.org>
 <CADtBP2D4a2OdLsAgZ8sRFBhkh2jArviaYNzYrS7wqdmogyc=Mg@mail.gmail.com>
 <20180613210044.GA15146@kroah.com>
 <CABdQkv9uNjf7ARKBJ-sE_RVruMA5U9bTNo-EL_+7Rv8ZVJGY3w@mail.gmail.com>
 <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtBP2DZ0ceTtwaG7AdXV3xa16mQ6nu=gaqUYj7JSOLBdVD8cg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 10:48:50PM -0300, Rafael Tinoco wrote:
> On 13 June 2018 at 18:08, Rafael David Tinoco
> <rafaeldtinoco@kernelpath.com> wrote:
> > On Wed, Jun 13, 2018 at 6:00 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Wed, Jun 13, 2018 at 05:47:49PM -0300, Rafael Tinoco wrote:
> >>> Results from Linaro’s test farm.
> >>> Regressions detected.
> >>>
> >>> NOTE:
> >>>
> >>> 1) LTP vma03 test (cve-2011-2496) broken on v4.4-137-rc1 because of:
> >>>
> >>>      6ea1dc96a03a mmap: relax file size limit for regular files
> >>>      bd2f9ce5bacb mmap: introduce sane default mmap limits
> >>>
> >>>    discussion:
> >>>
> >>>      https://github.com/linux-test-project/ltp/issues/341
> >>>
> >>>    mainline commit (v4.13-rc7):
> >>>
> >>>      0cc3b0ec23ce Clarify (and fix) MAX_LFS_FILESIZE macros
> >>>
> >>>    should be backported to 4.4.138-rc2 and fixes the issue.
> >>
> >> Really?  That commit says it fixes c2a9737f45e2 ("vfs,mm: fix a dead
> >> loop in truncate_inode_pages_range()") which is not in 4.4.y at all.
> >>
> >> Did you test this out?
> >
> > Yes, the LTP contains the tests (last comment is the final test for
> > arm32, right before Jan tests i686).
> >
> > Fixing MAX_LFS_FILESIZE fixes the new limit for mmap() brought by
> > those 2 commits (file_mmap_size_max()).
> > offset tested by the LTP test is 0xfffffffe000.
> > file_mmap_size_max gives: 0xFFFFFFFF000 as max value, but only after
> > the mentioned patch.
> >
> > Original intent for this fix was other though.
> 
> To clarify this a bit further.
> 
> The LTP CVE test is breaking in the first call to mmap(), even before
> trying to remap and test the security issue. That start happening in
> this round because of those mmap() changes and the offset used in the
> LTP test. Linus changed limit checks and made them to be related to
> MAX_LFS_FILESIZE. Unfortunately, in 4.4 stable, we were missing the
> fix for MAX_LFS_FILESIZE (which before commit 0cc3b0ec23ce was less
> than the REAL 32 bit limit).
> 
> Commit 0cc3b0ec23ce was made because an user noticed the FS limit not
> being what it should be. In our case, the 4.4 stable kernel, we are
> facing this 32 bit lower limit (than the real 32 bit real limit),
> because of the LTP CVE test, so we need this fix to have the real 32
> bit limit set for that macro (mmap limits did not use that macro
> before).
> 
> I have tested in arm32 and Jan Stancek, who first responded to LTP
> issue, has tested this in i686 and both worked after that patch was
> included to v4.4-137-rc1 (my last test was even with 4.4.138-rc1).
> 
> Hope that helps a bit.

Ok, thanks, it didn't apply cleanly but I've fixed it up now.

greg k-h

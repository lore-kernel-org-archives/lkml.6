Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1974EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5BC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547103675;
	bh=FceOKX4IlMcPkljfRCx8fmuGUPwBbz53DwE5EtzxOLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cOpNOZoEq0F6v4Z0ldo+WEOi730h5NjMPJjav4WuoSzMUMxxi4r1EaqKrAZ9wax4x
	 VNHxBKhMg9yrzks4g4bFOZbdLGV+FWEZGpoEwl6Ju51mhsBGXIXnglzxptj1Kx/3vt
	 zE1xm7d1mUYx4g5PjH701vcDI+cSDkR95wqL0gWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfAJHBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:01:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfAJHBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:01:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C0120657;
        Thu, 10 Jan 2019 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547103673;
        bh=FceOKX4IlMcPkljfRCx8fmuGUPwBbz53DwE5EtzxOLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmqp/m7xayz4ySXiTy0IlGwXqmfq06taj0fe1LKYl4LdnCiwRDFg+ikYMHYiiY7mQ
         QtsBdc8irxlSnhRRNFwzxzLCx71768ZWwbTrqzkehowgt0LdjoLhaECi8g1GmB4XSP
         sn/wqickAez5M6ghGV0eXjvbFi+UjMOR9KpPtukE=
Date:   Thu, 10 Jan 2019 08:01:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     devel@driverdev.osuosl.org, sedat.dilek@credativ.de,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
Message-ID: <20190110070110.GA29175@kroah.com>
References: <20180926232055.31951-1-natechancellor@gmail.com>
 <20180927051634.GA32508@kroah.com>
 <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
 <CAKwvOd=NkgAWVGCS4Mb=Mgs5iu-uX1Kp=fjYSHhXAnh4gAQ-8w@mail.gmail.com>
 <CAKwvOd=+Vqm2FdZ-nb7j2eVTHuP2dWBmiYyZ0WLMEERK9NqNKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=+Vqm2FdZ-nb7j2eVTHuP2dWBmiYyZ0WLMEERK9NqNKA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 04:19:30PM -0800, Nick Desaulniers wrote:
> Digging up an old thread to point out I was wrong:
> 
> On Thu, Sep 27, 2018 at 1:08 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > > This is not a million-little-commits problem; more like 2 drivers in
> > > the whole tree have this problem.
> > >
> > > Note that this change that Nathan has DOES NOT need to applied to
> > > every driver that uses MODULE_DEVICE_TABLE.  Only when the struct has
> > > no other references other than JUST being passed to
> > > MODULE_DEVICE_TABLE() is this a problem.  For an allyesconfig, I only
> > > see 2 instances of this case in the whole tree:
> > >
> > > https://github.com/ClangBuiltLinux/linux/issues/169 <- this patch is addressing
> > > https://github.com/ClangBuiltLinux/linux/issues/178 <- waiting on the
> > > results of this patch
> > >
> > > If you're ok with this change to two drivers, then:
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> I just landed a fix for this in Clang
> (https://reviews.llvm.org/rL350776) which will ship soon in Clang 8.
> Sedat helped test this patch and reported that it removed 41
> false-negative warnings
> https://github.com/ClangBuiltLinux/linux/issues/232#issuecomment-440006399

Great, thanks for letting me know.  Can I revert this patch?

thanks,

greg k-h

Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42603C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174F820842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551117410;
	bh=wpgNzSJ4MTK1RJL8A1yE1/CwFh1z7p9ZoHYU8Dvz2LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kV3Z7eomWq8Kcf1unibttEmuSU7aeUPXnVNVN7Ynd3YoLfs8TDzI06nT0Ltdv0NVK
	 tb+n8ZjaGZDACvXI+7ysJL11RcSxHKdSRWTSttnycNomfeYPBwR+bON1uAkIxADl7c
	 hCBvKNJSL+CWMGMtj6uRC5rhn4GuMjNchUM0U2aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfBYR4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfBYR4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:56:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16CAA20645;
        Mon, 25 Feb 2019 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551117407;
        bh=wpgNzSJ4MTK1RJL8A1yE1/CwFh1z7p9ZoHYU8Dvz2LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXjgnJpQqxD8oylNEowJaJQvokTJMMJMClmvyzvY/7epHonOJ/Co/Psk1rYSbo2ia
         g1fskgMuaKjGqYkIn2uw+WJR5tpdXfQLLb/e2bWSYE+YdV3N9D8MzlJ298AdNYMaKx
         thzF1xvL5qmneDevwEmN5upBq245rebzDLY+2fDY=
Date:   Mon, 25 Feb 2019 18:56:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225175645.GA30288@kroah.com>
References: <20190225061301.GA23411@archlinux-ryzen>
 <20190225144513.GA14055@kroah.com>
 <20190225144719.GA14597@kroah.com>
 <20190225173508.GA7885@archlinux-ryzen>
 <CAKwvOdm9V-ejTLmkzR6P_p41rVPQQ=sENdTr0E_PtZepZFmTSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm9V-ejTLmkzR6P_p41rVPQQ=sENdTr0E_PtZepZFmTSQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:46:56AM -0800, Nick Desaulniers wrote:
> On Mon, Feb 25, 2019 at 9:35 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Feb 25, 2019 at 03:47:19PM +0100, Greg Kroah-Hartman wrote:
> > > On Mon, Feb 25, 2019 at 03:45:13PM +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Feb 24, 2019 at 11:13:01PM -0700, Nathan Chancellor wrote:
> > > > > Hi Greg and Sasha,
> > > > >
> > > > > Attached are three mbox files containing patches that bring the Clang
> > > > > backports that Nick did in 4.9.139 up to date with what is currently in
> > > > > 4.14 and mainline, as well as fix warnings that are present in the arm64
> > > > > and x86_64 defconfigs here and in AOSP (cuttlefish_defconfig). All of
> > > > > these warnings are fixed in 4.14 so there will be no regressions from
> > > > > upgrading.
> > > >
> > > > Really?  I see a number of these only showing up in much newer kernels.
> >
> > Sigh that's what I get for not double checking my email after adding
> > patches :(
> >
> > > > Specifically these patches:
> > > >   1f60652dd586 ("pinctrl: max77620: Use define directive for max77620_pinconf_param values")
> > > >   a0dd6773038f ("phy: tegra: remove redundant self assignment of 'map'")
> > > >   a9903f04e0a4 ("sched/sysctl: Fix attributes of some extern declarations")
> > > >
> > > > from the "arm" mbox you provided.  Why shouldn't the above patches go
> > > > into 4.14.y and in some cases, also 4.19.y and 4.20.y?
> >
> > They should. All three pick cleanly to 4.14.y. Only the first one needs
> > to be taken into 4.19.y and 4.20.y.
> 
> I feel like I need a script that given a sha, tells me what LTS
> branches the patch is in or not.  I have this to tell me "when (what's
> the first tag that contains this commit)" a patch first landed:
> 
> function first_tag () {
>   tag=$1
>   git describe --contains "$tag" | sed 's/~.*//'
> }
> 
> So say a patch landed in 4.15-rc1; and I want to backport to 4.9 and
> 4.14 (but it's already been backported to 4.14).  Does anyone have a
> script to check this quickly?  The process for seeing which LTS
> contains a commit or not still is very manual.  I guess backports that
> require modification probably complicate the search further.  Just
> asking, in case this is already a solved problem.

Here's the script that I use that does just that:
	https://github.com/gregkh/gregkh-linux/blob/master/scripts/fix_in_what_release

It requires 3 things:
	- a directory of all kernel logs to search quickly to avoid 'git
	  log'.  I use the ones I keep at: https://github.com/gregkh/kernel-history/tree/master/logs
	- the stable queue git repo, to be able to search the stable
	  kernel trees quickly.
	- the latest git tree from Linus, to fall back to if the commit
	  isn't in any of the above places.

Hope that helps.

greg k-h

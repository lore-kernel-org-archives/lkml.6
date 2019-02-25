Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD8C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3F020645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBi1UP2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfBYRzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:55:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYRzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:55:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so8309066eds.8;
        Mon, 25 Feb 2019 09:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsVdvgdpXkplAcX5YmQlVpaF0L7DkpWtmuD+S8mZSMQ=;
        b=aBi1UP2PuQMFiY5iZnv8jqlOL8BP4zIrgacNGjz3OCGDpulOgi2YuO95QaaxTQPgAr
         r5PnhPbKPqAOV+EJwpiEkLnqsdmQxHMAGMc0PNyoeOZcdNB71Oz5h+lxredtThNJIWa/
         q8v25CXuBTq7ahx5nA7web8wYkdb4hI1rDbY26lk8ggQIbW46kauvwPEpDW87wbLobGN
         Psu5b8R1Dr1kIAefQVxmMJ3AoPixj99LVE/yvglwjE8Zb2ABx/NF/xvYQZEbnZ7vxcDS
         IlnRUdjEFQE3C0aospFxMj/V4543xmcymLGrsauHwWAgQSToLYGiTro2sD/vBCdMij5b
         3hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsVdvgdpXkplAcX5YmQlVpaF0L7DkpWtmuD+S8mZSMQ=;
        b=hJlGZzeIZWCwYPtTQ8radssI7cRbcgBO0Ju4y2f9NOI+qPZfyV/fXe7QBWfRMiJnhR
         gYtxp5qdI82iWWT2mPtuVxgtQFX+iql180BFdJhV9ikm9YPiDQf3lZuv5DGIPfszvdg6
         toGv5an697nWy47VXFBhG07WGVfXGCYHlJpG8FW25KwnlAtIRNLTU5gjV8GBQMLkTEwq
         hmxPydD5e2W3hT+bBsJJ9zn0HrScmrG+yh5pqYpNzok2SBxdPXCyDZ9N/z4HCWXrUgkl
         KYltMtmSRht/ZZSEqoRvL6xYNB8S5Cef8sOfVO+Q3+SS3m/zJiKXCelcDL4kRPeqrePJ
         Ncug==
X-Gm-Message-State: AHQUAuYGDqXoGktRP6sF56DZOUTA1uuci3gqQ/lo4t+aQAMT1+NexJ2s
        m+3Pcnao35URGvS6+2F5X6E=
X-Google-Smtp-Source: AHgI3IaIwqTnO5KRk3aE2ZbwXMvHoNjGEL0GENq4SEg8cySSdmlY+pp5aouX/9c4M4aUzY8hdzYB5Q==
X-Received: by 2002:a50:9a01:: with SMTP id o1mr15929026edb.82.1551117351469;
        Mon, 25 Feb 2019 09:55:51 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id t33sm2246351edd.55.2019.02.25.09.55.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 09:55:50 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:55:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Clang patches for 4.9
Message-ID: <20190225175549.GA11688@archlinux-ryzen>
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
> 

I usually use this one liner in a stable tree:

$ git log --oneline --grep="$(git show -s --format="%s" <mainline_sha>)" origin/linux-<ver>.y

You could also grep for the mainline hash.

> -- 
> Thanks,
> ~Nick Desaulniers

Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB6C20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="WQ/xyrie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfAQQpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:45:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42414 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbfAQQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:45:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id q145so3233305ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JO8OK9lnLxz9ocpuQkpfBP4EQtitfGExKeOwXfemQ8o=;
        b=WQ/xyriesTSaoGMj1sV9QmgGY+AMiz+S9+eWutbX42lDkulRqZ0OLCCD9zh1sQ5dv+
         tTO0H4LTYv8mUNDhQLDIG/mnaq837khBBX4p8PWT+dCZFbdM1VgMOMh/ORoY41id9JCv
         G0ECA9Cr4Ml9eZxBIi6DkIsyi8L07D+Ph/tpduTzAGonfFDn2pSLkBWVXkcUEhJ06zpG
         DSDJor26npPAH2bO/f+3QiMzddmk0oYNqFmgAJpUqHV3v0aa3q4cSxhxYrWO6A+trQqK
         BPu2dTikaveA64J609gFoHvF9RyrW79nJKsVFKr+JOC8lIFnOGutGlvawnJkbqt0U4eF
         7yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JO8OK9lnLxz9ocpuQkpfBP4EQtitfGExKeOwXfemQ8o=;
        b=phHlsgjcP3UmpiPxCV2EOSv6ClUGcwSUO0qj9BnIvPOg7ATLwaIjhplV+YOLsyvuN5
         kNLOzyHQvs8Qf79YuhZw0ZD3aBDCftbMgJOeL6z6OUQTLfdF6epFthWUFC3zhWUNIxO/
         pD3spUlysjz3DgVo8MGR3Y2lGi7SG+9fsQYPVZSvybOyILP028xn7hK5jW09rzRf9iBF
         X5514o7tjOrzbG1e/9cw8QrqX/y4fzBCFGbBMJmCVOtdzgj8CrqvlknzdzZX64noNHrl
         6xNcgew7KGhLicPojnMBt9CAu1SfNR+SbLBOXD9efOoE4HqhAvwKI2ATkLQWPJN73+34
         cuAA==
X-Gm-Message-State: AJcUukfSD4pvXytuaaKU9kIWZdNjZZIN5p3Yx373zHTXJRQ0Vzb9cTMZ
        /AUTY4CaGPyZsKNJ1CZDvq27yQ==
X-Google-Smtp-Source: ALg8bN4RsK86yh0yrPd6L5KPIXAnTTkUOw3oth6Ik1Qe7cGZTs3gSfk3ER1rO8oArmrRLLwp1atpHQ==
X-Received: by 2002:a25:da4c:: with SMTP id n73mr2638829ybf.385.1547743534324;
        Thu, 17 Jan 2019 08:45:34 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:f990:e507:9c40:21df])
        by smtp.gmail.com with ESMTPSA id y125sm749001ywc.97.2019.01.17.08.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:45:33 -0800 (PST)
Date:   Thu, 17 Jan 2019 09:45:31 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah <shuah@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
Message-ID: <20190117164531.GD17449@cisco>
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco>
 <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
 <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com>
 <20190117162703.GC17449@cisco>
 <CAGXu5jJOGO1UWdYdGmnnUEZOm-DaMUqR3UVSi+gnSc7q3KE8xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJOGO1UWdYdGmnnUEZOm-DaMUqR3UVSi+gnSc7q3KE8xA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 08:41:59AM -0800, Kees Cook wrote:
> On Thu, Jan 17, 2019 at 8:27 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Thu, Jan 17, 2019 at 08:12:50AM -0800, Kees Cook wrote:
> > > On Wed, Jan 16, 2019 at 5:26 PM shuah <shuah@kernel.org> wrote:
> > > > I am running Linux 5.0-rc2 and not an older kernel.
> > >
> > > Weird. I couldn't reproduce this on 5.0-rc2, but I did see it on a
> > > kernel without seccomp user_notif. Does the patch I sent fix it for
> > > you? (And if so, can you take it in your tree?)
> >
> > I can reproduce it; you have to run it as non-root. I think your patch
> > is necessary to get it to at least fail. The question is: what should
> > we do about these tests that require real root? Skip them if we're not
> > real-root, I guess?
> 
> Hm, maybe use the XFAIL() bit of the harness?
> 
> Perhaps it's time to make it a root-only test and do internal
> priv-dropping to test the nnp-requiring parts? I'll add it to the TODO
> list...

Ok, I'll try to send a couple of patches soon to fix some of this up.
But at least yours should should stop things from hanging for now.

Thanks,

Tycho

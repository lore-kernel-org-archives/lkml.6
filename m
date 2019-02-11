Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C9FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB52218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L7LXE26x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfBKSea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:34:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40060 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbfBKSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:34:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id z25-v6so9653561ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2is0QElp3h5cMAg9WjQlIydXMWuuXpyL8Y0m9BcHfXc=;
        b=L7LXE26xuwReDoaAPtTmRUh1H9idNIobzThPsuEOg8EwLuBfTJkJOkRpFns114Su7g
         O0OEtyxynlN2ZYfruJnJ+d+gxF1PvqJxnVYVcNXIhK+O6+I5csVG6Dz/gFu6r53cnldR
         lPwGDYcCeD686ysbjcx89uBY3+/ppJu2aBFdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2is0QElp3h5cMAg9WjQlIydXMWuuXpyL8Y0m9BcHfXc=;
        b=Vs9sNyjxBQC7T9UAbgKIJAaO+EbIS7L/yAju+jz+/n65Ou+4vvhe53+GPAFVRtki7g
         cmAsj7sift6Dmj65Vr5V1Qti+ogGgw4Qe6r7lb+sWxt7R7s5hMx4gPLWonHdRzZ/f2WY
         5TyGzUKDiZl5Jbg5Ri5eZ7/nawAF3CpCkIlJPl0G/zIUUaAF1BXufnMDKaOq+Q0Xr95O
         l6Fac9w9p3jnRlhxfIjWcfHZjlkTkRA2bLMwSR0h1/zkqyDXRkyIitpAQGkAhkJBaB5B
         anEpc4eSGGLVeYj05hibciI1OemvUUo4LOqlgnDhcF+kY+rwm5bO1txiMnbd6R0mOF5w
         8c/Q==
X-Gm-Message-State: AHQUAua+ByQ969p9dYGvvoHEJC7ChqU97OOxl3Wwin24DxT9VUzEV0fi
        DEGIbnbyR/kTgVo+uw7slsv8eHQYMmY=
X-Google-Smtp-Source: AHgI3IYgg2NnhyMzWPmuNGJsB+0F1VkckmUey8o/EnJxmyNEM2RE5RSRgeR9mvn+b7a6phk52OLfQg==
X-Received: by 2002:a2e:9649:: with SMTP id z9-v6mr6437923ljh.11.1549910067018;
        Mon, 11 Feb 2019 10:34:27 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id j14sm2470855lfc.28.2019.02.11.10.34.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 10:34:25 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id f24-v6so9709902ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:34:25 -0800 (PST)
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr10409457ljz.54.1549910065097;
 Mon, 11 Feb 2019 10:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20190210041721.GA2805@localhost.localdomain> <154977271617.2362.11794417398216386913.pr-tracker-bot@kernel.org>
 <20190211031921.GA1799@localhost.localdomain>
In-Reply-To: <20190211031921.GA1799@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Feb 2019 10:34:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
Message-ID: <CAHk-=wgz_WpD7jc084QROuM0zszEG0-WvQhQZPsCboMOWNRiWw@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
To:     Eduardo Valentin <edubezval@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 7:19 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> On Sun, Feb 10, 2019 at 04:25:16AM +0000, pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Sat, 9 Feb 2019 20:17:23 -0800:
> >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/7ad915f5ebf5b9e7ca98a7048d8f84a631fe388b
>
> I think the bot is off here because the above commit is about a merge
> from the linux-omap tree from Tony.

Indeed.

.. and the pr-tracker-bot thing actually made me ignore the pull
request, thinking I had left it in my inbox despite having pulled it.

So it would be really good to know why pr-tracker-bot ended up
replying to the wrong email, because it can cause real problems.

                Linus

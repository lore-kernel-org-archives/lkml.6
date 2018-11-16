Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA91C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F942208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqBQ8kEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F942208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389157AbeKPP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 10:58:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36464 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbeKPP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 10:58:52 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so30213itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WL+w6kusciPQlXPmxQpI2dTHKm8JXyDZ3yhIlpEKFkE=;
        b=TqBQ8kECrBJRZ6Ug85nycmHFKmQ6/sP7JiKpuFG84ZLiLNEWEK9Bs0mYQndbRzNys2
         PVgvHPfX6zCUkRnwyjr9hi8HUQP1gQBYc0tNwya4D5POdTNbYoqspJ/o4oSrEmJFuyYB
         DAuccHbCtU0j7LUvDckeiNfMeM4uganILhWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WL+w6kusciPQlXPmxQpI2dTHKm8JXyDZ3yhIlpEKFkE=;
        b=ITTA9ceSiwahz+CTa1L3zMr3EJntOU49bQmRiq8MGvag7RgQ5usMCHrpNsRonGY9U0
         ZEIku7klAH5O7h2jNFxgTiMhd9K2xFmV6KHFwg6WgCLDgSHW7+z8A2T3ew+C/znemiqo
         L4WitSdzlGr8RF2UUlDjtxqxcIpi2P9Rm9Yh2hfWHUlPRMeKpGNNzUPONx3T1qPtzNGG
         J5LFh0de+5CHSnZUgaWthCumFDx1YTvvPelDuTb64wGnr4Xz/gu/TXwqAvbVJr7XzoSX
         rHilhz+QN9wfHk/OEqWiLi9ZpsPo0IfqhQYAkb7iQlUdJVE/NCzbJm4Rt/l/jSBxDUpW
         iH+g==
X-Gm-Message-State: AGRZ1gKS/lpXid2lwYoYaZOxmz5oigdszP/lOGUPdbcd2HisLHQT35fR
        jBbQTW6BgVJFCVQPkIjmT4WiROjDOJw1FUKZH0aXCg==
X-Google-Smtp-Source: AJdET5fr3muuBevWT06mO3yUTuv7cl0/VTchkEEjNIQ0OZgDw3ME1vLuOXZ8lSsnkk11cENz6zNO3FXSLZxxGK82WCI=
X-Received: by 2002:a24:1c85:: with SMTP id c127-v6mr8335130itc.148.1542347275701;
 Thu, 15 Nov 2018 21:47:55 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
 <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com> <CAMo8BfLgf7+89X6bGtK9iKz2FkZwCtDT4W=ipc4R0OTgjMGoAQ@mail.gmail.com>
In-Reply-To: <CAMo8BfLgf7+89X6bGtK9iKz2FkZwCtDT4W=ipc4R0OTgjMGoAQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 16 Nov 2018 11:17:44 +0530
Message-ID: <CALxhOnih2fQhxuR9-X-JRmKcZj7XRPX7hg-sKyG0WFr_tgCmEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, 16 Nov 2018 at 01:46, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 1:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 14 Nov 2018 at 05:23, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > [...]
> > > > Firoz Khan (3):
> > > >   xtensa: add __NR_syscalls along with __NR_syscall_count
> > > >   xtensa: add system call table generation support
> > > >   xtensa: generate uapi header and syscall table header files
> > >
> > > What's your plan for submission of this series? Are you going to
> > > submit it with other similar series in a common tree, or shall I take
> > > it into the xtensa tree?
> >
> > I prefer the second  option.
>
> Ok, I've applied the series to my xtensa tree, it should appear in the next
> linux-next.

Sounds good. Thank you.

Firoz

>
> --
> Thanks.
> -- Max

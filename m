Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50804C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF33E2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f68pEEga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF33E2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeHCJX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:23:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeHCJX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:23:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so4433347wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJGzc7TV9BWfjYAjc2vMec1WML8YOA/IZiinHw8Qfdc=;
        b=f68pEEgahN4wskQGl5yVo5HrIc06hBlYMcvtoXff6J6T6iNf5/KHwtDh9YIYM+Nlqp
         cNJjZ9PXpg7qGqWEpGxe2ceOoYQe/RLH5ZYMuqfTSZBGqcv7PqBSYinXy4n36dKhIzz5
         nD0taQ+4wFQcPkk8J+Ha293iN+8aIs6kVxDl/Fl6Nnp4Sw/btIGXOwWY3WKJqJmjvPFd
         mY38axqHJhxbsy5BHLZEQDYBFysKT3XTr1gqAwlszONu7F1u12dn2u08/hIRtEXZ5emt
         UQKKJ0ecXRME7nmwGFWEGF6etq/2riUwN0D1jQo0dtYCUs742HLhOUsAiO/lCqJuaviM
         iVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJGzc7TV9BWfjYAjc2vMec1WML8YOA/IZiinHw8Qfdc=;
        b=fKymuKRdIT+5MdaKibSNke331ZsPCIRKCCneSH24HbrrSa9JYi/YNLBN0H9RyTnfhR
         3KyQXVXA0rgMb9NrdelfYDS+k2Ulxm1SjgIvH4kyJFPuPBVQFSKNXJHAsmI03uhs2y8y
         s88Iasrkywuj2qMr45oyc9t5fJnQr7vriYtmbQ6ngTq+RL0We45m7IhaMjhEOjq8dZaB
         HH3D2K33ChguLluN+zETVZRVpUKseNFhzmXI4wt016Aop4xHg4XQLYGQBw6/PB+4QKX0
         kkXlHAzvkYq1yEkkA4CmIGtAkaUBR9J8iYvFcw3luvihELNJ85T+CFXYtTazBiLlBbLr
         dLyA==
X-Gm-Message-State: AOUpUlGPVDt66b+OKMhdNX3iw7v/bJiARM4p+w5qZ7/Ez5TK2nj2TZeI
        wwIdsbWKgN6Wj7/fO4ebs9yaXkqu3XmbEaKJxWU+FQ==
X-Google-Smtp-Source: AAOMgpc8lirY0nZV8hfpBQKumwTe+IA7Z6Xbo9yDxR/X5PI6uembaUFjpLEv6C5pRHGeglU9uEDEUWVwm4F0d2fDyb4=
X-Received: by 2002:adf:a0f3:: with SMTP id n48-v6mr1777239wrn.23.1533281307686;
 Fri, 03 Aug 2018 00:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBT0P=GKNb6ypjaPxe4dEwShHk37mdrX0RtodMm44gaE+Q@mail.gmail.com>
 <20180719082539.GB18667@krava> <20180731092128.GA17617@krava>
In-Reply-To: <20180731092128.GA17617@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 3 Aug 2018 00:28:16 -0700
Message-ID: <CABPqkBQOWGUsTOXP1CjVxSDtquSGrxaiSqK1ZgJcW0jfzwENsg@mail.gmail.com>
Subject: Re: [RFC] perf annotate: option to report global percentage
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
On Tue, Jul 31, 2018 at 2:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Jul 19, 2018 at 10:25:39AM +0200, Jiri Olsa wrote:
> > On Wed, Jul 18, 2018 at 02:55:14PM -0700, Stephane Eranian wrote:
> > > Hi Jiri,
> > >
> > > As far as I know, once you go into annotate mode, via perf report TUI
> > > mode, the percentage you see per instruction is relative to the
> > > function. I would like the option to display the total percentage,
> > > i..e, the importance of the instruction for the entire run. Right now,
> > > if I want that, I need to do function_percentage * insn_percentage by
> > > hand. This is not convenient. Having a key toggle would be very
> > > useful, worst case a cmdline option.
> > >
> > > What do you think?
> >
> > hi,
> > that should be simple to add, we already have the 'F' in the
> > main browser window to toggle among full/filtered scale
> >
> > I'll try to add something similar for annotation window
>
> sry for delay, I was out last week
>
> I put something together and pushed it in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/annotate_percent
>
> there's the 'p' key to switch between local and global period
> I haven't added any command line option for stdio yet
>
> I'll have more testing and post later but any feedback
> now would be great
>
Tested your code on a few examples and it seems to work well. Looks nice!
Thanks.
PS: I'll have more small requests coming based on user feedback and my
personal experience.

>
> thanks,
> jirka

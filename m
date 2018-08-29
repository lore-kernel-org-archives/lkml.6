Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1CFC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E89205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeZZ+RbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E89205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeH2TKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:10:30 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52942 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeH2TKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:10:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id y139-v6so5616322wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JLqiGIQni4zvJXjkNnl/H6Nr83ui6sWEU9gBiCOb4s=;
        b=CeZZ+RbNlyNqeTNxKNmSbSay59205xskwlbpCwU8bc9YqNCEewgn60dW5GAO5ywGOB
         WG0KwGxvdHWSEvJIEc9ksg5OTcYljg4ubH4hElLd4C+J2NIv0SOkduwr+iAdjLAapCbN
         nY8N9ISNOd5vPKHgJWkoZURv4VHmZ57pCsc1FpdqfuACnRLOg8Em3rEzTHm4UUHWgoKb
         CYtRCjocsnIzbrt5OtxRQoaD9trikwguJRRJyPepASRl7dFzTNuKEFoNlNf0pzLC4HLv
         oWBs3GkSE7N8vEgirhv1H2pJfXOXiMjsopyMA11+ocd53p+A05g8nXu3C+g/S1W5VsA9
         aIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JLqiGIQni4zvJXjkNnl/H6Nr83ui6sWEU9gBiCOb4s=;
        b=KDGSqn97z9Fhy1vXSDvl1goK6idzc07lc53Bm/IdTBBEEorerBFxkdKUfM0fJYmOIz
         QkgILBjG0maYzhQvwvHifGhhDvW+XjfV+4t0fdwATh2GjhAvU4y8bfhAkO/bWO9rM1yz
         GUaSqprogqG2Ht4twzrrPOjiicIdZC9vTR3MakGKFnQg272dGFoGSYeXjXLFKgbBGsZ+
         sviCozBLgQ8D8xg53LFdaODASctPHuVbNCA92+q7vjkZNtRi6neGj12+M9PrTeFuz7gV
         hVHDffkTFPHPjxl37C84cGwwrIae888qkV2NizT+QtUrMqfGTK5j+OGZH/rGztSdHsPL
         x5MQ==
X-Gm-Message-State: APzg51Cl8WrlkjQepKh0bgsO2oNKtfSEJKk+mBzGo6ll0e/rVcz6hgCS
        Cn7f/+kggs+3TC7xeyh2qL3fIDDUf0bd2zyLwrkSjw==
X-Google-Smtp-Source: ANB0VdaBoOk1wuT+thlcX7fLPdkCwi9SboZUF4vqMXeLTgJgizSkqZ30COQdqu496k5b9b6dup5GG6g3f6WN0+rKHMA=
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr4199414wme.122.1535555584677;
 Wed, 29 Aug 2018 08:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
 <20180829135440.GA25381@kernel.org>
In-Reply-To: <20180829135440.GA25381@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 29 Aug 2018 08:14:12 -0700
Message-ID: <CABPqkBQ1iTg3bkovUykg86r0kj6jaVbb_f=BCVHrLN+=S5jVZQ@mail.gmail.com>
Subject: Re: [RFC] perf script: callchain handling is not useful
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 6:54 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Aug 28, 2018 at 07:41:31PM -0700, Stephane Eranian escreveu:
> > Hi,
> >
> > I am doing the following simple collection with callchain and load profiling:
> >
> > $ perf record -g -d -e cpu/event=0xd0,umask=0x81/pp  my_test_program
> >
> > But when I type:
> > $ perf script -F ip,addr
> > ffff9d4821346878
> >         ffffffff9d58df25
> >         ffffffff9d58e054
> >         ffffffff9d5965bb
> >         ffffffff9d640650
> >         ffffffff9d697d06
> >         ffffffff9d63ec60
> >         ffffffff9d640322
> >         ffffffff9d64070c
> >         ffffffff9d455a60
> >                   7030c7
> >
> > ffff9d4638ba84a0
> >         ffffffff9d5df447
> >         ffffffff9d5eaf4a
> >         ffffffff9d63e165
> >         ffffffff9d63e439
> >         ffffffff9d697d98
> >         ffffffff9d63ec60
> >         ffffffff9d640322
> >         ffffffff9d64070c
> >         ffffffff9d455a60
> >                   7030c7
> > I also see the callchain and it is not clear which is the IP. Further
> > more parsing becomes more difficult because of multiple lines per
> > sample. I understand that multiline is likely because of
> > symbolization. But if I don't want symbolization, it should be
> > possible to print all in one line.
>
> Humm, to have this not break possibly existing scripts, perhaps we can
> have something like:
>
>   $ perf script -F ip,-callchain,addr
>
> ?
>
> And if asked explicitely for the callchain, then it gets added in the
> same line?
>
Yeah, that should do it.
Thanks.

> - Arnaldo
>
>
> > The current output is not very useful. You expect perf script to give
> > you one line per sample and only what you want. Callchain != IP.
> >
> > I think the following should happen:
> >   - do not print callchain when asked for the IP. Create a callchain filter.
> >   - print callchain on the same line, much like what is done for brstack
> >
> > It is not clear to me why callchain and ip were lumped together.
> > Any opinion on my proposal?
> > Thanks.

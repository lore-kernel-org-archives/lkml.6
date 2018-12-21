Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C214DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C33821928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qmq3G1dB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbeLUUCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:02:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35774 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389059AbeLUUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:02:08 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so4736100lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bol/EtSNZ1pGgBcscr2+UR5k7YT/e9qr896uQYhWbMo=;
        b=Qmq3G1dBQIodXUmikCIhNNdJnHXrNFig/BVwuSNeKv8/LOeQY0IGrebh1yEugqtC3p
         3HLkBR4ng1uzJXHkCjHeZgh13SB/w7cWbY0EL5WgIXP74c1BB+0jQ33rsFeKPsIDot2G
         VBe4isoeUjdwQJcdaMabBMScVRS67FI3j51yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bol/EtSNZ1pGgBcscr2+UR5k7YT/e9qr896uQYhWbMo=;
        b=AjMaEOedNj6Z5cqXkOQvrFkH9qnw74RvWE+zFkx/T3CsCZ3DfYtP+eYSyBV3Qt/uhb
         xNmgMW2lcs5eXSxGIadsCDnYHKQLJD5B7C2J5P2Ugkc3GnAEka3XkzYH8RAG2AGNTWbo
         Hhe49d948G7ScqZmRxRUJujLwtrRAU66A3Ao2Of/hzcdt2LiXQG3liYErB9XDN42egVs
         Ced/Ma8emdosyDE3oEpppmlqtXiW1uBXISrjUcfdg7mDUNfK5EptwVEmdJ8eDXHcyD9o
         cAMP7eiG4iIel05raCg5bCDCwQ1VFoqhnLbcAWbQiy0P65oVbKVMh0a93nfWLxmB4lYP
         mY3g==
X-Gm-Message-State: AA+aEWYxQY7+zO4rRMuyuJdl6BxlAsAW1x2M2IKZ27ao2AsmWlbTO+rO
        BbppGhW2jGZBQVVtKftKGsref0Iuyj4=
X-Google-Smtp-Source: AFSGD/VW2b2p0Vm2qlmshddDmeSLbn8TTWBTmlekXEhcu/65CBPWi/K142bbtYZtyxdYLvSzW6DpSg==
X-Received: by 2002:a19:5059:: with SMTP id z25mr2159872lfj.120.1545422525884;
        Fri, 21 Dec 2018 12:02:05 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 15-v6sm5482576lje.18.2018.12.21.12.02.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 12:02:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id q2-v6so5761922lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 12:02:04 -0800 (PST)
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr2347484lja.148.1545422524178;
 Fri, 21 Dec 2018 12:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20181221175618.968519903@goodmis.org> <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com> <20181221144054.20bdeb33@gandalf.local.home>
In-Reply-To: <20181221144054.20bdeb33@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 12:01:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
Message-ID: <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:40 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> OK, what about if we just use strlen() and say that this macro is not
> safe for parameters with side effects.

I think gcc follows simple assignments just fine, and does the
optimized strlen() for them too.

So why not just do

   #define have_prefix(str,prefix) ({ \
        const char *__pfx = prefix; \
        size_t __pfxlen = strlen(__pfx); \
        strncmp(str, __pfx, __pfxlen) ? 0 : __pfxlen); })

and be done with it safely?

The above is ENTIRELY untested.

      Linus

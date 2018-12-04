Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B090206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJDIZrSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B090206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbeLDTeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:34:25 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32778 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:34:24 -0500
Received: by mail-yb1-f196.google.com with SMTP id f125so2616251ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1NIxcvk+5AFzgbsHZc73ZPCu1R9fyAveUbRPuyWU1Q=;
        b=HJDIZrSsR8+cB+eJxgq9K3WS3iocAgz9teSga4gMdwUnTxG2uub0niriPVyGehWq1M
         pCx+FzxMfXN6vWdDpGb0DiXQAugaDcGAt88830qdXcaBDtdiXs7/Xu0BRxct0+BjqXiQ
         o5rjTJNLv30ULCOE7zK+jaA8PQ7+va1SiwDuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1NIxcvk+5AFzgbsHZc73ZPCu1R9fyAveUbRPuyWU1Q=;
        b=tKvZ6vpwXS0LD8FJ9kHbBtfAs7eszJm8zP5Jays0pTeX7Ca7dnFcJiMcsFEDT5kcPP
         JdNBMvIzmMGGip8EUo5/2YvyAd1zliyP4Y6rssBDk8ZogLgS2WghOtoZ+/kWTrTOl8M6
         AeE5d1g5yygvExCn5NxJAMUtm5o34+M/Y28XZosYmKc+PurePWoTfSWVGfM4tAVWBLo3
         TQO8nuNV4i2pKMCZ1d6HS/r/VUPXVMX7y2pFuKgv8LeyZLtVh71c8mIfzHsNvalbNBzW
         t4HwDja0pOXnnRg3Sq+jrqCRpyc1SIuqGHVtA6ajYh0fH2yKuHFDN48UrjCU9H1fyoJQ
         OATA==
X-Gm-Message-State: AA+aEWZ5XbjaC9TAdYtsTpaW/1+0t9SbKoYD5XLt8+FSni7nxTS8Q3vQ
        JYwuza5403tdsb8U+Spk7iJwWZiocM9WXkIvY9ggIw==
X-Google-Smtp-Source: AFSGD/X86gGQs4FVxgdf1qPKKOMfnf871bCehwhOPV9NbCQCXMTVCtFm/GczHTTBTB3ptR+qOD/4dyvsSWOh1dDOj78=
X-Received: by 2002:a25:2157:: with SMTP id h84-v6mr19869453ybh.198.1543952063778;
 Tue, 04 Dec 2018 11:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20181204191229.6851-1-anders.roxell@linaro.org>
 <20181204141908.76e7afa5@vmware.local.home> <20181204142142.4e2e2169@vmware.local.home>
 <CADYN=9LNunVkSTzg1fri7Mu7mbu8gFPpgnFfCRQk4T61JXt1_A@mail.gmail.com> <20181204142918.12c087b4@vmware.local.home>
In-Reply-To: <20181204142918.12c087b4@vmware.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 4 Dec 2018 20:34:12 +0100
Message-ID: <CADYN=9LiHspkqWHho6UqD=AEznZ4McgExQoAWttNmWzh-NBh-g@mail.gmail.com>
Subject: Re: [PATCH] tracing: add cond_resched to ftrace_replace_code()
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 at 20:29, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 4 Dec 2018 20:25:31 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > On Tue, 4 Dec 2018 at 20:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Tue, 4 Dec 2018 14:19:08 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > > @@ -2435,6 +2438,13 @@ void __weak ftrace_replace_code(int enable)
> > > > >                     /* Stop processing */
> > > > >                     return;
> > > > >             }
> > > > > +           /*
> > > > > +            * Some archs calls this function with interrupts or preemption
> > > > > +            * disabled. Howeve, other archs don't and this can cause a
> > >
> > > typo "However". But could you write it this way:
> > >
> > >         "However, for other archs that can preempt, this can cause an
> > >         tremendous unneeded latency."
> > >
> >
> > I'll fix this and move it up (where I added it in the first place but
> > moved it) =)
> >
>
> I also noticed a grammar issue:
>
>         "Some archs call this function .."

I will fix that.

Cheers,
Anders

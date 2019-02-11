Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D39C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E932054F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UCZx8vY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfBKVtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:49:43 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35941 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfBKVtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:49:42 -0500
Received: by mail-vs1-f68.google.com with SMTP id t13so313979vsk.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5rf+/eqHbmSMwpO4FWY3tDIWfljvRtfFAuOxBx/Tks=;
        b=UCZx8vY2w2+SvXZT1qU1UbjVCP2tUG0SODhNSpvW7TJ+Ga009ynw+4pvpzGbqcYIZQ
         54ywBKdehMw1qlWSz43SybC9xgyq3ErNJdE6vXAyw7R01ObeJPQzBvLh8pSJs3j9r7KI
         7iwLXWE845Zxh+ScfRLMsfrWJzkA97nv8BPMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5rf+/eqHbmSMwpO4FWY3tDIWfljvRtfFAuOxBx/Tks=;
        b=D/cP/Lzf5Z9iGzjD7UNvfjW3C5oq/8Tz5gSVj7cdheQi7jmYpxl4BnkKeIx3AOhsRH
         t7xCZ60igOqvKqyDdYloTjhydK4xAFGi3cUzBurfylFVLERhIXMTI9YbcQNBbPCraIzq
         UAjM+38IMQvYoSvsVWojNX2WLNoUEH/gOAQPzVN/gxVvO2oY6ScC2YY/znt2z3dClJnW
         ThmYM1OJKnoh3IRU4+GAghyrkWu0X84Mxtuc2JOfHfedluiP+Bzl6XeDkFoM8pE06mVW
         cXHxzx0iUtDtnhl6eWIxP/X8Ww0BJkCTUbkCiI8A6CKfkNRoBDdHEWCEOdocEJy9gSz7
         ynfg==
X-Gm-Message-State: AHQUAuaNZ9zsSzJBUmI5jDIM1CDxUP8o7MkNX4p2e2Ic4UDO8/QXketr
        wHTOX4nus4P55Y4CAA8FHT/28KKrZRI=
X-Google-Smtp-Source: AHgI3Ibalc9Vcg1LPlwDVGz+7MyzznUHkpQn9uYhrJ2c5L9UxKyflj0rjG35++DtnYT2pL/wyiLFAQ==
X-Received: by 2002:a67:1505:: with SMTP id 5mr188652vsv.20.1549921780643;
        Mon, 11 Feb 2019 13:49:40 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id k77sm3007780vkd.17.2019.02.11.13.49.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:49:39 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id j8so148294uae.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:49:38 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr173427uan.114.1549921778407;
 Mon, 11 Feb 2019 13:49:38 -0800 (PST)
MIME-Version: 1.0
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
 <20190201172150.GA1853@linux.vnet.ibm.com> <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
 <CAGXu5jJdeQ5DOZj_nPkWWBn8y0fRg2UEUGhd_seHL=KmKJey2g@mail.gmail.com>
 <20190211152725.65d0ed18@gandalf.local.home> <20190211152842.6a2a7794@gandalf.local.home>
In-Reply-To: <20190211152842.6a2a7794@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 11 Feb 2019 13:49:27 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKgqHyji+W5coyeMmO7wQpJ_mxHK9Rga4UD=65kFavMEQ@mail.gmail.com>
Message-ID: <CAGXu5jKgqHyji+W5coyeMmO7wQpJ_mxHK9Rga4UD=65kFavMEQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: convert uprobe.ref to refcount_t
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 12:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 11 Feb 2019 15:27:25 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 11 Feb 2019 12:21:32 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
> > > > > Looks good to me.
> > > > >
> > > > > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > >
> > > > Thank you very much Srikar!
> > > > Would you be able to take this patch to integration?
> > >
> > > Steve can you pick this up with Srikar's Reviewed-by?
> >
> > Yep. And I'll also add Oleg's acked-by. (Currently doing my "urgent"
> > patches now).
> >
>
> Or is this something that can wait till the next merge window?

I wouldn't classify the change as _urgent_, no. For "next merge
window" you mean v5.1, I assume? I think that'd be fine unless Elena
sees something I don't.

Thanks!

-- 
Kees Cook

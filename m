Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B75C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133CD20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwbEdnhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfAQQmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:42:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43796 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfAQQmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:42:15 -0500
Received: by mail-vs1-f65.google.com with SMTP id x1so6598312vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXkoDMAo1l9x1KFS7DJ3BAbq5tPoK01h54+Ce8Z3KbE=;
        b=iwbEdnhuzPXZUpKFZ+sPF44s4397qHQU04zlI3DUoP5Xv4gXqQsHZDSa2iFztJr5G3
         mxRx/LUznf98r21D/Qktoz3Tr9g1i4y3jVb9LOQCGneAS9VU2nsvvghZRpf4yi1AZjmV
         lKVnJ7D1CGeSRR4afXWP4lzpzm3gytuKmDZro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXkoDMAo1l9x1KFS7DJ3BAbq5tPoK01h54+Ce8Z3KbE=;
        b=RciKMHCgYy3qD6GGRzcRTDh4hcdo0zTz6YDwKrq0Zbe8NsuDPTd7tBDyD394tl39b1
         2uMsA1Xd4Ca3URGIEOf4ne31kVB8N9uey/CBWN40YtuIFdXNtfWuNHu6nroKUGRqelXH
         Qu8VfU3rIjjFNEtppZw0APQZ0LVY8znWYXHAKosmIQ9yxKPTsqktStn5kZZkIrvzO95U
         X8hcmCUfMvvLrUdG/++AEjQBB5W8Qev/F7UF/JZ0C20xnFhGIu7fLR6jcGWSalPJZN6y
         QUaOnnNTblCnmfrz6T3HPos76sXsIRmUd0QlJmBgCDKGYerXGrpJPT+X5f6cq4BKOQyq
         OEZA==
X-Gm-Message-State: AJcUukeNTE/hwMjvOatbf5SZ23D09uxBTmsXJdpIIDbc4SQwEkitvxXG
        jGMi8ZKB/5h2F60M64MoGZYfY1u9l3U=
X-Google-Smtp-Source: ALg8bN4cV1wwilsoyw8LYS41fapri6/BVHFPFUTI+gKP8LdC2DOWwDw9yKehzhsVHqgu714KF2lQHA==
X-Received: by 2002:a67:a8da:: with SMTP id h87mr6565732vsi.143.1547743333395;
        Thu, 17 Jan 2019 08:42:13 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a137sm3112122vsd.24.2019.01.17.08.42.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:42:12 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id h78so6612955vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:42:11 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr6392973vsc.48.1547743331296;
 Thu, 17 Jan 2019 08:42:11 -0800 (PST)
MIME-Version: 1.0
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com>
 <20190117004416.GA17449@cisco> <f665bb74-293b-d627-2605-5b8de7671743@kernel.org>
 <CAGXu5jJ0VK4UiOeKTqv_TZSn5aZAVsXjUZgiXD=KFbZ-Ng_+KQ@mail.gmail.com> <20190117162703.GC17449@cisco>
In-Reply-To: <20190117162703.GC17449@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 08:41:59 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJOGO1UWdYdGmnnUEZOm-DaMUqR3UVSi+gnSc7q3KE8xA@mail.gmail.com>
Message-ID: <CAGXu5jJOGO1UWdYdGmnnUEZOm-DaMUqR3UVSi+gnSc7q3KE8xA@mail.gmail.com>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     shuah <shuah@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 8:27 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Thu, Jan 17, 2019 at 08:12:50AM -0800, Kees Cook wrote:
> > On Wed, Jan 16, 2019 at 5:26 PM shuah <shuah@kernel.org> wrote:
> > > I am running Linux 5.0-rc2 and not an older kernel.
> >
> > Weird. I couldn't reproduce this on 5.0-rc2, but I did see it on a
> > kernel without seccomp user_notif. Does the patch I sent fix it for
> > you? (And if so, can you take it in your tree?)
>
> I can reproduce it; you have to run it as non-root. I think your patch
> is necessary to get it to at least fail. The question is: what should
> we do about these tests that require real root? Skip them if we're not
> real-root, I guess?

Hm, maybe use the XFAIL() bit of the harness?

Perhaps it's time to make it a root-only test and do internal
priv-dropping to test the nnp-requiring parts? I'll add it to the TODO
list...

-Kees

-- 
Kees Cook

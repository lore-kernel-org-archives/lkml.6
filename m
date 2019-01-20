Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D91C6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22DD20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 13:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovui++He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfATNam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 08:30:42 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54608 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfATNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 08:30:41 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so13104455ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 05:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvPxZxbejLIRpkWpPkQpCpqx55TaTGMUbFyDQUcQOH4=;
        b=ovui++HeQkza1NtzXxbxEEAuR9Kl+GYoJUXLn6Pkezrl/6olxG0GM9Emt9KnAMstkh
         m0mPlxWguzJ9f5G8d2dFTHSmm4eiWCItwxFYnaKj9DWy2UUBbNPS8feoqCI29CMaMmKD
         ZV7/XOXDTcd4pruN7Kj6IgSETHHYqCS3/SYmC1pDYTVz9yY1RnWg/mjThwG7G6D++LkC
         Q2xuRx/A5p94WPyY219D3+J4yl1qKgJJSryZSo4HoqK9YnIgWpiKLyuvSkbouA1oIFHf
         WQ4yrQZ12I+Lq57gScP1Fou22oHFv+c3pxtPeLbxhjAYZceYyXBQsHqT+c+kO23+KGkz
         srjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvPxZxbejLIRpkWpPkQpCpqx55TaTGMUbFyDQUcQOH4=;
        b=fl3az3BLk22O1JsROjCoMsePK3VyXV775Kh4ARyFkiloqohFWnVd3w2/H0tKXTuNyH
         FUcmDS/LLAp/R8rwta008FWgPEEmQ+yVHbHv7ifQByBvrvfvHVzqNv1mUxZohMDSzxky
         XYoWmk0AFxzwVNL5SwAiIrlerlG3WwLx65JFD8bbRVdujTymRtD2PSOHvE6sblyEeAaK
         TdGf5elX8MWTPW1mhc2GDVzu0/N/rWyc4AopsomXFueGcfaiDJQDUmhGhAunKGXWRxvv
         2nudlhWqyX7rNIY20zY1/v8+eqsC0pgchzyi5pHOy5dC0stXu4j6CkrhAn8NgnBEleiB
         ++bQ==
X-Gm-Message-State: AJcUukfe3uRU8lgzQ2PKYwRMmG083micjBn9B9YWrT3wsUGcswUMGBOG
        /3OC5izEyJHUBLSAt+tnYztsIARVTZguFsOi5l1GOA==
X-Google-Smtp-Source: ALg8bN4Y567V5el6qPj6tMuVjN9+Yf2lTkOzSiNd3H/zVUMmXK/cv9wDbxp2/voSuypeGaZjJ0OMecXqt6RgliDFKL0=
X-Received: by 2002:a02:97a2:: with SMTP id s31mr14655398jaj.82.1547991040336;
 Sun, 20 Jan 2019 05:30:40 -0800 (PST)
MIME-Version: 1.0
References: <ea2bc542-38b2-8218-9eb7-4c4a05da36ea@i-love.sakura.ne.jp>
 <CACT4Y+Yy-bF07F7F8DoFY8=4LtLURRn1WsZzNZ9LN+N=vn7Tpw@mail.gmail.com>
 <201901180520.x0I5KYTi096127@www262.sakura.ne.jp> <CACT4Y+acvQXPLHFSbNYAEma6Rqx6QCp_kqjsbAF8M9og4KA3CA@mail.gmail.com>
 <d90cc533-607e-fe40-9b02-a6cac7b7b534@i-love.sakura.ne.jp>
In-Reply-To: <d90cc533-607e-fe40-9b02-a6cac7b7b534@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 20 Jan 2019 14:30:29 +0100
Message-ID: <CACT4Y+b=5_p=eTgKobApkZZTAVeRxrn3dEempFHampFjrGX0Pw@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in ndisc_alloc_skb
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+ea7d9cb314b4ab49a18a@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Linux-MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 2:10 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/19 21:16, Dmitry Vyukov wrote:
> >> The question for me is, whether sysbot can detect hash collision with different
> >> syz-program lines before writing the hash value to /dev/kmsg, and retry by modifying
> >> syz-program lines in order to get a new hash value until collision is avoided.
> >> If it is difficult, simpler choice like current Unix time and PID could be used
> >> instead...
> >
> > Hummm, say, if you run syz-manager locally and report a bug, where
> > will the webserver and database that allows to download all satellite
> > info work? How long you need to keep this info and provide the web
> > service? You will also need to pay and maintain the server for... how
> > long? I don't see how this can work and how we can ask people to do
> > this. This frankly looks like overly complex solution to a problem
> > were simpler solutions will work. Keeping all info in a self-contained
> > file looks like the only option to make it work reliably.
> > It's also not possible to attribute kernel output to individual programs.
>
> The first messages I want to look at is kernel output. Then, I look at
> syz-program lines as needed. But current "a self-contained file" is
> hard to find kernel output.

I think everybody looks at kernel crash first, that's why we provide
kernel crash inline in the email so it's super easy to find. One does
not need to look at console output at all to read the crash message.
Console output is meant for more complex cases when a developer needs
to extract some long tail of custom information. We don't know what
exactly information a developer is looking for and it is different in
each case, so it's not possible to optimize for this. We preserve
console output intact to not destroy some potentially important
information. Say, if we start reordering messages, we lose timing
information and timing/interleaving information is important in some
cases.

> Even if we keep both kernel output and
> syz-program lines in a single file, we can improve readability by
> splitting into kernel output section and syz-program section.
>
>   # Kernel output section start
>   [$(uptime)][$(caller_info)] executing program #0123456789abcdef0123456789abcdef
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] executing program #456789abcdef0123456789abcdef0123
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] executing program #89abcdef0123456789abcdef01234567
>   [$(uptime)][$(caller_info)] $(kernel_messages_caused_by_89abcdef0123456789abcdef01234567_456789abcdef0123456789abcdef0123_and_0123456789abcdef0123456789abcdef_are_here)
>   [$(uptime)][$(caller_info)] BUG: unable to handle kernel paging request at $(address)
>   [$(uptime)][$(caller_info)] CPU: $(cpu) PID: $(pid) Comm: syz#89abcdef0123 Not tainted $(version) #$(build)
>   [$(uptime)][$(caller_info)] $(backtrace_of_caller_info_is_here)
>   [$(uptime)][$(caller_info)] Kernel panic - not syncing: Fatal exception
>   # Kernel output section end
>   # syzbot code section start
>   Program for #0123456789abcdef0123456789abcdef
>   $(program_lines_for_0123456789abcdef0123456789abcdef_is_here)
>   Program for #456789abcdef0123456789abcdef0123
>   $(program_lines_for_456789abcdef0123456789abcdef0123_is_here)
>   Program for #89abcdef0123456789abcdef01234567
>   $(program_lines_for_89abcdef0123456789abcdef01234567_is_here)
>   # syzbot code section end
>

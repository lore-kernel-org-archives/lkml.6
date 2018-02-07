Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-29863-1518014125-2-14109602049185372531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518014123; b=MOIGTGP7gYnNu3VhCkl1z3W3ayu3pt9pnIfArZmpS3tLnOz
    EJ9GfPqZAeIrSAOjec+3k0tCvM3caC5v1HVKBhDOvjA3/KSN95CG5Ua9mvyFxb1J
    q20ImdpA8EPtS/9MsS0hguYBMKpruFcCzzJu/eIRa+a+HonKqfcnhbbyTQzEr0YO
    jZlGXujCbJ+DE34qBM+iJIfu5jncbOOqWNF2FPsnpc3kvcMCgvr4mySITZYxxsHx
    /hSet3v4dQ9DskMHsYUUP8++aaluaZ91jB4xRlfHGpIpdkeM+EN/6BNgnXlhrH3s
    Yd6Hopq9SOB1A+JYYiDdVcnXpo+m6TphPjofMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518014123; bh=dP4igDN6ihRXMWk89iQeftfzZ9ATFMrrzhYMEB
    7mglI=; b=I09RMCB0Pmf5vsLP7oNRQiXzRxS7cCHhyTi0XvDkJx1tuGDWsOCtvY
    6If7/+dN2VZcP9umZfnJYTA4b0dmKGAaAJUojPXJYOR09kwntxsqn4uW6hYyimYh
    /6c4TK7x7vlNzLqqcFE73lIHC1HPrJEIfwH7K3ZBNj4BqX0CNQuwwcP5bQWtzP9v
    9i0TP2t5PbniT4A1B06WJjuzD69je7ALCbE0LJBs2R/WHr292LCzdmB84wfU5wNM
    cpMG0nXZfAGrQxt70ZhyyA295vdyKke2ki66O69J/DkR4iRq+AHHtm0gbTi5PlI5
    ooksAAFGiw2sDYktae7jVhlqJK5x6tZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WmTHWxXV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QO81yvXn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WmTHWxXV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QO81yvXn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbeBGOfW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 09:35:22 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34973 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbeBGOfV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 09:35:21 -0500
X-Google-Smtp-Source: AH8x2254NV57jHksOB7ndG5p8iU+EAHY68PmLWDvUoCBGTiESWpsP6Dq+RncduZQQ6a+gNOU9MajafQ3l0PVGH0dO6s=
MIME-Version: 1.0
In-Reply-To: <20180206224541.082571667@goodmis.org>
References: <20180206224338.446477232@goodmis.org> <20180206224541.082571667@goodmis.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 7 Feb 2018 14:35:00 +0000
Message-ID: <CAJwJo6ZQ7cMrWfVJ_dJsXmtDohMq6FwSC60Qy9WZX8MNVrUpzA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/6] ftrace: Remove incorrect setting of glob search field
To: Steven Rostedt <rostedt@goodmis.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-06 22:43 GMT+00:00 Steven Rostedt <rostedt@goodmis.org>:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> __unregister_ftrace_function_probe() will incorrectly parse the glob filter
> because it resets the search variable that was setup by filter_parse_regex().
>
> Al Viro reported this:
>
>     After that call of filter_parse_regex() we could have func_g.search not
>     equal to glob only if glob started with '!' or '*'.  In the former case
>     we would've buggered off with -EINVAL (not = 1).  In the latter we
>     would've set func_g.search equal to glob + 1, calculated the length of
>     that thing in func_g.len and proceeded to reset func_g.search back to
>     glob.
>
>     Suppose the glob is e.g. *foo*.  We end up with
>             func_g.type = MATCH_MIDDLE_ONLY;
>             func_g.len = 3;
>             func_g.search = "*foo";
>     Feeding that to ftrace_match_record() will not do anything sane - we
>     will be looking for names containing "*foo" (->len is ignored for that
>     one).
>
> Link: http://lkml.kernel.org/r/20180127031706.GE13338@ZenIV.linux.org.uk
>
> Cc: stable@vger.kernel.org
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Fixes: 3ba009297149f ("ftrace: Introduce ftrace_glob structure")
> Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>
Thank you, Steven.

-- 
             Dmitry

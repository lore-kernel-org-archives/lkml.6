Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E10EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B6920659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Yn9TWYXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B6920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbeKTEpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:45:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40144 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbeKTEpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:45:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so1959847pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cetOeM3wNE+xbTkSnfOy05RV8vvE0VAiYl8MZym5BT8=;
        b=Yn9TWYXGlwx6yJ6chj1YMJ/mJSLXfbvvEvL3JRCFf6Ul9ygDyYa9s9BJpXwf3avJfj
         tAzQz0DRWRnhKefy9/tiw7rTbVdUEfJeS/X3zgiOOQQ1un/y5Oeu03ErOvoePn5oCPNN
         6rTf52+Wc/yc9JjSL8ZYO3A0S3b8iFK2LWbOtUnDYOuyVZ4JKBoqnoEDvR5QCJlk7Ob9
         WznPiEX7fl5/QlqgjTRnh3RjpnwkXr1RJaIeHdTyX4ZlsHu+ycSzhORl8VQp11kmQkM/
         YLX7KukI3VR6Agt7/i3znGfK3jV0HOwq6XQl+2u/LYfsPUdhHm8YrsaZwZbR3WtD2uHI
         GVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cetOeM3wNE+xbTkSnfOy05RV8vvE0VAiYl8MZym5BT8=;
        b=FMZtFn6ifqLj2kIKFCfdXf45RhQq9RJmzyz2zLKzLVL04hBXb1exOElTgFwwWR48lJ
         vI1w8aphfRYRjcidvAtZFQDIzBv64LUVw3Y5CY2DKmHbGBwRX88pvnSs4Sb9ZPFZhD8a
         KIs0pXthZXw7pyHzyE1iqotr4iwrgm8fup3cfCgUMEvclslpPue5/j+Het9GKLQN/rwB
         tjnNoCS/TNYj+dd/bk1+9IVqN6QQ4C+wMJZdROvXL13iRP/uFfQ0HNIRUiPpMPgAabx+
         pFYoebf3ncy4yPPy/HSXK0t53hBd26LoYm5XwkqztKd+Z+sHYSuUPlyRIdziBG+mq/+c
         YJ4w==
X-Gm-Message-State: AGRZ1gJBJOmUs2zF9s3WfA5Mfwt0a6flQGRVbuQPOi+3Ae/YJ0Knf2y5
        9JJfHzGomwsMDI+dVjTNwBU5Zg==
X-Google-Smtp-Source: AJdET5ddScElbCtO2I0DpRkSkYTrQrgp3BV3J6vvvpYm4VdG7S5ucn06by1DjDZOIrKE8c8OtOrgPA==
X-Received: by 2002:a62:995c:: with SMTP id d89-v6mr23838079pfe.11.1542651652808;
        Mon, 19 Nov 2018 10:20:52 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id v89sm8814419pfk.12.2018.11.19.10.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:20:51 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:20:43 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 1/2] proc: get process file descriptor from /proc/<pid>
Message-ID: <20181119182038.27obrbpxp54rhfxt@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-2-christian@brauner.io>
 <CALCETrVvHu2dSJs1dpA-2ozGhZGxbGrnYbUuh98rkCdsz42rfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVvHu2dSJs1dpA-2ozGhZGxbGrnYbUuh98rkCdsz42rfg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:32:33AM -0800, Andy Lutomirski wrote:
> On Mon, Nov 19, 2018 at 2:33 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > With this patch an open() call on /proc/<pid> will give userspace a handle
> > to struct pid of the process associated with /proc/<pid>. This allows to
> > maintain a stable handle on a process.
> > I have been discussing various approaches extensively during technical
> > conferences this year culminating in a long argument with Eric at Linux
> > Plumbers. The general consensus was that having a handle on a process
> > should be something that is very simple and easy to maintain with the
> > option of being extensible via a more advanced api if the need arises. I
> > believe that this patch is the most simple, dumb, and therefore
> > maintainable solution.
> 
> How does the mechanism you're adding here differ from proc_pid()?

I'm sorry, I am missing the context around proc_pid()?. Are you talking
about the the proc_pid() function in "internal.h"? What exactly is the
proc_pid() mechanism?

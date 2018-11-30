Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2235B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNA8vZbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2235B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeLADpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:32820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbeLADpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:45:52 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84636214C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543595759;
        bh=4Gac/Vhr2TC3XRK5vvjmEJW6+Ymq3jRJY1l0TE4OGQE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNA8vZbONlpPsLbIejimZ3mdYbXqWHekUsW0E69IsZOz6vmYzUvZCavKEkwgCVUTC
         Nns+tlX1FmCIsVx1twEmyhu3sJvMoDHOyDG2XXsY1jvUFh4csOUE1VYRqVnVlxWcEt
         mxYKyikHsVsv+vl3s2lEKJxrC+lSucMjF7eKnWUg=
Received: by mail-wr1-f54.google.com with SMTP id x10so5874289wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:35:59 -0800 (PST)
X-Gm-Message-State: AA+aEWaDRNltB1pac1vrvhbIptq7+B+lCi3s5Y7A2td48LmtMqpjyepO
        IDezaf6DTSeeXAfJ7Udg5iTM1sZLLkNtY0oH6C2Y5g==
X-Google-Smtp-Source: AFSGD/WAXIxJuwgMScXUJij0Os0AawoUXSwMEqu+LAro7x9Wf/70L80mjEU24nvMG7y7D6cFZeUDx08Ay3cD8dPOFBc=
X-Received: by 2002:adf:8323:: with SMTP id 32mr5328377wrd.176.1543595757875;
 Fri, 30 Nov 2018 08:35:57 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com>
 <87y39b2lm2.fsf@xmission.com> <20181130065606.kmilbbq46oeycjp5@brauner.io> <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0kqPii5TwFAo_JHLX=o_FDMFVKXxgzzbDjLFZ7OQ5QCQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 30 Nov 2018 08:35:45 -0800
X-Gmail-Original-Message-ID: <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
Message-ID: <CALCETrW2aphWwEY4=hUwo_JBCvkQyMjxzxGd9FCW017kMLaMOQ@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> siginfo_t as it is now still has a number of other downsides, and Andy in
> particular didn't like the idea of having three new variants on x86
> (depending on how you count). His alternative suggestion of having
> a single syscall entry point that takes a 'signfo_t __user *' but interprets
> it as compat_siginfo depending on in_compat_syscall()/in_x32_syscall()
> should work correctly, but feels wrong to me, or at least inconsistent
> with how we do this elsewhere.

If everyone else is okay with it, I can get on board with three
variants on x86.  What I can't get on board with is *five* variants on
x86, which would be:

procfd_signal via int80 / the 32-bit vDSO: the ia32 structure

syscall64 with nr == 335 (presumably): 64-bit

syscall64 with nr == 548 | 0x40000000: x32

syscall64 with nr == 548: 64-bit entry but in_compat_syscall() ==
true, behavior is arbitrary

syscall64 with nr == 335 | 0x40000000: x32 entry, but
in_compat_syscall() == false, behavior is arbitrary

This mess isn't really Christian's fault -- it's been there for a
while, but it's awful and I don't think we want to perpetuate it.

Obviously, I'd prefer a variant where the structure that's passed in
is always the same.

BTW, do we consider siginfo_t to be extensible?  If so, and if we pass
in a pointer, presumably we should pass a length as well.

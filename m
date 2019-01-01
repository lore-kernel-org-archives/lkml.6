Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21842C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E008221019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 21:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eRvmYGLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfAAVJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 16:09:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfAAVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 16:09:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so25639678lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1smFcJyY+sRLjSvnuWeB9fT9Kf3K1Xevdi2qg89Cpg=;
        b=eRvmYGLHGAKsvul25tTOCU2Zg0PuKiLwpkQJ9JJhJfTpTsM8Gw8Wp0XspIw5Q9+I+p
         BJnuYwuWHb3R8/yZ73WCBYSJha0aJUMzvda0jIllRPf0kfzE+QwBaO9hYSBqe/kP47Ty
         SZAEtqeqM0Ok1u1XV9lbsnnK9w++pIvq3L3oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1smFcJyY+sRLjSvnuWeB9fT9Kf3K1Xevdi2qg89Cpg=;
        b=nkl/+K6QBymJguow5UANPRIHcswMFkuN3wWuMmb7jfCgCjfWUOj/z4qQ7xq+krjufi
         enO9UCht4XCwjsVr0145ES+fXkLXgQM7RUokmsT05D09Av/Dsca1gJjy3OsLv4B706wU
         SRqYVhqOjcinJXGcVNHBg633fkUcVEH3uv3vXxYVdQtW+gCq5KZrdUHrka5fSAreD153
         cHXUykTuv/oxKHStLCZY5U+4EFRYTR6dOnukvfTG6MOELjBktw4y9M+eyphWQBMi5CwK
         N8E+A3aEq6mAhjdLizV9gtSfbKj9KEbg8oY47/XgreGa7viakEC1FmqaQvsfD6ApLZ+0
         TsTQ==
X-Gm-Message-State: AJcUukcXdFV45NG051jeI692zEy4flkoTs6M0LKCjcv3IPIcxIXjOtzO
        nCaKO+upwyLrZbJVbPAOZJXKTAlK8dE=
X-Google-Smtp-Source: ALg8bN7HuscRdkslFZupeZ51mSb6TBWdfpxHEB+Njj1+wUHzWLkrfNDdju4hmBIPa6wB/woOoX16vA==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr25835140lji.101.1546376939235;
        Tue, 01 Jan 2019 13:08:59 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x21sm9916136lfe.6.2019.01.01.13.08.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 13:08:57 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id v15-v6so25634208ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 13:08:57 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2630250ljh.59.1546376937148;
 Tue, 01 Jan 2019 13:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com>
 <CAHk-=wgGYebCEE-M-6Dnbn5MpC8BD8SLjgw8iPGrgy8zETrdJg@mail.gmail.com>
 <1545076260.2878.15.camel@HansenPartnership.com> <CAHk-=wjPhKNKRq24wXL3wvqUgfyriDjYNXUPCumbH=64ZMXrSw@mail.gmail.com>
 <20181231224530.GA12425@zzz.localdomain>
In-Reply-To: <20181231224530.GA12425@zzz.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Jan 2019 13:08:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whb31a-4-ac6iBM-2tDMb9cEHogU788ASpfw+Uk+DAM+w@mail.gmail.com>
Message-ID: <CAHk-=whb31a-4-ac6iBM-2tDMb9cEHogU788ASpfw+Uk+DAM+w@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 2:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> KEYCTL_PKEY_QUERY is still failing basic fuzzing even after Linus' fix that
> changed Opt_err from -1 to 0.  The crash is still in keyctl_pkey_params_parse():
>
>                 token = match_token(p, param_keys, args);
>                 if (__test_and_set_bit(token, &token_mask))
>                         return -EINVAL;
>                 q = args[0].from;
>                 if (!q[0])
>                         return -EINVAL;
>
> Now it crashes on '!q[0]' because 'args[0].from' is uninitialized when
> token == Opt_err.  args[0] is only initialized when the parsed token had a
> pattern that set it.

Argh., how embarrassing. And it turns out that James' suggestion to
initialize token_mask would actually have fixed that, for subtle
reasons (but subtle was what I didn't want).

I detest that match_token() interface, but this key code then mis-uses
it in ways it wasn't even meant for, and tries to "share" error paths
that aren't actually common.

I'll take your original patch, which I clearly should have done originally.

Thanks, and sorry for the wasted time,

             Linus

Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC23E20657
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b9ArRGaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAISkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:40:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41296 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfAISkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:40:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so7356561ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijLjzSJxS/pQbS2F8YiBTgk5YasRsnLXVntteEFabhQ=;
        b=b9ArRGaV2Md7/SGhcFEPseIerUHGGPx9JoD7t5CeNYe2qvKwJWjbtQj+ouwz2MrrxC
         If1VvjWDIq4Q3n9L5mnnyJszd7+RYZ04sL7ZZ+sLY1yVNed6malG4/rPLrG3C6hTSJ0e
         ZcJevjcoRVFA7sVJ/oZiPlkSI9+dHcfq9cO9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijLjzSJxS/pQbS2F8YiBTgk5YasRsnLXVntteEFabhQ=;
        b=jP0JKs8DeXdYoKtBIkYTyhxSDNB4vWIhaPfqxyvlMwraBFLP/yg92lijzxHmsCB+ov
         GO07TX9fMTRBX5Qs0hJrH4/jtjyWadQJ5guTlu16I2i4zVDqVPJ5AUjtDGck2zotLgKS
         BqL6SW0LhoyCJWaFNDQJfWu1i44NxMDBoWt284Xw3+lfhAPoYgbOF3QiVd1Owh76tihD
         dfjNZUvkBeF+v5ssF9NVxniaVHFC0EqZxUU039isdw/7/9696gGTYTjKSFMxi6gdUts5
         flnVhsasPgfFUBlZTVIl0IzvIyVtQbP1V4hcO2OvTKqAgpkc8rnLdWmqzC2kZsgm450P
         k+mQ==
X-Gm-Message-State: AJcUukeQrlcSNIjQjo3uyTniRD3yZ1rT3grnn4E5W9IJP6414y9Cncjx
        Pu8BceM7W6SidrpFNKHb7B+83v6cMrQ=
X-Google-Smtp-Source: ALg8bN47kw/RQW9yssiRgFbNZlAFjhCt64vZ3KtweK5MPyZJEmBssqfwV/rCMFA+ERZObbXfBJdpmQ==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr4158944ljs.118.1547059238474;
        Wed, 09 Jan 2019 10:40:38 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id m4-v6sm14615180ljb.58.2019.01.09.10.40.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:40:37 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id v15-v6so7354678ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:40:37 -0800 (PST)
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr3632360ljj.120.1547059236928;
 Wed, 09 Jan 2019 10:40:36 -0800 (PST)
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
In-Reply-To: <20190109182955.GC30131@pure.paranoia.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jan 2019 10:40:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
Message-ID: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     pr-tracker-bot@kernel.org, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 10:30 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> >
> > > (unable to parse the git remote)
>
> I just committed a fix for this. We weren't expecting URLs without ://
> in them.

Side note: I do wish people would use the proper _public_ access.
Maybe the pr-tracker-bot might even send the person who did a pull
request a (private) notice that there is something odd when that isn't
the case?

Pull requests shouldn't use the ssh address. Yes, it may be where you
_push_ things to, and yes, I can pull from it too (since I have ssh
access to both github and kernel.org), but it's still not the proper
"public-facing" repository address. Not everybody can use those
addresses.

When I remember, I actually end up editing these things up by hand as
I do the pull, because I want the git history to show the publicly
accessible tree. I don't always remember (but I did for the csky
case).

[ In fact, for the ssh://gitolite.kernel.org case, the fixup is
automatic in my git hooks, but for github I have to do it manually ]

               Linus

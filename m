Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF53B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M9PPKpLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF53B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbeGYTgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:36:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36478 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:36:06 -0400
Received: by mail-io0-f196.google.com with SMTP id r15-v6so7117467ioa.3;
        Wed, 25 Jul 2018 11:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waMkm8qu4qiwQ8g0dtVft2jRB7R+CjCYLVpbw++3Go0=;
        b=M9PPKpLid+fthco/DrtgmgonNxXm+jA3vvEX6LuTO85nBZ4nhHOOTyJGnlFMeSeMD/
         m/eYPzlCU77+TubWpDVXQfwhdNy3AnmobMP43+hM6sogJECB1t5RfaHdSsCqebm9VMWM
         DEcCZzJrLHYyoIPJHgKjit+StDe7XEzFg9vp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waMkm8qu4qiwQ8g0dtVft2jRB7R+CjCYLVpbw++3Go0=;
        b=oFKa2SQpabLHjWid26+H3GvxASFbhuwzFkJFzB8j/heibX4iqoClSJc5sZMewwN8EB
         op6BRm6UC/r/ULGblxZ5DAKrC7Ip3C7NBkLsSfpeT4TgzlFqaVN+PHJAqoKMcJK7yysh
         KVWwH7MTd9IohDdnX5Ll2UjeuVMW3hhd6OgA0QRpoNuQQeE9g39VJc0hOkSM5vSVNmDh
         GkTgjEH3vorb8SG8aD7sFiciOV4VqVY8DzkE0SMjVJnfP8vxVoQRpxPY+AFSHV/ZDtTP
         DdvNKIoOjU2n1zeHqZjFCd5+G9/9Sviftke5zKpGzmFUEfIhVDtpMvSCf0GiBC5XUQAh
         CgHg==
X-Gm-Message-State: AOUpUlHKo/5clnw8qwBKvS/SJkdAipRBF5lxbcH4LHdDbMCXEEu/YRFr
        yWye0Q/KSkrJtZvO2+pe9Y5nX+I+XdeLUJjD11Q=
X-Google-Smtp-Source: AAOMgpfWinhUeU6C8kFCMXX9CEFb1Lpvz0YTuAKEeqPAQKQ0scScpc/mWW8MuPY1b3c0TndvwDByPlEgwZg2Iqh6Yao=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr18854792iov.203.1532542994330;
 Wed, 25 Jul 2018 11:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <7828.1532527332@warthog.procyon.org.uk> <CA+55aFy2v3OW+mmSDF4MPWW673WsJEdQef3LChWg5k9=_k9ggg@mail.gmail.com>
 <25183.1532542685@warthog.procyon.org.uk>
In-Reply-To: <25183.1532542685@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Jul 2018 11:23:03 -0700
Message-ID: <CA+55aFwvKerkzigZmm0zrUTnsqDpJs0XBtX72Ltmek+_ic-KmA@mail.gmail.com>
Subject: Re: [GIT PULL] fscache and cachefiles fixes
To:     David Howells <dhowells@redhat.com>
Cc:     kiran.modukuri@gmail.com, linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:18 AM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Why do they have commit times literally *minutes* before your email to
> > ask me to pull?
>
> I split the first patch into two because it had two more-or-less independent
> changes and it made it easier to describe them separately.

This didn't explain the background before that happened.

I really want the warm and fuzzies about things, and when I see
something being changed just minutes before, something like

  "I did a rebase becasue XYZ, but this was around in linux-next for a
week before that without problems"

tells me not only why the times are so recent, but also tells me that
I really shouldn't worry because so-and-so.

                  Linus

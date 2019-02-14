Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C39C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B4821902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRrlFMqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbfBNBfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:35:33 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40977 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfBNBfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:35:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id m20so2168010vsq.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmLwR9SK/L1ub2UqKIynjD9SpCt7lvovD4KgOt1r+rU=;
        b=LRrlFMqs4PNqzFONzIHrAsLYDpDm76ciPQW/c1v1+nkQAgYIsjEOfy81BPAtnmqXIb
         7zF3wWA105tOgP72dSF2w+eY0GJxEN8A9IlP2OjOIPv2Pl7aftkoyA5h2wReh9xKrshQ
         EcNc1CS0OEYEWTRtu+gagMv+LTXWrSa8//z3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmLwR9SK/L1ub2UqKIynjD9SpCt7lvovD4KgOt1r+rU=;
        b=A1ntPLZvJtFafWQ7vZbvCiJ4ngEkx8CRS8qq79Oz5qdxDcoaXXFKdW8097237Qxuj5
         Qr9eJ1Ab1gS+CpTE46advvQYc1b8FavlkjceyAwA8ekEml2wYtXjMd3sgqqCx4psLVvI
         NDMe3hK2xhqQOzBka9D+48vdQf/b/62IitDV2czNReRWutNE65ZIrWDv+cRBtYzvARWu
         u4vS5x9zwhOzjZPKbes5CctU15aXslKxeXAf4oC1ZN9M2QHaO1rssDBD/thHOuyPwxSM
         tywk2E/CVZY/PmOEDbG1AbED4uogsUHY/tSg9b6NDqfv4E1TPNillnX51BBpfMAfDEzP
         lDQQ==
X-Gm-Message-State: AHQUAuZCgyoSwMSWqwCg4u81AzN62keHapvMXAVB0v62iZqoATEjZP3f
        SytqXQS12IsFuLcYTf9jFlfzst2epFo=
X-Google-Smtp-Source: AHgI3IbXTcSgjR/UJsVtJR+ryqaUTZcq/H1JX83VsXaSBVa4nscB0d5jKqJLoNksxEWS3YM5iJL2KA==
X-Received: by 2002:a67:ea02:: with SMTP id g2mr677065vso.205.1550108131732;
        Wed, 13 Feb 2019 17:35:31 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 2sm134244vsd.13.2019.02.13.17.35.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:35:30 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id j8so1472511uae.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:35:30 -0800 (PST)
X-Received: by 2002:ab0:74cb:: with SMTP id f11mr642242uaq.14.1550108129914;
 Wed, 13 Feb 2019 17:35:29 -0800 (PST)
MIME-Version: 1.0
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
 <CAFLxGvwpuxKF4UWdsULwQWo7kgVLMNHC=77dN+w-A0a6avrAXA@mail.gmail.com>
 <CAN1fySXjLUYFw2JGQQ5xxqjX+6kygzqgUc6Oj-sbtq=ZjgfLTA@mail.gmail.com>
 <CAGXu5jJoqnX54JnHZDVxO4NRCsT6sLH4+-TPk8GqCSVp0mFNLw@mail.gmail.com> <CAN1fySW2mTaHmj7_uon_xZBVgPeEuYCD8e+JGOSKNwokmgZ7yg@mail.gmail.com>
In-Reply-To: <CAN1fySW2mTaHmj7_uon_xZBVgPeEuYCD8e+JGOSKNwokmgZ7yg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Feb 2019 17:35:17 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKXUhYB9xBLMWTvJiJEVPyRd=RsZTOCSvbNv7i6pEhtmg@mail.gmail.com>
Message-ID: <CAGXu5jKXUhYB9xBLMWTvJiJEVPyRd=RsZTOCSvbNv7i6pEhtmg@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Graham Christensen <graham@grahamc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:27 PM Samuel Dionne-Riel
<samuel@dionne-riel.com> wrote:
> If I understand right, you're asking whether it should return NOEXEC
> if, of the first 128 bytes of the shebang, there are no spaces, but a
> too long shebang? I wouldn't know for sure. The behaviour would
> change. Instead failing due to trying to execute a shortened path, it
> would fall back to the shell interpreter interpreting the file, which,
> due to the inclusion of a specific shebang, might be a wrong
> assumption still. Here I believe it's still in the "undefined
> behaviour" territory, but one where it fails early for the userspace.

The original problem that was trying to be fixed here was to disallow
execution of a truncated interpreter path. It was assumed argument
truncate was just as bad, but it's not, since the interpreter can (and
does!) re-read the script to get the right arguments.

So, I've sent a fix-up patch that should disallow the path truncation,
but pass through the argument truncation as before. This passes all
the tests I built:

$ ls -l /AAA*/perl
-rwxr-xr-x 1 root root 129 Feb 13 17:17
/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl
-rwxr-xr-x 1 root root 129 Feb 13 17:17
/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl
-rwxr-xr-x 1 root root 129 Feb 13 17:17
/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl
-rwxr-xr-x 1 root root 129 Feb 13 17:17
/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl
-rwxr-xr-x 1 root root 129 Feb 13 17:17
/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl

$ ./test.pl
Arg # 0 : /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
Arg # 1 : -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-Fi
Arg # 2 : ./test.pl
$ ./AAAA.pl
Error: no such file "I should fail to run huge interp\n"
$ ./A128.pl
Error: no such file "I should fail to run 128 byte buf interp\n"
$ ./A127.pl
Error: no such file "I should fail to run 127 byte buf interp\n"
$ ./A126.pl
Arg # 0 : '/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl'
Arg # 1 : './A126.pl'
$ ./A125space.pl
Arg # 0 : '/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/perl'
Arg # 1 : './A125space.pl'

Are you able to test the patch and report back?

Thanks again for bringing this to our attention!

-- 
Kees Cook

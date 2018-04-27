Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524818699; cv=none;
        d=google.com; s=arc-20160816;
        b=seNEUF1hLfn8byonv4w+klLXwfuJPRrMj6Gf6QV1jLYcJslgpVRlNAfhg7yX8CwmqB
         lltBErZ7C3QUjJXfz0e0qajo11SM50uLzXQ9Xnr/O1E5Y+1AOupWzgewEj8ycjKR/Qp7
         XLmFYm9nv9FtCtxnH5MGP5ws4zdEfiTVasEQx9J+Oy+F9DZPvWBa6Gf1j83nE9UY0VA3
         ftUhF+leBAp5DjX3iXPPL2yVHxq1Idsa4CLkQBEw1kyY7/mxcd4IRDqMtsQ/Dtf/Trhn
         FnUduSuCBkOopNypOWwDN/PA9Un7RMdXUC4iRnTksP9xjKytLgana/6ADxthq8o0/fxJ
         8O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :arc-authentication-results;
        bh=zc7NP7LOFv7bYgqsGxJWE9Ka7OY/R2VKlvh4AoSZYVo=;
        b=y7uNBAiCSZOIq3eKThRRgMp5q9F2ybFGvJESWgRXjkE4tJ8XN5lt7KI99CuDZR1tvS
         XJank7Hd9GVJHMzKDn8VpNTq2mtLpLdEJyORUez/2v2KmFzz54eglVUbIWzefo25bBUv
         sF+C6Enu95H+0j21tBA6u91IYs7SNyH0tj8lJvFZtlhyTPMPDSii0XG8EYaLUGY9aKo7
         Rl4I6AE/wbhHXa3u7r/yaYke4yydiwqJbmUGf81EH0wpELQh9PEHz4gWk5Pj5X60QrYW
         tWhb0IaVeemOWOZgXbluT0ejrYVG1W2G2lp2s2v3ES0VyXxq182akLjP4qn1t8ajRirH
         l60g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pU98zFZ+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pU98zFZ+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZq2uIBG2DtpFzitySTAipq7b/bRkaWEH9oJdHV6FR+LoYQ69g+q458YnahckMcEyhnlWKQ5afUnSw/vgEj5giE=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180427083006.GB25242@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com>
 <20180427073004.GA12770@kroah.com> <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
 <20180427083006.GB25242@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 10:44:58 +0200
X-Google-Sender-Auth: _5Xw--TXQvsCN5yGh2qwQ67DPOI
Message-ID: <CAK8P3a2b81P_i2fX+RukhKiVwSUah2y5yPkQYUYU-Tr7yM3cog@mail.gmail.com>
Subject: Re: stable 4.16.5 hmm build error
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7RgdC+0LI=?= <drdeimosnn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598847241183995427?=
X-GMAIL-MSGID: =?utf-8?q?1598888292308359707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 10:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 27, 2018 at 10:17:42AM +0200, Arnd Bergmann wrote:
>> On Fri, Apr 27, 2018 at 9:30 AM, Greg Kroah-Hartman
>>
>> which you backported as 25df8b83e867 into linux-4.16.y after v4.16.4.
>> After that originally landed in mainline, I found another build error th=
at
>> I fixed with commit
>>
>> 9d8a463a7016 ("mm/hmm: fix header file if/else/endif maze, again")
>
> Why does that commit reference:
>     Fixes: 8900d06a277a ("mm/hmm: fix header file if/else/endif maze")
>
> when there is no such commit in the tree?

This must have happened when the commit that introduced it came through
the -mm tree and got a new commit ID between the time I sent the fix
and Linus picking up the patch from Andrew. I try to hand-edit the
'Fixes' line when I know it's a patch in -mm to say 'Fixes: mmotm ("...")'
but I missed that his time.

>> This fixes the issue that Randy is reporting now, please add that into
>> v4.16.5.
>
> I tried, but it does not apply cleanly:
>         $ p1 < ../mm-hmm-fix-header-file-if-else-endif-maze-again.patch
>         checking file include/linux/hmm.h
>         Hunk #1 FAILED at 376.
>         Hunk #2 succeeded at 498 (offset -52 lines).
>         1 out of 2 hunks FAILED
>
> Am I missing some other commit that went in inbetween the above patches?

There were several other commits from J=C3=A9r=C3=B4me inbetween. I don't
immediately see where the conflict came from, but as my patch is
basically a revert of J=C3=A9r=C3=B4me's, and it was working in v4.16.4, ma=
ybe
it's best if you drop the backport of b28b08de436a for now, let him
comment on whether we still need it. I had not seen the build error
he referred to in his commit and we know that it does cause a
new one.

      Arnd

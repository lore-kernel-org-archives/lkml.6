Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524817064; cv=none;
        d=google.com; s=arc-20160816;
        b=rP9x7k6XQouSOmXKedx4rJGPXlru0yRAflc1GDzreJTdCj3AMq5oGOr5u0/+84EmBg
         2DLRX24aLKLgD3JprtHeJIIcic9/86bpX6q16eJLA9Nlcay/Y6ru0tnJHG02B/7wJvP0
         UajnlJkH/TPR0f4tvEyGo9Nr15fPNXyZ7+GbEfLVMz09bLgeCHG/WNEyJm0r8u5H5Tbt
         agVrx5gxIoBQFxIMyaQbaf6QqCRl2iA9oMTh2ybfKvYMJtrG3xy/i3BBPtdj39iX9zoz
         7Q6msw07rPUZqeGF0pxbKBNrEGROZuh4HA0Ol34TsRu1BR6DIlZbUYFEcZKQlvFF9Bmw
         699w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :arc-authentication-results;
        bh=cG4Cc2B+dJgSfUfsm3/NJFwizWnDISZfa9o6YXPmWnc=;
        b=HOK8S3OhmtlUd9Taq4Q7e+cs66TEMau4ZcHoxxTD6b/ME7HVyfPkORegljB9gD5nM0
         VFij0aJqp+xdCp3qvahaywdufwSLzislZnXxfw3o8G16PkW9i0spZ5zP3vPfTjV27pvO
         U0xldbYgbBoll0Lm7WmhXxd6hfgy5oDIiwpco2km4Qi9OpbJcikh1Lxj+joCZOLMmOfh
         d9kNbnK0pdSAcOvTZ7c/bObVTWdaKRK+UtdnERXQHWBjhPKTFP0ez+r16kqUyV74qIzg
         rC8ACJWLRnXDC0gJD4TIlMoNM9WX+6cvWR/fZULJ24qKidkCmMKanwUEWoah2GWvqNsE
         Gflw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SX10buJ6;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SX10buJ6;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZqtOmOmsogQqHsLMtzlooXtr84aa9H58RlxHfvQX0He9wiBzSu6OfQkmcKhnbxvVKq9jcSAO4YhxWAOrgo//r0=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180427073004.GA12770@kroah.com>
References: <d5e6a41a-2fb2-7f7c-5b8e-65dba4b8c356@infradead.org>
 <CA+MChEqqReWRVDELTqzOQe73sv_bCVtk5TQ9n=FqYjJwndDN7w@mail.gmail.com> <20180427073004.GA12770@kroah.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 10:17:42 +0200
X-Google-Sender-Auth: ASGJUIAPT58PJ1bsPdjbHgmyjKw
Message-ID: <CAK8P3a37b+3oW8vKS=pYi897uK3qySt0Cd=jvufqLc+h+ATkBA@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1598886578148422459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 9:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 27, 2018 at 02:19:24AM +0300, =D0=9C=D0=B8=D1=85=D0=B0=D0=B8=
=D0=BB =D0=9D=D0=BE=D1=81=D0=BE=D0=B2 wrote:
>> Oh. Yes. Tag v4.16.5 without commit
>> 9d8a463a7016e9e5578a561588a18acef139919c.
>> It's in v4.17-rc1/2.
>> Thank you.
>
> That patch does not apply to the stable trees.  I'm also confused by the
> lack of "real" git commit ids that are being referred to here, that
> commit refers to one that is not valid.
>
>> 2018-04-27 0:52 GMT+03:00 Randy Dunlap <rdunlap@infradead.org>:
>>
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D199515
>> >
>> > kernel/fork.o: In function `__mmdrop':
>> > /kernel/build_kernel/linux-4.16.4/kernel/fork.c:600: undefined referen=
ce
>> > to `hmm_mm_destroy'
>
> What .config is creating this?  I have not seen any kbuild reports of
> this in the past.

I only got this through randconfig builds on mainline.

>> >
>> > "It is also reproduced in linux-4.16.5"
>> >
>> >
>> > There have been a few attempts to fix this build error.  The kernel
>> > mainline
>> > repo seems to have it fixed, but it looks to me like Arnd's latest pat=
ch
>> > (9d8a463a7016e: "mm/hmm: fix header file if/else/endif maze, again")
>> > was mis-merged to 4.16.5 stable.
>> >
>> > Please take a look.  Do you already have a fixup for this?

J=C3=A9r=C3=B4me initially created

6b368cd4a44c ("mm/hmm: avoid bloating arch that do not make use of HMM")

which is part of v4.16. He noticed a build error that he fixed up with comm=
it

b28b08de436a ("mm/hmm: fix header file if/else/endif maze")

which you backported as 25df8b83e867 into linux-4.16.y after v4.16.4.
After that originally landed in mainline, I found another build error that
I fixed with commit

9d8a463a7016 ("mm/hmm: fix header file if/else/endif maze, again")

This fixes the issue that Randy is reporting now, please add that into
v4.16.5.

      Arnd

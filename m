Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518383447; cv=none;
        d=google.com; s=arc-20160816;
        b=0DlD9YaasDLIuALqmwS876GwuVmK7sqLzMJaCje+iZAomgHBKw8UXdTkncEoojxsJ6
         Evx5gNZRzPQggI6eflCNS6cgn0fO4QM4o2MzZu49nDWpojp3OY825EWGzTmfQEQvOyj2
         8tL4IaUFmBPpHJxUAxtkQb0lCTmFEUarbLXyfUwZfmfmvbpO8uJXQhnP5+kP6h1BvNO/
         cwES+HtObKR9TT8vr87HmKx8s9Hmof+BGXZpjId04QNObjqJU523nCjWTmWBL6D5R0yU
         SjKVQ5aY4qlg8N5/4DC7HTuNDA0qBIj/3Ood2Ih5Z08dhJosZF+LD4JiI0RTl2sgSS+q
         ka2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+Pk4up/oalgA3xnPgPg6V+K2KTk7EyRYocCofe5fbWA=;
        b=nDl/sqkTr8Q/hfUlXUug9hQU+eUpdAUFZi01YnJvANMeniMmkAdlDfOnCFfO0SouLm
         rQ2FkZW9ADstVnFlzPYuIxfkDSBneWl+O1okNBLzExPQUOVqckkwwy4mLklfEX4DrJQ1
         YbtTI6hIw9G0b954QCLh90GjjuzujNiWIOTcVZq7C1CiMi4I/eUJ0yc5j7c+PPFr90jb
         a/msmuUIil9ZpdBO1vlWVcMNfH185bF0LifSdakRtZa52vq9hLp4Q8pUTP/kkoVFYKCc
         UT+wCETLsWssKS/sH7grY1hTMYQTq42fib/KfCY1Fz1UI06abjls4lFXJ6cp/D9iSUGd
         /dZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VghKzbnm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VghKzbnm;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x2267+i+HA1Hla5glSAPljV1yW1vJ2KV6BafleN37TXfEqYUtz7vWRNNiNIi4PyEbFVghXUe8z7F0W3HeULlWmQs=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <CAGXu5jLV-i5OAbXMQiJC-idXB+XrxMCC+RigQ+4R6eZWqn4rgg@mail.gmail.com>
 <CA+55aFwWQ4nL2Asmzn0NSsw=w-tX5hAM9bFiOZhxehnhWH+wkw@mail.gmail.com> <CA+55aFy4WNC=pmga19CHhrX9QwOJsu1bUvGL0oNxq5EeMW94eg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 11 Feb 2018 22:10:45 +0100
X-Google-Sender-Auth: 7TTvKlcrx25JeXovERsCRNFyB3Q
Message-ID: <CAK8P3a3DHkpbRxUTP77OoeAqRHDz-tL-qYxLfq61Wv8NUPmyjA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Ulf Magnusson <ulfalizer@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592140441902035586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 9:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Feb 11, 2018 at 11:53 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Well, it's still not a very *big* bump. With modern distros being at
>> 7.3, and people testing pre-releases of gcc-8, something like gcc-4.5
>> is still pretty darn ancient.
>
> ... it's worth noting that our _documentation_ may claim that gcc-3.2
> is the minimum supported version, but Arnd pointed out that a few
> months ago that apparently nothing older than 4.1 has actually worked
> for a longish while, and gcc-4.3 was needed on several architectures.
>
> So the _real_ jump in required gcc version would be from 4.1 (4.3 in
> many cases) to 4.5, not from our documented "3.2 minimum".
>
> Arnd claimed that some architectures needed even newer-than-4.3, but I
> assume that's limited to things like RISC-V that simply don't have old
> gcc support at all.

Right. Also architecture specific features may need something more recent,
and in some cases like the 'initializer for anonymous union needs extra
curly braces', a trivial change would make it work, but a lot of architectures
have obviously never been built with toolchains old enough to actually
run into those cases.

Geert is the only person I know that actively uses gcc-4.1, and he actually
sent some patches that seem to get additional architectures to build on
that version, when they were previously on gcc-4.3+.

gcc-4.3 in turn is used by default on SLES11, which is still in support,
and I've even worked with someone who used that compiler to build
new kernels, since that was what happened to be installed on his
shared build server. In this case, having gcc-4.3 actively refused to
force him to use a new compiler would have saved us some
debugging trouble.

In my tests last year, I identified gcc-4.6 as a nice minimum level, IIRC
gcc-4.5 was unable to build some of the newer ARM targets.

      Arnd

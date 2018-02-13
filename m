Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518510958; cv=none;
        d=google.com; s=arc-20160816;
        b=sBdwyKvCA5LwegdzJ0XnYAfwjChvUvJ8SgQJCErgGCPffUVEq3td1mao05GGT6GDmV
         eo7OaqYJ07RQTn4V1V/tWZF73DgKFS8FH4ZIWQhOS6u75ujrH2k6Y/FtlNG2UT45MF44
         x06dHQ8RWRgvXmLtyHaD/Ykn++MEuBUtyPtszUNhAjyBdLEOgOgfNvgGIl1tVAvbM6VQ
         IkW7/QnOf9O488WEaCIM63htQ3r5MMb5oEOA8stPAT/olvQ1MaQkmBiHBQRqmVr8Hy24
         mCOVar5Z0y5xFFh6ycwnmjlH9aQIdtdBkES4A/nFXLTLQfUDi28+tNy4o5kCL0FJZjfb
         5c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9xugc5sCxkjch6OQTJEbko19I0qMWWL1SSeTOTzCpYE=;
        b=FDRob+mBq2IaDpVUhnU2FUb9BrM0FjjBN1CnZ4zYVMieXUl7Kaow2wc/cfCOq2vXUQ
         kpQwKjneuu2UTfKCvs7+gsAghDpqigrcWwefC94Z7iS1h6cHO9hvb539CvyQxc/qtE9v
         LWDEmSqc5Kqn1whzi9bPwp9AS9qziuC1ftI1I0NF7HF+jzQjAPTw2jvgxFnv5sBw4UJi
         PafmDbLNHprM/ThMiDvci8lqD22kYnY+ZLURaxyq2huXY57L0Q79xPQ33E+flcd/r0+/
         e25gkKr6ceToGshQv9z/C0i/QsjS1GcLq+makk8JLDJ65Hgws7QgZkLoeMZlVk5tE59L
         GBuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I2J8kN0y;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=I2J8kN0y;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x227kCWqWGKW0tDHmbeXbuviPq7bkT9vDOgA6mYPylyboxm+hyBpzhIlGG/g8NtNvSlV7Zaqm22a6th3fBcgjEjk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <b17cc8ff-1bf1-1026-d028-f9552701403d@infradead.org>
References: <20180210054843.z3g7wvcmlccvww3h@huvuddator> <CAK7LNARHmAF2SxBcc1aUEH5MMzUo_furLevqy7QzGxqNRHYiyQ@mail.gmail.com>
 <20180210074924.3nhxsza5zdbaahxx@huvuddator> <20180210080556.mycqsjhxbaguwhay@huvuddator>
 <20180210085519.737ckf4bcl57h4g2@huvuddator> <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CAK7LNAQpS6dYBnt_PjL5zrX1=eccSg80khu=WYCjnHNvDiKa3w@mail.gmail.com>
 <CAGXu5j+7kv=jrg2u7jaxFEXwHoyzDXP_jyKHYA682_BrYuHwQQ@mail.gmail.com>
 <49c196ec-891d-2030-bd6c-7222feb22059@infradead.org> <CAK7LNAREEJ_k9x2QXaT73nBg934pb9YvO9DfzhhU7+_fpDdH8g@mail.gmail.com>
 <b17cc8ff-1bf1-1026-d028-f9552701403d@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Feb 2018 09:35:57 +0100
X-Google-Sender-Auth: U9jJDmo8ZQGNy88BTH2S4-DKvhI
Message-ID: <CAK8P3a1SiejhK+eSx_mYqJratytU+_6FSjjatZE9n171GiA0mg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kees Cook <keescook@chromium.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592274147394306688?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 2:53 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 02/12/2018 05:41 PM, Masahiro Yamada wrote:
>> 2018-02-13 8:48 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>>> On 02/12/2018 07:24 AM, Kees Cook wrote:
>>>> On Mon, Feb 12, 2018 at 6:39 AM, Masahiro Yamada
>>>> <yamada.masahiro@socionext.com> wrote:
>>>
>>>>>> (And in thinking about this, does Kconfig know the true $CC in use?
>>>>>> i.e. the configured cross compiler, etc?)
>>>>>
>>>>> I was thinking of removing CONFIG_CROSS_COMPILE.
>>>>>
>>>>> A user can dynamically change CROSS_COMPILE from
>>>>> "make menuconfig".
>>>>
>>>> Most builds I've seen implement cross compilers as an environment
>>>> variable during all "make" invocations.
>>>
>>> I agree. I think you would break a bunch of build bots if you remove that.
>>
>>
>> For clarification, I suggested to remove CONFIG_CROSS_COMPILE.
>>
>> The following code:
>> https://github.com/torvalds/linux/blob/v4.16-rc1/Makefile#L315
>> https://github.com/torvalds/linux/blob/v4.16-rc1/init/Kconfig#L58
>>
>> I hope build bots are not using this.
>>
>>
>> Passing CROSS_COMPILE via the command line, environment
>> is still supported.
>
> OK, I misunderstood.  That one can go away IMO.

Removing it will break the workflow for some people in a minor way
though. Could we have the top-level Makefile try to detect the
CROSS_COMPILE? Instead of just using CC=gcc as the default,
we could check for ${ARCH}!=`uname -m` and then see if $PATH
contains a ${ARCH}-linux-gcc, ${ARCH}-elf-gcc or ${ARCH}-gcc.

it will need slightly more complexity to deal with architectures
that have different identifiers in linux and gcc, but I think it would
be a nice feature anyway.

     Arnd

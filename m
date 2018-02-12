Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518454594; cv=none;
        d=google.com; s=arc-20160816;
        b=yJUU9Ov5NGys1ly/OuqjQaFT581bUxtO7ZxMx8yEfg6bl+Ll87gmg/kj2W4O2qKcCH
         yDk5xauJQP0bgga+nSYGNtnZiuFNeD69XZErH+ngpVN7n9F7qmEdiNF91mHze8pQID7M
         L2zZYo+cu3x6EHtUzMvbBweIEN8Yv1Gns2+L29B7RCugveX0RFqIIPiKPo4fyBgnyurc
         O5jP2Yz/bm70DV0yDsW7zAEM5WsCBWjltnGIgM8pB8AdKmOrU0v6oaeyebHCHaLLqXVO
         oh2NyttXemL+fS7SXst+zm1BkCliF8aC/SvRkaBopa2YuZHs8VmLX+w66bta8RBAlfJ+
         bJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hKrluWKUqkvCYAIV93zhDQGOMZ54oQpyH5SjQvvwzLs=;
        b=OtzIlQeYyZMqzgljXQa43wgH0ZDjP1XPVwpMiDBloTJ8YLOuijOQ9IBv3LaQC0M7An
         mv1LBF20XYedxGjDdC7gEpoOlohCZLlrSqA6O0UAowYnfpc90qsse9gnLfUxIJQxf0cV
         ns1AHVP646wr1S+LxbSI747wLEiBqOtzQCDxK0+9n0qJPGgCRMyQhjkuewoNhbC/B2qf
         3U9w1jfxEiCfaAh0nKHdYGEfRYYcKNKT0GLX7gL5KYh/KijkuT8kuPQb21ehZgSwhPcZ
         IOgvVQUcjlIZaK0PiZ9RjM/qb4irLCKHEpl5jdv+0m21/N0/qwju6VqGX3PijOVRaaX3
         01ZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nYbzLKFn;
       dkim=pass header.i=@chromium.org header.s=google header.b=no9QZdhe;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=nYbzLKFn;
       dkim=pass header.i=@chromium.org header.s=google header.b=no9QZdhe;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225TYZ872qCDnsXMsproXjhU6jbowcIHnaVyeNH7K2SunPmmAgs8gcz3JPxCdWKcgyUtfbVdrl48Hz7rLHpwiT4=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1518452362.6606.102.camel@infradead.org>
References: <20180210080556.mycqsjhxbaguwhay@huvuddator> <20180210085519.737ckf4bcl57h4g2@huvuddator>
 <CAGXu5jKQgxxC2RQL0dxLKFVED2v-LiWKjtXY3DDpfwAXbnxM4Q@mail.gmail.com>
 <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net> <1518452362.6606.102.camel@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 08:56:31 -0800
X-Google-Sender-Auth: L6bHgaIW5AaX6nwoDi0QSgMv3jI
Message-ID: <CAGXu5jLdH7wkrnB9YnRLf+vQsQyfHehUywkXqsBuy6WmVLH3OA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591850368607646970?=
X-GMAIL-MSGID: =?utf-8?q?1592215045055742119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 8:19 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2018-02-12 at 09:26 +0100, Peter Zijlstra wrote:
>> On Sun, Feb 11, 2018 at 10:13:44AM -0800, Linus Torvalds wrote:
>>
>> > That actually sounds like we could just
>> >
>> >  (a) make gcc 4.5 be the minimum required version
>> >
>> >  (b) actually error out if we find a bad compiler
>>
>> So the unofficial plan was to enforce asm-goto and -fentry support by
>> hard failure to build, which would get us at gcc-4.6 and then remove all
>> the fallback cruft needed for those features -- for x86. If we want to
>> do this tree wide, that's obviously OK with me too ;-)
>
> This would also kill clang support, right?

That would be bad: Android exclusively builds with clang.

-Kees

-- 
Kees Cook
Pixel Security

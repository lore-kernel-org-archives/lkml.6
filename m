Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518457072; cv=none;
        d=google.com; s=arc-20160816;
        b=A1UbJGBfG91OfK+37uxHCp6GKa6ckObg4BQ68JxBkmhxHChdG3saXJ9qfOj4+MQ6be
         Kv9WE/hJ7/OPhxZjnctQNp473406EC8hAnaDL/sZMj0seB7odduheR1eqTQJgO7VvMSg
         R7FPl5tBXqSis20IWrEHrYUsShUqWQyy48L3o3TLDitOBaoH4tbkrFydQ3hnpGWh62iF
         ZRRWxnEQiuY0CgBHd5Hz3fhNDwXgRsAZ0nzqsqmic3fe8ONxsUzsXdl7OIP57q24oD9K
         IpvB8W6NHL8BRnaLvjOO5JY43J81WKSC1c/LUXhA1wCipM52F/XkeyWPmcu+B2QsZZMK
         HQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=iyhfWm310SIZGQH58zfkrstmBK0tuHQXl4LT/M4v5m0=;
        b=ODZnIwT8QjD/EPO9rSEMELZZI+BtaTVmjlE3CJFbUdiTEyy/rnz4KM1rLqJcGXBKxg
         7NpZfEUfZTZLhpw5FlHxHInt/33olBnOT/AnGsqo6hqUoa/QBxEgUwQ82+BCGdSHlJFt
         SLbAr695oOKjUoG137p4B3fcANSpfOfJOiQ2Hqr7xzi1X8ulyOsnphiB6fYIdQfSzDR4
         95QMBEJ7uf/4KgWdYig11cIgFLW4jYsjfb+m/Rr/51qF+EUQP2pdVY3YBBrYDDbXcuoL
         1E6aMamL2N+0PfTV2rCs5Kxiiv2sAvHlTxw+mEk3ytC9Nuq9TBEsw4gpcbHSpyaAXSjw
         848g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kS8weAke;
       dkim=pass header.i=@chromium.org header.s=google header.b=K/H5aI0f;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kS8weAke;
       dkim=pass header.i=@chromium.org header.s=google header.b=K/H5aI0f;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x227EAMvcHza1MW1/xGx89Uvv1MghVriPA8BLWWSaQckAUK9A4bSfOzb+N98WtVSXg5Zu3PaQVp+6kYZMF55rx3s=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1518456964.12890.7.camel@infradead.org>
References: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net> <1518452362.6606.102.camel@infradead.org>
 <CAGXu5jLdH7wkrnB9YnRLf+vQsQyfHehUywkXqsBuy6WmVLH3OA@mail.gmail.com>
 <20180212170510.GQ25181@hirez.programming.kicks-ass.net> <CAGXu5j+ev_TORtrogt+sPhBx0BMc3rrQ+6hkfxU7OHoG2bmdoQ@mail.gmail.com>
 <1518456964.12890.7.camel@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 09:37:50 -0800
X-Google-Sender-Auth: pg17nLIKGyAeJzqnEJyWUIinDOg
Message-ID: <CAGXu5j+h2uvSg30DvvnQMUFr25MepaGa690VJBxCGW0f4HarNQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1592217642518079829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 9:36 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2018-02-12 at 09:33 -0800, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 9:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Mon, Feb 12, 2018 at 08:56:31AM -0800, Kees Cook wrote:
>> >> That would be bad: Android exclusively builds with clang.
>> >
>> > So implement asm-goto already, and do asm-cc-output while you're at it.
>>
>> Yup, I've already been asking for it. I'm hoping there will be more
>> time/attention now that retpoline is "done".
>
> Retpoline isn't done for 32-bit x86.
>
> https://bugs.llvm.org/show_bug.cgi?id=36329

Understood. I should have said: s/now that/when/

-Kees

-- 
Kees Cook
Pixel Security

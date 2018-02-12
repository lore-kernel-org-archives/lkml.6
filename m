Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518456819; cv=none;
        d=google.com; s=arc-20160816;
        b=in31fMwqEio/WUXcebqGnLSSYy/kBj5tqvbwjMNv+GvRrfG2O8x0jRcEyMcA7Ps+AY
         qeH969Lgy0fhAtvAnCRE3iP0sC015Z7Etxb4+BTu2LjUrroxdZbb3M9iyH+T0KKZ8wGX
         +NXSEj4SnoV4I5Dg0YiSOq2P0t95MjsuBHLZWfRjKtJa62IYbUHlkqTxFiAQlEYbtp2B
         tiJYdCNfxtGQinCYPeecGo6fXjHhFtyLzZW9h+VzuEfImcl/lZf6/mnB/AJPGf+mLs2n
         NJ6gU1zKjRzR68XBnpuyZ7YZeyOsGDcx5f90mkLP8SaxTvuGhsNOA7n5vhfHnDdJsAjk
         2abQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=/ZpcABckk+3ph1HPLlMA9IdIUS7rojcrlsq2yiTqGXE=;
        b=ukERszLK1HqwJLC4ijtbzazyZxSFhxYbpuRg+UqWBOlhk47i1EkRwqtuOLChIy6cMQ
         /crOBALWkpyWuHKzsbpGEgd48c2oLrhW1rioSGrkm2ll0x/43jvuQsFL/MhFJ3Jmqq+9
         ZBqQ1W/0m3KwbKXk652g8eFsQ+H320SRIqEN1uKRQUfZhOEXXg5y3BiSOrcVKSG+pgWO
         4mbxnUot4D67tTNBZ8bbV0+tNMFKUEL5jvSw1TAE0SZVy+vZWo9Th+oRehkPnna/F2Nm
         71ixO0DaIGF6QPcs+jjPvAfhIxefDvnfKYziZBi3yebY/BrASInv8Ffuj7Zx1ibS5QXo
         7JzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Qo6Onqqq;
       dkim=pass header.i=@chromium.org header.s=google header.b=TRbCp9So;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Qo6Onqqq;
       dkim=pass header.i=@chromium.org header.s=google header.b=TRbCp9So;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x224k8/QOyKd+AFpB9fph8lZNPEP51a2z4bBucHgsewXQpbeR6QU/udQbHvL1Ho4OdiBW1e9r7r+isXFxFTW/i9A=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180212170510.GQ25181@hirez.programming.kicks-ass.net>
References: <CA+55aFz-SJ970iqDsR8-Ke4z6WvB4n9RXAeen8pG=+YJWubETw@mail.gmail.com>
 <CAGXu5jLo0iuMsH89vj3nr8sv+1YvXfXgoPeBdxHwZm5i=DWoOA@mail.gmail.com>
 <CA+55aFxdx3FYE6YGifRR=BSG9QzXwgThj5z7RmV5P5+RpNXSiQ@mail.gmail.com>
 <CA+55aFyPyYyG-riaBQU5cGp_sC=r8mf9Mg6L=DUEH6EyQfWYwA@mail.gmail.com>
 <20180211103432.pf2ot6nd7nbhdhsy@huvuddator> <CAGXu5jLtFcvbazxUvL_=6uT+a8m0JQEB7v0OE41Z-PMoX_fWpA@mail.gmail.com>
 <CA+55aFz3gUKQMr-X-b=ytLPX0AjGUaXNtLSUQ0_xZwZuDU33RQ@mail.gmail.com>
 <20180212082635.GA25314@hirez.programming.kicks-ass.net> <1518452362.6606.102.camel@infradead.org>
 <CAGXu5jLdH7wkrnB9YnRLf+vQsQyfHehUywkXqsBuy6WmVLH3OA@mail.gmail.com> <20180212170510.GQ25181@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 09:33:38 -0800
X-Google-Sender-Auth: VyPRqXY0BQS99VOBOV_Sz_y10XU
Message-ID: <CAGXu5j+ev_TORtrogt+sPhBx0BMc3rrQ+6hkfxU7OHoG2bmdoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] kconfig: support new special property shell=
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1592217377734329137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 9:05 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 12, 2018 at 08:56:31AM -0800, Kees Cook wrote:
>> That would be bad: Android exclusively builds with clang.
>
> So implement asm-goto already, and do asm-cc-output while you're at it.

Yup, I've already been asking for it. I'm hoping there will be more
time/attention now that retpoline is "done".

-Kees

-- 
Kees Cook
Pixel Security

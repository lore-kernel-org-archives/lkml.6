Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523286257; cv=none;
        d=google.com; s=arc-20160816;
        b=tpFMYhQkeFPBjBRrDTooxTPijFdENlEBj4Uocmbvub+u+wyuDEqgN32ZGqIAZXPAn8
         1D58MQhk8VsCF7px2ywmO0GMjso5HBjlNqQiz0nHgRd+/T4UqM3gYNAGTkScF7lfednd
         i10o6VjXUkR8xIO7h+TMvTQQ9LEXoUC97agHdVhSNtuMCBk7BOW4PwbDGmuPoJV5WFgO
         WX1goKpFTrb6EfxwYqXQ3sVGcfgrAtv0gVm8gFbf2Ox6Xbe3lCC9TShodReoq3/8I+7F
         aB8OhvRZdvUjdCrfVE8NQ37Dt/2Xw5xqjcT7BMDBo73bBT8Pos4B7cHNrr2EXFkzTOCc
         4c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=77YXMQK9DdG/tVbRQqp07MOUqB48aXTrFTiHxGZJmz0=;
        b=hGGk3+kf97yjztlUgeNYq9YvXfPlCx0QxljkeIdWiQZ3mtT9gIwxYzDdoB96xs29BW
         mgiCbHDkFz1JJx1zBBLu0Mxf9liuEqkUcFrILqJG4BaM9ZtW8bg1OLpoCg/hM/K5EVQ5
         m7XS+TC5uYVYMH2DrFyEiaePNbIhytK/e4SX6WEJ8QkaLG78y9TvgC2awvVipxNV0yTT
         /L0j3NECgBR7ZFsPaoSLz0TPCjm6kjkR7ZgL9xCSXPN7jWYabm85avLlLc/JdZ2DXkxB
         9S/04n1k3e/bsJaCTwE9xj0S9PMy7WVSVc+Zcj8htmmKT2om5m8tVj7VeDhqPbXJoxph
         0MeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=L72H5QhI;
       dkim=pass header.i=@chromium.org header.s=google header.b=NO99rhSe;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=L72H5QhI;
       dkim=pass header.i=@chromium.org header.s=google header.b=NO99rhSe;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49y2Yb/KGeLETzZncH+diZtKK3dHICJdyJmFlR3tx9UYwjEZJs3KE4aOYEYp1AKsz9vHUCpaPKND9In/qLccqw=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAK7LNAScTUhpvgnNzuOGZ2ueh-d4R4r=v5wzOGsd+pYn+MF-rQ@mail.gmail.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
 <1522128575-5326-12-git-send-email-yamada.masahiro@socionext.com>
 <CAGXu5j+F1GXNE9T3vOo+Sq+GfX2Cy5a8tFU--qVBJwaJkt=s6Q@mail.gmail.com> <CAK7LNAScTUhpvgnNzuOGZ2ueh-d4R4r=v5wzOGsd+pYn+MF-rQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 9 Apr 2018 08:04:16 -0700
X-Google-Sender-Auth: UEfeTvrda6rIDiUEj1m3vsuRCxw
Message-ID: <CAGXu5jJCpDtVcFckLzeTg=Du0TWL=KGUH1_k2LSbv8PTONQ2Mw@mail.gmail.com>
Subject: Re: [PATCH v2 11/21] stack-protector: test compiler capability in
 Kconfig and drop AUTO mode
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Ulf Magnusson <ulfalizer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>, Nicolas Pitre <nico@linaro.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067538122129787?=
X-GMAIL-MSGID: =?utf-8?q?1597281410952909870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 1:54 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-28 20:18 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> On Mon, Mar 26, 2018 at 10:29 PM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 8e0d665..b42378d 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -535,13 +535,13 @@ config HAVE_CC_STACKPROTECTOR
>>>         bool
>>>         help
>>>           An arch should select this symbol if:
>>> -         - its compiler supports the -fstack-protector option
>>
>> Please leave this note: it's still valid. An arch must still have
>> compiler support for this to be sensible.
>>
>
> No.
>
> "its compiler supports the -fstack-protector option"
> is tested by $(cc-option -fstack-protector)
>
> ARCH does not need to know the GCC support level.

That's not correct: if you enable stack protector for a kernel
architecture that doesn't having it enabled, it's unlikely for the
resulting kernel to boot. An architecture must handle the changes that
the compiler introduces when adding -fstack-protector (for example,
having the stack protector canary value defined, having the failure
function defined, handling context switches changing canaries, etc).

-Kees

-- 
Kees Cook
Pixel Security

Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519232520; cv=none;
        d=google.com; s=arc-20160816;
        b=a2v5LSJHBYrmCwk+r1YZnN6vFoZr5nRQ2LdzZ3uGBzPMp6UusymMtg0KklIQwjjKSX
         wzZBN+nC6XCFaFWrGndsY0vU4+8iNUG6fQg/o2w5qK+Eqo0WEYubpZ3jat1RQ6/Ar7sB
         6J9s1T7QFXoCRyx8+YDB7YL+skZB60OCIOXF2gYfbA2eRsnXa9BzK3tQGqRq1dAP4D47
         Z4TcS7NzivG5xcB8n6juRMgRf7XfpJ4TqMEoK2SS1JkNApVfs6IPbBfVWE/RsoQrY7LM
         EmJg88tv81XzoPg3II3xaX3UQenNBle8UWVnuNYsb8vo0cMAWNL2sxFrESOal3JWAQWO
         Wd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6UtHzamqATML83ql2TZ3IPHTAqspTErPN7Bf4A+JaPw=;
        b=ThKiZyYaUNSqCjiNvDYVZeW0fokofexcq0q5FaGQM1kQBfaBVG0q8isPJeG6DgEehR
         pzUmreV4tLAcYi1+oDuT3WWACYxO8qqR7PKO46cyLYwug3stEcYysdA4dGuo8QPMc/Q+
         Kyps/bdIpDdevjyX8RH1IqsIcI+mPVfJ/AisdnhgpDCDmA3sA+IzNV+Tx2ScW1s3EOIs
         qkGLGywckMiA16ZXFDOLzQMo1Dci6JGYSS3HtRXHOP5wIcJIMbjk8jQQbdwMVq+DA1t0
         rxa4YSA24h8ewyWoaWpPo6tgcO7Gk/rQ3pMdNYj4Y85cg0/RM6K+KFsPbKu6XfER/b1R
         9fiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ouHfUbnQ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ouHfUbnQ;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x225uw30pQLshtlJ481TAZVmzB9shVgcUvDt8dT/B8CFBqSOnSJZuw0aZk17+2gZV1ELwMRcNjkQS2+0w+GR2ukY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK7LNAT1QNMrHL_JikeEk1ejen-03u_vwkdQmHhHxrxHLtaa0Q@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
 <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com>
 <20180219044845.7cnqpgyiinn6hkyb@huvuddator> <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
 <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com> <CAK7LNAT1QNMrHL_JikeEk1ejen-03u_vwkdQmHhHxrxHLtaa0Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 09:01:59 -0800
X-Google-Sender-Auth: DdBXcQNUw2OeFUcLivPu6N-xsKQ
Message-ID: <CA+55aFyNM+qrF=f2gX4ktp5U+WOycktkrYfGos7VdTdOuhtvvw@mail.gmail.com>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1593030759418864381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 8:59 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> IMO, I prefer to use different names for different purpose.
> So, 'stdout' and 'success' look good to me.
>
> BTW, I noticed just one built-in function is enough
> because 'success' can be derived from 'stdout'.
>
> So, my plan is, implement $(shell ...) as a built-in function.
> This returns the stdout from the command.
>
> Then, implement 'success' as a textual shorthand
> by using macro, like this:
>
> macro success $(shell ($(1) && echo y) || echo n)

I like it. This is nice and clean, and seems to be very generic. I see
no issues with this approach.

                Linus

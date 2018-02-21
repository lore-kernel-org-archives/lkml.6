Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225HS/zaneRWCh0FVu8TOznqsaeBQId12mcTVM7PU8oS+FZEDlEknk3fA6/ugNIXySwlq7n2
ARC-Seal: i=1; a=rsa-sha256; t=1519189272; cv=none;
        d=google.com; s=arc-20160816;
        b=UvS3KSzOlJ0bripB9C1cBtkbXPiiQR8aWVAmqLw6NVyjLD/Y57uvLUueAUDnreQ/Jm
         ArdT4bOykW9XRZlDgEQEJr/NfPAnfgCid1jFE+HW8AGnD7ZOltnLPAZMA4fk9ItEurba
         kom8M8mLxdhKCfhtG9GotDCZCDoRMcDS5VEg90YM4htXg4Ss7mf0y16LklZMOiHaKol0
         kp0HaXaDNn1fRhhbGeY1p6JwdFwS3wCxmqOWnhhvW9jvwf5n1FLv+fohRDYK/clcxafs
         84CU8bRNyk5zg2d3jYjSw1dlwGWJ5rC41OsOOa6AWe+OYHrwZk6sQDg0+4Hzjj6Owcx0
         /lyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=aPzwcgNxfDELSgo/zdoyvVmxOEouKH+6eOBaavdNmq0=;
        b=w9I+5CUw6mTZiIcpOeX3iItrxvaMwLJLCeqkeYC1Haohkj5ZvXbXWayPJqClwN4pzY
         7ZBpVFNR+DwD2wHpdwA9+BciZiNtB+mtlWxCIuaraYg5hVzubJdJg1bGup+tvH+MNNSW
         3EN4vBaPvBSZe+AktNoPyMTPaAtAbG4eL8Om6cix1K5vYAQFRJjCW0rE4iU6surz2/Zg
         xRA2N/7F0hUg2BFr9CSYN+Lwcf3jsb+cOlLI3gzSHUIeLK0P3D/bBh9Qfpw4lKI4K3AY
         o9mglXWgXoNQdKK46g63/teAJlGLGrM+NYLipDE/9yT0pVnZVRalcASJyuO9oQIgXsGX
         YPuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=WkXy2Bod;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=WkXy2Bod;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.83 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w1L50etN006177
X-Nifty-SrcIP: [209.85.213.42]
MIME-Version: 1.0
In-Reply-To: <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
 <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com>
 <20180219044845.7cnqpgyiinn6hkyb@huvuddator> <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
 <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 13:59:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1QNMrHL_JikeEk1ejen-03u_vwkdQmHhHxrxHLtaa0Q@mail.gmail.com>
Message-ID: <CAK7LNAT1QNMrHL_JikeEk1ejen-03u_vwkdQmHhHxrxHLtaa0Q@mail.gmail.com>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592985411023498079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-20 3:01 GMT+09:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Mon, Feb 19, 2018 at 9:44 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I do like your "success"/"stdout" more than "shell"/"shell-stdout",
>> because with that naming I don't get the feeling that one should
>> subsume the other.
>
> Hmm. Thinking about it some more, I really would prefer just "$(shell
> ...)" everywhere.
>
> But it would be nice if perhaps the error handling would match the
> context somehow.
>
> I'm wondering if this might tie into the whole quoting discussion in
> the other thread.
>
> Because the rule could be:
>
> (a) unquoted $(shell ) is a bool, and failing is ok (and turns into
> y/n depending on whether successful or failing)
>
> So
>
>   config CC_IS_GCC
>           bool
>           default $(shell $CC --version | grep -q gcc)
>
> works automatically.
>
> (b) but with quoting, $(shell ) is a string, and failing is an error
>
> So
>
>   config GCC_VERSION
>           int
>           default "$(shell-stdout $srctree/scripts/gcc-version.sh $CC
> | sed 's/^0*//')" if CC_IS_GCC
>           default 0
>
> would need those quotes, and if the shell-script returns a failure,
> we'd _abort_.


GCC_VERSION is int type.

Setting aside the Kconfig internal, I prefer 50700 to "50700"

According to my common sense, I do not want to quote integers.




IMO, I prefer to use different names for different purpose.
So, 'stdout' and 'success' look good to me.



BTW, I noticed just one built-in function is enough
because 'success' can be derived from 'stdout'.


So, my plan is, implement $(shell ...) as a built-in function.
This returns the stdout from the command.


Then, implement 'success' as a textual shorthand
by using macro, like this:

macro success $(shell ($(1) && echo y) || echo n)


macro can be expanded recursively, so cc-option
can be implemented based on 'success' macro.





-- 
Best Regards
Masahiro Yamada

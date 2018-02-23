Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x22793rHgJu8yjaq4JMYTY4epmGl6UJyo0ZPBRcGbEddGQXFFjO4tTR+oC6+ZHyJw/beEaxxU
ARC-Seal: i=1; a=rsa-sha256; t=1519389530; cv=none;
        d=google.com; s=arc-20160816;
        b=ex8JGSEd8Qt/Prg69P9BHQD8MDVeMRQHA2llv7fb8vwWwld9TSJYZvGC+QuFbERpan
         9dfm/isCCZf5vDL+o5FAHQfPd0fXRbWihGxikubiqcB+/YX+DFcLZNDcInT6C+g1WBi8
         s6e5OfeWN90YmYNiu+KdoyjIomBkINFmT34zdaJgFrfu5fOj4LU2QdUoldR2W7LNLp9J
         SUIB0Ct+PGkJb6QEtrJKWtt9fV0+LkGA1o+GupDwY43FwhY0dDv1bHUMM+u+GtoyD5Ep
         GebjkhXy0Nse3ylrmbA0O+cLGWgORt6rcqjSnMf7NAh3t7lnbbRe4zFQAC4JPZv/sF9G
         /bbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=tGfSwir3QWixobBtZpSMOFVtoa9g1Ik1AhQxrnF+kqI=;
        b=Fqg9/DBer9iVOf4+FKKSsir2XM1KGezsulhl2oLlm8YgR80OjmlPwj1km/AOciZNsX
         3DsWv9f+NTnIpV9EJzr40hLpJ6tq+qt4WiU1mIyYy0X8b8TVVH5uduKXLhUx4HugqnOV
         +k0+r+Q61Cc/zBtRUONjNjBGcC0gAioNqexbwkpAGPg/S7qm2YfSXUpKnkgOE4nmm5sC
         NbJwYfscENXCQ8YmK01ZXPLlHgKDDhUCzTG9p8gnJH6IDyKL+W9U+dZeIxw5XrEr9A8C
         0gpplM6d4N/NsFL15ctTqvWTpZcCGCBvSHAEPfsdWpDFoKH4FTXTQSyhdd1eWuzvTAkg
         vKUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=VgWvHxj7;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=VgWvHxj7;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1NCcY2h028542
X-Nifty-SrcIP: [209.85.217.174]
MIME-Version: 1.0
In-Reply-To: <20180222194541.35076c5b2166879a8d5d234a@gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-21-git-send-email-yamada.masahiro@socionext.com> <20180222194541.35076c5b2166879a8d5d234a@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 21:37:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0EYibS3cSDtSxyXGmRp0PoctB4aWuFhPTZxnCuAd+2A@mail.gmail.com>
Message-ID: <CAK7LNAT0EYibS3cSDtSxyXGmRp0PoctB4aWuFhPTZxnCuAd+2A@mail.gmail.com>
Subject: Re: [PATCH 20/23] gcc-plugins: always build plugins with C++
To: Emese Revfy <re.emese@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935376722462?=
X-GMAIL-MSGID: =?utf-8?q?1593195396169221422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-23 3:45 GMT+09:00 Emese Revfy <re.emese@gmail.com>:
> On Sat, 17 Feb 2018 03:38:48 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>> If the target compiler is GCC 4.8 or newer, plugins are compiled with
>> HOSTCXX.  Otherwise, gcc-plugin.sh will select HOSTCC or HOSTCXX.
>>
>> To simpily things, let's decide GCC 4.8 is the requirement for GCC
>> pulgins.  With this, plugins are always built with HOSTCXX.  This is a
>> feature of advanced users, so this requirement whould not be not a big
>> issue.
>
> I disagree with such a decision. I think the gcc plugins should compile
> with older version because the kernel can be compiled with them too.
> The distros use these older versions as well and I can very well imagine
> that new plugins will extend these with backported features such as
> my sancov plugin.
>

Let me clarify this.

I removed the version check in the following patch:
https://patchwork.kernel.org/patch/10225379/

So, you can enable CONFIG_GCC_PLAUGINS
as long as scripts/gcc-plugin.sh passes
(i.e. C++ can compile plugins).

Even if it is unlikely happen,
GCC 4.5 -> 4.8 is not a big jump.

People were recently talking about the minimum compiler version
https://patchwork.kernel.org/patch/10207385/

The thread is super long, but my understanding was
4.5 or 4.6 would be reasonable.

So, we will be there sooner or later.


-- 
Best Regards
Masahiro Yamada

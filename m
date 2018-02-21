Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224cm4+7SLFO4oL+HoFK0xomO+x2R3yOtGkGjY65e2b3I7cpqj9wuOhoPCaL3dG92wXq3sNq
ARC-Seal: i=1; a=rsa-sha256; t=1519198765; cv=none;
        d=google.com; s=arc-20160816;
        b=lW8OLsNUAqXqcLfwMxPLrqpeU7B0AVfGCdh+oKmJrcqZhmeHmNcElgzSwqfOx0ENIP
         Wj9aLrZczoevIwq6Mze/CENKx09ur8bUo/pEVc5muKa/GFuvfvuSSYZaCY7ybhk6q2O4
         3ds1IsoAQrMwniEP9iVg0bBsVoleqqPkbS/Ri7vgXoZ8XHkaz+NQ0MON7XXMkBY4dm9e
         XL5sG9ExjaiP79mbR1J4PC4knPjFnaSFY6/kUubPX0Pn/LWII5pz0pi65LuGGAP+7vHg
         +ICONfO4MzjmNOlp6xuDe+HiB7XDkKTBNgCl1qnFUO0vEQkIautyurnoBgvxjhqAQBy0
         pkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=fRDLos7XG6JltQGtJEy8h5voEhzrb39985bVFRx4XYw=;
        b=CzEVsvoIwdKxkUqozM9t/QTJZWXOgXOgVfuRuXBkjeq8mDfAr/OMeZbMRCKL4lEkBy
         Kao9L0ed6ROKJPynttMGytorLpEd/bQimSBI55kDwjjpG193rject/6rGBvdcByRD+hr
         XJsyojoI0vpnKuCZxlB43bQDs60zP9vymQBjUooMhj0I4DkvP0ffYfuQNBFdBGJXv1Yv
         35IYWW2uK3JII3HupOHUfzeSY9V2bdGYvhUg3zdeG6u7FNUfgQesvMo8HKT8XMlLpNfB
         Es/tpqXVca9VNjO/wm0ETdGlY7/ThOZD2sg7sL2c3h6hRQ8Dti6220fY6paIm9vlgM0L
         H09Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zPcWnXm7;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=zPcWnXm7;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.80 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w1L7d6rh024923
X-Nifty-SrcIP: [209.85.213.47]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <20180218221352.GA6651@ravnborg.org> <CAFkk2KT1krKuDkWt0eHcasfC61fTVQNf-1kqw7icLP9OYGYkXQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 16:38:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
Message-ID: <CAK7LNAQH0WD3A3T97gce0xmZpMy0zWxTO2StfNWaDbiqjQg8gg@mail.gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        kernel-hardening@lists.openwall.com, Jonathan Corbet <corbet@lwn.net>,
        sparclinux@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>, Jeff Dike <jdike@addtoit.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        user-mode-linux-devel@lists.sourceforge.net,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        user-mode-linux-user@lists.sourceforge.net,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>, Emese Revfy <re.emese@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1592995365316926338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-20 0:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:

>>
>> I'm not happy that we in one context can reference CONFIG variables
>> directly, but inside the $(call ...) and $(shell ...) needs the $ prefix.
>> But I could not come up with something un-ambigious where this could be avoided.
>
> I think we should be careful about allowing references to config
> symbols. It mixes up the parsing and evaluation phases, since $() is
> expanded during parsing (which I consider a feature and think is
> needed to retain sanity).
>
> Patch 06/23 removes the last existing instance of symbol references in
> strings by getting rid of 'option env'. That's an improvement to me.
> We shouldn't add it back.


This is really important design decision,
so I'd like to hear a little more from experts.


For example, x86 allows users to choose sub-arch, either 'i386' or 'x86_64'.

https://github.com/torvalds/linux/blob/v4.16-rc2/arch/x86/Kconfig#L4



If the user toggles CONFIG_64BIT,
the bi-arch compiler will work in a slightly different mode
(at least, back-end parts)

So, my question is, is there a case,

$(cc-option, -m32 -foo) is y, but
$(cc-option, -m64 -foo) is n  ?
(or vice versa)


If the answer is yes, $(cc-option -foo) would have to be re-calculated
every time CONFIG_64BIT is toggled.

This is what I'd like to avoid, though.



-- 
Best Regards
Masahiro Yamada

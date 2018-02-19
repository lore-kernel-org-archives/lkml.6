Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519066499; cv=none;
        d=google.com; s=arc-20160816;
        b=jo4/R1dFOMGDct8DmUEpemCDW11qNEx+d4JWZmG1UM0HLctS7HCqzukONmGrsJuima
         eX+G2fyts0GoJ9tKSBXmyY7UWNQbR9i2kZXXVX0FwrHQ/McOfJNP1T379/zHyA/lz3Ze
         UaeqArpanKvGUk4ao4LKAi4RmNaSAlBvx8jER7r4Eru98aA2oMvIDvUOcxnGSZPG90ju
         Xz0lu3CNH5jlPRwyyjvOo+/C49W6B5b5v7cRZG7rcmBQ9GfkrkVaF2t/MXdLLeDkOKXf
         rVeO9dkoXNA5Ag1zuq4HlfzVXn0c2NFJGIk4cpDgzXv/y0XzIsN5+j6tIc8qaXTzT1jI
         oDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ILL7YdXXEtVVLJiXrvzosQCYH4yzugjMg5I2Sim3PKs=;
        b=o1EXoGZPR8AH/G6ISER90H4r9BjYo8xPmMOwsRUxlcJ+U1KLGssYmmLXiI5J9G6v7m
         k2+4C838TXeZAcJb82TCp+3aEDnPpFl0bavRH4Z7h3HhM2/KQC/ZAHL3+9TdkHDBjGrd
         c9XqDCrvUf+g1jduko/rlmTowD2VJQ6onGqSiC8t/5DzGuZGojqb2wtCp/YCds0TOvVw
         FtNvTi9HETMqLGa/kMiLydIlw1i5CowJn64i2iERb3UwAODGgDWjB5MSgy7FpO+oBP+y
         Z9Poi63Hv90EjGPBuMe75k5cSctTn4krFPmlTLVvPeKz2cSCP/naQyaT9DlPaTxT9Pdn
         vupQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ImaAjAtv;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ImaAjAtv;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2264yACyaepCnqDudsBpXW4JOL2cnCfIChtELpPoRuyJlOhX9OzCDA27gorfQb3zq6R43yoTgw==
Date: Mon, 19 Feb 2018 19:54:44 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
Message-ID: <20180219185444.o6p2v7qtl2fg5r35@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
 <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com>
 <20180219044845.7cnqpgyiinn6hkyb@huvuddator>
 <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
 <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFzu8+yaAGvdZMRYJWWZmv_OnFnocnvUiSKcAyNQ1z9kmQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592856673685611300?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 19, 2018 at 10:01:49AM -0800, Linus Torvalds wrote:
> On Mon, Feb 19, 2018 at 9:44 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I do like your "success"/"stdout" more than "shell"/"shell-stdout",
> > because with that naming I don't get the feeling that one should
> > subsume the other.
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
> 
> Which is actually what we want there.
> 
> Hmm? Is that too nasty?
> 
>                 Linus

One minor drawback would be slight kludginess if you want "n"/"y" put
into a string depending on the success of a command:

	default	"foo-$(shell cmd && echo y || echo n)"

As opposed to:

	default "foo-$(success cmd)"

I don't know if that's significant enough to matter in practice.

Keeping it objective, I can't see any major downsides, though I'd really
prefer to just have $() do string interpolation within "". That keeps
the implementation trivial and makes the behavior and limitations
obvious once you know that n/m/y is just shorthand for "n"/"m"/"y".

Cheers,
Ulf

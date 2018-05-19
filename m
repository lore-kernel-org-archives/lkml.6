Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AB8JxZpEoMeseCwnupZFgS7MqBLVUG51YMXSlwvvlEVmjdiGfx6eFeUD/NC7Chh3klOYy5sRWhAF
ARC-Seal: i=1; a=rsa-sha256; t=1526754649; cv=none;
        d=google.com; s=arc-20160816;
        b=dWIiqIpxBXSsl99yjFN1PRLhEjtAQeQjyG9vYvYaxK88i57PhUIj608JC27z1xmPC3
         28WNBswIWn8ZNw/+6/ZF4CyzV4/WcrST0eRQdfuUCC1ZcH/6Gq14jwc8+XVtxc3Ky/qU
         x7zT+Bx8bZqwzQdvcQz22EXV1vJ0D6fOIu4ZXi+KogX4ngV4XYNV696RafE4SRCQBz85
         L0D8jfGQHegFucg7ZGmaNk7q4mJyA8s8jLRSouWvzdiHXjEMZoPDDVRl+LkmCnwLlmE/
         fe/VKVInFmzoxp9Fjbqk61SlQLp/CHoFXZ9gLkDpJEGS5HGSsfEyrqzSzNmLR0Pd6w/N
         U2Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=t1vK9yJg77VYIxXrDslCODDoQph+vSPPyUsHaVyxcaU=;
        b=TrsgSfjkGFjORyeEC4bFoTIwOGXgPD7MjHNVRHHUSEo478DBq0YU3RDBVvPPn4QCLY
         4a0vWgqqFCs9L9Mjk0hJEWmdGa1kWTumc6kPHbmLppuIr4HsIWA+1bt8pr+noSYlEdta
         eyey0IVyioKKxFG2Y/wBVKGAm7NduRZkKB1QTKmfi3Ol36EK9oHsQbgu9kTjCZuzEC6h
         bfNnEpR8v/mIOjR12udM9QhuMCjqv57a3K2VseWaJNOKLLawJiiSaH+ZbTKKGlQ5GKu8
         lW070SVcErUN/Ep3A2AwxlhbqCG8xTGojVBl7g0Ti6LgkwKE+rWsPjcpiwRanTyqEQ6y
         EfeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qA7LJdTK;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=qA7LJdTK;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 0/5] kconfig: refactor package checks for GUI frontends
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
 linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arvind Prasanna <arvindprasanna@gmail.com>
References: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <35d9beea-7d99-99dd-a266-431a27d5df19@infradead.org>
Date: Sat, 19 May 2018 11:30:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526619146-1895-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600776240582675977?=
X-GMAIL-MSGID: =?utf-8?q?1600918283669690353?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/17/18 21:52, Masahiro Yamada wrote:
> Kconfig supports 4 GUI frontends.
> Each of them needs some support packages, but checks them differently:
> 
>   qconf, gconf: check packages in Makefile (pkg-config is required)
>   mconf: lxdialog/check-lxdialog.sh
>   nconf: needs ncurses, but its presence is not checked
> 
> This series refactor the package checks so that all of them work
> in the same way.
> 
> The package check scripts have been moved to scripts/kconfig/*conf-cfg.sh
> 
> The motivation of this clean-up is Randy's following patch:
> https://patchwork.kernel.org/patch/10277723/
> 
> I want to clean up existing code before adding more checks.


Hi.

This is a nice cleanup series.  Thanks for doing this work.

As I noted in my reply to patch 4 (mconf), I can no longer build
mconf and patch 5 (nconf) has the same issue.

On my system, "pkg-config --list-all" lists 153 packages but nothing
about ncurses.

Sure, I could ditch (drop) openSUSE and use something else, but then this
problem would just come up later. :(

[search web...]

I see that a few years ago there was a bug report (in Debian) that the
ncurses-devel package was not built with --enable-pc-files (for pkg-config
files).  There was a similar problem in Arch Linux.  (2011 and 2012)
These should be fixed by now (!), but maybe openSUSE still builds some
libraries without --enable-pc-files.



> Masahiro Yamada (5):
>   kbuild: do not display CHK for filechk
>   kconfig: refactor Qt package checks for building qconf
>   kconfig: refactor GTK+ package checks for building gconf
>   kconfig: refactor ncurses package checks for building mconf
>   kconfig: refactor ncurses package checks for building nconf
> 
>  scripts/Kbuild.include                     |   1 -
>  scripts/kconfig/Makefile                   | 160 ++++++++++-------------------
>  scripts/kconfig/gconf-cfg.sh               |  23 +++++
>  scripts/kconfig/lxdialog/check-lxdialog.sh |  93 -----------------
>  scripts/kconfig/lxdialog/dialog.h          |   2 +-
>  scripts/kconfig/mconf-cfg.sh               |  24 +++++
>  scripts/kconfig/nconf-cfg.sh               |  22 ++++
>  scripts/kconfig/qconf-cfg.sh               |  25 +++++
>  8 files changed, 148 insertions(+), 202 deletions(-)
>  create mode 100755 scripts/kconfig/gconf-cfg.sh
>  delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
>  create mode 100755 scripts/kconfig/mconf-cfg.sh
>  create mode 100644 scripts/kconfig/nconf-cfg.sh
>  create mode 100755 scripts/kconfig/qconf-cfg.sh


-- 
~Randy

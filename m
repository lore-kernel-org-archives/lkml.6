Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AH8x2255J9tk/w9kxvD+PdFPyIj5Nqm6PXskrhyQPGku3ZSoP/2wMKyT5/DOm+Hu2iXNKWGdAuH+
ARC-Seal: i=1; a=rsa-sha256; t=1518992040; cv=none;
        d=google.com; s=arc-20160816;
        b=gyEBir/3OwAyhKbCtfoPqSQpJH2rc/sAeRQHIsT+a8ISKRIGHxc5WCL9FPHbaH3VdD
         9KsfC2yo/JR2MsCQHqhiAGSalguwIbtZDr1Ctv+l1GJHTY1jZwLaXC1a1wVl0f8tCvvk
         U/kkeaBBf14bp5rLkeFmYN9jASAPIBbhdcGgEjYT0DnIpxzQ7JVsbtU69TixeC06RxYf
         y5rX4GJb9vzSm4fzB9mCwpTXJgtXu6zuSCD30Ks+VCACS7cDYD2ig+DlRoO8HAMS6ALD
         fMeYOQhWDqLEH21c1M50GPcp62dpAAc5Lc2cvhwPALfAWCy3MZoOgmOZoVI+2bliTiUd
         niFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=84KxJAVEeU7/9eT2azVYL/1rFFEHMMIVGnFC4vwNpGI=;
        b=s3SffSz7r7+0O79Fkkhg43CNa1tEKGU3VUKKhobjlbNEwBX0bTtAAk/recny/IfZCE
         MM1P0616dNUqinuUi/AoBEG+jYkwjOX9MfFWasDsWki5ktwELoQr/1cLFanRzoXxMTf3
         25mqhAsLLQJvYSKo98owAsskziJTaMkjQz1CIV5DgoAD40w8Ia1S5yC9AGW7AT1/S4xV
         61/7El3IbVgWb8STH3YKBGnYk9W9IykolMamm5/ZahyL10Q3KjfwoOxPhP+sY5S/7d1M
         wtNGyhCN7zl2YxfGr9NLrV5scAzSAZS048DEssWqayGPjO7+altvgSWVnRqT2C1x6ue7
         A0bw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Sun, 18 Feb 2018 23:13:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Michal Marek <michal.lkml@markovi.net>,
	Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
	kernel-hardening@lists.openwall.com,
	Jonathan Corbet <corbet@lwn.net>, sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>,
	Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
	user-mode-linux-devel@lists.sourceforge.net,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	user-mode-linux-user@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Michael Ellerman <mpe@ellerman.id.au>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Emese Revfy <re.emese@gmail.com>
Subject: Re: [PATCH 00/23] kconfig: move compiler capability tests to Kconfig
Message-ID: <20180218221352.GA6651@ravnborg.org>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=W9cWqyek c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=fIvg0Y2KpfyUdLn-zlAA:9 a=CjuIK1q_8ugA:10
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583929666456907?=
X-GMAIL-MSGID: =?utf-8?q?1592778597335667586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro.

On Sat, Feb 17, 2018 at 03:38:28AM +0900, Masahiro Yamada wrote:
> I brushed up the implementation in this version.
> 
> In the previous RFC, CC_HAS_ was described by using 'option shell=',
> like this:
> 
> config CC_HAS_STACKPROTECTOR
>         bool
>         option shell="$CC -Werror -fstack-protector -c -x c /dev/null"
> 
> After I thought a bit more, the following syntax is more grammatical,
> and flexible.
> 
> config CC_HAS_STACKPROTECTOR
>         bool
>         default $(shell $CC -Werror -fstack-protector -c -x c /dev/null)

Looks good - but maybe we should go one step further.

So we in the syntax explicit handles:
- shell commands
- other commands, defined as strings
- environment variables
- config variables

Each case is explicit - so the reader is not confused what is used when.

$(shell foo)	- output of the shell command foo. Uses $SHELL as the shell.
		  May include optional paramters.
		  foo may be a config variable referenced using ${} or a config variable prefixed with $
		Example:

		config BUILD_DIR
			string
			default $(shell cd ${objtree}; pwd)

$(call bar)	- output of the bar command that may take optional parameters.
		  bar may be a text string, a config variable or an environment variable
		   The definition of bar may reference the parameters using $(1), $(2)
		   In this context a config variable needs to be prefixed with $

		Example:

		config reverse
			string
			default $(2) $(1)

		config NEW_ORDER
			string
			$(call $reverse, A, B)	# Will assign REVERSE the value "B A"


		Example2:

		config CC_OPTION
			string
			default $(shell ${srctree}/scripts/cc-option ${CC} $(1) $(2))

		config CC_OPTIMIZE
			string
			$(call $CC_OPTION, -Oz, -Os)


${FOO}		- environment variable

The above is inspired by how make implement similar functionality.

I'm not happy that we in one context can reference CONFIG variables
directly, but inside the $(call ...) and $(shell ...) needs the $ prefix.
But I could not come up with something un-ambigious where this could be avoided.

The above proposal include the functionality of the macro stuff proposed in this patch-set.
But with a simpler syntax and we keep all the other kconfig logic (depends on etc) - so
users will not be limited in their creativity.

> Current limitations:
> 
> Dependency on outside scripts.
> Inter-option dependency:
> Functions are evaluated statically:

Same limitations exists with the syntax suggested above.

	Sam

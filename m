Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522256109; cv=none;
        d=google.com; s=arc-20160816;
        b=e6KGs8KlVNJQOF8w+I8v4o+PHLOMRXQNbj+Qg9d9TItC9vdGC1/geFiZWSjUEM8qQ6
         TV5KfJyDV0N+xpNkqfgkAM5yc+HF7f9DL9Nrz8LS4RAS9Tz8bGT2EmgJnrZyJH8377S2
         FnKFUsMYxVHezSuFWRfpMXBlOhVKTUX8ugZKqSjRoLyTT7J2bFuXEnE2Qeo2AUy2Hhmi
         QwUDkxrT8FpECNX/TxtadUong0Ya/xUJHqJOMKxRhigoeijizjnU//kJIniD855hKzhU
         +sT57SkLvllZUM23CwTcei5cp9TVCSBU50uXr4gTxe6Io3PjaoG67Hv4re1PPcG2AneF
         amRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
        b=SqP+cRFHV4jLN+2DqkBUerstpc/oFU4LVObhJrJOet7PlGJPAiyumsT+zXabZBvzre
         cRlszX0ykz03Koj6h5zWaNiGi+9o89FwKwDzeRC3RVG+drIRvvC3AfjvKJp1QbJkgzgu
         jEKoGPX67FqHhsJtOJYHHWSK4HP2ka2RCIegGKWUrHAaLDSg7sy6AAcxcKEF9UvoYnQ9
         XqpuYRVMoR//n2J5DpG76IU15JJSpcRBaUC+xryUs49BRTrZ5xcL+FvCook3LASDwR3D
         dbpH9FPMMFizgUrsQukFjH0o3lboY/ikzGiXtahwep7btUTc4l/GY1zJ/NFTAfkGa9jE
         cMBA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Lx1Vfi6y;
       dkim=pass header.i=@chromium.org header.s=google header.b=C9F023bT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Lx1Vfi6y;
       dkim=pass header.i=@chromium.org header.s=google header.b=C9F023bT;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/AaLNWnGImizTYImMY7WTQ/KVrr96pT4C3C5y6iI+e3+5ICgEO9lC7H7JLJZic5Jr9QqExXYJ9ZLR+fu29qKM=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com> <20180328152714.6103-1-shea@shealevy.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 09:55:07 -0700
X-Google-Sender-Auth: pJbrkNlGYsOjm2QGq3dxmEwoNP4
Message-ID: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
	Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
	David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
	Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Vladimir Murzin <vladimir.murzin@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
	Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
	Rob Herring <robh@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Balbir Singh <bsingharora@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>,
	"Oliver O'Halloran" <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
	Wei Yang <richard.weiyang@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>, Rob Landley <rob@landley.net>,
	Florian Fainelli <f.fainelli@gmail.com>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
	linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-am33-list@redhat.com,
	nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
	linux-parisc <linux-parisc@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
	linux-s390 <linux-s390@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>,
	sparclinux <sparclinux@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596201222621078100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
>
> Signed-off-by: Shea Levy <shea@shealevy.com>

Yay consolidation! :)

> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>         default ".lzma" if RD_LZMA
>         default ".bz2"  if RD_BZIP2
>         default ""
> +
> +config HAVE_ARCH_FREE_INITRD_MEM
> +       bool
> +       default n

If you keep the Kconfig, you can leave off "default n", and I'd
suggest adding a help section just to describe what the per-arch
responsibilities are when select-ing the config. (See
HAVE_ARCH_SECCOMP_FILTER for an example.)

-Kees

-- 
Kees Cook
Pixel Security

Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522408523; cv=none;
        d=google.com; s=arc-20160816;
        b=wvzUfDNI0k8xemxgMk0GslyD50ii4psGsR1+38Z4Zq5f8yd1unepS8KzODETCKlHnU
         luPP3L1ZVBSRThGw/ls0Z1RAkZohgLut3ETjdeRfc0V+PZUcAmg46QH7xtFQm+gSmcGj
         Ca8JSUmLqI2wwTVxw6vklhR6km/my3q5mWXWjZUL1n+FKsY3A0esGWbP2LhOvfR2nmgw
         +fUubCn4aPZIvKXiXet+AEVxrwVd8vu4B++en5RgfwFTLbhXs0NJSfKI2iBTZpAR8zWy
         1/Pj9yBotNdJn4W+VttAGxWV+XMDRubw6w9sqzLKZ+brWsxcNYybne37PwyHXAVdhaMS
         E+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=rXlwKiGp/tjcc21tBymr4J+1neoT8IuyCWGzifMsAiI=;
        b=NxvH/Yi3OguJb+ssV7ft9ZWd28RsBDIvzzOKDNdEmn61t/xYuucSzT7W1OaLTcABJN
         jpGD1zlfSLiElaQ0HF4UwPSZ+pyG9F5aVObhYNQ6b9KLyD98e8Cf8slQw3mOJOqU199U
         Moci0O0inBeUnBW9oWNJTVAg/gWje1vg9RlI1oBv2ZAktTQuCtvR3nYE9MjZYZdz8y7F
         IBXWUDHTXlEBnfnUB7+tCqLsMZPI0aDGkkIQ7w4Tw02/hsH/njORZM3cJFUh5/ZAagvU
         O5nMa7+H4EjsTDcNgNl3hFGrA/PGlwUwhmRyFsa3JCJ/M572P4SPPzTNJl20TtcrgjtV
         ze4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fysDn56U;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fysDn56U;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx49B69d0qqumGJq+mzslTiIIbKql1MnH1QTbx/qAhVh2KpmUPGrnHfDHaflm8NUa4Su4njHlHQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 30 Mar 2018 13:15:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@synopsys.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>,
	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
	Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Ralf Baechle <ralf@linux-mips.org>,
	David Howells <dhowells@redhat.com>,
	Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
	Rich Felker <dalias@libc.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>,
	Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>,
	Balbir Singh <bsingharora@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Joe Perches <joe@perches.com>, Oliver O'Halloran <oohall@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Deepa Dinamani <deepa.kernel@gmail.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Rob Landley <rob@landley.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	adi-buildroot-devel@lists.sourceforge.net,
	linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
	uclinux-h8-devel@lists.sourceforge.jp,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
	linux-mips@linux-mips.org, linux-am33-list@redhat.com,
	nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net,
	linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180330111517.rrx6gs2skkgk336j@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596361039737299330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Shea Levy <shea@shealevy.com> wrote:

> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
> 
> Signed-off-by: Shea Levy <shea@shealevy.com>

Please put the Kconfig symbol name this patch introduces both into the title, so 
that people know what to grep for.

> ---
>  arch/alpha/mm/init.c      |  8 --------
>  arch/arc/mm/init.c        |  7 -------
>  arch/arm/Kconfig          |  1 +
>  arch/arm64/Kconfig        |  1 +
>  arch/blackfin/Kconfig     |  1 +
>  arch/c6x/mm/init.c        |  7 -------
>  arch/cris/Kconfig         |  1 +
>  arch/frv/mm/init.c        | 11 -----------
>  arch/h8300/mm/init.c      |  7 -------
>  arch/hexagon/Kconfig      |  1 +
>  arch/ia64/Kconfig         |  1 +
>  arch/m32r/Kconfig         |  1 +
>  arch/m32r/mm/init.c       | 11 -----------
>  arch/m68k/mm/init.c       |  7 -------
>  arch/metag/Kconfig        |  1 +
>  arch/microblaze/mm/init.c |  7 -------
>  arch/mips/Kconfig         |  1 +
>  arch/mn10300/Kconfig      |  1 +
>  arch/nios2/mm/init.c      |  7 -------
>  arch/openrisc/mm/init.c   |  7 -------
>  arch/parisc/mm/init.c     |  7 -------
>  arch/powerpc/mm/mem.c     |  7 -------
>  arch/riscv/mm/init.c      |  6 ------
>  arch/s390/Kconfig         |  1 +
>  arch/score/Kconfig        |  1 +
>  arch/sh/mm/init.c         |  7 -------
>  arch/sparc/Kconfig        |  1 +
>  arch/tile/Kconfig         |  1 +
>  arch/um/kernel/mem.c      |  7 -------
>  arch/unicore32/Kconfig    |  1 +
>  arch/x86/Kconfig          |  1 +
>  arch/xtensa/Kconfig       |  1 +
>  init/initramfs.c          |  7 +++++++
>  usr/Kconfig               |  4 ++++
>  34 files changed, 28 insertions(+), 113 deletions(-)

Please also put it into Documentation/features/.

> diff --git a/usr/Kconfig b/usr/Kconfig
> index 43658b8a975e..7a94f6df39bf 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>  	default ".lzma" if RD_LZMA
>  	default ".bz2"  if RD_BZIP2
>  	default ""
> +
> +config HAVE_ARCH_FREE_INITRD_MEM
> +	bool
> +	default n

Help text would be nice, to tell arch maintainers what the purpose of this switch 
is.

Also, a nit, I think this should be named "ARCH_HAS_FREE_INITRD_MEM", which is the 
dominant pattern:

triton:~/tip> git grep 'select.*ARCH' arch/x86/Kconfig* | cut -f2 | cut -d_ -f1-2 | sort | uniq -c | sort -n
    ...
      2 select ARCH_USES
      2 select ARCH_WANTS
      3 select ARCH_MIGHT
      3 select ARCH_WANT
      4 select ARCH_SUPPORTS
      4 select ARCH_USE
     16 select HAVE_ARCH
     23 select ARCH_HAS

It also reads nicely in English:

  "arch has free_initrd_mem()"

While the other makes little sense:

  "have arch free_initrd_mem()"

?

Thanks,

	Ingo

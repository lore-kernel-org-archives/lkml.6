Return-Path: <richard.weiyang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522285941; cv=none;
        d=google.com; s=arc-20160816;
        b=Yk/q8x6LZ8XzCMNQ7VaP6l7B+efciQQYHbGfiKJjjrsFyvXP9GsYjoGVKj2hsP6pE/
         AipVW9LCNT02IP8sq8Y6j8s7BF504+HmRj9Vl07EziviA9lKUh1gadeLLJFk0ywkQBbk
         4dPY2c19w6qIg5AsRSbTAYnfvlxwSZf0BB0k4uEX/QTYqRW2wj/RBR9wfnvwNx/x7DNW
         OiNF8ADpaprPWfn26f/qOIk3RQ8ZRITKpEW07UDdzTf9ZKiSFgii0PdXQs0mMf3zHcS7
         FOlsLTnvjjwuLJCaOXahLJrmBJy4JznT5xAcOdm+/+bJYEt73+MZwBrCyx5kxVJfFAw9
         mtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GAsEAuA/4wkkmLXuWBTfZ4TahUKEhDVaSCN3DyLMjvE=;
        b=FX63dgiinPPIj518W7KKSBliNJM4lGreaQwC7nbfZ6NOUpiNKG6sDZhz0D/Tb40Wex
         5vbrcPM6z4F5/FwlmDhwDBLOT56srlvVP7FB7U5F3hmsophpp3tb9XGBEyZDoQWdQOft
         u+zr3HWW8ELDMTOc0+STTLnu/r7SPntRs8hTr4JVox/U8fglG1YWDTZDCsIXbkscCwbp
         izS4aOvFyJJVWH8BWDQtJygbMnAtvV7jhohjZ0EE+1ASpqBitr9b+pRmBUWasM/wFdWU
         dS43aHFKBv6vy8vbcOl+UfToHvSvDyePpM8puSMkgBMCkC9gBlgm7Ykmq29YFDNTS1O4
         Ostw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LHfXHTp7;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LHfXHTp7;
       spf=pass (google.com: domain of richard.weiyang@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=richard.weiyang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48kiM9+mVxnOH2o0IX/MD4L9mQM3AoMsbZywd49Q/fHuYkETWQP9/yuofvEraKatP6oLMPEPw==
Date: Thu, 29 Mar 2018 09:12:10 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
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
	X86 ML <x86@kernel.org>, Chris Zankel <chris@zankel.net>,
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
	Vlastimil Babka <vbabka@suse.cz>,
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
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	adi-buildroot-devel@lists.sourceforge.net,
	linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
	uclinux-h8-devel@lists.sourceforge.jp,
	linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>,
	linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
	openrisc@lists.librecores.org,
	linux-parisc <linux-parisc@vger.kernel.org>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	linux-sh <linux-sh@vger.kernel.org>,
	sparclinux <sparclinux@vger.kernel.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net,
	linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180329011210.GA4275@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596232504011184934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 09:55:07AM -0700, Kees Cook wrote:
>On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
>> Now only those architectures that have custom initrd free requirements
>> need to define free_initrd_mem.
>>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>
>Yay consolidation! :)
>
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>         default ".lzma" if RD_LZMA
>>         default ".bz2"  if RD_BZIP2
>>         default ""
>> +
>> +config HAVE_ARCH_FREE_INITRD_MEM
>> +       bool
>> +       default n
>
>If you keep the Kconfig, you can leave off "default n", and I'd
>suggest adding a help section just to describe what the per-arch
>responsibilities are when select-ing the config. (See
>HAVE_ARCH_SECCOMP_FILTER for an example.)
>

One question about this change.

The original code would "select" HAVE_ARCH_FREE_INITRD_MEM on those arch.
After this change, we need to manually "select" this?

>-Kees
>
>-- 
>Kees Cook
>Pixel Security

-- 
Wei Yang
Help you, Help me

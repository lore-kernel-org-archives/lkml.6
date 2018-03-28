Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx4/5hCAzbxPN3RQzLKxvnfBWXedV3vWJCz7UURcDqgIIu3sPAVa9YejCZ+4PNCIQZSnjcPDw
ARC-Seal: i=1; a=rsa-sha256; t=1522255983; cv=none;
        d=google.com; s=arc-20160816;
        b=vKtKSCOu7iGsaGh1iJP03orrnKP03dDlfcqbVZwM8o2m+4ZqqoakjnhE2zJt/Jsg0u
         hgsRLViCGNOYFqY5fXJQboSnZqH+RweO+Gc+09BrA/KLcWCpUDUxFpjSuTJ3hF5EdNnE
         vVlLCEl08evw2GJX11mPFkxh5xn772NNpva6G7c3Flq1mZ3pxWFdv5X8CM0mL5+M1htu
         EbODjDBHAz8QcWm4iT1Qtg40Yr1Gq33UywjzvTLHv5ktC6q8/eGJJctrnwFLTXD+xu7+
         Y6i+yhcDctvSiMmKz5RMwTr05AK8RXuCGVhO3fBSrCG7L42FPNGqp7BG5GqoZVdu1VBP
         BaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=iIi57hmdUHu/G2PcLLQKVvJN4dL/nzk3JYon59E2zQw=;
        b=GNLH+qAZyl8UkMj9nfEuC1zNZvJ5JdsPa9VBfleghA2vJc/Al5J1IFz/yAkuf8Xr8f
         C7rCoHyTBm8vTkewO8yVTDi013lhHmgovs8ZzSJmpNrR/muOVT8QLrnarzO1GdpmsVF9
         OQEVaNSsNYMczhD+ts9vap3BgnJuq7AfO71PxUUV2RJFkD111x+P1hDf2Ob8IDCYtKXl
         hywUqBvurgSZ4WaJKkFs6ufgi0UV02Dgtb7vfIGfBRPs4gYTT/z4ObXGxOWniXPlb/WF
         wu5hFaqhgTRw02aZZVBf9a1gVlxunZFA0bzANagtZdK4f/c4Rg+V+E7vOo7xPmRTnVzv
         GYcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=oPiSPwhd;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=oPiSPwhd;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Wed, 28 Mar 2018 17:48:14 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Rob Landley <rob@landley.net>
Cc: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@synopsys.com>,
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
Message-ID: <20180328164813.GA3888@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596201090209533892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> On 03/28/2018 10:26 AM, Shea Levy wrote:
> > Now only those architectures that have custom initrd free requirements
> > need to define free_initrd_mem.
> ...
> > --- a/arch/arc/mm/init.c
> > +++ b/arch/arc/mm/init.c
> > @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >  {
> >  	free_initmem_default(-1);
> >  }
> > -
> > -#ifdef CONFIG_BLK_DEV_INITRD
> > -void __init free_initrd_mem(unsigned long start, unsigned long end)
> > -{
> > -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> > -}
> > -#endif
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 3f972e83909b..19d1c5594e2d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -47,6 +47,7 @@ config ARM
> >  	select HARDIRQS_SW_RESEND
> >  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> > +	select HAVE_ARCH_FREE_INITRD_MEM
> >  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> 
> Isn't this why weak symbols were invented?

Weak symbols means that we end up with both the weakly-referenced code
and the arch code in the kernel image.  That's fine if the weak code
is small.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

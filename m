Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx48dWmPgDo4NbkgqbhdpmoyvvmRHfC+dDjUWYVeZWvNziaRWeTY3GSr+DrpflYYoCLkG5M8G
ARC-Seal: i=1; a=rsa-sha256; t=1522337489; cv=none;
        d=google.com; s=arc-20160816;
        b=Ng2ycxo8Fi9t3R1e9bAywvNXlygH9xZUjzvAtFiTyPZol+ddwpjrCfCeKwEr/1wH/j
         g77i+TaARkZVuFuY9SqPalmsGvvirwZqzbm78yyfqsSRcu246M32U2rmqRgQJ+BLia+M
         PBd5UtaB2vSLr3wDEMNV1+yvGRVg75/vVNSQnyBaTX76LjI6w3P7vHKUOCoc1E3wk/it
         /04oROvBiVsgGu4erq7WO+PolhkXi7blnQ4x9TjGO+vEI51mJ1b0Nua9VEQOgJ2V5lxw
         w71h74yUEyQKmIAWtxJf4YG+gwHcB2EujtevVMNG5IXw3YLdJH9Z6MsVX31EG9tECZsC
         VDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tszDhZ36qEhT+cbTS7MjWHFiFTBM6apHylUvgVhpCDU=;
        b=zkETlT0ZJi8dVidHZWTLfyguHHZ3tkbJ1xePpNpVrtt4bc1z1YtINlAtAFuaO05U8b
         LySAaiBAdAfw/hUmsGw3xOSGSue4mCZyNHUXFrEi5EvPtrJBm4arG5rwuQMs/5wkbAjQ
         mxwRmWkKDGZxoE+xUJV24nQuFEQ9ZDhsgnr/LMWSH5oB5XvQCF25NI5EmCexv72kjJHm
         i0p112K9EAI0cvh+3EszpxYGy35Gxh/BrOuyhi0lBZ3ZSjSohG8ABofivjYJWVku6FTF
         iFc+3xvoB07/J6qhUvdbyfxOPlVujXNrdYuF1QdjUITgYk8Z0JIgapgvelKCLh+l6Ubz
         HXJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=ePCJ3cfQ;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=ePCJ3cfQ;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Thu, 29 Mar 2018 16:27:49 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Oliver <oohall@gmail.com>
Cc: Rob Landley <rob@landley.net>, Shea Levy <shea@shealevy.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
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
	Joe Perches <joe@perches.com>,
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
	linux-parisc@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net,
	linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180329152749.GC16141@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596286555119369267?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
> >>
> >>
> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> >> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
> >> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
> >> >>> Now only those architectures that have custom initrd free requirements
> >> >>> need to define free_initrd_mem.
> >> >> ...
> >> >>> --- a/arch/arc/mm/init.c
> >> >>> +++ b/arch/arc/mm/init.c
> >> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >> >>>  {
> >> >>>   free_initmem_default(-1);
> >> >>>  }
> >> >>> -
> >> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> >> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >> >>> -{
> >> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >> >>> -}
> >> >>> -#endif
> >> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> >>> index 3f972e83909b..19d1c5594e2d 100644
> >> >>> --- a/arch/arm/Kconfig
> >> >>> +++ b/arch/arm/Kconfig
> >> >>> @@ -47,6 +47,7 @@ config ARM
> >> >>>   select HARDIRQS_SW_RESEND
> >> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >> >>> + select HAVE_ARCH_FREE_INITRD_MEM
> >> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
> >> >>
> >> >> Isn't this why weak symbols were invented?
> >> >
> >> > Weak symbols means that we end up with both the weakly-referenced code
> >> > and the arch code in the kernel image.  That's fine if the weak code
> >> > is small.
> >>
> >> The kernel's been able to build with link time garbage collection since 2016:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> >>
> >> Wouldn't that remove the unused one?
> >
> > Probably, if anyone bothered to use that, which they don't.
> >
> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > what I can see, nothing selects it.  Therefore, the symbol is always
> > disabled, and so the feature never gets used in mainline kernels.
> >
> > Brings up the obvious question - why is it there if it's completely
> > unused?  (Maybe to cause confusion, and allowing a justification
> > for __weak ?)
> 
> IIRC Nick had some patches to do the arch enablement for powerpc, but
> I'm not sure what happened to them though. I suspect it just fell down
> Nick's ever growing TODO list.

I've given it a go on ARM, marking every linker-built table with KEEP()
and comparing the System.map files.  The resulting kernel is around
150k smaller, which seems good.

However, it doesn't boot - and I don't know why.  Booting the kernel
under kvmtool in a VM using virtio-console, I can find no way to get
any kernel messages out of it.  Using lkvm debug, I can see that the
PC is stuck inside die(), and that's the only information I have.
It dies before bringing up the other CPUs, so it's a very early death.

I don't think other console types are available under ARM64.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

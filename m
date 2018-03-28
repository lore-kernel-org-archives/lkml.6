Return-Path: <rob@landley.net>
ARC-Seal: i=1; a=rsa-sha256; t=1522252742; cv=none;
        d=google.com; s=arc-20160816;
        b=GEPz4C7rzPcPKn8bdbq2GP1Pim/LsP7WyhSkULx4zDZXqlebz3/QW9O0kCFZP9bXOq
         9oe7dVQGVx0/jL7uYBRdms6nQZDytnwLzOW1cBGNZkiD8mKueAbyrPD+W3l+YFUX1UQd
         im1O4kPNltKuAzxkuf4VCZxL6jqfL63EbkB182ueI80/nNk27jbZkbuhwdnOt4OTuV4t
         WJX5p5h4SwUBPFg41L/1DcfCsjtS0GrSGDrcDC29webLFS5Y1cHPCx2Yc8OaTdkexdkK
         dfocrXvsn9DqMz0ukXdcfrOC8d+X8YXXy6DIDu3Tww8j1YFiqhvBYBLmyBFU9KDk6gqN
         LxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=qSDkcmbz+hhYmqe2ncZumACqLvxx9LwbFbBwrEiskLE=;
        b=wOhE6ojFzF/s/370YvH5+6kGNVio5cC9JRTu2RedYiDSmlx14VzaxKvAHxZTFDi12D
         ct71ajmv5DkXHnV9bko5RrndKpZ05AV2ZkRBAChTp8jgYKbWOdsfOZJSzR26ySi3Ug0r
         CZbbtFS9lsx5wzZpX4jGq3Nxs4OGszXCFykHpI62rFQG5R8xyYVfoygigPdPe84ikB1y
         NePYSuoWJTPbcJzLkxloKDzjw10ga10s30xYH6xZGBd8O5A9BK2gAOUjYmVVUoRsQ00N
         Tc/6bKp5sl0Kj8iRAeCuQh6C+tVLt4dSkeimGqDrqbtmrgj7Y4V/Ra3udBp8H/o5NOc+
         1TKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=RL0IGzUY;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@landley-net.20150623.gappssmtp.com header.s=20150623 header.b=RL0IGzUY;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of rob@landley.net) smtp.mailfrom=rob@landley.net
X-Google-Smtp-Source: AG47ELss7e9gTw/EW5uReqslv5gSdy/QsSqOI9SxFyO+YGUYNMIXTL22ku6bXZmM+LXFQUNNTCNiQQ==
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Richard Henderson
 <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller
 <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
 Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Vladimir Murzin
 <vladimir.murzin@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>,
 Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams
 <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
From: Rob Landley <rob@landley.net>
Message-ID: <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
Date: Wed, 28 Mar 2018 10:58:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596195734883590774?=
X-GMAIL-MSGID: =?utf-8?q?1596197691354271589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 10:26 AM, Shea Levy wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
...
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>  {
>  	free_initmem_default(-1);
>  }
> -
> -#ifdef CONFIG_BLK_DEV_INITRD
> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> -{
> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> -}
> -#endif
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f972e83909b..19d1c5594e2d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -47,6 +47,7 @@ config ARM
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> +	select HAVE_ARCH_FREE_INITRD_MEM
>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU

Isn't this why weak symbols were invented?

Confused,

Rob

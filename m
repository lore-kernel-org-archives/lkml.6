Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx4/jbVcqFHd4O0xcf9vRBYnVOUJRuz1OM9BCdEXA5+bqI625vCypVxlXmDLR9HvGeFjgE0Yb
ARC-Seal: i=1; a=rsa-sha256; t=1522692990; cv=none;
        d=google.com; s=arc-20160816;
        b=XE0yfysR9A63zSJozAZ0rRgdjJ9MT5yZCpCAV6h0Yeo5InI1/NEDW9eUbJbKGeicro
         hj/u/9F29MUAzto684/g6NKyAsioDd3yy8s49bF0itqJnyDdiUwPirnK33wVf5Z/BWMy
         oz61ngbW9JsrPZ03G6fWe6/bRgpyUpdccMYGlRNFtSzF9aLFyVIdYptgVqdlhc7jA7hA
         ENSpYcqm4LGC1i1KuXsA2kc1pVDpE3p/a/7GGltWHv8Vmv6A5vQ+kbmmuG7+V1WNmYox
         f8hqvkZEC/2po3WPdZe/6firaSDSEew3tlEovi6VY+Psd8THTUFSPExIWDY9UNAyUrYy
         s7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=jYfSrkpv8FOUzemlQoG3h7Mxq7My+IRLeJola3h8FBw=;
        b=JZWgmqm4hCskgErOpNqeJVP6YASHucbueDUHea0oH8yjGxgmfxNcSU401Xb1Bcb9xw
         LVzX0Yp/mi4Nmi2ZueoqlZxTqv6Vd3Rf6xmruEesW+uAxS/dRoQKFe6eBUQjhbxFpBTU
         pfWKis8W/G6PenoT3ss00732lQWpTfq2b9OYJJK9GXPEsjZjvThN0kpQiNdhydOAO6ZK
         xHha3FPCLNJ7JBJPRZ8D8IM5Dbb5iA/Okw8Lpi3IT1oNnLFwRt6ku+eascMH6lJ6bTOS
         ktwmhFtlZKS/JLQol+ykdbHhZisYcMPFy5Cze5fltHwiVy/P3DiNLjm+EaC5F6t9zIGO
         GMdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=rPxSnY+D;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=rPxSnY+D;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Mon, 2 Apr 2018 19:15:37 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Abbott Liu <liuwenliang@huawei.com>, kstewart@linuxfoundation.org,
	tixy@linaro.org, grygorii.strashko@linaro.org,
	julien.thierry@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
	linux@rasmusvillemoes.dk, dhowells@redhat.com, linux-mm@kvack.org,
	mark.rutland@arm.com, kvmarm@lists.cs.columbia.edu,
	f.fainelli@gmail.com, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
	geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
	zhichao.huang@linaro.org, aryabinin@virtuozzo.com,
	labbott@redhat.com, vladimir.murzin@arm.com, keescook@chromium.org,
	Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
	philip@cog.systems, jinb.park7@gmail.com, opendmb@gmail.com,
	tglx@linutronix.de, dvyukov@google.com, ard.biesheuvel@linaro.org,
	gregkh@linuxfoundation.org, mawilcox@microsoft.com,
	linux-kernel@vger.kernel.org, alexander.levin@verizon.com,
	james.morse@arm.com, kirill.shutemov@linux.intel.com,
	pombredanne@nexb.com, Andrew Morton <akpm@linux-foundation.org>,
	thgarnie@google.com, christoffer.dall@linaro.org
Subject: Re: [PATCH v3 5/6] Initialize the mapping of KASan shadow memory
Message-ID: <20180402181536.GJ16141@n2100.armlinux.org.uk>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-6-liuwenliang@huawei.com>
 <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637214651692602?=
X-GMAIL-MSGID: =?utf-8?q?1596659325367854757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 02:08:13PM -0400, Nicolas Pitre wrote:
> On Mon, 2 Apr 2018, Abbott Liu wrote:
> 
> > index c79b829..20161e2 100644
> > --- a/arch/arm/kernel/head-common.S
> > +++ b/arch/arm/kernel/head-common.S
> > @@ -115,6 +115,9 @@ __mmap_switched:
> >  	str	r8, [r2]			@ Save atags pointer
> >  	cmp	r3, #0
> >  	strne	r10, [r3]			@ Save control register values
> > +#ifdef CONFIG_KASAN
> > +	bl	kasan_early_init
> > +#endif
> >  	mov	lr, #0
> >  	b	start_kernel
> >  ENDPROC(__mmap_switched)
> 
> Would be better if lr was cleared before calling kasan_early_init.

No.  The code is correct - please remember that "bl" writes to LR.

The point of clearing LR here is to ensure that start_kernel is called
with a zero link register, which it won't be if kasan_early_init is
moved after it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

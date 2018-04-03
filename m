Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx48GCCEkfN7XaVHFiZYW1gj/3mo6n+vpZegZCCKY+I9vfvFI+OfHNYbuKXiBk25iBOPqOzIf
ARC-Seal: i=1; a=rsa-sha256; t=1522755546; cv=none;
        d=google.com; s=arc-20160816;
        b=uVfz/l9+sDPw14tCuXodre6nkkKQctEsUbje4vkVzBOO8KWPP8TD9IDu+6kwlXv0ND
         wd0ioV7IpBHLEHQHVLH3R4oKUz8ulmmoGppgHVmGcTjDCrn4+ciw93DnZiUUmezha937
         yEtVuy21t+C8fHoGUrJtY9Q40ghw25427OMHzoXDHqCDjL1AFZPUOxmlXOcugtx6LitU
         r5ZRfjW8x91J/6IzQm+qZjBd60Z2Eq7AjmEiJfTI2mB9gs/WpmyOYrHeBazkSvidFQpT
         wgIKYeVLIRXsabJ7Ih+e+OTwDbnd8pReUbRYpYDezXxWDzyFKcvZL1HrZPjBmDu1LHBA
         vYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qLQhq3iY7hF49eIDuYbrjg5KLP1qzGt1xNWmRL0Ij5c=;
        b=hdnOxN83ZJH/qYK0amPb69WBqgjxOKg7M2dr3bD3pIfu5OaRNWMTrLA/NaMCzli4D3
         4Tb1WqlB+Nh6Nw27VuY/j/XCTnjjoTlL0CfEESqteNWRZx48sQDg0gl84GYAccpY+oZS
         QzVKIgQS4RrNYKNAUlK+w1gyQSSTJEs1VMvTmmKM2K0FsZ+P+tIDSgBrkDqhiNJaDchf
         g+Lvuksns884t5+wgU/VgTzZOPYGXkjfnIas/sggSgJYfckU2bbx1kB24pfqK74duah0
         Kgc29GfzfcMtT0Xf0D6rvhPVp/k8jFpQto/IhQRN9eVZt7MIIy5NgUJWcwhU40+eVhrO
         +cBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=ll8ZDaVL;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=ll8ZDaVL;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Tue, 3 Apr 2018 12:38:37 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Abbott Liu <liuwenliang@huawei.com>, aryabinin@virtuozzo.com,
	dvyukov@google.com, corbet@lwn.net, christoffer.dall@linaro.org,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	f.fainelli@gmail.com, akpm@linux-foundation.org,
	linux@rasmusvillemoes.dk, mawilcox@microsoft.com,
	pombredanne@nexb.com, ard.biesheuvel@linaro.org,
	vladimir.murzin@arm.com, alexander.levin@verizon.com,
	nicolas.pitre@linaro.org, tglx@linutronix.de, thgarnie@google.com,
	dhowells@redhat.com, keescook@chromium.org, arnd@arndb.de,
	geert@linux-m68k.org, tixy@linaro.org, julien.thierry@arm.com,
	mark.rutland@arm.com, james.morse@arm.com, zhichao.huang@linaro.org,
	jinb.park7@gmail.com, labbott@redhat.com, philip@cog.systems,
	grygorii.strashko@linaro.org, catalin.marinas@arm.com,
	opendmb@gmail.com, kirill.shutemov@linux.intel.com,
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/6] Disable instrumentation for some code
Message-ID: <20180403113837.GK16141@n2100.armlinux.org.uk>
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-3-liuwenliang@huawei.com>
 <7837103a-bcf0-6b00-14d6-bd6b80649886@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7837103a-bcf0-6b00-14d6-bd6b80649886@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637215509017214?=
X-GMAIL-MSGID: =?utf-8?q?1596724919178392332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 12:30:42PM +0100, Marc Zyngier wrote:
> On 02/04/18 13:04, Abbott Liu wrote:
> > From: Andrey Ryabinin <a.ryabinin@samsung.com>
> > 
> > Disable instrumentation for arch/arm/boot/compressed/*
> > ,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
> > code won't linkd with kernel image.
> > 
> > Disable kasan check in the function unwind_pop_register
> > because it doesn't matter that kasan checks failed when
> > unwind_pop_register read stack memory of task.
> > 
> > Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Just because I replied to this patch doesn't mean you can stick my
> Reviewed-by tag on it. Please drop this tag until I explicitly say that
> you can add it (see Documentation/process/submitting-patches.rst,
> section 11).
> 
> Same goes for patch 1.

Same goes for that reviewed-by line for me.  From my records, I never
even looked at patch 2 from the first posting, and I don't appear to
have the second posting in my mailbox (it's probably been classed as
spam by dspam.)  So these reviewed-by lines seem to be totally
misleading.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

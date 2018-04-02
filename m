Return-Path: <nicolas.pitre@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522693218; cv=none;
        d=google.com; s=arc-20160816;
        b=GPunxmuE9ankSoO5942ju3+doa/OxhkiEyUnnTYBpDACVYE+2ClKj1rdoqQ2jZ/ZyI
         oW1FPwsyopoY4/kh1sp/7IXq/FC7L+xYS9yg0jXxMUsx/oZXxtn3JU5Wjb1R8F6hqoHl
         4CCstmPr7wW1DMr1NtglUnFFMSIyw9wi3l+aNSG4JIjj9RTxNdPBu2JBh4mXxowoYJ+F
         QgU+eXe83zUJX2A6RGT7TRGuJaDikSwVzJoTtY3ViDGMrcoFsmSe1yNOakVfGZtvWFd7
         jg0COLkNJQ+jgaL89AVSHhBzRKgnezZ48xV1Gl5dqHBm5c6NeShkFKdZ5q0bU0KXsIQ1
         dX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=PXnl9t3unwaczbJ7SBchb7sQfQIY9LA3+ZKbrnDz1iU=;
        b=s6LS+O+zXLPKZ7Jfl/pi0vlTywRFEuVCC7B7OFXPAD1U6+BSr65GqaOuW9fJbL1ima
         VL/DWfmFNQCE8MhCEnp7dCLWAv0epDFYccsQGCXDq9kn+M5IyPhVPbqFCzNTn7Dt9lP8
         f67YKYVZGV8jXiFLmouHJkGc870ieHhXg/e8wPXAPhJGlyl3i+FI0vCShjmoddSk+fHt
         AcSO5XpmlZmrAsyAuhcIN7+2mEEkk96LXD6+dHwSb4Da3R4tej2Nyw4ZwcdWdr3RgQUh
         osdTP7OfiUULYJO0eDjyN34ncIyTuG5/L/J+GRUYU2P47DpFSpJkzQ1ZLJcM6TIWPSSq
         VVjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EHVdI8Lg;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EHVdI8Lg;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49WEhHo6w8rYiPIiTDgAT18DqlCDp8wI//Zr+IJ5boxupxA8RQduvO3BG0T9BrmPU669QVC9g==
Date: Mon, 2 Apr 2018 14:20:15 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
cc: Abbott Liu <liuwenliang@huawei.com>, kstewart@linuxfoundation.org,
    tixy@linaro.org, grygorii.strashko@linaro.org, julien.thierry@arm.com,
    Catalin Marinas <catalin.marinas@arm.com>, linux@rasmusvillemoes.dk,
    dhowells@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
    kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com,
    Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
    kasan-dev@googlegroups.com, geert@linux-m68k.org,
    linux-arm-kernel@lists.infradead.org, zhichao.huang@linaro.org,
    aryabinin@virtuozzo.com, labbott@redhat.com, vladimir.murzin@arm.com,
    keescook@chromium.org, Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com,
    philip@cog.systems, jinb.park7@gmail.com, opendmb@gmail.com,
    tglx@linutronix.de, dvyukov@google.com, ard.biesheuvel@linaro.org,
    gregkh@linuxfoundation.org, mawilcox@microsoft.com,
    linux-kernel@vger.kernel.org, alexander.levin@verizon.com,
    james.morse@arm.com, kirill.shutemov@linux.intel.com, pombredanne@nexb.com,
    Andrew Morton <akpm@linux-foundation.org>, thgarnie@google.com,
    christoffer.dall@linaro.org
Subject: Re: [PATCH v3 5/6] Initialize the mapping of KASan shadow memory
In-Reply-To: <20180402181536.GJ16141@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1804021418220.28462@knanqh.ubzr>
References: <20180402120440.31900-1-liuwenliang@huawei.com> <20180402120440.31900-6-liuwenliang@huawei.com> <nycvar.YSQ.7.76.1804021402521.28462@knanqh.ubzr> <20180402181536.GJ16141@n2100.armlinux.org.uk>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637214651692602?=
X-GMAIL-MSGID: =?utf-8?q?1596659563722839106?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2 Apr 2018, Russell King - ARM Linux wrote:

> On Mon, Apr 02, 2018 at 02:08:13PM -0400, Nicolas Pitre wrote:
> > On Mon, 2 Apr 2018, Abbott Liu wrote:
> > 
> > > index c79b829..20161e2 100644
> > > --- a/arch/arm/kernel/head-common.S
> > > +++ b/arch/arm/kernel/head-common.S
> > > @@ -115,6 +115,9 @@ __mmap_switched:
> > >  	str	r8, [r2]			@ Save atags pointer
> > >  	cmp	r3, #0
> > >  	strne	r10, [r3]			@ Save control register values
> > > +#ifdef CONFIG_KASAN
> > > +	bl	kasan_early_init
> > > +#endif
> > >  	mov	lr, #0
> > >  	b	start_kernel
> > >  ENDPROC(__mmap_switched)
> > 
> > Would be better if lr was cleared before calling kasan_early_init.
> 
> No.  The code is correct - please remember that "bl" writes to LR.

You're right of course.

/me giving up on patch review and going back to bed


Nicolas

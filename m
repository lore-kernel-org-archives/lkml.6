Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x226MSDVhGK1/RmsxumDdX9YPXlELlojqyQsXyiFwQ511e/gI2XNwCIBUpAhq+rFPYxhaV4n+
ARC-Seal: i=1; a=rsa-sha256; t=1518602419; cv=none;
        d=google.com; s=arc-20160816;
        b=JlwS5gnD9f0a7fGlZrNK2xQ7hS8EdkRBBlP7qAt+SKmRpRBonKhTECGZ1u4rovJAfK
         YNUEPwvmzgax3brDrYLXQ1WITJFeyOVToJZhluoC1SX/2aQLxuyv7Rl5u1tdS7E9hn1P
         V1Wbya//kpRsOm9eDdMuEp6hjzHWjGEr1a/ymwUfpR0CJ2MTQ+23D8IktKSWKNUMAKKc
         3lpZOF4ka56B267Q7uuExgMfxk9N9LsVfdgbUR9fmJrHF5VAy2m2/8s1cK0Zx9RuDUlC
         eOaHoJo4H6LrmMapc9HR9g3BWvg+d2u/syyOvMpVDK/qbDiEM7zvACFSpOphAfE6pPsZ
         POSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=SsrTiuVgdknHDKNDNnU4ekq3QwoLdspTnkMh37bHPNE=;
        b=JbJH6/awtGIqU1R2Xky8LKHxSBKRvFOKIG4HG4d8JupeGwTPPB9oudzjRSwq4DiU8E
         1wgbdRBY5AObZvzDLA05H1zASHCamLODjCg6XwZP5GJ6C9Akf0lY33MtQap7Ml7VpxMI
         b4OiL+l9AYnfg5LhjTW3Y5yL9ntd5PZcWOsxCRIzay5wPOjjeh87Qs3T1KijsnOZVXIl
         7RAz8sBLHAMpoWSvSsiFDJRbk+kwA2LGmEkvn0gDHdo0plGV6OyDmSWPA85GWGjLXvjt
         fbh29j4mAmWWdRM7haQDMRTkDzIEE0WxLWqJgPlKzUoAzXQG4HNTpg8jcWqlgW94iRWY
         GwCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NUkSPDbo;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NUkSPDbo;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Wed, 14 Feb 2018 11:00:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de
Subject: Re: [PATCH 19/31] x86/mm/pae: Populate valid user PGD entries
Message-ID: <20180214100014.GG16484@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <1518168340-9392-20-git-send-email-joro@8bytes.org>
 <3913f255-7309-58c5-b6c3-39cf0e29a844@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3913f255-7309-58c5-b6c3-39cf0e29a844@suse.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914908450442630?=
X-GMAIL-MSGID: =?utf-8?q?1592370050305398630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Juergen,

On Wed, Feb 14, 2018 at 10:45:53AM +0100, Juergen Gross wrote:
> On 09/02/18 10:25, Joerg Roedel wrote:
> > +#ifdef CONFIG_X86_PAE
> > +
> > +/*
> > + * PHYSICAL_PAGE_MASK might be non-constant when SME is compiled in, so we can't
> > + * use it here.
> > + */
> > +#define PGD_PAE_PHYS_MASK	(((1ULL << __PHYSICAL_MASK_SHIFT)-1) & PAGE_MASK)
> 
> I think PAGE_MASK is a 32 bit value here, so you are chopping off
> the high physical address bits.
> 
> With that corrected the kernel is coming up as Xen PV guest.

Cool, thanks for testing these patches and debugging the breakage on
Xen-PV. I'll fix that in the next version.


Thanks again,

       Joerg

Return-Path: <linux@rainbow-software.org>
X-Google-Smtp-Source: AH8x226gIisniBwhdlUYFhvznWd7fSSNyfTnnH1tK1UjpvDMJUc72LoDMZUHyBcy2Y3OApSrzdTK
ARC-Seal: i=1; a=rsa-sha256; t=1517991504; cv=none;
        d=google.com; s=arc-20160816;
        b=BFnSe5nWCxfMlGUXfgUstS63Re2SaZHwu/WmWwqc0wqGGApsF6TOuqf97N8Gl1xOqN
         ZaD6xUv1EzSSUIf+A5W0gydJQSqybdW1ZyVMX7Tpt887aprf5so+C/LOVFjDmOW/Fg51
         vpRJuxG51mvLzEXMR+jSHmBbpDOYN5lTHJan5VakvP3iIuYQnznHyBtwlQjuNKhIItcF
         ckZV2dCb8ir75TxzCrKAL2PbzHgLoCrg+QNbIBCEzUAlp1I0NGa5ThSCH+uOVZDheREz
         HCuMJMu3GSfKaOtYzQxvStQdMS26xhKC4JH3dpIHnQM2S3qs3kbbcZC/nXiLe9UHecxE
         IU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-disposition:content-transfer-encoding
         :mime-version:in-reply-to:references:cc:user-agent:date:subject:to
         :from:dkim-signature:arc-authentication-results;
        bh=1Du+GOB9YcpU63pN5CIHQdCOzsS2KmTiWhHPTIBDaBQ=;
        b=pebQE87D2CQ6K4gWCW+s+/LRG+HZD8BldeaA0wCOo747khVx6BC+Pz4z7BHc+sBofr
         gfJ9PLl+wMCsoIQKtDci1ScUVfAtTG/8Kf2PYhVf7KXKtefSNiUbr5k0JBPf2exrhlBt
         MDFeV7OXUFcVDmKpNIadvHgwPSmx9a9cPAH/GaUmi/Lc9Hm9lTLaVwP/TVtN2cJrrRtS
         hPFAwpIAkfkHbM+TBCSeyotL/o4J7fU3OVz43H/THZtlqIPJVp2nX6dNOJVo5+A9W6Bn
         KRYBqaIDeyTO/6oYCZ0ljkofVr2FSftvbcqIFdcNQ/LDatPkafnxPpBROJr891Nm0EmC
         Q5Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=CoeHABjY;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@rainbow-software.org header.s=atlsmtp header.b=CoeHABjY;
       spf=pass (google.com: domain of linux@rainbow-software.org designates 80.94.52.26 as permitted sender) smtp.mailfrom=linux@rainbow-software.org
From: Ondrej Zary <linux@rainbow-software.org>
To: whiteheadm@acm.org
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
Date: Wed, 7 Feb 2018 09:18:18 +0100
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: David Woodhouse <dwmw2@infradead.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 Hugh Dickins <hughd@google.com>,
 dave.hansen@linux.intel.com,
 jikos@kernel.org,
 Borislav Petkov <bp@alien8.de>,
 Kees Cook <keescook@chromium.org>,
 Jamie Iles <jamie@jamieiles.com>,
 eduval@amazon.com,
 labbott@redhat.com,
 Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com> <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
In-Reply-To: <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201802070918.18978.linux@rainbow-software.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591729459266569469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday 06 February 2018, tedheadster wrote:
> On Tue, Feb 6, 2018 at 3:54 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Tue, 2018-02-06 at 15:45 -0500, tedheadster wrote:
> >> If that is correct (and I might be wrong), then I am up to date and I
> >> am still getting the following in /proc/cpuinfo on my Pentium 4M i686:
> >>
> >> bugs  : cpu_meltdown spectre_v1 spectre_v2
> >
> > That's expected for now. The CPUs we exempt are as follows:
> >
> > static const __initdata struct x86_cpu_id cpu_no_speculation[] = {
> >         { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_CEDARVIEW,  
> > X86_FEATURE_ANY }, { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_CLOVERVIEW,
> >  X86_FEATURE_ANY }, { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_LINCROFT, 
> >   X86_FEATURE_ANY }, { X86_VENDOR_INTEL,     6, INTEL_FAM6_ATOM_PENWELL, 
> >    X86_FEATURE_ANY }, { X86_VENDOR_INTEL,     6,
> > INTEL_FAM6_ATOM_PINEVIEW,    X86_FEATURE_ANY }, { X86_VENDOR_CENTAUR,   5
> > },
> >         { X86_VENDOR_INTEL,     5 },
> >         { X86_VENDOR_NSC,       5 },
> >         { X86_VENDOR_ANY,       4 },
> >         {}
> > };
> >
> > Alan is going to improve that list, but your Pentium 4 isn't on it yet.
> >
> > The bugs went away on the 486 though, right?
>
> Okay, recompiled for the i486 and it reports no bugs.
>
> As for the i686, it is really a "Mobile Pentium 4 HT" Prescott series
> (https://ark.intel.com/products/27368/Mobile-Intel-Pentium-4-Processor-532-
>supporting-HT-Technology-1M-Cache-3_06-GHz-533-MHz-FSB). Does that make it a
> 'speculative execution' processor?
>
> Thank you for the help and I'll test more of the museum pieces.
>
> - Matthew

What about Pentium II and 3? I'm using 5 such machines (and also a Pentium 
MMX). I've tried a spectre test before and it wasn't reading anything useful. 
Don't know about meltdown. Is there a complete test program? (The web is so 
full of crap that even google can't find anything useful.)

-- 
Ondrej Zary

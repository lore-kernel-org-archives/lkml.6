Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5BF1AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5E020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5E020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755975AbeFOJud convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:50:33 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:54158 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755735AbeFOJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:50:31 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id w5F9nKkJ023010; Fri, 15 Jun 2018 18:49:20 +0900
X-Iguazu-Qid: 2wGqn6MRrs6ISYajcP
X-Iguazu-QSIG: v=1; s=0; t=1529056159; q=2wGqn6MRrs6ISYajcP; m=73e5pGUCYMSbQnd8oSh7riUMZ/KmDP7VqYvMyWU6zs4=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id w5F9nEXL015306;
        Fri, 15 Jun 2018 18:49:14 +0900
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by imx2.toshiba.co.jp  with ESMTP id w5F9nEKb022085;
        Fri, 15 Jun 2018 18:49:14 +0900 (JST)
From:   "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        "'Andy Lutomirski'" <luto@kernel.org>,
        "'Rik van Riel'" <riel@redhat.com>,
        "'Borislav Petkov'" <bp@alien8.de>,
        "'Brian Gerst'" <brgerst@gmail.com>,
        "'Dave Hansen'" <dave.hansen@linux.intel.com>,
        "'Denys Vlasenko'" <dvlasenk@redhat.com>,
        "'Fenghua Yu'" <fenghua.yu@intel.com>,
        "'H. Peter Anvin'" <hpa@zytor.com>,
        "'Josh Poimboeuf'" <jpoimboe@redhat.com>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        "'Oleg Nesterov'" <oleg@redhat.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Quentin Casasnovas'" <quentin.casasnovas@oracle.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>, <pbonzini@redhat.com>,
        "'Ingo Molnar'" <mingo@kernel.org>
References: <20180614132724.483802160@linuxfoundation.org> <20180614132724.905032027@linuxfoundation.org> <000c01d40460$bfc97710$3f5c6530$@toshiba.co.jp> <20180615045604.GA8664@kroah.com> <000d01d40468$f2109570$d631c050$@toshiba.co.jp> <20180615070619.GA25325@kroah.com>
In-Reply-To: <20180615070619.GA25325@kroah.com>
Subject: RE: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
Date:   Fri, 15 Jun 2018 18:49:12 +0900
X-TSB-HOP: ON
Message-ID: <002201d4048e$1d854f50$588fedf0$@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGUQj4igkaupq7EehpFPqRFc6I8UgHKB38SAimvd0gBXoRCXgDMhTFaAfEAKtqkoBhoQA==
Content-Language: ja
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: 'Greg Kroah-Hartman' [mailto:gregkh@linuxfoundation.org]
> Sent: Friday, June 15, 2018 4:06 PM
> To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; 'Andy Lutomirski'
> <luto@kernel.org>; 'Rik van Riel' <riel@redhat.com>; 'Borislav Petkov'
> <bp@alien8.de>; 'Brian Gerst' <brgerst@gmail.com>; 'Dave Hansen'
> <dave.hansen@linux.intel.com>; 'Denys Vlasenko' <dvlasenk@redhat.com>;
> 'Fenghua Yu' <fenghua.yu@intel.com>; 'H. Peter Anvin' <hpa@zytor.com>; 'Josh
> Poimboeuf' <jpoimboe@redhat.com>; 'Linus Torvalds'
> <torvalds@linux-foundation.org>; 'Oleg Nesterov' <oleg@redhat.com>; 'Peter
> Zijlstra' <peterz@infradead.org>; 'Quentin Casasnovas'
> <quentin.casasnovas@oracle.com>; 'Thomas Gleixner' <tglx@linutronix.de>;
> pbonzini@redhat.com; 'Ingo Molnar' <mingo@kernel.org>
> Subject: Re: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
> 
> On Fri, Jun 15, 2018 at 02:23:08PM +0900, Daniel Sangorrin wrote:
> > > -----Original Message-----
> > > From: stable-owner@vger.kernel.org [mailto:stable-owner@vger.kernel.org]
> On
> > > Behalf Of 'Greg Kroah-Hartman'
> > > Sent: Friday, June 15, 2018 1:56 PM
> > > To: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; 'Andy Lutomirski'
> > > <luto@kernel.org>; 'Rik van Riel' <riel@redhat.com>; 'Borislav Petkov'
> > > <bp@alien8.de>; 'Brian Gerst' <brgerst@gmail.com>; 'Dave Hansen'
> > > <dave.hansen@linux.intel.com>; 'Denys Vlasenko' <dvlasenk@redhat.com>;
> > > 'Fenghua Yu' <fenghua.yu@intel.com>; 'H. Peter Anvin' <hpa@zytor.com>;
> 'Josh
> > > Poimboeuf' <jpoimboe@redhat.com>; 'Linus Torvalds'
> > > <torvalds@linux-foundation.org>; 'Oleg Nesterov' <oleg@redhat.com>; 'Peter
> > > Zijlstra' <peterz@infradead.org>; 'Quentin Casasnovas'
> > > <quentin.casasnovas@oracle.com>; 'Thomas Gleixner' <tglx@linutronix.de>;
> > > pbonzini@redhat.com; 'Ingo Molnar' <mingo@kernel.org>
> > > Subject: Re: [PATCH 4.4 10/24] x86/fpu: Hard-disable lazy FPU mode
> > >
> > > On Fri, Jun 15, 2018 at 01:24:27PM +0900, Daniel Sangorrin wrote:
> > > > Hi Greg,
> > > >
> > > > >  /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
> > > > > --- a/arch/x86/include/asm/fpu/internal.h
> > > > > +++ b/arch/x86/include/asm/fpu/internal.h
> > > > > @@ -58,7 +58,7 @@ extern u64 fpu__get_supported_xfeatures_
> > > > >   */
> > > > >  static __always_inline __pure bool use_eager_fpu(void)
> > > > >  {
> > > > > -	return static_cpu_has_safe(X86_FEATURE_EAGER_FPU);
> > > > > +	return true;
> > > > >  }
> > > >
> > > > Since this function returns always true then we can remove the code
> depending on
> > > lazy FPU mode.
> > > > Actually this has already been done in "x86/fpu: Remove use_eager_fpu()"
> > > > Ref: https://patchwork.kernel.org/patch/9365883/
> > > >
> > > > >  static void __init fpu__init_parse_early_param(void)
> > > > >  {
> > > > > -	if (cmdline_find_option_bool(boot_command_line,
> "eagerfpu=off")) {
> > > > > -		eagerfpu = DISABLE;
> > > > > -		fpu__clear_eager_fpu_features();
> > > > > -	}
> > > >
> > > > Since this patch removes the kernel boot parameter "eagerfpu", maybe we
> should
> > > remove it from the Documentation.
> > > > This has also been done by commit "x86/fpu: Finish excising 'eagerfpu'"
> > > > Ref: https://patchwork.kernel.org/patch/9380673/
> > > >
> > > > I will try backporting those patches unless anyone has any objections.
> > >
> > > What are the git commit ids of those patches in Linus's tree?  No need
> > > to point to patchwork links, I don't use that tool.
> >
> > OK, I got it.
> >
> > "x86/fpu: Remove use_eager_fpu()":
> c592b57347069abfc0dcad3b3a302cf882602597
> > "x86/fpu: Finish excising 'eagerfpu'":
> e63650840e8b053aa09ad934877e87e9941ed135
> 
> Minor nit.  For kernel commits, the "normal" way we reference them looks
> like this:
> 	c592b5734706 ("x86/fpu: Remove use_eager_fpu()")
> 	e63650840e8b ("x86/fpu: Finish excising 'eagerfpu'")
> 
> Which makes it much easier to read and understand.  That's what we use
> for the "Fixes:" tag in commits and in other places (text in commit
> messages.)
> 
> To automatically generate that format, you can just do:
> 	git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h
> (\"%s\")%n"
> 
> I recommend just setting up an alias for the above line, otherwise it's
> a pain to have to remember how to do it all the time.  Here's what I do:
> 	$ alias gsr='git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h
> (\"%s\")%n"'
> 	$ gsr c592b57347069abfc0dcad3b3a302cf882602597
> 	c592b5734706 ("x86/fpu: Remove use_eager_fpu()")
> 

Thanks a lot for the detailed explanation.

> > Unfortunately, they don't apply cleanly to stable kernels.
> 
> Should be very simple to backport if you want to.  Also I need copies
> for the 4.9.y tree as well if you do so.

OK, I will do it after the OSS Japan next week if you don't mind. I also want to run some tests for the FPU and try different boot parameter combinations (e.g. no387, nofxsr etc) to check I didn't break anything.

Thanks,
Daniel



> 
> thanks,
> 
> greg k-h




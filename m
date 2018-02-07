Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518046333; cv=none;
        d=google.com; s=arc-20160816;
        b=xDjMMKR6iPzPSygjEx3cSpHqxhuMxSUvAirPg02Gpl7o+uY8TxfWplyJ+YtHGH/SBo
         3DunCnACPvvtiqMdWJnOKXlVFp4eJMOwqHyMWCajv+zWhIG0Sagrpct9U0Pwi5Jg1QSv
         ntvnY1OjnrPSXNQGKEjtN46dwxGixsfoVGEqhN9yw7ImEqroEViWufN/4rC5K3L82jtq
         Oyqr62UEdScVDzlJ6G9FpKE8FKncyByrzguXclCvZwoNffT1u4qeORN0lXSUpbhDt3EQ
         YnBIg9XUSvthaO9XSc4Y4suxZwqgk9OC/PodiLqEcDsI3ObW72fbeMBEknXDMHTKf19H
         mUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=qc6R00f/4JPNAG3AhdHp56bCR2TLKYtHTdfLodBuSNk=;
        b=VIzLhXAolcWH9Ocv7MW95fpV72tTTEhIzdHyn+9Cc5zmxqGPTwwTIydPjImR33/h0y
         IrpB3Unb4InJYDrcdKfRm2wkE4NV0yNJxxhyl6BFv31gpuTzAUnOzGsaG/CnpMEVuqQR
         jUh4eXTKDaXbA9pEhNsr1HmZw7SLxhpvXCs8FyxfntFa52/XjIr61NoBAE0+ufm+0vgy
         YR7/2+ddJCTaV1EEsY8/OJO1LEHpmLcFvH4fFeBQajgWJI0hAW4xkKrdFTqT45L+Ac2+
         jWPHCBiXJFMdJ3huIGPxRxrRVZI+xtZtQFH7ypiU3gX2Vb2XT/3ZJTocJ7DP/EpbeFS1
         fbeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TvnUHgmY;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TvnUHgmY;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x227JPtI/yyfXxn/jhyPouCv4zxE5Pj7Yu+o1cAVaWSa24GVvKjJ+vjBU2r+YxVKTSUqr7RRH4A==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2018 15:32:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	gnomes@lxorguk.ukuu.org.uk, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, thomas.lendacky@amd.com,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] x86/retpoline: Add clang support
Message-ID: <20180207233211.GA13991@roeck-us.net>
References: <1518040338-9476-1-git-send-email-linux@roeck-us.net>
 <1518042518.3677.153.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518042518.3677.153.camel@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591780669011927496?=
X-GMAIL-MSGID: =?utf-8?q?1591786951968453763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 10:28:38PM +0000, David Woodhouse wrote:
> 
> 
> On Wed, 2018-02-07 at 13:52 -0800, Guenter Roeck wrote:
> > clang has its own set of compiler options for retpoline support.
> > 
> > Link: https://github.com/llvm-mirror/clang/commit/0d816739a82da29748caf88570affb9715e18b69
> > Link: https://github.com/llvm-mirror/llvm/commit/fd5a8723ce9f2a6b250e85972ef859e4253ea95d
> > Link: https://github.com/llvm-mirror/llvm/commit/59b64490fda69d29bb42cfdf7eec37bcc31ff833
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: gnomes@lxorguk.ukuu.org.uk
> > Cc: Rik van Riel <riel@redhat.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: thomas.lendacky@amd.com
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Kees Cook <keescook@google.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
> > Cc: Paul Turner <pjt@google.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: llvm has been updated to use the same thunk names as gcc.
> >     Tested with:
> >     clang version 7.0.0
> > 	(https://git.llvm.org/git/clang.git/
> > 		848874aed95a913fb45f363120500cebfe54e2ef)
> > 	(https://git.llvm.org/git/llvm.git/
> > 		3afd566557f3616881505db0d69f5d19bf55ae14)
> >     cross-checked with gcc 7.3.0 (x86_64-linux-gcc.br_real (Buildroot
> >     2018.02-rc1) 7.3.0).
> > 
> > Tested with 64-bit builds only; 32-bit images fail to build with clang
> > with various unrelated errors and are difficult to test.
> > 
> > I had to change '+=' to '=' below since make otherwise sets
> > RETPOLINE_CFLAGS to " ", and the subsequent ifneq would always match.
> > This is also the reason for the "ifeq ($(RETPOLINE_CFLAGS),)".
> > If there is another/different/better way to handle this, please let
> > me know.
> 
> See
> http://git.infradead.org/users/dwmw2/linux-retpoline.git/commitdiff/82a1f41600
> 

You have __x86_indirect_thunk within #ifdef CONFIG_64BIT.
I think it should be in the else case.

Guenter

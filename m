Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518046090; cv=none;
        d=google.com; s=arc-20160816;
        b=KHu4XmNZHZsgl+7Rz/AtKwYJiiaNWRo9Q84GJSIgO5/W8SJxwz6O3dhSZy/sL7PglS
         bDcjtYZgb+vbOF+otW6Fq7Fw6MSt1kl0ChNPGJW65rK75NCuMVAb6cw8ZThU3WnRdFsB
         yDp1EPa/kM609Sqsts3K2vVjon+OVFc800TKTRZZwt3O1CeJ/LLRo+6jHUJ6fXpNLgjh
         h4M4myh9jhEwiIdEyQ9kOVkK8uKhfkVGPP0D/sPik9fvvu/62OhHVkl4m1fSj8bZkMI+
         1GQX7kYrM40bCqPTQBvmfomjfKAp6HmZPwuSbKwWT0S8GW1r2a2M8gcjXf3lVc9K798B
         DxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=XlIEFyRyoDDgX25hapHe5N0D9Ix/Qp5S1Q6NHMiOMPA=;
        b=OXUrSYX0y3SA0KXIhWyFEBNApzBYqAWh5QTgI7KVPbXAGqY1j38G0Qdymqn1R8xq7z
         pt3by8mNjnUGtSyUjMAmS/VJbShjeju+WLe/hKKznCzyYF1QVCpJ/pPbwJ1knpfjRGGy
         a5+t7iivTp/y3im7CO5HFKBTzTnMIxUlIn125NqwGZghH0bdDRQ4C6xQ5rZbIEOOC7cx
         q8dFB/nQKs6lmAAL8opFoDIlutULoENJ72KT8Xc8rXFWpTmOke8hbIFY6sDkXcVpkZkQ
         JdLuowEjY0n8WoNJdf3Ly7eOGFc2MVhPhP2A0COW08ruBIpb9zxHoAZOBiX+3BTDw3FB
         4IWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fADuuDHW;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fADuuDHW;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AH8x224At9BAJ0ByGp+P1+PAGS7VxHwaRnbCyoAXZIq+9QEKRVub01gIN1G0HBRwq2QHp2jzfs1C/g==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 7 Feb 2018 15:28:08 -0800
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
Message-ID: <20180207232808.GA9939@roeck-us.net>
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
X-GMAIL-MSGID: =?utf-8?q?1591786698161610162?=
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
Nice.
> 
> > There are curently lots of warnings when building an image with clang.
> > 
> > ./include/linux/init.h:134:6: warning:
> > 	unknown attribute 'indirect_branch' ignored
> > 
> > I was inclined to add "&& !defined(__clang__)" to the condition for the
> > __noretpoline define to fix the problem, but concluded that this should
> > be a separate patch unless it can be addressed in clang.
> 
> ... where I fixed that too as well as providing the
> __x86_indirect_thunk for 32-bit builds (which are broken for other
> reasons anyway).
> 

Much better and more comprehensive than my patch. Let's go with yours.

> We do still need the %V asm constraint modifier to work in clang
> though, because otherwise it still doesn't build if you have any
> hypervisor guest support.

Let's see what Chandler's feedback is. Worst case we can handle that
in a separate patch; we won't be able to fix all clang problems in
a single patch anyway.

Thanks,
Guenter

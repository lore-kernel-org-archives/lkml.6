Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518629483; cv=none;
        d=google.com; s=arc-20160816;
        b=nf0zNkASCRYK6j2prBcB62fJE2Vm0AGK9XJjzrC8wqJI+hclEsEvaFOQR4Eo6IFwm9
         ZIi/aEwsuvNM8y6l1+K5At5TbAZcmryxpAzyKhUJQ0Zris/PkA5JHbAqWgS8Ryy0fA0g
         18/8+7nwipWoHceNZj/emdjEHn5cwbfrdliLVJQ7rdqADRXVMm/f7qvwMamAPkQHXLuM
         hAnlJ6hCyjMlziU9I2vYUO3V1W7XrPBHGRvKHLtVs7DpSkSE3MODilnR1oRRwjNk+z7c
         hCE0leW0n3YOgj2e9ch3NSG1ylFz+z0Oply78Rt8dPnVuJHNGu6E3+obpA0YguQ4HcZe
         0uGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QYiI7Xd8uifDbuxujFXHa/d2xsfcK0eMonjjPHSCdKU=;
        b=N1EpyMI4RrqKcZFGT8WMByfe5IwwipXhEMXYGkqO8p+TWo8JcKDMOtjssmf+LQdGfe
         QXJnd9C7zNV/xGzkM03ERwQRHkVSTq3WuR1pysQDHJB+f2MmadhiA1kKz2R6y8RLWhY1
         Y+ZnkY7eYpj7m+8ZqPn+baIhoeUEnp1RkrbrHLL8JjZcU9ggKajb3+JGKMIgLTBukYEz
         +KfDHCk/zVNdDmt5tJYN28Zqx8J1zlfHFIXb3gikcu9nydpnf0ejZPtD3BvIs3m8rcOW
         0SyL7isub1qUi3NxwpK5pciMIZjtbxSlqmsn4R7gTLe+34ZsBPgvDponHOxjA/bkbkCC
         ypmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HJNiP3OA;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=HJNiP3OA;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x226f68pQdXuX8D/lCDXb9gQBO+tguqWDcM9ahzI4UZIUbsgBTEAU8PlPd+VE2lBRhr2ekiE+ATBgq8nZs1Xt/MM=
MIME-Version: 1.0
In-Reply-To: <20180214090851.GU25181@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com> <20180214090851.GU25181@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@google.com>
Date: Wed, 14 Feb 2018 09:31:22 -0800
Message-ID: <CAGXu5jKDAKZYwvi2FAvTOsuPdu1wrqH8bckutbO1BGDyGx+U4A@mail.gmail.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Yatsina, Marina" <marina.yatsina@intel.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>, "Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>, "rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>, "ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>, Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>, James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592398429585050528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 1:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> If you ever get to the point where it makes sense to build a kernel with
> LLVM [...]

Just to speak to this point in particular: it makes sense to build
kernels with LLVM right now. It's already happened; millions of Pixel
2 phones are already running with Clang-built kernels. And even if
you're only interested in x86, that works too.

-Kees

-- 
Kees Cook
Pixel Security

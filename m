Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526513527; cv=none;
        d=google.com; s=arc-20160816;
        b=r/cmMq8taxB5+YWAMwIjLym6VJnHTL7loq+QdV4/x/zqpcjSOGCIHUtmsmY5TgfZ6j
         yixI+F0qlFQvjUcXv62x+eccLozmQPTQIR9vu0mJsfhzZ76clcskG7DH/fuWNgjCpXRE
         ocUfHwwY3doXj0/2eYwEPZ1doIUAGqU73hroqwaSXar7gBVbeODvbSdOFY41rDLvhpml
         pXN+8jkBULC3hmDGcuXuGZoqtvm+yXsDEyenkvHGqATr+rJPrXZY9soBHKlzWCJFSC9W
         t5CjqD4rX+Ftse8Tjyr7ETOPjlQyqNuX0VoNpO1ceeq7BMR6h0inXuuiKT6qdEncJY6H
         S73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=BWeaAm84fZuDgoUlMLQjaNuTHa4s69ABz1jMtes2I+c=;
        b=UYaoLe2DOkv6XPTuN5wF3cpN1iK9aVWyhknR+vDAf5AS1k0CaBseeoENyqep4/t0XX
         AOZiYSI9ChbmbCkJFjgSbHlwWVaLTpnhlXodqBBcB0xQOu0eqs39u4HAeuL7iNYzFoGs
         IdBZZPrKd1xjkm7RIR305Ss45RCCO97CRhU29amVkRFBLNFcxEGCYk9I5as+yvTEaDWw
         6MixQCXyn5RevD7voCjqenxR2q//ZP2RV7cSfaDLGcTS3Jivi9ai7H0So7ZTVceCaTp5
         OpIBAGfEqPW/ksmDOzmING5s2NJJ5Awpx8hjBX39A8bHtoIjVIngOUyr7aelMKW7ZvZs
         E7lQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XrBx+8Qh;
       dkim=pass header.i=@chromium.org header.s=google header.b=bQlOCB7G;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XrBx+8Qh;
       dkim=pass header.i=@chromium.org header.s=google header.b=bQlOCB7G;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZppFzEUloLswa1vlrwmr5O4h5hPdJgUrfulHPkGUxEwlO/pbU/auzemsDHqsX3PY8LTMa1h/ydFEPMw7voFTek=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 16:32:04 -0700
X-Google-Sender-Auth: LHQktrlOVHVTKi4ZsNFs4RdpkUA
Message-ID: <CAGXu5jLwnbcMqoV_LYPjEUHZ2Lgv+35xVxYO0FNSqGPD-P7Pzg@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Introduce the STACKLEAK feature and a test for it
To: Alexander Popov <alex.popov@linux.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, Andrey Konovalov <andreyknvl@google.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638805272204332?=
X-GMAIL-MSGID: =?utf-8?q?1600665449398535222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 9:28 AM, Alexander Popov <alex.popov@linux.com> wrote:
> This is the 12th version of the patch series introducing STACKLEAK to the
> mainline kernel for x86. Some code is made common for easier porting to
> arm64 (will be done by Laura Abbott).

Thanks for the update! I've pushed this for 0-day testing here:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/gcc-plugin/stackleak-v12

I'll let that churn and push this to -next in a day or so. :) And then
hopefully we can add the arm64 bits too. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security

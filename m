Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520278485; cv=none;
        d=google.com; s=arc-20160816;
        b=Kjtq3BfpKFDlNWrsS1qZrYYjojXmqZFtQzNLtVg12myGNMEGk//0SVIuKs2GGGE5Je
         ASfZjbI8VHNVgqu3rmoIj8rtpDJBmiUATGuIUmGj4WahOlaU57yccdccjZYdurioTQLI
         pcDxZkGwc3LJnV4++TaVLsF0f79Sa3iXpcPwJwf6fPniA49VI5uMUFoj4wzQ4lC7+RC9
         JNS1UtFyWuzg9wlZhZcEEIn/h/0K4hQ+4mMNkZuXTH3qEyFJTHfCmyzVgoUZNc6Id3C2
         gJ1FNVyISfjW57dqwRMvtkqFnUzXI/hS89JTeS2jAFHbJ1kMMWdh5Roys/WnP9eGAAzl
         qRUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=x6HoUBBjHs0nwIyCRviYOioSHZzE6nnGwinRmEHXoJo=;
        b=E757ZaL/X4jxAU/zQ57WIiWp6hx3EmlhTifZN6Uy0jsRLTbabkyEsT9aZ1TfAAWhtE
         hCmsFhXzC/4iYwnGTLDbtThrREIuwL6laKp9CehHbruzQ9M5QncgbxjSLraBkahYt+za
         c530duB7Id8WcZrqmtngASY4mK8Gm8snu/udgPr97O3/9gq20RwZ7yHk0PaQjLN8V88Z
         qa8zwI5TQuzBBYdGUgCw8Ijc6DoHyumbuoe0Kh9Kz0zZ25hEX4LKtpgvANO3fcnfNpeT
         n8w0i8kzKrhFtQsJRvCK9lt/muCNHK/54RaW5zpcUOEcFYxNeP+SWf3ukuFuuBWCFwKE
         BUmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TlympP4b;
       dkim=pass header.i=@chromium.org header.s=google header.b=BgwN1EpY;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TlympP4b;
       dkim=pass header.i=@chromium.org header.s=google header.b=BgwN1EpY;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELupeygqCAc4PFSiatYSdhzfqLEEaihCY4+Nq1rzxYNwRyNsI2gakFeggVtbhHK9/yiMagFJyuAJwgyRgH9QqSQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 5 Mar 2018 11:34:42 -0800
X-Google-Sender-Auth: bZhmDcwc7Vx5uIbY81UFLLgG9cY
Message-ID: <CAGXu5jKvTUkU5qLf+j9aB8G2xqKm7n3QLPBXaGnk_ewhG6=i_g@mail.gmail.com>
Subject: Re: [PATCH RFC v9 0/7] Introduce the STACKLEAK feature and a test for it
To: Alexander Popov <alex.popov@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Richard Sandiford <richard.sandiford@arm.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947979230091677?=
X-GMAIL-MSGID: =?utf-8?q?1594127532933386916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 12:00 PM, Alexander Popov <alex.popov@linux.com> wrote:
> This is the 9th version of the patch series introducing STACKLEAK to the
> mainline kernel. STACKLEAK is a security feature developed by Grsecurity/PaX
> (kudos to them), which:
>  - reduces the information that can be revealed through kernel stack leak bugs;
>  - blocks some uninitialized stack variable attacks (e.g. CVE-2017-17712,
>     CVE-2010-2963);
>  - introduces some runtime checks for kernel stack overflow detection.

Thanks for continuing to chip away at this! I wonder if it's time to
drop the "RFC" part of this? It seems like this should be ready to
land pretty soon. I can start carrying this in the kspp -next tree,
for example. I'd like to get some sign-off from x86, though.

Boris, Andy, and Dave (Hansen), you've all looked at this; would you
be willing to give an Ack on the x86 parts? (Though I do now see a new
comment from Dave was just sent.) And if not, what changes would you
like to see?

-Kees

-- 
Kees Cook
Pixel Security

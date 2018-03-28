Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522268030; cv=none;
        d=google.com; s=arc-20160816;
        b=PUJcHvN0SWCF6LjXMaSnOmja/WHVAGl5GfDVj7GBP70vKsYZ3Z4e40RqOTSZIqmxwX
         ZYtLxZRKZR/s0XDQ4NLnYsumNNQ9qkZy6bx5zSOaxfeXbl0NZo1RTF8Mdz06slBiBdOB
         gC5A2W6zl6dpv5xmzPFIFqGpG08xv3h+A/dGwI4FcjLAF0xwrW/oR2b5+AQsxeTPJDV8
         EhpETrKPFoYt6B5e/5chbs/sgCl9oVsE23Yp8L+6XSlwGD/jDVi6DcJjY/XzF9l+LpMp
         h0xckcwxomuriCNz+ffWrqAH3HbULMp/rF1vuRqwQNpSd3RICCfNFP7JwR1V6CMJBw0I
         VdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sjn6lh+CCVHo+STbd0e/0SJwWu5HDPjBhEGHlUXO27I=;
        b=Dd9df3YMcCrUAceVpvz2wCJ5bGN9UNOJauPpVdo1r3Cuuot6PfWOja3UaScpUTKX1x
         QhzdACOXBqYgK6SHol0Vn5N6rBAyevvgxILCpDpnXb5nnR9TT/pKv7rHxZA0JY7A2si2
         bWFpF2Oj8HruWGwZTeWMRE/qJkm79etPSEofWzi4lrtuh0adLdB2kuAsDkJvRcznd0Ra
         fnoSqkB56kWqbjJOCCBdt1fiRqGfo3vtEqRNPGF2Ksz3B2cSAwG0ZVXQLvl06CZvLbZ6
         beJ4jp29XfWGDl/3dnzMNT1FDpXNnzMw2EPybXj9gUfLamQUk6VdvOQFK7OuLAEGTXZa
         qdpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=POTEujau;
       dkim=pass header.i=@chromium.org header.s=google header.b=fhKR546a;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=POTEujau;
       dkim=pass header.i=@chromium.org header.s=google header.b=fhKR546a;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+jXarZdB/ieS3XHhqzxkiIZ3wAco3nSxY2/AA3kxITL1lwS2UbbVevVEwu47NcTvFMogtK+w5RBnKEXj7Dx6Q=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1522267032-6603-1-git-send-email-alex.popov@linux.com>
References: <1522267032-6603-1-git-send-email-alex.popov@linux.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Mar 2018 13:13:48 -0700
X-Google-Sender-Auth: 6EuzW5-EXugopD8tgcsClYzrB9s
Message-ID: <CAGXu5jKRs6Zi7+hDEsH3hW2zsAAQ0aiJoXaOpmxNjHC64ZABTw@mail.gmail.com>
Subject: Re: [PATCH RFC v10 0/6] Introduce the STACKLEAK feature and a test
 for it
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596212689180490954?=
X-GMAIL-MSGID: =?utf-8?q?1596213722012756229?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 12:57 PM, Alexander Popov <alex.popov@linux.com> wrote:
> This is the 10th version of the patch series introducing STACKLEAK to the
> mainline kernel. The previous version raised a fervent discussion[0].
> The assembly code introduced by v9 irritated the reviewers.

Thanks for persisting!

> I've found the way to bypass the obstacles[1] of the C implementation.
> So I dare come once again. Let me ask you to look at this code without
> preconception.

The assembly changes are now very minimal; thanks for reworking this.
I hope this addresses both Dave Hansen and Linus's (similar)
objections.

>  1. reduces the information that can be revealed through kernel stack leak bugs.
>     The idea of erasing the thread stack at the end of syscalls is similar to
>     CONFIG_PAGE_POISONING and memzero_explicit() in kernel crypto, which all
>     comply with FDP_RIP.2 (Full Residual Information Protection) of the
>     Common Criteria standard.

Agreed: I continue to believe this is meaningful even if just for
reducing the lifetime of sensitive data on the stack.

-Kees

-- 
Kees Cook
Pixel Security

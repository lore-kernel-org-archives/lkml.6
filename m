Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+3o/ag3OKqIIKd5KF7HQYgQIAyRB+WwNA1D/MMaVB2AqfWro9MmPfd0kGyePcfwDxeNbBC
ARC-Seal: i=1; a=rsa-sha256; t=1524543834; cv=none;
        d=google.com; s=arc-20160816;
        b=hv241IrHd6Xyb7m3GXH0aGw5666SytVycX1bsbaZc0xNCGVtaBjQhhe5oYezfReZzl
         Jcb2TiPIVZtepXBOAKvLKjEj6qAyDgdd3r+CTfdjcXQqCX8LyhMwawRXdZhMnK0XH2hY
         v48caETcyCLQ1K4zWJXzt1Ecc+WmnUEM407OdSw9WTdkczqzgleNUpuQN/xGZBW6SKQV
         ZOJiwJpOgXhAiApN1iv3HqFPciRAqx+Uvi3LS91n5LEXZyZCeGRpYUoEMQvGy/YZ8cw6
         D0zYt+2HTvC6UaWe3vnURqLw5wWgSuPwpA+OzMzhVwk6h9Em0oQWwi1VQxG/LkHqZQaW
         o/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=abj0pkIheIWfAZnZo3lE9e3NO/WO+saBq2vwINadPng=;
        b=k6EHalTCgBVi5/odPdjIDgY/NSnajJEoGfUjlo0mDyCWyGqmfSmbAFbw2m2fIrhPG7
         /cX97VX8ZSBGCo3ML5bz/f8Wbvx+QazBU/XcTRw0ukvztAjeir9X3PlDbgk6IuRmBA/+
         IjXUvaxo5/YQK4ZHKkipydsmMFSKaV2bF2BiNEoWTP7n6I2C77qw0IbJ/rdgfF/cLoVA
         XvMDxYh3zQmhDU+a39GtQzP9lsLgCwkER5ToRhvinUlMTE9k6Bf65rrfccRiIZwNhk8D
         yM+WL95hKK5Fi3zgQvKnA7PvCbioMLS/QQxxXuH9WhlhYMKW97Vn2FXDy48vnC/kxCku
         y48A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,321,1520924400";
   d="scan'208";a="218880558"
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Alexander Popov <alex.popov@linux.com>,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin"
 <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Garnier <thgarnie@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Juergen Gross <jgross@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Florian Weimer <fweimer@redhat.com>,
 Boris Lukashev <blukashev@sempervictus.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com>
Date: Mon, 23 Apr 2018 21:23:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523024546-6150-3-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1598600075650344714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Alexander,

You can add:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

for this patch if you like.  I haven't taken a super close look at the
rest, but this is certainly minimally invasive from my point of view for
the entry code.  Thanks, again for reworking it.

Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521042729; cv=none;
        d=google.com; s=arc-20160816;
        b=b5Lz9CmLNXe38oTLBNnqXY9UxKK3ICnapLc83p7bwDAKzgZ+/8VLcDiVwHUqOSsSU8
         jK4bVvvHmDHy/XFW44e4Ryj6GOP856VAum0ISXY889obuKY0YMu6mTuz2Ei8oYONNNJE
         UgXocOa99Dyl5WKAWnKrv0mTjcrY20aOUsuCtrEjj3Vvyw1jfZIKjCSm/qzKQz3M2Ier
         LAztVug5P4wyyODsFxyMLsrOMfNij8hkODdbuNdPBD7uNGUXUw+CARr3+u1W75FHBXoK
         p9qs9fI1RVJncrn70Nu+UYOUHAmFtKwdpmseF6/ooz8m49UiAN+heomfn+uc+4+2FJ22
         Moxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=c337iAXpoinukRbrSk3c7Y6sencPpkv6kc9t1YAOFFU=;
        b=ndiGzw44XztfDSXwDZrZsmcPLxx9UQLWOuIwkFoi9BMc/W5GLzapVs5V7tSPcFVBOi
         A2dP6epExKG7RdKPOvEiPjqsNc9EyrAJw9CqVMMCteWMnsF1lJIolY5ZOSmeVA9WrzOd
         SRnPzIx7hCSkq1V9SDzZtoVqniBclg1xdt8L+8L6F3UrggLwWXrefgpmWn9ATDbtuj6S
         zME3X3ACM6Qyn2gnzI/gleWkn5Ii5DBIs/hgpLrgC87tp+lKw0/9DwIuYVftMAxG0aM+
         fUBHifUnEGewKeAPE6YtjZ4fNu6kAziXhG6YcT0kQVSEzMWG/O9yFvavD72FPUYPQ/PQ
         WFhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ccMpV5j9;
       dkim=pass header.i=@chromium.org header.s=google header.b=AdXr+3Le;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ccMpV5j9;
       dkim=pass header.i=@chromium.org header.s=google header.b=AdXr+3Le;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvQ8zHJvh1GzK/sSL62NnYTYdvOBsaQGE2FKI7U0KfIESgnLo4+k3Qg66vI1SzL9HbjxVMrfCAwkCRG8qc89vQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
 <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
 <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com> <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Mar 2018 08:52:06 -0700
X-Google-Sender-Auth: FxF3ESBnm9wgt2h6VRTLmT-EQao
Message-ID: <CAGXu5j+C3p_dHyG1cRJdWTaC9+Mjc7VTEtXygiywTXnx+XmFRw@mail.gmail.com>
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Florian Weimer <fweimer@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>,
	P J P <pjp@fedoraproject.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	Daniel Micay <danielmicay@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594750868471232540?=
X-GMAIL-MSGID: =?utf-8?q?1594928900995222945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 7:21 AM, Florian Weimer <fweimer@redhat.com> wrote:
> On 03/12/2018 06:45 PM, Linus Torvalds wrote:
>>
>> On Mon, Mar 12, 2018 at 10:17 AM, Kees Cook<keescook@chromium.org>  wrote:
>>>
>>> On Mon, Mar 12, 2018 at 10:09 AM, Linus Torvalds
>>> <torvalds@linux-foundation.org>  wrote:
>>>>
>>>>      struct xyz var = { };
>>>>
>>>> I'm not sure what that will do with padding.
>>>
>>> AIUI, this does not guarantee padding initialization (yet another
>>> "undefined behavior"). This is why we've had to sprinkle memset(&var,
>>> 0, sizeof(var)) in places where a structure has padding and got
>>> leaked. :(
>>>
>>> I assume this may be orthogonal to -finit-local-vars, and maybe we'll
>>> need some -finit-padding or something. (Though, honestly, is there
>>> anyone that wants to get_padding_  correct, but not variable
>>> initialization?)
>
>
>> We would definitely have wanted it over the years, yes. And
>> conceptually it's a separate issue, so a separate flag makes sense.
>
>
> What would be the model for the kernel?  Write zero to the padding
> initially, and on copying structs, make sure that you either copy the
> padding from the source, or clear the target?
>
> Clearing the padding while copying might be somewhat expensive.

I think the common expectation is that copying does a full copy from
the source. Zeroing of padding should be guaranteed by the constructor
only, IMO.

-Kees

-- 
Kees Cook
Pixel Security

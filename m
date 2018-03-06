Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520375094; cv=none;
        d=google.com; s=arc-20160816;
        b=Xd3e7eszemuTryfidACNQeaC3TOywq6vVuDzqS45U4AYsRUCvTQyndv0X469K4gjM7
         nz/zxJbKk1Nxbh9AltP5q0Pig+bIBZZpeuP+jq8E5rzGF+ENVaheV0M26owDrvNW0V74
         5M+0OG20MsViNe53+mSRTm6NPih12ai4SpoM2X/MCLjGHD5HCSsPAMZzeLm/9UlPqkVE
         G7NX6LfyTKwtZjUUCJaYmCbX1/vEyHeoTQhPed8KBUMNe8Wje1ylX+ExnfDsFsFxEtOF
         vKoR6cdtzNB+D06FvLde0mVR1keQC7AIa8r7YIel3v7tTQWhcKKdKcsHXFaNimef8b1p
         4UoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=V2Qi/xrYAFlniXam+o1HVbTLMskavR/Jy3pkgf6fUZI=;
        b=hzLxMVVn2Vr0zl+LWugqj+miOJBxEMff72Az+3ZO47OTP/vbH9U464UVGdqhOd2wUs
         Yypi6a7a/wuMfNBhdaBZo2FLfoHKdoGSFVkxCCMhHIVI1uwzwEFIIq5iw161RC2Y64Rh
         G+vfWL/QuVuQ9LWNSUcG0BHSgHZW5js699bljpsNNs66dW0JyYr4HBakHyPGHYke6b4r
         9gkBlz1Tl3J8/xnFwVMBNKZyNzQGF32ej5np497xpseXZjMUFXuhuVFj3PMdI5DFJhGp
         XqPO4KTBrbKBRwTJeFrcHlahT0EcoAgDAJi6VGy3CIF7DjT2KcDf8HYcexGhIyiFEfp9
         zD+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nSQF0AuQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=HfrzvuUC;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nSQF0AuQ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=HfrzvuUC;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELsmhxKOnX0As+A91a/2lBDEvFm4gPy2ODjZukCYR3gy/JGy5hqRuEDLepp2uJIN3uUXBebhAhFXKGZtHzEMJ20=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK8P3a12YVBK6rtXwubW-0W3XwEbF+BU21MN1Fx8OrA4-2S7vw@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
 <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
 <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
 <CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com>
 <CAK8P3a3BA2BueHOuOiszEzkBtA80QDdo3wgX+62=KXCdi9wScQ@mail.gmail.com>
 <CA+55aFxeJ-6JB-DeZavyzeAYrcdjM=5tMM5dMxvNgT5WJLfQMQ@mail.gmail.com> <CAK8P3a12YVBK6rtXwubW-0W3XwEbF+BU21MN1Fx8OrA4-2S7vw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 14:24:53 -0800
X-Google-Sender-Auth: SfverJ1kFzxaLIMsa8XG2V90j-I
Message-ID: <CA+55aFy-imLQ9WeA880qR_DqKTpCiH2-3ou6_NScBGOKGE=-fQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Micay <danielmicay@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594228834675599203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Mar 6, 2018 at 10:29 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Yes, it can obviously generate some extra code for the "pass pointer
>> to uninitialized scalar around to be initialized", where it can now
>> make that stack slot be initialized to zero - so it can generate extra
>> code. But disabling an optimization?
>>
>> What did you have in mind?
>
> The type of optimization that causes my earlier example

That's not a  valid "optimization". It doesn't make correct code run
faster. It just makes incorrect code result in incorrect results.

See my previous email about _why_ it does it, but the point remains:
the "optimization" is not actually an optimization. It's just "garbage
in, garbage out". Speed doesn't matter for garbage.

In fact, see my explanation for _why_ that optimization happens to
understand why adding an iniitializer doesn't make it go slower, but
simply makes ie well-defined and thus makes the optimization go away.

Really, only stupid compiler people think it's an "optimization" to
take advantage of undefined behavior. Sure, garbage code generation
can run faster, but that's not "optimization".

We want to very much avoid those kinds of people, and those kinds of
optimizations. It's very much why we disable strict aliasing etc -
because the whole optimization is purely based on taking advantage of
undefined behavior.

It's shit. Don't call it anything else. Getting rid of that
optimization is a *good* thing, not a bad thing.

                 Linus

Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELsOY3YIU77qDKbxsIbKxycv8IIFAh9QBcYwUOMpGmeHDZ7OcAEN7McDsHUaqI//JabvYUF1
ARC-Seal: i=1; a=rsa-sha256; t=1520278929; cv=none;
        d=google.com; s=arc-20160816;
        b=tJVj1uVSmJYtfTkN53Z9m5gGYkacru0uzw+gg2NOsx8fHgAxLk4Fuf7HCgFvzB5sId
         NV4RNEnT0P81QAG2FGJeYwAkeFh0eT2Ip6mKBiNgwo7wv3XgBh0ZozhR0R+Scu82zJFD
         dPvClh29Pg9aN7ZkG4sZ1K4o08RKfyP6mfeX/2xbectyDXR8YFjl87WWEjuer1o+vA/z
         acrLra29w5A59RdtVrkcCEHhrfj74IrVMcUYq2s3S4OSKSA3ik7bdkAKiCqHFo/jkIsf
         CvswbsQDhLuC79qq4br7Xu+ok1g6YdymklIKbV66C9jASIqmZHC7ynJQcgYvqIwZBQ/H
         vcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=VqU61Y6sYFV4efpoiypvipbZi4Rudm3XzbXjIV8bytw=;
        b=EM6mz3QNyJ+9afiZfghcmuUzbF4y5jlyy0INlG+YEE72hs9EgdlM13rUYG42H9/wL7
         3KIj+wnuUQP4joqMQ+13I/EgW1bhdI9A1pQcWBylhZVBWZ5obUXgAgNMtJk7KRees59X
         GcSVbf8iDzg4YM2oYB+Tpr0OvnSpU5BO5GvFy4PeX2PwI+HltLyarGPI1gGd7M0f5jpF
         D1HlilTKDKvZq5lSt31/gAyEOA8P5Eko2RxUzpCpx4gmlA26igJ3geUjJeCAg27/1lvP
         zyKtxpOTgLeZyP1ISEa/pmG7R3mbzrwQFv34qSiPWvwqj2pwOdEDErDjJbB1O/z1GQjI
         y5yw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32583054"
Subject: Re: [PATCH RFC v9 0/7] Introduce the STACKLEAK feature and a test for
 it
To: Kees Cook <keescook@chromium.org>, Alexander Popov
 <alex.popov@linux.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jKvTUkU5qLf+j9aB8G2xqKm7n3QLPBXaGnk_ewhG6=i_g@mail.gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <39c52c1d-dba5-07f6-0838-2e8b368b40ed@linux.intel.com>
Date: Mon, 5 Mar 2018 11:42:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKvTUkU5qLf+j9aB8G2xqKm7n3QLPBXaGnk_ewhG6=i_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947979230091677?=
X-GMAIL-MSGID: =?utf-8?q?1594127998216205808?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 11:34 AM, Kees Cook wrote:
> Boris, Andy, and Dave (Hansen), you've all looked at this; would you
> be willing to give an Ack on the x86 parts? (Though I do now see a new
> comment from Dave was just sent.) And if not, what changes would you
> like to see?

I think it could definitely use another cleanup and de-#ifdef'ing pass.
It seems to have inherited the style from the original code and it's a
bit more than we're used to in mainline.

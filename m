Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526626464; cv=none;
        d=google.com; s=arc-20160816;
        b=FfOnjCw7csqMMYVQpwHeNWkq61dxzfiKzw5jKj/3GQttnLBksykppnzw67xY101MBv
         pFU0YT26wjpFuy8TweLkej3xZYlSWroT6+ptEZ4lY10987M8tT8+tA8lOgEyGSdOe/BG
         slOJOZZ0az4xRhGy2/+de1riGEiwvUjScu6COhe55VDWDiWuCq/SalZNnnZbsOKOA4VN
         uNdaO+lMX2Mcj7Y1IJgXNZ6fRt0spS264wOaSel1fpLl5oCD6Lc2WcKV/FWgldZJs4gx
         IJdpDn/O++NL//USGTNecOEfSWDd3jZQCbPQbfstr4NUncE5FYjLB1+RA5gimoZWStvO
         pFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=jFDyapZPdBaYzIUTUQBpIfIdvGet8nAhzo9hg/XlYFo=;
        b=JL2xVy8s29U3hH0a72fTdHcbJv9zSPpSXokLVhbLW9dAV64nDtU+jvFZKO+5AnIhpt
         2Qk23fHBSU9b8UiYxN54jXdm7aGvrgucSj2FYN4QpqyFOQQC3c+TzMzzc1VLvDqorUZI
         272xJyqdPhQUWxILIw+0MA0AWNPYsfu6c88uh1VY9OoqUcqvuUdYs2ohnbfc3S4nj1l3
         7mGek6Vu2s1F7ZMpIE93aIfPHNkijCwMUcQ6EXv7RyFOTMPgqzzD5y5hX2qNE5N85d/X
         uYyQijekDE8D9wSKLYCDq0hMym8cdAax6cSMUC0a2CWoqTHaTH/AafpJibPLQ8JAAt8O
         ma6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AabQ1pCE;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AabQ1pCE;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZob5nTnuEdM8Vt4gHgWSt302ofNgjm77dACrsp89YBgPSGQGI2SwMFpmPUBm/UtWDw1OYnWng==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 18 May 2018 08:54:19 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>,
	Andrey Konovalov <andreyknvl@google.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/6] Introduce the STACKLEAK feature and a test for it
Message-ID: <20180518065419.GB10080@gmail.com>
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jLwnbcMqoV_LYPjEUHZ2Lgv+35xVxYO0FNSqGPD-P7Pzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLwnbcMqoV_LYPjEUHZ2Lgv+35xVxYO0FNSqGPD-P7Pzg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638805272204332?=
X-GMAIL-MSGID: =?utf-8?q?1600783870900062844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Kees Cook <keescook@chromium.org> wrote:

> On Wed, May 16, 2018 at 9:28 AM, Alexander Popov <alex.popov@linux.com> wrote:
> > This is the 12th version of the patch series introducing STACKLEAK to the
> > mainline kernel for x86. Some code is made common for easier porting to
> > arm64 (will be done by Laura Abbott).
> 
> Thanks for the update! I've pushed this for 0-day testing here:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/gcc-plugin/stackleak-v12

Please don't commit this to any stable Git tree yet, it still needs more work.

Thanks,

	Ingo

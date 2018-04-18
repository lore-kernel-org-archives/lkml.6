Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/GqxbZasF1cT44SpANULOHNpRseubJwHvE7ZWtZq523M/d2oU39H3JBbvIxNMWCQVlRTrC
ARC-Seal: i=1; a=rsa-sha256; t=1524077428; cv=none;
        d=google.com; s=arc-20160816;
        b=CgRgEvb5MKmFDWj70yWNaE7AgIiYZnWom7XxUGZTMT+e4tr5Xf0J9gZDDl/pwQZlCu
         VaiyAdjusyZqYT9wMFB8c0zK/kPq5Hy3pkgnDcHOvNPTovdPhshCdIQ/5U0nsWpyqHoU
         FONTR1VSSMdXFLyMyZQmM+GhbsI8fh+tZygIv4QhveA5x4rpfVWO1NHDvhGD3PQnWpCh
         Libg6jJyspKeQxYvjyYW8OGYbOSO96MMHM2mgrrT2uvvoSfHv/LyLGxUPy+3Tvjy/dYE
         sQVF7srnfasBQEYxydXIsWqHACj8YjzV7wxsOcIA+fPAOUYknblkjyawmF6UfzMVm0f2
         vrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=GCghOTnMMwFlRzWZr7vZwFIgmcMzyOxbLTCatbIzpAI=;
        b=OA0qwXlVCiLFfzr5+OqwVq4rPqCMf8WNwOq+FM4h9GUGIRRJNd1wYmLNFdygEFyVIp
         IVILA3pExfVYHrYh2K/7iI85r+Cq9oltbaIyIUQ/q4sz/aB4GF6r/JzQ++T1X/9SWf7x
         AIrFdbe3joV4WoEm/r0jXoCgNeX/ILHPCQeFNrcBv9KqH0XewIi7ZKVNcc8OLJyuk6mF
         2oesZTClvbLVcdpQ4DVdJum2ymhzBhGWrSWOEy+jShRJ+eQlW1RaQxS0FTjHH2Iqohe2
         wa+h5uyTPhXbp8CpAIZNGib4ELFU35U/2TefTb+Mx2h6NDhzEEm+ywyjie/I19BPOov8
         iNXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="34391495"
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Kees Cook <keescook@chromium.org>, Alexander Popov
 <alex.popov@linux.com>, Ingo Molnar <mingo@kernel.org>,
 Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com>
 <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Florian Weimer <fweimer@redhat.com>,
 Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <c5a605b8-423f-5e92-5fbe-12cb44a70bd6@linux.intel.com>
Date: Wed, 18 Apr 2018 11:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1598111014287950524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/2018 11:29 AM, Kees Cook wrote:
> Dave, Ingo, Linus: how does this look? With the assembly rewritten
> into C, the entry changes are very small:

The assembly looks very nice to me now.  It is as minimally invasive as
it can get.  Definitely no objections from me on that part.

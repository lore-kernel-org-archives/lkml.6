Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+FQ/vnRcAJ4tupHHjGtUA8xuLHPB6C40XM/pVIRGGE/T4hkBi7RsqflJMWkUg8o7aNwpym
ARC-Seal: i=1; a=rsa-sha256; t=1522277727; cv=none;
        d=google.com; s=arc-20160816;
        b=n9wcVIBoK9skcS8lL/SESw3fKSvnjMkfCu7AFIzZASq85UmRx1rKLYQcA/dIZspllX
         MbBNq/Jt1wCCdUns+2MIDKtqNTw6iMHbCisysh8RZytDei9SfyU6MxZJW+2KOoslIzpr
         sw8MgCTQzP+rcaf2ufZAfeWLEF/LebF1TclpuDm1fV7Ltavzw7WnGcbAFqScSKts2k5N
         29jfyOQwgQhsc91Ta5Ga0VWWDX3yQTDPIOgEWUP65qzpzZ3DbMdvdlYfLmhJIVXOlkbL
         UcXadeJ+pE/kHoKtPClvv2VKQnJ9vrmIhhhc9EFqZgzqgG6ovJKZcP4GySdYaBXUuW+r
         D2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=leNGlvJMGF6EBGwcR1T3dwNfr9nZyO/0bmW90hobtwQ=;
        b=k+oABv2bYN2BcEo35HRTa8rDYZZ3bffVpdgR7N2GypBX0cAET2MjC+NXBEIbnSxuzX
         +yq3usqHonJIE4lUcjvk3Bw1rAu2qijZXt4B7Wlidk85KFfY2ZMXCaD8Hrmxulw0U2ON
         G990U9pPNVFgRgsT9WaD5idCDRBBC4Tgxos2AxM8y7sTNFtpi4T13y74MMyH6x5NWHcl
         LHHZDzHLZBcsTotveaBXpgAYH3lApNNyLDIrxWH5Kh1NNWett6K/WLZLjrku8Dr6wxAJ
         AiN5brtSKvWfBLImgl7PfUpNurKqv3AdnNd3lAZlCYhWKHZ8GybZ9V+mUMHaevAIBz9Z
         Ramg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="43041667"
Subject: Re: [PATCH RFC v10 2/6] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Florian Weimer <fweimer@redhat.com>,
 Boris Lukashev <blukashev@sempervictus.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <1522267032-6603-1-git-send-email-alex.popov@linux.com>
 <1522267032-6603-3-git-send-email-alex.popov@linux.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <77fab6ea-0bbf-d68b-a38e-3e22d1ae6093@linux.intel.com>
Date: Wed, 28 Mar 2018 15:55:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522267032-6603-3-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596212693741401562?=
X-GMAIL-MSGID: =?utf-8?q?1596223889779284234?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 12:57 PM, Alexander Popov wrote:
> +.macro ERASE_KSTACK
> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +	PUSH_AND_CLEAR_REGS
> +	call erase_kstack
> +	POP_REGS
> +#endif
> +.endm

Thanks again for the hard work to trim down the complexity of the
assembly.  I noticed the 64-bit version saves/restores registers while
the 32-bit version doesn't.  What's the reasoning there?

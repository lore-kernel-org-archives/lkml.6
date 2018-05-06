Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZo64JUlK3GMiedfWqY1XF08F92c4KQqtW/iBHN0aOoiZ2OO8DdYw6qGjUlDt68IRPDTbgT1
ARC-Seal: i=1; a=rsa-sha256; t=1525601131; cv=none;
        d=google.com; s=arc-20160816;
        b=OGT3lJn7AYOUvj4TO1xOj8ajHt/86wHxvsBv4eKD44MsAVFqvsqufr2Kl1ebQDt6nD
         D8P+KG5BGv19WSpJCF2PzT9VZZtiC2jHwsCHBBVDEVx7/Ihv1jmoAGdoSPPIN/ujMilI
         Fk1PFJeJWbq6dB+W6ojfPkt0DESNF0JWYkW88V1zyp7UUOx5fRYN6Il7K4lhbxXpPRC/
         wZBMth4XslSN5fiFOgtRoaudBW64ajeOYcnoX929nUdsUvEHlKA2Nb6Unh6FLMLqZtYH
         egLqNgTJC4ltUnHCmL4ldsXXP8yE3tNaKDwei7cSI03wrvByvYADV9rjrNPLfZfCd8W4
         zO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=CKShoNw859JoAcxSWO2dnXa71IpHxX03Ho909swdfL4=;
        b=tajLdnM9ae2xp7aMY0aGDxEZD/FXfw/GrpZliPoBpFrZaOL/yLjuDnDEvgljpcM6pQ
         vQy+KCjerbwRIAwW9urs4S8NubqTnqTCbvb45wa2FO1HfYU/NvQCbdUk7pOTJ+es8NOo
         uPBw+J+uUhtlRh3My7JMbfCrfLUNTvoYEJoZD4BWYegqX/M9UzIdm3GA45Ro7UkaO6nn
         pSPv75yGKc89FmRgrn5Bnzc8RQsv9qwS6HFCspwJd4sPS0Fz7y1D18I5a7J+ls6ZaXfc
         n3I0urMMA7TZHLmWUAPs4iKPKvgO2PzS4d26Z9eMJUx8k2rLxwbcQzc6vwZYa0tyt2Ok
         dXOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Sun, 6 May 2018 12:04:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kees Cook <keescook@chromium.org>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Alexander Popov <alex.popov@linux.com>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>,
    PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
    Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
    Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
    Mark Rutland <mark.rutland@arm.com>,
    Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
    Richard Sandiford <richard.sandiford@arm.com>,
    "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
    "Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrey Ryabinin <aryabinin@virtuozzo.com>,
    "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
    Thomas Garnier <thgarnie@google.com>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
    "David S . Miller" <davem@davemloft.net>,
    Ding Tianhong <dingtianhong@huawei.com>,
    David Woodhouse <dwmw@amazon.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>,
    Steven Rostedt <rostedt@goodmis.org>,
    Dominik Brodowski <linux@dominikbrodowski.net>,
    Juergen Gross <jgross@suse.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Dan Williams <dan.j.williams@intel.com>,
    Mathias Krause <minipli@googlemail.com>,
    Vikas Shivappa <vikas.shivappa@linux.intel.com>,
    Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
    Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
    Florian Weimer <fweimer@redhat.com>,
    Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
In-Reply-To: <CAGXu5jJ1rPmb_fs=iN5x6fTMtew8+jxrb=VxQQwiPLYzjxE07g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1805061204060.1685@nanos.tec.linutronix.de>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com> <1523024546-6150-3-git-send-email-alex.popov@linux.com> <4e668302-8754-3f4e-3372-d0d7ba30cfa3@linux.intel.com> <CAGXu5jJ_0e63QSv0YZsQoT_=zN8U-83nwxrQ10h=QjszbHK-aQ@mail.gmail.com>
 <alpine.DEB.2.21.1805021041260.1668@nanos.tec.linutronix.de> <CAGXu5j+4Rj3oOH_iHhfD9sMMa2hRVm_dp9oA6YKhN9omhjdtEg@mail.gmail.com> <alpine.DEB.2.21.1805021438470.1560@nanos.tec.linutronix.de> <CAGXu5jJDwLfg0LPYkYKZcgqwbej-xVUB+6rSaLE+OvKQxy-Y9w@mail.gmail.com>
 <CAGXu5jJ1rPmb_fs=iN5x6fTMtew8+jxrb=VxQQwiPLYzjxE07g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1599708732251432384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2 May 2018, Kees Cook wrote:
> On Wed, May 2, 2018 at 5:51 AM, Kees Cook <keescook@chromium.org> wrote:
> I think it'd be better for this to go via my tree with your Ack (where
> I can carry the plugin, lkdtm, x86, and arm64 changes). How does that
> sound?

Works for me.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

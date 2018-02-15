Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518657446; cv=none;
        d=google.com; s=arc-20160816;
        b=Dl8p9DiyYdEJiXP0jdi5CSUyltwBEnJAbzwNDXSGB+hozMIiji/NwZV90Nu8g5vrny
         k+wXBJXUL2X/UnKkp+RCAGYv5uBpjHJVrRRA6TutUdBza+BfQ6IBWJiJ1nCXj5YPvazK
         LPT0vlFLwfUVkE67UYMSKCJnDOmQCI0zDNxowgHd0CJQk6LfMBomhXyGsqfKocoCtJcw
         ZFiLEr/daKfUPbI8NQBGXA/gSFmFhSkNaRt/6wgnhRoa4LUyzbYBOn2SsVCiNQQyirFM
         34C8Hb58YXW82Lne8k1r5r9WploIqsoIXiwblBeCTvnvbl4ooatX8kHpKN4Ljaxh8HYI
         WVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ojy2HdxfOVT3zA2bSzN65obP3DzWclKAZqnKwvttIqI=;
        b=lSX6o4qyN0nnzoabtugr4QX8Z5mB0yVBmrC2vXymwl8WBm3hOFou7e6QirRPSgVqfx
         Y1qVBOPfXIQG4sX8X+dPcuzEmzJy1YSu70fDz/7xCKhdvkT2cJL1EomFpNiS1Nil0dJx
         g0yHvHrYKuTW2OgALA0FDgehoInL4EVP7cYIu4DMAmRPYwio6y0G2kGfVq1DgAGH6GZL
         6Hdq338JbF423pyFJSf96lb+RuEllsq+uZvC/vbO8zyHuAB3UOIWyEAZir0kAIEX/nzU
         7KqAxW1bmrhThCRiHTFCn3ReIS8ewPrB/uuy/8D75TkMGUgLS73maoPgA289ZA3Udf7E
         fZcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kc4YnfR5;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kc4YnfR5;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x224o7SUPBnBZaMHX45U4x5bDLZNIXiKn+3ImmdutLKhwWsYZivVlRpu6WEQCXVWdzLmFtjetA6HLi4pu3/Ird8U=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
References: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 17:17:25 -0800
X-Google-Sender-Auth: ajR_fM6wdgiO_oipi_1My9rWojk
Message-ID: <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
Subject: Re: [GIT PULL] x86 PTI and Spectre related fixes and updates
To: Ingo Molnar <mingo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Andy Lutomirski <luto@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592425307928838978?=
X-GMAIL-MSGID: =?utf-8?q?1592427750259348291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 4:38 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
>    This tree generates two relatively simple conflicts with your tree:

So what annoys me about these conflicts is that I'm not convinced that
the stable tree actually *uses* your fancy x86/pti branch?

I think stable ends up working like a patch-queue anyway due to how
Greg works and all his helper scripts, so the whole "let's keep a
branch for pti" ends up being of dubious advantage when it results in
conflicts on merging, and it's not the same commits in the end anyway.

This is not a complaint so much as a "is it worth it?" question..

              Linus

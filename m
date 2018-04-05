Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx498pPwlLBXA4aeP/NHGGwMXU5REp4x1JORWI1h3iSSm65J2c05I3kYy9Jd25wVLl5goiTDe
ARC-Seal: i=1; a=rsa-sha256; t=1522916664; cv=none;
        d=google.com; s=arc-20160816;
        b=D6m9arq0zt926oKjWoLGB6P3zQzxfDcshvU9Ipf/07tzalb1bfT0PXXptsSQyRlDH5
         AnZY0yeEv2ItGCyvOqJkgTRcSoP9NIHX6urbUtAbi/lRA83PazU/PLKgRR59h5TrJJJU
         9QeKSueaW2HAXRYvZ3EsdJmDRVwA0TVFPNEXIY4ZX8fXGVjkdfOIoHI+6CuUurLySD75
         bFETYN1jHT15bd9A9RSKCAQzFtX6uB6vRh/4zEGFnjkngOeSLIuFHvRSRYQTa5Ap5aBo
         tQ2WpVy4Uk35RqP9DHtxzrqPP6qrD4xApptMCLOQMTKo3Ns425VQVBOuyhsl2vbGNeNR
         t/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=HUP8MtlMKxEkJK3kYzHNmdEhGaGhUfSXuF1JLJYDgQY=;
        b=iUg5vtbOEY14UfM+qoS2os9Gkwc65FH1ZTo8QqEhCmszNi7FZU/B5kvIq5E9DBPHHO
         QsdwLv2EynBD/OKJr2lIKLub8VWKTPOTB86Lf76rZOea5+NT9JgTeWICfzJ22JrRBF6T
         iuSS4zLcoWvdjpK7dwgkd5tcwOfK+Nu6nPIJ+sXJSnNvDYar4zSGl11ssNN+fisJgRsQ
         bUCjDXBHFfrkhprOY4QhZdR/QnNepkWm/JsSL5LcCczCAFAQI5uzfssW1SmxS8WvuOv+
         aukwGVexjruMoaDwmeSm6OlCRMJ0rOEJAr8ebCrUZjmuce3vQvrN+dUnOgzmduAfXb6r
         dEXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=oLSMAqbz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=oLSMAqbz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 205.233.59.134 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 5 Apr 2018 10:24:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180405082409.GK4082@hirez.programming.kicks-ass.net>
References: <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
 <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com>
 <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
 <20180405072401.GO4043@hirez.programming.kicks-ass.net>
 <20180405080446.qomyc6ozug3g57gl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405080446.qomyc6ozug3g57gl@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596893863868517417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 10:04:46AM +0200, Ingo Molnar wrote:
>    http://www.agner.org/optimize/instruction_tables.pdf
> 
> The SkyLake costs for 'BT', 'AND' and 'TEST' variants are:
> 
>                   BT             m,i               2               2         p06 p23                   0.5

>                 TEST           m,r/i               1               2       p0156 p23          1        0.5

These two I would imagine (I tend to forget about the TEST instruction).
And while they're of equal speed, TEST has more ports available if I
read that right. But yes, on SKL it doesn't matter much.

But if you go back in history (a lot) then you'll find BT being far more
expensive than TEST.

On the original Pentium for example TEST-m,r/i is 2 cycles, but BT-m,i
is 4-9 cycles.

But yes, going by the tables that's all hysterical raisins, modern cores
don't much care.

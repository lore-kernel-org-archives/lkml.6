Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx48oq9QpFmmrMBCPNzJLDrhquU+txbVjrKHK5Okf5YYH+OC6B8x/uK9F+Hf7MffqPYqqbsg9
ARC-Seal: i=1; a=rsa-sha256; t=1522912823; cv=none;
        d=google.com; s=arc-20160816;
        b=OsdRIW053uSgY2blN5GGu1Azmr+oTZWfGJDvoWDBNZRsWNUL+KG2xeRXaKZwN2RJ7u
         Z7cgHlaZgHfBsrDzywFKBMps0zc/0U5rNe3Gc2p11YfQ0kqc5Ir8imjk+Z7Pee2GtM5N
         w8HMGkcgzAd3lw1EI+9x0xEv6cpjjzNecltNLrCtHSYNbrksumLuWcD29Vim++A6miRb
         2z1BTbQyNLmudsPzTYk1BeEueogHIr++uguVLDrlVZ82npZJj+FE/X62rsZ5DxdGTZov
         Keu47Wms26jyRDcYPqkDHrE0RZSZMWDbW4wp0uE3onMHu3E3pV/Y+k/MGBBtZKclDJUO
         /eeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DzuIxCPNeV8Au6y2zS/c8o2zsgSBW9CfqWO9ewR2Dp8=;
        b=eXr4xj5pZjs+vDhaTWpYH9w16F/E3DkyQ/QMwquPhMmHSehd0WY8KIgylYUEc1BGpj
         M4JCcMh1upvXCJLeqEANkLUgAnSn7YxGTemHSKv5Wtp0aLCd5S/W186a7t6YBV2B/gmq
         POwaATykFGy7W6lsHZ/9YnBfvgzLepCtdMIqE6JbOal/s80NXCxpgB3XvYaiA1yDnCTA
         d/MMQZvnitI7G40O4p68+UgXnUpjboMHO/Xq0CBbg4ImQsB7kmqljJgs9a7nSlhKE+kB
         b4pUC+mGikigQ6wcBgL46fReGseMS4YGs/aYhGs0/KVRtJAv6HW4OArI0c4OkgSBc8ZR
         GuGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jqqwn1Uz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=jqqwn1Uz;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 5 Apr 2018 09:20:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20180405072017.GN4043@hirez.programming.kicks-ass.net>
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
 <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404233111.GJ87376@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596889836914757995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 04:31:11PM -0700, Matthias Kaehlcke wrote:

> From some experiments it looks like clang, in difference to gcc, does
> not treat constant values passed as parameters to inline function as
> constants.

Then you're also missing a heap of optimizations in code like
rb_erase_augmented() which is specifically constructed to take advantage
of constant propagation like that.

Other sites where we expect that to happen is __mutex_lock_common(),
__update_load_sum() and a bunch of others. There isn't strictly a bug
here, but not doing that constant propagation will still result in shit
code gen.

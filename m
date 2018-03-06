Return-Path: <Jason@zx2c4.com>
X-Google-Smtp-Source: AG47ELvnaphi0/HYllSujxMnw+GWvwf9cfCt1QJKxP+29wxbvrIsQC6vNpXbW1LNEZTS729AIK2c
ARC-Seal: i=1; a=rsa-sha256; t=1520350798; cv=none;
        d=google.com; s=arc-20160816;
        b=s7yN9c55hPmy5Vb9d3OZ+Eh/532Ck+WPD8LrE9XETfgyH3CZGm8VoNaXr34EHUWeHf
         kCTLd5MyzuCfjpSuxWWWRqAOpo7ej4V+Xf6o5UJJWjdaIYyNxcGCX5tkBU/447hg1idZ
         AdKj+uxAV8+Ii1rNMuT6Z4ZuxP1pqafNLoa5l/t23kSjwg5aQ76jtJ+qlikJrW3EeeRN
         12xt9rLP2icOoK3lRRdYpHA4dPpCMbol/4wQ66ceU3g9Ik8jWvj4/MfFT3rB1g260Ugx
         kHoW1zwyPT4qIsft4aigRF0nW1osKWnGur8zcGAU2YU6F5Jxnkm185bdmsEKXUF7kue6
         8zGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JWfYnwLLlBWikPsD/qK93wKdBkAMpXCBwqcisfGjfFI=;
        b=u9Xo82j47QIOoDLQKPForgJDs3hcEmKq3UF6cyjvslJZ2LNtUASJQuQNvlDKWhiNX/
         /cGh1Cw+ckSPBRSOSdUGDzZvZkCJvjYTf8ijeVHTN7NLGwH+kH8ZjoDfhqL3FF8sLwOs
         WS6fkCdKwQmycETTnTwZ/3QMWKBap3s4k7KtNVlhSnML0HSGePvdfRjsQeSfllWcoVQf
         xsY+rIku2jzoYjwRXQkp4/n9Vzz6uKyVvNdgmQQVlMXcnnL9nQ5+mO1Wl0i9QCg1fcZL
         5DNqi8yw4povWefCuiZQfuwUYkhrjFhG24aTfut89m+OUqOxen5Jkk2T6NiyOkGrUzMY
         vsjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=Wu0ZHSnu;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@zx2c4.com header.s=mail header.b=Wu0ZHSnu;
       spf=pass (google.com: domain of jason@zx2c4.com designates 192.95.5.64 as permitted sender) smtp.mailfrom=Jason@zx2c4.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=zx2c4.com
MIME-Version: 1.0
In-Reply-To: <CA+55aFzLR2DbGnAKQwg79Ob9dpkOM1Z7bxkjyPBSp3Zdxmk5eQ@mail.gmail.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de> <20180210091543.ynypx4y3koz44g7y@angband.pl>
 <CA+55aFwdLZjDcfhj4Ps=dUfd7ifkoYxW0FoH_JKjhXJYzxUSZQ@mail.gmail.com>
 <20180211105909.53bv5q363u7jgrsc@angband.pl> <6FB16384-7597-474E-91A1-1AF09201CEAC@gmail.com>
 <20180213085429.GB10278@kroah.com> <CA+55aFzLR2DbGnAKQwg79Ob9dpkOM1Z7bxkjyPBSp3Zdxmk5eQ@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 6 Mar 2018 16:39:43 +0100
X-Gmail-Original-Message-ID: <CAHmME9rntZnGBfN_yp5+zBBpXiinFJTU2RkuREa4a5DQGiMB7A@mail.gmail.com>
Message-ID: <CAHmME9rntZnGBfN_yp5+zBBpXiinFJTU2RkuREa4a5DQGiMB7A@mail.gmail.com>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Mark D Rustad <mrustad@gmail.com>,
	Adam Borowski <kilobyte@angband.pl>, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1594203358431795980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

On Tue, Feb 13, 2018 at 6:25 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So let's try to fix the iscsi and ipsec issues. Not that anybody sane
> should use that overly complex ipsec thing, and I think we should
> strive to merge WireGuard and get people moved over to that instead,
> but I haven't heard anything from davem about it since I last asked..
> I have some hope that it's slowly happening.

Sorry for missing this comment earlier. We're really quite close to a
point where we can post our v1 patchset. I'm headed on the road this
week, but will be back on the first of April, and I expect that
sometime in the spring we should begin to have the cycles of posting
patches and receiving reviews and getting this into shape for shipping
upstream.

So, fear not, we're still rolling ahead!

Regards,
Jason

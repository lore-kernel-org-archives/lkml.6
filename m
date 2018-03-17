Return-Path: <kernel-hardening-return-12688-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuvzL+XuBaeGXk4dzzxpXNJYRZkstpi4LeMtLWL4U2gzaKNq2TLixI7O8kD/rhhYvYWAPz9
ARC-Seal: i=1; a=rsa-sha256; t=1521327345; cv=none;
        d=google.com; s=arc-20160816;
        b=qfNq2f4qCYDA+ay/JZ2BpAmpnqOVVwdpcprihh4nFude4twPq3jBtcSOjQQyuHnqGh
         G8Ivrp+PfqTjdYgBxvNauRSeBDFOdOlPwRyaRt5rmGceKbgg25npphela180sfDaIcYn
         JVo1tAHxUfmyC4NdJtn6p/Vl0/Iq7M40A7DASTm3LgcIDdAa1M6vmTgdsEuaZwD57RSP
         Zo1pX/OQkgQt9A33bX8igVBUVyUAFBJWntVAHYqc1naZ/IjSsmJJRkcEQUXmkZ6C8lEd
         jpXq2RuuiISL8EBuDiXVklRJGuNcgwP9ktoAj2zEupXcr00S9t51rPkBfqdYUAXgTwzH
         r9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=axO1CHEoQB4zFM15EMLRl+Ov+TyIwfRxpOreeF1NtK4=;
        b=1CDCgg6hbpNRXtvNxU5p+kVwKC2uIbtxxDvSei4Fx1k3FMW4S97CAK5/3kAhn7NYXh
         Sw7ItYDL8u6upHB+WkazzTUYuXymwji00ZtPzFOXSKtWTjNzg9yTiwsa4byGLInXv+SA
         nL+etjq8rLCHFg6XJKdnCIeC7R8RhiMOtRRTC0+A+VD1648ocddN5lTB/czB2Jfdo3te
         MUKv2dvkOTqFFzZJaVMwUa0ycipGq/EGQZmm+AdX8FNgCdIVi0/LVUNoTlisYooCm+bx
         BPsVpAs2ffLR0gTlvNPpc4vBFcWuF39D3lIJv3YvxKkPhH/ryafWCnHL/rEogmCW4EV/
         lbDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12688-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12688-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12688-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12688-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 17 Mar 2018 17:55:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
Message-ID: <20180317225524.vy7vpopgiwjcp2sa@treble>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
 <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk>
 <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595227342998380684?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 17, 2018 at 01:07:32PM -0700, Kees Cook wrote:
> On Sat, Mar 17, 2018 at 11:52 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > So the above is completely insane, bit there is actually a chance that
> > using that completely crazy "x -> sizeof(char[x])" conversion actually
> > helps, because it really does have a (very odd) evaluation-time
> > change.  sizeof() has to be evaluated as part of the constant
> > expression evaluation, in ways that "__builtin_constant_p()" isn't
> > specified to be done.
> >
> > But it is also definitely me grasping at straws. If that doesn't work
> > for 4.4, there's nothing else I can possibly see.
> 
> No luck! :( gcc 4.4 refuses to play along. And, hilariously, not only
> does it not change the complaint about __builtin_choose_expr(), it
> also thinks that's a VLA now.
> 
> ./include/linux/mm.h: In function ‘get_mm_hiwater_rss’:
> ./include/linux/mm.h:1567: warning: variable length array is used
> ./include/linux/mm.h:1567: error: first argument to
> ‘__builtin_choose_expr’ not a constant
> 
> 6.8 is happy with it (of course).
> 
> I do think the earlier version (without the
> sizeof-hiding-builting_constant_p) provides a template for a
> const_max() that both you and Rasmus would be happy with, though!

I thought we were dropping support for 4.4 (for other reasons).  Isn't
it 4.6 we should be looking at?

-- 
Josh

Return-Path: <kernel-hardening-return-11874-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224lcKy8F2ZzdcGs3Bzd3obcUvBb46YzWrIK18wASpC1Sm1w863bMCJ+hnfkM3lJ7YvzUW/9
ARC-Seal: i=1; a=rsa-sha256; t=1519255496; cv=none;
        d=google.com; s=arc-20160816;
        b=wy10TMyYDBIicAyr2EXo/7/wRMxNK3YUwnlNIyfNvOZpwFbXD1WRs776dQEQwgCKCa
         eHwJ+EhUA0Mpxor8qN0Xmyukd55n7fwzGzSmpVjOOim/hYJPxriS3iGDA480G1p8fKkt
         oJzhcpRxdB3x/wB3po3SnphdYkCcHEIUwD6QI+JHko9XIox12YHVjhAqRRPUOq+qWfuI
         GJv+bho8hi87Lmymnda78aneM5Ylrj44XYPBFhhjF455N0RpBywvZhNritC5cX9iSnel
         IHbh1/bOzAXzU+8K2hFciGtBcQOY38zO61xYyRLKRuCKqMgB9lU87JhrHyVCpap9mNvI
         AACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=xt/QNjbn3FM2KIZamwCl6Of0+KVL6Rg38h7I8uED/Yk=;
        b=tgJAoQ3GQuwd5bUDYbqydsN24P/xvB2H2QdxchYk4PhoXIgNRpdRkHMQZD3FSPfjrP
         JkQdOj++nP1CXtGExgjWbpuCLJg4tKlulXW5OU/90BtKr/SDjJ2q8CNJnVJkfkQiyzuQ
         uB08h3A8rn+ByzqA2c0YpcY1PEVTSl1/HUCDk6Gwq7r4VE1BggpuNdf6skiybABajDJ3
         YF3sfBdNd/K+vt7dfR2wAyxQCSQTzJg3KX5xAWYB1NUSzGQZeiRODmmWPF9Yf+wKVSjb
         sSz85m6jsBKCwyKL6FbZybafQpylFFqx9B0n84yMLLu9koZlQOHDHBHE+R/jyw6ee1Qi
         hXEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sKhv23yJ;
       spf=pass (google.com: domain of kernel-hardening-return-11874-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11874-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sKhv23yJ;
       spf=pass (google.com: domain of kernel-hardening-return-11874-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11874-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
 <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name> <CAGXu5j+gvH+X-XyqFbY+X0xtG2mQoL5bO7T2_QaeEyr3-Z5eLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Feb 2018 15:24:35 -0800
X-Google-Sender-Auth: JROn-6c4Q6G7KBAnFKw6kBqFC4M
Message-ID: <CA+55aFzsiVMFZVwm92N8L=E+YgOG+fpjwxt7rmz72=yMQGz8rg@mail.gmail.com>
Subject: Re: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Kees Cook <keescook@chromium.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Patrick McLean <chutzpah@gentoo.org>,
	Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Bruce Fields <bfields@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
	"kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593054850715805472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 2:52 PM, Kees Cook <keescook@chromium.org> wrote:
>
> I'll play with Linus's suggestion and see what we get.

It may be just as well to just include <linux/compiler_types.h> from
<linux/kconfig.h> and be done with it.

If you look at that hacky script I documented in commit 23c35f48f5fb
("pinctrl: remove include file from <linux/device.h>") and run it in a
fully built kernel tree, you'll see that that header is included from
pretty much every single file anyway. At least for me, for an
allmodconfig build, the top headers are

  23322 arch/x86/include/uapi/asm/types.h
  23322 include/asm-generic/int-ll64.h
  23322 include/linux/types.h
  23322 include/uapi/asm-generic/int-ll64.h
  23322 include/uapi/asm-generic/types.h
  23322 include/uapi/linux/types.h
  23323 arch/x86/include/uapi/asm/bitsperlong.h
  23323 include/asm-generic/bitsperlong.h
  23323 include/uapi/asm-generic/bitsperlong.h
  23326 include/linux/stringify.h
  23390 include/linux/compiler_types.h

and considering that I have 25949 object files in that tree, it really
means that just about every compile ended up including that
<linux/compiler_types.h> file anyway (yeah, the "orc_types.h" header
ends up being mentioned twice for most files, so it looks even more
hot, but that's not real data).

I do hate including unnecessary stuff because it makes builds slower,
but kernel header files probably don't get much more core than
<linux/compiler_types.h>.

              Linus

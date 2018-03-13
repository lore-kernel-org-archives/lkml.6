Return-Path: <kernel-hardening-return-12491-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv2t+84ij1eO+vmcnPjLYDZikYYVvUIm7AYNpNSbnVCTdXFw6XOttsAO3PoGk8lQTV0Ax2A
ARC-Seal: i=1; a=rsa-sha256; t=1520915358; cv=none;
        d=google.com; s=arc-20160816;
        b=kip0aeXWKCBIO16kfwKkHSW2DZ4IAsLcF6vFUJV8OFy4fNofPOcG1g5F3hs/bdKSci
         U9mugx21covNwhJ8cEQONAYotDZi4kmpdjqQVFdQj024ZeOrKgPFPysyao5+5mDGjant
         KVvkJLZEdBeUhVBe1CEJsOSview7sGA4joVCV+hgkGfWO+5SC593l+VIL9nA+7k/qY2S
         1ksy/DpQM0OyiT8tfLvbWNlutJSiOCHSlsKc4b213kCs45YyqfQh9lQDvRjFII7pMQ2q
         OkPE44lwTaIwH53QKow8FxFFlsWuFZm/V31bpLjEB5Oa8epbS5N5kN8mjPxl4VyN3zJl
         7bBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=gcTBsGaR+npVp5SDZrMJ6Bto+FYsL+pcuhr5TML+g0I=;
        b=D22sJeTULxq7R7SmcZfb7iZwxwzq5uETG3az+UtoqmCAUAXFxGKyZmrjjkHkj5V0KL
         VNMoOF4ec5MZN54T6Y2U3EJhx3f860oZ77muccaiWjzf3901oJr1n/zRUTf13p0Gpdu9
         10a1/jNP2nIm6Fl8fZy4wuwsNOm4OGH+yeimRB1M0Vk76FjDHIlhnZPXHai9kwZ7ci2N
         9XDtA7jF3ASzJfgHqMLJcn23y18NqzZZFGpnmjUrKgi8dNO4F/NW9RbP17MX2SPxnn/C
         K8M5U4JUVmxgH/Qw8YqFhmNQas5D8O/MebGQOn8ZI/vAyem4dbnHYReim07BfLFurmbP
         C36A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E70oGQKa;
       dkim=pass header.i=@chromium.org header.s=google header.b=AbdE9HXZ;
       spf=pass (google.com: domain of kernel-hardening-return-12491-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12491-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E70oGQKa;
       dkim=pass header.i=@chromium.org header.s=google header.b=AbdE9HXZ;
       spf=pass (google.com: domain of kernel-hardening-return-12491-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12491-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
 <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
 <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org> <CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Mar 2018 21:28:57 -0700
X-Google-Sender-Auth: whAygmiSenmi_Ek9Jxzc1umwzq8
Message-ID: <CAGXu5j+M0qbBS0og8buXHdubA=oi=jMcK=ehLGDeevFd2H7JmA@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Tobin C. Harding" <me@tobin.cc>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
	"David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>, Borislav Petkov <bp@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>, Ian Abbott <abbotti@mev.co.uk>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Linux Btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594491887701841138?=
X-GMAIL-MSGID: =?utf-8?q?1594795343183227405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 4:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 12, 2018 at 3:55 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> Replacing the __builtin_choose_expr() with ?: works of course.
>
> Hmm. That sounds like the right thing to do. We were so myopically
> staring at the __builtin_choose_expr() problem that we overlooked the
> obvious solution.
>
> Using __builtin_constant_p() together with a ?: is in fact our common
> pattern, so that should be fine. The only real reason to use
> __builtin_choose_expr() is if you want to get the *type* to vary
> depending on which side you choose, but that's not an issue for
> min/max.

This doesn't solve it for -Wvla, unfortunately. That was the point of
Josh's original suggestion of __builtin_choose_expr().

Try building with KCFLAGS=3D-Wval and checking net/ipv6/proc.c:

net/ipv6/proc.c: In function =E2=80=98snmp6_seq_show_item=E2=80=99:
net/ipv6/proc.c:198:2: warning: ISO C90 forbids array =E2=80=98buff=E2=80=
=99 whose
size can=E2=80=99t be evaluated [-Wvla]
  unsigned long buff[SNMP_MIB_MAX];
  ^~~~~~~~


-Kees

--=20
Kees Cook
Pixel Security

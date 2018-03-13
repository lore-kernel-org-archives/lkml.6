Return-Path: <kernel-hardening-return-12564-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtLEOy8AVPiX6op/8fjJr2UaFZCA6rdrlIHkNnSX8iRrRHo0FWPs0GJ3hukObNxJ8Fgg32H
ARC-Seal: i=1; a=rsa-sha256; t=1520979293; cv=none;
        d=google.com; s=arc-20160816;
        b=LM4cdXuJ1xU2TpVEx9ZTJOv9cZujsJdgOd3dIvzGoQWuaVVnpJl7C75MNNUz7jsP5B
         xK71WZlSNhQj5co9KTwrs8WDZPZFS7/YvUy6T6d5GJtdLSvBNP1tNehdllA+DiNlKV9R
         +r3jUFV3Vp+Y+2Jm8hUYz6Q38bYvU7nXHd08Sk/gYgiHzV73VRwSQAm6tKLVIGmlBaZ/
         NMNQQSxc/Wuc5ETQdbhz4e/NfARIo9RhsDmvMAAKrfuD6bgZb6Ld6L62UoMdv9FhWvnv
         Y2zFOBf6SslHQHEcZYGdzWNFpabHQchbxT07BuzFV0EfLSXpLjC0Uiir1DyastCnXGAo
         sCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=WlR+Uy1GooYZI5irAD6fS7A5bH77xLHj0FIHL0g+gZE=;
        b=eUy8x1tLvgS5eOKLL1mEggmbVjNSdy12B+No6dxhcYMVY1BD5BLZ7fozklyy000tKv
         hI3KASo+/Sl3vYvGzyhV/yCKLgFvSIF1Xs7fg5GZm5mOhllcpORRqs1pDr77GZZewCT/
         cxVPZ3+unitj7k2JrpHID0L4ID/J7N8miTT2kChIWlmHHD6Mjw6S3b4UeO2PespTebY9
         bz1H4gNvnWcBdGvyKIpOi9x5OlC0I/HajWwsSVfx4HRFNyinDqbnDQERXKwu+WfKAVQ5
         YiFIt7m1HPHa2fnxf5LJXRj70efSosVGgXHL+Fe30gY9HspHWtpgA+fO8jEQHd1fn46i
         HMlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rVS9jkfY;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kyl6Bqhu;
       spf=pass (google.com: domain of kernel-hardening-return-12564-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12564-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rVS9jkfY;
       dkim=pass header.i=@chromium.org header.s=google header.b=Kyl6Bqhu;
       spf=pass (google.com: domain of kernel-hardening-return-12564-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12564-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180313140248.7fdb0d0cee044cd7c7fc7b93@linux-foundation.org>
References: <20180309200536.GA5670@beast> <20180309160719.154a3158e2d8ee56e43a918f@linux-foundation.org>
 <CA+55aFw9hWz1-YFVoHEiXDjqb9q7dz=rQVXr7YLkMuVLvbwaOg@mail.gmail.com>
 <20180309163241.a421e216999bd0b1f43a64c2@linux-foundation.org>
 <CA+55aFwbO2vUsjWzAwB6SZ65RM4r3P0+2JvyMHn=ry0CgWCBgA@mail.gmail.com>
 <CAGXu5j+D=zs8AMb969dhH05GmKPuBxKPcAs89KfKzVf47faL1g@mail.gmail.com>
 <20180312155524.b421f07d7f08f24c57bd1887@linux-foundation.org>
 <CA+55aFwK7W0SsaP5eR+2TxOj-j_Mu_E11fRw2Gk8ptV71ebvww@mail.gmail.com>
 <CAGXu5j+M0qbBS0og8buXHdubA=oi=jMcK=ehLGDeevFd2H7JmA@mail.gmail.com> <20180313140248.7fdb0d0cee044cd7c7fc7b93@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Mar 2018 15:14:34 -0700
X-Google-Sender-Auth: tOZ8mq_84u8bLDT7jdVEAA1Z3u4
Message-ID: <CAGXu5j+JUfvYCej17Gx__3Vhu4JmimddrSgV89c2tkfwshH_Mw@mail.gmail.com>
Subject: Re: [PATCH v3] kernel.h: Skip single-eval logic on literals in min()/max()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1594862383586862058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 2:02 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 12 Mar 2018 21:28:57 -0700 Kees Cook <keescook@chromium.org> wrot=
e:
>
>> On Mon, Mar 12, 2018 at 4:57 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> > On Mon, Mar 12, 2018 at 3:55 PM, Andrew Morton
>> > <akpm@linux-foundation.org> wrote:
>> >>
>> >> Replacing the __builtin_choose_expr() with ?: works of course.
>> >
>> > Hmm. That sounds like the right thing to do. We were so myopically
>> > staring at the __builtin_choose_expr() problem that we overlooked the
>> > obvious solution.
>> >
>> > Using __builtin_constant_p() together with a ?: is in fact our common
>> > pattern, so that should be fine. The only real reason to use
>> > __builtin_choose_expr() is if you want to get the *type* to vary
>> > depending on which side you choose, but that's not an issue for
>> > min/max.
>>
>> This doesn't solve it for -Wvla, unfortunately. That was the point of
>> Josh's original suggestion of __builtin_choose_expr().
>>
>> Try building with KCFLAGS=3D-Wval and checking net/ipv6/proc.c:
>>
>> net/ipv6/proc.c: In function =E2=80=98snmp6_seq_show_item=E2=80=99:
>> net/ipv6/proc.c:198:2: warning: ISO C90 forbids array =E2=80=98buff=E2=
=80=99 whose
>> size can=E2=80=99t be evaluated [-Wvla]
>>   unsigned long buff[SNMP_MIB_MAX];
>>   ^~~~~~~~
>
> PITA.  Didn't we once have a different way of detecting VLAs?  Some
> post-compilation asm parser, iirc.
>
> I suppose the world wouldn't end if we had a gcc version ifdef in
> kernel.h.  We'll get to remove it in, oh, ten years.

For fixing only 6 VLAs, we don't need all this effort. When it looked
like we could get away with just a "better" max(), sure. ;)

I'll send a "const_max()" which will refuse to work on
non-constant-values (so it doesn't get accidentally used on variables
that could be exposed to double-evaluation), and will work for stack
array declarations (to avoid the overly-sensitive -Wvla checks).

-Kees

--=20
Kees Cook
Pixel Security

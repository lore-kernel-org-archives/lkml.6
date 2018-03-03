Return-Path: <kernel-hardening-return-12085-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvey/eeKkg7dXbXXNpoEOj6NNm1lzk3thSpccQn6QwB+e78KLpLNwEjCUk3Q5gmYyF0CkjD
ARC-Seal: i=1; a=rsa-sha256; t=1520085542; cv=none;
        d=google.com; s=arc-20160816;
        b=KsjMkDbYRG9nuxxeC1ksqc8SCi9RRFkwUYQl/Au/2tloSdoLn1VQWond7EusFmU73X
         md0906LlGgPKFKaqacIHV6gEYA+tLsykGwG7OAjFMx25vamXPD6olbGZV/YsWrU5ry1j
         YmqPUuz4wCqbjCkwygryK0khvbqCTa9Y+R7uQwo02zWB2iY/3u0MbMlD5Gi59IZv4TZb
         dKOyswU91z+NCB4ZlkUDO8NkMUhSdOiVcyKJnzgeURdLz2W9NccQKpU5ZETrm/sqrva4
         bayQ7L+Rc3KBzKsTJd1NP5/DI0BbQrvzMFho6Hk34WBBxfrZi/9DkuGhj1wTcg7eBrvX
         XLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=96DGP6ZbXyck9pxHya3Acq1KJi9dsOu4NVoGIgPibA8=;
        b=J/ndfimB85jyZvl5b6iUiFGOHU9tsHRcZ0/MIdWO9+H8AJ6lQTTZag3iJo0JNa2++E
         GvA3cBa+9EjjjsjG321WIFZK1CDmgB+GUhV5Z3Lj98NVwxuNw2ToREFadYtp0v5LnowV
         wSjjYBjGYAh5n4PcBMrcJztKXEnHCTJXZqw/uDDpIifXLqs/JhGBg0jQSxNUEowTMnX4
         W26b5U8AK7iwhVtttCja90FikQ8nkfjXqrNyyqUKA4ZPS25KQL2rB2YPksIpjrnbiVdc
         xprt0GeSOrB6XO5tYwTQ6Kj+lVdktmiV8sQjFwnMZ9IlwSU/AHnimlB+HtoT/6ZuNOb0
         fQ5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LfcFa0ms;
       spf=pass (google.com: domain of kernel-hardening-return-12085-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12085-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LfcFa0ms;
       spf=pass (google.com: domain of kernel-hardening-return-12085-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12085-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
Date: Sat, 3 Mar 2018 16:58:40 +0300
Cc: Matthew Wilcox <willy@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jan Kara <jack@suse.cz>,
 Jerome Glisse <jglisse@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Helge Deller <deller@gmx.de>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
To: Daniel Micay <danielmicay@gmail.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593925217881898327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Daniel, thanks for sharing you experience!

> On 1 Mar 2018, at 00:02, Daniel Micay <danielmicay@gmail.com> wrote:
>=20
> I don't think it makes sense for the kernel to attempt mitigations to
> hide libraries. The best way to do that is in userspace, by having the
> linker reserve a large PROT_NONE region for mapping libraries (both at
> initialization and for dlopen) including a random gap to act as a
> separate ASLR base.
Why this is the best and what is the limit of this large region?
Let=E2=80=99s think out of the box.
What you say here means you made a separate memory region for libraries =
without=20
changing kernel. But the basic idea - you have a separate region for =
libraries=20
only. Probably you also want to have separate regions for any thread =
stack, for=20
mmaped files, shared memory, etc. This allows to protect memory regions =
of=20
different types from each other. It is impossible to implement this =
without=20
keeping the whole memory map. This map should be secure from any leak =
attack to=20
prevent ASLR bypass. The only one way to do it is to implement it in the =
kernel=20
and provide different syscalls like uselib or allocstack, etc. This one =
is=20
really hard in current kernel implementation.

My approach was to hide memory regions from attacker and from each =
other.

> If an attacker has library addresses, it's hard to
> see much point in hiding the other libraries from them.

In some cases attacker has only one leak for whole attack. And we should =
do the best
to make even this leak useless.

> It does make
> sense to keep them from knowing the location of any executable code if
> they leak non-library addresses. An isolated library region + gap is a
> feature we implemented in CopperheadOS and it works well, although we
> haven't ported it to Android 7.x or 8.x.
This one interesting to know and I would like to try to attack it, but =
it's out of the
scope of current conversation.

> I don't think the kernel can
> bring much / anything to the table for it. It's inherently the
> responsibility of libc to randomize the lower bits for secondary
> stacks too.

I think any bit of secondary stack should be randomized to provide =
attacker as
less information as we can.

> Fine-grained randomized mmap isn't going to be used if it causes
> unpredictable levels of fragmentation or has a high / unpredictable
> performance cost.

Lets pretend any chosen address is pure random and always satisfies =
request. At=20
some time we failed to mmap new chunk with size N. What does this means? =
This=20
means that all chunks with size of N are occupied and we even can=E2=80=99=
t find place=20
between them. Now lets count already allocated memory. Let=E2=80=99s =
pretend on all of=20
these occupied chunks lies one page minimum. So count of these pages is=20=

TASK_SIZE / N. Total bytes already allocated is PASGE_SIZE * TASK_SIZE / =
N. Now=20
we can calculate. TASK_SIZE is 2^48 bytes. PAGE_SIZE 4096. If N is 1MB,=20=

allocated memory minimum 1125899906842624, that is very big number. Ok. =
is N is=20
256 MB, we already consumed 4TB of memory. And this one is still ok. if =
N is=20
1GB we allocated 1GB and it looks like a problem. If we allocated 1GB of =
memory=20
we can=E2=80=99t mmap chunk size of 1GB. Sounds scary, but this is =
absolutely bad case=20
when we consume 1 page on 1GB chunk. In reality  this number would be =
much=20
bigger and random according this patch.

Here lets stop and think - if we know that application going to consume =
memory.=20
The question here would be can we protect it? Attacker will know he has =
a good=20
probability to guess address with read permissions. In this case ASLR =
may not=20
work at all. For such applications we can turn off address randomization =
or=20
decrease entropy level since it any way will not help much.

Would be good to know whats the performance costs you can see here. Can
you please tell?

> I don't think it makes sense to approach it
> aggressively in a way that people can't use. The OpenBSD randomized
> mmap is a fairly conservative implementation to avoid causing
> excessive fragmentation. I think they do a bit more than adding random
> gaps by switching between different 'pivots' but that isn't very high
> benefit. The main benefit is having random bits of unmapped space all
> over the heap when combined with their hardened allocator which
> heavily uses small mmap mappings and has a fair bit of malloc-level
> randomization (it's a bitmap / hash table based slab allocator using
> 4k regions with a page span cache and we use a port of it to Android
> with added hardening features but we're missing the fine-grained mmap
> rand it's meant to have underneath what it does itself).
>=20

So you think OpenBSD implementation even better? It seems like you like =
it
after all.

> The default vm.max_map_count =3D 65530 is also a major problem for =
doing
> fine-grained mmap randomization of any kind and there's the 32-bit
> reference count overflow issue on high memory machines with
> max_map_count * pid_max which isn't resolved yet.

I=E2=80=99ve read a thread about it. This one is what should be fixed =
anyway.

Thanks,
Ilya

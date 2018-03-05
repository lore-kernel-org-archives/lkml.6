Return-Path: <kernel-hardening-return-12122-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsZeV33rbW+1JkCcwgApoOaY89WMn/NRN0E5ETtdR2Z/GrdglifSyYSxA6X+FJSiTTZpyJB
ARC-Seal: i=1; a=rsa-sha256; t=1520281252; cv=none;
        d=google.com; s=arc-20160816;
        b=dZN4I59hKLVHTGyjw5j3LzyqWoFLk8Uu4I0DNV22WauIofE34pefc0VZQkoJMeEaCK
         Y1W7JRSAf7nGRNMwx4gU6bnYSWX3FErIBqQUGl8KxAk2JwqcpTLOCqKuV07Ppd4qVpbs
         sWtb0qzXXHW7VnFQDmK6mYs+asaLvug2DmYG3/gIWbhP+KNXEEi7nhwwkEo809MuXKwJ
         AN2931LeEqrU0H0CeXU51kjKdebu/gvxQbr6Yz6cdfz8F9RduGFCZo0S0LUhoagQNqAy
         1PQtD+UPqQ3LXzhM3o1zUPxi/lvDk0ThMXBMYKlyWe5QsILxu6MWfweupET/17o/fbQA
         EgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=XA0XSQijkWkLCYpOKsnmfcEcJ2n9AzlDbgcSsM7eN10=;
        b=KeXMKh+/9W2ai3XtfoAregN75ZSXaRCpK+sfRZvG69lJT1ok/A1pFCce7dngUm/xXr
         fBem/wUPwWl0iifFeklP8cohBnC6ZlsKkcTa+9W/HwHVBPhB7cO/oRvc3PlE+ouwpMQz
         3BxROIUsNg62ZWZgr8cIGEHVjAoKndVvvX/n5ekFIEGq8phTAgQrRMJOyXvUnnxxBJhG
         t7mFp/mXkry1dSB1zesNbSPxdfjCl4kpYJzrMZRpzz5DbdTgkWARPZ33ZpwD9+Sv0+Si
         Ktz2EeImvUgq7O+oHPSCpchq5Ka3IHnksW40vPVAmQ2jWnO1wUBSA7aY7khnXDu0mfDN
         kPOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qF6cFiQm;
       spf=pass (google.com: domain of kernel-hardening-return-12122-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12122-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qF6cFiQm;
       spf=pass (google.com: domain of kernel-hardening-return-12122-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12122-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <20180305194728.GB10418@bombadil.infradead.org>
Date: Mon, 5 Mar 2018 23:20:31 +0300
Cc: Daniel Micay <danielmicay@gmail.com>,
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
Message-Id: <4CB48994-60BF-4329-B6CE-0613EE1F7417@gmail.com>
References: <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
 <20180304205614.GC23816@bombadil.infradead.org>
 <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
 <20180305162343.GA8230@bombadil.infradead.org>
 <EC4E37F1-C2B8-4112-8EAD-FF072602DD08@gmail.com>
 <20180305194728.GB10418@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594130435288328819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 5 Mar 2018, at 22:47, Matthew Wilcox <willy@infradead.org> wrote:
>>>> - the entropy you provide is like 16 bit, that is really not so =
hard to brute
>>>=20
>>> It's 16 bits per mapping.  I think that'll make enough attacks =
harder
>>> to be worthwhile.
>>=20
>> Well yes, its ok, sorry. I just would like to have 32 bit entropy =
maximum some day :)
>=20
> We could put 32 bits of padding into the prot argument on 64-bit =
systems
> (and obviously you need a 64-bit address space to use that many bits). =
 The
> thing is that you can't then put anything else into those pages =
(without
> using MAP_FIXED).
>=20

This one sounds good to me. In my approach it is possible to map there, =
but ok.

>>>> - if you unmap/remap one page inside region, field vma_guard will =
show head=20
>>>> or tail pages for vma, not both; kernel don=E2=80=99t know how to =
handle it
>>>=20
>>> There are no head pages.  The guard pages are only placed after the =
real end.
>>=20
>> Ok, we have MG where G =3D vm_guard, right? so when you do vm_split,=20=

>> you may come to situation - m1g1m2G, how to handle it? I mean when M =
is=20
>> split with only one page inside this region. How to handle it?
>=20
> I thought I covered that in my earlier email.  Using one letter per =
page,
> and a five-page mapping with two guard pages: MMMMMGG.  Now unmap the
> fourth page, and the VMA gets split into two.  You get: MMMGMGG.
>=20
I was just interesting, it=E2=80=99s not the issue to me. Now its clear, =
thanks.

>>> I can't agree with that.  The user has plenty of opportunities to =
get
>>> randomness; from /dev/random is the easiest, but you could also do =
timing
>>> attacks on your own cachelines, for example.
>>=20
>> I think the usual case to use randomization for any mmap or not use =
it at all=20
>> for whole process. So here I think would be nice to have some =
variable=20
>> changeable with sysctl (root only) and ioctl (for greedy processes).
>=20
> I think this functionality can just as well live inside libc as in
> the kernel.
>=20

Good news for them :)

>> Well, let me summary:
>> My approach chose random gap inside gap range with following strings:
>>=20
>> +	addr =3D get_random_long() % ((high - low) >> PAGE_SHIFT);
>> +	addr =3D low + (addr << PAGE_SHIFT);
>>=20
>> Could be improved limiting maximum possible entropy in this shift.
>> To prevent situation when attacker may massage allocations and=20
>> predict chosen address, I randomly choose memory region. I=E2=80=99m =
still
>> like my idea, but not going to push it anymore, since you have yours =
now.
>>=20
>> Your idea just provide random non-mappable and non-accessable offset
>> from best-fit region. This consumes memory (1GB gap if random value=20=

>> is 0xffff). But it works and should work faster and should resolve =
the issue.
>=20
> umm ... 64k * 4k is a 256MB gap, not 1GB.  And it consumes address =
space,
> not memory.
>=20

hmm, yes=E2=80=A6 I found 8 bits somewhere.. 256MB should be enough for =
everyone.

>> My point was that current implementation need to be changed and you
>> have your own approach for that. :)
>> Lets keep mine in the mind till better times (or worse?) ;)
>> Will you finish your approach and upstream it?
>=20
> I'm just putting it out there for discussion.  If people think this is
> the right approach, then I'm happy to finish it off.  If the consensus
> is that we should randomly pick addresses instead, I'm happy if your
> approach gets merged.

So now, its time to call for people? Sorry, I=E2=80=99m new here.

Thanks,
Ilya

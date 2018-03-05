Return-Path: <kernel-hardening-return-12111-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvAzqv7G7M/MfDcQLee20zSNORKC7alkMnqLnKVwa2vutxamKXwCtAZrVww2JH2xoSM2bA/
ARC-Seal: i=1; a=rsa-sha256; t=1520278074; cv=none;
        d=google.com; s=arc-20160816;
        b=OsqvAtdHDbtWjb3/rcnjbbsvouxYXVlj21kxm2QbPoEAHINL/eN8K5dENZ7rOELuEn
         YWOr5qZB5ySJWYIQv/ueLcBndaTzB/Z9LyAinOCTL59oWzkJst2HaYY6Qi5FfIpKY5lJ
         B7+px4uOpWynPZY7BqjT4NCLQZAQUsUJpRrhcXoyv3dROuebJck92nvXtBt4tsT3DoLb
         RqjRzmDh55h2IRP3yPeXUAD690L2qntkqOjbhylJ/Fw5TK1hGD4xbbw+GxuP/42Xd/Qz
         s1lqK/aYl9Zg22sY/qydgTzrTrKgoUgWMh3+mG9bHua/4/dbnfQ9ZyAT1WcIeyE+imm6
         6dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=/Bno5D2DcHGozFh1N4VqTmuIGKLck2seubG3XwPAX+A=;
        b=Boiaqo58QYgSA/8ASeLxd8V9StD/VpWbSVNepYIkLu7HuH9yuG8Xg7cHSgsGUnQsYT
         juwnb2UIgbi8vEjulmouRadzWLkKInnulvIB3my6RpeVRBmGHcOJod/E9oNaF/LsVG7P
         nlsE2FCyNSzyPdpTKyMOFdG9BcmkxbG0M32FN0g2G1M8MfU9xHg7HT/8gErto4/Najpd
         J/vvbP9rfKojph9Ko+vbnsd1oVPhC9JB7i7bjUy8dXodH3/7wBmThYUNsNJz/vzG8ey8
         M/eixcDFY4AUI+85EUsafnNJRDfT5OziLjMYypoZyzG8E7cox9mUXLLAhU46rl7wvR/p
         AiNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ED5Wnkua;
       spf=pass (google.com: domain of kernel-hardening-return-12111-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12111-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ED5Wnkua;
       spf=pass (google.com: domain of kernel-hardening-return-12111-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12111-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <20180305162343.GA8230@bombadil.infradead.org>
Date: Mon, 5 Mar 2018 22:27:32 +0300
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
Message-Id: <EC4E37F1-C2B8-4112-8EAD-FF072602DD08@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
 <20180304205614.GC23816@bombadil.infradead.org>
 <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
 <20180305162343.GA8230@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594127101618076009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>




> On 5 Mar 2018, at 19:23, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Mar 05, 2018 at 04:09:31PM +0300, Ilya Smith wrote:
>>=20
>> I=E2=80=99m analysing that approach and see much more problems:
>> - each time you call mmap like this, you still  increase count of =
vmas as my=20
>> patch did
>=20
> Umm ... yes, each time you call mmap, you get a VMA.  I'm not sure why
> that's a problem with my patch.  I was trying to solve the problem =
Daniel
> pointed out, that mapping a guard region after each mmap cost twice as
> many VMAs, and it solves that problem.
>=20
The issue was in VMAs count as Daniel mentioned.=20
The more count, the harder walk tree. I think this is fine

>> - the entropy you provide is like 16 bit, that is really not so hard =
to brute
>=20
> It's 16 bits per mapping.  I think that'll make enough attacks harder
> to be worthwhile.

Well yes, its ok, sorry. I just would like to have 32 bit entropy =
maximum some day :)

>> - in your patch you don=E2=80=99t use vm_guard at address searching, =
I see many roots=20
>> of bugs here
>=20
> Don't need to.  vm_end includes the guard pages.
>=20
>> - if you unmap/remap one page inside region, field vma_guard will =
show head=20
>> or tail pages for vma, not both; kernel don=E2=80=99t know how to =
handle it
>=20
> There are no head pages.  The guard pages are only placed after the =
real end.
>=20

Ok, we have MG where G =3D vm_guard, right? so when you do vm_split,=20
you may come to situation - m1g1m2G, how to handle it? I mean when M is=20=

split with only one page inside this region. How to handle it?

>> - user mode now choose entropy with PROT_GUARD macro, where did he =
gets it?=20
>> User mode shouldn=E2=80=99t be responsible for entropy at all
>=20
> I can't agree with that.  The user has plenty of opportunities to get
> randomness; from /dev/random is the easiest, but you could also do =
timing
> attacks on your own cachelines, for example.

I think the usual case to use randomization for any mmap or not use it =
at all=20
for whole process. So here I think would be nice to have some variable=20=

changeable with sysctl (root only) and ioctl (for greedy processes).

Well, let me summary:
My approach chose random gap inside gap range with following strings:

+	addr =3D get_random_long() % ((high - low) >> PAGE_SHIFT);
+	addr =3D low + (addr << PAGE_SHIFT);

Could be improved limiting maximum possible entropy in this shift.
To prevent situation when attacker may massage allocations and=20
predict chosen address, I randomly choose memory region. I=E2=80=99m =
still
like my idea, but not going to push it anymore, since you have yours =
now.

Your idea just provide random non-mappable and non-accessable offset
from best-fit region. This consumes memory (1GB gap if random value=20
is 0xffff). But it works and should work faster and should resolve the =
issue. =20

My point was that current implementation need to be changed and you
have your own approach for that. :)
Lets keep mine in the mind till better times (or worse?) ;)
Will you finish your approach and upstream it?

Best regards,
Ilya

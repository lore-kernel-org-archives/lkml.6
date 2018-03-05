Return-Path: <kernel-hardening-return-12103-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsxLeBtTv8lny7wPWmqEDZfwB+1Bzw8u2Q/WoWS1MB6CEwifjYqQQRUOyZqtE5A4E0vcX3c
ARC-Seal: i=1; a=rsa-sha256; t=1520255392; cv=none;
        d=google.com; s=arc-20160816;
        b=SwbGVG2OLM00aNkyB7ZLag+KXOiLLDbubdYyv20vA3StupKzwG8Ak4Nz2P18WPwMls
         xYZrKVNUPFHMKZ3Q2wGEUKYLjErNFRZU64OuIyW4okyHaXyGCeOm6VOdDP18k9qRV8co
         o5FR192xhsypZHe44IU3bfsn63JsKgCLr+kdvoBBo+am1KZE90CA1SoNemGdOtChJBCd
         /E5z9R6dlMh+8HBQ73yjdh79L3GPHDwYTwKhpYc1PKTmTrLYXCSlGcSS8A5WIDUvpptD
         RJnCmz9VjIkU8yRYlc0Moa1I6d/D1x3zuI962uSAfHfK5NhAmGbc+3ryjoBnrRWGk4oj
         IOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=/yfKakyszuF+TfANNAVGz1ibNZJ2iYTesgxA6QSGURw=;
        b=WF1qjZb3mmU22d9DsK9J62eWiGmH2JnhAsSRqhlLJHbCa1TcrIXwf0OK5Jqnp7sdBd
         OHEH1wgNL41anZqXERGgr2eM3jyRJHDmMaBh9QgmYNgSRVR9kQUvlSI+oaX2gFPhZE7Z
         pTb2t6VNaKPX6Wr9PqAuCw960aChIrBPJFa3CzIkOP//X1QVjrUALjR1JmyEdKUSR4mB
         1gn5t1x3KclCHPpj4YVG7AIcPFMaWJrPdqweN+Tj63bju7XmzGAXkQKjKcjAqoy0Gz7q
         FMpATV71mLDRPYe4mi8nTGdzTCyMnqctiyKYuXEKfQpjzsGisffEb63Dab/LOihu9I4I
         7YAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R69I3bP/;
       spf=pass (google.com: domain of kernel-hardening-return-12103-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12103-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=R69I3bP/;
       spf=pass (google.com: domain of kernel-hardening-return-12103-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12103-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <20180304205614.GC23816@bombadil.infradead.org>
Date: Mon, 5 Mar 2018 16:09:31 +0300
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
Message-Id: <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
 <20180304205614.GC23816@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594103318529909122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 4 Mar 2018, at 23:56, Matthew Wilcox <willy@infradead.org> wrote:
> Thinking about this more ...
>=20
> - When you call munmap, if you pass in the same (addr, length) that =
were
>   used for mmap, then it should unmap the guard pages as well (that
>   wasn't part of the patch, so it would have to be added)
> - If 'addr' is higher than the mapped address, and length at least
>   reaches the end of the mapping, then I would expect the guard pages =
to
>   "move down" and be after the end of the newly-shortened mapping.
> - If 'addr' is higher than the mapped address, and the length doesn't
>   reach the end of the old mapping, we split the old mapping into two.
>   I would expect the guard pages to apply to both mappings, insofar as
>   they'll fit.  For an example, suppose we have a five-page mapping =
with
>   two guard pages (MMMMMGG), and then we unmap the fourth page.  Now =
we
>   have a three-page mapping with one guard page followed immediately
>   by a one-page mapping with two guard pages (MMMGMGG).

I=E2=80=99m analysing that approach and see much more problems:
- each time you call mmap like this, you still  increase count of vmas =
as my=20
patch did
- now feature vma_merge shouldn=E2=80=99t work at all, until MAP_FIXED =
is set or
PROT_GUARD(0)
- the entropy you provide is like 16 bit, that is really not so hard to =
brute
- in your patch you don=E2=80=99t use vm_guard at address searching, I =
see many roots=20
of bugs here
- if you unmap/remap one page inside region, field vma_guard will show =
head=20
or tail pages for vma, not both; kernel don=E2=80=99t know how to handle =
it
- user mode now choose entropy with PROT_GUARD macro, where did he gets =
it?=20
User mode shouldn=E2=80=99t be responsible for entropy at all

I can=E2=80=99t understand what direction this conversation is going to. =
I was talking=20
about weak implementation in Linux kernel but got many comments about =
ASLR=20
should be implemented in user mode what is really weird to me.

I think it is possible  to add GUARD pages into my implementations, but =
initially=20
problem was about entropy of address choosing. I would like to resolve =
it step by
step.

Thanks,
Ilya=

Return-Path: <kernel-hardening-return-12061-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtd9YzBgHBoLzl2b2Qpw5dS0Zlet9Z1ETptlHTvNtY0bNI8wibUbfB5VIJgWmZAd8hKqG6s
ARC-Seal: i=1; a=rsa-sha256; t=1519912352; cv=none;
        d=google.com; s=arc-20160816;
        b=PbYJA7AbQ+/duMGvNhR09LN6S+Bgm4YPNJ5N1vxoQ8SQ//8qxl0DbQIAadmt102pGE
         90HjZ1dwY7lfNA1tQK2Z4aj2ZPDSvEpHyKOAR1kCEN2NdtAgeUqKsBvcrqrkWZR7GpsT
         Ke1r8emWPiDKhfbLr003U44YBNIUcrtRCpI2gsN2LgxgWJlai44oG/5rzFQGt3vzL67p
         mGRKNM7n0Qi/Qk2cQk8x0GoThVoQjkRpwAhQumSjZWHCR1oYUuQUEsxZbtk92y4riSGY
         YwTOYQ3hDvEQ+fvy4NSK/RrU7tEY65MYJFy6Kcwl3ewtqvMyVdZs28D4G8WklsSUgnc6
         aQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=OCyN+zWE2Zwaxoh9ZubIkb3IfuRhB6nXBKF+S3v3bPs=;
        b=Hw/LfMmkLtL5rjq6wmVHLw/jXf2/T9qjUG+SVL2X+mWY+8mWZKz5gy5RvqWZW/9fgk
         TPs8Y9feF9U+kQvzK2MbKKHIYofN/447J+Soy5Q1meB8ueSiBxZw0efq1UgyaBjL/k1K
         7IpxjOkgU0rAwAWMtvXY2nymZu6rq34DUe4ALZcfZuX9e/DOZDEBQhmh6qTJaNsC4Rcn
         D5TEgbdMlfpdz8zIu9vbAI8jSDj0X9cCoABGd5H/n77izIRRTSuYfwsZ/99F/ULm7WV/
         MCoLNCl3KJYpFxo2TjbyDnu82ecGS2y0giulgv2Gp92y5/lyQfjv2SRF71tXfBgvXkT6
         vHCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=etYqpPoS;
       spf=pass (google.com: domain of kernel-hardening-return-12061-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12061-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=etYqpPoS;
       spf=pass (google.com: domain of kernel-hardening-return-12061-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12061-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <CAGXu5jLY4eX5BMU8-2HFr2myjSL717KE-m_SAQp1yeu=cg+w7g@mail.gmail.com>
Date: Thu, 1 Mar 2018 16:52:12 +0300
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jan Kara <jack@suse.cz>,
 Jerome Glisse <jglisse@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Helge Deller <deller@gmx.de>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E526DB1-08ED-4BD9-AD33-A2EBCC95091E@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <CAGXu5jLY4eX5BMU8-2HFr2myjSL717KE-m_SAQp1yeu=cg+w7g@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593743614701932122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 28 Feb 2018, at 22:54, Kees Cook <keescook@chromium.org> wrote:
>=20
> I was trying to understand the target entropy level, and I'm worried
> it's a bit biased. For example, if the first allocation lands at 1/4th
> of the memory space, the next allocation (IIUC) has a 50% chance of
> falling on either side of it. If it goes on the small side, it then
> has much less entropy than if it had gone on the other side. I think
> this may be less entropy than choosing a random address and just
> seeing if it fits or not. Dealing with collisions could be done either
> by pushing the address until it doesn't collide or picking another
> random address, etc. This is probably more expensive, though, since it
> would need to walk the vma tree repeatedly. Anyway, I was ultimately
> curious about your measured entropy and what alternatives you
> considered.

Let me please start with the options we have here.=20
Let's pretend we need to choose random address from free memory pool. =
Let=E2=80=99s=20
pretend we have an array of gaps sorted by size of gap descending. First =
we=20
find the highest index satisfies requested length. For each suitable gap =
(with=20
less index) we count how many pages in this gap satisfies request. And =
compute=20
total count of pages satisfies request. Now we get random by module of =
total=20
number. Subtracting from this value count of suitable gap pages for gaps =
until=20
this value greater we will find needed gap and offset inside it. Add gap =
start=20
to offset we will randomly choose suitable address.
In this scheme we have to keep array of gaps. Each time address space is=20=

changed we have to keep the gaps array consistent and apply this =
changes. It is=20
a very big overhead on any change.

Pure random looks really expensive. Lets try to improve something.

We can=E2=80=99t just choose random address and try do it again and =
again until we find=20
something - this approach has non-deterministic behaviour. Nobody knows =
when it=20
stops. Same if we try to walk tree in random direction.

We can walk tree and try to build array of suitable gaps and choose =
something=20
from there. In my current approach (proof of concept) length of array is =
1 and=20
thats why last gaps would be chosen with more probability. I=E2=80=99m =
agree. It is=20
possible to increase array spending some memory. For example struct mm =
may have=20
to array of 1024 gaps. We do the same, walk tree and randomly fill this =
array (=20
everything locked under write_mem semaphore). When we filled it or =
walked whole=20
tree - choose gap randomly. What do you think about it?

Thanks,
Ilya

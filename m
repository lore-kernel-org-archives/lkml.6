Return-Path: <kernel-hardening-return-12087-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtGzlHpawVKXMAeXa4Rkc1FH5g8flzgn+UznEwCDlhLiI+fw+Sl0DiGcD2t2OpYhHbc2ID+
ARC-Seal: i=1; a=rsa-sha256; t=1520090030; cv=none;
        d=google.com; s=arc-20160816;
        b=AnGPPj+tlRQeHWWZA6Tsx3sS+qeQ2LtX0yLb17s+2G1qjyTJXTnt5HRslIbzk6+MAj
         9QrNktgkQAQYIuDnOW7ZBT28gDoVfd77oRqFIByspZ2TygxnlTmYPJzSyYr3RvVvHLUE
         C4jkJ3eWxDwmBAxoIbChGuY8/BR3aX4q+MUFeL+qJKoexlr/cDoG9IHgP5KI8DAn3d4W
         51O8KosYaEBD8icirAVkVrB4Uvv4LJ+8sno9K0UeZ9uZ9IcDF5y3jRYXZdBKqNon/tj/
         4LDgT2Bx5//CJHtIxs9viYcHqcDS3UEyTGTRWjeWzbs3xYj21W/ihIgak016BzTpCrwF
         YVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ggYTqIygwWNZ1gzpnb4lYEpgDrUqph/wYXSBgZo0vYM=;
        b=N8F6QEx83dgIyhcyRXYUfyTPDAaUoWB9pNuaRo2uBooqEK6XMl6ReDaHU9DzsyqoU6
         sXVxfm5649Maxy+Wz8TkdXop5/Ljf+KXIGpzSta/XJsR81XDB/Qx6uYShxRB2U81r+gL
         0Nc/t4zxTzIMBPvwukHswG64mV5/kUmIDAxfNKz8ZIlgxbZzeuLJomAnXu+knIyGO4X5
         dIo9H2QOdqIHB8LIrJpzoxLN42/IKL5LAghxE33bxkIKB4Y/E8ixsagcVe3bnTKHGmir
         XJ8dSB6KGXPlpwqmT1x+N8F5w7jjJvLpoD6hLnLccgm0BEqYsDUmIoY4f4tyypqdZiU4
         +tKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nprPTKCh;
       spf=pass (google.com: domain of kernel-hardening-return-12087-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12087-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nprPTKCh;
       spf=pass (google.com: domain of kernel-hardening-return-12087-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12087-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <20180302204808.GA671@bombadil.infradead.org>
Date: Sat, 3 Mar 2018 18:13:28 +0300
Cc: Kees Cook <keescook@chromium.org>,
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
Message-Id: <221A2345-53FF-4471-B4FA-C79AF90B70CE@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <C9D0E3BA-3AB9-4F0E-BDA5-32378E440986@gmail.com>
 <20180302204808.GA671@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593929924163177154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 2 Mar 2018, at 23:48, Matthew Wilcox <willy@infradead.org> wrote:
> Ah, I didn't mean that.  I was thinking that we can change the
> implementation to reserve 1-N pages after the end of the mapping.
> So you can't map anything else in there, and any load/store into that
> region will segfault.
>=20

I=E2=80=99m afraid it still will allow many attacks. The formula for new =
address would=20
be like: address_next =3D address_prev - mmap_size - random(N) as you =
suggested.=20
To prevent brute-force attacks N should be big enough  like more 2^32 =
for=20
example. This number 2^32 is just an example and right now I don=E2=80=99t=
 know the=20
exact value. What I=E2=80=99m trying to say that address computation =
formula has=20
dependency on concrete predictable address. In my scheme even =
address_prev was=20
chose randomly.=20

Best regards,
Ilya

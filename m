Return-Path: <kernel-hardening-return-12076-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu7qh/Ju0YAzaZDy3swGF5GbNDl3UhzKhKJ4m52eRJFDKmh1Eln6bfLCl3kETvVNmzTY+2G
ARC-Seal: i=1; a=rsa-sha256; t=1520022649; cv=none;
        d=google.com; s=arc-20160816;
        b=uditdIymnhrPsnsabAw3mM7tgvT8hIwbCSmtEnZxPYlQ9Ohm7AvQS20ObkqHWAvl+d
         XCkKDq4tySf/dhflXzmqfl+04qPEPnroVesKRnAfAO3iN4/zUsvbsZgJGVCdaQsfeSw1
         NN5F6Jf0gOzbsDqd/yPq/69XLi+vKJvwAM3GuTGy/k+rv7DD5XdTIuTc6QYHQt27BusZ
         x5bK/PTYtxw7GY6ejOGJ4/Hd1QeaH1/opZgrtvAGa+ZwOwLJrg4mi08rn0MsK3uv67ek
         BAKRqVpcODZxKrO++IG6y1TULogbcyABg7yDZ7ZpFlW3PgJC5ZoSbIxHQpNDpi1EMrT2
         LBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=x8m3SniJ6Pmg92vMCrd/0AJzc+gCfc3kFfRvbq3UyGo=;
        b=EN6o84K/l4iPgBE4YWjCZElhxoUx4aQEm+EpkshN3HGZ+g5lt0Y2jrSvSDwjeBjcYF
         s0qS8WzYFd4P41TrFum9hvz52dH9Yt39CBcVTIS8jpxifk79XqPm5AOAZW7bQwBlZTr4
         JX7Owh00arG/RYXA04LerNzfGFXwmf6ec7r//0XwpFcgdaonpJYed0eB1rs9+12+dn28
         Xx6D+5rRo3AM4gOrWjSgt/KxEuZ8tzZAPTuSVzGGX/0GYfkcns+BOCTDZvYdrN/xo7+3
         m6wiau7o8PHhc5xdfA4Hv33L6xbydoRP8CELmnnBsdwkhqVSCsMAZKvYYe2W3mlVE/ah
         /2QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BBtYYwq0;
       spf=pass (google.com: domain of kernel-hardening-return-12076-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12076-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BBtYYwq0;
       spf=pass (google.com: domain of kernel-hardening-return-12076-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12076-gregkh=linuxfoundation.org@lists.openwall.com;
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
In-Reply-To: <20180228183349.GA16336@bombadil.infradead.org>
Date: Fri, 2 Mar 2018 23:30:28 +0300
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
Message-Id: <C9D0E3BA-3AB9-4F0E-BDA5-32378E440986@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593859269487385426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 28 Feb 2018, at 21:33, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Wed, Feb 28, 2018 at 08:13:00PM +0300, Ilya Smith wrote:
>>> It would be worth spelling out the "not recommended" bit some more
>>> too: this fragments the mmap space, which has some serious issues on
>>> smaller address spaces if you get into a situation where you cannot
>>> allocate a hole large enough between the other allocations.
>>>=20
>>=20
>> I=E2=80=99m agree, that's the point.
>=20
> Would it be worth randomising the address returned just ever so =
slightly?
> ie instead of allocating exactly the next address, put in a guard hole
> of (configurable, by default maybe) 1-15 pages?  Is that enough extra
> entropy to foil an interesting number of attacks, or do we need the =
full
> randomise-the-address-space approach in order to be useful?
>=20

This is a really good question. Lets think we choose address with =
random-length=20
guard hole. This length is limited by some configuration as you =
described. For=20
instance let it be 1MB. Now according to current implementation, we =
still may=20
fill this gap with small allocations with size less than 1MB. Attacker =
will=20
going to build attack base on this predictable behaviour - he jus need =
to spray=20
with 1 MB chunks (or less, with some expectation). This attack harder =
but not=20
impossible.

Now lets say we will increase this 1MB to 128MB. Attack is the same, =
successful=20
rate less and more regions needed. Now we increase this value to 48 bit =
entropy=20
and will get my patch (in some form ;))

I hope full randomise-the-address-space approach will work for a long =
time.

Thanks,
Ilya

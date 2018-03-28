Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522262905; cv=none;
        d=google.com; s=arc-20160816;
        b=MKXu7TGmqf/Qh+Lyjf9N7OiGMTy9YbeC8FfUirntf8O7pVxxAic+2H9GrnxA/WMsEe
         CFloeIvXtrbZ+05ArzCu5+iQBWF61AL7ZwPwirZGaW78JLLbi6nOFCZV4dkuilQcCM8m
         0VhQMGFAejfX79Pfb6u6S0v/eUab5UCsoJXVm7Z2J9iJN9DXtYlza7Oa9GtgG4pmshG1
         8iTOahYEFbRTY9X9prmMcMXYpbUTmf5zOWcIJ7WNJRZ0ytIJSy4WRBJmzFFmGVkOR3Df
         w/RgF7slc/lqwvws1ViY8wfxJhbOKIs04Kqam09onatVnBmxdX+IUE+QMcjGLFNkIYwr
         eDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=f+re0HW/85NsVu/LcchDagF2oAbLnTK285vXqWgR0wo=;
        b=f0WgZyOECzTcbacho8mb1qISgA0/RXMljqyfwvUoCyohUVYXtWmGtbg69/SoKbjWCM
         LPEQLlGuQR+ugtr6Vw0HPKzfPQTY7vbj/F8FrYWIxR4QwPpEUN3XzUqpU7hHrppxaT2M
         qNmVxtUvW2VkLXk4ZT6PjNDPOXdPi0UiRSdlIGf+CRyBnXa6kDY2teoprJfM3fXAVhW2
         boYatYPtz73AVALSIMlynwBGudplL7leQ3O0V2nU8/Ad0AYHoBI/EQdm3ZZlbIqFpMEO
         hnEMhqfEO/WzHrFvD+S+dU+EfvhOxFEbUP6hbVNnbaMtsVVCq2Kccc7/GmKBFRRKYRaL
         3NvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CD1wumWZ;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CD1wumWZ;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+dwqVh1nEI930koA5Dbyw10gOxThstZ0P3Ms8fC+CWW2blWEE7IBEbV7AOxZv1966jnFaIUg==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180327221635.GA3790@thunk.org>
Date: Wed, 28 Mar 2018 21:48:22 +0300
Cc: Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 rth@twiddle.net,
 ink@jurassic.park.msu.ru,
 mattst88@gmail.com,
 vgupta@synopsys.com,
 linux@armlinux.org.uk,
 tony.luck@intel.com,
 fenghua.yu@intel.com,
 ralf@linux-mips.org,
 jejb@parisc-linux.org,
 Helge Deller <deller@gmx.de>,
 benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au,
 schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com,
 ysato@users.sourceforge.jp,
 dalias@libc.org,
 davem@davemloft.net,
 tglx@linutronix.de,
 mingo@redhat.com,
 hpa@zytor.com,
 x86@kernel.org,
 nyc@holomorphy.com,
 viro@zeniv.linux.org.uk,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 deepa.kernel@gmail.com,
 Hugh Dickins <hughd@google.com>,
 kstewart@linuxfoundation.org,
 pombredanne@nexb.com,
 Andrew Morton <akpm@linux-foundation.org>,
 steve.capper@arm.com,
 punit.agrawal@arm.com,
 aneesh.kumar@linux.vnet.ibm.com,
 npiggin@gmail.com,
 Kees Cook <keescook@chromium.org>,
 bhsharma@redhat.com,
 riel@redhat.com,
 nitin.m.gupta@oracle.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jan Kara <jack@suse.cz>,
 ross.zwisler@linux.intel.com,
 Jerome Glisse <jglisse@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 linux-alpha@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 linux-snps-arc@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B217D90A-6200-4257-804A-50D6C0308470@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <20180327221635.GA3790@thunk.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596208347872056587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 28 Mar 2018, at 01:16, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Tue, Mar 27, 2018 at 04:51:08PM +0300, Ilya Smith wrote:
>>> /dev/[u]random is not sufficient?
>>=20
>> Using /dev/[u]random makes 3 syscalls - open, read, close. This is a =
performance
>> issue.
>=20
> You may want to take a look at the getrandom(2) system call, which is
> the recommended way getting secure random numbers from the kernel.
>=20
>>> Well, I am pretty sure userspace can implement proper free ranges
>>> tracking=E2=80=A6
>>=20
>> I think we need to know what libc developers will say on implementing =
ASLR in=20
>> user-mode. I am pretty sure they will say =E2=80=98nether=E2=80=99 or =
=E2=80=98some-day=E2=80=99. And problem=20
>> of ASLR will stay forever.
>=20
> Why can't you send patches to the libc developers?
>=20
> Regards,
>=20
> 						- Ted

I still believe the issue is on kernel side, not in library.

Best regards,
Ilya

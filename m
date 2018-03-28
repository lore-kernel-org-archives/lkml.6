Return-Path: <tony.luck@intel.com>
X-Google-Smtp-Source: AIpwx48Fg51z1gfysh4Fj3i47M6zqdUHMRNyxDME+XZ35hHnOG/z4Kh3w8ntWLAt8q8VKCM7UnQL
ARC-Seal: i=1; a=rsa-sha256; t=1522271252; cv=none;
        d=google.com; s=arc-20160816;
        b=Xfh/bGUAT+2kwugTShc5lxLcptoiHQiAzdYw2aYSkYZOMe4+3P9uoC6QFWEG1BvJZe
         7bH8HYuS/jNEpFZrvUhVtV4c0eaa4dCq03YbiajV19j2GgIkA1o70Xn9llE+80Lt0W26
         nih1Sp+o1t3jQCfgF/9O0uESNh1m4+X5qg7VOPXn4zuqXWBFilM4G0UgIfkRjHVURj8m
         gpN9lGfGanZtYqJzZbkHgOK80+IcdOb5XAt7kqEYXm+JNQwzMn7Ewer18+v4ckWJZVGI
         GaKWAkgOLzB5QkTBk+ry/cmTAB25sxx69uNjmF7j2AS2PKsO4eYvLoP8T33oq6WoyaCI
         i9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=dexk/TWoqvx5X0x+Q82JbeJivpFxXrRniCs3RygtDrg=;
        b=Ivc67NkXnd8f3/TD5YmM3+1p25k66A9OQe0tQChKvIR/efZO39SPiqE2dsuCSCf3Sa
         YaTd0tNfDuuGeC6C7ugyx31fdCdr1M2Z3X7QB+mvGxxPzRzInXUQ4CzBPe+82VvITK5A
         bJ3kfJoWJ0I2EXh4vHKxPWkDT1TGOVz9XoiYP0MMD3W1IkzrONUr7VljcOwG5NVE9l9V
         QfAnS78xtYJVG0zzeynPxrRu4ZZ/uhi0EF+tsjuya8l+jkOTY7V2aYeDaski5GBUguYt
         5UWXimMFmH7kJR7+vbPkx1QvC9FZQj+H4+oPNzabzymn4LxG23axUZuW+1wV3fU5Ty1p
         lqLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tony.luck@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=tony.luck@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tony.luck@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=tony.luck@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="212130243"
From: "Luck, Tony" <tony.luck@intel.com>
To: Rich Felker <dalias@libc.org>, Matthew Wilcox <willy@infradead.org>
CC: Kees Cook <keescook@chromium.org>, Ilya Smith <blackzert@gmail.com>,
	Michal Hocko <mhocko@kernel.org>, Richard Henderson <rth@twiddle.net>,
	"ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>, "mattst88@gmail.com"
	<mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King
	<linux@armlinux.org.uk>, "Yu, Fenghua" <fenghua.yu@intel.com>, Ralf Baechle
	<ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge
 Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, "Michael Ellerman" <mpe@ellerman.id.au>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens
	<heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
	"David S. Miller" <davem@davemloft.net>, "Thomas Gleixner"
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
	<hpa@zytor.com>, X86 ML <x86@kernel.org>, "nyc@holomorphy.com"
	<nyc@holomorphy.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann
	<arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Deepa Dinamani
	<deepa.kernel@gmail.com>, Hugh Dickins <hughd@google.com>, Kate Stewart
	<kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>, Steve Capper
	<steve.capper@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, Nick Piggin <npiggin@gmail.com>,
	Bhupesh Sharma <bhsharma@redhat.com>, Rik van Riel <riel@redhat.com>,
	"nitin.m.gupta@oracle.com" <nitin.m.gupta@oracle.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, Ross Zwisler
	<ross.zwisler@linux.intel.com>, Jerome Glisse <jglisse@redhat.com>, "Andrea
 Arcangeli" <aarcange@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>, "linux-ia64@vger.kernel.org"
	<linux-ia64@vger.kernel.org>, "linux-metag@vger.kernel.org"
	<linux-metag@vger.kernel.org>, Linux MIPS Mailing List
	<linux-mips@linux-mips.org>, linux-parisc <linux-parisc@vger.kernel.org>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>, linux-s390
	<linux-s390@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, sparclinux
	<sparclinux@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Thread-Topic: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Thread-Index: AQHTwfv/6OYZeJeUs0u250ucIkhOV6PeO8EAgABV+oCABB2cAIAAuAiAgADDTgCAAGwEAIAAl6SAgAAPawCAAAMsgIAA6zcw
Date: Wed, 28 Mar 2018 21:07:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
 <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
 <20180326084650.GC5652@dhcp22.suse.cz>
 <01A133F4-27DF-4AE2-80D6-B0368BF758CD@gmail.com>
 <20180327072432.GY5652@dhcp22.suse.cz>
 <0549F29C-12FC-4401-9E85-A430BC11DA78@gmail.com>
 <CAGXu5j+XXufprMaJ9GbHxD3mZ7iqUuu60-tTMC6wo2x1puYzMQ@mail.gmail.com>
 <20180327234904.GA27734@bombadil.infradead.org>
 <20180328000025.GM1436@brightrain.aerifal.cx>
In-Reply-To: <20180328000025.GM1436@brightrain.aerifal.cx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjkzNTdjYTQtNTkzMi00YjMwLTlmZDYtYTU2NThkMWMyMjM3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJlaHB6QnBNXC8xMlk2YWYyRGtPZVp6YjNkMm1ocGd0VEZ3dG5RWFZxWGxGTDlBYmNuSU5jZUdZTTVBZzZFUERCUCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596217101035568514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> The default limit of only 65536 VMAs will also quickly come into play
> if consecutive anon mmaps don't get merged. Of course this can be
> raised, but it has significant resource and performance (fork) costs.

Could the random mmap address chooser look for how many existing
VMAs have space before/after and the right attributes to merge with the
new one you want to create? If this is above some threshold (100?) then
pick one of them randomly and allocate the new address so that it will
merge from below/above with an existing one.

That should still give you a very high degree of randomness, but prevent
out of control numbers of VMAs from being created.

-Tony

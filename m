Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522714370; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWxCWQPXy0ofWl67vT1W59nsajgiJxWjK7Al2XuTxd0unS22RpPjJotdd+TKOrt8mc
         3Crv2v5RRHyqI3kK5hleLMorxQdiyzv28E0j156M2O7sH5nKbb0NuHzl4ZoedGf9KmXX
         GGr6HjV7CLdoeTQPjMf23IYPtyCmNaf6m2goiFvsB60ZsNs41T7fPEB8jGupxH2rkJ5s
         n0UuWQ2LO55Cead6v8GuRlFmpK1Ed6/+fgKk0iMKc4XaZDOH9LX76iqa62hNU3FLeYin
         rdVi87/jczT4wvojDQNdYPBJCjJ+IiF2tGXRkgyePvwJ4KU79ZtKehIhGbNxKG7RrOK+
         pbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=J1d8GZtrK4hY+JTjitzp/6IX1SAUit8cEPdA71kilVA=;
        b=F1U3AFRo/zrNR60RmxBfw9IeI7nDUgiSkMbUxMUqZuhfexFRajQUITjFD+iMX1Ogpw
         F2RH2a79odgJ3bCOxQnk7ujEiG3Ta3997n9IIMJ6Ta/jvTRFafJRLRKUHMwipG/C82V2
         aU1dKmjAC17pP5PpGL6YvTCkw6ib36MTWQ7cDPhAIKARwj+57LaAWEwT0poe6fDpCjFe
         a6n1X2cY0YxeUb/OPKfpZts1E9VYrl46G7KPk3TBIk7Juk2qraZsp9KZJwnPq1iwJbTh
         Bb4yJe27MbdKQT+7S+SH3iIepVdf1tNxtRwTVXnKEAzAmZPRMKgeLMiA+s2cEsJkQasX
         OTDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EuGazHaJ;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EuGazHaJ;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49ClP02AGgxiYwZoPDHz8HxKYxZ15sE72H7Zj1waosYFFtzDGDuzQQRgJhpA6TX5qvHmOQxOA==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
Date: Tue, 3 Apr 2018 03:11:50 +0300
Cc: Rich Felker <dalias@libc.org>,
 Matthew Wilcox <willy@infradead.org>,
 Kees Cook <keescook@chromium.org>,
 Michal Hocko <mhocko@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
 "mattst88@gmail.com" <mattst88@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 "Yu, Fenghua" <fenghua.yu@intel.com>,
 Ralf Baechle <ralf@linux-mips.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "David S. Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 X86 ML <x86@kernel.org>,
 "nyc@holomorphy.com" <nyc@holomorphy.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg KH <gregkh@linuxfoundation.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Hugh Dickins <hughd@google.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steve Capper <steve.capper@arm.com>,
 Punit Agrawal <punit.agrawal@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nick Piggin <npiggin@gmail.com>,
 Bhupesh Sharma <bhsharma@redhat.com>,
 Rik van Riel <riel@redhat.com>,
 "nitin.m.gupta@oracle.com" <nitin.m.gupta@oracle.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Jan Kara <jack@suse.cz>,
 Ross Zwisler <ross.zwisler@linux.intel.com>,
 Jerome Glisse <jglisse@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-parisc <linux-parisc@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-sh <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9173B50-39D6-4EE5-AF8B-3EB50D0C9A3B@gmail.com>
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
 <3908561D78D1C84285E8C5FCA982C28F7B3B8BC5@ORSMSX110.amr.corp.intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596681744210038058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On 29 Mar 2018, at 00:07, Luck, Tony <tony.luck@intel.com> wrote:
>=20
>> The default limit of only 65536 VMAs will also quickly come into play
>> if consecutive anon mmaps don't get merged. Of course this can be
>> raised, but it has significant resource and performance (fork) costs.
>=20
> Could the random mmap address chooser look for how many existing
> VMAs have space before/after and the right attributes to merge with =
the
> new one you want to create? If this is above some threshold (100?) =
then
> pick one of them randomly and allocate the new address so that it will
> merge from below/above with an existing one.
>=20
> That should still give you a very high degree of randomness, but =
prevent
> out of control numbers of VMAs from being created.

I think this wouldn=E2=80=99t work. For example these 100 allocation may =
happened on=20
process initialization. But when attacker come to the server all his=20
allocations would be made on the predictable offsets from each other. So =
in=20
result we did nothing just decrease performance of first 100 =
allocations. I=20
think I can make ioctl to turn off this randomization per process and it =
could=20
be used if needed. For example if application going to allocate big =
chunk or=20
make big memory pressure, etc.

Best regards,
Ilya

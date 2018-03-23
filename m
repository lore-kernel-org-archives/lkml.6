Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521827752; cv=none;
        d=google.com; s=arc-20160816;
        b=U6gFmjYKAYYBn4nMDqbvYGR43l/F/65lya4QhJewm5ZvSuPYk9ETd8et0plH7Y7XJJ
         s4wNBBFzMtM9nrx2K8q5rRNJ7h2IspTcwxPGupSSkzq4GZttRcOoeZKrCcVJptP5ZePG
         Eluzf4IZc/Vw+qQQEG3CRb8aq3oFW/7n4dKv3DJLOGtc9qSiYP7Fpvqyn9sI5XheTvAa
         DlR8VPLBeCWEs3CAgkjqKE219lIo83eEodE9glrxY06GjclWqdfVW2GfFsiv+ISnKjOP
         q8BOwkJmnx9wu95rl9JzZpY9k8v7iWPwRyvii73/FhKPepC/63paYUdqSuCCbqU0O3eq
         oAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=Nn/LegfdgCnPMfgxrP8ldElW5x41AbmrS9XnJZIcO0M=;
        b=LWmtTWdQvzW0UsuMc06qAAb6CHb3ELLCGt4KVK6jOtc64IXdwurw7Yflvhun1gtLu0
         DkvALCQM146HBUEeuMDIRlJti/vWewwFC1WiQU8TGM8jU1MTy68/PwDPs6mEc1x/JHBR
         sddD9zLV4AvSy8eaEbp1sUUTSAeKPOy9FCWmhW/R8XeavfOZJLuNz9sxmt2t8Ym1xSmV
         n0SswJP6iaAwm9X+sXDLTibVTX5+H5XASAvXlst1xJreZwJgZpkobEOY2iYdDESj38mI
         EIE+R9Zeo9JMIHiU+KksUDOlwTRk3be3QUTHAZwE/Yagyk3jaFot0t747axfxynGk/Mr
         nZGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dmuwuz6Z;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dmuwuz6Z;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvfGoHwG8ZFUTfHtGgnMEMhX5286YUod0rhOtxN+bKDVeOxka7156ZLffopag3GbBdCfb+X5Q==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180323124806.GA5624@bombadil.infradead.org>
Date: Fri, 23 Mar 2018 20:55:49 +0300
Cc: rth@twiddle.net,
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
 Michal Hocko <mhocko@suse.com>,
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
Message-Id: <651E0DB6-4507-4DA1-AD46-9C26ED9792A8@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180323124806.GA5624@bombadil.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595752056978107135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 23 Mar 2018, at 15:48, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Thu, Mar 22, 2018 at 07:36:36PM +0300, Ilya Smith wrote:
>> Current implementation doesn't randomize address returned by mmap.
>> All the entropy ends with choosing mmap_base_addr at the process
>> creation. After that mmap build very predictable layout of address
>> space. It allows to bypass ASLR in many cases. This patch make
>> randomization of address on any mmap call.
>=20
> Why should this be done in the kernel rather than libc?  libc is =
perfectly
> capable of specifying random numbers in the first argument of mmap.
Well, there is following reasons:
1. It should be done in any libc implementation, what is not possible =
IMO;
2. User mode is not that layer which should be responsible for choosing
random address or handling entropy;
3. Memory fragmentation is unpredictable in this case

Off course user mode could use random =E2=80=98hint=E2=80=99 address, =
but kernel may
discard this address if it is occupied for example and allocate just =
before
closest vma. So this solution doesn=E2=80=99t give that much security =
like=20
randomization address inside kernel.=

Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520618283; cv=none;
        d=google.com; s=arc-20160816;
        b=Vy/7umGPsLMv+o5tgb2Y6+nDA5pF+gDVMF7/LWLiy0zb6NbgZOO852YyRPwnDTJ78Q
         3RLk+WuwvUo6iiXxuKCJBms73h7yJ9AnrFtaeknuchO8Ok7pIkfSGjAH4NnSy7a84AhS
         2QooPL/DoKlzOQWTB+0FKMC/krgYS1pEpR/ZduhBrtZcTx3GbBVm/6eGB6/SXPzhbLCt
         cSW3v4XD3lHAbsKDo96B3+DjATMytyutjmdXQIrZVsHGwAg13cJe5OLxu3QyNqHENyFy
         DHJZWG8jDN8uFziLLYohIJ16/c86v+dRfwxPufml4hRyo3yGVyxY3QJc6xylNicd8095
         5CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ytr0eCyhrSlYJUx6v/73vhT/W9iKGUGXQ0WwWeu81/g=;
        b=qPA32wwml8MoVtsCGFimkBRXOzf0W1p0J0f8Qx9IyYSlqA75FM3vT3Zw2o7nQu0tIk
         JECp4zsW4u2BQA/Ei5k02BEGyBDKBXh9+X8uBfy8qbHRLgCf23LO6FJo88A1J8wjjp38
         vF+mDcBS+NThE1UziWPOhMhULQ1mbWLPIWH4qaVBy56G4QwlyM9cTg4OQuczJ8ji6vwR
         4Zohh2AoSxI4AUQw03yjHpDTu0cdlnGK6nnYvuXPxKuTbVyGCnGnZmnhDbF7wTLH8ymM
         wRfq2XFOCndc514rWNg5G4pVPHsVunpI3zBSIoH3Yz65j1rFOTByvMm+E2JkJDlPR0Km
         7+jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D2GjXNID;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=D2GjXNID;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvgTJdVcFaeY9AnGrjJ7mPCt2UE4Uf0AhCvOg7h8XSyfqbF72EQuYH+b2TxzabYJRj9chxt9TAS3pX3Yvgh2Pk=
MIME-Version: 1.0
In-Reply-To: <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
References: <cover.1520600533.git.andreyknvl@google.com> <963e112a-88a0-94bc-e6eb-0e9f9a6ee14a@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 9 Mar 2018 18:58:00 +0100
Message-ID: <CAAeHK+xTEp-jcMDxNK4kCKcNtVbu4s4VXxzThsKMMFaTdBv0RQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] arm64: untag user pointers passed to the kernel
To: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Shaohua Li <shli@fb.com>, Andrea Arcangeli <aarcange@redhat.com>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Shakeel Butt <shakeelb@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@techsingularity.net>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>,
	Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
	Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <jhogan@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>,
	David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	"James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
	Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	"David S . Miller" <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>,
	"the arch/x86 maintainers" <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net,
	linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
	linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
	linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
	openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594468997571598661?=
X-GMAIL-MSGID: =?utf-8?q?1594483837686119105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 3:15 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Andrey,
>
> On 09/03/18 14:01, Andrey Konovalov wrote:
>>
>> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
>> tags into the top byte of each pointer. Userspace programs (such as
>> HWASan, a memory debugging tool [1]) might use this feature and pass
>> tagged user pointers to the kernel through syscalls or other interfaces.
>
>
> If you propose changing the ABI, then
> Documentation/arm64/tagged-pointers.txt needs to reflect the new one, since
> passing nonzero tags via syscalls is currently explicitly forbidden.
>
> Robin.

Hi Robin!

I will include changes to Documentation/arm64/tagged-pointers.txt in
the next version.

Thanks!

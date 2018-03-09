Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520610444; cv=none;
        d=google.com; s=arc-20160816;
        b=GtZGAKtJ+qmjXNwFo7+CX5znrIRozuaTyngZTcd4p1LjpfHFMFgb9GsxrRX989RY16
         /Q/fs3RtVdUsoMej2gPI+mwbGvyUCs4qXbXRNvancbh191dS9HpsVzPhyGPsz7UFr7GT
         sasqtP7dTaKJ7fWhwVtJCrlN8yzqzE5We+ERXqLJEKYlqHVG3fL4GsCuXLDOmfQLnA+N
         0qyu2SvTd9NdW9CIuJ6gPpkGaRRSeBlJQnrA/5gXPnXmDPWtnh6mpNu+SKUcLa+JNai9
         c8Dkl2tAZPAQqiK90l4+bmlhC/Vbd195tSpgmseEjO7xE6U0kGsE5sP0cSb3JQLBXyyE
         Kgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jAAksnYYkMODsnsZbowE4/VFrct/KsJsppH3N6IgE5E=;
        b=esvicHM/okcy/t6hY2RG55gl0pOSCvAlB9KCy2FUWRj/UKZSeYV5yb6KU/uX5zCROa
         2sXvFG+g4ElBRnd42K5rZtZTBd2H4o85V1vXHgzkGunFE9iCLX10UKLN0Vum82r+BtK0
         e6A9W2gtOYkazbF0izOGN6lNPKMASRc0sWF1vA4vjyB8rvhAWewTAUXZbXj9wiJOSlSp
         ZCTLRDElkBCb9duDVM9KordgJCGPP/hCrKAs++ISDCL/NM/n3FDLI72fQwlA3lI+Gf+d
         m/gPEXtFHG6jb3hmqHgxQnU69DY3av7vMjS0Xfr5M1/L1kpSs2rxP/LVumC/aeTNzB+C
         aeLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UtibAzSD;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UtibAzSD;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELsF7lorhRvuFkmJ5gTFIQ+mijzHzzmqoCjPv2uK8Rd/dB8Y4qjhePOvFPSh69W8VA48c0fknemZtvTJgO2GVa4=
MIME-Version: 1.0
In-Reply-To: <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
References: <cover.1520600533.git.andreyknvl@google.com> <89b4bb181a0622d2c581699bb3814fc041078d04.1520600533.git.andreyknvl@google.com>
 <b320ff92-43ae-a479-35aa-4257b9c5430e@arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 9 Mar 2018 16:47:23 +0100
Message-ID: <CAAeHK+y=_imh4uNSAg_vj3DLAeDLcVP3a4f79dNMW=Ot5oLiZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] arch: add untagged_addr definition for other arches
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
X-GMAIL-THRID: =?utf-8?q?1594469014749264601?=
X-GMAIL-MSGID: =?utf-8?q?1594475617909790372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 3:16 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 09/03/18 14:02, Andrey Konovalov wrote:
>>
>> To allow arm64 syscalls accept tagged pointers from userspace, we must
>> untag them when they are passed to the kernel. Since untagging is done in
>> generic parts of the kernel (like the mm subsystem), the untagged_addr
>> macro should be defined for all architectures.
>
>
> Would it not suffice to have an "#ifndef untagged_addr..." fallback in
> linux/uaccess.h?
>

Hi Robin!

This approach is much better, I'll try it. This will also solve the
merge issues that Arnd mentioned.

Thanks!

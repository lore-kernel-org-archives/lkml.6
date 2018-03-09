Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520604130; cv=none;
        d=google.com; s=arc-20160816;
        b=mGkgzA2HFLLjcwRX91oGowg8klNztNssnZ+/WuZSl+13U8Gg7mnNASZSKENDr2q5bO
         R9DaBAKOrDEz34fsrFJK2fWoAI1NY6K19WJSxt1x0q1CgRrf5WQyo8lb5zLtsNV3t8dG
         Rg7t5xMEREssAES6LNfyEJwSbpPPZwiCwS7NbQZL51DA/asJtzz41tSMrJnJN3hxRhgg
         PZ43LlqRGdB/D18jBQwLxoENhFsC76tRVd8fOIIyBQBJMbOg4W2YA7OwjOcCOA2hh8UH
         HjB6cFm1TDHMUXC1b25+h7oCFsXKHAyVdBIkOiBhGO//AjCSamaKI4dAfYWfQDZ5bkiB
         0MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=gZz08brrhFST5FaV0viJBc0/5aRp7ApbKS2EC+x028M=;
        b=UYL5o2QiLUHc977dCiAz/9j1XXml0AG14Rx9IygLMp1WmytF5WGqlo8TLk8MFVqfu+
         mtZ1rWxOuLHM5sXeJ8rHreQfGSwdjpvLv1aurH/qVKcdnYHfj9f6X4LNYQcfsWzoBjuF
         fx3uphX6FSiAA5lOOFdqbWo6VXvv2JV5YsSzSZwA7rFJkFMueeC3kjjQ76+QKS4qQJK8
         KAxPTVJDje9eA9AD7/7s4jlPSLwfqrgh6ZJDdoq5IsL2mo/zUwLGE5XrHZWRW4jqSBbt
         zRHp17tcme767L/O2Yh5BLOH5zSiKVH0qTpE0YUkyq3g28uEkvd4yFedZkLxTDXnc7Hx
         DzMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rh2dOZ4z;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=rh2dOZ4z;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvYWNQoilyaclxWNdMvib+6V1UMTra7MHnmrEmL8NxvYg2eyj8JCEjSAb7r57tENLlLIGjJgQ==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Shaohua Li <shli@fb.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Shakeel Butt <shakeelb@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hugh Dickins <hughd@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@synopsys.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Salter <msalter@redhat.com>,
	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
	Mikael Starvik <starvik@axis.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Hogan <jhogan@kernel.org>,
	Michal Simek <monstr@monstr.eu>,
	Ralf Baechle <ralf@linux-mips.org>,
	David Howells <dhowells@redhat.com>,
	Ley Foon Tan <lftan@altera.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E . J . Bottomley" <jejb@parisc-linux.org>,
	Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@sifive.com>,
	Albert Ou <albert@sifive.com>,
	Chen Liqin <liqin.linux@gmail.com>,
	Lennox Wu <lennox.wu@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	"David S . Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	adi-buildroot-devel@lists.sourceforge.net,
	linux-c6x-dev@linux-c6x.org,
	linux-cris-kernel@axis.com,
	linux-ia64@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-metag@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-am33-list@redhat.com,
	nios2-dev@lists.rocketboards.org,
	openrisc@lists.librecores.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-xtensa@linux-xtensa.org,
	linux-arch@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [RFC PATCH 0/6] arm64: untag user pointers passed to the kernel
Date: Fri,  9 Mar 2018 15:01:58 +0100
Message-Id: <cover.1520600533.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594468997571598661?=
X-GMAIL-MSGID: =?utf-8?q?1594468997571598661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

arm64 has a feature called Top Byte Ignore, which allows to embed pointer
tags into the top byte of each pointer. Userspace programs (such as
HWASan, a memory debugging tool [1]) might use this feature and pass
tagged user pointers to the kernel through syscalls or other interfaces.

This patch makes a few of the kernel interfaces accept tagged user
pointers. The kernel is already able to handle user faults with tagged
pointers and has the untagged_addr macro, which this patchset reuses.

We're not trying to cover all possible ways the kernel accepts user
pointers in one patchset, so this one should be considered as a start.
It would be nice to learn about the interfaces that I missed though.

Sending this as an RFC, as I'm not sure if this should be committed as is,
and would like to receive some feedback.

Thanks!

[1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

Andrey Konovalov (6):
  arm64: add type casts to untagged_addr macro
  arm64: untag user addresses in copy_from_user and others
  mm, arm64: untag user addresses in memory syscalls
  mm, arm64: untag user addresses in mm/gup.c
  lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
  arch: add untagged_addr definition for other arches

 arch/alpha/include/asm/uaccess.h      |  2 ++
 arch/arc/include/asm/uaccess.h        |  1 +
 arch/arm/include/asm/uaccess.h        |  2 ++
 arch/arm64/include/asm/uaccess.h      |  9 +++++++--
 arch/blackfin/include/asm/uaccess.h   |  2 ++
 arch/c6x/include/asm/uaccess.h        |  2 ++
 arch/cris/include/asm/uaccess.h       |  2 ++
 arch/frv/include/asm/uaccess.h        |  2 ++
 arch/ia64/include/asm/uaccess.h       |  2 ++
 arch/m32r/include/asm/uaccess.h       |  2 ++
 arch/m68k/include/asm/uaccess.h       |  2 ++
 arch/metag/include/asm/uaccess.h      |  2 ++
 arch/microblaze/include/asm/uaccess.h |  2 ++
 arch/mips/include/asm/uaccess.h       |  2 ++
 arch/mn10300/include/asm/uaccess.h    |  2 ++
 arch/nios2/include/asm/uaccess.h      |  2 ++
 arch/openrisc/include/asm/uaccess.h   |  2 ++
 arch/parisc/include/asm/uaccess.h     |  2 ++
 arch/powerpc/include/asm/uaccess.h    |  2 ++
 arch/riscv/include/asm/uaccess.h      |  2 ++
 arch/score/include/asm/uaccess.h      |  2 ++
 arch/sh/include/asm/uaccess.h         |  2 ++
 arch/sparc/include/asm/uaccess.h      |  2 ++
 arch/tile/include/asm/uaccess.h       |  2 ++
 arch/x86/include/asm/uaccess.h        |  2 ++
 arch/xtensa/include/asm/uaccess.h     |  2 ++
 include/asm-generic/uaccess.h         |  2 ++
 lib/strncpy_from_user.c               |  2 ++
 lib/strnlen_user.c                    |  2 ++
 mm/gup.c                              | 12 ++++++++++++
 mm/madvise.c                          |  2 ++
 mm/mempolicy.c                        |  6 ++++++
 mm/mincore.c                          |  2 ++
 mm/mlock.c                            |  5 +++++
 mm/mmap.c                             |  9 +++++++++
 mm/mprotect.c                         |  2 ++
 mm/mremap.c                           |  2 ++
 mm/msync.c                            |  3 +++
 38 files changed, 105 insertions(+), 2 deletions(-)

-- 
2.16.2.395.g2e18187dfd-goog

Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521736611; cv=none;
        d=google.com; s=arc-20160816;
        b=QC/XaXOfWG0A6UCgFIJG7CNUtpyQa9j0tI7pDRY5i49TUpSHrSqfGUrqkkdeTmY4+n
         oRxY9IF4LC1KQasnmylD1knd6kqilAPiWT5PgMKLe6LvLsfg3PBvpJ8TRL+m39GYDyas
         XNPxnVvn+uW6WP35C1XF7MBjobk90x0WnTWlf4CR1oc8V2wPPwW3l0pzlp2Bc3KfU8TG
         uzNDZjN4CU7RJ2RcKq6XwgeRRYISBeok9IO8cweQhFOgXkg9oMXFE3p9QnM7TFrQeW7o
         /0YlQwVIvkncnoutkr5w4mVhGOmzvoAWINy1hNmUacfkJXgV2wJsMUein5oUg2vrqG52
         9EyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=m//DR2IjF14kxMb8hIASlsdQZeTM3Tfl8MGXfPzFsvc=;
        b=tWbxIIGkHHBhUjH3iVCCC6uYeTgIAmWpMj8DDoXjMxXBrg2CNmniffDptlJplGt+Ak
         TcG5R0ijKHRfvciJYtdGr9gVzwJUpRc1rpznGtVX55wcJNHDfzNzluoIekpVpe9Nb+AB
         jf83C6DR7AMzkj1JaXLiBcbVt/pZcPxOUyaXjWezSZcYAIuoXFpx2eZZcGLUczC9Q2kd
         afNHGq9QzMr44YoE57HeTMu1qWZEBwlFgi5aJPN+xL/R7oticSdT+NiUYgZtIGawM9Cb
         VvDOzBb77Ev4lctYfI0ZsvC3QiF0h1bBlxt25MFEYWZAqRCMESWdjxaLRy8UWToWnLZk
         U3eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fk1+89zN;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fk1+89zN;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsmRYer/1Dep+M8qraEhBnVwgO3tJHW3WpPA6ME2Bcsmp3ICIBTSnPz1wU4NkkLmvFAEzStCQ==
From: Ilya Smith <blackzert@gmail.com>
To: rth@twiddle.net,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	vgupta@synopsys.com,
	linux@armlinux.org.uk,
	tony.luck@intel.com,
	fenghua.yu@intel.com,
	jhogan@kernel.org,
	ralf@linux-mips.org,
	jejb@parisc-linux.org,
	deller@gmx.de,
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
	blackzert@gmail.com,
	gregkh@linuxfoundation.org,
	deepa.kernel@gmail.com,
	mhocko@suse.com,
	hughd@google.com,
	kstewart@linuxfoundation.org,
	pombredanne@nexb.com,
	akpm@linux-foundation.org,
	steve.capper@arm.com,
	punit.agrawal@arm.com,
	paul.burton@mips.com,
	aneesh.kumar@linux.vnet.ibm.com,
	npiggin@gmail.com,
	keescook@chromium.org,
	bhsharma@redhat.com,
	riel@redhat.com,
	nitin.m.gupta@oracle.com,
	kirill.shutemov@linux.intel.com,
	dan.j.williams@intel.com,
	jack@suse.cz,
	ross.zwisler@linux.intel.com,
	jglisse@redhat.com,
	willy@infradead.org,
	aarcange@redhat.com,
	oleg@redhat.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ia64@vger.kernel.org,
	linux-metag@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
Date: Thu, 22 Mar 2018 19:36:36 +0300
Message-Id: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1595656488556903336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current implementation doesn't randomize address returned by mmap.
All the entropy ends with choosing mmap_base_addr at the process
creation. After that mmap build very predictable layout of address
space. It allows to bypass ASLR in many cases. This patch make
randomization of address on any mmap call.

---
v2: Changed the way how gap was chosen. Now we don't get all possible
gaps. Random address generated and used as a tree walking direction.
Tree walked with backtracking till suitable gap will be found.
When the gap was found, address randomly shifted from next vma start.

The vm_unmapped_area_info structure was extended with new field random_shift
what might be used to set arch-depended limit on shift to next vma start.
In case of x86-64 architecture this shift is 256 pages for 32 bit applications
and 0x1000000 pages for 64 bit.

To get the entropy pseudo-random is used. This is because on Intel x86-64
processors instruction RDRAND works very slow if buffer is consumed -
after about 10000 iterations.

This feature could be enabled by setting randomize_va_space with 4.

---
Performance:
After applying this patch single mmap took about 7% longer according to
following test:

    before = rdtsc();
    addr = mmap(0, SIZE, PROT_READ | PROT_WRITE, 
                 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
    after = rdtsc();
    diff = after - before;
    munmap(addr, SIZE)
    ...
    unsigned long long total = 0;
    for(int i = 0; i < count; ++i) {
        total += one_iteration();
    }
    printf("%lld\n", total);

Time is consumed by div instruction in computation of the address.

make kernel:
echo 2 > /proc/sys/kernel/randomize_va_space 
make mrproper && make defconfig && time make 
real    11m9.925s
user    10m17.829s
sys 1m4.969s

echo 4 > /proc/sys/kernel/randomize_va_space 
make mrproper && make defconfig && time make 
real    11m12.806s
user    10m18.305s
sys 1m4.281s


Ilya Smith (2):
  Randomization of address chosen by mmap.
  Architecture defined limit on memory region random shift.

 arch/alpha/kernel/osf_sys.c         |   1 +
 arch/arc/mm/mmap.c                  |   1 +
 arch/arm/mm/mmap.c                  |   2 +
 arch/frv/mm/elf-fdpic.c             |   1 +
 arch/ia64/kernel/sys_ia64.c         |   1 +
 arch/ia64/mm/hugetlbpage.c          |   1 +
 arch/metag/mm/hugetlbpage.c         |   1 +
 arch/mips/mm/mmap.c                 |   1 +
 arch/parisc/kernel/sys_parisc.c     |   2 +
 arch/powerpc/mm/hugetlbpage-radix.c |   1 +
 arch/powerpc/mm/mmap.c              |   2 +
 arch/powerpc/mm/slice.c             |   2 +
 arch/s390/mm/mmap.c                 |   2 +
 arch/sh/mm/mmap.c                   |   2 +
 arch/sparc/kernel/sys_sparc_32.c    |   1 +
 arch/sparc/kernel/sys_sparc_64.c    |   2 +
 arch/sparc/mm/hugetlbpage.c         |   2 +
 arch/tile/mm/hugetlbpage.c          |   2 +
 arch/x86/kernel/sys_x86_64.c        |   4 +
 arch/x86/mm/hugetlbpage.c           |   4 +
 fs/hugetlbfs/inode.c                |   1 +
 include/linux/mm.h                  |  17 ++--
 mm/mmap.c                           | 165 ++++++++++++++++++++++++++++++++++++
 23 files changed, 213 insertions(+), 5 deletions(-)

-- 
2.7.4

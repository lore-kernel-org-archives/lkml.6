Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520604137; cv=none;
        d=google.com; s=arc-20160816;
        b=tTwKuJqh6FZyBmw+zyR+QpqKq/8Sda32xcS7OznGBhsvSr+swhiJp+5U6XlUdq6n8E
         YvpXCb7kPYgHhHpFq0IbpdfsG/gYmMcm7jyyctJlimsGks95Gr6SyO7qWJgG24iPCmTL
         QSDk2AkWefljYdwTFScGvH3fHA0nCdoDiZqWefg/mYZOSTzQXwBJ4EJ4VA6Dcjy2tdFV
         aVA6nl8T2qrbLtnR9S0/YhFZgjHAG+pGeYFYA97/6838hniETcuieHV2uhRLhDtb/hCE
         2aKhLSCdxkDQTjhNYwqD+37G+Z1ta8Ugpq9eE8EGgN4clqfq0K36+2gPVpVlGaCDa2ng
         4JLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KVsaoUpOD8Si69HtIZnikRY9QoHsK3D77i4tLJbKAhI=;
        b=JVhjvth6vdBYPQKsSFVfLP5lQhdyuYCFA+ov3m3w6q4C+1frB3KdoPCn1sCpxSWVcV
         3UUwcDlt75AKODxBUoGzvr4ordP7zR9z2gdDbeTajOe0/r6eGVZgNodgrbkRWqlAr28k
         xsKv2dcSGktYACDJWvK0Bn0cPf/kkyriQUpGKSy+WqWT2IwQo3QWwEa79uK8qNZgV0it
         QXgJGt5gMHLJ9AH4DYpJMxgdoZk1v5fqqf+iA6NfdWPh55SO2fG3pTLCeI4vs3NzAnBr
         JdrDHov4EmKUlOKm5pa0YVjCp+0D22gkO9rDsPBWCekM2LsR0CV8x1Dk/ZqYcOfiHt1G
         bI/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aDu8Cfeu;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aDu8Cfeu;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELs2VGB0w/R+8AMN4YxVgPH/BwbGSNE+qDws91MY8GmIgNN/Kw09V1wCr4nFk/gnrhzyj8p//A==
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
Subject: [RFC PATCH 2/6] arm64: untag user addresses in copy_from_user and others
Date: Fri,  9 Mar 2018 15:02:00 +0100
Message-Id: <d681c0dee907ee5cc55d313e2f843237c6087bf0.1520600533.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594469003637770776?=
X-GMAIL-MSGID: =?utf-8?q?1594469003637770776?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 2d6451cbaa86..24a221678fe3 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -105,7 +105,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 #define untagged_addr(addr)		\
 	((__typeof__(addr))sign_extend64((__u64)(addr), 55))
 
-#define access_ok(type, addr, size)	__range_ok(addr, size)
+#define access_ok(type, addr, size)	\
+	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -238,12 +239,15 @@ static inline void uaccess_enable_not_uao(void)
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
  * current addr_limit.
+ * Also untag user pointers that have the top byte tag set.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 {
 	void __user *safe_ptr;
 
+	ptr = untagged_addr(ptr);
+
 	asm volatile(
 	"	bics	xzr, %1, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
-- 
2.16.2.395.g2e18187dfd-goog

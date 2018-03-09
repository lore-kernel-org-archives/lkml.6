Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520604144; cv=none;
        d=google.com; s=arc-20160816;
        b=DrV2oVTb+qTJfYqY0nI+237VciSxntfwiWQK9Gbi1rLE7h/E1HC69WjwJ8exavFNth
         Fq1VVKrN1Z1kZCcXuB+Hhw0QWbQmnZI0RBTLkvRH48f40bjTGnNFbQ/bjjd0/JXOcl/o
         ncmzQ/eD/hwaeGiUa64pptIERufHCs4Ci6TV636v1mLgQ1mKruh+27XPMRqJZbQWxd5d
         tzaV3D8D1u0TqeR9q0CspplldHOhveR0JP4v34G75Dwk1Gi7HjDf0bjJ84/kKmWYCBSK
         ysK6jYvzQmT12+X437P6gN8+xlXzq8xmn+IKHyJKwZYHnUx6RX3ldMdAVXdZ/siUDCVn
         NDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2cZZ6id+x0/wo2ATzm8/IeoYF4xqs5KCdHuahlIxLDo=;
        b=brzNpQTVhr/MKaCLZJ+W+AZsZJnpnWiVK7fubb5bNkQS9ur8Ht+dFIzXekDPDR4qqx
         vn1JDBiMRvULo9H9mbgc3/PwedY8c/fjy/uF9bH1dSzUhcJiCsvle7sBqY86udrPp5og
         WLYLFcnKhcjNeIhsmksibNAkEQiPzf7P9h+iQM73k8pXYAOufwfoAPo4jhmET+aiYNav
         Xg0k2+a7Q4T9TpTLD06Ze6jiGzDwjpIMbqOpx1HwDLD26XXAaw9lVUgXcfwO22q8FRk2
         wcrtFCrTy6/rXdmImV3sn/XsYBSpASkyhP3dEJNYsDuwraoMz78w0H/jNiIDbdVLe6bm
         5NUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=n28I0cW2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=n28I0cW2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvbn6srqv+rO92C9ogiihmsYkHDHVrSlz9idaCoHMrpLnomGUssQTnZ+zDlRwUeFPhJ0hlfTQ==
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
Subject: [RFC PATCH 5/6] lib, arm64: untag addrs passed to strncpy_from_user and strnlen_user
Date: Fri,  9 Mar 2018 15:02:03 +0100
Message-Id: <c515f67a6d94b2cfcac156bca0b9471203389d79.1520600533.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
In-Reply-To: <cover.1520600533.git.andreyknvl@google.com>
References: <cover.1520600533.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594469011516997845?=
X-GMAIL-MSGID: =?utf-8?q?1594469011516997845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to separately handle the case of tagged user addresses as well.

Untag user pointers passed to these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 2 ++
 lib/strnlen_user.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index b53e1b5d80f4..97467cd2bc59 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -106,6 +106,8 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	src = untagged_addr(src);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)src;
 	if (likely(src_addr < max_addr)) {
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 60d0bbda8f5e..8b5f56466e00 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -108,6 +108,8 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
+	str = untagged_addr(str);
+
 	max_addr = user_addr_max();
 	src_addr = (unsigned long)str;
 	if (likely(src_addr < max_addr)) {
-- 
2.16.2.395.g2e18187dfd-goog

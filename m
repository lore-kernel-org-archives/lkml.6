Return-Path: <lizhijian@cn.fujitsu.com>
X-Google-Smtp-Source: AB8JxZoRsnF6EmkNjYNsJofK7aESmjCplbbvNH94UIeQDt+zJZ+WiYfSAbsgC09MI7W1Li6LmkLj
ARC-Seal: i=1; a=rsa-sha256; t=1525770888; cv=none;
        d=google.com; s=arc-20160816;
        b=DA4wEH5lAMN+ErAP/tvkIY1Wkmq+5RRsuGUOUz6Ui/d9JH+OxweTrgCApTXjKS9UcE
         dDgMtpE+N2Ul8V3mMBmYI2BBHLvUU/BQgvZUbkCryp8BhNbOZyhlyK/cIZVcXj7e3WTV
         33PJ627VCLezq2hErNCTGwNncqDyftPK3ESPMw99kMnSvmAdY9Ocf0ByBpc8XUsBvMLS
         lIXzF/SeQXS/E0xJwvunTMqpGPK8m7tZ4B1ue8O3MtczO98gd6kgIcZBo3/1aQQqvYME
         OR5WK0i5w7FT6wp1puRFQElZ9WJd9Ls+1XFyBYyTZVt6Mq8/0bkmMXkyKn5tV/bRE/ZE
         ZF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=brFEqMnuExf2/K+8+4n1S/+f7oHwKdXMvaNs2mE3RAE=;
        b=ng4JZVx9rGhlu6hk6b2cxaFqFlgV6f4h6N1o0oDPdnAdiqpqGDMNuH53qgItZ7gB0S
         QrU66KJDElwtCwairxH6IEOHyrXZFc8uHytnZAP2yjIk70D82YSYRXZWK4dw6VEOSo1l
         PpEUpiLlMOi2aR4FQXL0HaHL8KVDIth4IH1m0/MagqQG7YDrpM+bgiKxfvWHaevyeMDu
         8ao+kv+aekR6o399yAtCKmjj9xE23/TKdglJdNchjsyVHLMtwqtPhgZJFtt8cMDJfs5/
         7o70158aRRIFXUsndZrWKuPIr4hRVgC8q4Wvk5yZYYTDZzEA8v1+QA6wX7snSPlMhmYX
         ZETQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of lizhijian@cn.fujitsu.com designates 183.91.158.132 as permitted sender) smtp.mailfrom=lizhijian@cn.fujitsu.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of lizhijian@cn.fujitsu.com designates 183.91.158.132 as permitted sender) smtp.mailfrom=lizhijian@cn.fujitsu.com
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="39685156"
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <mingo@kernel.org>, <tglx@linutronix.de>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <ebiederm@xmission.com>, <luto@kernel.org>,
	<dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<philip.li@intel.com>, <leist.fnst@cn.fujitsu.com>, <zhijianx.li@intel.com>,
	Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 2/2] tools/testing/selftests/x86: fix error: conflicting types for 'pkey_get|pkey_set'
Date: Tue, 8 May 2018 17:14:30 +0800
Message-ID: <1525770870-19067-2-git-send-email-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: C6B9D472400A.A13C3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734480796496?=
X-GMAIL-MSGID: =?utf-8?q?1599886734480796496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

pkey_get() and pkey_set() are implemented since glibc-2.27, here just
rename pkey_get|pkey_set to _pkey_get|_pkey_set simply

the compiling errors are like:
------------
protection_keys.c:399:5: error: conflicting types for 'pkey_get'
 u32 pkey_get(int pkey, unsigned long flags)
     ^
In file included from /usr/include/bits/mman-linux.h:115:0,
                 from /usr/include/bits/mman.h:45,
                 from /usr/include/sys/mman.h:41,
                 from protection_keys.c:37:
/usr/include/bits/mman-shared.h:64:5: note: previous declaration of 'pkey_get' was here
 int pkey_get (int __key) __THROW;
     ^
protection_keys.c:421:5: error: conflicting types for 'pkey_set'
 int pkey_set(int pkey, unsigned long rights, unsigned long flags)
     ^
In file included from /usr/include/bits/mman-linux.h:115:0,
                 from /usr/include/bits/mman.h:45,
                 from /usr/include/sys/mman.h:41,
                 from protection_keys.c:37:
/usr/include/bits/mman-shared.h:60:5: note: previous declaration of 'pkey_set' was here
 int pkey_set (int __key, unsigned int __access_rights) __THROW;
     ^
------------

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 tools/testing/selftests/x86/protection_keys.c | 32 +++++++++++++++------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 757bb16..ccbd81f 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -397,10 +397,14 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-#define PKEY_DISABLE_ACCESS    0x1
-#define PKEY_DISABLE_WRITE     0x2
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS    0x1
+#endif
+#ifndef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE     0x2
+#endif
 
-u32 pkey_get(int pkey, unsigned long flags)
+u32 _pkey_get(int pkey, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
 	u32 pkru = __rdpkru();
@@ -422,7 +426,7 @@ u32 pkey_get(int pkey, unsigned long flags)
 	return masked_pkru;
 }
 
-int pkey_set(int pkey, unsigned long rights, unsigned long flags)
+int _pkey_set(int pkey, unsigned long rights, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
 	u32 old_pkru = __rdpkru();
@@ -456,15 +460,15 @@ void pkey_disable_set(int pkey, int flags)
 		pkey, flags);
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
+	pkey_rights = _pkey_get(pkey, syscall_flags);
 
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	dprintf1("%s(%d) _pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
 	pkey_rights |= flags;
 
-	ret = pkey_set(pkey, pkey_rights, syscall_flags);
+	ret = _pkey_set(pkey, pkey_rights, syscall_flags);
 	assert(!ret);
 	/*pkru and flags have the same format */
 	shadow_pkru |= flags << (pkey * 2);
@@ -472,8 +476,8 @@ void pkey_disable_set(int pkey, int flags)
 
 	pkey_assert(ret >= 0);
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	pkey_rights = _pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) _pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
 	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
@@ -487,24 +491,24 @@ void pkey_disable_clear(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
-	int pkey_rights = pkey_get(pkey, syscall_flags);
+	int pkey_rights = _pkey_get(pkey, syscall_flags);
 	u32 orig_pkru = rdpkru();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	dprintf1("%s(%d) _pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
 	pkey_rights |= flags;
 
-	ret = pkey_set(pkey, pkey_rights, 0);
+	ret = _pkey_set(pkey, pkey_rights, 0);
 	/* pkru and flags have the same format */
 	shadow_pkru &= ~(flags << (pkey * 2));
 	pkey_assert(ret >= 0);
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	pkey_rights = _pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) _pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
 	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
-- 
2.7.4

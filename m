Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELscaS8iDyB5M8068P493xnJbWy2RgaDDWKVvaDOrvEMBY/nJjR25WLGjRyrugA7T10jxFX7
ARC-Seal: i=1; a=rsa-sha256; t=1520295977; cv=none;
        d=google.com; s=arc-20160816;
        b=lOf3NzZE4ezif2z1sgm9qBKaU/97y3MUa4algRnQOaK680mYXSXoYW1sUk7CTWNDbx
         K7qaRhKiFG1J1nLYV1HaR0za2qXl33SlYd1Q0Cie+bMXEyqMQJQl8mQWB/VRiYt9Uz8w
         pZLlG/FgPu3KXnfOUMw77MZsiBSnavVX58wQJILl7n4J0WXDSmUypYLoklIRa3D1EU/4
         mZVm6xPX1yK5PZq/8qHUmEYrWjsZvoHMuK9PwbzQYzctHLmnvWsWjelSjxysqq+1ltf3
         fenna2WROiG/HKluzsbZv2xq7PsHsVDukt5nLvNzTg8H8bHpA9GnTN2qL8nN7H7Am9nl
         C4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=NnoxVu0rYiqiDvjwEt6ao/PM8XzFNUz5pLfQ1GinYCw=;
        b=gDFyO1pF9TR/bc96NY+VpaLM3SstQOCKnyEUH6W/C2NzIEszqK8hpq3PiII5Yte/F4
         O5yczark5oQ6OYo5elDtXaVv3zVQAG5WcLv/wojeiq4U5BP4JPXEj9MKjEhHa8lvgoyL
         Z4goT99nZTcP83qX4tewm2V9NjYSRxGlOG3ktppTGhuN7cxnOhtMY5cBvrKXcy6KwjTu
         gqnBge95gC7aXUByKolKaC2XXZu60eRrurOpNGr43yRXcj+7HNopOO/y4Vydw6cYLSDh
         OwVLeadiRlLlQXZO+DlmbunaXU1wTRW93BB7cntxM8vExQTZk2+hGD96tlYHB1JbbodI
         I4Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ghz8Gs/o;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ghz8Gs/o;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 19/65] x86/mm: Add the 'nopcid' boot option to turn off PCID
Date: Mon,  5 Mar 2018 19:24:52 -0500
Message-Id: <20180306002538.1761-20-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145875041863992?=
X-GMAIL-MSGID: =?utf-8?q?1594145875041863992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 0790c9aad84901ca1bdc14746175549c8b5da215 upstream.

The parameter is only present on x86_64 systems to save a few bytes,
as PCID is always disabled on x86_32.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/8bbb2e65bcd249a5f18bfb8128b4689f08ac2b60.1498751203.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

(cherry picked from commit dcccd3c266e24ce80ecf592765315c54c222ac33)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 Documentation/kernel-parameters.txt |  2 ++
 arch/x86/kernel/cpu/common.c        | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index ceaab09a279e..97bc24101896 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2471,6 +2471,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
 
+	nopcid		[X86-64] Disable the PCID cpu feature.
+
 	norandmaps	Don't use address space randomization.  Equivalent to
 			echo 0 > /proc/sys/kernel/randomize_va_space
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 90ef802d9d90..843be1de5ddb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -172,6 +172,24 @@ static int __init x86_xsaves_setup(char *s)
 }
 __setup("noxsaves", x86_xsaves_setup);
 
+#ifdef CONFIG_X86_64
+static int __init x86_pcid_setup(char *s)
+{
+	/* require an exact match without trailing characters */
+	if (strlen(s))
+		return 0;
+
+	/* do not emit a message if the feature is not present */
+	if (!boot_cpu_has(X86_FEATURE_PCID))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_PCID);
+	pr_info("nopcid: PCID feature disabled\n");
+	return 1;
+}
+__setup("nopcid", x86_pcid_setup);
+#endif
+
 static int __init x86_noinvpcid_setup(char *s)
 {
 	/* noinvpcid doesn't accept parameters */
-- 
2.16.2

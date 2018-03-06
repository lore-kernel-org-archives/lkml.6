Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvIGwvdMsCLD+CiU+yIXcr74h2fIRPpx2rlfD2oBaJP9C4K2W2zvj4KfenKR8g+vIjL4ehG
ARC-Seal: i=1; a=rsa-sha256; t=1520295963; cv=none;
        d=google.com; s=arc-20160816;
        b=oACsO+9lo0kNP4BHV7uucgJrQ36Vz2JmuQyOpp94aq4dGgZU4yT1I2eG1efc3FDtXy
         w2isXE0LEu52lJUtO+jq0r1I4Y69nnVgzMQFNrSDGBw8aXXnDRI6cKDQr+OtMUFcMXTV
         mcSm8T8xSdR+DetUAU9ETxfParKIq8g1aS1yLePp50ZzmCktY1i2Psrtx0T9p60f6Wlb
         iW5L2mXaZvOL4ZVcwsB5krHyf5nN6YVCMGHZtCYp8yqxl3QR5gmuEQqx1/Zh+0xv89aY
         yWaSva5HawvP5hmnXGw+wI9n3ME5LUj/k3hL6PD9jNvLn6c1WeUKQhAN827R0SKHX38G
         xGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=krsfNYm6vYIxaNB1EHHnoyEBIDUic98SoKn6cn6o8MI=;
        b=cDOw2K6jCdPyhMtZB6zieeedw6dobsrWJD8ibFPK5945g2QIV8uAs/JWsqNw7U06Er
         pL5L5Hv5EYD+GcqZ2IpjruGY/atOky7sZtFIuxWiWWQs2wqoe+WC0Du+vXw5DXNFDmBO
         5SGeLJQYJJT5hBpGG0JiZtvnw6UCvNlk34e5z1lqch6HY7A3xc8Cd2gENXXiXogOe9vr
         DVi1SlaAm6tXygMQDytYHiq+G9yEttbYyuxvgJwweBWejFEP9tRZP9vrz9aAD67pFTGC
         NA/J+T2bo3UVcemsob9aTcFyF3FjRXKd5ZRRSaw2jspaUcivypDgzDT5AbULuO1wyIHq
         mW0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sqJUyNZI;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sqJUyNZI;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 05/65] mm/mmu_context, sched/core: Fix mmu_context.h assumption
Date: Mon,  5 Mar 2018 19:24:38 -0500
Message-Id: <20180306002538.1761-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=901
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145860290148766?=
X-GMAIL-MSGID: =?utf-8?q?1594145860290148766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ingo Molnar <mingo@kernel.org>

commit 8efd755ac2fe262d4c8d5c9bbe054bb67dae93da upstream.

Some architectures (such as Alpha) rely on include/linux/sched.h definitions
in their mmu_context.h files.

So include sched.h before mmu_context.h.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit dfe513a4e8ddde75ffc6abd3f139c5d65bf925d7)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/mmu_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index f802c2d216a7..6f4d27c5bb32 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -4,9 +4,9 @@
  */
 
 #include <linux/mm.h>
+#include <linux/sched.h>
 #include <linux/mmu_context.h>
 #include <linux/export.h>
-#include <linux/sched.h>
 
 #include <asm/mmu_context.h>
 
-- 
2.16.2

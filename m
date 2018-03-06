Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsE91F8W2XRHfJ1MQEICmpnVlMte9lqH7JO5rX0Oqj2zokgrdc05QdUR0i2jBkT7g7jNGVa
ARC-Seal: i=1; a=rsa-sha256; t=1520295992; cv=none;
        d=google.com; s=arc-20160816;
        b=kQ6xrFySHDc/OAiws640J8KsyUNNlMDUt7sJmPHEZt9OD61/V+xMzqQkSzWD2pv6KW
         Y5r2uGyuzaeyeNL6tD6SeLkMVjo7FpeDPrhAENN2c3Ov6Tk51sXLnhDcsemeMpR7cKoy
         VVblsG1pNCO3A+UOEf2fOUif1bT90OAva0M0aaPI60LrxqSig5tGRbqswrclFDpjhr4m
         AHiA4YKIoN7ySyU9eYTRbEcKDAMoMTeEIuQV0epcm0Bv0qWlqMbciRXMd0Gr4tAiZ9Dz
         eLr4m4EjWFMuPOHpmF6oKPLRLIqHpfZT+41AUJe1OWjvCTaRUanBRG/Ensg2vV6fqTjU
         Q77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=ThHOEZY7L4BENk/u11Bd9oEiSXYHFF3hH369H5ivfRE=;
        b=cRZvTIv4q5I7Hxo6HG8sjPlKgd2+glWF1UEymnNNzQuVoa8f3rSEiYrSQ0RXW6vKTy
         jicOxVoR9KBvjLf/Vd0b0C9xAZXGQcQslJ3Z4orkzH9wQfa6wdA3V6+Q9mF0/4PMhKQK
         dBtv8pfxqF3P8qSqbxTDDncU/AHvs2joN5TCvnxmLqEHC2KbNBiuPM83qWQfTxBwVRiy
         WcCAH7BPTCMJvwZC4YEJTky2PZI4k7PAUVYij9L1dTqrcPX1cP0SlaAo0dg64Gd6FUjt
         ZWGL+QpWUvfK+pt/aSEbsrOohaRGErdTPyejG5Wl8NK6aqDBIF/NyTr56wH72W2WCVGH
         oH4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nxQKhUXR;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nxQKhUXR;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 36/65] kaiser: tidied up kaiser_add/remove_mapping slightly
Date: Mon,  5 Mar 2018 19:25:09 -0500
Message-Id: <20180306002538.1761-37-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145890780333496?=
X-GMAIL-MSGID: =?utf-8?q?1594145890780333496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Yes, unmap_pud_range_nofree()'s declaration ought to be in a
header file really, but I'm not sure we want to use it anyway:
so for now just declare it inside kaiser_remove_mapping().
And there doesn't seem to be such a thing as unmap_p4d_range(),
even in a 5-level paging tree.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0c68228f7b39c96cabd89bee3e1d6bd55926df80)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/kaiser.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 058d0886086b..190371071a02 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -286,8 +286,7 @@ void __init kaiser_init(void)
 				  __PAGE_KERNEL);
 }
 
-extern void unmap_pud_range_nofree(pgd_t *pgd, unsigned long start, unsigned long end);
-// add a mapping to the shadow-mapping, and synchronize the mappings
+/* Add a mapping to the shadow mapping, and synchronize the mappings */
 int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned long flags)
 {
 	return kaiser_add_user_map((const void *)addr, size, flags);
@@ -295,15 +294,13 @@ int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned long fla
 
 void kaiser_remove_mapping(unsigned long start, unsigned long size)
 {
+	extern void unmap_pud_range_nofree(pgd_t *pgd,
+				unsigned long start, unsigned long end);
 	unsigned long end = start + size;
 	unsigned long addr;
 
 	for (addr = start; addr < end; addr += PGDIR_SIZE) {
 		pgd_t *pgd = native_get_shadow_pgd(pgd_offset_k(addr));
-		/*
-		 * unmap_p4d_range() handles > P4D_SIZE unmaps,
-		 * so no need to trim 'end'.
-		 */
 		unmap_pud_range_nofree(pgd, addr, end);
 	}
 }
-- 
2.16.2

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeD3EUc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:20:32 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:44727 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeD3EUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:20:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180430042029epoutp04fcbfb62df39651249d5c7586ca06bcf8~qG9XhCIIQ0285402854epoutp04H
X-AuditID: b6c32a48-c31ff70000000fef-ec-5ae6998ce2ae
From: CHANDAN VN <chandan.vn@samsung.com>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com, robin.murphy@arm.com,
        labbott@redhat.com, steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, chandan.vn@samsung.com, vn.chandan@gmail.com
Subject: [PATCHv2 1/1] arm64: To remove initrd reserved area entry from
 memblock
Date: Mon, 30 Apr 2018 09:50:18 +0530
Message-id: <1525062018-8065-1-git-send-email-chandan.vn@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmuW7PzGdRBgs3ilm8X9bDaDHhS4TF
        y0OaFvf3LWeyuH+8jdVi5Z4fTBabHl9jtbi8aw6bxcEPT1gtJr3ZxmTxZ/9PFovXty+wW7z8
        eILFgddjzbw1jB47Z91l97hzbQ+bx+Yl9R7v911l8+jbsorR4/MmuQD2qFSbjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBblRTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGRnomprFWRqZAJQmpGT9W6xWs5aiYsX0NSwPjR7Yu
        Rk4OCQETiafN/5i6GLk4hAR2MEp82feZBcL5zijRtbmFFabqV/NkNojEBkaJRdc+MUI4vxkl
        Jn87CTaLTUBT4sS8aewgCRGBdiaJq8c7gQZzcDALOElcv+4PUiMsECRx/txXFhCbRUBVYv6Z
        GWwgJbwCrhJvHilCLJOTOHlsMthiTgF3iccP+9kh4gfYJFb+MYewXSS23P0AdZywxKvjW6Bq
        pCWerdrICGHXS6y/fBnsGwmBDkaJn02XoX62l5ixeCsziM0swCfRcfgvO8gNEgK8Eh1tQhAl
        HhK97+dBlTtKXNv3ih3i31mMEpcmzWKcwCi1gJFhFaNYakFxbnpqsVGBiV5xYm5xaV66XnJ+
        7iZGcErS8tjBeOCczyFGAQ5GJR7eDdbPooRYE8uKK3MPMUpwMCuJ8K7sAArxpiRWVqUW5ccX
        leakFh9iNAUGzURmKdHkfGC6zCuJNzSxNDAxMzMxMDe1MFYS523wPRMlJJCeWJKanZpakFoE
        08fEwSnVwMiT85ypRXq7B0PuakdxxzffpG8eXufkbXDBzUXB5Owu/znfDX+LXbzE/07/9C8v
        jquBK1ZLeM3U/cXc8l+dfxmfo+DUn3VT0kREdpf/O/Sh63fWllufYp4zv3/CNdv+hMeS4/++
        7PN+veZJ3TOueMbyae9W3ju/qGr9li05D841nVF2bzha8qFFiaU4I9FQi7moOBEAWS9pHl8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsVy+t9jQd3umc+iDD6esrF4v6yH0WLClwiL
        l4c0Le7vW85kcf94G6vFyj0/mCw2Pb7GanF51xw2i4MfnrBaTHqzjcniz/6fLBavb19gt3j5
        8QSLA6/HmnlrGD12zrrL7nHn2h42j81L6j3e77vK5tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2
        CVwZP1brFazlqJixfQ1LA+NHti5GTg4JAROJX82TgWwuDiGBdYwSLdtvsIMkhAR+M0q8XpMP
        YrMJaEqcmDeNHaRIRKCdSaJ54QfmLkYODmYBJ4nr1/1BaoQFAiT+3XsENpRFQFVi/pkZbCAl
        vAKuEm8eKULskpM4eWwyK4jNKeAu8fhhP9QqN4mfv1axTWDkWcDIsIpRMrWgODc9t9iowCgv
        tVyvODG3uDQvXS85P3cTIzAUtx3W6t/B+HhJ/CFGAQ5GJR7eDdbPooRYE8uKK3MPMUpwMCuJ
        8K7sAArxpiRWVqUW5ccXleakFh9ilOZgURLn5c8/FikkkJ5YkpqdmlqQWgSTZeLglGpgdNbf
        uXWFqKvH9PknJr9MPVEgpj6zcuUWE49NS1a2pmrWH7h7LSVCMOl8QUjWmf/Mtz8c33+8Me/1
        VtOmyWd23yuu3FihPNlZb//HUP2PpRWuuzn4Kv9O/cnNX/5z6XaeGwab5909bDZhyTKnJsOc
        7RLu2tbrlJfzaP5yTf92UXti9Mbajy8Z5JVYijMSDbWYi4oTAchcHBlBAgAA
X-CMS-MailID: 20180430042028epcas2p24418c10ebe7b2c656cdfc31e98ed540b
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180430042028epcas2p24418c10ebe7b2c656cdfc31e98ed540b
X-RootMTR: 20180430042028epcas2p24418c10ebe7b2c656cdfc31e98ed540b
References: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
        <CGME20180430042028epcas2p24418c10ebe7b2c656cdfc31e98ed540b@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INITRD reserved area entry is not removed from memblock
even though initrd reserved area is freed. After freeing
the memory it is released from memblock. The same can be
checked from /sys/kernel/debug/memblock/reserved.

The patch makes sure that the initrd entry is removed from
memblock when keepinitrd is not enabled.

The patch only affects accounting and debugging. This does not
fix any memory leak.

Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
---
 arch/arm64/mm/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9f3c47a..1b18b47 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -646,8 +646,10 @@ void free_initmem(void)
 
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (!keep_initrd)
+	if (!keep_initrd) {
 		free_reserved_area((void *)start, (void *)end, 0, "initrd");
+		memblock_free(__virt_to_phys(start), end - start);
+	}
 }
 
 static int __init keepinitrd_setup(char *__unused)
-- 
1.9.1

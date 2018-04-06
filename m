Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeDFExp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:53:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:53689 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbeDFExn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:53:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180406045341epoutp0472792626a80c08a6a55889d52a9a15b8~iv7gX7lPi0479504795epoutp04d
X-AuditID: b6c32a35-139ff70000000fee-7f-5ac6fd5486fe
From: CHANDAN VN <chandan.vn@samsung.com>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        takahiro.akashi@linaro.org, james.morse@arm.com, robin.murphy@arm.com,
        labbott@redhat.com, steve.capper@arm.com, kristina.martsenko@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cpgs@samsung.com, chandan.vn@samsung.com, vn.chandan@gmail.com
Subject: [PATCH 1/1] arm64: To remove initrd reserved area entry from
 memblock
Date: Fri, 06 Apr 2018 10:23:10 +0530
Message-id: <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7bCmgW7I32NRBtP/q1i8X9bDaDHhS4TF
        y0OaFvf3LWeyuH+8jdVi5Z4fTBabHl9jtbi8aw6bxcEPT1gtJr3ZxmTxZ/9PFovXty+wW7z8
        eILFgddjzbw1jB47Z91l97hzbQ+bx+Yl9R7v911l8+jbsorR4/MmuQD2qFSbjNTElNQihdS8
        5PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKBblRTKEnNKgUIBicXFSvp2
        NkX5pSWpChn5xSW2StGGhkZ6hgbmekZGRnomprFWRqZAJQmpGTfPL2ApuMpe8fbpGtYGxtVs
        XYycHBICJhK9i+cydjFycQgJ7GCU6Hn8nAnC+c4osf33NkaYqlN/97FDJDYwSmxY/5YZJCEk
        8JtRYvF1JxCbTUBT4sS8aWBFIgLtTBJXj3cCjeLgYBZwkrh+3R/EFBYIkDj0NBmknEVAVWJv
        61sWEJtXwE3i9NynUBfJSZw8NpkVZIyEwAo2ieVb5kEd4SLx6+AXqCJhiVfHt7CDzJQQkJa4
        dNQWIlwvsf7yZRaI3g5GiZ9Nl6Hq7SVmLN4KdjOzAJ/Eu689rBC9vBIdbUIQJR4SvcefMkHY
        jhJbNlxkgXgxVmJ75z6WCYySCxgZVjGKpRYU56anFhsWGOoVJ+YWl+al6yXn525iBCceLdMd
        jFPO+RxiFOBgVOLhzYg4FiXEmlhWXJl7iFGCg1lJhHf3H6AQb0piZVVqUX58UWlOavEhRlNg
        cExklhJNzgcmxbySeEMTSwMTMyNjEwtDM0Mlcd6AAJcoIYH0xJLU7NTUgtQimD4mDk6pBsYe
        NdMKzoMVM86EvV9yhVnLrfbfORsL/sg9xc5yjHxb7z17vHPiziIf+zMVXwqa00u5dFddbqnO
        YuSR9UqQdeVviQrcbbfDReHD2+WCzZ+3HJA9s7Fqg9C846eTZvEarbza7+LHUjYtlEPwJ+/H
        BaJnv67czGT8jz9+6q1Zxr8W3PB/MfVMd40SS3FGoqEWc1FxIgCqBQHoUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQd2Qv8eiDJZ/F7J4v6yH0WLClwiL
        l4c0Le7vW85kcf94G6vFyj0/mCw2Pb7GanF51xw2i4MfnrBaTHqzjcniz/6fLBavb19gt3j5
        8QSLA6/HmnlrGD12zrrL7nHn2h42j81L6j3e77vK5tG3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2
        CVwZN88vYCm4yl7x9uka1gbG1WxdjJwcEgImEqf+7mPvYuTiEBJYxyhxa88rKOc3o8S7/e1M
        IFVsApoSJ+ZNA0uICLQzSTQv/MDcxcjBwSzgJHH9uj9IjbCAn8T0w4cZQWwWAVWJva1vWUBs
        XgE3idNzn0Jtk5M4eWwy6wRGrgWMDKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQID
        bNthrb4djPeXxB9iFOBgVOLhzYg4FiXEmlhWXJl7iFGCg1lJhHf3H6AQb0piZVVqUX58UWlO
        avEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwcnFINjDwaFRoKgrt0W60+VljvuLTd949G
        GOfDyrROY965Ph6Lv8fP0z0knH7gRvqUrx84z7bc930/Ufhtzj1Bi7yCGtEd59QDJ1YKT/R3
        l12oOO/YDMGtGw9+OnHj7+cAxoZdGwr3777cEpvXxbDI8XyoOcenq/ESU+b1zGC8PcPu4RPG
        t7JMe6TcYpVYijMSDbWYi4oTAca1qPAsAgAA
X-CMS-MailID: 20180406045340epcas1p1ae6416dc25823212303c9109d125c018
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180406045340epcas1p1ae6416dc25823212303c9109d125c018
X-RootMTR: 20180406045340epcas1p1ae6416dc25823212303c9109d125c018
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INITRD reserved area entry is not removed from memblock
even though initrd reserved area is freed. After freeing
the memory it is released from memblock. The same can be
checked from /sys/kernel/debug/memblock/reserved.

The patch makes sure that the initrd entry is removed from
memblock when keepinitrd is not enabled.

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

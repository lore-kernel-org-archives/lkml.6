Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeE3FUt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:20:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57364 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeE3FUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:20:45 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180530052043epoutp02b845fdd985403143f3a073ae206fd026~zVIhj2zZY2131021310epoutp02p
X-AuditID: b6c32a45-429ff70000001079-30-5b0e34a9bda2
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: robh+dt@kernel.org, m.szyprowski@samsung.com, mitchelh@codeaurora.org
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] drivers: of: of_reserved_mem: detect count overflow or
 range overlap
Date: Wed, 30 May 2018 14:21:42 +0900
Message-id: <20180530052142.24761-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7bCmme5KE75og43/LSzmHznHajHzzX82
        i+7NMxktet+/YrK4vGsOm8W9Nf9ZLdYeuctusXb+NjaL1r1H2B04PS739TJ57Jx1l91j06pO
        No9Nnyaxe/RtWcXo8XmTXABbVKpNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJC
        XmJuqq2Si0+ArltmDtBVSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMj
        IG0ea2VkClSSkJqxZO1n1oKJqhV7D31lbmCcLtvFyMkhIWAicf7jX7YuRi4OIYEdjBKNbQ/Z
        IZzvjBIfH3czw1QtvDKBBSKxm1Hi/sMGJgjnD5Bz6AhYFZuAtsT7BZNYQWwRAU+JpgPzmEGK
        mAVWM0qcvriUBSQhLBAuMfnFFHYQm0VAVaL7+RewBl4BW4mWZw0sEOvkJa786gdbJyHQwSZx
        /uQDVoiEi0THnEVQRcISr45vYYewpSWerdrICNHQzCjxduZmKKeFUeLupl5GiCpjid6eC2C3
        MgvwSXQc/gvUzQEU55XoaBOCKPGQ2NH0DmyBkECsxK/D29kmMEosYGRYxSiWWlCcm55abFRg
        qFecmFtcmpeul5yfu4kRnD60XHcwzjjnc4hRgINRiYe3I4o3Wog1say4MvcQowQHs5IIb+le
        nmgh3pTEyqrUovz4otKc1OJDjKbAQJjILCWanA9MbXkl8YamRsbGxhZmRsaGJsZK4rw3zf5F
        CQmkJ5akZqemFqQWwfQxcXBKNTCu3Xe8mk83PUXVpWXtnZxWpanJ82ZE7m5QezqHK0b8c8zx
        tmvVQoFVb3wW+jFcU0tXORH5Yl+LkkbJoc697KsZv7w/KXA8rbSTVelYoPLbYxfe9a+d9UnQ
        cqfwKmGl+LNhFg82cSwvb996eHPl5NXMU1Jnzbt17vW32O4tPw9suqfKU5RyNO6LEktxRqKh
        FnNRcSIAD019xDUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xgO5KE75og13NKhbzj5xjtZj55j+b
        RffmmYwWve9fMVlc3jWHzeLemv+sFmuP3GW3WDt/G5tF694j7A6cHpf7epk8ds66y+6xaVUn
        m8emT5PYPfq2rGL0+LxJLoAtissmJTUnsyy1SN8ugStjydrPrAUTVSv2HvrK3MA4XbaLkZND
        QsBEYuGVCSxdjFwcQgI7GSXWtayAcv4wSjTvWsgEUsUmoC3xfsEkVhBbRMBTounAPGYQm1lg
        NaPEz24tEFtYIFxiXkMnC4jNIqAq0f38C1g9r4CtRMuzBhaIbfISV371s0xg5FrAyLCKUTK1
        oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMwaLYd1urfwfh4SfwhRgEORiUeXoMI3mgh1sSy
        4srcQ4wSHMxKIryle3mihXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgt
        gskycXBKNTDO2yDqxqx461zd13NzguTWCn/aa8ylOLvknqjyH6F/JicPHkxRl5YIXSV0TEKr
        3efjPId+Hqe2RXs1lepjvMPEUz6uXmbhrzQx2D1j78nJTPf03FnPH+1g/p7Y+Yb1xqvqD1l7
        zux58lTE+Pkhw7vqn0XEua5c333e73S2bdqmZwE71B8+fn9diaU4I9FQi7moOBEAayzyDxYC
        AAA=
X-CMS-MailID: 20180530052041epcas2p395f2fbf4506d911c127cc4243838fedb
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180530052041epcas2p395f2fbf4506d911c127cc4243838fedb
References: <CGME20180530052041epcas2p395f2fbf4506d911c127cc4243838fedb@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During development, number of reserved memory region could be increased
and a new region could be unwantedly overlapped. In that case the new
region may work well but one of exisiting region could be affected so
that it would not be defined properly. It may require time consuming
work to find reason that there is a newly added region.

If a newly added region invoke kernel panic, it will be helpful. This
patch records if there is count overflow or range overlap, and invoke
panic if that case.

These are test example based on v4.9.

Case 1 - out of region count
<3>[    0.000000]  [0:        swapper:    0] OF: reserved mem: not enough space all defined regions.
<0>[    1.688695]  [6:      swapper/0:    1] Kernel panic - not syncing: overflow on reserved memory, check the latest change
<4>[    1.688743]  [6:      swapper/0:    1] CPU: 6 PID: 1 Comm: swapper/0 Not tainted 4.9.65+ #10
<4>[    1.688836]  [6:      swapper/0:    1] Call trace:
<4>[    1.688869]  [6:      swapper/0:    1] [<ffffff8008095748>] dump_backtrace+0x0/0x248
<4>[    1.688913]  [6:      swapper/0:    1] [<ffffff8008095b48>] show_stack+0x18/0x28
<4>[    1.688958]  [6:      swapper/0:    1] [<ffffff8008446e84>] dump_stack+0x98/0xc0
<4>[    1.689001]  [6:      swapper/0:    1] [<ffffff80081cf784>] panic+0x1e0/0x404
<4>[    1.689046]  [6:      swapper/0:    1] [<ffffff8008ddcdb8>] check_reserved_mem+0x40/0x50
<4>[    1.689091]  [6:      swapper/0:    1] [<ffffff8008090190>] do_one_initcall+0x54/0x214
<4>[    1.689138]  [6:      swapper/0:    1] [<ffffff8009eacf98>] kernel_init_freeable+0x198/0x24c
<4>[    1.689187]  [6:      swapper/0:    1] [<ffffff8009396950>] kernel_init+0x18/0x144
<4>[    1.689229]  [6:      swapper/0:    1] [<ffffff800808fa50>] ret_from_fork+0x10/0x40

Case 2 - overlapped region
<3>[    0.000000]  [0:        swapper:    0] OF: reserved mem: OVERLAP DETECTED!
<0>[    2.309331]  [2:      swapper/0:    1] Kernel panic - not syncing: reserved memory overlap, check the latest change
<4>[    2.309398]  [2:      swapper/0:    1] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.9.65+ #14
<4>[    2.309508]  [2:      swapper/0:    1] Call trace:
<4>[    2.309546]  [2:      swapper/0:    1] [<ffffff8008121748>] dump_backtrace+0x0/0x248
<4>[    2.309599]  [2:      swapper/0:    1] [<ffffff8008121b48>] show_stack+0x18/0x28
<4>[    2.309652]  [2:      swapper/0:    1] [<ffffff80084d2e84>] dump_stack+0x98/0xc0
<4>[    2.309701]  [2:      swapper/0:    1] [<ffffff800825b784>] panic+0x1e0/0x404
<4>[    2.309751]  [2:      swapper/0:    1] [<ffffff8008e68dc4>] check_reserved_mem+0x4c/0x50
<4>[    2.309802]  [2:      swapper/0:    1] [<ffffff800811c190>] do_one_initcall+0x54/0x214
<4>[    2.309856]  [2:      swapper/0:    1] [<ffffff8009f38f98>] kernel_init_freeable+0x198/0x24c
<4>[    2.309913]  [2:      swapper/0:    1] [<ffffff8009422950>] kernel_init+0x18/0x144
<4>[    2.309961]  [2:      swapper/0:    1] [<ffffff800811ba50>] ret_from_fork+0x10/0x40

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/of_reserved_mem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9a4f4246231d..e97d5c5dcc9a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -65,6 +65,7 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 }
 #endif
 
+static bool rmem_overflow;
 /**
  * res_mem_save_node() - save fdt node for second pass initialization
  */
@@ -75,6 +76,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 
 	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
 		pr_err("not enough space all defined regions.\n");
+		rmem_overflow = true;
 		return;
 	}
 
@@ -221,6 +223,7 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	return 0;
 }
 
+static bool rmem_overlap;
 static void __init __rmem_check_for_overlap(void)
 {
 	int i;
@@ -245,6 +248,7 @@ static void __init __rmem_check_for_overlap(void)
 			pr_err("OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
 			       this->name, &this->base, &this_end,
 			       next->name, &next->base, &next_end);
+			rmem_overlap = true;
 		}
 	}
 }
@@ -419,3 +423,13 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
+
+static int check_reserved_mem(void)
+{
+	if (rmem_overflow)
+		panic("overflow on reserved memory, check the latest change");
+	if (rmem_overlap)
+		panic("overlap on reserved memory, check the latest change");
+	return 0;
+}
+late_initcall(check_reserved_mem);
-- 
2.13.0

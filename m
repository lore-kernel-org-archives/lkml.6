Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCULLp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:11:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19533 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCULLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:11:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180321111139epoutp014237da7e2369ede8171f89e8c8b431da~d6w9Ftxux0514905149epoutp01T
X-AuditID: b6c32a49-025ff70000001122-2c-5ab23deb8cfc
From: Maninder Singh <maninder1.s@samsung.com>
To: linux@armlinux.org.uk, dustinb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Subject: [PATCH v2] arm/stacktrace: stop unwinding after an invalid address.
Date: Wed, 21 Mar 2018 16:40:45 +0530
Message-Id: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTcRTH+e1udzdrcZtmp0k2LvSHwubu2PQuXA8SWyVhT2hR66K/1HJ3
        496ZGVSWZWFZ2eMfcxRYlgaZjyxmQk2yxDDMspf0fr+oZtKDqF2v0X/fc76f8+BwKEL/RmOg
        CoQAFgW+kCFj1G2dScmm985mt+VAnYHra8fc6z21JNf8fEDD9YdqSC58pANxncfK1dyjD+dV
        XLg7iGZRrv6BPsLVv69S5Wo5sdW1r7UBuSLNidkaN07Px3wuFo1YyPHlFgh5TmbBEs8cjz3V
        wppYB5fGGAXei51MRla2KbOgMLoJY9zAFxZFU9m8JDEpM9JFX1EAG/N9UsDJrGRZq5m1pJmt
        VqvZZl813WqPImtwft3wXa3/JLXxdtcgKkXbtBWIooC2we8XEypQDKWn2xEEh1pRBRoTDb4i
        uNibphjDCHrOPiRkQy6oCh8lFaMDwZ7gIbUSDCE4+Xk/KVMkbYaG0CW1rONoFpre1SMZIujr
        CL5f+KGSjVg6C0K1H0YgNT0NSkvvaGWto+fCzcflamVcInR3HdLIxUBvIyG4f6dKWTwDjjws
        UZhYeHetVatoA0Q+dZAKX4Zg8PQ3QgkOI/gafDradSY8uXd15AIEnQSNoRQl7YSD4cgIQtDj
        ofLXi9FZOthdrleQabDj/jmNohMg8uXLaEcX3GupRIqeDb0PbmnkUj29CjpfFh9AidX/Zx1H
        qAFNxn7Jm4clu58VcLFZ4r1SkZBnzvF5m9HIlyXPu4iqe7PCiKYQM07HxTe59Rp+g1TiDSOg
        CCZO1xaJpnS5fMkmLPo8YlEhlsLIHr1lFWGYmOOL/qwQ8LA2h8WWmprGWiwOGzNJN3tRhltP
        5/EBvB5jPxb/1amoMYZSFOdY+Ky2ONF4rCl9kcodE7t83eR427kLV47SY3WmZZMGk1f0iTdO
        oZ/fEmLHi2/Lznz+2BPKTBIckczyqTtIjaFsVy0/0L2p6vLeofo/9a9CO7Xb+5cmHITGejSf
        3lvTVeJL9xs3/yj7KK3eMmW4raWiZ/HalomeBtOssC9rKL6aUUv5PJtMiBL/FzkWpDR7AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXveV7aYog92txhYXd6daPO9ezGax
        6fE1VovLu+awWRyaupfR4vD8NhaLe2+2MlkcOjmX0YHD4/K1i8wel/t6mTw2L6n36NuyitHj
        8ya5ANYoLpuU1JzMstQifbsEroxl366zFyzlqLhy7A5jA2MjexcjJ4eEgInExEOz2UBsIYHd
        jBK7j1tDxKUlfv57zwJhC0us/PccqJ4LqOYTo0TXq6lgCTYBPYlVu/aA2SICxhKHP3xlBili
        FjjHKLG96wAjSEJYwEdi1+I3YEUsAqoSDQ1XwTbzCrhLnL/fBrVBTuLkscmsExh5FjAyrGKU
        TC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA4mLc0djJeXxB9iFOBgVOLhnSCxMUqINbGs
        uDL3EKMEB7OSCO+2z0Ah3pTEyqrUovz4otKc1OJDjNIcLErivE/zjkUKCaQnlqRmp6YWpBbB
        ZJk4OKUaGMNn6FWYVAe/6N4xwT8sZP/n756JyauOL7tQ6LIn8Zuvxq0LAnyya1vvhy9+fe1N
        CvNduV5bfrc/b6onfg3w2BsWKmPa4Htm9qy08Oz7wpkVy5mzGTrOh93hkkj87SX3eKrRPalt
        8n/X3OiVPjTzYMMzrnZuwxfiV1esF1/nLi97ejvHdFad90osxRmJhlrMRcWJAIdo0NAiAgAA
X-CMS-MailID: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
X-RootMTR: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
References: <CGME20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch stops unwinding backtrace in case address does not
belong to kernel address like below:-

....
__do_fault+0x4c/0xa8
handle_mm_fault+0xb74/0x11c0
do_page_fault+0x29c/0x38c
do_DataAbort+0x40/0xb8
__dabt_usr+0x44/0x60
0xb6748ea4
^^^^^^^^

So this patch discards last junk entry.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
v1->v2: https://lkml.org/lkml/2017/10/24/378
(take care of IRQ taken in SVC mode)

 arch/arm/kernel/stacktrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
index a56e7c8..1aadffc 100644
--- a/arch/arm/kernel/stacktrace.c
+++ b/arch/arm/kernel/stacktrace.c
@@ -92,6 +92,9 @@ static int save_trace(struct stackframe *frame, void *d)
 
 	regs = (struct pt_regs *)frame->sp;
 
+	if (!__kernel_text_address(regs->ARM_pc))
+		return 1;
+
 	trace->entries[trace->nr_entries++] = regs->ARM_pc;
 
 	return trace->nr_entries >= trace->max_entries;
-- 
1.9.1

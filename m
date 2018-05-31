Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754383AbeEaKVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 06:21:39 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33463 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbeEaKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 06:21:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180531102135epoutp03795848323f9ddc49a02fb6e7caa4d304~zs4gI4gRu2386123861epoutp03T
X-AuditID: b6c32a4b-9a1ff70000001138-57-5b0fccae6b28
From: Maninder Singh <maninder1.s@samsung.com>
To: pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com,
        Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/2] printk: remove unused flag LOG_NOCONS
Date: Thu, 31 May 2018 15:47:51 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURjn7HkNZ5dZdFph40KQlnN3Ob2alpDkIAuhtyLzogcnbndrd64H
        BAZjDjEzFSLtYfWHYJohKk2n1fKRFYWV9LBspUHayzkfpKRtu4v+Ot/3e3yPw4fxpS+FMqyI
        sSAzQ+sJ0SpB58PoLbG3n67OUdZMxlHD3Yh62XVZRD28ZhdQY987eNTK+JyQ6nV4eFSLb1xM
        uYeugDRM46z7INbYet+JNZXtTUDT2j4i0PjaorKE2ShFh+gCZJYjJt9YUMQUphJ7D2h3a9UJ
        SjKWTKISCTlDG1AqkZ6ZFbunSO8fhZBbaX2JH8qiWZaI25liNpZYkFxnZC2pRA5JqhSkMlGh
        UvlfdW6ySu2X5CFdj+0mz/QZOzn/85W4FFSIy0EYBvF4eOnTsrAcrMKkeDeAr+tHAZfMADjX
        ZQsx8wA+eLwi+Ge55WjkcUQPgAPOSwIumQVwovITP6AS4QrY1OUKOtbgGXBmYVoUEPHxagAX
        PjYHiUg8GXqr3gQNAnwz/OYYBlyLKDg0UBPsDfEqEZx0DQsDhAS3wsYbT0JzpMN3rY9Ca0TC
        qcH2UCyDk+ftoZiF5b/OAq6QDcAfs5/5HLELet70+0WYf6Ro2NoVF4D5eAQ8tzTBC8AQl0CH
        XcqpN0Pb2ztCLt4AfV6vgJNo4IspbQCW4rnwz/s+cRXYWPe/ZgMATWA9MrGGQsSqTdsZdELB
        0ga2hClU5BsNbSB4UDF774K2Z5lugGOACJdgzRE5UiFtZU8Z3ABifGKNpNa6OkcqKaBPnUZm
        o9ZcokesG6j9f3aBL1ubb/SfJ2PRkmpVQoIySaneTiWQxDrJfPxythQvpC2oGCETMv/z8bAw
        WSnYGr40B48md2r6VePjfX1fWruLmeN3PYdGo9oOjBR31LYcn1EsrtOMHdxUv2DPmF/87vP+
        7t3R4Dx80vnVN5J0ZGyp8qKHbSD2ua83758+Mz24LKouq6Ezw++n3nON/HKQSzf1qLpM62Zu
        ZV99nluRdWPWM7fPfmRb2sSzDFfeMULA6mgyhm9m6b932wpPZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSnO7aM/zRBmuviVtc3J1qcXnXHDaL
        w/PbWCzuvdnKZPH/8VdWi30dD5gs1n5+zG5x6ORcRgcOj52z7rJ7tOy7xe7Rt2UVo8f6LVdZ
        PD5vkgtgjeKySUnNySxLLdK3S+DK2NuymKngEUfFt3dX2BsYe9i7GDk5JARMJFZ3LGfqYuTi
        EBLYzSjR3XiPFSIhLfHz33sWCFtYYuW/5+wQRZ8YJY60TGcCSbAJ6Ems2rUHrEhEwFti6vVf
        jCBFzALTGCU+PD8GtkJYwEri44QbzCA2i4CqxOuOi4wgNq+Au8Txnb2MEBvkJE4em8w6gZFn
        ASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4IDS0tzBeHlJ/CFGAQ5GJR5ejjV8
        0UKsiWXFlbmHGCU4mJVEeKeU8UcL8aYkVlalFuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1
        OzW1ILUIJsvEwSnVwFh/1fFsn81qOQXVHd1/fP+sifjc9HvpXcaGTVtVnyaYLLz1YWZ3SED5
        +9/Prmr45D/nNdOpcxcyjFnwh5uHjW+lyL287rf3E3afsNF4s8B85sF7WS4VT7q6lr6R5l2/
        ozHZK+Zg1Ow53+rTYxNO3fktI9iiso6D055V+utmxZyItQ+XHngmu1iJpTgj0VCLuag4EQDA
        nO0pJAIAAA==
Message-Id: <20180531102133epcas5p2e8d47887c1708836c9b70964983093e2~zs4eTmEuv0380103801epcas5p2U@epcas5p2.samsung.com>
X-CMS-MailID: 20180531102133epcas5p2e8d47887c1708836c9b70964983093e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180531102133epcas5p2e8d47887c1708836c9b70964983093e2
References: <CGME20180531102133epcas5p2e8d47887c1708836c9b70964983093e2@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes unused flag LOG_NOCONS for printk.
usage of this flag is removed long back with below commit.

"5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb"
printk: remove console flushing special cases for
 partial buffered lines

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
---
 kernel/printk/printk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af21..ab15903 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -349,10 +349,9 @@ enum con_msg_format_flags {
  */
 
 enum log_flags {
-	LOG_NOCONS	= 1,	/* already flushed, do not print to console */
-	LOG_NEWLINE	= 2,	/* text ended with a newline */
-	LOG_PREFIX	= 4,	/* text started with a prefix */
-	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
+	LOG_NEWLINE	= 1,	/* text ended with a newline */
+	LOG_PREFIX	= 2,	/* text started with a prefix */
+	LOG_CONT	= 4,	/* text is a fragment of a continuation line */
 };
 
 struct printk_log {
-- 
1.9.1

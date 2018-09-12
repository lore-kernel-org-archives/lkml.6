Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED617C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6020880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D6020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeILWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:08:21 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com ([104.47.2.133]:44960
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeILWIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5IXjQJQHXQ9Jc/79DfGoAA7QFw1a2q9tyVtlEeP6Nk=;
 b=mBGxYAdia+XjwaodJnLmst+vZzDjOH9PkYV8aTkVdUfrmXEStqUhft5GdusyuE+rDPG0zU5q8yTfKxQUe2eyAHcv+0GoGHTxanB4QLCuK0K7/VvPeepRAQvNxli+z1uWdz2o/hyj2XEvAzuH1pklFGIBeho47OmlOWIza+aq4Aw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.32.181) by
 VI1PR07MB3981.eurprd07.prod.outlook.com (2603:10a6:803:39::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.10; Wed, 12 Sep 2018 17:02:50 +0000
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tools: Remove conflicting BITS_PER_LONG define
Date:   Wed, 12 Sep 2018 19:02:32 +0200
Message-Id: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.181]
X-ClientProxiedBy: AM0PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::27) To VI1PR07MB3981.eurprd07.prod.outlook.com
 (2603:10a6:803:39::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e75eba0-db71-44d1-caa1-08d618d1929d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB3981;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3981;3:gUwoIncl4WVs8vls98Ar1GizSOc2GmWXTetZ6qOuXtxdc4BApKoxpEAbyqzpag9nV6Hm1i0F067VENXW2Suyj+UmIrU008//KqpRTE9TsndwkWC9Uo2XYIbtjBZHgC+mx16I+BI2Xjfx5OU6V4dtfgtbyuC3FsslYFLdNnW5Ee7t/H58Oz5oHK81cUqPQyqJZCrnJGRmTeHdA7ngObd0WhW5VM6TUfhPAyNrOp++PadGt328sV4eHfeWVBHSDPxw;25:AHs6ZLsR6UYNTMOM+h8jrQk7TSnkkHwgcj/QDNx6AEssmjie05IMEpG51L7+zfG0JUw4MxgIxEv3QJxqGyAOiXbyGBcnTvFAX1n/bItVpAQX7JnTLaUHRwSQ+1yuSu7JbM7bdynQY5BLmq01cn9ASZsvLODnyc41cIbJJDxJR4Tx1QPVgiP9efLeIEjLX00rp4SOf2tg+P+nq+I9N3K8LHDbRJfmP7MX6l8HVsocn299tjlp2ioBGLDfEXR5t2o4I+QTTdsAzJF9rjpzh1FbKZkGNJANzmRJ1QpCMmO1KpCefxZh/6gafv7PmIva0MQGn7UPFILyhHXs3cNCyUvhPQ==;31:UX32ckD2/fLwlFzEBfEq4kZh6v/9ycUAMdZy/jBJsPHyd1Q5XHwYUKs9a9CZdPKObGpzaMwPNOar7JI6jx9T0twOPj3a8+ZsR4AuVXcptoiuxSYD7N9ij/p1NzpnyOP2TzXn84ZtGwyEeTPoyncJJaBTJ6aohTT8nLDU2CTzzj+BnwhZqj+jiNfKU8JPJ10q9hsPHToUzo5b/71k7HczgItVzHR0fAgPySSAUEi37Vg=
X-MS-TrafficTypeDiagnostic: VI1PR07MB3981:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3981;20:B0RAbplGH3o9rs1v9s5daskZZdjaweMWMqk4wTZc974TEj8GMT742MFEL+qwnfD9XyYjXqiSCN7ZCzVVDsk8+Fr+7XqjdsmVvLPxoS9rkPPp9TKxMnnKgs4ZEO8vyUXm/8YOB6wYVAyYdZn0riOHfbmQkj0DE30M2vHmyGlFCti1M7ZXA7NcSD7TG4+wWpvHsr5fMTkzTurFoQ/s9ZDhEvb0BrxJecIQ6teAMO8kQ51tGwBTcExxpR3MkPonFF10/1uVvZmXIJQh+JmMuqpSGUdZRf9GtqgaSifx3w3c3JCP0DNaTt52cHBJ8w+1ZM+EXWh6NEbF3iqA3mpL8sFXtP8lx51yIu69DeTgEav02ZpBGyXMwZpkRIs78CWEy0dgowhKgbgYs5HJLoLaloa8qv0D9X63E3cRbbOMDjV4WAJganMSzD+PmOJyfL/rP1cWhkfDAzcuna0wpKxy5kHA3DQ9ikUNnp9R5bdz5zhvILdDZJrsrqYe6shDf8Lx7a4N;4:OZLMJst6Scll6GiP/g3QtYROa/aCPUHcFFirmCD6eCuWoeZSkQshgU511UYCWi2/v4zuim/zaYEGAtWvmHr4jxwYKBR8THa4/0oFUHBpcsUhYUzKNTAscBcK/0n+kYpbz/8UmGrmgYcXc/8Uj6Co9o6VfHK6vAOvXLQt+gAOEPyCx1PoBloIsBpaqtJIrDsj/lrMeLvwU7I/pP17HEbR00yC+XZfkd5VFip5x+qplrsjehTn9LqcpKT8AfsLQ4B+i6fvwJjkugzfA71iYXGG8YpRxHzWITQZGgot1qVLlO8ajE6sGAcuyTkJSKHIOWAoDE5VAu4i6z9hgLd9ngjfeEaiS5DvRiEAslS42JjoKh6KU1UfpAzFT4cq3cWUccGi
X-Microsoft-Antispam-PRVS: <VI1PR07MB3981C8D02A886B261EDB2546881B0@VI1PR07MB3981.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333)(195916259791689);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(11241501184)(806099)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:VI1PR07MB3981;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB3981;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(106356001)(86362001)(8676002)(6512007)(4326008)(53936002)(6666003)(25786009)(5660300001)(316002)(16586007)(54906003)(68736007)(6916009)(48376002)(44832011)(97736004)(305945005)(6486002)(105586002)(7736002)(2906002)(8936002)(81166006)(3846002)(50466002)(6116002)(81156014)(1076002)(47776003)(2361001)(1857600001)(26005)(66066001)(50226002)(186003)(478600001)(386003)(6506007)(36756003)(16526019)(956004)(51416003)(486006)(2351001)(476003)(52116002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3981;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB3981;23:0qq5Y5jL8ZTtfXn2CFfihfTZwE74FOaxhHAW6LsGX?=
 =?us-ascii?Q?sXUZttwa7zj9V56IiRvTWvXJ1Lz6NiH+k6pIHrSoNTvmkCiwqlddOnSYBJFl?=
 =?us-ascii?Q?rHV3fD758MBkPwHNaexLDvegd1AaXyrZexxw47WKRgjS5lNHuohMnC6OlEGQ?=
 =?us-ascii?Q?oMhRP7rw2oQavgNxDAzXSwlLMGmS9JNdC3cV6pHl2z7rW9pb5qtNO4bhjKIz?=
 =?us-ascii?Q?AJrg6Omv2bqCJLCTZZfMBLNwmJ24kdgkbD+UDdNc87QMZSpwzh0CMWXsV4F/?=
 =?us-ascii?Q?n83srfgmgX1HpjMA7TTfD1IAeR4FOdpGwYQuZbHc60Z9y/caWQpYTQ+r/E/M?=
 =?us-ascii?Q?R+yLO/pIGS+elN9dnjCl5BOmy6ZFzz1keT9KY5JYHrlz4E6mHebdHo+PN+/t?=
 =?us-ascii?Q?/MhJgZydseZVUBbMYH8ubH02+FEmRHTPFT9ZzAuw1krW/sUkiQ2q38s08Rsn?=
 =?us-ascii?Q?W0iByIe0KixJtS2t4GNsRTTiJsIEey1kYHgkVfXybojHMmN58HeMc2wlccfW?=
 =?us-ascii?Q?YYIMCjgtdxVkKBSMhewx16T6jDSV+JxnXEK6GdYbNut7dt3nhwuQh2EWg1GF?=
 =?us-ascii?Q?ytNSe7Ykw0L2Gu/vNKSOo85f+YNhRglpePljtDHjA1Z1XramR0wLyt39Iajn?=
 =?us-ascii?Q?0GqgZN7f672uwsvEWwr+pO56HXkdlHIu4T/GsFdKi4BsVnl4sCwYinjXoPn6?=
 =?us-ascii?Q?dmZeInOow2xFuEgahFaBj4OTAe2o4DJ1EQ4DNptyOraFT6ZHkE8FSQuyFDk1?=
 =?us-ascii?Q?m4Qh3X5zZDasvZ1Sm2BEy4o04kIi2ibdolxKtNr4WHAm1yqKr2kMR4GOqwN7?=
 =?us-ascii?Q?wRRKKoJdIV3bPF8iuc4I1vtYUhPm4pGZq3ZKZI2B8EVMl0A1a0IfZcAS85ht?=
 =?us-ascii?Q?8ObPG3lAlKx9qI5YZrAnGCgoUP0LJyTk0mgh0RfkjKcSqK5gc+PQPCYzOAD0?=
 =?us-ascii?Q?EtqjQQ9FHSSFxqUcniRI5dm6790JV70d3Eq3/9K+e0ZfKdJLgWlwSK5i9UdT?=
 =?us-ascii?Q?xBsr/X2pmgVbqU7ru97yFXDhJ0m+18ITOfDaIKz4EhDE5eYzIQ/AR7A1UQRW?=
 =?us-ascii?Q?IgWTuxoUYPVumLlXeP4M8KxoPBZ58ZlsQLHEYRzQEWmJoS1CsZmVwFLmHnNZ?=
 =?us-ascii?Q?dko8PDvN4nTScAYb8hvsr8OmM50wPyusHxUxYpZDvoE8ALnHefR03aw8tNXv?=
 =?us-ascii?Q?Rfl7Yd1O0cmNVeCHRXxV+3mlGa/HzN95Ns6tQlotElMEu9Z+PxBN4u3Zw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: xKTw5yEYHuje37Ev/Z/ECoSgh88Kwa+X6I9EBhcXvvwFuEUqctjTtC1lXekna2+8HIfngZtSyZZU4y+kzKgd0dh7hB9Aqo224bRxXXHErgOyQzgcHgeYAxmkTexaWYel5dAKmhiNlIlmrL8sSH8iE9nORT2Bvr2xagC6v5SqGdfHGvIVUuaTqY4D/2R1jzK0PjGltxI3mFq+s3VHdOk0M43+Iwt+ZJpR7aH+gdnADrzfryBSyfzwZ/+bMW6f1wyvY7kkCdr+l/LeAqwkNuCB4HabZqCs3mNJPoht/9ElBwTuXtmMd55/Q2nxDN040COYfrzc+pHp3J/NujG6+DPRmEXfkW/Qdfk0QL/jbkSDkPTvuYJ64uszzjfiCe6Cj96CzQedUihKxBVrAmemwLUa9Q==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB3981;6:k9ZzEHaYr/PHu31Jsw5jFdXpNaJDdrkf6xWgq7raj2ymgypn44DPebHPPKPDkSZ5ilsRvVi/DH3pA8sMbw9cjTL+KpgSJalbs9xBQLzsBJkdB4OtiqgCuCJRnMjB5Rn36mKrGCXpsVFO83TS2Y1ii5wEb2bY0KCHsWtZHMbbgToTOj046rZtiLYvXqXtIKpsJ9vUVrhkDloEm7tz+AXwYAQRcSlH1BEol4/BW/6A7ZcCNWeavq3v+O9AujlFttcIhEH0JE0LTgGIby4uqgY6KbJ442Nvf8GlQUyWQZ+XbPxIjllqIaKJMY5Rj1M61d2HpWciGQ8GAZJcZhPYs/KyMHiyaW5bJ60k0jf0qujlfgV/OLqcqGIM/OPtAkX0ILXPMRt/IY4/UZuM9ntr+boSQjcaEkATaMFVXavzJzojn/HXruSfQVOtTDmKUe45xVA1Yw2lUkpd7dS3K68H1Gy2BA==;5:XuEGywv3+IPu4ATPMjHJEa2nD/Uv/SNN2wVo+h86Er0GN39ASzRppsWw2bVxiUsRcFD57Kg0YfUK/FGmmGdkiQigTKYLYvFgrUEnE5gdH90DWTA9SdpeGu8qZyCScHlbvQSGGU/yOIxiXpOBHSxBYFyTG7OViWz3IZkxf+MxRhE=;7:xeTgsfvqAooN60B0XTKbEqRUgjmPXzXVoJiZ8GIaBpSbnHKcrIsXCBfHlXsyDzeebTeo67eU1utTjOZdeNgJj3uD8b7ttKFxlDcibcB8VhOzzWnhH99UmVV5o4rZNn0cv5kVV+yr0BlOJHDxH7MiGS6vxV+O37Zafw4GfL9dRfbe03ynUD/zg+O83AeQIIhIJFVWD+IObadyEArphjmhYO28URSC+hRONzOQvekJQp0MhU9YVWEpHpA/moe3ElMG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 17:02:50.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e75eba0-db71-44d1-caa1-08d618d1929d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  CC       .../tools/objtool/builtin-check.o
  ...
In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
                 from .../tools/include/asm-generic/bitops/__ffs.h:6,
                 from .../tools/include/asm-generic/bitops.h:16,
                 from .../tools/include/linux/bitops.h:35,
                 from .../tools/include/linux/hashtable.h:13,
                 from elf.h:24,
                 from check.h:22,
                 from builtin-check.c:30:
.../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
 #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

Include <asm/bitsperlong.h> instead as other headers do.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---

Seen during x86_64 build. Seems that most of the compilers do not define
__SIZEOF_LONG__, but my does.

 tools/include/linux/bitops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index acc704b..4ae5232 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -3,16 +3,13 @@
 #define _TOOLS_LINUX_BITOPS_H_
 
 #include <asm/types.h>
+#include <asm/bitsperlong.h>
 #include <linux/compiler.h>
 
 #ifndef __WORDSIZE
 #define __WORDSIZE (__SIZEOF_LONG__ * 8)
 #endif
 
-#ifndef BITS_PER_LONG
-# define BITS_PER_LONG __WORDSIZE
-#endif
-
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
 #define BITS_PER_BYTE		8
-- 
2.4.6


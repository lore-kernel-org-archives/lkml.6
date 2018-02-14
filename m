Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032632AbeBNQer (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:34:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36090 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032583AbeBNQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:34:45 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        pasha.tatashin@oracle.com, m.mizuma@jp.fujitsu.com,
        akpm@linux-foundation.org, mhocko@suse.com, catalin.marinas@arm.com,
        takahiro.akashi@linaro.org, gi-oh.kim@profitbricks.com,
        heiko.carstens@de.ibm.com, baiyaowei@cmss.chinamobile.com,
        richard.weiyang@gmail.com, paul.burton@mips.com,
        miles.chen@mediatek.com, vbabka@suse.cz, mgorman@suse.de,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 0/1] initialize pages on demand during boot
Date: Wed, 14 Feb 2018 11:33:42 -0500
Message-Id: <20180214163343.21234-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=674
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces in mmots:
	mm-initialize-pages-on-demand-during-boot.patch
	mm-initialize-pages-on-demand-during-boot-fix.patch
	mm-initialize-pages-on-demand-during-boot-fix2.patch

It squashes the two fixes into the original patch, and also in:
deferred_grow_zone()

Replaces:
+	int nid = zone->node;
With:
+	int nid = zone_to_nid(zone);

To resolve !CONFIG_NUMA compiling issue that was reported by Sergey
Senozhatsky.

Pavel Tatashin (1):
  mm: initialize pages on demand during boot

 include/linux/memblock.h |  10 ---
 mm/memblock.c            |  23 -------
 mm/page_alloc.c          | 175 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 136 insertions(+), 72 deletions(-)

-- 
2.16.1

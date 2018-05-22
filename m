Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeEVDwz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:52:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59364 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeEVDwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:52:54 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, JBeulich@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v4 0/2] PVH GDT fixes
Date: Mon, 21 May 2018 23:54:43 -0400
Message-Id: <20180522035445.16911-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=401
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stack canary handling (in the first patch) and re-index PVH GDT to
make it explicit that the GDT PVH-specific

v4:
* Load %gs after base address is calculated
* Increase stack canary segment size to 48 bytes for long mode.

Boris Ostrovsky (2):
  xen/PVH: Set up GS segment for stack canary
  xen/PVH: Make GDT selectors PVH-specific

 arch/x86/xen/xen-pvh.S | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

-- 
2.9.3

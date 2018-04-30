Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeD3QVm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:21:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60046 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754868AbeD3QVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:21:40 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 0/4] PVH GDT fixes and cleanup
Date: Mon, 30 Apr 2018 12:23:35 -0400
Message-Id: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=688
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to new binutils release triggered the first bug.

Not sure if stack canary bug is related to the new tools as well
(haven't checked it with old tools, but they are really old, from
Fedora 13 days).

64-bit guests run fine even without adding the entry for GS but my
guess is that's because Xen toolstack sets cached portions of the
register to sane values and HW makes fewer checks in long mode.
Since those values are not part of the ABI I figured I should fix
it for both 32- and 64-bit mode.


Boris Ostrovsky (4):
  xen/PVH: Replace GDT_ENTRY with explicit constant
  xen/PVH: Use proper CS selector in long mode
  xen/PVH: Set up GS segment for stack canary
  xen/PVH: Remove reserved entry in PVH GDT

 arch/x86/xen/xen-pvh.S | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

-- 
2.9.3

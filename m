Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965147AbeEIUbV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 16:31:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935548AbeEIUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 16:31:17 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 0/2] PVH GDT fixes
Date: Wed,  9 May 2018 16:33:16 -0400
Message-Id: <20180509203318.2611-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=567
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stack canary handling (in the first patch) and re-index PVH GDT to
make it explicit that the GDT PVH-specific

v2:
* Dropped first patch as this was indeed issue with my tools
* Dropped second patch since the last patch should be sufficient
* Added real base address for stack canary segment

Boris Ostrovsky (2):
  xen/PVH: Set up GS segment for stack canary
  xen/PVH: Make GDT selectors PVH-specific

 arch/x86/xen/xen-pvh.S | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
2.9.3

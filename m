Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeEQOpH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:45:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbeEQOpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:45:05 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc: jgross@suse.com, JBeulich@suse.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v3 0/2] PVH GDT fixes
Date: Thu, 17 May 2018 10:47:21 -0400
Message-Id: <20180517144723.21585-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8895 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=429
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix stack canary handling (in the first patch) and re-index PVH GDT to
make it explicit that the GDT PVH-specific

v3:
- Use GS base MSR for 64-bit mode

Boris Ostrovsky (2):
  xen/PVH: Set up GS segment for stack canary
  xen/PVH: Make GDT selectors PVH-specific

 arch/x86/xen/xen-pvh.S | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

-- 
2.9.3

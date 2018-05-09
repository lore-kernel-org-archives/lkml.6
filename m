Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbeEIJaw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:30:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49356 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbeEIJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:30:49 -0400
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH IB/core 0/2] Do not form IB connections between limited partition members
Date: Wed,  9 May 2018 11:30:18 +0200
Message-Id: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=766
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Systems using IB partitions might be exposed to excessive pkey
violation traps which are sent to the OpenSM. This can be close to
a DoS attack, and in addition, the OpenSM logs are flooded with these
messages, hiding potential other log messages deemed important in
order to investigate important issues.

This series prohibit RDMA CM to establish connections between two
limited partition members. This avoids pkey violation traps stemming
from unicast messages to be sent to the OpenSM.

[If this patch series get accepted by the community, I ask if
the maintainer can update the reference to the first commit in the
second commit message with a correct 12 chars SHA]

Håkon Bugge (2):
  IB/core: A full pkey is required to match a limited one
  IB/cm: Send authentic pkey in REQ msg and check eligibility of the
    pkeys

 drivers/infiniband/core/cache.c | 32 +++++++++++++++++++++++++++-----
 drivers/infiniband/core/cm.c    | 39 ++++++++++++++++++++++++++++++++-------
 include/rdma/ib_cache.h         | 18 ++++++++++++++++++
 include/rdma/ib_cm.h            |  4 +++-
 4 files changed, 80 insertions(+), 13 deletions(-)

--
2.13.6

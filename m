Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeDYEbc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:31:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35788 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750945AbeDYEb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:31:28 -0400
From: <xswang@marvell.com>
To: <linux-ide@vger.kernel.org>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <oferh@marvell.com>, <dingwei@marvell.com>, <xigu@marvell.com>,
        <nadavh@marvell.com>, Evan Wang <xswang@marvell.com>
Subject: [PATCH 0/2] Allow drivers to override stop_engine
Date: Wed, 25 Apr 2018 12:27:12 +0800
Message-ID: <1524630434-5914-1-git-send-email-xswang@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_01:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=528 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804250038
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Wang <xswang@marvell.com>

There are some special operations needed when stop engine
for Marvell AHCI IP, and it maybe needed by other vendors,
so it is necessary to allow to override ahci_stop_engine()
when stop the engine like overriding start_engine.

Evan Wang (2):
  libahci: Allow drivers to override stop_engine
  ata: ahci: mvebu: override ahci_stop_engine for mvebu AHCI

 drivers/ata/ahci.c          |  6 ++---
 drivers/ata/ahci.h          |  7 ++++++
 drivers/ata/ahci_mvebu.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_qoriq.c    |  2 +-
 drivers/ata/ahci_xgene.c    |  4 ++--
 drivers/ata/libahci.c       | 20 +++++++++-------
 drivers/ata/sata_highbank.c |  2 +-
 7 files changed, 82 insertions(+), 15 deletions(-)

-- 
1.9.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965558AbeBPMBv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 07:01:51 -0500
Received: from mga18.intel.com ([134.134.136.126]:41591 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965036AbeBPMBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 07:01:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="201651805"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Potomski <michalx.potomski@intel.com>,
        Szymon Mielczarek <szymonx.mielczarek@intel.com>
Subject: [PATCH 0/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
Date: Fri, 16 Feb 2018 14:01:03 +0200
Message-Id: <1518782464-28847-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Michał Potomski has previously sent a patch for this, but this patch is
slightly different, based on the latest ufs-sysfs changes, it also takes
care to restore auto-hibernate during resume, and otherwise avoids updating
the register if the device is runtime suspended.  Also a default value of
150ms is set.


Adrian Hunter (1):
      scsi: ufs: Add support for Auto-Hibernate Idle Timer

 Documentation/ABI/testing/sysfs-driver-ufs | 15 ++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 77 ++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                  | 26 ++++++++++
 drivers/scsi/ufs/ufshcd.h                  |  3 ++
 drivers/scsi/ufs/ufshci.h                  |  7 +++
 5 files changed, 128 insertions(+)


Regards
Adrian

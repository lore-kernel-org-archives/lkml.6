Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbeCTNIh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:08:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:45632 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbeCTNIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:08:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="213218635"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Szymon Mielczarek <szymonx.mielczarek@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V3 0/1] scsi: ufs: Add support for Auto-Hibernate Idle Timer
Date: Tue, 20 Mar 2018 15:07:37 +0200
Message-Id: <1521551258-4027-1-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is V3, now re-based on top of patch "scsi: ufs: sysfs:reworking of the
rpm_lvl and spm_lvl entries".

Michał Potomski has previously sent a patch for Auto-Hibernate, but this
patch is slightly different, based on the latest ufs-sysfs changes, it also
takes care to restore auto-hibernate during resume, and otherwise avoids
updating the register if the device is runtime suspended.  Also a default
value of 150ms is set.


Changes in V3:

	Return -EOPNOTSUPP from auto_hibern8_show() if Auto-Hibernate
	is not supported.

Changes in V2:

	Re-based on top of (yet to be applied) patch "scsi: ufs: sysfs:
	reworking of the rpm_lvl and spm_lvl entries"


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

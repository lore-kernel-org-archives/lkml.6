Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965475AbeE2SSR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:18:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38237 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936888AbeE2SSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:18:12 -0400
X-Google-Smtp-Source: AB8JxZp5pmIf50F1cHkNk+ETbBaBBEiuq8nzYtfodMVu6yzQEQroyploVgfEXlSJoe0Q8j+2KiOEOg==
From: Evan Green <evgreen@chromium.org>
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 0/7] Enable UFS provisioning via Linux
Date: Tue, 29 May 2018 11:17:33 -0700
Message-Id: <20180529181740.195362-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables provisioning UFS devices using the existing sysfs
interface. This functionality is primarily useful along the assembly
line, but might also be useful for end users that receive devices that
aren't locked down.

Evan Green (7):
  scsi: ufs: Add Configuration Descriptor to sysfs
  scsi: ufs: Add config descriptor documentation
  scsi: ufs: Make sysfs attributes writable
  scsi: ufs: sysfs: Document attribute writability
  scsi: ufs: Refactor descriptor read for write
  scsi: ufs: Enable writing config descriptor
  scsi: ufs: Update config descriptor documentation

 Documentation/ABI/testing/sysfs-driver-ufs | 174 ++++++++++++++++++++---
 drivers/scsi/ufs/ufs-sysfs.c               | 217 ++++++++++++++++++++++++++---
 drivers/scsi/ufs/ufs.h                     |  29 ++++
 drivers/scsi/ufs/ufshcd.c                  |  89 ++++++++----
 drivers/scsi/ufs/ufshcd.h                  |  16 ++-
 5 files changed, 458 insertions(+), 67 deletions(-)

-- 
2.13.5

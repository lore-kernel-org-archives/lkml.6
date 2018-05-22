Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeEVIpg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:45:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751465AbeEVIpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:45:31 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: devel@linuxdriverproject.org
Cc: Dexuan Cui <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tools: hv: lsvmbus: convert to Python3
Date: Tue, 22 May 2018 10:45:27 +0200
Message-Id: <20180522084527.29254-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '2to3' tool to make lsvmbus work with both Python2 and Python3.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/hv/lsvmbus | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
index 353e56768df8..c184aac33d5c 100644
--- a/tools/hv/lsvmbus
+++ b/tools/hv/lsvmbus
@@ -17,7 +17,7 @@ if options.verbose is not None:
 
 vmbus_sys_path = '/sys/bus/vmbus/devices'
 if not os.path.isdir(vmbus_sys_path):
-	print "%s doesn't exist: exiting..." % vmbus_sys_path
+	print("%s doesn't exist: exiting..." % vmbus_sys_path)
 	exit(-1)
 
 vmbus_dev_dict = {
@@ -93,11 +93,11 @@ format2 = '%2s: Class_ID = %s - %s\n\tDevice_ID = %s\n\tSysfs path: %s\n%s'
 
 for d in vmbus_dev_list:
 	if verbose == 0:
-		print ('VMBUS ID ' + format0) % (d.vmbus_id, d.dev_desc)
+		print(('VMBUS ID ' + format0) % (d.vmbus_id, d.dev_desc))
 	elif verbose == 1:
-		print ('VMBUS ID ' + format1) %	\
-			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping)
+		print(('VMBUS ID ' + format1) %	\
+			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping))
 	else:
-		print ('VMBUS ID ' + format2) % \
+		print(('VMBUS ID ' + format2) % \
 			(d.vmbus_id, d.class_id, d.dev_desc, \
-			d.device_id, d.sysfs_path, d.chn_vp_mapping)
+			d.device_id, d.sysfs_path, d.chn_vp_mapping))
-- 
2.14.3

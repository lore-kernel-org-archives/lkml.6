Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbeEVH4o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:56:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:15400 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbeEVH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:56:12 -0400
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAgc09VbzR8stxx+XNVGnx9ZX3co74kFtJGu5gyLH"
X-RZG-CLASS-ID: mo00
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Cc: Olaf Hering <ohering@suse.de>, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        devel@linuxdriverproject.org (open list:Hyper-V CORE AND DRIVERS)
Subject: [PATCH v1] tools: hv: update lsvmbus to be compatible with python3
Date: Tue, 22 May 2018 09:43:51 +0200
Message-Id: <20180522074351.13346-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <ohering@suse.de>

Python3 changed the way how 'print' works.
Adjust the code to a syntax that is understood by python2 and python3.

Signed-off-by: Olaf Hering <ohering@suse.de>
---
 tools/hv/lsvmbus | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
index 353e56768df8..55e7374bade0 100644
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
+		print (('VMBUS ID ' + format1) %	\
+			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping))
 	else:
-		print ('VMBUS ID ' + format2) % \
+		print (('VMBUS ID ' + format2) % \
 			(d.vmbus_id, d.class_id, d.dev_desc, \
-			d.device_id, d.sysfs_path, d.chn_vp_mapping)
+			d.device_id, d.sysfs_path, d.chn_vp_mapping))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeFEUja (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:39:30 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:59502
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751950AbeFEUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:01 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 7/8] tools: hv: update lsvmbus to be compatible with python3
Date: Tue,  5 Jun 2018 13:37:55 -0700
Message-Id: <20180605203756.29809-7-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605203756.29809-1-kys@linuxonhyperv.com>
References: <20180605203536.29751-1-kys@linuxonhyperv.com>
 <20180605203756.29809-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfAorYw9lwdMbUVXOmopGsUwUamZra+Q4XhFqpP9g4t5ddAl/R+jK9CDPQXrqoL5es+SZs4RLxLp3Yv0v+R00LC5e5pL6FVDvfukvPH3MGYlaZv1yChEF
 QDQRTNX4vmg9hM78XbuGAdfiD7YVsX6sLn+YcKMVylUoSjukNnGbsp00/q6omoF7565hqFDAb+dJ12HDLc5iUPdZwPC09y+C7ufhK6qa+LLidBHFDyu4csGb
 ISGyGj/QLs/lGAMVO1XJ3NjZK9yfhG8r5+vaywOvBEKG2W93sk4lsc3CDKRGWYEmih3zVigqfKAeQebDHTJBfOXWVcNIbvlcyVs6x7xuEC8UHt46zQSSmgeT
 g4G8PF+yWeQyypRtZXkQsdVQbclLtg8gWZ/SkE19zowxvcaUEKoT5osaaeluT5PfCM4YCxCZVDlBjCwJ48DTjPvOhR0iMlsy6n11R05wArLC3hR0VnXdsHHO
 6arD+E2w8wnulutckFu6WPPbgUViX3IbelJPhNRJkFyRRDTkqteGOVbpOB91k4BiSESHeJpUuDoijYZw
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olaf Hering <olaf@aepfle.de>

Python3 changed the way how 'print' works.
Adjust the code to a syntax that is understood by python2 and python3.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Acked-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
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
-- 
2.17.1

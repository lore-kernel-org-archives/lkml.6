Return-Path: <dongsheng.wang@hxt-semitech.com>
X-Google-Smtp-Source: AIpwx4+TomDeTaTZ/d3/ZgpJ+D3mQwdqnMV/+dOaR4fPVJntHFMiU5Sjegmf5CKCUgV9tb6sgUqq
ARC-Seal: i=1; a=rsa-sha256; t=1522317692; cv=none;
        d=google.com; s=arc-20160816;
        b=ymtuAPZ3vRbnHORY4YCXDKQasQsl0435CGE6NBfcHIdTbBks0mo/8xibfP1KWIyb15
         o5RABMRA5ZNPY6t+HbGjt8CLNPf6iDOeFOI7we43znMlOgsvZB/P58aT7HA26FMQ+K0z
         +xT+fogS6VSMEs1zOzrnk/tuEvgNe5Wn267R9ISLivmZ+rgUgpDALwL0OjM3rjtn4y57
         6yjlO5b+uFjHGIm3Lc+ILlZ9ex6He2d9C8DiLsxxpDjb2hnkX7Co5CPJ+7oguYtq6Sz9
         2rL0VRkmlIb/TrgX9pNZ2LlMJ7IlfjOFAWpowJla3TmHbe/YECWy3YxzfavFcu0NcI40
         EcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=I5a7qvmd6QVKX2kaFBlxVwV88fVHi5xIBFcn5c/Tu7I=;
        b=JDymSJF28NFKnl3Pw86Y3eXhxfqoZxpPXd5bZ1ALD6La4aHscpOifcUVXHzjCI3NjN
         kwB1RI3VmL3V43Kwn18TsbBJnSlCdzo0bz+mwC//H6C12juNb1u6zcskOVECqQnIbPaY
         oO8of2PmRvb0GZvHsEpBXTJFzNnUotvtD939kugwwq/Bh9Ue4BYnfR6Yu7hok172I6Zs
         i8Yv9ZO/JjABQ9fyqMI9QG7idyQ9/fTsVOTP5pzZHMpfj/kQvymPFte9n4YGQyV2iUVo
         IBA9moFFzMMJLRi9GVgc699I2mIT0EGy6orO3aOAY5MoUvZXbm0PNqTFltUAeWRG/vO1
         uvfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dongsheng.wang@hxt-semitech.com designates 223.203.96.7 as permitted sender) smtp.mailfrom=dongsheng.wang@hxt-semitech.com
X-ASG-Debug-ID: 1522317690-093b7e77020c060001-y9GDlS
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
From: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To: <rjw@rjwysocki.net>, <lorenzo.pieralisi@arm.com>
CC: <gregkh@linuxfoundation.org>, <hanjun.guo@linaro.org>,
	<sudeep.holla@arm.com>, <yu.zheng@hxt-semitech.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wang Dongsheng
	<dongsheng.wang@hxt-semitech.com>
Subject: [RFC PATCH 1/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
Date: Thu, 29 Mar 2018 03:00:59 -0700
X-ASG-Orig-Subj: [RFC PATCH 1/2] driver core: add new dl device status DL_DEV_PROBE_FAILED
Message-ID: <1522317660-11080-2-git-send-email-dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1522317660-11080-1-git-send-email-dongsheng.wang@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.103]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1522317690
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6040 1.0000 0.7684
X-Barracuda-Spam-Score: 0.77
X-Barracuda-Spam-Status: No, SCORE=0.77 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49406
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596265787893408502?=
X-GMAIL-MSGID: =?utf-8?q?1596265797321275424?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently the initialization state of device is DL_DEV_NO_DRIVER.
The problem is, after probe failure the state will also be set to
DL_DEV_NO_DRIVER as well. And the device is not linked, it has no
supplier or consumer. Thus adding a new state to distinguish
probe failure and not-probed-yet.

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
---
 Documentation/driver-api/device_link.rst |  2 +-
 drivers/base/base.h                      |  2 +-
 drivers/base/core.c                      | 22 ++++++++++++++++++++--
 drivers/base/dd.c                        |  2 +-
 include/linux/device.h                   |  1 +
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index 70e328e..9054403 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -247,7 +247,7 @@ State machine
   :c:func:`device_links_unbind_consumers()`.)
 
 * If the probe fails, links to suppliers revert back to ``DL_STATE_AVAILABLE``.
-  (Call to :c:func:`device_links_no_driver()` from :c:func:`really_probe()`.)
+  (Call to :c:func:`device_links_probe_failed()` from :c:func:`really_probe()`.)
 
 * If the probe succeeds, links to suppliers progress to ``DL_STATE_ACTIVE``.
   (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_bound()`.)
diff --git a/drivers/base/base.h b/drivers/base/base.h
index d800de6..f9931d9 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -158,6 +158,6 @@ extern void device_links_read_unlock(int idx);
 extern int device_links_check_suppliers(struct device *dev);
 extern void device_links_driver_bound(struct device *dev);
 extern void device_links_driver_cleanup(struct device *dev);
-extern void device_links_no_driver(struct device *dev);
+extern void device_links_probe_failed(struct device *dev);
 extern bool device_links_busy(struct device *dev);
 extern void device_links_unbind_consumers(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5847364..31d4f68 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -452,10 +452,28 @@ static void __device_links_no_driver(struct device *dev)
 	dev->links.status = DL_DEV_NO_DRIVER;
 }
 
-void device_links_no_driver(struct device *dev)
+static void __device_links_probe_failed(struct device *dev)
+{
+	struct device_link *link, *ln;
+
+	list_for_each_entry_safe_reverse(link, ln, &dev->links.suppliers,
+					 c_node) {
+		if (link->flags & DL_FLAG_STATELESS)
+			continue;
+
+		if (link->flags & DL_FLAG_AUTOREMOVE)
+			__device_link_del(link);
+		else if (link->status != DL_STATE_SUPPLIER_UNBIND)
+			WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
+	}
+
+	dev->links.status = DL_DEV_PROBE_FAILED;
+}
+
+void device_links_probe_failed(struct device *dev)
 {
 	device_links_write_lock();
-	__device_links_no_driver(dev);
+	__device_links_probe_failed(dev);
 	device_links_write_unlock();
 }
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index de6fd09..90d57e0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -492,7 +492,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
 pinctrl_bind_failed:
-	device_links_no_driver(dev);
+	device_links_probe_failed(dev);
 	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
diff --git a/include/linux/device.h b/include/linux/device.h
index b093405..bf9630a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -794,6 +794,7 @@ struct device_link {
 enum dl_dev_state {
 	DL_DEV_NO_DRIVER = 0,
 	DL_DEV_PROBING,
+	DL_DEV_PROBE_FAILED,
 	DL_DEV_DRIVER_BOUND,
 	DL_DEV_UNBINDING,
 };
-- 
2.7.4

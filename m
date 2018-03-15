Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtq0ZB+HtSWBktkLZseG1YmSwbS6qPAo724dBwNyX4mJPyKS+y0z9qtkEttz0yE6hqfBfw6
ARC-Seal: i=1; a=rsa-sha256; t=1521133581; cv=none;
        d=google.com; s=arc-20160816;
        b=IomD2WqWXYaOhfwRkCI8g6i9qR46qwnyHWzfqzdenvGPLqWYmipdHhOF5HID4ux6BA
         cJ/sugFj2mS2EmOE/OLyrCPmhuseV78iBx+UNgnGD5DBEqVrWvUg9OUS+kjS3QsEqNLH
         chP1AA+GE0lIsQRv7R7yFIa8Oy0y2BNSY9e6huo0Y0efwDr/DJpdHXbBToErKOxq+7bc
         NIeObuulMFecuyCbrbWCqW9djk/ld1thq0rbR8o0w+jdLLd3WvFpOQqKNmjCOtFMstvQ
         eKt1gJF6ukAS0Xs+4sb1UuHjJePdvNkahA2ThooWCfrvTHJO/2boj6dWALCPvUaD/+Tn
         YoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=RwehDLVhyHMiwAomDERYYS+sM2cZ+effkHEjA0Thkx8=;
        b=K7ogNVPY80aj277qxFgnHBcfrJUWCTk/SXVKJX9aPfI7b7maCIvYQ0mC/W8Y/M55qZ
         Fey25V/KZQF7mMMIyJH8s5N19mNsgW/6n3EGSb5GtF9gi9t2T1+ffS1UPUsqDh2IvTzj
         ctyZb+1pEEgjVvVa0MY/ldJ+Zp1NV/JJY85irI/vdnT5THe93dhL1tkUE3MaIh5aXOc7
         IqaOoZaAof1q3IJW9gbHXPdQ1pYJm6P1yXLIzl5RFmDmgBTcz7ZuKXPNN7vAK9wv/fEo
         CIDWKqSUERIhBF5c8GgoHoenxTWwwakE33W2GuAJtQngrMybW2hdKd5Po4/Dlh9CcJ8A
         J2Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=l9rXM2yV;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.77 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=l9rXM2yV;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.77 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	arnd@arndb.de,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 5/6] bus: fsl-mc: add root dprc rescan attribute
Date: Thu, 15 Mar 2018 12:05:35 -0500
Message-Id: <40c147ebec14fd42c165d61cd060a5dc05b541aa.1521132659.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521132659.git.ioana.ciornei@nxp.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:300:ad::25) To DB6PR04MB3206.eurprd04.prod.outlook.com
 (2603:10a6:6:6::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ed05376-dd6d-4e3c-43af-08d58a97125f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:r+r9sCUOG8ZRasmBmKADgWD0LAAMhNdwrJw4+vFksR05TdseQvk+pXfdxNszpHSsxNlQpU51B7aZezNZZB5vlXfdUHXfIuiZVYR8nGVa/CSdHaSciE2a+D3G57x+O0Ll3F2KDs4Z4xz0erT6R4giDww4zFQgLJn8/6SmQl47+Sqtr/SSkOZKX8/OVXMaMMZM6rBGuTyTNEdRmaMyajPGhvZlCoHE9jupxA9scmxEpUs6LsJLZ07fzbQT5e9ix0Uy;25:cdllEVYkZimJMmUfLrU/nCjnXeSFQYaLaQmGpuOjIUI+ZFNIguG5mDYfQ/dSFIvyNgAFX+JFeDph0mZyR4P4cJM5P6O7sEY1ru8xYKUhzJCXapWht0+d+3iy1miV79LqY1zJXTXIkMWVPJBDK3JcR9feKVQ7VrT1QUwVVxYteKhaLzMQelw1B895WwY/wzUbEQ4WDdLHVFLUD0ukv2cPTD8WWrfvpk1GkCLJWFYMc4WhnxjZ9UT/5cfe8eLDA8wTlyoWgg9oD4hqtnivciUkjMIcIT1KszCzVFWM2VpqV41bJaSwoV29FBIC727KcP0G5brF0QdRbP13zkESB+z9Yg==;31:At5DUyvPLtlj7HjEH3BNJXmuCEfFqLOSbPtFVmTXCmoabXcju5SEMGen/TmSJC2lfSd69wSFWGSFb/06zMDvkJPdLTE1/sk2J7C2t1fdl3kNlzTmQRyz3oggddYZWxo0VeYgVFbxdr5ddLzCS/uuC8GwZzGEvj/NPR68COnKcMCYAAZA7ZAcNvsgOnDNVMrHFSa4muG+qPHHaaxF1t1TOx8J1x5vp1dU0PKTPGOYcMk=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:vJAXtdHU2BnK0Ok2PwhhytGnE0+kffIoQZSbScdDAdWB+p7P05TXvbtplZuFyBUw6U0rCdNs5Mcd7ApaeMrgADQq2WGvDe7KonfyQpIKMSebqcxv4lI66HTxh9Mv80bC3aw6K1J1jaU145sAdUMwiNCrhQk1GFBPFrCYTiGnEEeXatxqtFNT+jolvVZesMdPajm4PABjRFnVZl/RdONPtTL/f5zn8iJex6Y6g61w4+lCPohboUQfzwyI6HRp45VWZjXFfctd5sZntVOlx5XA7SLcVEyx/jTGeeukPEFUOZ/gvNojbmplLtYPo27JMKGV/ss2PAC0qhw4ff1jvFUDtZKuX0PVRj5BQvU3zGMu43T+mR/vSazzu9xTtgbCtwP9l+83WLL5TJYQBLHrpUXSaW9Yy9OkEtWiEDK5MG1O5uYU/08JOVHVyoX0T8PJYBgA42seFnunCpgncclagwiSL9+hhStHQPFuzA1zau61wJhBo0dwGOrpugUlYnoUQy7q;4:D7i6DoPzRPIr6aQpLu6xIJMXePvOgnL2VjlKMc+PoxplHTDJETXVozLutWhJFTQCNB37pmCUv62F2J5VkbO27Atu7RxHPt8VkgFO8SHowKA3/MiK0mQDQIJx2DTK42Wd/zpd/qdbekBOaXlgFIuTSw7s1o1INV/wMV8WPQZEi1wgw2UpKbGyUwtOb9pPPjcjDNgB4XauzOn+L6imHNEstdEpHtWDL9i6BWF60qcmAoWlE96WD7vu/8aubVaAjqP5YJJ4LjUwQjQCEIGCp10zxoM7dJPgU8rQLQNYttJzD1eKm+PTbsAyldWJwrwo2K5e
X-Microsoft-Antispam-PRVS: <DB6PR04MB3206FDED9136444C5D7533B5E0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(50944005)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(59450400001)(305945005)(6116002)(36756003)(118296001)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(76176011)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:e3gqEBRhQ+FEaEiCNhdufrvWaVJ3KxdMG6dk7KMIz?=
 =?us-ascii?Q?umOCncF5Lt/5I0EMBq/UF0b+gqpMQ0WGQEn22z3RKjdCIqnFSNBdS1CeqKcW?=
 =?us-ascii?Q?VWJQfg19ljxF+ATUAY0vPeDw1ErjtKaxufI3PtrucHvWCY8yUcZy2l9oEqru?=
 =?us-ascii?Q?dzIXGkSYYGnsIYkIVfQ0FmC017S3V8t0ZB2XfJCpCrffjpzpKkbWiWjZWXwu?=
 =?us-ascii?Q?wsGjGxaVMy1Jzxoid816SYW6LoGlFM2xAWDOkVAFma27dzAGpQHJGJZIlXI9?=
 =?us-ascii?Q?33URInG6LU3FmXy0LpEihhCEbib9O+Z3PkPevA37z4b4wBEpHIbFyTU3rwsj?=
 =?us-ascii?Q?xNK23yYMFTyNV6noHQFJXlJK5TVCE8ThH0OfG6+fyePSeGXgprA8vhV+zeJT?=
 =?us-ascii?Q?OdW0qwdJKe7Ls/2eOmyqf8SazadIam1L5wD5ORMdEqBxAWfFxSfuzUmTiPKa?=
 =?us-ascii?Q?k/G8PtLBAEUm7lVXw3h3jbe96Bz+Gvpa4Fn8LPX3tz5odt+rJtSa281Z+sr8?=
 =?us-ascii?Q?hxrCs/xrUlKJD9SkdjzjXbe0PeVRUwEYYKLeReCvK7LgMh5nwwWT04xyde8C?=
 =?us-ascii?Q?3j10DE5z8nT7mf3+GTkJi0ZZ5a2WiaxPV6OenEoGpylZc+h5X0+42kdpnV2O?=
 =?us-ascii?Q?l1L3xYpe31mn/7N/p7D14UHxhn1JN/1j1M67WX6T1/yNC0H89MefkwGKoOdL?=
 =?us-ascii?Q?d43Mi8grWtX4IA4pRDYElEY6vpPx83+Mfuv2ErPScfzwhoC1qN5EMFFHz9IQ?=
 =?us-ascii?Q?YRYmeVruJlWrXgcpy0KDEsAUQgBf1SNfBZAzijSNvolXEaqLgiBLoQGFsN2o?=
 =?us-ascii?Q?dAbpy4ghJHX6m7F7H5T1b6gz9PubypCHJw9DHpQnE2ERsZkyVur9UgZvjn9j?=
 =?us-ascii?Q?hgdPwH4im7V7osxszH5xyNTCbsWwNcN4ysJBqL6AIe0GF2nDNQIcxtHG2PqN?=
 =?us-ascii?Q?RMM7lFljyl6IGSxhWuZgd/xmD9QisHZSmDJcl5jepzjFOX8wJxUEkNAnkZle?=
 =?us-ascii?Q?c+2MT4/PTy90s0E3Q/zw3Q0Dke2jqnRBnBkDgbZ4aZAEEhzA//0ZEBIOTN2M?=
 =?us-ascii?Q?EwlTtIm0JeznP/7mMgxsq0XTVupV+04hRmfbbGDzW83EMMnfRFBiKE2eq8Qz?=
 =?us-ascii?Q?t1JxKn13/WrSMEwhagLS80cTOntCHB5kHXSOkS+vgt7t2sUs6Jr+by2wgCeO?=
 =?us-ascii?Q?fE8/QGF/nzy105ftdYmPCyVFSgznmk4bjTq?=
X-Microsoft-Antispam-Message-Info: 2VUH7RgNju2ZmHwUqAbK7ZfgMVbGvKxnMojOkVm59NEO7F5/kNrB1bVKUbyu/j7y7vNCrMiMQk4Vof+XuAsUNXRD/IqExw7UsQL+nuA5xdEeudGG8uiXlO6fNGKafje0NSZcG1tyBbeNEQMppx8fdpQRdeOXG1TYKUgD7Pkd867ItjNAl0uxuJhwhqQbVIZc
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:iruu6sl/JMwTTHCzXAuVDA9p27LqkwfWGsvi0WutbCFB9wVI5P5nNjYwJ1q7TQaTZVQsMMM0FnoAyFK5FnzhECFZmhm6VkqhX6UDmfZf6llQ1XWdkvyEM9ISOSpbBLoMloj8F5YmFPlnVTSEpDXOABVoLicfgQw1WuZH4y749Ad1vR0K052u2xJY086iFbi/XEX/ylxu5EuV9AphAQOClsPwTr+qy0rwTbgoCiYkK1/PaCoZ8Vs0DZ+qi7roNmDZ1ec2NgEaJ2HdPxmOv2Sb3TCTwyoXs+3mqVs8SX20tUAmW8nyTDKioDgLAmYOrHLw6qseCIh+shWlXkC1QoCxee+NmCuAANh39ViBx0+uzag=;5:VJy3lexFnk6YPYwlLI95CZUMlnz5rSiWannIZZNumqDWBYEFUEKTolgn/3iC9eQN3dTbKHRQYzeMTHK5qhJ0ctt4dh3Z/FHZTQtic5+8QAepFuHRAWMeMoimlwomm0jmPuFeKWpXYzdwuxvlHQo5GFAStPk5JhgMo1l/cnvsEj0=;24:pcp5sSzGZSaNsXrLl031dqbQ0JT39XGo6ZAtFlPGnQfWRxIVhTHKCYsEqd7HfAKaQAaKKGBGKfE8+hsZjf4p68tlnvmTQy0aNdL0wfvxaGY=;7:AuM3E/tTV6BbN5hMWe+3eG5NCmKJ8+7SKQuyFr/mag9Eo5sZwe4zM9PU8HSngBRrYHx1/d+5p4Rv1fRP+H1ktcLnvnGKEb95eZKcBMvIQ7OU5vuza3YNo+cmbHQKTtQACSmdFcT/dYFyBMvb5paAVVCQq8fAPhZDFbhLJql8UA/i5uSol+xL0rEcRxEiAzTN3uWPK86aOmmxBQkKc6mszVr0bZDNQqoJAawxBvh8X3Y6SNZNjrXcSrISETph0i0A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:17.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed05376-dd6d-4e3c-43af-08d58a97125f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024166993392217?=
X-GMAIL-MSGID: =?utf-8?q?1595024166993392217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce the rescan attribute as a device attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the root dprc only, e.g.
echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added proper documentation in /Documentation/ABI/
  - updated the MAINTAINERS file

 Documentation/ABI/stable/sysfs-bus-fsl-mc |  6 ++++++
 MAINTAINERS                               |  1 +
 drivers/bus/fsl-mc/dprc-driver.c          |  4 ++--
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 28 ++++++++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h       |  3 +++
 5 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
new file mode 100644
index 0000000..e530e8c
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -0,0 +1,6 @@
+What:		/sys/bus/fsl-mc/devices/dprc.*/rescan
+Date:		March. 2018
+KernelVersion:	4.16
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Root dprc rescan attribute
+Users:		Userspace drivers and management tools
diff --git a/MAINTAINERS b/MAINTAINERS
index 4f54765..1268b42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11464,6 +11464,7 @@ F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 F:	Documentation/networking/dpaa2/overview.rst
 F:	include/uapi/linux/fsl_mc.h
+F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 52c7e15..be80e3a 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -214,8 +214,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-			     unsigned int *total_irq_count)
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      unsigned int *total_irq_count)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 0ade415..9d02984 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -137,8 +137,36 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t rescan_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fsl_mc_device *root_mc_dev;
+	struct fsl_mc_bus *root_mc_bus;
+	unsigned long val;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		return -EINVAL;
+
+	root_mc_dev = to_fsl_mc_device(dev);
+	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val) {
+		mutex_lock(&root_mc_bus->scan_mutex);
+		dprc_scan_objects(root_mc_dev, NULL);
+		mutex_unlock(&root_mc_bus->scan_mutex);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_WO(rescan);
+
 static struct attribute *fsl_mc_dev_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_rescan.attr,
 	NULL,
 };
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 00cca7d..c1fc80e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -545,6 +545,9 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 void dprc_driver_exit(void);
 
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      unsigned int *total_irq_count);
+
 int __init fsl_mc_allocator_driver_init(void);
 
 void fsl_mc_allocator_driver_exit(void);
-- 
1.9.1

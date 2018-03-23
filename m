Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELsGuFNC93M+VGyx41T59UNV6AGf85rerXPxz/d7pUj7NasRxlZpJ72FjuRsUtgpUEoLzEm+
ARC-Seal: i=1; a=rsa-sha256; t=1521819592; cv=none;
        d=google.com; s=arc-20160816;
        b=pNxJimCexu+y4tbzgsxJQoIq8wvd/mj/xGFbMo5jMkTwVJDVpU6jhlx51KPpWWVgPo
         EtXiuucjNnWn8bqSHrV8zpeowYnuN+ejnoVkF2RAZJt7f4rC8R8FjB2XvxuZ4y9HR73+
         95DeGucSrq0xS1AbPbrkoQgd1SGqoVV/P2McAk2O2qFwnu/inwu9PxspGaFurnGOQQJw
         MwW/RVWegdIponwyGdmMEpJXHrKRVJYMoJoZwQufRixfxncMVLmC//89Zd0PlnvgaHB9
         IAm/73/o5F27KPEbGuOM+fNFNxtMcqmUAPHM5ES8JVJtxJk5Jezv7s3f2Lw6n2lWYXOc
         0r0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=uHBo6eIFKlCv74r6Nx/6sXebOvjlN2x6+Mi0EDYwO4c=;
        b=UIHPnF1BTeFBQi6bv31SCtEj2kOZHTPbT+aw5NHMAvVcTZU1vEKE7SpVBf6YLieYZy
         BselmSuJCmonVNTPsgdthCEs4Vqk0Q603fXbp3UOLB+PWrYWjh6alQIWZ+L60v8auvv/
         8g6pGtDDzT6lOkoFAvx8TqoYQEHB8HOqwu7DQltjzqjWHQeGgqtS4yZD+7jdlLu5TldS
         phpVp9GRvowxnuJTq+mTVs8ZxWRV3whh4nvomJ6UxGsC9Bs1BtJTeimzLbShH0hDt3KZ
         anpEAFsNlsU/5Uhe1BQNuhalqY8s0WU/mKBNrzeqPi/K1Kl5UIe+Vsm3q/af3JQrQxL6
         kS1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=SjGxhvuh;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.77 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=SjGxhvuh;
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
	arnd@arndb.de,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 3/4] bus: fsl-mc: add root dprc rescan attribute
Date: Fri, 23 Mar 2018 10:38:57 -0500
Message-Id: <7d4c4463871d4129c6c062265d83d886432af6aa.1521818403.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521818402.git.ioana.ciornei@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To VI1PR04MB3216.eurprd04.prod.outlook.com
 (2603:10a6:802:6::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab464a6f-5bab-41b4-14df-08d590d44fca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;3:I/gpyQhlrGA5miylojJ+YLYPYsLFSXAXYceZ7EECPyA47436y8E+DDdVtnWbpLEMYDFHDDuKCDKDQR1UGcCcFtTVMP2ztfqzD6fcLp9eVpOjTPfeMk30Ags3zKNtczIsq0SMOCK216Tc+o6zBpNPLam4voze5HsaYNTWZHmtv1enkKRZHymWGRy4M13NBil3yuw2L0Y96S5JocUwxd5fqOOeLv1hoolXZfu1+IhQu50FaXvX8ZUUXOWRJuF0DVP/;25:0/nNIzSBRjKmpNDIw/DXyAx/mVCX+QM+1dN7C5rY7gyrWNWdRXQCRNYDdSguzsnJ/l8E9fiXYj4G+SBlUT9NzLeo/SkhZErHr2yV+KcZHk8gsE19CyZp9zeko5x2ITY+DTyDXonFdtnkRVaPcQE2l51oySD0M5glUQWNVutXNoBkeVxHwEVHMBMcoVgvNoCx8O48CxqDAH6maNjyeUjKNXeUOiS7Tb5pJ30Ms1n2IPziccgN+cfAIt27xjXpu3FpwXTHtOm6iTuCujOeNIRpin+Laq8mYj6sF6LPCZzbz3Up3upvPfK0bMCHqC0N5ARYBuKuZwNotBMh4hfMrNSCoA==;31:9BsPdNOE882MU9Vg90LArvVhzZO5p4q1RhY88b+SgaQeywQBkpWea5CWzdYUs78yhhyJRCnW9bOzsSLa5QxMGJHLHXkFbFSCVLITly4o+t4R68SfijX9j4nVg4UlnQ+4QiO8aBvH98YlOGzhkBVANj2JdVxmb7M3J+y2DFyRfgxmDVj4u62KfT2Td/fUmJwLq7qXXgLyPLCpsI2+20pgBX8kJn/gcp34K/0jID1QIuk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;20:TwKipm6KtWLzRLKDlpWuQ/PbHDTwZ1T/Qt7qRoJn2SZqTj+0xHN5+4FQV4WEL/m5yBjfhq53Riu9ff33HT3U8DpA6eRXaNFnMCa85XzStyOERDkcG9oYyxkxfWvtcPxBqNASKlZh/m279/5Plpnn6ff+ChiziXnIcy0W/CTE3+L0W3Ix8MRMTchqWrxM9+lL/8w6/93xxsjwhZZLRHaZe2d6RHZCl4ZM4GnbOn/A8Zjmpf5cL+e9iF8NlVt0/SjciOFKuVmbUpAbd3PeBm2GSnumKDn3/YZyMUfh1Cf0/Ae5w1Y5rpY3WLVcD7RHUWEdcLEJTuETxM3gUdKP/kOykP4A2mE1Ffwk/DisOewsjsBEkyxRfoDFpnRUJd75a8azRxwC99FEOtrvjfCgc/VStOboq/k3QzPDz212PNnmZS5u+b3q7VMwE/0fwV4hJc9/TXHh7rG8XWrSoOY2CcdG2p5zRLR+ohoILvJ4mQiZZDcaa+R4rNDOcS1D5WMqMF8n;4:24QS/7Tt2vhG6PZI8L26am6ZTcNDX91VKj2/GTvMrgKzcgrxrsI4olwkrqVuEFCNVKlimz814Dw5bbzESeliabNgUSstCP7AOb0vZncG0Ka4IrJs8XIWCd2bWGTH5iXMDwmKLzsnsMyyBAxB+dHA3qci1nWE88CoKT4tW0qEjeHgHewtcQXcMDkAfu+activChv0dYjzxa0Wg92XW67w/+kVnXfhQJha6wrO/i4fsQxHReCr/lL/RyN5Kbt9HDjFwCvGL3xK5nOPcVpCVEsWiZmA0NQTLVkBoIpD0gnMgTwYvUAxFDfV2ZTgCU+qxvTk
X-Microsoft-Antispam-PRVS: <VI1PR04MB3216D19D8EB2A2E7569A015AE0A80@VI1PR04MB3216.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(50944005)(316002)(446003)(47776003)(66066001)(105586002)(59450400001)(5660300001)(16586007)(53936002)(6506007)(386003)(97736004)(86362001)(76176011)(305945005)(7736002)(6512007)(6486002)(3846002)(50226002)(81166006)(6116002)(16526019)(8936002)(50466002)(81156014)(478600001)(8676002)(6666003)(6636002)(118296001)(106356001)(39060400002)(48376002)(26005)(36756003)(25786009)(51416003)(68736007)(4326008)(52116002)(2906002)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3216;23:ClpJNxlKXpH7bWxTZl3mAlP9chm0Mb5ZXuQ6R8BTS?=
 =?us-ascii?Q?NHAKKfdpISHoNDgtgxYRCEDFW58OjyD+zGKnCq15vkOeKOcQgbShPSdbsgyd?=
 =?us-ascii?Q?FI8Rx1SkK0XiePCMEvU9hsrl7AYZtLCbmxHBXTEkRIjqF2lcgbrlPBPGwxhH?=
 =?us-ascii?Q?df51lY+nh5/hJDye93Mrt/W/86a638kUB7oOFOio6SI7ftXt47UmvmiuwjFB?=
 =?us-ascii?Q?QMYKtvyxIp7l4YZurS8gwARddbQiNE5G58B20LFKhglmTLCzpHMemAWEnTdL?=
 =?us-ascii?Q?rjJ3enML7IVNNXu/9BtL4i4ecEOKCbh9OAdOv/6HKMW+TeH3aWHioagt1d3T?=
 =?us-ascii?Q?Ne5QLE5NpmVD4gX5ymsmXdn2SOmZxEdE4WtIkxcacpUN+xWv6Jo4xJfyIAwF?=
 =?us-ascii?Q?vjICnqDIHTWNNkdgvVvYRSWja06bvFyDC6JeqkFpVyon3QIiL+K82p+Gyr8Y?=
 =?us-ascii?Q?qPHCsYKUQxugMKfEf/fKbMujksceiOfQOwpQwFZFWPWlzbdnxUzBBaUKvwBh?=
 =?us-ascii?Q?TVJHLK1GL1Iobm+abWBAetfzXVl9leWLRgCvVhK05sx9elxgSLePpgS+JPEH?=
 =?us-ascii?Q?WTivh9MUajUsBMKPu8YmSI65vYbikLvvM4UF76Ws5KfpV4eTaEXwvLoPE42A?=
 =?us-ascii?Q?mark0PPpMYfMP3POOxdHairT3IIYLCR1Ajw8za9T23IfFCYo4KndMFoh2W3E?=
 =?us-ascii?Q?E73rJsQtvF1S07AD2f/P0lopQorlEO0Iowhm2u+ihEpu07AoVw1l9Mw9wDBk?=
 =?us-ascii?Q?Ob2quapiXaI8ZAg5mQlm2t3ehwPz/BOc2YSJb301Fj+Ow8FFHuqoIES6EEen?=
 =?us-ascii?Q?lM4ZFND63rkxnYmk1bA8HvbeLKY1SYeETd9hDIWlfXru9GVfkeokq5AXdKcS?=
 =?us-ascii?Q?GuYqXtBpIBdWn7v4AmwCLTVmwL5OUUMwe92uMVGhyvJPxDbCGMMnaVwLwXUe?=
 =?us-ascii?Q?ioxneDcPlqjPPNwVFEvpVxrYvDGUzMt2yv2eaOFWc9bMzur1293IYlMgpnUS?=
 =?us-ascii?Q?70nD7z3/Hcew/8gvb89nU3leC3a4L8DXBvLSdf+liGUd8KN0awbn+DCQhnxi?=
 =?us-ascii?Q?6qUOBQPFzMk3xoQXZgJiQ1G/9jc+gi/gokFiiBA7a1oYxYUYeVng1U2Wu/m/?=
 =?us-ascii?Q?dWI/3QoNjVUDqQRGGijBEcd5DWKkEfL0EUmhRcHKOqmGgAh0ml4+B3lKSIfb?=
 =?us-ascii?Q?CFUxHGwcZ9bnQnote9Lbqrpu7GE4O1Vq8lQ?=
X-Microsoft-Antispam-Message-Info: WuKrHjZEd1ibUmc0nPuRkUzodeW6URaYR+2PMlqlQ27wTgBbfvptC1Jys9PkXJep7xkJHx8iAKHTHxwgdrIJaajiYRV+RWRhfpejt7HY7++i0X4ZHCcvM14W7XDYnou+Tst2jkvGcLEVdftr/EKZ89v8ISSvhj+AFj6I0OxL+Qr79Ob09BO1PF2CNjlLEmkV
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;6:o8ftoB6uNOWfBfPkkD1CZ4vKj8e8JTZr6DJiHstcMuXe5f0GwPvN4Bi6ZtZFH7S32hY7yzfa7q2WyLLuxq7PTDHlw9e0oWUPHro4zT/cC8WmDN/lpESxDm3L4WV3Rq/wqFJThEe24K2O3nUZsE/c5vzaGT7n67FLxLcF4999C1fXIHmFf8ZjBkKxyxleFfGvFONWpabyIpaFEf7mb4FV4SRpWBOfm/RPDOQSd+1UdwTlbXwtT6VYh6aGbSccJnqxV+9DaKhBDqgcF/+Owk9ZF3W6I7yKWZspDdiDBP8ngTbnCLXlFGGLPMiDyObl5EGhCtnHPHO+aDMfGVZusnn5S4QV9GJpYzeSJ6GLgcY4Fl4=;5:RgqF/LiHrbXdCY1FsTIzBGQ7Fv1+9HiPirfAgIi7HfpiJeOLjchr72WUAwzadVUebHNh8AZzFFPXtToczV4njEtF5I3nkzEggkmK59B8BNlEGVCnN9bON+olF/xikFKxTYURKWCxFtw9Of9BFeYgPn3k6XCV56E/DDDHBLUhlMw=;24:owMdv1UlczpqbNiSrt97ka4XWrq1UgeDe4Xc+0Wq8v3IY/BWW8nL6B+14pEsL+aTAJSb9sgOyJ094aIu2HmiKcD1OTsSjxEjAhyyiOCDXZw=;7:rgkQTPYlfNgfyWuFRPPDb3XtDJpmXvDLSMqQkxW4YzbU8DsMj92tM1sOcPbRJb4s7dJEDG5ngdWj0EgQL6Ug+jc0QC3xfXpalMPxA04yupRomeerUjq8/i3Nc+UPxiEZq3bnVSA7Mal7tKIE1hMKRXtVL8i/Ep0pwfDgkWfKkYTuIgkecWmvVh8QSPHQ2LF/YbWQJeeUJFLKu8PjrpvggPFrulHVLCID0hgBDc7lh0a97FVR3LwkeCw5c7FEvx3P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:39:46.3590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab464a6f-5bab-41b4-14df-08d590d44fca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743500993999304?=
X-GMAIL-MSGID: =?utf-8?q?1595743500993999304?=
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
Changes in v3:
  - no change

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
index 861cf1d..e179dc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11486,6 +11486,7 @@ F:	drivers/bus/fsl-mc/
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

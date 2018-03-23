Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtRbnAB5Jf1v93G4z0m69qxxiie1/BedwdrgOGC9O+sUq3CAilUIvY48DPw1rWxwdebo0+X
ARC-Seal: i=1; a=rsa-sha256; t=1521819596; cv=none;
        d=google.com; s=arc-20160816;
        b=0ixJNWvCtygj9mpRX7GdNg3T/aUvgTZJgUKpROSTvhfFYk9a3gUU6OyIDKZXtNzSJn
         0F6MrUQS2FGgNcuZktd3WprRzcHnq256ZTNpdF9BZXKGTQaBoQcpKHct1x6fEn023N4G
         gi5QRgA5jbycK+eAUzyHWaqMD0loULnYcwOfSxdpKsVQpiF2ybTI94CV2E6lOIqiabGd
         cjSN8OUuzEt54jbQuNUkx8/BKxWVFrDGJnafqlUJ7tTyuKH++MRb+iXHqZA2LkVlpZvy
         lWPS52ceoOYW1yz1D3bbOXSYikVjepOm6inQcxjJst0YpN3Oj3J6DU+5dOEAXdLlBZbv
         QxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zUia7gs0C/zhzZewWyMXczTMefXoR+/VFikrW8PoHJk=;
        b=ixGC4C9tvEa61Run4628qWeM8Zlby7dX5KoI/Qf3tDUZXNnO4gmXLCoD4OE8xjVhL7
         iO3d8RvVedDbIkad7fGLQSK+pv7QMOPt3BJPpl7eoi5oC5QOzZoT2YrnK9dsVIwqcxRJ
         jvElZfyK2GlN52XnG4XTkAribxFiMS8JrV99vu+80VMW+BZ/70qBr2dVVQ3al6+++JaW
         325FT1KkHgzbcPlgX7ss+CsJotwoKeCPDRtE3qy5sfpZ1YCCreN8JiVtSHfIc+wABvhD
         uhuXIXkFftaKvNTvHbci2KZ1jvLUuQA3NePmZ/ToaJfRjyf6CtL9TWbILc6hZd4y6tkL
         ywXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=MXJ1iT9o;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.45 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=MXJ1iT9o;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.45 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
Subject: [PATCH v3 4/4] bus: fsl-mc: add bus rescan attribute
Date: Fri, 23 Mar 2018 10:38:58 -0500
Message-Id: <2ea1db0e7d43255f8d13f6c3cb4ce3d12df89eef.1521818403.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a338e27-c00d-4c2f-fc20-08d590d451f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;3:qC4Ytrf0JekeOHfacGssoQ63wO7GZdYMB7QkTu+/AO2MUImWltXa0+rgBqslJrHpIb3kRM+qXnu3EFF8BrPnuB6ZlmahXujwE6/f+IlUN8kUUCyelTVdKHpodsxwQtNWcyvWgxIsyW+oHcfcNucgs6xR3eox7nyuW//07Jx6WA9DtKTXIAG0n82Fj2rf46Mw4h4jMcjhRIFT9wgJEe3ro0zQeCLSrz0jZy1UYcE/p435O84ZY9Nb4Gv1P9roWVpS;25:koGeOnLpMnBxE/m6ldRQ25iTDyvrrmGMccTkv76wpgjsV1j6Wv4At8z00Kcl26Bio96/fduYUcKgJprF/MIhwLjpEb1GJuoD5w2L59QFFR0Hc3BbDaMAvDxj7btRQNfQupv1JcAFT3E5N5m159XiN/FvKicvKkcU1txjqZNS+9zOhgngPcogRne4/8tzMEyGyq0X5dB3UqoeoRnKKNVl2grQf4IZmHm/v0U+11q8ivyQ4AYmDs9Kcvd0pideT80wBTVStHMW43xdN/bz7AAxQGpFV3ZHVV/rE5g3CeKB3pmkLq9vaaG9i8mppHDtLYbvzXLpcdDhuqnZKnpMkyYqRA==;31:IcZ1XfO32ZBbaDo7zfCjwichlO0QFOOfR/jgiM8EMCGiedMKdMqasdG6Q4iGmgkBZTc1hdQ9Xrckm997D8ym+/1ZTX37ey8G24BMTA97k+oEj5cLSiW3ByjQFbAy7kggYZWuZe3Pxc67HNq93+4F1cUpubZ6s3UWjfd6SoB4NDms87H4gXfqEbE0eXfpWxsCARC/LNyqT7ffpsRJWsimi5nmf6ZAZ+gd+7/ilvjzfuU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;20:+JP0C8kB6GaVe7U8Jx79VT0blNuDvs2mxZY+jGTvX1+jCudvGYWIYpdAzWuB0G4nvHY3GBp40TPPE89LGOnVY8+WfUM5+BfXgHddKwoefMNqMy54sKlpwcamzk4QbHtJ7si6CejzwTsa8Uams7BUFsUqTzJLxCkMvBNPGOLnTZYnmCbNnmzjrLNVHV+Da65GG3HqR1QaPCPRETNhPRTwHSwo0MfwBcaHkNhjzoySsEbIbVFWmkjdMJWcEBn7XQPNxmrZcpDbXb+mOqoNCn8zYFWj2Ml/7QDVVNEwIOQm8cw9ZON+TGK9/uqytyUGpAudxHLSY16YvU4FzFT4A9PSMIbXF1y6K4z+GBgZoK+RpJaItnXd1qRLBezy4k5j1noxh8H91oGZe2ZF9xW6Wgd6vPPETYL899sYAaeapimPGSfygYgGTGIeMF96FLimhzsBgSmz3w/YK4C9MIosuMUAUSWDBcxnHo5VfZ8p+Zp6fh4dOXjWgM3oRu86rLCF12zh;4:Ndhsf1Zv996VpTuO9mxXlxOdFwhbrIj9sukt0qJffyTR8tisAPDMKkbtRWROb0GRDXXfEvHhc7N6c5SxxTy8ZA8m5/g3hzKLRPsDiweDS1UtifD9FPd/N9gJXJaOXvFw1TKmicl8g/ZbCZRHEEuDvxDmZ/bSiCodtwT7rB+f6S62w0cvQ9oshwq4lczSY/4qHwfMhxl74EiKPhFR8e5bvWrOgW7OGsoJukLd1OFkM6JxdSBPYiEoaajl9hTzGQjwVEgvDvDX9CzMVnlPaWUEfu0plKGZRyXteKBcIMueYqn0rXTltJYgRi5SwzENlbuM
X-Microsoft-Antispam-PRVS: <VI1PR04MB3216F74C7ECA931ADBC62191E0A80@VI1PR04MB3216.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(50944005)(316002)(446003)(47776003)(66066001)(105586002)(59450400001)(5660300001)(16586007)(53936002)(6506007)(386003)(97736004)(86362001)(76176011)(305945005)(7736002)(6512007)(6486002)(3846002)(50226002)(81166006)(6116002)(16526019)(8936002)(50466002)(81156014)(478600001)(8676002)(6636002)(118296001)(106356001)(39060400002)(48376002)(26005)(36756003)(25786009)(51416003)(68736007)(4326008)(52116002)(2906002)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3216;23:zqhYoTLNguH8k8pZNfL7X4D4OfmC5xiLjR2WH+rUd?=
 =?us-ascii?Q?10dw3pCI6VcAR8ZFrizUDHvDGsHoAsDEvFBnCQkFUsJtBz+PjJvzKfHLfxc3?=
 =?us-ascii?Q?dmTgQ7KYaP9JBcOF77ab2R3egzqh61uQd+GAsg5+t+ZO6YKHwAGq7CTJV99R?=
 =?us-ascii?Q?88P0hyuxPLAZ5wafTyw9lAAGTNjZa1eZYPSnFtYmvTjC4tXnNGOBk2QcZVCg?=
 =?us-ascii?Q?ybM4I23rxm40jPCfSekLEmxBhahPz69HLB6dF6kzjGgCCKKEQKeR8CCo6zMC?=
 =?us-ascii?Q?6zeqf0/fvSrc45jadUIr+w/k2XrVEpxnbe99Dz/RbdP2SZKyxW3YFnViNkX8?=
 =?us-ascii?Q?KAjrSxvxvr+TEInp6Rygb1cnz6ddUj9vqbA3OlgipjtpL/V3dmWQw1rFfj13?=
 =?us-ascii?Q?5BMiX+hxQZCQinGYKFD3wRPsTflU7M3xYy5dUTFpx5TOCMbI8e1ewi3rtWDq?=
 =?us-ascii?Q?ZMG2qhXUlmzwcCIoVybq2zioRY2vlaejjg6EiQnVqX6uD+FSgeMuVtMyxl5F?=
 =?us-ascii?Q?bH7rDSrNpiE7rLJAwdBOT3KtrAZtYQ0JSlEVvo2NXEdTrQOzhxj8fGr7v+uV?=
 =?us-ascii?Q?PZlglPwrzT7JLxmSWmQw8t7FT7puYvhDvbM1O8BDK/fjRJLks/DGKmH+/Pyk?=
 =?us-ascii?Q?fqFiCFZ/rhKa/smbZ6RncLa7gT0eCBaQ/SIzUWZS4uTmQZp32Zc/wPF8XfNb?=
 =?us-ascii?Q?D8KzXO6TEfp2+kWdXe2xtIVgBcUSA/cTr7KYCueliuDXSZSKDRgcSPicr3VD?=
 =?us-ascii?Q?tXpSWojO9/U/P0ltd+QXPzfhAlvwUWk2R7UfSGl/pNnxYtY6/jQA6Fwer2zt?=
 =?us-ascii?Q?RKd76TK+7RfP41SIIjJuOwtJkhvQqAZ2iFnKf3ehBnQ/W2qPsDLnQeGNXyGK?=
 =?us-ascii?Q?gliQ9Jmyp3UPiURSW7WIdhzKppI7w0vfN6tYVB1v0LR9ZnnWKRXwkom5JRFs?=
 =?us-ascii?Q?1jUF54GJN+MHtQbqvVruxlg9wv2i6irPyGd5hQeihiWczPOLcHqIQEe0L0qD?=
 =?us-ascii?Q?3MN1PonBaj0LsBstLgfDPyR3PG1mOJOVObivlPLPzlDwWT4Wrqop76iTTbvE?=
 =?us-ascii?Q?GwfmKVF5Zysa0Pl+SMWz3RVb6qfj3VpfQad8H73qWl+0X3i5E3OYd6wjp0Nl?=
 =?us-ascii?Q?Z0MtFsxiBfsJZk5iH2ns2v+jv60FJT7QXv973I3cW+BND+dSI/edOAVadhMZ?=
 =?us-ascii?Q?uza0pQYIXx3F+Y=3D?=
X-Microsoft-Antispam-Message-Info: u5CtWVpmsrNJ7+0Ux0MaZ316uMWB+1+6D+VVuc99qKOXCgfVIMjQ5P0+V35SaNlnkrFggeftO8Cu9wsGqJzG1nksn5tUSegsuJ0dtzEINVshRHlUfu6yVEc+ZqwjSabtGNez31taCoWv77LLnv1ZNrEjjj1P41jHUUC6gseNLW7UvBmxu3FinbPEPo9RSlhC
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;6:E5R3X9zbHT5NIFikMHS0Ke2YDWjO/kr3NwlFUO6NTaObJkVVgYd5ehly/6xMHFenWwKqiHM+15EkM7Z2eiLM+hhgAJFSbSnBqA4Y1bCQf/ehReWZ4o7QRCMn1wFNWErgGvOSBdw2arp9uqtH6HqCRwGR3V686Q/FVI0dQIQgdoF2n/up/PsugqDayBzDDv/X1J+jblMCO+wQmNLU+H6ts2cYys+XluT4zVQ7bSDYRSLzAFkxfDLTkzjtwotM1IrKJr4RJb/gq2sj/pwqJnqLHjChcevZ4hUKRK6ePHt9vSo131LRfevr0Af71EHX0F5hbZsPWAD8ov1aT3R3tzrvjIuUaFyMH7S+WSxJk5Ru6d4=;5:3kwDHxxhqJw6TTOY8EJXaJfsEcP6xdJjJnZz4mFnTGyFgZkP9x0Gsq/MzQ4aFdAlJXvW2vvyN9OjOqpoXHvntzMbVxRij6stdb6qbEibVxTBm4t9ffDuTRnTaR70YklWpErhj0ZVSygsBbih8bdsJT1d5WmFSlwxJ7pHNfYX3xI=;24:ptJ9Ts3AIGD+3tieDHfSGQbXwBiYJy00DGoc+GURwF//Bkq4FQs2Nmf2bRO6RxNF8tAeYX6rTtmoWsltx3gAtBJ4kfKWYDKYDjKj0OlMRFY=;7:qDifmSqtGafDYzdGpkoHNbY/C1JvgSXrlqYtBVYyAravuGzxfdcsKCar21gOsnr0J2/Ms55gEBYBI+ua58bl5I6GpDuV5oRQemGC6PxjpXV9J7MOIVpuXeeB0TwDKBgamR6DvNEGChptfzQkEPpMikPrO4Staf3ziEeUul949UZF/Bo6cF0yUa8ZIxdKCdHXxOYGjMsOvCjCDSBACUjLp4Wu0BGF2OWSU57ErjqQSaR7Yn9VxjSqT0svAUZEXZ8Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:39:50.0153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a338e27-c00d-4c2f-fc20-08d590d451f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743505535969149?=
X-GMAIL-MSGID: =?utf-8?q?1595743505535969149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce the rescan attribute as a bus attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the fsl-mc bus, e.g.,
echo 1 > /sys/bus/fsl-mc/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added proper documentation in /Documentation/ABI/
  - updated the MAINTAINERS file
Changes in v3:
  - no change

 Documentation/ABI/stable/sysfs-bus-fsl-mc |  7 +++++
 drivers/bus/fsl-mc/fsl-mc-bus.c           | 48 +++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-fsl-mc b/Documentation/ABI/stable/sysfs-bus-fsl-mc
index e530e8c..0663fbd 100644
--- a/Documentation/ABI/stable/sysfs-bus-fsl-mc
+++ b/Documentation/ABI/stable/sysfs-bus-fsl-mc
@@ -4,3 +4,10 @@ KernelVersion:	4.16
 Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
 Description:	Root dprc rescan attribute
 Users:		Userspace drivers and management tools
+
+What:		/sys/bus/fsl-mc/rescan
+Date:		March. 2018
+KernelVersion:	4.16
+Contact:	Ioana Ciornei <ioana.ciornei@nxp.com>
+Description:	Bus rescan attribute
+Users:		Userspace drivers and management tools
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 9d02984..80010d1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -172,11 +172,59 @@ static ssize_t rescan_store(struct device *dev,
 
 ATTRIBUTE_GROUPS(fsl_mc_dev);
 
+static int scan_fsl_mc_bus(struct device *dev, void *data)
+{
+	struct fsl_mc_device *root_mc_dev;
+	struct fsl_mc_bus *root_mc_bus;
+
+	if (!fsl_mc_is_root_dprc(dev))
+		goto exit;
+
+	root_mc_dev = to_fsl_mc_device(dev);
+	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
+	mutex_lock(&root_mc_bus->scan_mutex);
+	dprc_scan_objects(root_mc_dev, NULL);
+	mutex_unlock(&root_mc_bus->scan_mutex);
+
+exit:
+	return 0;
+}
+
+static ssize_t bus_rescan_store(struct bus_type *bus,
+				const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -EINVAL;
+
+	if (val)
+		bus_for_each_dev(bus, NULL, NULL, scan_fsl_mc_bus);
+
+	return count;
+}
+static BUS_ATTR(rescan, 0220, NULL, bus_rescan_store);
+
+static struct attribute *fsl_mc_bus_attrs[] = {
+	&bus_attr_rescan.attr,
+	NULL,
+};
+
+static const struct attribute_group fsl_mc_bus_group = {
+	.attrs = fsl_mc_bus_attrs,
+};
+
+static const struct attribute_group *fsl_mc_bus_groups[] = {
+	&fsl_mc_bus_group,
+	NULL,
+};
+
 struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
 	.dev_groups = fsl_mc_dev_groups,
+	.bus_groups = fsl_mc_bus_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
 
-- 
1.9.1

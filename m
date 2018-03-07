Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELuQMK2ljXeNUXNDEHbPITSXYKsjJBHY1kSFGQAYfbodgRztV5wvi0eYgW+Al04wUcKovgAc
ARC-Seal: i=1; a=rsa-sha256; t=1520441593; cv=none;
        d=google.com; s=arc-20160816;
        b=RZDkukeA5nDqo6utB/nq2CeVHeEYdwmWa8isNbBaDX8zUXkbs+AbkunfgBkJeJD+/6
         uwhsK2/TpMnxmVIGVk3mH/QqQfDvyGkXyCyNZKlrj/JDRt7ABY2OVF3WStYkLqpc56t7
         N/p1q86FuuSHV7oYJPEV916zZh6kektiUBa0rPEGh9c7EsOf0wXt93xWKRltsiXzEYD/
         wTxFV3S03lXXFNtXDXoq5K+RIe8lxw/FOuHgKes1jcnxp3qb6qqtjJ3E/xg9NWaEYMy5
         r61U+0sprbP9RI55nSIAQG7uD6gOLYFpS9jaI/HaGtazWCJENMm6PiSth0i/n8XJgwUg
         RZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=dnpPslp9IwvTlK01x0gVkPVcw7PAnlhNg5iK1sBOsn0=;
        b=Sn/Wz9tXqKaZ+OdJFJA6GPlpbKa9HFo9bCKU0asKMpe/r0X5cy1T1JVvGnnou2p9Ly
         3bGoQFDQz1BS8MMxLbnm4BLpoMzeWdafpY6K3JrecvN891mUp1GX7uYnE9ILnLFT7o0s
         34uT9KF6NccU7aaV0+2VegQCOjNoAJfVyXeKPnjmZrGOCeLWziuAqTGU3FgUkLu/POGE
         oxRlkwbGrfzv6PfgEejQS1imkI3BLjor+bHLJqYC5Xg42Bjkuo3azTVlBI4pLcno4Pxs
         wlsztmbl5WDoO/wlWeu0TxqoYDXFvnrUNRP2C5VCmjHdoil22vQpwckTOjV7jDK9lq5M
         eQWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=l7AfMtNE;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.78 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=l7AfMtNE;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.78 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
	upstream-release@linux.freescale.net,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/3] bus: fsl-mc: add root dprc rescan attribute
Date: Wed,  7 Mar 2018 10:51:36 -0600
Message-Id: <0705c56d5b4c4cf0b4d9bacbd160982f12c7f953.1520440367.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1520440367.git.ioana.ciornei@nxp.com>
References: <cover.1520440367.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: BN6PR1001CA0023.namprd10.prod.outlook.com
 (2603:10b6:405:28::36) To HE1PR04MB3210.eurprd04.prod.outlook.com
 (2603:10a6:7:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19807057-5559-4e33-22ad-08d5844be93e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3210;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;3:QavIm4gS0YXppJpBASxY7jWmE5NNGoosw6RaO+tVQYeqPR8RH0iEvg79qs/+sratkTvKkcvqyx8fVqDsmE7J9kNxxtp7Y0DAYzeN67SuJDcX9kuc+5SuAmRht7WpswpQ7sY0WALeADYmndpPnCQWcDaxokifsSBOILz80vLMCRDd06KfP3r5IBxrursnBoR2FTr/YUtVEPVRa/xdQV0c/Ao3AODRkExe8DIkrlME2li6sGb579zx8MCwhPFxlhtN;25:zHidWObcQWUiqvocO5mkbLA9hIeNgggra6b42MAYQTSJW7LrB55hAecKhCN+lY5hJUOk7DpEeTEWhkDdJ4GhPh2d/4U41MDy2CiuFvjUjl9TFWvWpQW4leDrZqT4VgbfYmRqvwVekhQlFWH1Tzp73QeGkJkD4FcYtvWxdsm9Ak9Mng1ND2fq2ajupS/CB1PoMLOOVF07ECxjyI0WS/GqGf9hl3I3A/2xbvkTycsZhMfTmoQ4hR7XXhnuQUrT4Rz0c9MDpqswaeH9qflXDx94dFrDqeXU42FfqcVK5k/8dnkfRyviPZCyqyMPQ1JObnoWOQ4m8KWLXfatXpRKeJqOBw==;31:xKKtxXG631jNrst/VyUJLLJZBRv9cuWKU2b/3Dc1/tm5CVRPZgBML5Sk+ScCQ1nhCqQJsKnc/uQZaIfw8XLSuKzDyJLwpUGwyeuy3gwRtdZGDibos9uin906UX5Pg1aewazvardI3qOL8gyrhpFouybVyCnP4HcF02C8fwEc8gminI/XL5cQfCY23qZ6Q+7e67aB1lOJQM5j3o1zreLMMvsPdWMttipxp4BrCnaV1sA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;20:owBYmXHr2d9xpPVv1WCk6dDsanS/ag+fTfILulSPBshWoE64Y/7TiKc0I/v5OxsI/iCdKbf/YZKfEF2ua31N1Ni1xovua7uJOyLqukEtlsUdoDDwVRecMC4WMVKIyXPOK06XLgHwxCdsFOO2AjjXDLx8jXwrp7n8Cl2b027aZffGtVXDpgIXj1sebLt1bpLSUxCDpA2wjuEJInUk/Zu3PU7SawI1BD6Fpp0m0pPFsitaEvqXtJgwmcHhuyl8QzqG3iRALA62O/n0shUosOLOtSaIGj/HNFmf4Mbe+0Fb3Ux9FgTi/afmr7A+Ku/fX4chv45X3ZJIXH4KurW5I0P+67Z66yqPoLkq//LxSPNVpufI6rz13pYth1eEYlVPHWatnnIWBD4ZdtkQNDwIvc32z0BDUtOxb9+kyzbb+TXgHJzaP5iX+VTLN2IfBxHzaBLNTJYDsJOXBSwk4rdt1HGmvgs7RmsyEFkebj50iAJ3zrYfCqvUNLUp+vZpDt/yv0vK;4:zCBm3iac1mPaXTGOU00cNTTin2VIda6o0SwwYe6YI91YkT/fIGooLVm3XKkKby0Xpe9yvmpJ6LPn51VRtBxCnhcEtOTrn4rM1Jvds1G26jCMAv/LL61L7ibeuH7CWcoErBXC9YF9mmG51CWK8radquymRsCSwitwcPIuT16OxR8Fdw4V+MvSb5IGAx/dJqVdeVONxsTzvnIwOxRT12OITfSQTPheKqX3oHjqahmiygbPnOkj2/BzSTpXOaV6cLzDknUqUb1HY6cHesbjG+OMGFS3QTHDcbLXGRWxqoeY1kvnPQ3+A/U9Lxg8bLH89MKr
X-Microsoft-Antispam-PRVS: <HE1PR04MB32100DB70F13FDFED9BA46E1E0D80@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3210;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3210;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(39380400002)(346002)(199004)(189003)(6486002)(36756003)(118296001)(47776003)(6116002)(50226002)(3846002)(66066001)(8936002)(68736007)(8676002)(50466002)(48376002)(81156014)(81166006)(39060400002)(2950100002)(52116002)(6506007)(51416003)(386003)(7736002)(305945005)(2906002)(478600001)(76176011)(25786009)(86362001)(53936002)(106356001)(16586007)(16526019)(59450400001)(186003)(105586002)(6666003)(97736004)(4326008)(6636002)(316002)(5660300001)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3210;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3210;23:j1cOhZe3AFxd128QfUIM2d5Wb+I4/1Bk7l88D6gbJ?=
 =?us-ascii?Q?i2UXXoAXhcxTjbjPeKNA5GeiEgbdcQ/4c8SgpQdf+4p0jfuY8ewyHGB509KP?=
 =?us-ascii?Q?QF0mlaywp6s25M2ldV5i6P8+nP5MxT8DtIzq8f8rvuTn3EC2Y37GALNnPksd?=
 =?us-ascii?Q?XLzcS7/8udQ1ldIIlk7VmrzLfyOZn/lzOCGX9OZPxfClZaI7GT/YcDmgPXas?=
 =?us-ascii?Q?rNrF/FduNbV32vCrcEtPlsM9ea07kcKIASztUcd7AfQS+8zgr6NQTlwXzn8J?=
 =?us-ascii?Q?FwKhyvwJF73bCPAn9g2c36htai6XQs77PFbPImwi6lCnUsTpMjmMI6RzW4N0?=
 =?us-ascii?Q?+87iZLvkmjdii9pGX2jDtqiCvg8WJmlninUU9Q8d+DoKFAXws+GaMcwbYxIC?=
 =?us-ascii?Q?+q1OuE5q4x8QGQ5AItofv1ecEs6AnisyQ6FkHjPa6zy1/vLrhtl/3wavFOYQ?=
 =?us-ascii?Q?5Y4BtDkLaR0H/Xyuxr3ncjAgWgytRjj+M5VHR/0MFCm9oEbI3VCrk7FW/uLv?=
 =?us-ascii?Q?Q2Sbaf9PiXO4heG6ZsLLfewTmOVAGZxp9oKo6xfhvGKmbDpuWiM/S77eUmxu?=
 =?us-ascii?Q?oFJPO/d2zGx822A428sNMZiBZcu5y9P/p3uqL/1C46ELglJm8kJbcSYrPyUx?=
 =?us-ascii?Q?04wOQm5pHWwVxQ9Z9qD1WkLMbMWW31/QWZASma19H+mi20isUVWBJ1IUoQXt?=
 =?us-ascii?Q?d1q9NUHcx3WJwrswhKV8F5yR39u1Pex2/hlwdyIwP72Tgmqt4KBI4csgkV0v?=
 =?us-ascii?Q?WZp4FD57z0sclh+ArmtajSTVEOpQB6cCleUUt9klTyGHseAwzHvJ9zzj5AJr?=
 =?us-ascii?Q?eRGfav9gYDP75PAwGB4ARsfAX+3ZIftU+kMzi3vFg3K9lpNsoLH6osG9ZMaJ?=
 =?us-ascii?Q?FfSOGuzfkhOeiXCxG/S4GDsPazknPKkrjs8XN4l6j0KCVsgE04hbYWtA7l8f?=
 =?us-ascii?Q?SC5FTCT5uLYkp5pEdwMCm9biVc3NORou1QXqdbdkcB4GjP9Mkad4zvvVL51r?=
 =?us-ascii?Q?FV+ELxX6ov9EIfP76t1PWl5/hHpy+2/woXteaCkQhFl1LpJTmytfbqXzmPRe?=
 =?us-ascii?Q?L4n7ogPnOwdaUQwv+m2B1j1U9QNFSHbNGFjSKb4HMob6MqYSLFbBkcuwGVkF?=
 =?us-ascii?Q?WKdnjmUTDqcKRUNQ6v5cKZcMBLdDt0sGcr3TT+sfisfGnbXE+daBj+SvwbTF?=
 =?us-ascii?Q?osPmOLMffhQvn4=3D?=
X-Microsoft-Antispam-Message-Info: wKYOMPJxdkHLlIeCunBtMtxOP99PBKvX0xbI+VchN4nmnKK11Mw43fiNTSyNTyappdV4JPTQ9zAOy27CzNx8/yAFamO888ChmTdXLU+EEO45WRozN1iVMHzfacYB5+pZXndxlWOJ8bSddSGr0qXqkivJF+6TkA7SGfuulCrEPlY5SCpaeHarTdE7ZeNqGWiR
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;6:66qb3oQkCFWGFqlOT2TLsZJGB+BcQkShGTDp1lwKi2QCUnKKLAog117NZ2N7mG6jzeG+kRt+ha6qT+LTh0ZZSIrKk7EwHDIUrzZrajsP1MGv2M0/iRU5JJyaHhUj5+pgwgwlTVPKN9A8cRo1btDi5Aegzg1C2TH+TlPT8hXANciDaqo/jZZ8Ur7Rxr910pCCk1w8seuxnGxr01xoAxcaW6aMzi4+XOABhKdQLusT3lkFrwzRqhPRA1dgPneJuOsMZ82vcg5tegFGutPqym2gqHS7r2P+fSo8MoYa6KptZ25dhdtg5dy4kRyji/8MFij78c8SzwT+RREqbqJ396rVE4JYwDHuMfDVG6THhesvM0o=;5:hoIU66C1dyH/MUej0SSCoqid8ZNDKLyuAfvXcRzEKLoaFESVZCQXe9TC6wuMMNDT66eRVt+IQC5i2wpe882j3TUtBGjHYxXNRI/wCxeDeRflcXL9I/nUcaRYFN9tWWpa42Hhcx8ufUyUMl52mS4ccIG6vae+faiCxDPONxEO318=;24:VIIxVHl5p7kY9qPOskNhsrZSCFd448733nkqgUTjSArPjHRd9IgMxBsYnwDuZM6hEbgjlbMO5+m6wTMCjcp8ejOfXj75ITIQXOdjbYOq4pY=;7:s7UcfRNXT4wDegf42EcWjbYXnOR2rH5DD5st3ivI8BfeNAfx8/FToYhp+wCrz6NGKG9LvCBK2+Rp5KtTCO35KaFxLcwPcN91+DBCKloTb1k8+/AKYvYt6PYS1vimuGs4HTPIkL+rcsQ5ec73kGGZ9Q3iAw6Afq3yI9fpIpLp6riO7W0SsFYnwMh9Ssi5StV/dSUobeXc1WsHBud4kWeVmg9QNrCJFawVkDigBFmGUXMcSO0GavaQORNdY0TQ9/NN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 16:53:09.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19807057-5559-4e33-22ad-08d5844be93e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298564594377895?=
X-GMAIL-MSGID: =?utf-8?q?1594298564594377895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce the rescan attribute as a device attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the root dprc only, e.g.
echo 1 > /sys/bus/fsl-mc/devices/dprc.1/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c    |  4 ++--
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 28 ++++++++++++++++++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
 3 files changed, 33 insertions(+), 2 deletions(-)

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
index 240b99d..763cbeb 100644
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
index d6f67a8..8a244aa 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -464,6 +464,9 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 void dprc_driver_exit(void);
 
+int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+		      unsigned int *total_irq_count);
+
 int __init fsl_mc_allocator_driver_init(void);
 
 void fsl_mc_allocator_driver_exit(void);
-- 
1.9.1

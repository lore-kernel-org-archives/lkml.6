Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELuN6SeqjP7x7WPCGbTZOI/KIDLU+JLK0m0E4iQCVmqjkpz586/Xn4kG1mkYO9qvRxFMOaXw
ARC-Seal: i=1; a=rsa-sha256; t=1520441596; cv=none;
        d=google.com; s=arc-20160816;
        b=ZOtu38iR9mCeVqwum1GZ1w1WX1bG5gwmMUfOKDM90BfB7TnKHT2NUrUYX94j9314io
         UmKgzOcrk2QwAgQYYUt2x0gGjlgfxk2keorAE9g6eFyovl/8GbGJgtMogWyMW6Rsf9ug
         H6Pr9fsaxixx6q62P2WvHx2bsPApeaaHVTMVDyrZRTKZ0uQIgLmTwj7gF062CaurUgOI
         vvEoCXl2s5BADUDsGX5lBPFoEPvXePT+T0VkAiAJXdu4GaHZVwNYBbINuCWosBOd+sg/
         Uny5FxosQyEVFnjarrIOOWyWS2QWGbRGbiof/iCnroZ2XwnUc6Xj4bReUS91hnrjh+I3
         HLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tuP2t9P+4u4bVr1t6JRqZsyGazbN8tKqwBTtMeFrtn8=;
        b=CFxOOpazsCLa6X5N6o4JyajuiTapxHdnA+x+pL6nrUGN23+MLXxNwfhQcmuh49L/qL
         vlCHBIsFkusWQ5kE3RRYXjTywYSJPF+VlPnMxlXKTuBcUTmTkU6qq5XldH6Y2Y9Qhk+p
         bKZVv4tvrtNqV8/I1zJKDsc84LVRTd6qQBMRkTnVaoq4azzpo5gotcdjwhU+FEIRu8O2
         MK3/vJsDuUeQXGP0jJB/tyG9PoRuegKueB+HHLBGIrjhb17urvFDVcgtasxszWzKcB9b
         rsuYqcWfnFGjqeHWd7N9ROcnID9+kUoCfnlr0onbYUBJpKceKNwIWI0+5W1l5X0YeI3k
         GVBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=AzhDi7GC;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.72 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=AzhDi7GC;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.72 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
Subject: [PATCH 3/3] bus: fsl-mc: add bus rescan attribute
Date: Wed,  7 Mar 2018 10:51:37 -0600
Message-Id: <50701e7c26dad0b2f05a3dd3dfa8b8807da83046.1520440367.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 66ff2d0e-405e-44a2-72c6-08d5844beab4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3210;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;3:P8BJqIE6NHyiyM40Y5uPa0hJuSNPx0WDCUj5fHKrYWw6pPK2bK+mmvNajbqhK15Ut5pnu++jdszrVAsewPI5akmPcf1U+JKenYLsHJaj03qjfE1T/eeP+Z/QxfG7BZqXsvXpyPF2vJ4y2rRvqhCwKPOvN9Ih4WT3SINYwhe1jXQW6TKJ8J5CTg/Y7VzuKN30j74zB3l3DctLAl3aWsCX7W8+nBaZaZOTI88vtmLNBFPlQwcNL3HFMI+1ezIarTMH;25:pUl/nBsj4qlVDpeLcVpk4PMQadcm5LC85wFvT5FViKg8qNRVupKK3s2avp4F0JyMLoRuWOCOuO5uXNd2zvCh/izNHxJ1J84sAcz5E/xJ1eJP5BsQ9isyGiDEk7pMJadfvgMHaHVbHcBz4CgF1074VBJRRDtLuEf1gQMEVSBmxzVfm23xUaUMVu0aQ4ZeLJMQ4JoLgLX6n3QKmb1Zx8Pm5KjxSWyRNFmsI5ISOg6B6ViUGALQwTdI2G/UWumr1x194FItYIi1sF7xC1clTBJnKCFO7lBQ/0HGQP5K4nNUCmNZfxLv351fcGSGmtlaUDuj9Xa6Z6XCL19UIhBluDxJrg==;31:lc08TwUw4QzRmfY5Z5dol0sBzU+jbWyEAFOjuA8pxuCHgnjcLfOu1Ie4zQwzTS1wlr7QXQPZJ8NWvplgTatp1GShNLgR9vdS8X1JCRmPmVmllV9PjIgWIbhFEeaOrQjN9iPcGSLuS1ycJdnkMYDnJfJa+4SXzqVI2qB6o4RKmbYh6aMbrnxwGawe1scmn5wLw2mgdcpbGcjnTCl/LEGx7L4tnn75Sdo05lE+hEE/cHA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;20:OYY4Qb4iGQgCLZ1ijRVJjNnLsBajlaWD240JI2fCClRazqaegURgQ4CNHt3hmiXLfe+LlzRzBKkRFdlIKaVKMoDFBN+etXAnU/njU/1cZlQPj6pV+ncLmpb0Ny6K2nT5/svTydV98QpbXEvExbwGK7tnb8xbHuTURUtiWXxqPnvqdhW82lZyZuBHZIhhcoL01AlUrO1pL9dptUGbQXiNgxs5dEOYLmu47v99B1E7ASevKH9xX/ihermSKbsxl7LgvFxzmxXNG8MaKP78E9EUpNXr/Wc28f15xdZosp1V2o5EIw/IL2gjzlsqROH9sW6gAyIwjmAMgFBSrRSBEz2g1of55/CWj3HFuOskBKJfWuUuojrZADr1i+dYj0kozFjqBEVq6f47xRkYMMI7X57bSjVhgVA3xzFsiDfzpWt2nP3xQfYUyjzuNcPWZH+Sc16s76L39+CzrOodZeHEmQ1QujdxtjQG0CD+/SJRwMLys5MGCSxqEcvLzn4VnhW4O9KU;4:tQVKFYHGgwyQ6dc5ag9UCnJvl9u4RW5VCst2lXr7lue53VJiRiQycpv7lH8HX3iHmsDnrEuyvvFSEnPMHxwt4H58RQOFztSd+fJODl159Q7SuOLJyFHMY8STXElx80IF6KsUmJRkw4G94KzhjCATvTyVTMU6GymB3ExucBnQ8aYCY+Yw+7/BAHyorIfCoCeWik2r+iOKpNfdzUKiudUbl/NTJAI0nuiHiKchTVhGpRbbuC0ILodwHuFAn0HvA3dhG8xtW2CMcshA5MJQa+JqrrZwr6T9ByoH0gNVD8D/p6yPlA0I+F2GIGt4AScaDODE
X-Microsoft-Antispam-PRVS: <HE1PR04MB3210D5ED5DCC4D335D654103E0D80@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3210;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3210;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(39380400002)(346002)(199004)(189003)(6486002)(36756003)(118296001)(47776003)(6116002)(50226002)(3846002)(66066001)(8936002)(68736007)(8676002)(50466002)(48376002)(81156014)(81166006)(39060400002)(2950100002)(52116002)(6506007)(51416003)(386003)(7736002)(305945005)(2906002)(478600001)(76176011)(25786009)(86362001)(53936002)(106356001)(16586007)(16526019)(59450400001)(186003)(105586002)(6666003)(97736004)(4326008)(6636002)(316002)(5660300001)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3210;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3210;23:3m2tSh3w5iiEaL10gDZI1Yr3gBPzws6k7dOJ4lcoC?=
 =?us-ascii?Q?yO0T+VCdoH5577nntvxpSZKuxuMW1zTpuk2oHO/MMvAFh3QRmxyII1h6A2Lt?=
 =?us-ascii?Q?Qktynp+dDU30pLE7qLDk3P7RLKE4cGlT0n88pn8j8a1q/LQ3ulWggB/S3cG9?=
 =?us-ascii?Q?Ur+v3nVNM60pa7a3PA6A6X7XL40xof0jW5mNtTuIyV8BejIW83K9vhNySlT3?=
 =?us-ascii?Q?RZlXptX2m2Hoxpf2yHeFcoaGCdf9GQ8WF4P0vHOXYSjVBKub7htkXNlJZvK5?=
 =?us-ascii?Q?S2/7dCD+BF8vI7XDdJp8j+yC46VPv7uYC6x0M4cjiT+/v46m+uGVPfD07Odn?=
 =?us-ascii?Q?yRES88gcXivXOrQrnMrSqaQ4TCGvUJoeRW4NBdQgonUSKUkiLjjHPtrEJTM9?=
 =?us-ascii?Q?ulmdjxa6MyMUjQ72dcgyAjU9/1UPFau4S9HlydpDMfPRYgbSdN8nuJiKzeI6?=
 =?us-ascii?Q?nb8y+Jb4NvH0Cqk4jedxsn/ZtwICfbJUrwmQ1hM1vKlPln/RhLwxszRAr76j?=
 =?us-ascii?Q?cUgo16mq4dUZQ1FeKhhCTefKrnbsM/wjVCVk4WW4ii+k2M1nSeTbj1tCIJnk?=
 =?us-ascii?Q?YPgYuab5eRqLQzurOYJCLSWNUu46bYnhlmX6w8b1rynRlMZjOsXp9uYBkooF?=
 =?us-ascii?Q?7VYI+vTAwrOALxvp66130P5MyBi0iM6MfAfv6fM9Sk1+L0FZUXTRbN9RHukf?=
 =?us-ascii?Q?yvgxjL48Ij2zYvZ+z78oPlGzZDp8R0fsgxErYjmjksgYaFRLD/lo5L0rnZPz?=
 =?us-ascii?Q?JyMn7bIzqQROjSg9QX2G16nu234UY+4P+EXWjzUR6at6OwwYoNaEoeC1NAlx?=
 =?us-ascii?Q?vTkzGcrzF8/GW53FsBsqKbm97rctUWoigy+jDOu9XvQrXfaLLb6FqAY47BYR?=
 =?us-ascii?Q?RPYfHiIJiOWsqB9aIhkSeq2MuLWNhMKyFAuVHcdJhiSEgnfNJffAjzsMJfcl?=
 =?us-ascii?Q?/yKEpVNy0iet8K5x7R4sb6wSO7hn5qMTaCDzCQEN3iAKRzw/TX03Ae0H2qmf?=
 =?us-ascii?Q?oESjMguvFT4rVkJgM7ftCSuKl4FdyD6ZyyBGcF6FjVP1X1N6NaQKN+qmuACg?=
 =?us-ascii?Q?YTLJ3ECr4tNDc3J1vQNp1DHv83+ElWxLTRkr857K99EK8sBVRgkBLxiCVwWq?=
 =?us-ascii?Q?fcJ/m/MYnijJBRN38wvgGdh2xkppkDqYLaAQoHRN4fP0wkHOovYET8Q7dpzo?=
 =?us-ascii?Q?5h6VN9MpNl7fGo=3D?=
X-Microsoft-Antispam-Message-Info: nwerFHX3YKwCPCYjTWdihZnA2Ge6iLg86Qn1dwEIADjWtTnwqrZP14fFzPjRXiuGxYchco3jkhvjMq968iTfvBGxyB2lITtgffCHCXXreXfJQCy4QV803bpduZQlhUSc8RSRH6dkK/VDzEwPZsn5S4vn8Gqr/jB11rkDqE1pUHeZ4d3qjmatKPY3fSXyhtYg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;6:RkQcggncxnFbYbtdhBR+PwZbqepONYqCfkF+Pec4mCij5etGbCIUeJjgMTW+TQ4pXtmfDYhWG9B0NXCDoRCrolj5PGNuPdJE6nKTQ5XBvbHTOQuuDomuLhynwxVRnHzXyyCDaYmKTZ3xyYC/S0BLRgzdMpCAAHN9LwAoVztMqG5f9W6oUoNfCA4Xp+lCdnkGOkp3OVkXCLLk+l5giFIrUAl+BDuBS77/vP0s1fXPEbvtn25X7SfUJuhKa89VC/yVjifwlGo+99gZiS3d+sYNw+yeXKlRvn4hnFD63bN+49aT3vzMU9gpxB2QGT6wlGXq/+AqB4/QE5vg28s2V4OAc1p5IThWZw3v3zYtXFcjyRM=;5:cxNrj2etIQn8T1qkWeMrMTgbVP0Ube2I4HC7F7MnZ6BiO6q1Q3jNknjcorU872wcIH2McCS22EU5L/1IGmOU+K68ZtGSVxZY75mwNdRZqRKxkTqhccM0AtfAZq6QMSxhrf3IZwqj1xJu2p7aCWqg0MiBhevGY2cls4vbYoffRzE=;24:vfurd5FFRzNvxYGlp21p6+afYuuLvHCQDeuz5585PZ73SR2uHFpJ8AMNSuK2PgfFEgn+TY0NO7q8wJJmuxWNriTh0Bza6fSefQ4qKrnbc9k=;7:T31r3+kpVAYPI4A6nSTigAA4unpjpR2ffR9LM/yQtHufRimUhwVdPSXLEzUdavlfViXpUt0mQ+PzdbVFBGVTGz+rQ0Wp+nY5Yqy4yGSWjXq+1TGLUkhV6vHF5RKAsALJWK82Vx740Tb9buTDJxhkqzookfCI0e+tXmsHPrQ5mLEjTYosJcbj8Ce9C3mIZDbiXkqIYdsyVl2VMwShw0wECLMWYF0MHvVuRJDb63mwrbrZLmDponNiuQA5rx1I2bam
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 16:53:11.8213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff2d0e-405e-44a2-72c6-08d5844beab4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298567838677166?=
X-GMAIL-MSGID: =?utf-8?q?1594298567838677166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce the rescan attribute as a bus attribute to
synchronize the fsl-mc bus objects and the MC firmware.

To rescan the fsl-mc bus, e.g.,
echo 1 > /sys/bus/fsl-mc/rescan

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 763cbeb..da9fd29 100644
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

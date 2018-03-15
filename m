Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtVl7STj9SzcTnPjLDnNnhJ7Vq8PPeCyTmelX6zH2KaO6A1gg/WWltuK4NihUUd9324uFZ5
ARC-Seal: i=1; a=rsa-sha256; t=1521133584; cv=none;
        d=google.com; s=arc-20160816;
        b=gFSWVejTegmgjzpsk1ehfifipGa5rxtKzj8MWVxmvJX6mR0L1v3GFbj3zfGigymRQQ
         9rN6hrfw39764L7YCppIK7qDgx+DWsgsCgDF7GwI85uy8JMNTh0oTHideu0p/smKyWCq
         SWtGgRgXZuAssXukXceBzKD+cfHxwjs6si47nQRgQZBOoUX6wD4zO2pzhShR5ArxTjlk
         QaalZpG2qtMrGeFCw2UEpOwo5ACOlxC2uMIobZzwknHKtxvUScfBYsugYH4grmTZX6kx
         Zcau4YeLoLlDKBlsiNTKjedOebsbNm3i4v4Xtn4fZcDHvN1Ip5Q+jxrm5BzA0eVzBZsN
         Hcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=l5/0A4ExaHfSPNZf+iz6p3a4hFYYlKq98VPQ8FEpqwI=;
        b=TPqZ4u0mN60TJyt4XMt5XFw8LaA/0h4Sb6HVF90SMzgqyl56SNeNPAZ0B1Y2yEViGM
         PyMAt8pUMMC3Amyz1eTTZnXMDC4f0IaTgKnpbiG+qP2illQ9sMAfw4qfX1c7yK/l3P5r
         s9XWo9TMAwwlSnIlFIVun/dLVc2KUSkOBD8LHtPW5UHNmtuyFErr2mDdME9xNYsc97do
         UCpKh8CU342MWafUxakfXJyDFfJHWx/ZldztDgjqsXNUmHc2YyBh5ng+ayY1/9ni74lx
         Ri1J0VvwEzaKDiPjPeYjeBH/osfwr/soMrUqIHJnZDJG656zqgAABkcW9f6IL2R3bQYN
         d8rg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=S0I7Keee;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.53 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=S0I7Keee;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.53 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
Subject: [PATCH v2 6/6] bus: fsl-mc: add bus rescan attribute
Date: Thu, 15 Mar 2018 12:05:36 -0500
Message-Id: <023a09d0ceefe0d31da151a5d506e504da643fda.1521132659.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 562e3be9-2008-41d7-6e96-08d58a97140c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:/j1/JUGusn4P9xOMFr3rok96hMBxKq2nX8eprjaGd4qLGd/VjGiS66hGpvv34tNQ/Q2nObN0uecToabqgA7CAygPs9zyyZbKNrbay58GGbKB5f9X67bNIEl5nVu022UELFBNqEVmp/fmIj/W3RgYS2JekB5xqRpUUZfUhYHFsbrLUYshOiVEm8a7wdHiGyhU+qt9Gj4jw7Cja9u/kiWOFE83mJ0l6dPOL9yGEUCDZpBS2EtmIOP+aF4vLWrYpYs2;25:BZCtkis5h61JytqStb2qhc3iEK8xbwrQBIJhsproCVTxKpxv5oLL8cYgFVQ9GSIQkRQqYijqMlU91wxQ4MgBLrArK9AsnupWONWz1xu2WHykyodmX0/0y0wFijYQm+dktJ/U8SH725NVsWL1nk+nQ4u2OPF13u2Ev+QVnjYJvaG/7DZyz8FraSEwV+tBQMWqNu0O9b0PbnF1IVlzej42I3DP35ddLvfaxWuHDLACFk8BiHfLQd63QkwhcobBliTkdxiIgYXXZrDs6i3/nfSuVmOs0wQUks4AGamZ9LGEKCkpArYW18+tfbBgqV7HPyXFGYCIiBaGAGwAHdc0ZPd4PQ==;31:Ur5OdA/Mwe9XsMmT8QhALdvmfjP/tUBVEfVNC4KzZBBNUSGDmZQEJtX58YVF54n1vIP5JAirIkapTay3t2CGft3SFp7t/x0zn+CEn1TiqmKvTHkNOYuaMApH0/8qQTmxBHKRF1A3gXmvA24q7aLG9e+F2DB3dJLnpvz9bUJIGk17iffsPUr3okRXyyi0qXKrJGirGMO/MmBU5v/j4KRmRs+7V4N6aS7bpqGcTI8sjaE=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:JuO07of3O4LhBcMFfpiTESQqEXliyHoxeQ0mnqpR6ZdZJt3irxMeDVOuUXDUplV7bKn/zBR5NoRkXuG+YYlX9N3fUcWG8Huche18tgdUjlmFmDozY3AH6Fo7jfYhHgK6bfUuzUqlJ5Lf3ugiGzHZT1UWm/K8p7cJUjYyLp4Rt1KyEOOkgeJoSD7YkfLfxrGdUiJL9wPyvZ3vXx+NEFfa/NmSD+o3c5qL/rSH7uSmeP67tnsQtPI7PFm665udGbgaZbqQHnph4vZrqIV4+Zy8Enz87nFiDtBt4iGP5JK5VwLyhnPGQ2a0fGRc3dQ/A9mpd9+VtcT3dq2opDYgrywunEcwVpO9eQ1qItHB3P0ZD3QmZuPuKzIzoiHI9sfOuAGW0/7ilGZ7oZjfF0S9DAOvdhFzba2U3EoSC5vYJAg9DDz2g3lDTELNU9q9jeR/DQX3J5bN+WNoPqbkzA2HV3GJ9d+1p4xYNdwWkrFUDkS249iMvyIeSbkxbK052cc+kwBb;4:mugeyFxo1V+5hyC6mXFWUOZWv67vXAj14wg9ew+LsP6Z3uOcVGlkyIdy1YLz5OX/awkH9h02xGeS8w4iQn2eRwMD6gLSG4fceLjI+wtoJJm2vg2d4ggU3l5To07nJL3R5AjvwrvOgDrrzlcUwNqLutRpShIyENBQbk82803SNtzWK4B+honSF4bLXxjp+piCKJKNCv177LRhQs+A+MEYXBgZTScs3kUd6IyBq8fXGTCb+8o9Mdye5W8IhCc+eKEEo3G/harQflFZJG1hHiDmP25N8g9UFi07J484QDwmazN9ZskvsSdUApUqTipAu1UN
X-Microsoft-Antispam-PRVS: <DB6PR04MB3206D34337AD06D3AEA1355DE0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(50944005)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(59450400001)(305945005)(6116002)(36756003)(118296001)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(76176011)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:4AR0WrGSwlSIHIb03GuSXubuc6Sql5HtyitLZaZJH?=
 =?us-ascii?Q?uonqtIBYmUXPICceTRtV/mWqMWN3eYgsMGMGn4GyaoSMMAruKvPYWh9LUpm4?=
 =?us-ascii?Q?7oTL//02hdWbuAndcmCN7RbbKqLwiyRRPQ8dCEKmLNjKz8RwWPsl+kUvE6SM?=
 =?us-ascii?Q?5/ZLRgJZq3B4LUUVITgF8XY3FY/eCHNpnwS+qxvAnzoy6Rl3esZldCIYTsyF?=
 =?us-ascii?Q?RvSj5MypgOtjWOvu8fZwjrsZHitQBSRVqqMsaJ6fVMEfTK2Me+BNQrQdJeuD?=
 =?us-ascii?Q?1x4MUJTrPvBg0mNCl2BenWYYHbdzRzIXzYNCEH5FJ7lahSt2rvQz3Oy3TIOy?=
 =?us-ascii?Q?Sc14riiU4jKk6EvUBnvTAdgjqUNz7IdYQsX1xOTP1wLBnNcmKTs+F31/1BX0?=
 =?us-ascii?Q?H4vAORCZjlXdNdwrTWfK9kPB8OF4S3BLn9l4gTTdt3yEfhcQ8H/Tf9ELWIXv?=
 =?us-ascii?Q?2GUImK2Cm5MVeEy76G+qvv7nKW7QgFLR3t3FlNxaa9CpQWMS6QHcy3X1h2dQ?=
 =?us-ascii?Q?ULnFrtbsQ+TvZKym/MWQAmWdybLH1+jghkptXZB2MSWtdV3S+nCbJVIjRgkI?=
 =?us-ascii?Q?VHDv9u80vnBG0lqlPWWrj0JpB6PGzbaVDWs0MKn7LNIzUKc3dc5DrpR/EEyp?=
 =?us-ascii?Q?VN8/KHcKlt804eXVz2LecEiFZA7RMLaIYIhHraFG+JFoWqBha1Gnf1xtxQQh?=
 =?us-ascii?Q?vaWdDDBK1TnCQ9mslkgB/V6n2s7e3xAt+LjTh/TaX5v8zeZh7eaIHqJYHy9m?=
 =?us-ascii?Q?G1XX7uq73pobNaw8munUUIsNgvf27Z9BjX0TFORNbjyT7FYU8lezgh16y0oq?=
 =?us-ascii?Q?uJ+PQErnDKqUpebK+VpfclLOXmiConm6WTNxbijg67Q6Y8ECC6SRZ1psTf69?=
 =?us-ascii?Q?r7wOHuW6FqdraPSG65A8P0//sBrn9L9zAm+1x8LjQYVbpGMqQdqtBJ5ReJjv?=
 =?us-ascii?Q?Bj5l4SNgAo3lH4lE5NBh35Piw5FTyrkRvXQtr446nC3u6mMsDMj8b47JrfLp?=
 =?us-ascii?Q?wlSI/pNvjny3HF1E5L7PeFZRbe8GRFRY7s4dfZcAQlpGD97yAnyjTksqCuQs?=
 =?us-ascii?Q?4FT50UrFm4lx64EJKjX4dhrbsec4PaSV3IA/k3liCAJ7yTsX37NZdo164L2f?=
 =?us-ascii?Q?53TDFM7ucU+wTwPBnnNS7R4sU41JLg1It72t/R7Bm5H9ZF5k6vaS3woFAsZw?=
 =?us-ascii?Q?3N3/WzHfSPah58s5yFz18jacMxU+mQ1ED9L?=
X-Microsoft-Antispam-Message-Info: EmKmG7t+5xwWc9US3sMRPbHyqO0KrvyHSeNuuUzPpc/JBKIe3y4ZC/1njGBO5rJFLzfQQEk2aKLHZvP+Tr7ETwqSWUUP4414DNhQQwpiMAwQBHH5uHSo5zDS+u7TV5UzU/OmTnOsx3d67Elhy8z8V+2PxVxQ5TAdoDo+hFeGZrCEHURJZic6Q8vjkR6HLBZc
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:+GXrDebSt79a068zjKWhCt/veuSYT6BgnW35x8/+c/+dGBMC9n87s4XMundXbO8SrgI7GYY0ogQY6dHUR6RyajgqqFg/sylXwB71YcKjfZeAtiEWzDO3pum7oKtk+jitK2iK9j+ibKsopvKWv40Z5iUa2XUnZxXJ9kthurKGoVC4nuOuRJNNxmcefMB0LadUetAi5+D9YU0xp0FS2jVTgYNaF7dVsa1l2Rfs1WlycMyGix+CN32PqKxc3ovgP5WtbXrrAPJrFXV1Ux01kZ7dDgLjckGkprc9bfec6rx3gHOk0cgxwV2XIvWY0NHigmnXUpHSFogw1Zz7Ckc8flqLs69DMzkTHSXKG3pjztgpWCY=;5:xQgKcxYT47k2A95gk62XaBGZkV1GyjX0BAcaMO/AyErelMbeiExBcL2D8H8fw23xAhpPfiKBMxA+9lEH4hTE6fxDawGkbimdmNLEyt1a0ShhudicIIv1w1RqQuUG7WcjQMZHxQ1SAI2lE1tUEZCiwX9DELaefWHYGZKu4ACiDC4=;24:4bEvgQPo/TORdPyEOpmZSYfm5x4Pf5gLHRI5nXtLzqRVjKmBntdF5Oxd4m3hUoG3nuaKIwjY631f6YqZe9gy1GuyyiygSi20J/ICSXepCv8=;7:fO9W9c5oVY6nBH5bCvBzp79XBIhFniWqbl33eOz7aCePnMMAFiJMvAGj8ppaaPyJd/O6QyVz3Uk5l92A43QbKCtR+2FnYW/HvrFYTQhzG3w493ZBE/x9X1WcNrFnHqqvqWRUnavfTizHDKHCXHHbmGEAvWjiFl4d0tyJtkmoiuvdWwu/HaOG5OsnlCuRxVqvYhwHu1rtNPjT19ppXjNkzstaCSsv4pp9vXlX3kFZJq+BVOhsszBSeAx/nxC0WW8e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:20.1033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562e3be9-2008-41d7-6e96-08d58a97140c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024170124734942?=
X-GMAIL-MSGID: =?utf-8?q?1595024170124734942?=
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

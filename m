Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELvZRwaA8W1A3JaHPwuw4BKyKZ5fSFXTgnJayxzaSvHNuP6IrX4hM1h54UTjxbqmKJMy5ABq
ARC-Seal: i=1; a=rsa-sha256; t=1520441593; cv=none;
        d=google.com; s=arc-20160816;
        b=TPCNQKApo9iyl2huTxeMnyWmbVqrSrS5b2h/9iNSoPrV408eUEq3IrcW6Vdla1C7P3
         fVszQj2QrPmwjZ1HFIOpPW/xJmCLKo7FzqjjZ1yx8Q69dub0rwCzRMc2kzWyV2uG2XjL
         m/cvIMUoYcOtuXDlVxXaZzDQ/gcr5FlNiWpAo2n9kEhGGSIo0SBdsf6xhSgqGhA79so0
         f8RKdbU1ChMEWzgLEhsLRgOyLHLhG7YPstIcRJDHN6h5+MGTDswngQLrvSyfHe5KkoiX
         jk+sNcbIoUKgHr/k1NVHXwqRAS1J9gdmxAcNMraQ3egEU9GPhf05WRIXLLHVqdXPBdh1
         MVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ttPGhPgmqWC8joE6EKlJ6s1wp6lFUFZ4sPfdkDk7HkI=;
        b=gyjT3YrDiEx6p9N6U9faQFnkVJEPYghhPP5TXyKFVbnBJxzXhB+aIWStVoKTxmIIXp
         z+JBdVgT6Es7GxXIzprYlZ5VgyjeiNvbOT/SqkhmtjwgEYFWXF121YZN71ZpqV8ZLYV+
         Li1vL7p0YgRD9MPvj59uzcCTLtxrtpXC28JReubZv4wk+MdWrwzhgHUwfYBmqpDStVym
         mcp1uR7OGct3/Qh/L6cSsK/xluSfqoh1KNr0yhFl65jBjBexMrpkjVrUEF9/9nTlIRP8
         RFJjlKIiRi2Yfs0hGyQeqpBJ/YFz9Zlt20vkofuMDE/LzbLSDyAuFtqU6W7BKluHMB9D
         Vrpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Qm8EBBYF;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.78 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Qm8EBBYF;
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
Subject: [PATCH 1/3] bus: fsl-mc: add restool userspace support
Date: Wed,  7 Mar 2018 10:51:35 -0600
Message-Id: <e3d050dcdc575d65f9786eaa1b7a55aaa197dfc3.1520440367.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d3b6714c-0733-4686-7346-08d5844be787
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3210;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;3:rNASo4vHWbNQOs6H3waREnTMU6A0dofe+Ood24xs/WPklCaRQYVO0AvTpnPXyyNFotZn7wu7N0xDm22yqq1Gf7JScWZ7j8fJpaKFRKrwB8ybe9Ww95sLBqM1Nb4uTTmMcCiqSaiMDyI7J+us9T3J25c2bt6daVPQ1iwY2YLKejrAvlDMX0ZgBXncc13hs+eUorGSuX0dnnFcIJoA+2Mk+mPNoDvHkQwajsFPAONB0+fRP//qNA88dmBCc39nNfYD;25:bpP7Bos5UfZA9MOC4VAHJY9Hws0/klUGYufIR4tMai3nDiVJbf0ctMlSNz5TDNmfScrmtf1nzhPOHJSQEhWhWN8KKd5/fMFg8oam8XEQcwm6/97JdRMimheSTb/c1K+51d/HZ0ElWEEg+sBS0oNekOEeg5wku7VTTvaK9j8NlhNux0j1H/ADgDAHRN2P0K5kT019NrSbJ6ygoDGJvbvo/DezzM1Yqj1IY4oCPt71za0xJsCTzziywCjZ1qD0lLBn2z0TdTadlEqyVSko1FiL/Kq6Rt2+Mosn5/GnPgO/Hc0QgUnJxqdMExogyfJp9T3QATYMQEaSU9Dwv+GpIz7BzA==;31:Kf91+KxOUaQouXGjcJCK5sOxYQeOkLtj8U8SKO+DZ/KvTwZnsoT21jAnirqyHLERQXGi6+93+foDB3w5sScS3ohBZyTdJoC4hzosbrWTGRf3No8HOvRNGzstHX4d1uvbyQebG1cocZd7ycbMAzb0aT5I2bsWyIgfiB9OjHplmtv1N+694YLQVQLaXE8ApPUuel8OJMfDHHEzgXv5mkdDtBvb9F3lz5138jfjTUbAdPc=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;20:DOxYkLgct7qM/X9AI6M0CbNea3paerRwcIcCjm3wJg2HVnjPimRON+DyPOErON25eYiSdJiDDUe+3WH0fHJUjCawPR+hJ5iyeT1vymWa7NboWbZCZdR+YL3x5sj8WbuHx/CIBlq16NrxzUgBcezTXwVE+7KWGvznDxL+eiaapeh02K/NnkG9IBZns3U2VQF4Nbkebh9zOBr39XCadvYd630eKz5iGLx0o9wnp4pYvX8Rf2Xmx4bS6YwtzyPWLI13e5touL/pk3N1SF05uN1+q1pKsfyzq2TW3wsERYaxBfEts1kNmULHhRNrbtFKhHggf77svN65P/cUi7Km95LTqTCTm4nmps3xQ0GZ7yFTtrRgCP34om2NJpeWrezs5ZGU8gVY2ekak4nOFUq/HoF1/QCQL12qJ9Ln6k2YaYydfZIY1CIQyIb0+8q74xY4ihRDj5WMZ6lc+///ZORYhX9WZXoRBn+GXWYD6vEs9ZdCJKOSmwhfaixF27xCqwGw7ohN;4:u/v+EQ/UhB9YLemkWu2/2+EvwTocPYPlwI6FLkSTvU8RDghdUoWi1Hj7AqciwVWFk4Wx2ANVdN3h6UIFeg0NlsKFQMppAI/NCK0wI27WRz2kmLIj87KuoySE8QcvzbaMsiYTjC0rbo8aW42p/AiXYc7nvm84bnSxbYwhr0A6t8o5Sd94e+KL9VnAAu0qKzdi8ikDqmyI35Nwj9iuJ1r0X+HsqkMOF8Tkpe6IQnYcbT/TPa+TQQUutQNGutd+yA5ZT50+KQEoUXMOJndyVLGJkKbekCe3gQ3wiEOUslyVBxf78qc7867r4KUhyXAwDxsK58C8MgGk16xtY4FCkwT3GBNPv5qdnCIXaVhWUEUcflWheqmbdjd+/AWoyVpLWF3UyBZ4cWEsgoMF5dnr4UvkaAqtA04LX7t+IR+K2n9UPH4=
X-Microsoft-Antispam-PRVS: <HE1PR04MB3210FA528CD46AB7747E1435E0D80@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3210;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3210;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(39380400002)(346002)(199004)(189003)(6486002)(36756003)(118296001)(47776003)(6116002)(50226002)(3846002)(66066001)(8936002)(68736007)(8676002)(50466002)(48376002)(81156014)(81166006)(39060400002)(2950100002)(52116002)(6506007)(51416003)(386003)(7736002)(305945005)(2906002)(478600001)(76176011)(25786009)(86362001)(53936002)(106356001)(16586007)(16526019)(59450400001)(186003)(105586002)(6666003)(966005)(97736004)(4326008)(6636002)(6306002)(316002)(5660300001)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3210;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3210;23:tKBYxGIxf1XGX9rb5zFRc9+ovroBkLA0SpIh0rQHh?=
 =?us-ascii?Q?+FmdMn2SCoUmeaFL3pYkWULbXWkjkHluH6Ab6V0nYxQCkaIKVOVdRHblS2ZC?=
 =?us-ascii?Q?LZnE1K4T2SdCWVFurgw33FficRcbwwpY5mighPDbSSx1g6OpPILbO8SCOnab?=
 =?us-ascii?Q?cGr5aSlWJqijetrK8sDOCkrpSmQaFEQYfvGh/2ZbM1qz/gMG4HVeCSmmmatn?=
 =?us-ascii?Q?Y17W3E5qEYxK+rhVbTnsHmfjr3+A8pM2w93XU5cs7BOG2+JM8Dd5Ns5K/eE5?=
 =?us-ascii?Q?UFKIOSZ2VOfw/2Cp3zOjAQaw5URGSgzEWAKK3rgv7zT3BoTr1CT/+iSVKlkT?=
 =?us-ascii?Q?pUqvncYuGu0v9qA9qcBDKDW1EUGlGcwzTeURDhTVjy5TqH+sRvm+2kUhRUfa?=
 =?us-ascii?Q?zN1MFFm0j8Fg/B296cW5XawhHRtzpXCItLRc+b9fR1jzljBd93m+qtGbPyWc?=
 =?us-ascii?Q?hCcwLKgI5y3ATIWgPUIAOD9hhhX8hrKtaLKLY8Eny5NEX4HRqXdD4xoMgpl6?=
 =?us-ascii?Q?499fyJGHb9QXrEoZl9vVEYBUqO9LjIBRE5/7lwvKlt/wWKTwVjGY+2XkbMxU?=
 =?us-ascii?Q?AiKP379rBcWJWia8D5rN9m4vAZtsdjX6AGTh6gzGC42c4xmQUXXehJV56GSf?=
 =?us-ascii?Q?BIT7t1KsvLRhWGER4fGdPllMM+lD7JOi3VX1QOpzMk0MCzJhjUMhHW1joKDl?=
 =?us-ascii?Q?3leX4OGPdhzG4IW20CqI9+dLUtX6NXleh62pZAek6KuxObHjEdA8l5OW+/nN?=
 =?us-ascii?Q?DI0hO3zj78JU8O+ZSms2LA2Q9ICDSZCacs+m7n3p4/gIsJonGLqOEFBmFn5T?=
 =?us-ascii?Q?GJVDkc3gAP+d8arno/dV60L3MfG4ykUgHgYSXom52GQQw7D1nourMRHKMXUj?=
 =?us-ascii?Q?BmW1wIxPnH/kQ3+PRKmzGAHG5WD2q8dKtNIoEBGxCQmz0Fdl3eTKxCO5ZlA8?=
 =?us-ascii?Q?UI/WXulAmGRIGHEjgY1QqlSCS6FBzChL/V/JfyMe9I8+uCPSGvZeGX8sOeTZ?=
 =?us-ascii?Q?QN/0KLFwGPHyIrv3sHzam2BrHVgTeNDQa+86k0hxTloWk7F/UG7D+C0nJPvH?=
 =?us-ascii?Q?rt6WIAuyE93SV8u61Dl262zSivuZnMGHW/aXuwqoafHm6l1Olglo6scF6qbd?=
 =?us-ascii?Q?GA+0O2Fxh0x2lZ+yYl+a5mc7OHCdVXGG+MJ8bn2/96S5dBIaUCkImP3clfcR?=
 =?us-ascii?Q?wc67z6KpgfwlrNg1jKF1NfweG9KGyLTykPK?=
X-Microsoft-Antispam-Message-Info: eCUX0mGhmAedu8yDxFC5Uio/wX7IDtsXvHNAL+9HdokH3ZFaX52f7sU2beyOMOaCu9v7LC5ZdAl3sJilqF4TUTQlsTudAMGAiqRJZXpXz3zjFBfNTUrbQWtZQi9vaZK+K453SVy5E/ti0/HGd3vBVdlpKlngnCxShawWg2eYoRBpnPtAqhGyMl3Puw2UfOtg
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;6:EiEf628/Sb1eKasJTrDwJ1dVj+x21vf9OFyAogUMCYVyzIUuPt4qgpZxSyXW48aV92qP3hN9p1JLYv5+4IzZb+Nb4nbIq4KHaMHXiA4QMYch4cjIZKlOLp3yBmdquoXfpZY12BUQ9HVJrCgRQ/DbIMPM+yvqlbmXVlGIBFZwS4RfTYICkAahT2bhSeGPkx6YFnDJiuzSvN+R9LCwDIwgONzViI+bpKcWIkok5CXlFyTTEuc8vszIn49vHNstRttRp4TupVCz35JicSs86Z+G9dXdZBBfnMdYkDnIuSA5OB2rYY9SWJX6EfqpyUwQEd8kAeMcCDwJTVDmmArldtE4gLhIINYq04O+IQ8XT/KPvEk=;5:cCYIvVwY6mDGVq0yjeta4ktQ1Rcbw58GSwrXIANrkhl5Nephz8JyOPwqb+KIGwYUHLgqGmgiw4wVOdHfNgVi89i1AZUXI6VObwkujuPaDYAzxd/sTQaTNSdeO6Z11o8KIeMd3U6NcJpAvGf+Vj3cuqBgVCD15IQ5vRn5UbzdYnE=;24:kqO4+qPpge3wAGQkprfiZLYn0xw3/Ci4Gw+uw/dDNoyzHGZnZZR6vwLS0FHjPslGh4jSX2el2JbvOIo8qfvB5Pk+mTuVUfURr83NJFxGZbI=;7:DK+gvXZDeefWPCOziwHvZSPIinPooBoMLwTZVX9FCoVlkL4iY7+35H22pCtpdFXS+lP2apNWOD/uG6DbuQNLm2vmFY2OJLFFxt+j6xalNYi6KMC3C7j8vk2sFIBzypPpaklKutogWh6QOArelkcTbpUUiogXLA/VCtsC+LaON0oDmtVrvAQHeRAxWK/SLV2WyHddJGzpyRaHa8S0/ub5X5cMFwHcM4/6EeSnVU/B1z1Fp+hiG+6fpwgVZpPGGW4O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 16:53:06.8214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b6714c-0733-4686-7346-08d5844be787
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298563831180783?=
X-GMAIL-MSGID: =?utf-8?q?1594298563831180783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding kernel support for restool, a userspace tool for resource
management, means exporting an ioctl capable device file representing
the root resource container.
This new functionality in the fsl-mc bus driver intends to provide
restool an interface to interact with the MC firmware.
Commands that are composed in userspace are sent to the MC firmware
through the RESTOOL_SEND_MC_COMMAND ioctl.
By default the implicit MC I/O portal is used for this operation,
but if the implicit one is busy, a dynamic portal is allocated and then
freed upon execution.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/ioctl/ioctl-number.txt        |   1 +
 Documentation/networking/dpaa2/overview.rst |   4 +
 drivers/bus/fsl-mc/Kconfig                  |   7 +
 drivers/bus/fsl-mc/Makefile                 |   3 +
 drivers/bus/fsl-mc/fsl-mc-allocator.c       |   5 +
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  19 +++
 drivers/bus/fsl-mc/fsl-mc-private.h         |  56 +++++++
 drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++
 8 files changed, 314 insertions(+)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 6501389..d427397 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -170,6 +170,7 @@ Code  Seq#(hex)	Include File		Comments
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
 'R'	C0-DF	net/bluetooth/rfcomm.h
+'R'	E0	drivers/bus/fsl-mc/fsl-mc-private.h
 'S'	all	linux/cdrom.h		conflict!
 'S'	80-81	scsi/scsi_ioctl.h	conflict!
 'S'	82-FF	scsi/scsi.h		conflict!
diff --git a/Documentation/networking/dpaa2/overview.rst b/Documentation/networking/dpaa2/overview.rst
index 79fede4..1056445 100644
--- a/Documentation/networking/dpaa2/overview.rst
+++ b/Documentation/networking/dpaa2/overview.rst
@@ -127,6 +127,10 @@ level.
 
 DPRCs can be defined statically and populated with objects
 via a config file passed to the MC when firmware starts it.
+There is also a Linux user space tool called "restool" that can be
+used to create/destroy containers and objects dynamically. The latest
+version of restool can be found at:
+        https://github.com/qoriq-open-source/restool
 
 DPAA2 Objects for an Ethernet Network Interface
 -----------------------------------------------
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index c23c77c..66ec3b9 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -14,3 +14,10 @@ config FSL_MC_BUS
 	  architecture.  The fsl-mc bus driver handles discovery of
 	  DPAA2 objects (which are represented as Linux devices) and
 	  binding objects to drivers.
+
+config FSL_MC_RESTOOL
+	bool "Management Complex (MC) restool support"
+	depends on FSL_MC_BUS
+	help
+	  Provides kernel support for the Management Complex resource
+	  manager user-space tool - restool.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 6a97f2c..9a155e3 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -14,3 +14,6 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      fsl-mc-allocator.o \
 		      fsl-mc-msi.o \
 		      dpmcp.o
+
+# MC restool kernel support
+obj-$(CONFIG_FSL_MC_RESTOOL) += fsl-mc-restool.o
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 452c5d7..fb1442b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -646,3 +646,8 @@ int __init fsl_mc_allocator_driver_init(void)
 {
 	return fsl_mc_driver_register(&fsl_mc_allocator_driver);
 }
+
+void fsl_mc_allocator_driver_exit(void)
+{
+	fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
+}
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 1b333c4..240b99d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -792,6 +792,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct fsl_mc *mc;
 	struct fsl_mc_device *mc_bus_dev = NULL;
 	struct fsl_mc_io *mc_io = NULL;
+	struct fsl_mc_bus *mc_bus = NULL;
 	int container_id;
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
@@ -863,9 +864,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	if (error < 0)
 		goto error_cleanup_mc_io;
 
+	mc_bus = to_fsl_mc_bus(mc_bus_dev);
+	error = fsl_mc_restool_create_device_file(mc_bus);
+	if (error < 0)
+		goto error_cleanup_device;
+
 	mc->root_mc_bus_dev = mc_bus_dev;
+
 	return 0;
 
+error_cleanup_device:
+	fsl_mc_device_remove(mc_bus_dev);
+
 error_cleanup_mc_io:
 	fsl_destroy_mc_io(mc_io);
 	return error;
@@ -878,10 +888,12 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc->root_mc_bus_dev);
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	fsl_mc_restool_remove_device_file(mc_bus);
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
@@ -931,8 +943,15 @@ static int __init fsl_mc_bus_driver_init(void)
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
+	error = fsl_mc_restool_init();
+	if (error < 0)
+		goto error_cleanup_mc_allocator;
+
 	return 0;
 
+error_cleanup_mc_allocator:
+	fsl_mc_allocator_driver_exit();
+
 error_cleanup_dprc_driver:
 	dprc_driver_exit();
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index bed990c..d6f67a8 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,6 +10,8 @@
 
 #include <linux/fsl/mc.h>
 #include <linux/mutex.h>
+#include <linux/cdev.h>
+#include <linux/ioctl.h>
 
 /*
  * Data Path Management Complex (DPMNG) General API
@@ -405,6 +407,24 @@ struct fsl_mc_resource_pool {
 };
 
 /**
+ * struct fsl_mc_restool - information associated with a restool device file
+ * @cdev: struct char device linked to the root dprc
+ * @dev: dev_t for the char device to be added
+ * @device: newly created device in /dev
+ * @mutex: mutex lock to serialize the open/release operations
+ * @local_instance_in_use: local MC I/O instance in use or not
+ * @dynamic_instance_count: number of dynamically created MC I/O instances
+ */
+struct fsl_mc_restool {
+	struct cdev cdev;
+	dev_t dev;
+	struct device *device;
+	struct mutex mutex; /* serialize open/release operations */
+	bool local_instance_in_use;
+	u32 dynamic_instance_count;
+};
+
+/**
  * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
  * @mc_dev: fsl-mc device for the bus device itself.
  * @resource_pools: array of resource pools (one pool per resource type)
@@ -413,6 +433,7 @@ struct fsl_mc_resource_pool {
  * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
  * @scan_mutex: Serializes bus scanning
  * @dprc_attr: DPRC attributes
+ * @restool_misc: struct that abstracts the interaction with userspace restool
  */
 struct fsl_mc_bus {
 	struct fsl_mc_device mc_dev;
@@ -420,11 +441,18 @@ struct fsl_mc_bus {
 	struct fsl_mc_device_irq *irq_resources;
 	struct mutex scan_mutex;    /* serializes bus scanning */
 	struct dprc_attributes dprc_attr;
+	struct fsl_mc_restool restool_misc;
 };
 
 #define to_fsl_mc_bus(_mc_dev) \
 	container_of(_mc_dev, struct fsl_mc_bus, mc_dev)
 
+#define RESTOOL_IOCTL_TYPE	'R'
+#define RESTOOL_IOCTL_SEQ	0xE0
+
+#define RESTOOL_SEND_MC_COMMAND \
+	_IOWR(RESTOOL_IOCTL_TYPE, RESTOOL_IOCTL_SEQ, struct mc_command)
+
 int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
 				   struct device *parent_dev,
@@ -438,6 +466,8 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 int __init fsl_mc_allocator_driver_init(void);
 
+void fsl_mc_allocator_driver_exit(void);
+
 void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
@@ -472,4 +502,30 @@ int __must_check fsl_create_mc_io(struct device *dev,
 
 bool fsl_mc_is_root_dprc(struct device *dev);
 
+#ifdef CONFIG_FSL_MC_RESTOOL
+
+int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus);
+
+void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus);
+
+int fsl_mc_restool_init(void);
+
+#else
+
+static inline int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	return 0;
+}
+
+static inline void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+}
+
+static inline int fsl_mc_restool_init(void)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/bus/fsl-mc/fsl-mc-restool.c b/drivers/bus/fsl-mc/fsl-mc-restool.c
new file mode 100644
index 0000000..21ecee5
--- /dev/null
+++ b/drivers/bus/fsl-mc/fsl-mc-restool.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management Complex (MC) restool support
+ *
+ * Copyright 2018 NXP
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+#include "fsl-mc-private.h"
+
+#define FSL_MC_BUS_MAX_MINORS	1
+
+static struct class *fsl_mc_bus_class;
+static int fsl_mc_bus_major;
+
+static int fsl_mc_restool_send_command(unsigned long arg,
+				       struct fsl_mc_io *mc_io)
+{
+	struct mc_command mc_cmd;
+	int error;
+
+	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	error = mc_send_command(mc_io, &mc_cmd);
+	if (error)
+		return error;
+
+	error = copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	return 0;
+}
+
+int fsl_mc_restool_init(void)
+{
+	dev_t dev;
+	int error;
+
+	fsl_mc_bus_class = class_create(THIS_MODULE, "fsl_mc_bus");
+	if (IS_ERR(fsl_mc_bus_class)) {
+		error = PTR_ERR(fsl_mc_bus_class);
+		return error;
+	}
+
+	error = alloc_chrdev_region(&dev, 0,
+				    FSL_MC_BUS_MAX_MINORS,
+				    "fsl_mc_bus");
+	if (error < 0)
+		return error;
+
+	fsl_mc_bus_major = MAJOR(dev);
+
+	return 0;
+}
+
+static int fsl_mc_restool_dev_open(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_restool *mc_restool;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *dynamic_mc_io;
+	int error;
+
+	mc_restool = container_of(inode->i_cdev, struct fsl_mc_restool, cdev);
+	mc_bus = container_of(mc_restool, struct fsl_mc_bus, restool_misc);
+	root_mc_device = &mc_bus->mc_dev;
+
+	mutex_lock(&mc_restool->mutex);
+
+	if (!mc_restool->local_instance_in_use) {
+		filep->private_data = root_mc_device->mc_io;
+		mc_restool->local_instance_in_use = true;
+	} else {
+		dynamic_mc_io = kzalloc(sizeof(*dynamic_mc_io), GFP_KERNEL);
+		if (!dynamic_mc_io) {
+			error = -ENOMEM;
+			goto error_alloc_mc_io;
+		}
+
+		error = fsl_mc_portal_allocate(root_mc_device, 0,
+					       &dynamic_mc_io);
+		if (error) {
+			pr_err("Could not allocate MC portal\n");
+			goto error_portal_allocate;
+		}
+
+		mc_restool->dynamic_instance_count++;
+		filep->private_data = dynamic_mc_io;
+	}
+
+	mutex_unlock(&mc_restool->mutex);
+
+	return 0;
+
+error_portal_allocate:
+	kfree(dynamic_mc_io);
+
+error_alloc_mc_io:
+	mutex_unlock(&mc_restool->mutex);
+
+	return error;
+}
+
+static int fsl_mc_restool_dev_release(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_restool *mc_restool;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *mc_io;
+
+	mc_restool = container_of(inode->i_cdev, struct fsl_mc_restool, cdev);
+	mc_bus = container_of(mc_restool, struct fsl_mc_bus, restool_misc);
+	root_mc_device = &mc_bus->mc_dev;
+	mc_io = filep->private_data;
+
+	mutex_lock(&mc_restool->mutex);
+
+	if (WARN_ON(!mc_restool->local_instance_in_use &&
+		    mc_restool->dynamic_instance_count == 0)) {
+		mutex_unlock(&mc_restool->mutex);
+		return -EINVAL;
+	}
+
+	if (filep->private_data == root_mc_device->mc_io) {
+		mc_restool->local_instance_in_use = false;
+	} else {
+		fsl_mc_portal_free(mc_io);
+		kfree(mc_io);
+		mc_restool->dynamic_instance_count--;
+	}
+
+	filep->private_data = NULL;
+	mutex_unlock(&mc_restool->mutex);
+
+	return 0;
+}
+
+static long fsl_mc_restool_dev_ioctl(struct file *file,
+				     unsigned int cmd,
+				     unsigned long arg)
+{
+	int error;
+
+	switch (cmd) {
+	case RESTOOL_SEND_MC_COMMAND:
+		error = fsl_mc_restool_send_command(arg, file->private_data);
+		break;
+	default:
+		pr_err("%s: unexpected ioctl call number\n", __func__);
+		error = -EINVAL;
+	}
+
+	return error;
+}
+
+static const struct file_operations fsl_mc_restool_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = fsl_mc_restool_dev_open,
+	.release = fsl_mc_restool_dev_release,
+	.unlocked_ioctl = fsl_mc_restool_dev_ioctl,
+};
+
+int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_device *mc_dev = &mc_bus->mc_dev;
+	struct fsl_mc_restool *mc_restool = &mc_bus->restool_misc;
+	int error;
+
+	mc_restool = &mc_bus->restool_misc;
+	mc_restool->dev = MKDEV(fsl_mc_bus_major, 0);
+	cdev_init(&mc_restool->cdev, &fsl_mc_restool_dev_fops);
+
+	error = cdev_add(&mc_restool->cdev,
+			 mc_restool->dev,
+			 FSL_MC_BUS_MAX_MINORS);
+	if (error)
+		return error;
+
+	mc_restool->device = device_create(fsl_mc_bus_class,
+					   NULL,
+					   mc_restool->dev,
+					   NULL,
+					   "%s",
+					   dev_name(&mc_dev->dev));
+	if (IS_ERR(mc_restool->device)) {
+		error = PTR_ERR(mc_restool->device);
+		goto error_device_create;
+	}
+
+	mutex_init(&mc_restool->mutex);
+
+	return 0;
+
+error_device_create:
+	cdev_del(&mc_restool->cdev);
+
+	return error;
+}
+
+void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_restool *mc_restool = &mc_bus->restool_misc;
+
+	if (WARN_ON(mc_restool->local_instance_in_use))
+		return;
+
+	if (WARN_ON(mc_restool->dynamic_instance_count != 0))
+		return;
+
+	cdev_del(&mc_restool->cdev);
+}
-- 
1.9.1

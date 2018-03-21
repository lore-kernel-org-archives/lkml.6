Return-Path: <roy.pledge@nxp.com>
X-Google-Smtp-Source: AG47ELtYsvBPUy8biuIrYOPYSRgKFm7GuMnrITlMAmPx4DEaiRSPhqAJAWrKvBidmwJzcAJhymkq
ARC-Seal: i=1; a=rsa-sha256; t=1521643327; cv=none;
        d=google.com; s=arc-20160816;
        b=xjkWIXUNeRGoUfYKyupPwXEaYd6KyiLeOIxxuRVk5p0bavLdqbiCi2tRz57LEC2SRC
         sfX1Ab6hQy6shoFzAEvEnFgQvee48M0vz6CJDi+iPLgFoGcT1Fo0JWGziOTS1RF3jnjO
         njl5ZOG9htPZKkkCwflp2qGbLPxrOWfw/Kf9+yQKN2Hat51KSWrgZWSk8LUwTWa2zqQf
         UDYZDeN2Fq9LnryYYS5nxy9sJYCQwckTSaXyD6z2stOW1jl2Tt1G0ySRs/Re4QgnYSjX
         gitvV+NAC04iBXZ06FnmOkaQ2OpwxEJwJE2V3zomnqPzd9dmupfrbBZV/jxA9gOfXXRQ
         HBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3QJ5QSbMMXfalg6ZR1Uc56KPcZoSFmO7YFJhXyFsv3I=;
        b=VUynMMmpwZlJr9cz72GZMjDHfAnPvSMSCdi0JcLZVbS2bCpo/JkftcWSDiouRdKtOv
         sBLG825KpKXLuXkpzHXr19IZCWEf1IF5tPlHhc/DVnpdLLRKN6Yr2ler+iRqT2vuNaBd
         JTO1BheWzsNI5e91QmR7VLaLhM1U5cN7S/bYUbwiHlY6337FCsUFChKuG8nXg9NZRYEc
         cHAqW7s80TInD7HSrak3NyhWQBd8kQg4FqXWrNK267obvghfTj2Iy7kvrOD8hesmHnUW
         Ycq7Ufg5Pwt//atLdxnoTy0qtOl1TowNzVTFNRBT5ClhMgV3iRK170fJJC0Ex4S1w+kv
         H0zQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=c6kPueS/;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 104.47.1.89 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=c6kPueS/;
       spf=pass (google.com: domain of roy.pledge@nxp.com designates 104.47.1.89 as permitted sender) smtp.mailfrom=roy.pledge@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	ruxandra.radulescu@nxp.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	leoyang.li@nxp.com,
	laurentiu.tudor@nxp.com,
	stuyoder@gmail.com,
	catalin.marinas@arm.com,
	Roy Pledge <roy.pledge@nxp.com>
Subject: [v2] staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
Date: Wed, 21 Mar 2018 10:41:39 -0400
Message-Id: <1521643299-18231-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
Reply-to: roy.pledge@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: SN4PR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:803:20::24) To HE1PR04MB3001.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a072a77-2821-484c-cea8-08d58f39e8f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3001;3:nzGYurpwigvOOgkCROgvYOWpnVACubJOifnn4RVfyYqXKpBcR8+VtQLSqTFwNJQnFqWheck6xUO5ayAVqx1pFdFthWcClMu+HhXNNrz7twjE9RImj+8cspffvRANunCcCZv3ij8SWZdh8nD25/4nWAUA5AkHs+Cmso3S2s+H9pWZ4a+UIHg40YY705I7tSd27xCmVDu4oJJ2AK1xfCdIx5gqd99GYRErpuzA5HOsUl5eX2DOeCsKHfBhOwMY//fw;25:rih7S18t42LDX/QJ+HurB7tNFboHw9ERuSswtOMpD+CVSzmPfZ86z2B0V0tW/H385C7KefkV8hKhOuCerzt6Xs9L4NTQaUS9FOJvwqRI3HtEGQ0Gy2D1k9lBURFcqpEn3WDoWZe2KeuR8a5UapZRx09r45Q069kNgFZJkfhE8Nh9uvnXlPQP6i4dYGv/DU2mClLGYkbxdEA3F42hT7+q4jr3RDLpyLZQdoQD83lrWhs94k2IDBhsSnQoKTMeWfqxwjbtkdYTtgL1bnE+FP/flyMYrjqiy/F6IK/aztkUnLJvDFCXyagBQ78h94P1oqwKDZA4uRyRnt7L51JF+x+U3Q==;31:InTzo9PxQ00ZcHBtvZyaj4u5/zvjsFcpWNS45z5AG8DAWzu5Uucfk3eQ1nIERHIBn0E2TkzNvlmuCl5Bu5j0h8hkycVJJfYMGQarCLgaAiyVjCkEYt1HwfVAN8fJLfbRbUOJ/ouV41CFVAmHONkHCoUDw5kfNjz7G915ZlH2qykfCissgOExMOa0CsyyOb2UZm9VXV2CmW7pHk8PMY67uuUa7p3y5LYauvx8LFM7qjM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3001;20:eWdo9wcLOzZoCq+AFtf8OUSJDyPXDtGFieTY79jc1hUh5FDKOJeGWw2wqRBd5busQau5FudvdJTChza3E02x5wOGFByCPOX39V1Lw85gd5N9vJSdKHZ31XVU36/ABc1f7cTG2BFBp829jo0XBnj4gSHwIm6kTVMVaHyz6sOiNSKo/RmJMno3JhiRtHV0GgPdUoSZwy2q/ztKaceQNHm/BK6VrFgfS3KBJrDt0ozTeUiqTmTr78+PGwfEK7WFd5iAG9lLuZoyR1tdfp+80h863/Bk+MZ8Ze2HfyYZO8fZyKVRUcq3Mb6XqotREOt+gj+W1DKL6s/cjtO1ogrCNzCqb2yXPXCfJIm2OrCVMsx5nc7qnBwcWLQ9I5owh/+XIi/Vlo5UTezfUgsHXtrcIkDbhNsZzPpo+4ar3rQG0qfZQk5PVC9O0hspbv3DN3ab8VJKrRORBdH4yQmZ9kF4Jq/jUNefoTh7ZOqmqcn0Bg5f7XnMGFeNjJ/HMZxaE6zLjmbS;4:iZ6Rgvga5W5dBXiMu1vtOkeGbU3bZhDBwktanRthVskdLKiDDgz35Ivq1C4Z+bPU/E+uFjAQyNG1K1GjKZ8p+l4fhRGjJLXp89VxDx3X4ojSJgohfaVxIs83EtISuWRugc7ejsIb7I2mb9g3FG6kvEqnLC37Ycjeas1Z4Kh3SCiFKC6zOa1r0/A+PUnrw0iWud0WpIy2eCAGRMgRzgq2ic0JFHmAijEz2VP92EQe1IhGsIXzu9yP2wAm31+nSf1wWH6TZ7w+OK5xHAtwucZkCRWUW2PTJaqFVakUdu5gno7exZHCjswkmo5UFA974VLnoKZBba6UIkfgDMPeMRYycN99NOWUDDLq+6yD+hxRaO4=
X-Microsoft-Antispam-PRVS: <HE1PR04MB3001BD51555D0DE0CC86FB3D86AA0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501324)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR04MB3001;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(366004)(39380400002)(189003)(199004)(16526019)(186003)(36756003)(26005)(478600001)(48376002)(53936002)(51416003)(8676002)(316002)(50466002)(81166006)(81156014)(6116002)(86362001)(3846002)(386003)(97736004)(59450400001)(50226002)(52116002)(8936002)(6666003)(6506007)(5660300001)(68736007)(4326008)(39060400002)(16586007)(25786009)(6486002)(43066004)(7736002)(105586002)(3450700001)(2906002)(66066001)(6512007)(106356001)(305945005)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3001;H:otc-sw1.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3001;23:DaMryckgAc8lS2j1FQKcyo7nDz04Qe1pFwOQdwmKV?=
 =?us-ascii?Q?qIOTjbmeAc2PNksXdhLdg7Vo56RKVWdXDzTFBT0SPrrrBg95CJlFPlvBAsl/?=
 =?us-ascii?Q?bCSzohWbBDco8nAzbRSZ6OrxKk+AK6vf5bjlqd6ADJaTbxg7+P6XKy0KnoP1?=
 =?us-ascii?Q?5Ogz+UpE83h97Ruueef15ecci483VmEOw/ZcptZOSH2hvlGcMbEapquOiLJr?=
 =?us-ascii?Q?zcp38kKqtdp7rqXP+fZT1hU4pfqrvmRAqd5dr/Uy86SFUgp7sEAds5X6Ufxt?=
 =?us-ascii?Q?hwD2MRBx0VPe1Ch4wvtXLCnRsVjn7mGd4mN5kieU3Nb4qISbuPKUDGIy5Xb6?=
 =?us-ascii?Q?MY7TKHXKBwdf0KIAxSjBOmJSdAmvDNfqz7dZsZDnM5Tvap2YRSkh3demQnqq?=
 =?us-ascii?Q?ZHDwmZIfE1tUmuIh0TC5l5acibw6+4Vxz7bapJK23jva4/e7dkfSWrduQbuc?=
 =?us-ascii?Q?gqHSSe3lxErZuAk4wTfJo4Tqae5ZZpbB41fciLoVySYN8TqBgMBqgz6YiwX4?=
 =?us-ascii?Q?1W9JXDJ/LHi7zzMXXTtRGwychclucGH76MDfPFMvwlkECCDGG7d3ZeEPR8f7?=
 =?us-ascii?Q?oGCk7/9j2R2Y2qn+qQuzgtihcFBtZFMxuKxjtrDigpgKyPDq3jPEVCuiGVO3?=
 =?us-ascii?Q?vFAaT+3C/xJFuvDvDlVCKAroGWhAWKoFCsjmOfmHbr4dTfZT+29nT0vpImcH?=
 =?us-ascii?Q?PHqsJLBG/jRhRDHL0WZpah8kyrR2oNZxPjB6hrDZXJJgpLLQr6AIhoQo0cH2?=
 =?us-ascii?Q?k+dsSD6WMVlvtOOik6b3eq4jBnfepCsCe4y1jzZofGLEBbz5mE6aHiw2vesh?=
 =?us-ascii?Q?0bpsRwijfy2hG7LWvnN2wyotxhTiIW1imT1xd4rA+mPTrs8/79MMNyZy7bNB?=
 =?us-ascii?Q?5H02S8BswDYjVXc2TJ0LrtD1lawP+b2B+YKbvOSYiWGnWbHNVlKP8jclTYzW?=
 =?us-ascii?Q?sBse7Nx2B3zqnApzH2uRWJPoaKtYkzVUAwB/gUogvLNf/fWB0nHx8z9FfCTw?=
 =?us-ascii?Q?rj71y3qnuX/HvJ0PExoEsi0jL8dPgjN+3EzuxtuKmMSrlkS5TOF1CmBYDS8g?=
 =?us-ascii?Q?l5VJOA+L95XsoM5WDE/TvZ2i3PEKQVNSDiQ+ACFMqXsRk4jKrPc0xp0fHByq?=
 =?us-ascii?Q?W7KqI9BVMb8k4gjTbZprdnwMxyQMArY?=
X-Microsoft-Antispam-Message-Info: wV5pKXYRh8Vmfi/OEVV+6U+Z+g3q/ZogXyw78IwYjq1pt75G3brDCQDHmyX0rTJmiOKlVrj1yBx1IWevVVeqZgL0EMLRopuak39tlKH3Fh5rnvZlRZvjDVLQkg0M1t19CEHgAh3q4fEWCw2mNPegVK26dAf6Z9219Tb696ygsewA3YJgEj04tN7yentxELvz
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3001;6:/FBKho4Pv4FXCPH+L1sKXV6aMESJQMmbc/riDdAtGUDgD9W4cdxXsUE9JyF2Nn3CCR0JJkAzWQ78jg0bt5QzvJmTS9EtvGHTCxwtyC1MJWNK4xOAerSij78O3BRcw3onLtzN1qWXeJEjc3Moay5v0ty5MMxSea2qqsghpX6Jg890oN5/aAKljbLK63Z/LGvQpIsfHGSL/lmCfnbtSMg9KSe+2YH5XN5orf0/9ho/Huv1CxY4Ff1ffH8pYMVRwg6y7NgR6R9C2TJLP+RN/Ts8gEOC3OV3jsfOO+gv3I8s9MxX9n6r51bwjn4V65UBFXhGEYP8rMzXgyz3ZI+zcC6pD+EY8LYat2XxkD7K7n239BY=;5:4sWCn5oSksXhUDH89TXVkQ6DZzbkb746JuxBDWpGVdkMRedqqgl94bBXaKf0pxFWKHjL99OnIns0yamXo0KHiG3eWod1AwDJT9IUIg1ANuU4oz0L7X9/ofczlTc9dwdUuQbSZU5UM/cHHxHqhib3Yqi+F6ipJmUACPqiiJttwAE=;24:pAoFrVKNnQEWKC7VFbXakP9EqhfNeJvgDmT6ijqtLGVtMZ28A+40S4kIGxo2WZ3XQbBhBZvtzzmBxTNJXnGxeXc/hNyWRcSwH+CmvJVeXKg=;7:W/xtXG2HYEiKdP5LEzOBffrEg4/IOMujnINIY4ZccbmIgYolj23W+sM4uNANKBSynhMEDWfzjVydz/ylxWrxiHSlJsJsXiBZ6LHbkyCjSm3K58A3V+3wNj10n3+guUTjhps6RGN42GIDlBIPkDU6ye3LyTsmxuQwQhPIivPW8srhEqGjEgsfcmB750RUJMLdfU945fQhgBMXMtNglwsCfqoGzMtQGzaQ+9vfUJhyRB9PZ+JElm0/81GLj1ul4C2f
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 14:41:59.7789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a072a77-2821-484c-cea8-08d58f39e8f8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595558673233751593?=
X-GMAIL-MSGID: =?utf-8?q?1595558673233751593?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

---
Changes in v2:
	- Fix minor conflict in latest linux-next branch
	- Generate patch using -M so patch is smaller
---
 MAINTAINERS                                                        | 2 +-
 drivers/soc/fsl/Makefile                                           | 1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile              | 0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h            | 0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c         | 2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt       | 0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c        | 2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c                | 0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h                | 0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c        | 2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h        | 2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                     | 4 ++--
 drivers/staging/fsl-mc/bus/Makefile                                | 2 --
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h     | 0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h | 0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h     | 0
 16 files changed, 8 insertions(+), 9 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc74106..e2f234c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4375,7 +4375,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/Makefile
rename to drivers/soc/fsl/dpio/Makefile
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
rename to drivers/soc/fsl/dpio/dpio-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
rename to drivers/soc/fsl/dpio/dpio-driver.c
index 182b384..732f025 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -15,7 +15,7 @@
 #include <linux/delay.h>
 
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 
 #include "qbman-portal.h"
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
rename to drivers/soc/fsl/dpio/dpio-driver.txt
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-service.c
rename to drivers/soc/fsl/dpio/dpio-service.c
index 14ed2be..9b17f72 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -6,7 +6,7 @@
  */
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.c
rename to drivers/soc/fsl/dpio/dpio.c
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.h
rename to drivers/soc/fsl/dpio/dpio.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
rename to drivers/soc/fsl/dpio/qbman-portal.c
index 116fafb..cf1d448 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
+#include <soc/fsl/dpaa2-global.h>
 
 #include "qbman-portal.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
rename to drivers/soc/fsl/dpio/qbman-portal.h
index 4488a44..b2eed20 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -7,7 +7,7 @@
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
 
-#include "../../include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct dpaa2_dq;
 struct qbman_swp;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index b8990cf..24ae387 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -37,8 +37,8 @@
 #include <linux/if_vlan.h>
 #include <linux/fsl/mc.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 21d8ebc..2141e4b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,5 +5,3 @@
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-fd.h
rename to include/soc/fsl/dpaa2-fd.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-global.h
rename to include/soc/fsl/dpaa2-global.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-io.h
rename to include/soc/fsl/dpaa2-io.h
-- 
2.7.4

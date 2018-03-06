Return-Path: <ran.wang_1@nxp.com>
X-Google-Smtp-Source: AG47ELvDdeuAE2JE6LNvzqjzwar4Q/6M6NgybdoT9QCnMQfeGGoeyWb3t84WjyocHZ2NO0HQmS9p
ARC-Seal: i=1; a=rsa-sha256; t=1520340946; cv=none;
        d=google.com; s=arc-20160816;
        b=KV1ZqwYkAqDJ4b6C5imwAP89wpWsalqVtQDjdX/fYDl/UeUnJW3IhFT9P5Cbx5G/Xq
         SUP7kk6FS5hMKASKgqdUoOVcC9ovU92QDEKsyuDeHKKf6/BjE3h9RoXIhSxuo2L3qFBn
         ubHO4z/iTMB+GkPo4+jcW3ZjkTnxVpAztgTTapxUpAntlAH6F50Bk1PrLLObRc/kIG6t
         DgEFXT/aRblWAkZtfqD08WauXgAlYNzm+o4LOyOzqaQ93Zk8QlI1ON/WAKpff8tjMQVI
         HLdi8iQmhduvtOTOJjKfv7rC7f2l7pkGuWUdNd1q3vxUJBJnVvJFg+SZFK/eUfV85J5w
         2lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:arc-authentication-results;
        bh=CRQ4YWDOOLD3glcLgTbcpExGWVLZwYNc14wic/l2CoA=;
        b=pIV/2+5Hw2M6OoldkdWG+Ae/l4WsHl3LahE1zxv4cO8jnjqRktlyecm2Fjrjhj6DEh
         /fK+JrQskieRjMR9YJNKwaaHeNkhvwxAzlJ0AVsWSjVBcgu/VsFng58RRSRkl8M52PuN
         wCzlT07uNfZIlqabESq3x455OQjvy8qWZKCl5WCau1UxBTOwiLGAQA0SjGLScXboDA9U
         QeCOBaxUjhiMBtbhaJvY4owHmyMVyFcw70whoCTBPN5mOgGdX5RhanQX8oZP29K5tpCF
         klXRQv2g9izI7/qXSbkm/u9Cy8nvJEs1WRM/VqY/5boTDyN1pKFQiJglYiAIY3XYJzNu
         mECw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.41.69 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.41.69 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=fail action=none
 header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Felipe Balbi <balbi@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Li Yang <leoyang.li@nxp.com>
CC: <ran.wang_1@nxp.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH v5 1/3] USB3/DWC3: Add definition for global soc bus configuration register
Date: Tue, 6 Mar 2018 16:59:09 +0800
Message-ID: <20180306085911.5930-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131648145444895471;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39380400002)(39860400002)(346002)(376002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(51416003)(86362001)(47776003)(1076002)(105606002)(106466001)(104016004)(97736004)(336012)(53936002)(6636002)(6666003)(54906003)(110136005)(26826003)(48376002)(50466002)(316002)(36756003)(50226002)(8936002)(5660300001)(8676002)(16586007)(4326008)(81166006)(81156014)(498600001)(356003)(85426001)(26005)(2906002)(68736007)(305945005)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB0597;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD025;1:LPcS1dFh6wobEN5E7oUXOKk3QOcyWLWrVYmYxnpju9kKioVZ6maVExHPfbU1FI/EVLtPIAOsOzRNT6UnyWQuMbmCQ738YzWA8CHadnELdz5jX/UFwC7C7QHhcopvG0at
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a93633-d7c7-4a93-998e-08d583619309
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BY2PR0301MB0597;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0597;3:oTaYhFLtywv0blYeaw2Wonm9RtttB1MKvLGjj/0KMSxNQW0HikQEmTmBvGFVyl4DNlz4EtUTKrKs2cuYMtcbxdoAK2pTvDLZhre+7656pDk9/9o/2v1Mp7j4372aU/ZBtWvHhVqX77ifWEVWokQIOeQjrUgKIzfgo5wwzMGEyYltMR7oxMoT+9FpoHYsiR7YSo3HM10CejubTyYOR7L4rVyTMP/FSn734a/LWbIyjYvMaFrT3VHhQ9lKvmdvM7YeTuanrIQFa00E+98pzv8mrUeRd5a83wHXSjHKbxA3XShSuMw8hF7vo5Rd41d1bBhF0aS3GILODQb313umIE2Om2rF71D27Sl599O3bf7HYFk=;25:Y5vQ5iCDIJf4cPhOmTeolGmzU3v/TtCyHv8XF1bSSV1KSn9xqViWvV97ENLjoEpFX9MTTN8Q26Z46koYR4FvcqseNg1GtrZesVbGH0xGrPGh4jB4beVNZapSFQUI3gHHGw6Rzga3/p64er/mxDXI7LUaTpDVRL+1S8sJk9IzUG1HOo+G0ybVyGS52WcJ1ZGs2Y1Otqoa1wlLbLsu1zC4/Ov3Nm1prlj26OpasaaWaOS/hZUWoysZBgq8JZgVCCCsp88Q6U/eUEWVGIu9ZDc1HP0aFSiVUb2LV9eadjfuXxG2i8s48wMruViW3N3pu3WOBXjtSEQc4DdwRQmQax2wkw==
X-MS-TrafficTypeDiagnostic: BY2PR0301MB0597:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0597;31:RoEBnJ60+qftsXAsqcWhm6r0Jgl82CCzeTUAkLGdd15iCwU+VVLuymyLl6WnRnaewoSl8AEiU23UOPQA39yzKdkLMwPJYqITQIMsU9MUQ65C5HhW8t2roQ3GpeGhsYQ3F/Tw2IKrAL719rXRsIG01j2KBC8Szs/9RqTAf6wtLQPL7xsB53FKCsigZNNn6k0FD0n1LiuHL5DYeZVU0ZD6Mw5WtXtUf91vo1Bd678nm04=;4:iA+hlmwTS5iT3BhAunfv7x2YQELpbHPB5+YlgiveWoU21Rc6zl+l2kDAOig6Gh/lWw1yivbrjpBFrXhj4Ew4WuOpPwwXKF3ZpvJTC6l2OT/lcd3ymgrsGnWewuW4aNzDBE8MNhEneqSWmfRlcZMgvieFhrdwaT4E4bfoB7LfIPe3Lb2VvJ3804X35MabcilqwL786/AFfw05hASV8As6x9HbMJRGMcIX0jvmnFSPjJUA9wRbXeoXBE7Z0mL33A7qlAM0eZ1DNxUoThaM1FKM1k2eHVPipDMPdG9zJfLa/7ZamwCIvlcN34kFaDqdHNwf
X-Microsoft-Antispam-PRVS: <BY2PR0301MB0597A0C34380AAF6A3D13EB5F1D90@BY2PR0301MB0597.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6096035)(20161123561025)(20161123563025)(20161123556025)(20161123565025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BY2PR0301MB0597;BCL:0;PCL:0;RULEID:(400006);SRVR:BY2PR0301MB0597;
X-Forefront-PRVS: 06036BD506
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB0597;23:er942R07+BSPQAjDQJT9Zhu+EqByKeIBAjEy7Cy?=
 =?us-ascii?Q?KhauwQ4Ra7M2dPmu3xC56lrn1lRpmjGdbSPvPsqLQC4zXWCDG5yYTPPD/Nj8?=
 =?us-ascii?Q?slXksIU3RaIrMNejv1b0BNKYjCgWHxDXCcavrfb+mRnzxCx7nqF50HfhMtAx?=
 =?us-ascii?Q?edqHG5b7aW0vUkqz++pNv9Zu+q7wF6Rm3SbgvVRo2FGyEg/WrtXs5j6uz91g?=
 =?us-ascii?Q?8e4RGbOUP4SUABFj2rU+m+d7S4kglheCApU4VTTJa5/Z0Di1IUKcuGaVHbVl?=
 =?us-ascii?Q?ph/p72sSu5o6lQdcPPM/e4wTkxiYav89y69tZRb8pHo4KU5suB1aHgLxqnIP?=
 =?us-ascii?Q?Wd4iFPshk/bhXKHSqTh9uHWS94IwjsgK3wZMOMLWAZdULcnL3ZL19shN+PUD?=
 =?us-ascii?Q?qv1dhLw+pl+8jO7XrtTCQXaON+0v7tjzIQCxlFxxaDHKygKBGfbGIC/LFOlY?=
 =?us-ascii?Q?kQhrfwfIqo1s871lc1zTlMIFZPB9DUJEZ19mQaQy6fPTPeaGP7UX6YnHmsNI?=
 =?us-ascii?Q?tY5GX74/0PbkxaOjZbMUb2J8CEcjB9nlwrS7xg6lJ+wHsNLKcg5Cl7HFxloQ?=
 =?us-ascii?Q?dtM7Mak0X46b0E5wPMiL3IR3NTw+xxydcXaGmfQH/PnrCZx7dSsmtNjL6HVf?=
 =?us-ascii?Q?/LKb0/8++4RDgd1XmCdxaIlmlgb2qq+NlC+lC1k3yfQ4seezakEa5qm2F8n8?=
 =?us-ascii?Q?P2MDMLarjMHq6uVCEe9LT3894CCl4xOeutc94rPzauRRp7XHdfJvqnrpJWHA?=
 =?us-ascii?Q?1r1gbmgIQ70ZbKESRLkuF76eTjXXjPdXImaK6uJHCqwpoT52r32Gq8m1WDvA?=
 =?us-ascii?Q?gxxWjUrhgjxwU2sbReddpo1zvfP6K4+HMr+HUx+5IGrh4fN0KdtyQth8F8Bm?=
 =?us-ascii?Q?KKQmObF0EyhMdD5ULCaVHO5widrIWmVqN3B17CN09g9gM5dE3LE5i4Lee2Vd?=
 =?us-ascii?Q?iKk279OgZwMN+PEGy5DDZQ83JEMsKCS2i1R/rian8KSH/Eyi+b1sGp1abzrq?=
 =?us-ascii?Q?CEAMVmR2buIhlu6XLy6e5yR9Wuumc4dYTnMtNUix95xht063sVo4r5Feo8oS?=
 =?us-ascii?Q?Quqwu5C01ZVPBHkg3C+cNjBw3CQdh?=
X-Microsoft-Antispam-Message-Info: IJwUE+Q9IBJBxfUrzrLKJHXY0ah6adfT+SuWmFqOh0b3HF6oo/75XiRPIXWShmz5Spke6Xu5QFc0kSRWjf3Hi4ztA2G5AK6f6dujsRxb0cwz/qdK0j0ZiEN+iyB1QnsB/pcyApN9cFCuX0U0ThlGApUK32SF4T1oNNrMdGTYKSzD3NTj/IHIQRO6R6OdAoG5
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB0597;6:TSeVsFCWGdbbYX7FazHZbrqHcVXJmSOK9cq3+ZxyQc1mkPWtHJx+jWK1N1bsd1qHa16N06VqdqiqkbVqUKgNzWvOPhYj4w+KuvKMqDva1zjzychO73fRUAOCRXBNMuqHaR14MNqzK+LN0GmffIramTqjInMjwi1G0842DddH9B53pPYRPFjmqrvNdn0bBKN4upJ3FLgQDFGkajT/WkA6wQa00Bg99hkZFh8PaO/TORNUqecpb6Eg/2sCkG7BaWFiESFy15N1LHY4o6p+Y34sOgDJOExrZPYPmNXPC4FfZzz+DlSZqryxvEoP1WP/1q94bQefzsmDnu8fc1wYjePMIFjPykO7YfLxj5v8c1AghLI=;5:htYEydSS3T0VIMzrOc5Ys9O43e0lrZrr1DxbxkR6DPQ3ftVjBoO7dZStCIhywj7wszcSggdZIZZXnQKezyzKpVSFpruKfF7tQGxno26P6rZOhuLrY5joxNMT6/k7c91Md++zI1qoJ47DgdtsILxiAgA3DbkV4YQOy8V1BB7AwnI=;24:QLc3xt3F/snZK5UtxpWyXKAEz2w+munAJpcYm3fjQbWPHdvmH9WGmLZwrYo+Du9MmGnf10rge7NXR9xAk5IdVjXMLCwYj4W7bspma7GN+FI=;7:uxvN/ZrIpBkLJY9tXxSoelw1oPRA04IbTC6WAOOy6o7ASexDIxnNTI52R7rgGOowCfxxUqARSZKLjHh/w1ajKa1wSJn35QM0n9lhqRqvm27/sZni2BQnJXbLJlSBPB4lcvNsqs3Bgh+Pfu6hwUul/fhKGrnOEpK5zISszMAW2fDWU65HeoKsiooFB4TVtRM2TbkA7yrf/weesKXoCD23QXuOqfCSQzguZzvTgQ4Pmkc9hoY/RgtYS4eeyQ9cZmzY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 12:55:44.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a93633-d7c7-4a93-998e-08d583619309
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB0597
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594193028765615716?=
X-GMAIL-MSGID: =?utf-8?q?1594193028765615716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changming Huang <jerry.huang@nxp.com>

Add the macro definition for global soc bus configuration register 0/1

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v5:
  - no change
Changes in v4:
  - no change
Changes in v3:
  - no change
Changes in v2:
  - split the patch
  - add more macro definition for soc bus configuration register

 drivers/usb/dwc3/core.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc..8f97f61 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -153,6 +153,32 @@
 
 /* Bit fields */
 
+/* Global SoC Bus Configuration Register 0 */
+#define AXI3_CACHE_TYPE_AW		0x8 /* write allocate */
+#define AXI3_CACHE_TYPE_AR		0x4 /* read allocate */
+#define AXI3_CACHE_TYPE_SNP		0x2 /* cacheable */
+#define AXI3_CACHE_TYPE_BUF		0x1 /* bufferable */
+#define DWC3_GSBUSCFG0_DATARD_SHIFT	28
+#define DWC3_GSBUSCFG0_DESCRD_SHIFT	24
+#define DWC3_GSBUSCFG0_DATAWR_SHIFT	20
+#define DWC3_GSBUSCFG0_DESCWR_SHIFT	16
+#define DWC3_GSBUSCFG0_SNP_MASK		0xffff0000
+#define DWC3_GSBUSCFG0_DATABIGEND	(1 << 11)
+#define DWC3_GSBUSCFG0_DESCBIGEND	(1 << 10)
+#define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
+#define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
+#define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
+#define DWC3_GSBUSCFG0_INCR32BRSTENA	(1 << 4) /* INCR32 burst */
+#define DWC3_GSBUSCFG0_INCR16BRSTENA	(1 << 3) /* INCR16 burst */
+#define DWC3_GSBUSCFG0_INCR8BRSTENA	(1 << 2) /* INCR8 burst */
+#define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
+#define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
+#define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+
+/* Global SoC Bus Configuration Register 1 */
+#define DWC3_GSBUSCFG1_1KPAGEENA	(1 << 12) /* 1K page boundary enable */
+#define DWC3_GSBUSCFG1_PTRANSLIMIT_MASK	0xf00
+
 /* Global Debug Queue/FIFO Space Available Register */
 #define DWC3_GDBGFIFOSPACE_NUM(n)	((n) & 0x1f)
 #define DWC3_GDBGFIFOSPACE_TYPE(n)	(((n) << 5) & 0x1e0)
-- 
1.7.1

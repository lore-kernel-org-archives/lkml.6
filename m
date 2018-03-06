Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELt79pXUzt0xFsUxYkUhSlCsvMRvfjv8fcB7MICKNfKCTTv7w3Zr62Gp8OFe+VQWdRWa2mjE
ARC-Seal: i=1; a=rsa-sha256; t=1520358252; cv=none;
        d=google.com; s=arc-20160816;
        b=nFLeWsxbwwny/DAoclWvIUX2coWKedSpRUwEEvk9Ig10WIdL8RXILWoFxbsTLix4yV
         B2Y9aocLghdslyN6j2BUS7y3IpjNFIQBYd1/Szc8xGhsq+UPrdJT+6TTncKtWSA6EW8r
         pbK25gGJEhQ4961M1NdWm7wPSrmg6FH1WF4qVW/wKvqr8cp/lCUHCRqYwzHe1pd+Kr8t
         +2m7PUGJjcH6GqB8aIwnO6/kbw3jc/tYcJu8r3DcVMVfsD1Jchx1lUIB1g+awH0RpmMm
         7mF8ZZAHXQJr2spaee03TNY/1VndMp5lPuhHRbX8g24ssw0eJQvJPIne/iYDZZbto/zE
         WAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=YjQ5ov1dP4h4x8kvNtoL1+XHJy1TIF0NCDY9fW/8vdI=;
        b=eyhGqQY8UIH7USJmVj79vzqkM631zz8cgQ9xDkrBVCrKRWXnEfU6eH3lSxfF+1VEQr
         UT0yRWGkZ4FGVTcjGEq3gw6WtHGIyfU9RSn2tynT0gJ2H2WbkpwMzALZpyvkflZhFbu6
         IhLNg0PnRCJRnYULUsYS8Y7cn1u2zbw+61BW48RGonqnzcifGujk/dVHM+FlIjIsT2xG
         egCI26BhzWaO/YQBjUPF1+VPWh4ZN5D4+baEbEIEmjS/xeGHPA/RzZ1z1CKtXynFpS2/
         xcp3CTPKSC1nlMT/WVnHyiLrBRKFxLY9TFaclNp//uITwdW3fm/S7PIPKRcI3Namnomj
         KeyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=LFntqFcF;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.67 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=LFntqFcF;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.67 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 3/5] staging: fsl-mc/dpio: Use __leXX types where needed
Date: Tue,  6 Mar 2018 11:43:46 -0600
Message-Id: <20180306174348.26095-4-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 501f19cf-a06a-4546-c422-08d58389de8f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:fFApKO5zJY+mJQnLEMJyobY+Zf3716Z3oUHHkypLWGBk3eFeuLa7yX3AFYJ3HJL09pxv37mgNHFYs8yS/00NYp1ywOuwnZzL5xYknUga9ao92EZFibrFd8+1XGKjtthPsYoc8vwOyh0RV1CcUkULKIDaaNE5pgzJqL22WgXT88VqYcqz9Xmpst20DZb7y/nt9HArlP8JmtIXt/BtyS/1aVKErSqrzQUw8MVlghQaMV2TO4qiyMA8W3XQvHEnNqUL;25:9dxbuqcU9+xWhdzX+6ktYiDfdEP0BmGbDnSvawk1qugJvIdDFi4fta8BdGaM+stFfyB7cl1FGiMPsUYRhOlFUNOZa2A5wzfGCnVX/x28/bOES2JIAVxnl3PZqEJnHOzL2c2C9rXIqqKa7/eLEvv5k8asrWMWQdfwH71q+i0yIog0xbLVFuAv6hPw8Fa6xorhjoQMW38b3LcnvNxHHEj+FtlRDphSaxiOvFtd67FP6t/6yoQ/dl9GTkoYUmpKmE2LgU0aXpmgbvxCt1U/karsH/VcI/HWqOIYMvoPJrviEPF2f+jqeexdxM4exA43zHCk3Q0EGpbIckKftW1HIe2dXg==;31:ilee4ql2kX7mcbPXGXBsJefACQK1YuL1OiHzxHQX92QhlohmKfExzhm4UeI1ZCmg9o7W3ccHTiwLONJb4D8FnWtU1ObVxUmkJqVVFjeKT7qMXe68lywq+NY4n6iPHGOlQ+RkZLxdsEySmTeIauAl4KeUD7ZpFpyI7wshAO67cAG88ny09SufUcspn6sRZzaUq75hyMPWrmZqWyn8xndgcRQLel83jdRjEa06tGw/PCI=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:NE0P5rbDMUaOHLUj3phDFK4aOsw+/+nqLhGPsBfwcprMUyK/aWWzzxLSYlMLasTJNMr0LREXir7ylAQCNsbN0cEiPNBt3bZwuvFi9vlAlo0enKTdaiQXdqax7VmCvqmYQN1H1L+sICHw39XjW5fIJRfTYuaJAaKpj1uVZdxZqCTNWcmZG8AtwliaKvL72NZ42MbsoOZTfNzttvvk10rmyB3ztP19T6YfISVOcDCacCsze4kSyVBc8bYXptdzM5TmI2xYKDj+12wHsZycbzOAGe4lCqeGsP2SHpnTHaT7twzJkg7u/8D137xTcKFjlRtoMZvoVI7Um4LANOU4IwBt4GgyUdJqiIGycBN1Lqi7HgKAutD0/M9eRCSa8HLBFazBakHd0NcBb78+HjLevsUYgIv5Dg7TU3fWd0YKy8dvSr25btpEvDqXDD8S7H9eqRw/aa/SOBH2+exrKcHOfc2OoCYmciF/4wLWg3HbHZXREoj+5yF0g2vkIyw4ZVRM32PB;4:Jq95obgUXqy/BU+PjDozy5f2NneXlVsq5r/p6G5eLt3T88sPE+L3zrDAdBZn34i2Kqog/tifwVzUjk7VaW57CWwf+ojKhlwg7Gx+8o6GEsTA7wSbXqlzRYkPMkbAY6zAQIKrlFeaJr4oYR7Wr1IwjVHZwxQ7MVrm9nZfGb0DFjV5svLcNUYQtTko680K3MhPmtRpZYDI02IpLzXCaN0RrEWs+vnty4luXIDvd5pMeOzS983T4hlgKU+vFDzOyPyUcgN7BgGG4EhrD6+tGIO7JH0drS/LFqzPysX/qeDXsW4r55vV4rkPhbL+pRVEF7aP
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27003B55ECE6E55942A4F5D594D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(76176011)(105586002)(2950100002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:DB2LXclQbF9Ywekiv3+X5AoltF3eeF/MumPqU6U?=
 =?us-ascii?Q?Bs7Dq7GIgT5O3CVAQhshQxWAlZZ+XeDf1CQEvL6fZ8rDorfj6PD2Ze0ublq/?=
 =?us-ascii?Q?8LiQTBog2tQq1V37zSQllFMEOf3sdOVDZGQ4n3xk+gDpZjOJNFCkYySz58Vn?=
 =?us-ascii?Q?7aaLdSMegNlNQtTACXoRSTRewUKtutjmIrKx20Mrh4FyuwkmwNIlXpSWwwXp?=
 =?us-ascii?Q?r2AkvQxW3duPcUvfdcSbnifUfTAyhjjUfreCCQVDuJVo3pQQYmeQgXD4VGQA?=
 =?us-ascii?Q?0smS0x6CD71U8T62U3p5/voFNgIt55PJsIrpgT+lMT9eKIvAvCQj2NCz5DdM?=
 =?us-ascii?Q?cLgIY2uKM/kcYKLI5RThtL7OaZSDk+qSxstTzvWfQdt+AGFJYnF9tdSQGc5h?=
 =?us-ascii?Q?wI1Ii3SEhvq/A6JQXOL4PTVSe1Qyw8HgMXCyd733dAIPtagv3OBP3qS417fl?=
 =?us-ascii?Q?dHM73JdIJbTEd/Ka1/QvO+Fo77jIPm11XHZ3LT2PZrhxK18lUnj0sxRqOB5R?=
 =?us-ascii?Q?LlpsEUsmtOx8xLw4o76BvFMIMoJdzaQeltCRkJk590fKNG0JpRyjdt+5UxIV?=
 =?us-ascii?Q?RKBoUJpwBxvq6SEmkei+pjcY/uW1DpOL1eEChkTOPMZg2F8VGugaqQfQJhfP?=
 =?us-ascii?Q?6eJTa3x6FiBYU32YrlKZgOhTGT0g1tjsHRlgjm7Aqw55o9LnTnw2900xb/eZ?=
 =?us-ascii?Q?ivgSPkquw2pa4csmBiEWqZ16fBKIl/5ggZ1bv62qLh1+cfjg0xpfmjZQa4i+?=
 =?us-ascii?Q?eAg9SegNvYjrDtSYNJEHNr/0Lzer0kjzG3nwoL1dwyg+alpUa8qu+80q8Qr/?=
 =?us-ascii?Q?/JodDwhes3LOD0DcwCDRYIm2sCh8j5xngIC1QveX8FuFE5hQ71oYSdhEoYxd?=
 =?us-ascii?Q?TYiz3C0ENH0Ac7/vj0GCVTS1HtJsBqLpUui0DInGQpInNEBMoq6zkiJen2ky?=
 =?us-ascii?Q?fiIL4tQQTldpL5/F97+MppOsehQTFiQVWtEW2L5Q8LTyovSFVqn13/TwIUA0?=
 =?us-ascii?Q?+V32qX+DfOgmwmU+eTOOIPRk4U3DATUBSvg8m6vlc8wAZphlMax0apCbBs8s?=
 =?us-ascii?Q?4aOr9hVGsXCysmuvCvGUU7L+Fdsnt7tZRSzbOLyiY07PeKXTIkURAXVN3B2H?=
 =?us-ascii?Q?eZpweW1wfbIoJ/xpeq+E90GoFGbJnJLrW8AKSfsfm0kxuHpscq1qZNg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 1DCiC4Mr+hdCANklD4L54QTKoK2S2XV4sbCSmjPDPlMdG/DMKIaV7FufMuP7nsSnfZ+jYY9HedXJrxzl184eScl9Nv8xESMBpYTEJw1IDh1PQ0Cq16nRmD8htDZUXfJU3MMfz3i1OFlK+epD6sESkE+NRX1ECNoSPVhGGjmGR26p7Cx/cpPJTln6lHdcr5ho
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:V4jVpQ9zW0Y29uifw3Slnxmom1yaQV6QY2Rb1wK2+8CM/h2Erz4T0e7UtJXCRWbG57pSTOnYU/6+FcFW7LsGA0lYT/lqBBG26gSZobhl6nxeK7s6dKl33doSHGZdf515WC5iDCEcfb1jFpEhCuf4PfPOsGiHLpoCoKNlO58e2Vbx2szEX86wKnDZgzujNGivRGN5K10Cu10Js3Inq1IKKwPTrP+89YVyBxasn0p76E8un/hruP3VG5eqCKz6hLMtjneiKdYoR+FSG0dQUXclEjoGghqb64y3PuZ0Au4HBH9FNXv62eZkTuhhzn3k/ZmwkSBfhYKXP0+t7hsxKwmHFSw1RdTqCbLjzUjT3uJVlxo=;5:4ZYqnTSQDCCpk0adY9a31OX26/Gaq+ve9OmLGj9SIsAXvIxF/5MkjVj5uHflORO8M8Yl42Ll/gUds0AiUEbzB3FUaIxnxE29tr7Us9RuZxF6RnXYOaO2xZi7UQQhMO7pGscWE/+R6Xq6Y9R8exgjrI/ZXjYTqxL86t9CSKd3kjk=;24:4SV07o4jtjQt5U6xlh4aPweh4Lut5227/eQsgSfTYWyW3QZ5yNfEcFQTp98GBEtomsVd9bB1jIFpT7CCox1yJpIF2t4znR6LyPz8ccD1rjg=;7:xfUurBK3UlDjJVaOB791/qsCJTHf0aweyMSbyyBy4SJF1MwYsYPE7fiFyPsu7bTBqbBLVpvGFOZT/PocAyT5RPrb4rbHyJphnww4Gj2ExEcGZ6l74HW0oS2H1dwS4MlNfbo5nHTC+TzheM9/VuuHIci4xFvo7nQMU4HGokC7piRMaAnSQAQdjAc+q448Wa336/4lf7CXyQIMWdZ/s9uwJSeVXzBCKKEJtPYzS+RpsH716Gi7lt3/nEcUybEgecXL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:09.6452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 501f19cf-a06a-4546-c422-08d58389de8f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211175256305746?=
X-GMAIL-MSGID: =?utf-8?q?1594211175256305746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Structures that are mapped to hardware registers should explicitly
specify the expected endianness for fields larger than 1 byte.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 16 ++++++++--------
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 7b75c93..377f4d9 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -830,7 +830,7 @@ int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
 struct qbman_acquire_desc {
 	u8 verb;
 	u8 reserved;
-	u16 bpid;
+	__le16 bpid;
 	u8 num;
 	u8 reserved2[59];
 };
@@ -838,10 +838,10 @@ struct qbman_acquire_desc {
 struct qbman_acquire_rslt {
 	u8 verb;
 	u8 rslt;
-	u16 reserved;
+	__le16 reserved;
 	u8 num;
 	u8 reserved2[3];
-	u64 buf[7];
+	__le64 buf[7];
 };
 
 /**
@@ -904,7 +904,7 @@ int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
 struct qbman_alt_fq_state_desc {
 	u8 verb;
 	u8 reserved[3];
-	u32 fqid;
+	__le32 fqid;
 	u8 reserved2[56];
 };
 
@@ -953,11 +953,11 @@ int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
 struct qbman_cdan_ctrl_desc {
 	u8 verb;
 	u8 reserved;
-	u16 ch;
+	__le16 ch;
 	u8 we;
 	u8 ctrl;
-	u16 reserved2;
-	u64 cdan_ctx;
+	__le16 reserved2;
+	__le64 cdan_ctx;
 	u8 reserved3[48];
 
 };
@@ -965,7 +965,7 @@ struct qbman_cdan_ctrl_desc {
 struct qbman_cdan_ctrl_rslt {
 	u8 verb;
 	u8 rslt;
-	u16 ch;
+	__le16 ch;
 	u8 reserved[60];
 };
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
index fb8b9d3..4488a44 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
@@ -32,8 +32,8 @@ struct qbman_pull_desc {
 	u8 numf;
 	u8 tok;
 	u8 reserved;
-	u32 dq_src;
-	u64 rsp_addr;
+	__le32 dq_src;
+	__le64 rsp_addr;
 	u64 rsp_addr_virt;
 	u8 padding[40];
 };
@@ -70,17 +70,17 @@ enum qbman_pull_type_e {
 struct qbman_eq_desc {
 	u8 verb;
 	u8 dca;
-	u16 seqnum;
-	u16 orpid;
-	u16 reserved1;
-	u32 tgtid;
-	u32 tag;
-	u16 qdbin;
+	__le16 seqnum;
+	__le16 orpid;
+	__le16 reserved1;
+	__le32 tgtid;
+	__le32 tag;
+	__le16 qdbin;
 	u8 qpri;
 	u8 reserved[3];
 	u8 wae;
 	u8 rspid;
-	u64 rsp_addr;
+	__le64 rsp_addr;
 	u8 fd[32];
 };
 
@@ -88,9 +88,9 @@ struct qbman_eq_desc {
 struct qbman_release_desc {
 	u8 verb;
 	u8 reserved;
-	u16 bpid;
-	u32 reserved2;
-	u64 buf[7];
+	__le16 bpid;
+	__le32 reserved2;
+	__le64 buf[7];
 };
 
 /* Management command result codes */
-- 
2.7.4

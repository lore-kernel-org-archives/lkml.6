Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELsBMgyQWm18qCKee+CnBFOJBwNnK9t7XlEXtF9Hxsv5HFiMLLhF/3uLuVTTI5F8yBiqs28B
ARC-Seal: i=1; a=rsa-sha256; t=1521133571; cv=none;
        d=google.com; s=arc-20160816;
        b=Myq4/LwhFt7dud6h9GkJWXqdDy/0LR/Aet4sWpgx10VwgQ3cUSG0eBFrzJQMjt4DRr
         BgUG9kc9qfdA7057+Ku/oqXtdypC+JPdsY3eaj5UaU3vzP7Fk6MgJmWCjpsLuRWjfW2h
         USl9fLWmdlMAOj6FZeKMU+Se9goJUiam/+4jfkBDPg1LDtY4dXp2PKrSr2kIheHsZmdW
         C/MgoX+YkbDv5im8BaZ3J9ZY6FqZHkabAVjgxOjVboTN6ZHALmempJNIScAtTpBE6bff
         19lYrNJiX5FV0veSwr0f1N2YtZoz0Y/uTHVhHBjdZEDCOQlkCFx58Z5eaQDa8irRc1lB
         shiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ORGDW2kE2ZFNnKNVERuJZ10EIpy7CfhB4LecPb5wms4=;
        b=TTUTDmJrFt66dJDU00TKStR+dcq8fZKlSMmZAS4Ka2U/v8GtxZ9Iudn3JnRZRCysUb
         qers4rvu0JniunM/t7trNYywJcouzbbxD4+7wQT9zctnfSmTINVT+rw3JkKE9DCyhLPB
         PE0MutoN3bnHdTVP3e3nCOIN7NRLA6p2FJJyZjxFtSJFS1BJvOWrxcjP6HxmHaAKfuSi
         PvtJzaFUq8sn/pGweDmmN/5/eYTzhlCfpenXgL5gENoivMKYQjfIKtrSeVYRGGoJMzA+
         lxZlpZby03w/exPVAYtJIHvR4eJThDLEEP+37YjPJplSus76dUROYXZRZarG4iO7Icqw
         DmSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=C3N87eT2;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.85 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=C3N87eT2;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.85 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
Subject: [PATCH v2 1/6] bus: fsl-mc: change mc_command in fsl_mc_command
Date: Thu, 15 Mar 2018 12:05:31 -0500
Message-Id: <7028558c2e48625f43082d7ae26c249808862cb0.1521132659.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 866a780b-417f-4f1b-ac2d-08d58a970b9e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:YeXCFIBs8ovNVnTj4gGPXyqSv+6gXlM2EGWK+2q+FZkx/A/2ceJcyOI0dioaIlZiiLiSzUrsb+ZcPepClRvNedjsRG/1cqYopLtCic5eJPssBP5+uy8WaAgTxo2MbA1ZFqGlLTPuT2W6QDSx6M01hWJA+XaaKUAKF/5WtTK+1q2Rqq8Z9dZ+Ejf69NwuhzcJ0U6syeR7B1vHnPLWbL7Mwn24xdhoWXAvNfEXg/HQIbnxS83Er9elFN5C8EQ/VU7b;25:fJbvMkXXWRy9HknpLCtPSP5TINpd/xJgoE4Q4Oplkcoonyrs/JxxQT5ruQBgVFFbMMXYlE5Az2K+ujDZ7DpCrVFZmEGfFbgAA3jleCeexsoep1G4hAE+1RraJbzAZAAJPh17nkJ9DR6OSQrhP4EVxEm34q/h6YupvZF4yhVTctpipo8V0To2HPG7AeA6/D/88UmFAL+nTAW6EYJuBu5b8SJ4CZkZZHhuQKnX0q+Nl5hyosKaTt734KYzLkTELWoBr6GKaFYyROF4maJUEr5j86pKJw/nGhj5r5Sr1wZpL6LCP+A/GbWWVe54vUvX8f7ps6p4g5yCPv9viJailZ9HWg==;31:Ig8N9ONz/sMupw4aPHxFdkHSwqstp44g1R7GG0KIXC0Tv0l86bWmP7QD3Sc6x5LvQDCfspDWHLR5vZcD9kyYH62vObl+QIPI7ZEdwdsgP64jW6meCjdWeWhwwxP/SXcx19pGrNr7GSPYKCOlFp/6rJajhkLbTluCrw+kM9Bi1mfuMZw4oX0IUM7WjhR88i1dEN/QXnt6tiEcWQt/pE22tdZ9qZRnEUl2HS29MVfRA5g=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:0/e8rlxd6V0tdOociTO5Nykt2ihFJSFLn36N+2fIxPs2hlqwj8WYTLyqhj5pTCyN3EsV3WaT+FwPkDVw+YThKHYoZFuEWJ74D0PwrLKSN44xZKU4FnToXOOfi6d/9n8V+vzk0vV7ZB06RHGBWCAgl6X7ppliz4OtiLFUCXYZAaY9CuzIAG+NLBLwi9sl0yJDEu1QPVX6jJUTOQXHV7HrlMj1baku61VaDNhb34cOljC36wjp5BSqxh7GOQmr+ME/gVrQFwHXFjwB/HCABJdeWGTwEk0m6tqjvw53kwsqYA/dQB8E1dc5pjWjaK3QQEYIzd0HhOb4nE3o2TSgadm70PZeM3+w2a8OU2OUx0RzvgMQ/kvcuAGn/IYm2eaT4xu4yP6zslhlg9ybvKEfBgbUAbgsHlxq5hVwUBmfc+tAugLM9GgdDJLlwx4zRryqv6eiEbgw3Oit6fQqoFeV7hZ01GU8yNGku3puZ+yYhrVSlEXbYD/VZCwrmB2mlzGn2YOR;4:e8BCmeuwjK+9Wck4MjdvImoMQaL0f7X3ErEQKYTGCjpV7b+dKXJYeA1sF03fJwMU7QuCf+/ap/tiT6YdwBP9L2YYR8NZfvRkTqF4eKmBn5+3of9+CDG72q9MAKAySEt2VmwBGfUu1ngEg83up2+kbThWHetsdvdC0gBJxtuIWugrbH33ID8EpfnbhQZfn3dPRbB3FBkYMu77i6aecbxQ8a428YduQgvbiZpZn8ifvzkA+UHFMmBnrQmGp0WsSIlK7O+ffvn3fFBPZD/qUCgtziFgiPQ4W4sQd4uQNKZb1K1UvY0pK+h+qfgemDEbPzkW0R8TcSZ9NPWW75THCqtMcvrGmTRNuv3R5X7gT8Z2vEk=
X-Microsoft-Antispam-PRVS: <DB6PR04MB3206A3730B23E9A733CE0300E0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(199004)(7736002)(105586002)(81156014)(53946003)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(59450400001)(305945005)(6116002)(36756003)(118296001)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(575784001)(76176011)(2906002)(16586007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:X7DdeGJ8Y8wtQDdaDnll3+q76SFz+2HT988mCsNxE?=
 =?us-ascii?Q?K+HHDEZQxzMwnnacjeX1NQdLW76jxrzzZNvtW3DsfECgcANIkgz73z1tJzxk?=
 =?us-ascii?Q?5R5frmYiA9LCjEDbvc/UbF/3STKUuWCKuVqcUzUBC7xTvLFO2LjIWVZgqFjv?=
 =?us-ascii?Q?+qbTnSMVSg6C8kG3sZ//148pL/3fZqeURxHAXzrVGMyTAn96b+kg1JcWBnzy?=
 =?us-ascii?Q?l3mVODkPBtWratZlOlYMl7mj+i+RlpzaJbPTh1+CQYn+wnX0r6EHOXNnzWVJ?=
 =?us-ascii?Q?XrZpPhqRGiiMlYWHxRZwciKg4dDrJyS55jYxVrYSCVb0vvPjZPjVY4uMRKkU?=
 =?us-ascii?Q?uy4111BZEsaaE/XCb9IwBdKE7BzTVH9RHJ+ezI4kssPQoy8uOgMCwNtR06mY?=
 =?us-ascii?Q?DbEx4E7uQto+/+4eTquUHACzBWvBQN6oIMZzk0E9cPeH1Vk8Kb5Dp0uEedXV?=
 =?us-ascii?Q?9hcX1RZmbG2yZwanLpLvJIlyQR8FkTCUvwqNsuOG3DNZvWRaG0YQjY4jWxKQ?=
 =?us-ascii?Q?aVfQK9lAEg9IWroSMkxkgTvvroRmXZlqChDGMVsv7Rj1NHgCH/eTCV85S/A0?=
 =?us-ascii?Q?VhYuQaeAHSKvbOYUytQ12/vY5BiF5NO3HBWHNDP1t2VmH4zF+C/K7NBw3cDV?=
 =?us-ascii?Q?FlT24Zm6swjO5amtAJKqonKpk2gVVKnXd/+4Vg8Rx253HSZRt80Nr6G8fqcn?=
 =?us-ascii?Q?7mesbkJNkudkpzrGdwa/85GySJGJGfwetCQPecQPLAPHgWrdpmS/vpFVZXNN?=
 =?us-ascii?Q?dTDRCd2TKB3RgwziVV3egquDWAnGO+v0L+jzTr+t5eAjOVJJKxzRvFqTx1UF?=
 =?us-ascii?Q?Gfi4wrc+rJDcbSqdp5wfu6XbMTt1CE7j0c0SKH9ftedarvzc9N+cN8zAYipG?=
 =?us-ascii?Q?OGgkyGl5TBwYXxpnlT05HwcyejNq32xooAwgsyC+gvi8PQXNJGT8xp9MdhXR?=
 =?us-ascii?Q?Z+vp1wD4350FGZgZbhEDQmC2BxtGqwzgmdD4j6DsLx1XOOwvpa2yv+kTTviT?=
 =?us-ascii?Q?nAaV21j3QZmBJPyvZFlCjW3Ke47Q1vkvIQdEuqIqkpIiGzDMsWzwpKdiQiM+?=
 =?us-ascii?Q?xrqo3Jq4u20G6KfxbmvdkGDYw9S7thGW14UEyNtmEhwsbH6TId4QJ7/HySrI?=
 =?us-ascii?Q?wRY3VKZ1FY3rfMlX3MtR1ssgieGpcG2Vtv8PzQJrCfY286Xxue+chbSlRdkw?=
 =?us-ascii?Q?Xq2E4M4Zzo2wxjLWurz+aQLQ3DFnlqmjB2mHVuY7Lmi27D/skxxXzfnTCJGK?=
 =?us-ascii?Q?0ynYQ4qNMrntFOvfwfntualpBo8mTvf3ii2vfk+TEOJP3+9u+/RQg6zez16u?=
 =?us-ascii?Q?W0sOpeYp3DfYtr3qbamqRQ=3D?=
X-Microsoft-Antispam-Message-Info: FdCrKTCzMbyteDYsJD+htPlJm+4noWz4eIQjZFuvZd0N7vk1jg7ZSGgBLcVefjLryv30ibXncGH76iErH2ihHG21sNPRNyI8WG0l0aKJSkKt4mF0ujAQqZHxQ1R8CW94C5Tbgpnj+WPWjB62GjPs/OJqJXwEu0IC8q8HJNsMQaI1ER1C/lm+rckk9p8VkhQF
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:H/RUFBQoEqxvE/nK4B/RTfs9kISNOIdvHt6m0sKnTnLTGkVtCwt8s3ZSX8Sj2O7s4tkLtYOuEPhQqyGnZuVVxmPodNwjB5IdRM7NNOHAR8tMRjezLM+wAkjl3MPXdxjH04PpnXRY5a7MVc294t6LkOIMvXnRekwzSYNAQuVbwALRUSck6b0mkSqyFG7Nb7DEm43usBU5f592t4IZoAWWdSV6t9sTtP58TPV2+ejf4Z/0NHMabpsV1apJX/XohIL5tt2KdSwZiRw/9fSh4MHTV/UWqxzeAxU5C0FQ5WJRT2BrPgNuASFCO1pEMY8mFe8RP4RLEZezIM7QuUT7n8nZXMGKLlC1bcsiXj8cAL3mtvU=;5:dUF4UdiUb9JpEOkgv3s7/CtwYf+k5lBP0zpWlkUkgzUShsaIlXTlXPypl1/189pEARr9Lt0nzStiXQ8pP1rEneoAMgtnF4IsQsHZr6eUfrJWSa8TVnMPVIDrSZMDDbBKli4qBfRBj2kkWZtX53I2lF7ds9dDKOmBSrwrPm0gQt8=;24:Un2qykc2/Jji87RIg7BAdB9JjAxDPk3weL/+4f1zpnes9e8H02fzh3j8njE24Cufr9daoK2v7/szD8Ym0A5WdJ/toDdJCKzT7EPScQSOleo=;7:Nc6A5HwqyUxneY8U0K11O233+/yyx4hPCXvmC8wFcpPmeMYXdNqKbNAxsn09a775Qr5YkPLKC6bnShGUfK6Uv3VdoJiCF2rloXz8BT0hNlE4Ba5aKnxA07W0M7KXGCHVF5nkYhF+WRhfjcmyP3TpkNxaioKLZvmxpIvtAHvfp5bsKpwlaz1yjNp73g5YDmpkDzQRE79hQn9tWjN6QbWhRkkW6sxbIzISIKiqq6axQiKeMRXbYCf3Uma9/mrEcG2v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:05.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866a780b-417f-4f1b-ac2d-08d58a970b9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024155512402542?=
X-GMAIL-MSGID: =?utf-8?q?1595024155512402542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The "struct mc_command" is a very generic name for a global
kernel structure. Change its name in "struct fsl_mc_command".

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added the patch itself

 drivers/bus/fsl-mc/dpbp.c                 | 12 ++---
 drivers/bus/fsl-mc/dpcon.c                | 14 +++---
 drivers/bus/fsl-mc/dpmcp.c                |  6 +--
 drivers/bus/fsl-mc/dprc.c                 | 28 +++++------
 drivers/bus/fsl-mc/fsl-mc-bus.c           |  2 +-
 drivers/bus/fsl-mc/mc-sys.c               | 20 ++++----
 drivers/staging/fsl-dpaa2/ethernet/dpni.c | 84 +++++++++++++++----------------
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c    | 64 +++++++++++------------
 drivers/staging/fsl-mc/bus/dpio/dpio.c    | 12 ++---
 include/linux/fsl/mc.h                    | 10 ++--
 10 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
index 0aeacc5..17e3c5d 100644
--- a/drivers/bus/fsl-mc/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -31,7 +31,7 @@ int dpbp_open(struct fsl_mc_io *mc_io,
 	      int dpbp_id,
 	      u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpbp_cmd_open *cmd_params;
 	int err;
 
@@ -68,7 +68,7 @@ int dpbp_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_CLOSE, cmd_flags,
@@ -91,7 +91,7 @@ int dpbp_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_ENABLE, cmd_flags,
@@ -114,7 +114,7 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_DISABLE,
@@ -137,7 +137,7 @@ int dpbp_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_RESET,
@@ -163,7 +163,7 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpbp_rsp_get_attributes *rsp_params;
 	int err;
 
diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
index a1ba819..760555d 100644
--- a/drivers/bus/fsl-mc/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -31,7 +31,7 @@ int dpcon_open(struct fsl_mc_io *mc_io,
 	       int dpcon_id,
 	       u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpcon_cmd_open *dpcon_cmd;
 	int err;
 
@@ -69,7 +69,7 @@ int dpcon_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_CLOSE,
@@ -93,7 +93,7 @@ int dpcon_enable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_ENABLE,
@@ -117,7 +117,7 @@ int dpcon_disable(struct fsl_mc_io *mc_io,
 		  u32 cmd_flags,
 		  u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_DISABLE,
@@ -141,7 +141,7 @@ int dpcon_reset(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_RESET,
@@ -166,7 +166,7 @@ int dpcon_get_attributes(struct fsl_mc_io *mc_io,
 			 u16 token,
 			 struct dpcon_attr *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpcon_rsp_get_attr *dpcon_rsp;
 	int err;
 
@@ -204,7 +204,7 @@ int dpcon_set_notification(struct fsl_mc_io *mc_io,
 			   u16 token,
 			   struct dpcon_notification_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpcon_cmd_set_notification *dpcon_cmd;
 
 	/* prepare command */
diff --git a/drivers/bus/fsl-mc/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
index 8d997b0..5fbd0dbd 100644
--- a/drivers/bus/fsl-mc/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -30,7 +30,7 @@ int dpmcp_open(struct fsl_mc_io *mc_io,
 	       int dpmcp_id,
 	       u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpmcp_cmd_open *cmd_params;
 	int err;
 
@@ -66,7 +66,7 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMCP_CMDID_CLOSE,
@@ -88,7 +88,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMCP_CMDID_RESET,
diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 5c23e8d..1c3f621 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -24,7 +24,7 @@ int dprc_open(struct fsl_mc_io *mc_io,
 	      int container_id,
 	      u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_open *cmd_params;
 	int err;
 
@@ -61,7 +61,7 @@ int dprc_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPRC_CMDID_CLOSE, cmd_flags,
@@ -88,7 +88,7 @@ int dprc_set_irq(struct fsl_mc_io *mc_io,
 		 u8 irq_index,
 		 struct dprc_irq_cfg *irq_cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_set_irq *cmd_params;
 
 	/* prepare command */
@@ -126,7 +126,7 @@ int dprc_set_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -162,7 +162,7 @@ int dprc_set_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 mask)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -194,7 +194,7 @@ int dprc_get_irq_status(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u32 *status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_get_irq_status *cmd_params;
 	struct dprc_rsp_get_irq_status *rsp_params;
 	int err;
@@ -236,7 +236,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
 			  u8 irq_index,
 			  u32 status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -264,7 +264,7 @@ int dprc_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dprc_attributes *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_rsp_get_attributes *rsp_params;
 	int err;
 
@@ -302,7 +302,7 @@ int dprc_get_obj_count(struct fsl_mc_io *mc_io,
 		       u16 token,
 		       int *obj_count)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_rsp_get_obj_count *rsp_params;
 	int err;
 
@@ -344,7 +344,7 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
 		 int obj_index,
 		 struct fsl_mc_obj_desc *obj_desc)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_get_obj *cmd_params;
 	struct dprc_rsp_get_obj *rsp_params;
 	int err;
@@ -399,7 +399,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 		     u8 irq_index,
 		     struct dprc_irq_cfg *irq_cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_set_obj_irq *cmd_params;
 
 	/* prepare command */
@@ -440,7 +440,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 			u8 region_index,
 			struct dprc_region_desc *region_desc)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_get_obj_region *cmd_params;
 	struct dprc_rsp_get_obj_region *rsp_params;
 	int err;
@@ -482,7 +482,7 @@ int dprc_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	int err;
 
 	/* prepare command */
@@ -512,7 +512,7 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  int *container_id)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	int err;
 
 	/* prepare command */
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 1b333c4..5d8266c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -314,7 +314,7 @@ static int mc_get_version(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  struct mc_version *mc_ver_info)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpmng_rsp_get_version *rsp_params;
 	int err;
 
diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index bd03f15..3221a7f 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -28,14 +28,14 @@
 #define MC_CMD_COMPLETION_POLLING_MIN_SLEEP_USECS    10
 #define MC_CMD_COMPLETION_POLLING_MAX_SLEEP_USECS    500
 
-static enum mc_cmd_status mc_cmd_hdr_read_status(struct mc_command *cmd)
+static enum mc_cmd_status mc_cmd_hdr_read_status(struct fsl_mc_command *cmd)
 {
 	struct mc_cmd_header *hdr = (struct mc_cmd_header *)&cmd->header;
 
 	return (enum mc_cmd_status)hdr->status;
 }
 
-static u16 mc_cmd_hdr_read_cmdid(struct mc_command *cmd)
+static u16 mc_cmd_hdr_read_cmdid(struct fsl_mc_command *cmd)
 {
 	struct mc_cmd_header *hdr = (struct mc_cmd_header *)&cmd->header;
 	u16 cmd_id = le16_to_cpu(hdr->cmd_id);
@@ -94,8 +94,8 @@ static const char *mc_status_to_string(enum mc_cmd_status status)
  * @portal: pointer to an MC portal
  * @cmd: pointer to a filled command
  */
-static inline void mc_write_command(struct mc_command __iomem *portal,
-				    struct mc_command *cmd)
+static inline void mc_write_command(struct fsl_mc_command __iomem *portal,
+				    struct fsl_mc_command *cmd)
 {
 	int i;
 
@@ -121,9 +121,9 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
  *
  * Returns MC_CMD_STATUS_OK on Success; Error code otherwise.
  */
-static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
-						  portal,
-						  struct mc_command *resp)
+static inline enum mc_cmd_status mc_read_response(struct fsl_mc_command __iomem
+						  *portal,
+						  struct fsl_mc_command *resp)
 {
 	int i;
 	enum mc_cmd_status status;
@@ -156,7 +156,7 @@ static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
  * @mc_status: MC command completion status
  */
 static int mc_polling_wait_preemptible(struct fsl_mc_io *mc_io,
-				       struct mc_command *cmd,
+				       struct fsl_mc_command *cmd,
 				       enum mc_cmd_status *mc_status)
 {
 	enum mc_cmd_status status;
@@ -202,7 +202,7 @@ static int mc_polling_wait_preemptible(struct fsl_mc_io *mc_io,
  * @mc_status: MC command completion status
  */
 static int mc_polling_wait_atomic(struct fsl_mc_io *mc_io,
-				  struct mc_command *cmd,
+				  struct fsl_mc_command *cmd,
 				  enum mc_cmd_status *mc_status)
 {
 	enum mc_cmd_status status;
@@ -241,7 +241,7 @@ static int mc_polling_wait_atomic(struct fsl_mc_io *mc_io,
  *
  * Returns '0' on Success; Error code otherwise.
  */
-int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd)
+int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd)
 {
 	int error;
 	enum mc_cmd_status status;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index b16ff5c..1a721c9 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -122,7 +122,7 @@ int dpni_open(struct fsl_mc_io *mc_io,
 	      int dpni_id,
 	      u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_open *cmd_params;
 
 	int err;
@@ -160,7 +160,7 @@ int dpni_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_CLOSE,
@@ -188,7 +188,7 @@ int dpni_set_pools(struct fsl_mc_io *mc_io,
 		   u16 token,
 		   const struct dpni_pools_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_pools *cmd_params;
 	int i;
 
@@ -222,7 +222,7 @@ int dpni_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ENABLE,
@@ -245,7 +245,7 @@ int dpni_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_DISABLE,
@@ -270,7 +270,7 @@ int dpni_is_enabled(struct fsl_mc_io *mc_io,
 		    u16 token,
 		    int *en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_is_enabled *rsp_params;
 	int err;
 
@@ -303,7 +303,7 @@ int dpni_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_RESET,
@@ -335,7 +335,7 @@ int dpni_set_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -366,7 +366,7 @@ int dpni_get_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 *en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_irq_enable *cmd_params;
 	struct dpni_rsp_get_irq_enable *rsp_params;
 
@@ -413,7 +413,7 @@ int dpni_set_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 mask)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -447,7 +447,7 @@ int dpni_get_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 *mask)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_irq_mask *cmd_params;
 	struct dpni_rsp_get_irq_mask *rsp_params;
 	int err;
@@ -489,7 +489,7 @@ int dpni_get_irq_status(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u32 *status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_irq_status *cmd_params;
 	struct dpni_rsp_get_irq_status *rsp_params;
 	int err;
@@ -532,7 +532,7 @@ int dpni_clear_irq_status(struct fsl_mc_io *mc_io,
 			  u8 irq_index,
 			  u32 status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -561,7 +561,7 @@ int dpni_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpni_attr *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_attr *rsp_params;
 
 	int err;
@@ -609,7 +609,7 @@ int dpni_set_errors_behavior(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     struct dpni_error_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_errors_behavior *cmd_params;
 
 	/* prepare command */
@@ -641,7 +641,7 @@ int dpni_get_buffer_layout(struct fsl_mc_io *mc_io,
 			   enum dpni_queue_type qtype,
 			   struct dpni_buffer_layout *layout)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_buffer_layout *cmd_params;
 	struct dpni_rsp_get_buffer_layout *rsp_params;
 	int err;
@@ -689,7 +689,7 @@ int dpni_set_buffer_layout(struct fsl_mc_io *mc_io,
 			   enum dpni_queue_type qtype,
 			   const struct dpni_buffer_layout *layout)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_buffer_layout *cmd_params;
 
 	/* prepare command */
@@ -731,7 +731,7 @@ int dpni_set_offload(struct fsl_mc_io *mc_io,
 		     enum dpni_offload type,
 		     u32 config)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_offload *cmd_params;
 
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_OFFLOAD,
@@ -750,7 +750,7 @@ int dpni_get_offload(struct fsl_mc_io *mc_io,
 		     enum dpni_offload type,
 		     u32 *config)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_offload *cmd_params;
 	struct dpni_rsp_get_offload *rsp_params;
 	int err;
@@ -792,7 +792,7 @@ int dpni_get_qdid(struct fsl_mc_io *mc_io,
 		  enum dpni_queue_type qtype,
 		  u16 *qdid)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_qdid *cmd_params;
 	struct dpni_rsp_get_qdid *rsp_params;
 	int err;
@@ -830,7 +830,7 @@ int dpni_get_tx_data_offset(struct fsl_mc_io *mc_io,
 			    u16 token,
 			    u16 *data_offset)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_tx_data_offset *rsp_params;
 	int err;
 
@@ -865,7 +865,7 @@ int dpni_set_link_cfg(struct fsl_mc_io *mc_io,
 		      u16 token,
 		      const struct dpni_link_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_link_cfg *cmd_params;
 
 	/* prepare command */
@@ -894,7 +894,7 @@ int dpni_get_link_state(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpni_link_state *state)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_link_state *rsp_params;
 	int err;
 
@@ -933,7 +933,7 @@ int dpni_set_max_frame_length(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u16 max_frame_length)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_max_frame_length *cmd_params;
 
 	/* prepare command */
@@ -963,7 +963,7 @@ int dpni_get_max_frame_length(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u16 *max_frame_length)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_max_frame_length *rsp_params;
 	int err;
 
@@ -998,7 +998,7 @@ int dpni_set_multicast_promisc(struct fsl_mc_io *mc_io,
 			       u16 token,
 			       int en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_multicast_promisc *cmd_params;
 
 	/* prepare command */
@@ -1026,7 +1026,7 @@ int dpni_get_multicast_promisc(struct fsl_mc_io *mc_io,
 			       u16 token,
 			       int *en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_multicast_promisc *rsp_params;
 	int err;
 
@@ -1061,7 +1061,7 @@ int dpni_set_unicast_promisc(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     int en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_unicast_promisc *cmd_params;
 
 	/* prepare command */
@@ -1089,7 +1089,7 @@ int dpni_get_unicast_promisc(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     int *en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_unicast_promisc *rsp_params;
 	int err;
 
@@ -1124,7 +1124,7 @@ int dpni_set_primary_mac_addr(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      const u8 mac_addr[6])
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_primary_mac_addr *cmd_params;
 	int i;
 
@@ -1154,7 +1154,7 @@ int dpni_get_primary_mac_addr(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u8 mac_addr[6])
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_primary_mac_addr *rsp_params;
 	int i, err;
 
@@ -1193,7 +1193,7 @@ int dpni_get_port_mac_addr(struct fsl_mc_io *mc_io,
 			   u16 token,
 			   u8 mac_addr[6])
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_rsp_get_port_mac_addr *rsp_params;
 	int i, err;
 
@@ -1229,7 +1229,7 @@ int dpni_add_mac_addr(struct fsl_mc_io *mc_io,
 		      u16 token,
 		      const u8 mac_addr[6])
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_add_mac_addr *cmd_params;
 	int i;
 
@@ -1259,7 +1259,7 @@ int dpni_remove_mac_addr(struct fsl_mc_io *mc_io,
 			 u16 token,
 			 const u8 mac_addr[6])
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_remove_mac_addr *cmd_params;
 	int i;
 
@@ -1293,7 +1293,7 @@ int dpni_clear_mac_filters(struct fsl_mc_io *mc_io,
 			   int unicast,
 			   int multicast)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_clear_mac_filters *cmd_params;
 
 	/* prepare command */
@@ -1327,7 +1327,7 @@ int dpni_set_rx_tc_dist(struct fsl_mc_io *mc_io,
 			u8 tc_id,
 			const struct dpni_rx_tc_dist_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_rx_tc_dist *cmd_params;
 
 	/* prepare command */
@@ -1371,7 +1371,7 @@ int dpni_set_queue(struct fsl_mc_io *mc_io,
 		   u8 options,
 		   const struct dpni_queue *queue)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_queue *cmd_params;
 
 	/* prepare command */
@@ -1419,7 +1419,7 @@ int dpni_get_queue(struct fsl_mc_io *mc_io,
 		   struct dpni_queue *queue,
 		   struct dpni_queue_id *qid)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_queue *cmd_params;
 	struct dpni_rsp_get_queue *rsp_params;
 	int err;
@@ -1473,7 +1473,7 @@ int dpni_get_statistics(struct fsl_mc_io *mc_io,
 			u8 page,
 			union dpni_statistics *stat)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_statistics *cmd_params;
 	struct dpni_rsp_get_statistics *rsp_params;
 	int i, err;
@@ -1522,7 +1522,7 @@ int dpni_set_taildrop(struct fsl_mc_io *mc_io,
 		      u8 index,
 		      struct dpni_taildrop *taildrop)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_set_taildrop *cmd_params;
 
 	/* prepare command */
@@ -1566,7 +1566,7 @@ int dpni_get_taildrop(struct fsl_mc_io *mc_io,
 		      u8 index,
 		      struct dpni_taildrop *taildrop)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpni_cmd_get_taildrop *cmd_params;
 	struct dpni_rsp_get_taildrop *rsp_params;
 	int err;
@@ -1610,7 +1610,7 @@ int dpni_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *minor_ver)
 {
 	struct dpni_rsp_get_api_version *rsp_params;
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_API_VERSION,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index aefa52f..9b9bc60 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -43,7 +43,7 @@ int dpsw_open(struct fsl_mc_io *mc_io,
 	      int dpsw_id,
 	      u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_open *cmd_params;
 	int err;
 
@@ -80,7 +80,7 @@ int dpsw_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CLOSE,
@@ -103,7 +103,7 @@ int dpsw_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ENABLE,
@@ -126,7 +126,7 @@ int dpsw_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_DISABLE,
@@ -149,7 +149,7 @@ int dpsw_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_RESET,
@@ -181,7 +181,7 @@ int dpsw_set_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -218,7 +218,7 @@ int dpsw_set_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 mask)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -251,7 +251,7 @@ int dpsw_get_irq_status(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u32 *status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_get_irq_status *cmd_params;
 	struct dpsw_rsp_get_irq_status *rsp_params;
 	int err;
@@ -294,7 +294,7 @@ int dpsw_clear_irq_status(struct fsl_mc_io *mc_io,
 			  u8 irq_index,
 			  u32 status)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -323,7 +323,7 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpsw_attr *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_rsp_get_attr *rsp_params;
 	int err;
 
@@ -373,7 +373,7 @@ int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io,
 			 u16 if_id,
 			 struct dpsw_link_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_link_cfg *cmd_params;
 
 	/* prepare command */
@@ -405,7 +405,7 @@ int dpsw_if_get_link_state(struct fsl_mc_io *mc_io,
 			   u16 if_id,
 			   struct dpsw_link_state *state)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_get_link_state *cmd_params;
 	struct dpsw_rsp_if_get_link_state *rsp_params;
 	int err;
@@ -447,7 +447,7 @@ int dpsw_if_set_flooding(struct fsl_mc_io *mc_io,
 			 u16 if_id,
 			 u8 en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_flooding *cmd_params;
 
 	/* prepare command */
@@ -478,7 +478,7 @@ int dpsw_if_set_broadcast(struct fsl_mc_io *mc_io,
 			  u16 if_id,
 			  u8 en)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_broadcast *cmd_params;
 
 	/* prepare command */
@@ -509,7 +509,7 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
 		    u16 if_id,
 		    const struct dpsw_tci_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_tci *cmd_params;
 	u16 tmp_conf = 0;
 
@@ -547,7 +547,7 @@ int dpsw_if_set_stp(struct fsl_mc_io *mc_io,
 		    u16 if_id,
 		    const struct dpsw_stp_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_stp *cmd_params;
 
 	/* prepare command */
@@ -581,7 +581,7 @@ int dpsw_if_get_counter(struct fsl_mc_io *mc_io,
 			enum dpsw_counter type,
 			u64 *counter)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_get_counter *cmd_params;
 	struct dpsw_rsp_if_get_counter *rsp_params;
 	int err;
@@ -620,7 +620,7 @@ int dpsw_if_enable(struct fsl_mc_io *mc_io,
 		   u16 token,
 		   u16 if_id)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if *cmd_params;
 
 	/* prepare command */
@@ -648,7 +648,7 @@ int dpsw_if_disable(struct fsl_mc_io *mc_io,
 		    u16 token,
 		    u16 if_id)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if *cmd_params;
 
 	/* prepare command */
@@ -678,7 +678,7 @@ int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io,
 				 u16 if_id,
 				 u16 frame_length)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_if_set_max_frame_length *cmd_params;
 
 	/* prepare command */
@@ -716,7 +716,7 @@ int dpsw_vlan_add(struct fsl_mc_io *mc_io,
 		  u16 vlan_id,
 		  const struct dpsw_vlan_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_vlan_add *cmd_params;
 
 	/* prepare command */
@@ -752,7 +752,7 @@ int dpsw_vlan_add_if(struct fsl_mc_io *mc_io,
 		     u16 vlan_id,
 		     const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -790,7 +790,7 @@ int dpsw_vlan_add_if_untagged(struct fsl_mc_io *mc_io,
 			      u16 vlan_id,
 			      const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -824,7 +824,7 @@ int dpsw_vlan_remove_if(struct fsl_mc_io *mc_io,
 			u16 vlan_id,
 			const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -860,7 +860,7 @@ int dpsw_vlan_remove_if_untagged(struct fsl_mc_io *mc_io,
 				 u16 vlan_id,
 				 const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -889,7 +889,7 @@ int dpsw_vlan_remove(struct fsl_mc_io *mc_io,
 		     u16 token,
 		     u16 vlan_id)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_vlan_remove *cmd_params;
 
 	/* prepare command */
@@ -919,7 +919,7 @@ int dpsw_fdb_add_unicast(struct fsl_mc_io *mc_io,
 			 u16 fdb_id,
 			 const struct dpsw_fdb_unicast_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_fdb_unicast_op *cmd_params;
 	int i;
 
@@ -954,7 +954,7 @@ int dpsw_fdb_remove_unicast(struct fsl_mc_io *mc_io,
 			    u16 fdb_id,
 			    const struct dpsw_fdb_unicast_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_fdb_unicast_op *cmd_params;
 	int i;
 
@@ -996,7 +996,7 @@ int dpsw_fdb_add_multicast(struct fsl_mc_io *mc_io,
 			   u16 fdb_id,
 			   const struct dpsw_fdb_multicast_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_fdb_multicast_op *cmd_params;
 	int i;
 
@@ -1038,7 +1038,7 @@ int dpsw_fdb_remove_multicast(struct fsl_mc_io *mc_io,
 			      u16 fdb_id,
 			      const struct dpsw_fdb_multicast_cfg *cfg)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_fdb_multicast_op *cmd_params;
 	int i;
 
@@ -1074,7 +1074,7 @@ int dpsw_fdb_set_learning_mode(struct fsl_mc_io *mc_io,
 			       u16 fdb_id,
 			       enum dpsw_fdb_learning_mode mode)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_cmd_fdb_set_learning_mode *cmd_params;
 
 	/* prepare command */
@@ -1103,7 +1103,7 @@ int dpsw_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpsw_rsp_get_api_version *rsp_params;
 	int err;
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index 3175057..ff37c80 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -37,7 +37,7 @@ int dpio_open(struct fsl_mc_io *mc_io,
 	      int dpio_id,
 	      u16 *token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpio_cmd_open *dpio_cmd;
 	int err;
 
@@ -70,7 +70,7 @@ int dpio_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_CLOSE,
@@ -92,7 +92,7 @@ int dpio_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_ENABLE,
@@ -114,7 +114,7 @@ int dpio_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_DISABLE,
@@ -138,7 +138,7 @@ int dpio_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpio_attr *attr)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	struct dpio_rsp_get_attr *dpio_rsp;
 	int err;
 
@@ -180,7 +180,7 @@ int dpio_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver)
 {
-	struct mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { 0 };
 	int err;
 
 	/* prepare command */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index cfb1fbf..f27cb14 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -209,7 +209,7 @@ struct mc_cmd_header {
 	__le16 cmd_id;
 };
 
-struct mc_command {
+struct fsl_mc_command {
 	u64 header;
 	u64 params[MC_CMD_NUM_OF_PARAMS];
 };
@@ -256,7 +256,7 @@ static inline u64 mc_encode_cmd_header(u16 cmd_id,
 	return header;
 }
 
-static inline u16 mc_cmd_hdr_read_token(struct mc_command *cmd)
+static inline u16 mc_cmd_hdr_read_token(struct fsl_mc_command *cmd)
 {
 	struct mc_cmd_header *hdr = (struct mc_cmd_header *)&cmd->header;
 	u16 token = le16_to_cpu(hdr->token);
@@ -273,7 +273,7 @@ struct mc_rsp_api_ver {
 	__le16 minor_ver;
 };
 
-static inline u32 mc_cmd_read_object_id(struct mc_command *cmd)
+static inline u32 mc_cmd_read_object_id(struct fsl_mc_command *cmd)
 {
 	struct mc_rsp_create *rsp_params;
 
@@ -281,7 +281,7 @@ static inline u32 mc_cmd_read_object_id(struct mc_command *cmd)
 	return le32_to_cpu(rsp_params->object_id);
 }
 
-static inline void mc_cmd_read_api_version(struct mc_command *cmd,
+static inline void mc_cmd_read_api_version(struct fsl_mc_command *cmd,
 					   u16 *major_ver,
 					   u16 *minor_ver)
 {
@@ -342,7 +342,7 @@ struct fsl_mc_io {
 	};
 };
 
-int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd);
+int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd);
 
 #ifdef CONFIG_FSL_MC_BUS
 #define dev_is_fsl_mc(_dev) ((_dev)->bus == &fsl_mc_bus_type)
-- 
1.9.1

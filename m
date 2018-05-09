Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965950AbeEITsW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:48:22 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:56668
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965773AbeEITsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:48:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] [media] saa7146: fix error return from master_xfer
Date: Wed,  9 May 2018 21:48:07 +0200
Message-Id: <20180509194807.29286-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0078.eurprd07.prod.outlook.com
 (2603:10a6:3:64::22) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:93fK3Y9raTnrdcCuw1C5vYF0vR7rYs1DWwGlXYzQH3m7kZ5KKaAUK5O2fkOWHTMN7dU7/C1x1/Ij8zYc3M0BYs6gvb5zcEoLuutOPTkF8Y7u5oY9FT5uiaytswXN3Ef2wE9D+/gvEGsQc6yHhJPlF5PULexZppFUwPh4A+k6tM3tPyIB68lgQl9MY/Ojia33BUynOnKhl28FRHo1YR/a6bls+EGjPK6bQRMgJpCUTE8Ws4lmznalFW17oxhwY8d8;25:G0pRiRqClZS9g8O5LQpRvmjPpd5P83wXINKl63DLiV5yUS2t3vmdhrhmMOA0n8E8NvxhCkuOZJWE23S1trY2W0yTStksmGUy9UmYQR5yeI333tr1qesSyMhv9ef8IX+zIq9KATRXLsxbhywKCPtcZKa7I4Ogm6kphz+HHZQlsRPtronNnO7IxH+xdu5w2c2XqZtTy/PF+nyxRE8H5vVxn11U+ps4lt2KEva1BYCQGmhe3jTtq4+V8ahoYZCe/AYyjJJtmTMeePfcPUKbIq1NXnkqlqZBIWED2TZye2Cmde/xkB6Jt2abwuFqRXuGMZsmXJITm2WkCds1rc7Uy8SjCA==;31:pxFr59tN6/Flz+WdyrBqGyb2v3cseDUJobUN7M8hsX+RIkOj2QYWZF8YvV9wb5x16awR6/IGaeTqQiCVaaWWQOutcHXSxxutSkewhY+zUEtkWbAUCnomTVs8FlGmjlEDViyEQi0ciU1Oxurvyjy9htGdcIHqsjZEvCbCmvuo3AOvmYznNJ3CBH6SkzpzymGYwGNtQAZRn3TtH0yrY1IDtgOd6wHnC38FwZvWNVAB4KA=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27794F8CE9C5B455B62D5653BC990@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:P44G82qEdk6ZvlSKqanW+zDDxRwAy4hi3btheJ7DV3ZW+5qG+s8YisH37h7d7cFJq4HDqZ8ZDXASxD0h7mlnM6c8RpItcWBX7aEGhc6DQCoAUD9JcCRjEbN6xcjmx85vFPwQxli4eyytcDU8w5a3CfU5GNk0sDfYq8rdn1DBLS8iSoW48xr6L73d4LGwuJXCMJWroxrFoHPeMUcSndmodoJ6I8bG98W+w8mQ67uW3eMAHUUZwEvRHtaEoMCrWtfMhvqmmylbhjVg7VdnN+HA9g==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39840400004)(39380400002)(346002)(189003)(199004)(6116002)(66066001)(1076002)(97736004)(6666003)(6486002)(6916009)(50466002)(48376002)(2906002)(478600001)(3846002)(16526019)(186003)(26005)(1857600001)(25786009)(47776003)(2361001)(86362001)(36756003)(74482002)(6506007)(7736002)(52116002)(105586002)(106356001)(305945005)(386003)(476003)(316002)(81166006)(486006)(53936002)(81156014)(8936002)(956004)(50226002)(54906003)(2616005)(2351001)(4326008)(5660300001)(6512007)(51416003)(16586007)(68736007)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:Ydmc2gmhweqM9/+dnDu9olsYyQrzjrCuuK1Jpep?=
 =?us-ascii?Q?RORZnWzCVOiP38pLohMJtkhR/StrSSBmMY3oYta+CwKg7O3NOaWCBKPMgMy/?=
 =?us-ascii?Q?MXISxC4uFrLelqzvxBLg2SNbiUHBFEe58uyK6/ct2TaiJgG0wPtLi7yL9kQh?=
 =?us-ascii?Q?qoqD0kH01ryjEQ8oM8atnPAS5dDJDqJxEJ4U/FSrZ3zRgTTxNwSo60Efg8Ze?=
 =?us-ascii?Q?Z+xDuT3HPHDPMNBbSUbT63Bd4fdgBG0e/VYD4zWF3D1KurCk4BDLgKM10VLL?=
 =?us-ascii?Q?ijtgFWyWj443LCW7k93dZFd8r7dsKnunfqRgb400z1z2/dUnWSgcC1nrfrdN?=
 =?us-ascii?Q?zoNK3SPlODRCfzkFZKxG1MLqGWH38q5LcpbTa1eMdNHGKd3ZOIsDoB9Xegb3?=
 =?us-ascii?Q?2+JyxqaqXHwOh38Ag8tGh6nv8UhzMCi20huE8/M9zsjE+SYJhegw2/zxSOH9?=
 =?us-ascii?Q?M+EZ42zB5uTymF/DWJeJ0psp4WcQhmtRYokPfTSymX5TTj0adHADlGpxlD0u?=
 =?us-ascii?Q?lE55oRnL4zpau2oJ3mYIwUxGzteMjCVtjyPhLPPI9PQf3yAMQGLPvabACQJC?=
 =?us-ascii?Q?7Pl2IkgwHWLboHMUEHC4j3puv+0WZPp12KVfWXbao+OrnT11Ktt8AZgONCqT?=
 =?us-ascii?Q?c1SrQyd//ulgE3ZyPwkLnxTp2t3wqQlHPBb1iOepYg54GVRV3Oj11kEgGFqw?=
 =?us-ascii?Q?wCXF+DU4dRRQm9KSX+Rt2RViAKoDxPEFSDqZv6RjtmcPVjCl0xekv7Z1Naqc?=
 =?us-ascii?Q?BJ1kipAwr+x76EjyAkh7Gh+VXrkPyPRK5shsV28+4HMwvr1vv9fHXwNvWKJh?=
 =?us-ascii?Q?Y7+dSsitZDqrimtgNjFMfR8lzLJW2k2bpgUOKpo/f8tljP2o0fjLlPAvq91/?=
 =?us-ascii?Q?WxrrwJ00ifYYEbQVrHBFlc4mK6WKecegIfoWjytz+HfdoZbQb0aXlRkQCEMl?=
 =?us-ascii?Q?zOdIyRVMljJcCHgvoFlYxL301Lfr0vcMqkvlN81CMp9Zhr3mqvl67AJDp5rT?=
 =?us-ascii?Q?Kzw7AGeI9PuW3Ty8j6Z+ndfdbZ2ZB1HcT4m2K4l5Nzgdarj3mQCvwJqYSDOr?=
 =?us-ascii?Q?uXIOVq8fmm7JpexAuAuH5EwuWdsdp1MlHJo5chjmh2qakhVFdYhT0JXaBQj3?=
 =?us-ascii?Q?hegkPSfn3VoD1APBr5YPEw87PHZFTk6g2wkTn5zBdu4coLvrvzj4LsjCQcBQ?=
 =?us-ascii?Q?nHyp4Qt+m7kU95/fhYu7lfDz8M+1xPd1fozreKHLeZyD/orJZtCu0HgWq6bv?=
 =?us-ascii?Q?PYbVcsiOvMWgmdrQHTLZl1w74icITZrnc09r7PcrT?=
X-Microsoft-Antispam-Message-Info: R7Fxf40JTsvGYSF5cxqCUl4/t6FfSJiNaYC20SzAfbketIR8jk9/ni+AwuDKr86liiurnUOHhC5f6bwLhKVDo7bO4wZ9m1zQi0721reRYnI0DjwalNXqs6UFYvUPHW2bCkTq6JrRDYgcLslp5AixA4Z+6SxveshswS8ARldZVEEHOMPCoswelQXcN86jUOLW
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:bfcRwkf36bts3ZF3uZwIqfcCzyDKVqL6fJpYLPwg3mROmcf8e1iY/142YfnSrlIldy/omSAO1c7sYWvcvA4uhU2nS/KCrzMjl4TY08grNU/4BkO3Avgp2iCVYnJfD1oMweqWAHg/lnCH746aAXtq6zo/q7K5UmVy1BLAijVVoKjfY9yF1DurJaCr75BQF4K0H4BUY6Bmn1I0rlt6zR/TSOuul7Z+9KL0yFfgOUryPkc566VMDSrFxMbX5NDtMYojis4Ats3OEDfYFPrgmSjnm7d+Zesbt6f1DIWfwre9VNH+khqytXMT1snZhkOOmw5MRKYk0melUVqNTQyItELQseVJI8IrGBoFX6MMvS2lgeJLZtsxRww/G0zitD9cD0hBH6PvyBtdGm78LUsFQdRR+aFCwe1meZYufrqKq/xEFUgME8xhkwESSEzGgv8iCFgKiQnPlo0+dYdSIdGSPDhpJQ==;5:k4RB28Fm41iAInHfiyn6HtGV/gxFVo5S84gZqHThmj0gsBvuc0fywg1SgWG7uALpBFCuOILO85WwN9oun7QjI5ZuQk21KP241GBF6ppNgG+pCH08SbTC7aZgT/isfauyITzhb6Hr9mjF0CsRFfoQ+SBI6Q8OdbxT9/akcO7++Dg=;24:xectZfkYsgFAYvQzaO485S+MLmlkV2Yap5NqsBb4MtBvIW25IGjYAAbIUidNkDmsLpfvHJxuS4XT96VMgE00AWNcGHOtawqZ3K1KF0JzKNQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:J8ZpcJUxitm8AxoeBTiK/T2hZlwY+vQ3MNDvsxS1L+2JItL3E0u9TPIGM1a/tMlAFiRdv3f5wBIIVMtISHoCW1ms9gsNlb+hiJJeb0tYYjv2NqNMtmClMFp3eATFgY3B+72BRat6BWpppjZIBy0ri8alVu2lXAPz0df3rVqq3RAU1dUVCQyEMZPn1tmnIVolhpXVbXhSMKExfxIu1k4WO+tOEiyQdTgam1Csb0LoOMtJWdw+JftCbCq9sY8oTV5e
X-MS-Office365-Filtering-Correlation-Id: 9b42b3cd-1637-474f-95f2-08d5b5e5cf84
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:48:17.4941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b42b3cd-1637-474f-95f2-08d5b5e5cf84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning -1 (-EPERM) is not appropriate here, go with -EIO.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/media/common/saa7146/saa7146_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/saa7146/saa7146_i2c.c b/drivers/media/common/saa7146/saa7146_i2c.c
index f9e099d812c8..3feddc52c446 100644
--- a/drivers/media/common/saa7146/saa7146_i2c.c
+++ b/drivers/media/common/saa7146/saa7146_i2c.c
@@ -308,7 +308,7 @@ static int saa7146_i2c_transfer(struct saa7146_dev *dev, const struct i2c_msg *m
 	/* prepare the message(s), get number of u32s to transfer */
 	count = saa7146_i2c_msg_prepare(msgs, num, buffer);
 	if ( 0 > count ) {
-		err = -1;
+		err = -EIO;
 		goto out;
 	}
 
@@ -360,7 +360,7 @@ static int saa7146_i2c_transfer(struct saa7146_dev *dev, const struct i2c_msg *m
 	/* if any things had to be read, get the results */
 	if ( 0 != saa7146_i2c_msg_cleanup(msgs, num, buffer)) {
 		DEB_I2C("could not cleanup i2c-message\n");
-		err = -1;
+		err = -EIO;
 		goto out;
 	}
 
-- 
2.11.0

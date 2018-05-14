Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeENO6U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:58:20 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:52928
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754009AbeENOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:31 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 08/21] i2c: eg20t: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:17 +0200
Message-Id: <20180514145330.4857-9-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:UFvG+TMcCie1XCvv6XtLtb3y/rc/2v5Bfnaqv1adKnCcLidRBccQC9baSekbcrHKn8xP818vjO15HSn3ZgwPFwMod0hXTBBuMRm01dSkrK8kUcEj8oRbv+wqhokMi6TsKpGm+6HaUh91QQYwnLJ0FFb2KwXFkBVre+wU43nsy/ZrV1mi3aqi91X9FPci1E0eri94kQZ4VWsjEpq5TeqoPkHCEsdQdEum5vmkwRQ2r+QMoCGVtl2SBhVa1mvuQQQc;25:mx7C0iK0rnk7aELUhoOxuilQCXYNg5Vmrc3r2CgBM9IK+VpoQKdZIz2D2SJYAA9WWNihLh89X5HVa5n3U71O3CKdZEGArQKL/VS3nel4DoTPcK5N8Luud/O1Rnv557PG5eMwodOomTEAHq2QfBncs/IIWZnXiN2n0dYOB5Dr/pcu+BnBNkxfQy5S7kVxVeqaDWe+ybogTMZsg1x/KhaGtQLYmRSOdwOfsd3qHSPBEtlzMWC5HPZ0uIOonPtoImGDgH95d+JZTKEUdeWvUQllXYBjHUe7BE9ClvfLzECM28448S1fMLocmZxhj3XGX5n4Xp8PCzezkkuqznxbz3KHkQ==;31:9P2k0bAdxjogqNnA1B6T29yxB7UPutZF7QanyvM5yRAG33eY73WLMzS2+hVd7ERXTKPvOEH8YxxnqdJ/3apQAZn4uubo96UoYlBq9n5ktsUpAeG/88TltXPaC8AY41+a7eLUJ+7rkB9wp7z1ZmrOxIEKFlrsbgB0Dgt0n32Km5BrSHYv6dEdocgX6b45N20wwefPYeN08U0idZJxwPpjBwgO0uUzhbd3IIAV982tIQY=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782C726E016EB69EF68FE52BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:N1fQjpLXu/jWxWNmvGKe3DeR1MxSntpLf/bNEOQwDwr67ONqryiIUEeXlB6aDgh5o9hzKujoDOXoM/vc7gJUItxEPcZi1x0KmdSWBoBcIW2zkvuelLwArbHTyS/rGNyk3QNwnR4JYh0dcs3D548c1sk9W76JGpX8WOEpseg36cgkZ84n2V2vCL6akMQByH94HBHGALbNJ1s90mQrkT26Kh1aHh9YNMkGrxbSzMeCmQ5wid23uewfSbaIVACUxyUJkkApqNRDM/5GFV6gfq5xBw==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:3QuW6bjonsuwQMx2zAZ7wU8ZyKgu7FJzxD3lsj2?=
 =?us-ascii?Q?w3ff2DkgcdxOBn9IVveU/2Cg/ZmsXxt9kifBp4v23XIcIBNSbEe/IxLJkdmZ?=
 =?us-ascii?Q?z/AI40pL9vA0UYofx14gFD4nCrMqVRry32EAdTF0b75UH+UThN+vnN722ecd?=
 =?us-ascii?Q?sErq+kepmmGNKKgK1JEu0uLEgVCP0UyhaNSHCt57u8Suxt473DQ2EbHsMC5Y?=
 =?us-ascii?Q?Vu+tokh+d1rOBvI4UkCyGhH+E1Xa0Ykcl7362soZo3gJzzGHrRFeDNHr9jyM?=
 =?us-ascii?Q?wekoRcTNp7D7Y1Zm21bILIlWTGH4rru5m7+sa/L+3fvnFdZzyMKs5pYlTZJM?=
 =?us-ascii?Q?Awiu94UXbYTngG/uRYVEyodA9+RBAmCMZnrddQ+KNxERTC+yIbcma31JD7wu?=
 =?us-ascii?Q?qVoQbZKQRRpIJFruFeJCYoLhsHQbeVWw6Dguli6BScCC1FeMZ1xTYTMVoMcY?=
 =?us-ascii?Q?b/7pveBCUPrftTPOrUM5gAmg1l6jWxzBtgNSgC5l4usZkdbl0H3B3VrcWAuF?=
 =?us-ascii?Q?T7Sbp8ks0mex1n3l8BBGv9p3LuT7fmPOctuDKLLnOHKSw8cTgLnEcYsrGti3?=
 =?us-ascii?Q?zwJsrcpZNlxix3UEU1CnwDJGg7AR6oMxkUXQuXlGgxSBLot8buKEtG9U684Y?=
 =?us-ascii?Q?rJQzXWcc6y2D7Tjpl1IYOtbmjzZjusrZqi0BFwDoEoBxfGATfNdU8n9ciEVD?=
 =?us-ascii?Q?4aN6Zd/senKfmpX6EfDt5haDCH4py60U179Zd8MrBoeYHMNjd+s6RJRVSA+0?=
 =?us-ascii?Q?Kf2NNJhRm+oBiNclCLD4YgaJhJfdHGdyMoH1p+LIL0oC/s2Z+eV5N8P78/OF?=
 =?us-ascii?Q?TFTN6Ou+AUjG/aD9mhpm287FczkJTr78CZUHmjm7f4C3n7fDSXz1+tq0SpI8?=
 =?us-ascii?Q?0mJ9xi4ASOQUMsoy4Cb9AWO5wujnMkVRprtUlj9ub3lxpw3dp7CPRSiwb21b?=
 =?us-ascii?Q?wU8reLavsuDuMZwpW9ntvoCtc3TxP9eMauQBsHaqnNmAL2tMTOHcm2itOM3V?=
 =?us-ascii?Q?JcBEkVHCJKqXZWVwd0ntEiPZHgP0SbaOZQYwAV1fQ5BzVGSD3efJDP4ObGGs?=
 =?us-ascii?Q?jfl4vlNeiS8OTn7h7f4s2gA4pWfS6W3MdVCMM25q4kX78AmYshIQPvhxFSeu?=
 =?us-ascii?Q?2BS3ajZ0bFWYPUEVt+3LUI9hywqyQMkoNXjIPEJk1DQxcri4F8BXW9A77eMY?=
 =?us-ascii?Q?YXvos641xxCxwhadI3sIHban5Z+xpDnHXe+uEa2r8sITaPV4SKpiIWDnqw+A?=
 =?us-ascii?Q?CWa0IRlnDAxMZXUjZx41HgInLZ67QpdyhmJgAVGmdWTXXobkS2uKXBTgnJJC?=
 =?us-ascii?Q?jF8EJmn+FBu0efYPjSgNeekaQ/7YTIwBIVwYioti/LyUF?=
X-Microsoft-Antispam-Message-Info: weae/1Li7zmjHz1s1GAKJ2gTa/QgwAkakWmh81jF9BzfCQwV0lvrK++ob/T+5Iu6nK7t7zkHObTnBCTwSY+YEPGHw7jtzSX3akPa85gLdzQXOEczIgHJ6n4x3berdjEANJHFIzQc/V56AbS7tN5SQ+hAx3S2vQVcnz/1wy3mJutij4q2ymtBiwDKkg1KW9nH
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:H5bzYPEDv5UBnsuweouUnpGrqh8u+eQTiGCF/nWsB0VSJtECw314da9SMPhn9GE5TEiTblZ5miMSeBTIgTamVkhVc8f+gO0YpuMOQKGNGLTGIiZe00mQpQ4I4Xx5kBNcWv39rW+7sNI5/rHRS2KP14w1mOLbIcnTUPea2ftrAuLye9VFUmnVljWrrIKyyn2uQlzZytSr7eyhEG3riS3FmtyLtrb9xUx5GD6MuyDF8CXHEVN+aGK+guMEdFR95IcED8mDTZG2/MizEPmWJAIxkKzIrPlfFWFTcC9KBVFbw+o98fdYC+z/GwSed37ZiAHez1SiDF+watWPlVDZpXdmcwiFft7nVYHdX/N8tZXQMw/b1UVHhqGaq2i2jQ8k8zAtHRt1Lo8WoYyQw+XO334NRpLKWkEZY+Z/Uu4hhoU08mQVYigeVWS69VRs/wf+R8GI01ftSDL3xgOYxfUB2w3Dvg==;5:jePu8VrfDlUjVr7OGbRLhSmnr8NoJttiQnUigmYFeEubxi3eWmLbkX4aC0vb6+xKcJUdLSqoVtdiTl4W0iV3buFFDZRbSxVnYIdEZtOfdGpXaXEub2YwLC2odU+Kr2N5iiNTGiRnx/gADonycLYmflHtIQ1n3oPyjeOELEtzajI=;24:lTij5K29E161ek4+9kEiIq3OQZWRYczblHqOgdwq+4gRWOD+t+trdt746GE7wjVHZkrErkCQHrFLVP92LqpS0vjNM8gq6M+jozfZIk3PuUE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:c+UFbbCthSnhvqSLhja+qGsH2nijupBuimIU1tJBNCGhTTycQeG082Ky98Omw8w/0YYk/VprvX3S2r/q2RLVXOgP/4DTABXAoLfDcVAOCs5T9wHh48m5j5mQ7qwNo/maM9ofuqoOEEoSsqlJFlFa6I3kAmsUrNJ1d9MC/yjNfmcOsTvCsTOTsHfkyqEr+lZfUnuQ2HezlqwEOyKXZwj10QzUxys7xiDjvsK92zRnzJQQt2yxMYNlR0rQ4d72D5DI
X-MS-Office365-Filtering-Correlation-Id: fd57419c-1260-4396-633f-08d5b9aa97d8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:28.2162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd57419c-1260-4396-633f-08d5b9aa97d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.
pch_i2c_writebytes is always called with a write in msgs->flags,
and pch_i2c_readbytes with a read.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-eg20t.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bdeab0174fec..835d54ac2971 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -414,7 +414,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		iowrite32(addr_8_lsb, p + PCH_I2CDR);
 	} else {
 		/* set 7 bit slave address and R/W bit as 0 */
-		iowrite32(addr << 1, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 		if (first)
 			pch_i2c_start(adap);
 	}
@@ -538,8 +538,7 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2CDR);
 	} else {
 		/* 7 address bits + R/W bit */
-		addr = (((addr) << 1) | (I2C_RD));
-		iowrite32(addr, p + PCH_I2CDR);
+		iowrite32(i2c_8bit_addr_from_msg(msgs), p + PCH_I2CDR);
 	}
 
 	/* check if it is the first message */
-- 
2.11.0

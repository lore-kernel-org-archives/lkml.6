Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965851AbeEITqy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:46:54 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:55011
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965181AbeEITqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:46:49 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] i2c: pmcmsp: fix error return from master_xfer
Date: Wed,  9 May 2018 21:46:30 +0200
Message-Id: <20180509194630.29047-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180509194630.29047-1-peda@axentia.se>
References: <20180509194630.29047-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0190.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::14) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:wbphEgT0EK3R0JjgZCY6byJ/Pefy4CLhFfVIp1lH+cK3fEC/UMoLEyTK3gZb6fDFZapagZYICHTPIUbuR5k0hN8FM5Ncwj6P3QcargYUKRAWt9nBxe2QxDEzes2SYNVBOETmmSAQ46VXPQ65K9oGTGFdzp7uGzuFANsth3u22otUr3tDBmbS2t531AyZsoHBc64FHNqWEJuhTFKx3Ti80K3kM3ImnLUUKtVHLVco1glONiarjMlllSJ8uw3b+CCC;25:mjSzPzaxE1HL/w5Pt+9fSztb9/D1N88wuB5nvWQ2RYzYZtWR+HjQ6g58VJk0CJqPds/CSz/j0CRZigAk/hBjBjW5fUFlw4d9mLyCJOb/LofLh2PVm6LGKM6OHEG1hoAyS4EWi7ogo/R3jDjKaGQNzbsyifePQ1CEgP9Zo+5Q0FZh7mvKO6xVYU/4PVZBzr/shIlvVXM3KYBLY43TM+V5T2d/3JBCHfy8DQGvtHgJuvHsz+avkwpW7Hz52KmE5pp5WDV4kKAywHbL1bsIMQrlpQobUE1qMrCxrjYZCjbCShxo1YmTzv+i4AOBhEHU0+w/Otc8iasX6pMN+Qje4wv1Nw==;31:jthS/+HbbO0SLpFAjnUBz1jM8kYvHb5wRwd95GtxpSyz28Zi0UPDOVYgCpWy9jtOn0ELqyEn2cnDg0dNdbts5LcgHsK7itsXw1j5XpeMFZ+aOkIK3wNDy2inDqFIpk0YPVqoUEYXu5/SRQxOFIN4xMQCVCXH1MmQ9AirECL0MD3fJwMH3bFpSJS7Sk2FbAFraPSgtWXyAXoERD4RtIR5umd19bagk2lOku5y+yyLIm8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2781EA1F22975C46A506758ABC990@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:AQYX2qqct8/eiGe0Yv/2smwr4GfRfFizi30T8eJPpH4K9KTZhfgEOFEAiqwZ2+mmRhCamuMX9ABZQems2IUVdCqSQrfIp5+rYtL2SETywurDIX2tc9CIB8hYOkNSKdjV/TqieAa94OeFIrhbaKN2x321B7iGgfoosYAYLKg+TLKkFE9/n14IY1nSoMFxabWRDe0NF+7EuWuEKc7ACRKDZg/Gl9+48IY60zVUb54OilkaC/tVaxmnVZEhpWKfFiOecpVcEvh/PcdqLTXveUu71A==
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39840400004)(366004)(346002)(39380400002)(189003)(199004)(6666003)(1076002)(86362001)(386003)(6506007)(76176011)(25786009)(59450400001)(305945005)(6512007)(11346002)(68736007)(26005)(2906002)(476003)(4326008)(486006)(66066001)(52116002)(54906003)(2351001)(478600001)(16586007)(2616005)(51416003)(53936002)(7736002)(36756003)(446003)(47776003)(956004)(6486002)(2361001)(186003)(81156014)(8676002)(81166006)(16526019)(6916009)(316002)(5660300001)(50226002)(8936002)(106356001)(97736004)(105586002)(50466002)(3846002)(48376002)(74482002)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2781;23:zBn91mqiWxpGAsCQQP5qPOAhGz4p+8umjaGJ6lT?=
 =?us-ascii?Q?Qx4W7cA6j+qf6saEaArf3/Kxy7F3JfncAl4OM6MNFBBwfh4Om3tXGgY9Cf/p?=
 =?us-ascii?Q?VtAZqgVUPmQSGNVvgLNIJaYpx1YDV/mxQS1jJLdRK84Pmc1bVdzUVzlt1da7?=
 =?us-ascii?Q?dGCexHLM8meibvbsXmCACFmk8B3iJa/VkCKJ+ZxnWSPw7VIECvwuAEIlalGH?=
 =?us-ascii?Q?c2/tPJnUNmUnfuNRl2RBonOj5xJ8yi8FGIT17djRbHAmGh00wcrhpklJav6c?=
 =?us-ascii?Q?DF/evv1gmwThPbLGbvVgjvTA5EXlboM8BEF5xbreMfzCy1jlpamOn6q+6W7Z?=
 =?us-ascii?Q?23j/LH6ovqeF8Mz6mJqHfPewCH1T8Onw0pClvQ8WONw5IFFexObjEYvIpybK?=
 =?us-ascii?Q?5znzAy5RBCkB2LdkcLihVrvjaLAmHun0IxD5+8fsCEQiSmGV79taf5ysNwlF?=
 =?us-ascii?Q?28eedMtdPfz5KOXua8tIpujmyC3ae1AOhWMet2qma+HrnELabPFc4iVkgZdI?=
 =?us-ascii?Q?wVbM6AECOiJRjL7PX4sqJd3ofGR/w5vi8y6PFgDRw0ysgbT5N3pzGs/zY9tK?=
 =?us-ascii?Q?A8YTlNcLV3ODSMLM19PhUuOsxuWqbfJ8hO8mqy9mBEXjmGezzSdHfVEaUDJ0?=
 =?us-ascii?Q?Box5ScqtI5JHDHNl3LXqKAeKyoDXbsU1/9PiNjvf4T/RpnfOjPZHstWFZC3S?=
 =?us-ascii?Q?cAKU/2YzcvzSnJt0/OhKqfaM+l6+eyPcz2qts9PAPCqBrEFPd/iQISe3Ogyi?=
 =?us-ascii?Q?pw1X6CmGnO/oucEWEj3fGDWbO/vlyIDwj8P6Ul3B+IakIldklcswJy0ozsQn?=
 =?us-ascii?Q?QHOYfrtmEiVEcfsof6TSDTefBHi7TRz2/+WR8S6ZRiup6gHZkgevgspYFvVL?=
 =?us-ascii?Q?8f5B0bndW1VYClbZDCBZlAqQrkfObWJvl/VdXL747G3OXrvA8Q70FnYEtzLe?=
 =?us-ascii?Q?gpSBzCQBvrMUk01pk7L7BEEODOtXMutx82sQY5yeW34ozPQhhls3+9FVtNTl?=
 =?us-ascii?Q?mYXPZWWot+lrUzsMUhgZ3ZoqfcbrjmzztFz/Lgx572yDzYoBPiz1agOX3sDM?=
 =?us-ascii?Q?eVsOYfXBluwEMYLqxMKeH+D4GcA7sYSTG2Fl/Ra+NUUJUfMwUV6Q+PRal+cM?=
 =?us-ascii?Q?ZsVeGJdYKAWf3tdEcU4NS4LCvcTcYg9f3ZdfLOT0WPBhwWB+zdedqtPKtV1n?=
 =?us-ascii?Q?nYM5VDoxjh5POrfBfN4sa1LmH7llUvn6ul132vkOHmKpR3U/Nq/YjFHnt/0+?=
 =?us-ascii?Q?P9jZKH9nZTgK6SXWWjJFSQQqZd+4yjJHY8UQF2Q6HW6RkBc+k3XJQUHo5Rar?=
 =?us-ascii?Q?fXM8MXCSu1nVYbxuvKwvYXMpjSfwzAmiBxAkMiWyKwGEs?=
X-Microsoft-Antispam-Message-Info: Ux5dj3tfZNmZFoA7mwkUuWghGY/sqxZpP3EFGm8QadzXBYvgdxS82FTsXcHY1E0D1NEXpBd6c2W5fD2ULTH/J88tcuCt3oEWqnwMV92O4SnVtRu6+zZ5gGbGCezkxM4XAdz8Fx7+SKaHxX24rdcwpnzTRmlTGyVVqAhQKw+d7jvAD7MOH48JEa9Uc2ySjj67
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:7mS1tumaec8JzX9SVdHkAzkTcg6TYazkkPSVVvWyS0CT4FSwF7Q638uQ9AUs6rxQKjCodirfUMBudfBSFzQFrYeX7K3MSHLYcqRB92CcugY4hMrpfEN7EG5YeRn/U37lcHszPGd6ghxB0Ar3Yse6D5Hik1bgVyRa3MfHA3Fk0MbLN9BOX5/D2cdB44u57bsYW7Opoj9I3uojI1vO1pl7rAnho8JP7Q6Ng0pTciSR+T1TRB+x962n6GPfXIEkqduPBeYVMUh7tEy+skTBOaeShb/hOuB/9trJhyf0DD3xu8vtBj2B8DOyUadRjHwg8s4o+zAf4h3pCPBg/OeFFPPs7cIftq4LzWoldaDlL/Go+vcxZ+MN7enRXTy1j4gW9Puc+Tbx5kc+Wj0buhly8GDD/lXqE6RY/FmsgjEhS5iB+Pcsk9N8vURgsEB9Jr7P0MX2IjRXJjj0tA0zbuu+0E2fbQ==;5:yRSxF6H3aYnguYyTFc5yYmRe7Vo1HbnhPv0hiWxWS0zRtyaUwju2hbzYVxyoPuklzKhb9yYVQCAyuVxih93M9g8gSInl2FzR+ls7ofYGF4dRx/Mr6Jfwr8v8Bkp/DCJuXc2OugPwzP1ajDUCYcVMPO7u1QkXV+QxN/68cjJQnpA=;24:O5heJ0k+W8WiSV9aPpTjSZite7uaDF/474UxwqEJofIYwOWJ/NsB430zxxO+0+rVB/c05HTA9X6MFUMFd9GPfucs+nlVazX+5EcFhtgOWqA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:818N8/iHAOEkNUvnsohKyBUBgdhtqNx+cytZSzFxckx1GY0oD9krTLHt+ErJjVmc+94CR6Gsj1Hez63TlD5gDT6sa3sup9oPW9KW+aPwPvtpvm38zaNpejqG01/zctVOzpLNhwtgEnFNOoHuzil2RikWCffeVJSMtwO9KTriPNAqSF7JaIUMt88yfNtxSRk7w7DI2nIv86AiI0QbmYTeGchavM24RmzBq4yn7fRecjtjes3eRNwSwP2RzV5NYznx
X-MS-Office365-Filtering-Correlation-Id: 581cc417-0714-47df-4e0f-08d5b5e5997e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 19:46:46.5279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 581cc417-0714-47df-4e0f-08d5b5e5997e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning -1 (-EPERM) is not appropriate here, go with -EIO.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-pmcmsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index ec27e27e8d06..dae8ac618a52 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -564,7 +564,7 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		 * TODO: We could potentially loop and retry in the case
 		 * of MSP_TWI_XFER_TIMEOUT.
 		 */
-		return -1;
+		return -EIO;
 	}
 
 	return num;
-- 
2.11.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757200AbeDZWc6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:58 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757127AbeDZWcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/24] drm/bridge: tc358767: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:30 +0200
Message-Id: <20180426223139.16740-16-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:05+f1HB5kQ8y3UK5zxYDjCxtO6eGxibNwGqcz8UKpIOcDKkS7jI2pRX5CzCHNI/Fh1GAnoGZq/2WamlCxmy/4cjmVO1I0y6b9FzDmNGR2IqIN6DSMY+Q7pGEwHuxqllqqOIYgYBiopBIxTzfQhoM5krBL6Rrmaqsk64QS1S3jrNyRc53Ns3p55NNnSVt8ZYglgKifVi3r1e2zuzHKeqhKTxBTwWRL6RChGm5ZNKQQgtBub/thGP7uhIcbKhB2aDQ;25:sYW2DVzV47j6pTVf2Fd6vTm6G7lhN6UBAF/jwfnPf3NzU1oxbxVJb2eG8lsAE3h9j5AOOFym7I1WuZ4DQZETKtDo3yZXKyDz89/5yilmP5R7v8QKtCLi3+vCeOlHYHj0B0Vmh919Rq5CGZ77sMCjtMc5PswxDWGQDd/cpLluMu5Q+aO2UUHyPaGh+2TiYwLXwUfDmK4RIsTyXBmlJQzsjrUM9bEl+9S3Il28f8/lISXkthaxQm3p9Gwnlm6Hb0tCvvI0DjevviEqED7y7JCzyVlsKDl1piVm4RdbJDooNPQHsnTb87KapcFsYoMIaVmyEc6W1XpmNWedipEMFKVOtA==;31:5s/995NWOQznm3p3kA7qIfIRWFWOhGBAe3LXFjKfrhp7bMmJ+V3g5V1flGS/kmRisCxDWwLiaPCKZKZC2LjbaZfRlCtJryW+gGwfFyT1ui1OMMuKed7XlQXq13GSn5A3Vj37iHYstAD0G5Rxkkplg6GwFTJTYOpCGrBKtRv1sEqV1luXFOg2oimNqc3EJLVNbQNqlM0YbNS095jyP/dKIxV1LpkkjCiESQDGgLlE8aQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278223A703402E6644454808BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:dXbLrbaYmaw1UBy2jCURRoY/yQFayjb5LgcSOVBIx9QFoTFlb7evenkK95G1+zZ9YVakX8VUxHdeGv8BeS5rWhCY1Sq1xV7VayNUhM2r3KopLV3isuP/5mrrEKlVNZfoIMfZSYiBYsHPGPw1cSGNvENijNBhMqEZ+MSI8AIrua5wq/wf3JWye78KmoYM2FcDlhpLlZipKk/dUIaBV0tZMwz7A367RoGCl5LjuXKbpU7VzF6api99wlvEj7Uozsh1p+/4imiR5byV3v39yjfrMg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(956004)(8676002)(76176011)(26005)(6512007)(486006)(6506007)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:jdzdgiLHTBO7nK3OZs8NaXDX/sWtCHLCSFb9PJs?=
 =?us-ascii?Q?54fqaLcfAFIRJWAveo4fQwegbTan/lW3Lx2lZQVeyZJ8cK4kchk31tsTu7e4?=
 =?us-ascii?Q?AUeJE8YzjlmHZuo0eJ7IIW1JT8CFQZaA1ZNlsYiffC8vCwnQ3h/ZxPDzz5H1?=
 =?us-ascii?Q?iDIVmbU5TNggE2dgH3aKWks1AssiwBE3l7/GYVZIy6rIRxwA+5TG9pyw7Eb6?=
 =?us-ascii?Q?ebVw7jhR3cbvOONRLhAf+PiS/KUUOLVOUD5w5BaYCJss06yKwHS8r2PEHFZC?=
 =?us-ascii?Q?YWXrjyEh4Cf7YMAHsfWT0z460Nv/XX5i+gZI4fsgeLNy61UTm7pXbJ/uHLC6?=
 =?us-ascii?Q?z4NUvtDfBsWHHprJSC46pHwU2kBwncLK++bxnTSxYR5hd4ktUtCW/NnxwsgG?=
 =?us-ascii?Q?ub3hWlYimMnfWNHOIKrYLkcXI3HfumjgxqncOzYJqRHQ/6fr8zFFBU6dBycr?=
 =?us-ascii?Q?CuI5CliS525YboJn6DWJfIFlRyzB98kfA26fajS30ZmnZ8BMn0ZDPHzkluje?=
 =?us-ascii?Q?aJzOgIUCdZzIfFfm7xouVMf9ONyNLrzZb2vfqHZRBbVDHBkHJ3/ARgtjpBtk?=
 =?us-ascii?Q?26+9JaFzbW2MAtB8kgnnQIridk4MbEg4devTcNUvlF2FPaPwlsIKfK8cB4HS?=
 =?us-ascii?Q?Pw4qV3tfuwlwI1zECmHucSPBsamDGzuJ8GHftRgzWixY48kq1L9xHg+R9fCm?=
 =?us-ascii?Q?qH51QrDRvKSnbJJuAahyQLC41cM0ZiI/mNPzqNcIy5XHnAQz8BZ2xCsNtBhq?=
 =?us-ascii?Q?beo+0VdmYrlaFOrxDnjWPUOHlI3zUh4MzfijOtRdDp6JDvmlKF1h0DeYCK1m?=
 =?us-ascii?Q?nl2LK0XiC225QieDkIJjvKAwhfJBtpHxI68nRxxyXY1epQofYwohlXFanfLz?=
 =?us-ascii?Q?YBrwFN8ZH8KhfUQXZOWLoPaae0bRIXdBK5K8R6nSgCTJgflRj9ZiBQILIC61?=
 =?us-ascii?Q?puaEMdg+4m0m+ss53NRQJ7z09ngRnocakb26B5iPjN7WlBbD1YhAXTjEYUxW?=
 =?us-ascii?Q?ouGB80NaHtE9l7UAIlyK2ycAy6Felayx+vPXyQnIAv7K485av9JU0yJ5H3gF?=
 =?us-ascii?Q?s7riwiypJtC8AF3Oc8dykSSUxxKBuvfKy2FlWICmemPyoD8eSjCfZz+kobBB?=
 =?us-ascii?Q?1NkOBKG2DsjIyuwL+pUzLSINxypM31Td+XR8IRMWklTYLSPdJdIJUvudrJRz?=
 =?us-ascii?Q?7cfRVDbjaD5bwHnNH6WYh+vdB7bdTTXXoPxHo1bCKEemFy4DH5xY6MeUMux2?=
 =?us-ascii?Q?i2eU417r0VHwOVBOllf74DNdtRK0Wg7hUVaQpzPcUNIEQJVgRwoOS7dh6FVx?=
 =?us-ascii?Q?S0RhdUt3PcgjZj4GT9Muqim+72Trxq6/EQUuE+OF+TMc9RSrGxkrR8fJBvgh?=
 =?us-ascii?Q?lpEfqBQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: AF6rC2Z5k3E3O4J/jMqg2NcSVp2ecLDZBmyw5mNz8BQBczaj2nG94PrhouKctNZx3kNFGwwEyqrInUKD9hAaq2z7+3Ue7r+XjunnrLs2W6/bWzWrQ7V9JyoXoeKIDYTVWdURandt/fDAxa+DPK0dUrNlrjXO8HU5ZQBaMcBCgwdjrjfhSGdvmC8FUeo7CwYX
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:iIsnCuWwJ58nAlSsGsb2Ueellhlwgw6Z9etzW3LQw+4ppRfcPSC1xSCFE1Ku3zFVQL9F9wGLXXSzXmVXXyzxnoWJn4/bC9TImi3b8TXQnH3qBDRJzB1I6E5zone1xXt1jFZ9sN0VL4JL7HuH+Mz4hFD33BvtwDqMfvAdekCG/7TrV9NFIOyHXoTCoUy0ZHEWGB3XumcAx3v+ezYgS4YmAGa0ohOx6qPcUG605UnAuk4fOL4UMRn3uuAEVcwRqbRLXoxzVI7vUV2Tccx30Gv78cNHP2gQ2K092oFPEAEteUpFYR+Rjv497z8lvAynFwPNFnQG7Cq+QM+knFEeC4J3seNdadPuz5noD4SnslRxH9KEEW+zb6mlQlYhslPdesfuvCdfQWx1DK+AgV6sIMKqxCTxwvRGfJDF42oz8lD3Mw+fv6siPalXNdNWDoSt5MyM/aOk/SBs6ii8mZvxbWQQcQ==;5:feAGeGUbAl2SKQT3aYY6wlRPmBUBYD0BqvDg9UahmqcxK99/Ccs5p2W/zYDv+6CGWOGYXvQHxYlKvFCQ72NhHRrr1sCh1ygnbLDo+P9948hiiugNWz7mHYysdMOyfHFIS4StsWYMWNIhooJ2Qwfh9yoosqmAHMx0pq51wz8PSG8=;24:JPYFkmWE/tZMUe3AqRuMfIKRozSJ1EDphMPGGW6v5jxq4siu7B/2GxcF9i6xeRfQbszjy6bH8/fYBXqIlB7OFFckW33LrqyGSxwZXqdetWw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:iihNF7GbAqZ/m5P5F2XceW+ojF/wcY+7htkq/mPfnL1lB6dGMDx0dJ1U40GeTOoBJGdY9nwCzNTM4SGl/5JOOENlJMIJ3ruS4hZtwF3LbHknCyOSOQSkJmL04k5rpqu2yZBFBZM74bKMxTfCRHJGUqNB6ywtA2TZwI/BD0FDJTszHPp2jJQ9uVRugvIw1HePPgobmkEst9W1SmT3IW0B5h1CU9jMmrPq0luxSUBCoQtiLUb+yKi27RwpKYtyu5Q0
X-MS-Office365-Filtering-Correlation-Id: 6aecc2e6-0a4e-4dda-5e77-08d5abc5a0d8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:43.1359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aecc2e6-0a4e-4dda-5e77-08d5abc5a0d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 08ab7d6aea65..a16573bb8715 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1331,8 +1331,8 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	tc_connector_set_polling(tc, &tc->connector);
 
+	tc->bridge.owner = dev;
 	tc->bridge.funcs = &tc_bridge_funcs;
-	tc->bridge.of_node = dev->of_node;
 	drm_bridge_add(&tc->bridge);
 
 	i2c_set_clientdata(client, tc);
-- 
2.11.0

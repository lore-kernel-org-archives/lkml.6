Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCUGzt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:55:49 -0400
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:30016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751317AbeCUGzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mturquette@baylibre.com>, <hdegoede@redhat.com>,
        <b.zolnierkie@samsung.com>, <linux@armlinux.org.uk>,
        <linux-fbdev@vger.kernel.org>, <linux-imx@nxp.com>, <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/4] clk: new APIs to handle all available clocks
Date: Wed, 21 Mar 2018 10:54:50 +0800
Message-ID: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660889454149454;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39380400002)(39860400002)(376002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(104016004)(36756003)(26005)(26826003)(47776003)(16586007)(6306002)(54906003)(498600001)(50466002)(77096007)(966005)(97736004)(81156014)(4326008)(81166006)(8676002)(2351001)(450100002)(105606002)(48376002)(106466001)(356003)(8936002)(2906002)(6916009)(305945005)(316002)(51416003)(6666003)(86362001)(5660300001)(85426001)(53936002)(50226002)(68736007)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB349;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC012;1:QITi8vAuA6Ytf45ydvvRWGNylQfRe5TvrPIAGZtmw0K7BdiY6REbY8+lqzZWQ0yivyD4/ZxXItlxSSyZxa9Na/b7qw0tnhnVQ4DySphCiDUBkgrEFcDsQ718eHjZqqp9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8fb8425-70a0-4622-f466-08d58ef8c51d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM2PR03MB349;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;3:bT4ZfP8ANLavL8QmIVonn+629mJSz2pstJFL2/dLyBd2ZKB2zNt8RvxQU8oh/IB3Jkl6Fe5dx5/tESLq5S9XjWHfLZESsuMvB5EdfFVc0tpxzaBIICwOe7PIbWeDIgkMJpbO+/2gRfHAlBZrBzzJ1aDIaMviEyeqB5tgIyenS5m+YdAIpay6gRA4enPefWvyWcI1Ir08QmKxCYBnWdE6WMjC9Mn79dTwjfB8DVfvJyvJ5jPnWX4fUK8L54rl8n3euIconwg3eyLY+zEbiPZF+fzUGPlup7pUQFcrFgpLrBfupsFYnJqPj2kivHZrpuejCux5be3itmYB+XCZpBlgZUdZJxhvJaX+OU9JDCZawPQ=;25:jOIGcNQKwl2aLph5869Dyx/pL8qwaCsTrPx1XnKBOwAWY8C6S6wcCgD7xP+3yxJm15CRL3QgFaZrli9VZz1UEbRKhHSs3UcSdprj1G987Vv6kCvT+EpdNj5p/qh2/d/BVaMUC08RmnUPpYWrfS9y3gRduBB8Wkt1NDaZmip9lr27KpDLqvTpC47jl8BWXL3Mt7f3sG9Y7cWCyEBFnjfWbu+H8XAIl+VjZjlI6D6HOiSpOLrZ3yQQzR6uyj1aYjtUBobwEqhGS2jh1CGeTpesYgJ8GQO72ZFoEovIE8V4Ww4z5LKz8idOlSsNaz27M5b0niThbY+qvIERV6jA20Sm3Q==
X-MS-TrafficTypeDiagnostic: DM2PR03MB349:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;31:MPPEb6m3E3IDTAqoThsOIAynNojoPlHzfNP9wLa/1J+0DJ92UzlSLKKoESnvici9LG7ahhtcWqc2MYazip/beEK2DSeot7obxWdpDTsf5YbmDpAxRH2IOEsZU7xKWQ3c44HQARYWBHR5eM0psLWuBc1U8WhVJrgazDsYIXYDYZXqGOJo3+mH9Bs4UBsFNrEST5wLP/vgIKh9GChpfobQQHCqKGWXRkgmMlRMqh313lM=;4:x3VTPsfNgjPsIFUDVke7mR+1eMaIVZwHFibqEOaFGuekZec5Juxob2Gg+iDtZ/KrW8WuO8ADqanMfvbHUXf+DWVX9BNuKltWQSPI5VemQ/V9kIWFZeBFHkPn05WSTLGZEgnCmm3sCpRQum+8i4J8sw5LhsjwM5Mdt3UkCWidNVaVM5q9C4XJyAEpbdUydXNNOYKoiDs+pzcB7bgGlacjBPPBD+aLReDXBHErZxv2g+3fGl+NOyJhdFEtzmXgBWpRtSp2ZBQm1Daa33ASUtMFmw==
X-Microsoft-Antispam-PRVS: <DM2PR03MB349598A0554896B90B6698B80AA0@DM2PR03MB349.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501320)(52105095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123561025)(20161123559100)(20161123565025)(20161123563025)(20161123556025)(201708071742011);SRVR:DM2PR03MB349;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB349;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB349;23:cNrJtgDn2DBKgu5PgZPp7M8nQxzbnhSu0rPhKRX5O0?=
 =?us-ascii?Q?CL4dfwcanHHNg9PAF9zK2RuPIfPSiet8VbbdI79Rw2WicaEaUKxWswEHFzp+?=
 =?us-ascii?Q?6tETGM1tSws+iwfjA65t7H/nXtdVoxZc/QXSPYY4Rci1NAHJH5QjRgwJcLgN?=
 =?us-ascii?Q?jHipmtIc1ZPsBw6Mj7RlbYGlSGj5YJenFPHxjr9mJymDldjgvkWTyNziTUo0?=
 =?us-ascii?Q?siDgSmkCui69itJbhZ5LeelJd31f4L+2lQqBLvIl3e2yx3SHe8/ukJPJOX83?=
 =?us-ascii?Q?tqOPrCgs6O0wQbm/3f4jY1Jmv7tZfwVv8Ym6dl7YQWcNWtceQHGSWyUMn0i9?=
 =?us-ascii?Q?BPP576PsmW3Nzbkim2fibkWErkg+Pmsf6iq71vF1UNA43KYuoMrF4Yq0wn4i?=
 =?us-ascii?Q?vRKMQXyt8QoVE9A7LvSgCOS3J3H4hZusrwX6OdmY8AStjDY8GRWHvysVzxOO?=
 =?us-ascii?Q?KmHGrSuHkMYoIj/qZDjdVELcR1jiWwlUWrm7i/tKAvFjcoQYjlSv3kERmKTY?=
 =?us-ascii?Q?nKVNiBNB9dDqdvgYAhkrZ2CRJeIn/dOQ6HhV0fXIcy0bdx8aRXF/a7Fm+e4S?=
 =?us-ascii?Q?RaMrSzA+IKpSdEZ9QCYBvrOEoCYbwc8ZafVF8XAkpKdFlXChPTJheqZJ8tk3?=
 =?us-ascii?Q?GVnS152ER4MDMp8QyGtsHRForpDeyQ5j/tsrDI94qKHHYMIbB2Op4PtJWp3w?=
 =?us-ascii?Q?pCJFPVz1YlZZE8oWxa39yDaytnEVUc/z91elyIdOC/TOJzq/Lq/t1/SuaUxI?=
 =?us-ascii?Q?JbPp9tFbdEat/aIxEzAY4nd6rqusqobxV5c9pGB5NL0x8CYCWUJfRz3wGWHg?=
 =?us-ascii?Q?Vt8R7Ax+5WzCltheLJxfDtvDJKMYM1nJQdOxT1221uMnNY81pHVcOwdSicQz?=
 =?us-ascii?Q?SpgIHgj6/kIU1btJqnWUREydxeFMAac6Fw/+5EdlLO+mfTSR1PqCQqGDK41H?=
 =?us-ascii?Q?PTEDgeMjpJNMs7iGDs1zilOpZ6qDuxp0hV4lgID2ELUZ7yKhUDQIExbjNtMl?=
 =?us-ascii?Q?oafb96cJtEMQfiIyN2ci2H8Lf7889/v16J6wJs0WZU6IWyjdmgNoOOJCbFhm?=
 =?us-ascii?Q?Jcl9K2Yw7z0afVhEBtefv/keih0UcB+mnbALWnduQ8iLWgGUDMlsGQ7zx1F4?=
 =?us-ascii?Q?zcHrPcnkA=3D?=
X-Microsoft-Antispam-Message-Info: 98iwOIOLuba432PTeIli2B5ACUcw7JtDj6ETVkFT78VA4tZHVQObiJBHplTq3EaE9QaTpXNwvZQ+6Ro9oC57INNfhbgNpDqyjf6K34vXjVXUXE4yzYnbcH25bCJK8ZgV0M41yLjfd5oQciom/3iH/WbuR59AwldMk2ZPqL6kxn6iG900mFggPZ2xKLCHJwQN
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB349;6:AG3Odc7tScK5LOpR45G9HCBAr2gF394u80XQ3yohk96gKgNHHljrEqCa78gUSI5e3l+4RWvTRv5KqmpfD7KgIhySHIdxeF2JEqSzhcWSLzdfc9tGC5/9lbxJ2HkGRy5wy4HKC32oBv8cW6JgV8B+KMvHzSOOJLRnz3GjA/qKd79Q/E+dtOYMED3xS0VOofv5P30CqKl8nQP5jmwSt4LWyuILBvPuFH4X6KWsbTW/lRf3HaDP6MmogR/30RUmb+SqqTdDVYZzaPtMbwZfSswJBSm1dRWNVm567j4vZ116T0s3Bgk0wl6gjQRnXiIuIBGdcdW14IrTWQT3DOVM6SWPrEkxfoBW2Z2RB0rn3uTWbks=;5:TlYzvLt6z3rIvDXx7Mvp41Yk0J/Y1pRfDFSdYNYHT3iApOdLReDJduLkKyopzTMw0sGhAYR4GoCVeOx9d4o9EwsgYtZakpDs9EJ4mYb6IlDoQCzc8X6yvB2+ECtZuLgUT785o/zY2f9lVHExBl+wmTWjeNB8ikw6oC9F6lSAYFQ=;24:4N1qa8oa9O6SGmpNPwZE9d1laAiKv7zQctwFS1qFYKCZEQVy1w+fjpY0Yg6zdYy/8SdeuFol35KPHoF7TYKUkpmy0pNXmaDNp33WIGJ1jOk=;7:5cLyxEuB2fAMAdlTuVwmWnewG3c1Mod+n9eLPPsnxOmkXKeOxk6hSE1Yx5ocAXold7GXaQuZ9wQ9Gl11wmcmFpekodS0Fj6VnJruGB12wq8R8FJcYGcfgUb4z2ic84ck0o0kfNnbux/kNZ1+19U2b7MxYCFDtAOQPYBAObTyVsqWLV3OXeAoFD9enq1Pxj9EWV6EifPvs18LUhVACREqor5jhOpU9p85ZojFjP7ntMkgNMwGTldw0yfDHoCGKxjD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 06:55:43.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fb8425-70a0-4622-f466-08d58ef8c51d
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB349
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 89 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 ++++++++++++
 drivers/video/fbdev/simplefb.c | 69 ++++++--------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++-
 4 files changed, 190 insertions(+), 57 deletions(-)

-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeBWRwo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:52:44 -0500
Received: from mail-bl2nam02on0125.outbound.protection.outlook.com ([104.47.38.125]:26912
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751406AbeBWRwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:52:42 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=edgard.arvelaez-diaz@senecacollege.ca;
From: Alex Diaz <edgard.arvelaez-diaz@senecacollege.ca>
To: acme@kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alex Diaz <edgard.arvelaez-diaz@senecacollege.ca>
Subject: [PATCH] perf: Reduce memory usage of asnprinf_expr_inout_ints
Date: Fri, 23 Feb 2018 12:52:13 -0500
Message-Id: <20180223175213.25561-1-edgard.arvelaez-diaz@senecacollege.ca>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2607:fea8:23df:f94b:7adf:ba3f:12a7:2849]
X-ClientProxiedBy: YTOPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::45) To SN2PR07MB2512.namprd07.prod.outlook.com
 (2603:10b6:804:6::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90075c54-33ac-467c-5f26-08d57ae63bf0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN2PR07MB2512;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2512;3:cGMBTlXs3VSwZrenjvMmjRzdQCCuMC8sF20sjGKTLHri39a9Wv6MxZnnM5q8wyi93e382LFOh7Lwo5eU0HgLExmfwyvwpBKZ86GKbFQmF8PmQ5fDSeBPcrKN9iFDa+i/I+cZERKc4fNWrl74v+aA7s45IBNZg0HeqbawxFon1rVb69sIFUVabR6M6phnTPH2HL5Vj00tD09jafHuG7QybNWF+DcqgQGS3tEr1Jr2MMV2P6BHqKih/9Q+/IrYl87y;25:YI9krnDhb44CXh0alNkixyJRWGTGAmdL905XqrYNW12o8Y1WEMlZoWnC9EamnPfZtHvmn0n1LsDM7jq3AoIp2oHkJ5UOktFT4x2pnEnRtK0isDSsmJsCLgb8ZgxX/els77FAyhilDIrwokWn6aRF+xWGcdFJ3qtMJwSl2tBkJcpjNT0C8Sukk2OwjBdOWXTsoelvc8XDR+2WKGFqYVvGSY6dbiaulVzz1woCC10b2ubs3nHihTq79GU6RKJ7p8EspXlN9rRfd2W/VLBVDwV13qijWYlK0YkiUNJYXm1kpKR1brSGB59UEJ6QPs77UxVOTN34Dz5PhyRzlRABz1GpoQ==;31:pgvccIU4DXs7Stt9f7jn1Yj4TAbsoPhlasoDOh0V1Vp3mYt0GQzWgr0Y72u1NCBtg6yIQC3JWOgk4EGWMYN3F8bnzKHFTGv8cjEYW8TwNmZRr888mQSk9CnNbyzh65BhZWxSaq6aPiSRGO6hDWgfk3GQOazEleEYgA7TrF1/sn8CldJTRNSVVpIS+oIy0lMfzgF6vyrxYCHu+4evx61Fyglvx3yXvjYTcDa8/GTrd/k=
X-MS-TrafficTypeDiagnostic: SN2PR07MB2512:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2512;20:l+2/sstkyYLvupIHbJZTMXF5lhdCfD3QIfZms6UAYZfMR+2eB1D6IID4sml8oAK9lXV8caPB2VT9wWTW8xqHKnjut18tZm67PZf5KPlaEY3cswY6nMq5Ycm1t2GeXJsuMAJ7h7Hk8BsEVHdpjbeefBULWy3aUn1n6tazUBN47MEwZnD1h82JrrKOm9seEJtouPhlpjE/AlIesqv4sLzmlfrlLnR18shpp0K957uuhpL3s3KtqUOxhDNwY4HWwaWxIIxAIQTnzpRmNQRNt5Jf+T/1/Z4RcRcfcEo7hMdZfFl9R+S6TbIX1A7xnSnO+yZTbDSgD3DvkAZahtUfhWy6jSMxHpe2MTJKHrb/NbYNIAoveC18ySmls7FODbpD1328fR5kU37BMF4cXy/3S7YXSwem3ReyrSrUrTIeQWs7XaAd9hlwtQW527tFUZoindTGNvouh0H7CkQ4uP9eJFhH8wHD4MVAswISpSSPHzm4tPhZQIKL3K+VZ8TghTW9AWpC;4:KJDgsuDf/A4l45vjDakYjhEnpTL1V+HDM+KS300X16EF3DccPDg+8cMqwAqwotjbyc5F4YblvfeXjP6zm8a+qsj68BVx8LLTOD7YAroUQxbHb3G+/dDOnIB6pyXmv6rI07iEdBMFzI1wHqCGKRxLDedVjzA8JoYYG5hGyKF69kUhbkCFwJ5gWiD6tzSEI3H74Mgm6Ey9oFEcBOp4IQvz90zjqW3XoVA4upJ/iqufEhQCtiiQUR8FnrJLHSy7YTv4HoJDRBX7zXa7A+NI4Q5ZObElo46x0aopyUCZNBjdGbciCPojeWAUjOK8FA5aGqHLRR8Yy4npv6PBTGqFobUcMQ==
X-Microsoft-Antispam-PRVS: <SN2PR07MB251297365305699D8A923503B4CC0@SN2PR07MB2512.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(95811205626656)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6041288)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR07MB2512;BCL:0;PCL:0;RULEID:;SRVR:SN2PR07MB2512;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(396003)(346002)(39380400002)(199004)(189003)(107886003)(2906002)(36756003)(575784001)(86362001)(1857600001)(16526019)(1076002)(50466002)(97736004)(105586002)(186003)(6116002)(106356001)(386003)(6506007)(48376002)(81156014)(81166006)(52396003)(8936002)(7736002)(52116002)(8676002)(4326008)(51416003)(74482002)(305945005)(25786009)(2351001)(478600001)(6486002)(68736007)(786003)(47776003)(2361001)(50226002)(6666003)(16586007)(6916009)(316002)(5660300001)(53936002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR07MB2512;H:ealejandro-ryzen.phub.net.cable.rogers.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR07MB2512;23:7bAtK4/wxNUHwiAbtI37JZZdEOULlFSFPs9SMVEwd?=
 =?us-ascii?Q?DLMxl0whT0k6PK2Nlc/73B2wBYjMxDTa+PRzqF+5cm61eFgOEZXwgwubKu2Q?=
 =?us-ascii?Q?GpOGvppmhtsWyq1xkJzOhNcj0sl/hHP+DKWLaM2Fc++2sdOZI0kFsdz7CVsn?=
 =?us-ascii?Q?La92RVI1rghIlFm7C5ccfu9EuxafXgoqhugU+pHIz3MknGyX5R+jsvq63wGR?=
 =?us-ascii?Q?FC+Zn7vNYV3XE6iBcurLW6VJ9CI8DLCdZbqrAFTYpn+GaWZbiGJvN+rBa6Qp?=
 =?us-ascii?Q?GzcsXbpH2Pl0PkOzoEhfwNjHUSrDFvKm+ZI20fnpDVMTSsyTuyKmr7CNkHTG?=
 =?us-ascii?Q?at5xnn5KsrjP5SpWdomrlMeIBZ5lPg3DJUWCu5IfNJDFk1aQXfnKP7Y1+nHu?=
 =?us-ascii?Q?xIbONcEohDMOOpAPHehfreg8X6/y9Qp6UpRNPM8svnfSv/gUowrKDEVTeGdb?=
 =?us-ascii?Q?3Cgx0oytDat+ncDm4FEHeBIqSkrLNsiE9QavM4mvDaIZbzeoU5fBe0PeMITw?=
 =?us-ascii?Q?Pn7q9pbZh2jZ4PctPsF7LAm3CpAHktdg+C6Mn6TsJ4d0KYg+u5VLQsIRK3YL?=
 =?us-ascii?Q?4niSFYlDjDgrQB7h8bpo7J8ASwALV4LMkzbW02hbMR01xLU1KRhKivHKfVok?=
 =?us-ascii?Q?Xd/KoDF7Nco4taI/baDMkNtfcTclI91sbsR4aBQNQNaksIIiYa26qjxOdCZk?=
 =?us-ascii?Q?h+gtt2TXmScQyJKhi+59V8wP7emNPvCr3spSW+HRkNtXu3/QsmQwTgTGJ5b9?=
 =?us-ascii?Q?Nr3G4pzFuTQHyZxq4E1fz7C0M9eq8CyC/nWcbk+/Ju9Vs/T2XVmzaAMxswCj?=
 =?us-ascii?Q?aIX4bt4IvdCGpAatGHagGZGPZzfUxjRA0OmAubywkfdA6dtmD4MOrgujPYT0?=
 =?us-ascii?Q?JsTieSuwC0ryMCl6q2jFQgJEeLElpSjncJNaWuhk4hbFrkCLF6ce/qllNmr3?=
 =?us-ascii?Q?NSlpiS8oXkccyNQeKpXBlYb7NizTE5Av+nYogL1RahsXFIAHsUbH6KCKEn0u?=
 =?us-ascii?Q?F1RhltcYqxHeU9uIE/bTJ3YIpyPJ8vBnUYPhHMfdUZGVtek7PQfDx28pg+bk?=
 =?us-ascii?Q?ZKgTKn4785A3q5KFF3+UxOhgVHRS0mUIrivBSiJK7NH6VuIm285v4ptaI7gn?=
 =?us-ascii?Q?p+sqbqXM82fN02pOm3eQc4Y2wfm6wf/C+Govi0npg6H4m4+VNlGvl6I6hpsZ?=
 =?us-ascii?Q?GHW7gceXJSnfqQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR07MB2512;6:W/tNWRG3OBjrcauvZNv5Z6nvxfMdug3s6W09HYu6GTcDv5EIkC3XSOeMHZUDbdWdphgJvIjzEZeGe7heClPltxyClOqkvpWLd4Uj96xPF1Bft7B97zqHCNqPJbkCz28roqu+bnsNiooxfyv+RF4JsFwgPKuwCvr3uToK9Img+IOx4ajyGpt4CO8DJrdwXo71YESWDnk8kIxzk1iTdBVGVMozUl8LjVG98tVJTya8AcgzXWPKtrg4RnGoILaamFjZmvtc2tGQI38HbpLlIjgtwz2Ql5VeVp8NRi+SA2pUq5Upy44+kIazuehxgaUlJHczMhEHdLvc/Wsob6iDlzQfIAkLR40t4VE+mnnKr2nKuuo=;5:Fi5NT/VbARS3aAdY1bkj84yI5rSWmLueIku4ht9NIZKkldd/S9DmdP14FLH1HElrfTMyrF1sFHRenqEtHdBcOJAU1cN3HNu7p36OHyDoW7UavYNqCeYjGdjJ46OHVOt1p4gbVLBpL7x1Jz/yz6i8O+m/vLAZwM5wi8cDe6AzpdE=;24:AEDScM287V/mjC2+dRc2DA9MXCigoWYh7FIRnh3xEX98VrLxhqoZ5eGvt1gARWUI4/TZjIYEMmFh6R59D8A4iekG7dT7Cbjjxp/obf/lElU=;7:Vw70BLjpfBAE60r5Tg2YJkJtGGoG6MWNrcrYbcuR5taxZchggEHxQHpZ14FO3DqYbQMU1PV5ShqWcgHd8z3VzbzFVZ/5048XE6MqtjU6BobFMRnkoUdcFXXcvucMntS2Z2XrVfLZ4jPNgTDMOgFe+qEDqLKGZpg35JdRVtGViQcuJgy9nY4rxjZL+D2WG+Kv3TjBwfNE4yGiyKYcpoGNC1s9I3lG3Dgdl6G3XS5MyaMaaGxuIRv1AlMUtGwViSoS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Senecacollege.ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 17:52:40.6187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90075c54-33ac-467c-5f26-08d57ae63bf0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb34f74a-58e7-4a8b-9e59-433e4c412757
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR07MB2512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally a formula was hardcoded to allocate 28 bytes
per integer passed to asprintf_expr_inout_ints. This commit
replaces said formula and only allocates as many bytes as
needed.

This commit saves memory in cases where numbers passed
are small in magnitude.

Signed-off-by: Alex Diaz <edgard.arvelaez-diaz@senecacollege.ca>
---
 tools/perf/util/string.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index d8bfd0c4d2cb..b04146099205 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <stdlib.h>
+#include <math.h>
 
 #include "sane_ctype.h"
 
@@ -360,15 +361,18 @@ char *rtrim(char *s)
 
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
-	/*
-	 * FIXME: replace this with an expression using log10() when we
-	 * find a suitable implementation, maybe the one in the dvb drivers...
-	 *
-	 * "%s == %d || " = log10(MAXINT) * 2 + 8 chars for the operators
-	 */
-	size_t size = nints * 28 + 1; /* \0 */
+	int max_int = 1;
+	int no_digits;
+	size_t size;
 	size_t i, printed = 0;
-	char *expr = malloc(size);
+	char *expr = NULL;
+
+	for (i = 0; i < nints; ++i)
+		max_int = max(ints[i], max_int);
+
+	no_digits = log10(max_int) + 1;
+	size = (no_digits + strlen(var) + 8) * nints;
+	expr = malloc(size);
 
 	if (expr) {
 		const char *or_and = "||", *eq_neq = "==";
-- 
2.16.1

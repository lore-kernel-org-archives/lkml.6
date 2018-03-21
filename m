Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeCUX6b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 19:58:31 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:17408
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753485AbeCUX63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 19:58:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com;
From: Petr Machata <petrm@mellanox.com>
To: linux-kernel@vger.kernel.org
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Petr Machata <petrm@mellanox.com>
Subject: [PATCH] perf: python: Reference Py_None before
 returning it
Message-Id: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
Date: Thu, 22 Mar 2018 00:57:32 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [89.176.83.59]
X-ClientProxiedBy: LO2P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::20) To VI1PR0502MB3024.eurprd05.prod.outlook.com
 (2603:10a6:800:b3::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d3b792b-3515-48f9-3d07-08d58f87a30a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3024;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3024;3:EK06PGYLGeiWfmjhKFHzsfFLhqxdy8JtX0Zmtfolt7CVL9BAznmS82YjFh7TeNX7vc7EHggPhv+357lDMaYSQwhkltLk9ZSgRMiZctk+d6n+GSNlbi/O2LtSsJLiw7MtgvTeBBrZDESHt8cROsX0uAntpOvmzGbr2V4Uby4rPDQmpYGJXr3wY+nPWpJ1cy51ClzZZAGdRvCNrdKJQbcaUVrRsUeJDDPXI2OHUFxvnr9pHKi8TuzBMPOvahVR6z2S;25:SkrXtc9UxqTghuxvJVjRdrxZ7n3ho1Wl35axHlzpRF9iEWGOTOUXMAs4Wv0PrnHs1VQ4BUGt21eM+p4T+LGYliuGdD7czqrNFfwa/c4igpkpn5b6fxW5kA8LiU+91Jhe6nAw4Y4BwyLszsc81ut0CKy7yPsrHMSWSZWiRu4LkMG/6ei88y/r0YXnIqtJg5ZfS78pqCC0qUCSdHSNtTOIwtfSZqG1hkQCsiahePg+r51WrVBWUZuLbkR+y0Wz9IUA/7n/KCZhy8KXgkr1Adw5g8Lc28/PYyXqHSjObHDdnua3FqBbp+r50ojENvJquDHuqJmma/NVH04Q2g7gIqQrOw==;31:uS/yKGoIIM+1USK+4CfGGOY5vYFgIVQtuDx/5iPSNve4tNUS+xKfZsYf4gUb1zJg8rnXIIQi5+KlmrfRTnopzGfEpMsl2Gopo/LF+0+6nx/jKfCW5CiDNvfiUv8CfI9CPBUYolQtwwMwfzlurD2WNhPqzzawRRscPwsiZQ4tQi+JT3GdeU7HnwUgLha1gtmGXuMMxzAg0pyr0/eQww37QuKLVnhUA9rOYxs30RwRalc=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3024:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3024;20:moUOqkWQKKxEB6B6Kgwv5RbWlpXO+fNxohY6wQbGei07IQaFCgSl6xSBRXB6jJdN/ascPcRia1RJ2GNwIYYgcWnT2JipVWo6KSGH2m6rw2jSHo/JLfFegj4sj0kkJJBs2y1jjfz7vIy4jy6n3TDxDRaGd7lIcncJHugFcMmgLFcjT6d5ZfALAViamWhREmvl3GKoEpTq6HmzzXk/t3vTgRDQFNbsR5ZlBeNvDr894fuUlJFCHq02sJ2ZqoGJp1+vtRGssJMFhPQFtTHcM/1nDYzbBkpik3D7F2OmdpsSiQ7vFCWuVx7vaoGwnZ+z20clKgKGjSKnfjhtvbPa7SmGRwLZZZkbBdfgX3FtFssl29+J82KpdeRCijGVU0zRgk7BJcHk4maS/1+vstSpoRaPUv+i5o5ZnhLFH28RuCni7P4MgV7vAIqETLzPfwOcwRxwC6nHRKIiXtxX0qVahjzWEd9ix8nAn0u1a3W1Q3+TtvOY4cTppYQ745Y0RP0ticMv;4:SFIH/YFETP78YBBf8My+vnvoEJvRneZ9Rb2MlxQtBvSdAb6flIrjp+zflHD1HjEn7R/PvXiGSM7an8EeUZA5PBIlG1e5R33knDyQIZN+Yz9ZhPCbghZEtGl7daEtjgxDEOaCnEbwsgaQjAbf3Nc14YHbE9+NRF2NwhXmipPXeyArvL1SHAGksietkHIeNIGa7Y985/vakA33slbcE5y68+mR1Qrqrae3YZ077JydevaTdgOKHhXCGzUXLvjAJm8UeEAH5ll9zmF1+l7JS1YVFQ==
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3024B32247885FBC6F1260C2DBAA0@VI1PR0502MB3024.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0502MB3024;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3024;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(105586002)(5660300001)(16526019)(1857600001)(58126008)(54906003)(6486002)(6116002)(3846002)(8936002)(4326008)(86362001)(81156014)(53936002)(8676002)(25786009)(81166006)(305945005)(7736002)(2906002)(66066001)(47776003)(48376002)(50466002)(2361001)(36756003)(106356001)(2351001)(68736007)(59450400001)(51416003)(6496006)(52116002)(478600001)(6916009)(26005)(6666003)(316002)(97736004)(16586007)(386003)(107886003)(118296001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3024;H:t540p;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0502MB3024;23:Wr10T19aayiGNzBCG5w2Nc/Xtuwuvrv1i0+2XM3?=
 =?us-ascii?Q?/9zgPvsGlXUZFGff9392mntf8HBhPs/VSgdNTX4cUnsq5j+/sjGVzxkqfyDX?=
 =?us-ascii?Q?ZM/JMKfamSaX/JgUwjQw5cWoJnJO23pw94Q0xCDf92Fq4b0/kwbju+0f/OBc?=
 =?us-ascii?Q?D3sKVK629Jzb9vxQx81FhlpV2GexCjOoJ/KmqNnZ/Ah23iJ0AbdvCnZkxtEI?=
 =?us-ascii?Q?1+Exv61GH/WWP8cFHzDmmEGz/P68Ks9jlc3D27/7R6RisPnrQmbTTuY1+qjx?=
 =?us-ascii?Q?firc3di39DRHkCqqRNqofgZD8UyYHSFUP87riGgqCQUh2D1OTvD4XRVyILIu?=
 =?us-ascii?Q?DiTxnIEsVE9OcvWod0yjLTY19lhv9nmRTG+LgSo++lf6g6J86IVAny6h9XBW?=
 =?us-ascii?Q?407wRG3tiLxgjQ0kw5WV2ho+TiDsMpI/meyYzyhY21rWJrIIuymtNPFWxYVY?=
 =?us-ascii?Q?M4a7832wb+A3TrlqP6HpRXrGARC53rRp6mz0vGIjzhVUOr/t9Au80xm+c1ZX?=
 =?us-ascii?Q?wfb4polLiKBcnmM5PpsHqwcpiCr367uxsRgVx0BjMGFuDTriXOEztwJZ3quf?=
 =?us-ascii?Q?O7D78chcv6F4JDSe6DD9jt2beWj2orcAo6T+I/gDfv5FsxFKZBm4E9/sTVwI?=
 =?us-ascii?Q?MO7eJ8iDGl8iloVFBnYDDHkr385HhVf+ERt99VWpNZJz9hVE5nKGWVci6YWh?=
 =?us-ascii?Q?4iMYrmX25DcNoWW7qI6cjhdfUi9rCKjuhUDefRRG5yCmdWE/DXc/UVgVQNEO?=
 =?us-ascii?Q?O3Ln7TbLKdOHWShjVkGkm3ovTQR5ukoSqLgc1V4Ho1Pb2CgCNQCoWJpbMvi2?=
 =?us-ascii?Q?9xc3+en8+JXigNOT2U3R0tPcup2w7ooRypxxgKtXm7TPAFeqWXbf2rUh/bLa?=
 =?us-ascii?Q?jsu8eiabr4ZNNx9u856afFBMsOLDX4BdzSgPxe73tYul7z1MbJO0S1cYDvYZ?=
 =?us-ascii?Q?TC5sD+4wBgb7RuSFB14GxE7W85IpWYQ/529YqbiocTvlHubhX+w48+ZeDg9G?=
 =?us-ascii?Q?MdNFKkFI8P3KlsiT1cuwzQmeiB2INnJ108n0cxqbRh+6dbvz/NcxeFZ6SfmO?=
 =?us-ascii?Q?FlvKIw4z9pljJTpX15lsPXls98JJkUEjJEfwsZxVt6vRpmBaWjvmkxjb7By9?=
 =?us-ascii?Q?rJC+fvM9Amip85MWLhDJOE4efZaOPYZ1n2E2HvEGkvKwlvxh7PknlJA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: e6/bv6wDlDNZSiLq/NGe1X0NWY8cCybf7BZDWmdjwyn9qjs41IqOftM5r13jLoB1C7M9TdqvAdv1wGFwz/yOIhpKO5prnGhjCEH0OD0uQiG1xTCFkhmbinFtUKsBpDPA/Y4ENIHc+vBIqBYzbDEVsf85C7c/4ERvdyp320pLtMVJRCKPS90KaB0S5oJ8ZYba
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3024;6:xpoYAmTYsi1nwizws/dYIaPjTcr8qNWVjhD8XqRWF7kkwrmw84wlGdE2KF3hh9eVl2EZXq3cfzIl6FTiHGjCAI9Wh/P0+GksIIFR0xDdDHwCih/DFrHc7txRSEnNQ7zZYCpGG0cxtphRcGtNuq3J3/0NHrVTBMcW5IOKRQVZjmuyx3hj4arl4IGJKHc9hQ2Q5WL4Wpc1+tsJxVM+yGwcWw64o4sjypqOc4olBfE5EQjA4NbcFqu4qpKTz7RI5VfIobiv6LeQS1mwGYITLdMCp+XuqkTR3mt9grIHFqScuB1v3cl/PGPL61F2498Edrjt/LakcqyS163HJkN1Onu30/PP1x4iepFb9um6Wkr0/VU=;5:vl/OKjg19UBHy0VcjpZUNj2DmvW+TlnuXYUK+TE4aiueum5147Bj+vSGLT4DGDYixi1r18Jd3pWVCrbYFt+FTXZqwE7KC24tHNC0C9iEluGmLf7Wl4q1kshe9N8US3mQ35RahAX3KFrElUbRw59Et0CopPDT06bawm4ACWVaMgI=;24:8UHwfHIlk30pd/dubF/xASX6DDJ/l459KIO+uxfQfN/GwO4mPS8koYzu8Bv2XboakdhJ9HxMxPdZao3r7rp+tfYrgfk0j/y3mSufhBVmoGs=;7:Ga4WH9/JzPR9YT/4FEgsbA19vu9q35Ry+3OXsOtZCsYvBd0aAPteDnaKp1LcupVNJLjD4r9FgHsnB8lyJVT7SakngtEpmf5dxhqtS5z28Ko6yyDhMdVodndTk8IoxuerNfTPHrLKxltptUJAPs96ZC4n5LfMBobNZactKdJkIysesq+X7AKAb4Vbehdff/+UZFoKo2Ejj18Q8YuaMkQXdSeAmY/lqxBCKgVBmubYVCHRDe2HRcfBSwDndMybpGu/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 23:58:25.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3b792b-3515-48f9-3d07-08d58f87a30a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Python None objects are handled just like all the other objects with
respect to their reference counting. Before returning Py_None, its
reference count thus needs to be bumped.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 tools/perf/util/python.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index b1e999b..762d429 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -967,8 +967,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 			return PyErr_NoMemory();
 
 		evsel = perf_evlist__event2evsel(evlist, event);
-		if (!evsel)
+		if (!evsel) {
+			Py_INCREF(Py_None);
 			return Py_None;
+		}
 
 		pevent->evsel = evsel;
 
-- 
2.4.3

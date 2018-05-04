Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeEDN6n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:58:43 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com ([40.107.2.121]:36370
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751582AbeEDNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 12/26] drm/bridge: sii902x: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:58 +0200
Message-Id: <20180504135212.26977-13-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135212.26977-1-peda@axentia.se>
References: <20180504135212.26977-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0202CA0039.eurprd02.prod.outlook.com
 (2603:10a6:4:a5::25) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:rCAZI7npqGRGpErq+MmS+dmCZ4rLCufD6j2K3spXZBQdCIwMPEuKxPs9FYpq3w/5VNhVUp1UVjGDVq78vTdkvH08rEIDIyjUAvkbXKrPV43TmUl57hIhZSRQQpccYWO/mKegYqmFvzOnu34hBk7xfgzoFIBkOWBy1NaUswStrbxTvJV5+3qQM3oiDULuvyg8blEef6mcblyAcrIEFXUBX6NNaOG/jbsd8Xfh4Z4PpIzktEsjpuGwakksciTYgC1k;25:z0/n9UYQokaWqHpF1EZN9nkaYYKrHmhXcfVH3wCRaoaI7gwjC1rnNfOWTiPZzoqHmIPsF9RTRmoKGprI7xdMhSoOqPnGCAcCBW4rUr7vhysAnyEFFJvpsz4N+c1sL36mhkR5qMQF/odGc3yZzVjO+UCN/sSM9QXpMVWcniOTo0maFs6oZUDxx92I886nR23lUG+rdr4BYT0QtiRqjKovBdYEm964jSYAwgHiJrPMwB67woc0L9mtKJKfmsCtb5x8iYoZzpppps5k4JrHTU5IQUTaTNrpGrIPT/tS3jXZXRpibFW8tHkeAWUXXe1NihNZK/DHJbbsKj1uAdXXZCBlIw==;31:QjmkhsNHY6SsjnbibQKrTLB9QDytjwFEbpXwfhIfd2Zscrt/VzJpohEIapeOgXZx8B8tFDLcb5dR9gRIzlfsQ1GDwScpk12gZ3qoa6sSB/+QNgAwjTt4MXgpTFzh/LPZC4FKrfMYXYgHtH2fQ2vdL6xYvkjzej9QWXRH8NWO39oTh+3h7T7IRTOW77YKH7k7mXybbDoL33Ps3RGqA7oEqYS3yPW/cvqR9FlnY3oi4gQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769CD685134A90DEA1B02B8BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:Dy/rlz6PyCTrTUHX59DSN/9IvMKoAGr8UHxpOY97w2C9ycgXW6qQ39bPbsuqDVNVcsqKVMGDBYX949CCf3x4mWOBp/SHMPgTQb/ca/co4bVQW+XvP7LdoBf9dHNGRaYfRvfgwZF9ypKN+8HjeawJd7xOkQVzAL+fuWnjEQRy+9ryBFuoDdcSmLqYy2si6R+QxpkLwRV1VaaAzM82kUEONlhDyXNX9y29MbBwYgT3d3JG+J86ew/3d6FurGOqhQ9adCTltf1zXxiwkcXNhZWiIQ==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:m6ZD6J65scROtEWd3esz0Pv2IjeLWrhaX33+Yna?=
 =?us-ascii?Q?nBQ80EMucvjJcKbQRAQF0hpbSlYaFssLDzgvBmnZCYs/aH+qNslc6riX92G4?=
 =?us-ascii?Q?0EgjVkSLclKU5raCTQ81JZvPp1YUqIm4qbHFhy1wFm82eNtq9y/LEFkt6FTm?=
 =?us-ascii?Q?CSPAcqxjPtQue3GSuzk1dyCZo2lOKqSCiTI/8wJ8LvTnBUclCqSPYqDMxjuy?=
 =?us-ascii?Q?22Z0atmFauDHgdvVkBwy68CuiSmPiMLmD/AKgXwz6aWhoMXuhvUs4H0Lo9cB?=
 =?us-ascii?Q?blbhVyW1J75RjKlG4aMI6e+0ba5pUzCsfjoB3lGNjdT/dwuR2PtoSs0PN0cj?=
 =?us-ascii?Q?HhfuQqWjCUBXp1rLwaJXtpeuyhpeQoyKmU5zQCEdU/fuoeR5df1JOVHQS/Jk?=
 =?us-ascii?Q?gEoeOIV9/NMtt238tlOOXwftiGFWCJemJ/82ZGU23NsA9ddCWGVLm7Mx3NHy?=
 =?us-ascii?Q?QxTYY9ANgCJRFhQgFYYeWYNtyGL74qNJJW0FsC2BrWOQnaCwuKXRejkhcL1d?=
 =?us-ascii?Q?aQTIkkvqSyaYVE9faFygIQKao91X/504BF+nIjglaqL0faZjku+qkd2E7Ve0?=
 =?us-ascii?Q?GxSq9E7D5BV/ELyEoTfrkUC8v2d9Z8gc66F5arpf1Z1xlgNr4FR4UhLAr1FF?=
 =?us-ascii?Q?sYfWahUYJQ4hvb6Lfh/bWbfdHLVDaUOd+a3d/8p3xe+ptb0rw+vErWUXdB5W?=
 =?us-ascii?Q?KtJm2SYINKje0gJf1P7UJfcccvj1279a/d0YgzAgPLmQXYwwF7nkJwBEV/Ny?=
 =?us-ascii?Q?Jqd5Fry37agJHVLVrFqcxypOwmA4f7M/n2coqlJKuxez/YQWyYZMnJvB5T2/?=
 =?us-ascii?Q?v4xoMvubpiL+F7UkTJ4WRr4bZyGcR+ELlRUM4gckCK5oaT+M+oDwB5Jg8/kG?=
 =?us-ascii?Q?eV4btTOlz4iuLuIw432Styj01jryFxDLdo20BYtTJ9wMZFRrMJN/VxwANDTg?=
 =?us-ascii?Q?g2mk73aZK0x6qo+B9dm4yi7Mj62apcZFnNQLf8pbheLHXJHL+s9taPr5US4T?=
 =?us-ascii?Q?2O7IAUevBO01IjaiBUYSMpgiwBV3RmUahsi5T9nPI70wyuZQ1JcWpVIfaZuC?=
 =?us-ascii?Q?edk52JvTQha0HTUlB24bZRMtGLYtHJVaT3Prboae4rJRzLtoJ8GhCB4jkT9h?=
 =?us-ascii?Q?M0gP6LYewDLRs0qNYuFQ+9Nvxa+qHaG02g9ra6YWLl8Wf9JYZhFlGvKXm7Gk?=
 =?us-ascii?Q?NyclfnkR3s9NgScXQX2oWvYYnSiZD12weGAWFbKjPNj9T2nPKgxn56tB9YJI?=
 =?us-ascii?Q?ANLfMpwkKCnEAVuIEhIzU/BUwm4DIuBgzMFnzADWUxNK3qzBKI/Zi/RNuPor?=
 =?us-ascii?Q?/1D3XaoidyH7unLim7nHO7Odd558GxC43slcRwSfCFYEzEQS/dBUi4H0CdsH?=
 =?us-ascii?Q?vn7pgeA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 7SqAeoTTMXpMQxdUr74RRgf8vorwZIbI9zUh6/Ax1xlqAyiGetevfGHJEIIrgMqzQSe1YnaFxy01oOc3oHRsJQiCyjdMnxUH5UU74il66uE88Ypt5RHyXaL9V28K/GupudaAty8qHPPUSBlmfbcRO6jMsAITPFJ5v5mHRbCDGpM8WUImUBJI3H9MIm8zHoNL
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:dDPabCXyNIuullGIqVa6YKMi85kgDEuXdWbZPEnvf3hCuJrzlsjaTv8O2j8dSEQMaSCgLxhP+lD5tO2BkntMQGxeprbTSuRxy0XcN5Yb4t5uCe883bDDVCfpn8Jm9U6RKt+scdvsklzx34S422v7zT+QVFSIKfehLdjVTa3aMh6U/J1OHWD0658tQP6oO4uhnBzqJHivh3Iyyrp8BOeckK2rtJ2HfXdGMjGcsljZU/Pto1hYeU1dun9y5mQd7Oz0G69S8KFN+xaGYGvYu6f1lYXdtJbJ/RsiR/dC/fpBG9RAfcbYpgVvAiaodfdpde8PYPiCvKBKnq85Kx8Wpy4aRSxe+3tdmwiIIyrBeLlqQO4BkBSNowUiNpgv21Odr1m6HqUa73liRHI1+sSXOWS7zy0q1VVW0te4AhwdUBD5dsZZ4CZ2NMVa1achxrytJCoKLAHFQ/W//sPy3ZNTvWtZjA==;5:4KDgOGzbYWw/oID/vlh5n+zD9nbyg2zyVHbDkaV1HJFDvVV8uzcnMcDH0XCr0zatmcVaU0nfPah64+hlAcWVOAYJ0EsJN2Gc9yxni0As0yZRXvG9Gk9ANchkJqATAQ3OGh2j9nQFEeQg7YraLoTLrpsVupdWtp6+ld1hm4a6Pm8=;24:gZg060dMJuzX5L7PS9TJLxz8PsG4/qspQDqR8DLTD4cS4IDRl5S6cNHCyj6tzeg+zV6hu2CDOgvK5RpqVah7D7psVYFIEUGbg7sYPrGeki8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:b3jeeGB3oF9zmmjYOYngnDiiH80Nx3tUnHda+L+bX4nRt6wQOmYWCq8zRG+nY/ykQcCvr95n+L+ScZ0Rg5Mf0m/sU4hwDsQVwcuEkvdgEckzVHCjgFrn3X4ogd40V6pDW1tjuH32vpqr/sasO0KhX4B6qUZBIfvVtH0i0tI7iSdSPQTZwu2S42Q2VYc9kj6gQ8IZKFUPt2OwY0fojDTrZ9cc0+0/u7hb1bx0qmZt3kMFCMpuVOQExl6TglzyzwRL
X-MS-Office365-Filtering-Correlation-Id: 44918fad-caf6-45bc-ad4b-08d5b1c65f9b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:10.1906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44918fad-caf6-45bc-ad4b-08d5b1c65f9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 60373d7eb220..894525b05985 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -427,8 +427,8 @@ static int sii902x_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	sii902x->bridge.odev = dev;
 	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
 	drm_bridge_add(&sii902x->bridge);
 
 	i2c_set_clientdata(client, sii902x);
-- 
2.11.0

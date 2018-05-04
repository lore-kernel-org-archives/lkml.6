Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeEDNxR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:17 -0400
Received: from mail-eopbgr20093.outbound.protection.outlook.com ([40.107.2.93]:22400
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751568AbeEDNxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 11/26] drm/bridge: ps8622: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:57 +0200
Message-Id: <20180504135212.26977-12-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:d5uLu91gTrPIcz+VARuMxH8IL3rz9P+kycit6BD70jgUSM7mc6X46tnGIe+CkLpL0ekhc9LDmKzLXBBHNaXDgPT0E5hDwiak7WralroselEm2fYwHYZnQ4eLmoOyhBdu7u4w9Rr/NNauFRs7XRcJLtJ/sk7CWzfEZdvn3FwxnBhbILRl8YJkjgXQWB95zdKOa319Zsc9L8e3icHDwvV+LT6+WlJ/flt0MV9lfdPo7GwQVeUWgVY3ACFPGYqCP6K9;25:lIgSGVoiejmksjnQDa3M1hwElTbMdlUNyWBCS0anLsmSbA2uMtsMJKUvQBfYjwJCakeJxiW00eZZJtYgr8nsxFyf/4ltv28PBrRKPkAP/cOb3MFYerjOlx40kh0D+l/gy9C1XDG5P51KYZIH7v2bFP5LJ2iswP9Rz3nK8nHCo5xQ1sB5BFxROrnZjrfQXw6NwT56fpy0gMLh6PqfvKZfMf2SolXE77b+IRb1k/ACEuyAZKP1iqFTrKdRODY1yNzoC4LwfncVb78uc2TLvCjW+1tkrQuynPXj0mQilJ9AaVQ8TVp97Hh+QXh7GGxwNt6cqv5+ZvoIaNmzpbY9NhEXDQ==;31:7vcKZJTVpBBiYKso0gcLLRw8b9NHAU4tORYA8mTUC4l0qXvMyw9LlfUiBNld6q7uGPHmgcJMfliG/rl5pXhyXi7pwIhZvX4OmRkCrGnEZL62QCOOOSaLGROspTt6dVuguZsbDepH5jX6cHTYGjg9gMU2rWAwExkAFCcq8cR083cjnRohvDRYivKKDoQIw65qp9Ldhra/Kq9bqVNct+RpC87uEpI2nU/+WytjReytdJw=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769C9CF231AB83BB911D365BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:5LA2Bpa9h47ASeYB8ijF/V0SI+At9L+nWc+udRiIf7jVvYI8LYbWXAWhyt/K/f0LA9oFn2FjsVC1lW8dEioD4AoUIxJnTHTD/s+ImlDeaF1rHxl87jWKHJukKw+9TTL8/tkqIJm98zbCLDs35z65uXkWJYQbo4v5aDlX/5HoGu9wPLzaqi7ulAmrQZmbj34e+0dQshFTfkFXDAwtHthjqwbijZt5BmgEQaieIsgaRacTSUrEoY8y2sIKGUdgI4yUt817rNhk+dt8TOCrIqBowg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:sxCnRF/+iesL5UwcEhla+g6qaJfFfags+qV5Utc?=
 =?us-ascii?Q?Pt9ASPZloeV6+JzT82BeOoZl3SgZbQRnsB3q9+sUs1CIrMd7W+pecXZMGF6u?=
 =?us-ascii?Q?7kz9+av8BRfWYaNkgYxrIcDhKJ2EKJS/VlpF4IEWPXUJ67DBNbrsv+qVdKea?=
 =?us-ascii?Q?4GC7UeyhvPqZGemT7nYgDc7CDPeMKB6eANkp9GB2kDHwiuxqs3OLYv0ALwG1?=
 =?us-ascii?Q?0omor1K10KNdZdYfOEBWywGdXG5Y27msRyP14Uq8lhrvEzmiNHPF79jCnggo?=
 =?us-ascii?Q?C2uuzppGgJ2Wjz9UM1n561ZvTvgjiHJJKAoZIJNQXbpxawYuari8pE6i2mRt?=
 =?us-ascii?Q?V9caf+WYZC7iz8olukiAbwEauCZ8F0pY9FLBHusCoY7EjCYAIwz9Ikou6jJb?=
 =?us-ascii?Q?SbNwvFi9+va0H7oSnlQYB9PAb0MJEDl794S3RGGEBhYFjoY4JVqQl69V4G+e?=
 =?us-ascii?Q?pAUwJeKkGN5/S6h3jyoYzI0OKSzuvSWxhH1qBb5hEOA1UXv7nBCikCgL4+pP?=
 =?us-ascii?Q?7pLRb6G9UB5cFU562zMmUSA/2fIihWigfACh4uu9DnFSb0DhYOpbah7j8fwx?=
 =?us-ascii?Q?5bo3EPC61SUbI6ATr+Q2tdXkNK0krbfE6ZJSQatqVFBqbfCZ8UwFWlYN+/TB?=
 =?us-ascii?Q?KVy12nFAcu0H8ZiA+LDvI6BjHb3225kZ42/QRrVZBWFvGs16SrApLWPo+Z9g?=
 =?us-ascii?Q?E6F5A4S8jyThrIqhe1I6lQCoTYgEDh90sEDIKCwTRBdTDHwboWRfykVydLLz?=
 =?us-ascii?Q?CWuh5phBgmOMvguxodnAwU/1aCjhP2B8BAmGnOsQEO2oVlv9sxx4cuReoDmO?=
 =?us-ascii?Q?iepzB1OQDsVaLZHKYks5oyQj6JRIasDgYW5RplW2B0q9/ll3TB58rQAl7Bc5?=
 =?us-ascii?Q?/rF+mjg0cj4ImixJ2tPVYaegkuDJzI8oV0RPNK16yNERiN0fdZZN1/H8zFEf?=
 =?us-ascii?Q?Cv0Iu0EZLU4hsAil7YDx6pvnqzldQmysNxFuc2j8NtPij7eG1VON84AuSPsx?=
 =?us-ascii?Q?zgrOf5dbykHvLQujSKToCRGUBlNhWVcrHdqXCKxUtMwOvnC4LtrliHEH2YUr?=
 =?us-ascii?Q?b4AWJ5t2Ls7X0S6H/cRRyBXyyKKkYiU8ziczOf6qS2HQp9IWPh0amm6y3bYM?=
 =?us-ascii?Q?Nto3RbJ5DAEBMJjmfG6UL64k4ktYb87rmVYtA7SlU8fW2VmylntCdvdPkGk9?=
 =?us-ascii?Q?8oRPYmlEYocr59+IVSGiiUT0Ypzg8Fn3yhN4hGkPiuL62Ui9JcEPTs6RTMQQ?=
 =?us-ascii?Q?G7SVM3UZJYyhWz+Xy4hKywx8x/vayllOYUXKxgacm/F8xhUgdYYqvNFGyV9m?=
 =?us-ascii?Q?mGSY9Aqn7yd3G0CHxv01/eFqIUi0xbOofUb2/vNPuZujT+TcmITUIveVHkVl?=
 =?us-ascii?Q?UjGrv7g=3D=3D?=
X-Microsoft-Antispam-Message-Info: YhI+RqIMj33D1J+vSwdj1E5wA2r6gqaWgO13ifxgEokDvmjjxtUK8aaMPmtKb0SclwVgi7d5vdGcFuur1APtlQjzRRQPsKfLIM++NCO4KJPaDLwOcPcAE4p6ikNV0s+Yvtb/vUb0E/wLX0EDcZR+G2F3c/XXtyFXDqOW/r2k7VHfj35Al6lJXYeArILvtkVy
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:XqZuminiqoFm6f9TdU5KX7BF26MgvVI8HX26grLNwUXIv6V76i6xXVjqkLSnAUmiFt/mL6WVBK/ZuRGh1CpJGW6SBYfC+cXAFUlZr8BAT/yYE1Ck7xYP/E4ATqKFfM8e214iX0+j+7nXg4KLmkf/kUlBcsRXvDZ1hNNfTRxOLcARQZ7n70Drq6maTEeJFiLp2Qy8667iQGC7PMvPyU7tRf1R4Vy0ai6XKvJn5teHjkOnfMpNEet+inmgyGX5x6u4RwSiFYIgNeX+Yehcx+T4Nfn1RAIrnnolXJsZWGO5ps5/jrq2cMR5tiRntrDwkAqG0K8AyQ/Dy4vchNwFXjZSu5mPVeVuJztxDvuOCibfQp/pC8KaJRjxLR81jABLzxOwdGHQPM1qYGNDw/n/Hcl31eHq2qslAatauXmaPH7eMpGOH0M21OYqVDnCasU0ns9VvYcU6oVuc1MCTNu4vnFtwg==;5:y3/OXr1HmdZaillBopNuhBO2rgE+DptJ52Kusttjf1xD7SytWPxso6OlS+eRR/wpcesPEdVtukk7V2JHAtrJhwG4sqIe+2auS6UuSj2pDx+erRu1UZL5FbvcrngCHWeU5NY2/P+HD9Dk7chwQGopaxjbpSXGFKDSkOuLDczmdz4=;24:niA5MUuI8k7p0cWaicRbjrGOcgXj6tAq0Ds0KSs8/u9j8AxdFmObqBruuEfg4CdDe0JdQFmxB4dJm89yrH5ZTleaTdVcdl2TX8C7FBFTIts=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:eYEQy5F+AbRI7h60B5NGcUuBmrmXKBprBn+YHZwoEEGMKafYnupiu+ENz3wy2Qnoyt1f2kUSpCnOr+Q8GL0w2ngJRXFbJaP/IYkd18Rm5OoBY8pWkb28ugoiiPJhGeaNQZVBM983/znFaM7/gwiyFPuBVuTUSUEhW4QRdcR94SucfVMp9HEYbF8N5Q5/xWytQvDg15KAjLtKX7N+kQKsSKVGU9YRqti/CNvY5Nn9QhpxEqsLp7aRvGGzDAz9kzsD
X-MS-Office365-Filtering-Correlation-Id: c472c2cf-5fc7-4a9c-f337-08d5b1c65dcc
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:07.1171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c472c2cf-5fc7-4a9c-f337-08d5b1c65dcc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 81198f5e9afa..957420a1c924 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -595,8 +595,8 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
+	ps8622->bridge.odev = dev;
 	ps8622->bridge.funcs = &ps8622_bridge_funcs;
-	ps8622->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ps8622->bridge);
 
 	i2c_set_clientdata(client, ps8622);
-- 
2.11.0

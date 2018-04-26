Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757310AbeDZWhS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:37:18 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753964AbeDZWc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:27 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/24] drm/bridge: lvds-encoder: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:21 +0200
Message-Id: <20180426223139.16740-7-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:cLrp4gGVLVJqPFnP/YImoqynp0QomBHXArMtQCl8r7FyNxADY75g3lQYRVT7lWZuzS//niHT4L593GzDbyw1hAIuTuKycI7LnBYpAZpw8et1QyJlBUcRG2SWt5TWoJ5IsnHNMr4n7417oPINwl30bZuWEy98gwzMVyb3mr/xyam89dJ84UfRqv4Eb1Ok46x3GzJZeMpu7obnFwWP9gEuNqKn9d2lR5DNKP+2fLovIHGjQ7kQqDYeIoYpUHAB/3TD;25:is4KvdwhSodWOyIkteHlcBtSLs/teDyiguduQDvX2ZEwRSEh36xNYYzawKW92uMeu5x2m7AMEh442ehHUwvhPiegWYdKOGv4g0i1mw5pF6YRHhwwbp27hG2fBjE6F/OVnsw9JudJM+UZy+QD4HXftPdZxRXCcBXe3e7SWsEIhivHf8UnO8FmbMBsX/4ROV3Hh0NTznEdSY3kiWhQtUsUqwUFpG5Duf7yrLeeggpQPuYjrCEjWbjuzelJLb/H3NPoRYTE1BD1l/1yTEpkfk5vj1JrQ7CtPMoC0csPrlNDo3O3amWE0nZaMwMTLYJTFH9AQy4g0bZ1FpPXoZrgPieZnA==;31:P6jlNJwjVp4syEZb24Qjv+muEPvcZFP0MPe/2E9O6kMJWjQEtXSy4DFZjX8dy/83qLrV6oSfIhVelsnbcr9SJUEOh3q4s4Ey1GhgxCNuN7bVmgQBQYGsZSeQYyHxcnxxY6olCJ7QSXmRmPNJqToWBOcb6JC6abzPROVm6XAfaan1hUbGmQueqvPWrqZ+sX3qcnslFd54XNgJ8aYYSiweGwP3ZeTUuHCbRG2a4Ctulqg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B053E7FF74A884B25E64BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:nHiIJsOr3zJaDn9DQ0mIqZu+Ka9eDhsqrHdvHelhLrz1Bg2QaBy3JT1WUM0Iyr7LjomT4JTQ4rBhNCgu5Rix2OV903G0leWwhrvkoSjCv6EH0WVZ+DRMS3J4wTfMOBb4oapDvXc6jrVryuTmnCscBFw47EGQy44u0bTBoLIIxkrWTG3+yu++Km2pWR5BA4hs0VV/7GeLpbPJjQXownQHoKY93s25uDFLnbImyBYwoTHO2kSsh+IMngsJmfYJ5lLd6jdrdhs6nLyCRvkDjxL3yA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(5890100001)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(575784001)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:rXdBFYC1wX4FVABy0md44TSm1r3/2fQR9pICxS6?=
 =?us-ascii?Q?fd5YK4NI7FAAL8guA8zO7PYJMevIzmgok6IpmakMGBi1Qu0ZAPLzsJWJCZkW?=
 =?us-ascii?Q?l6zB6h9ucCS7Mg6bUTwlpUecVuw+szm0rF7S45s6q9+kK9Z1B+UioyKXb3dp?=
 =?us-ascii?Q?ScCzyBtQEozD4oltjr2+L74xGKexSqD7BwCetWtgWtb5Idk6IKGFf9A/M5IX?=
 =?us-ascii?Q?Q6rbgkS/PFXbN+Sf9fX1JIfNL2A76tFkYYD3S4hkGZ0/KIF7a5Kviw/YtTpa?=
 =?us-ascii?Q?YBlSe6yA9Y3gUx4N+bXSV981Ul27cjvbZA7LMqHsp0B0JsF32IiW8PC8Fy3z?=
 =?us-ascii?Q?PiIcsNvo2JV9ex7dpOyOvYagrldqwXlXMuSZ+jgBD69gzQQEB4Mg+3sfmoSU?=
 =?us-ascii?Q?M8U32SIGTEm/I+TAigQRr0HXXK8yiUo47kJ2E0cbIyeEggm0a7Edeft9pj1c?=
 =?us-ascii?Q?H1M+L08Y2bYED2L0bnWqCbZxbQIguZrsJltd5+pNlhwmptbaJOWKXUXlRqAP?=
 =?us-ascii?Q?Km9AP0Zi3nGa7ylW31oYDMDgQLvqH9mDiLcUuciJrGa+f8eS783INrxOQ+TG?=
 =?us-ascii?Q?+0zRdiHwDq+AWox8fRsolXH7VXTItvLJiiYNIMHYBVo3PLcaYk1Y0TjaS66R?=
 =?us-ascii?Q?mQOX161P4DVuIShbCWK+mktWv5NgqXSgx0rwtAcQZjvknLXfg4V4BbQACkIB?=
 =?us-ascii?Q?/N3qUHmPAZGGSAiBFbhuttZ/AkLnisRhgdQDzS9h3qWtupuACBIoocNzzxD1?=
 =?us-ascii?Q?6q1iXWxzWXU9P/B+NX6t964lFCILVKyBxDiKOrpLlFi1KIjHDrYltVupr8g1?=
 =?us-ascii?Q?BxQQESlOOYzsIv06FARTVCWNvpNSaBBd0mNxO9OZRfeG6aPgwcgWHcNgsT7d?=
 =?us-ascii?Q?o8QkTzn4cxUF+L0EfFJfax9hWcYkxZKNqUS0bilGh1WQaEpuLPlYfaUkogqC?=
 =?us-ascii?Q?jt3GpgXCw2Hk0bOFgqFEqXFUKvaBmuKNTT4G3Nmx+9IIiDjlMm5d7ycUBJey?=
 =?us-ascii?Q?xt0oGnmNpUqShxntTdujkjmlc4qefd/CpDhBFncS1IOVyk7hMfiGEIJdgJSR?=
 =?us-ascii?Q?37PfBj6hNeTjiK1cLw+u/XfwtqEP0QKk3cs2meh+bK9fc2FZOseIllnl8eJj?=
 =?us-ascii?Q?XA2uplezdyOYD3z6zoaFHKJBwtvd3CcvsftegF1QsiWU/89nlh5/lNIO/3gw?=
 =?us-ascii?Q?OQFYyOjgKMqsfBmZbtGHOzlrE+IQjHYud2qvbZdI+ySKmC2KAESmpLvzbGYh?=
 =?us-ascii?Q?TOjAB6McjzhHGBVmJgcr7Nrcr1rBY03cGKHFD9k2OY6OmW5pm/PguMfkDafw?=
 =?us-ascii?Q?affYHrXV1lYN2GTLdXBoU3U/z0aTi9MVTY7I4/V6wP6JyGKcrQZza1u17tpi?=
 =?us-ascii?Q?9Yz1vCe1HDwRF0TNouEFOeyrcGoM=3D?=
X-Microsoft-Antispam-Message-Info: Jgm+cAmSF8Rjwxv4QTZbiXCkmvfOkzbX9JBLopWN6vfkl2Qljrgs8aZghUfz47Yb2FXSvaVov1kxF1g//y2othdZpzXduuZCAHY41nq7XQVvKg+bz52OqslVpx2z4sG4phXVdY6Xg8cIYwYAEK+XtdenJSnTKhyD+1sOKpa+7vsGk8R37eHIG+Ky8qYGRWtg
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:FvHBNQm7cVk4PTRSg47V7rh6/LXmqUz8WdoFf6BxlyVkuqKNYg/i9BraePyKQpEn7sPmX+LrR/thFVtSfjbh9EaVCSNmhxd2KyqvajrunrPXzf9eneBpYWGzuqtiwQlYRHpaA+WxMVW7xh+QCgar+76/CwrcSCQ+Yz++Pf8dU+ct4Zyw/4+l534L4L6uA82Zxj+NZLQ5oiZfdyHwLawASdlJYWpRFiyJBGFQq4vjcBN9M7LJfc1rHPoFJ4Ncp33FcqYEC0JQSzjb2GijwL4sZzKheT1wX6ir1kjAK9bctPtn4j4LQMpa5BaDQhAUVeyxD3Cj8R5PNIVMSizEmXLm8bo/cVIcgI2OTl2nYjaUBLeJvTicLLDFNEHLWSI06rTUqq4HyEn2b0lT8gMEdPGfihBV5yUdFmvL+WURQ2kIaEo9iVDqZevbU0SNXcbxYWj1Zj3EPlhDKgRnh0AoYRqqEg==;5:ZZ0DfvHi6Tuo3ZVNz8Lu4I9qBoWcg+54cT0SJRNAD1NyJRV4vuA9MNfz3bb8/gTzEh01YGC9CzcJI8RWKoQA1uhI1kuNO/vtkM6Thj8PoY0+mvZKQyURBZrmjqBCuvH+lkhmRN5xa1nSqQBoia+R4YsSLzNEIFdHyKlc85xQ034=;24:ad7nW68nPl42DNL1l2TyEVl/O916/JovDG/8FHgfpx32oyECYu3g6UL50njB2Xf1u9BOSh7KD6WPAjhkOeIJsI5erkW/qK+7jioPs1fU+pQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:dLfxEC1dzLWRclP7nRg3NF9VEwZVfRleX9W+JjCpUh9BOSQdInlKU5eZedu/ZcuZQgPYMADvucHAYTwUnMMEpWADeRwTQ7aoDwQyEuYUNTfONNoDLWt3nytT/a/sBe+LHokFqJmwYj+oavsNBWn7bYWUcKnrOwJmSkMh4K2gtlgWDIv+gLBFXEkr/epibxYxzANO1/RAUh+1oYKrayEhjUxCmSUCpUFXHY7nnGfdvBNfwSswkfeLq63KMCsrcMNS
X-MS-Office365-Filtering-Correlation-Id: a2442666-9064-4f2a-545b-08d5abc594b3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:22.7605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2442666-9064-4f2a-545b-08d5abc594b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..7aa12f4b5745 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -83,7 +83,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
 	 */
-	lvds_encoder->bridge.of_node = pdev->dev.of_node;
+	lvds_encoder->bridge.owner = &pdev->dev;
 	lvds_encoder->bridge.funcs = &funcs;
 	drm_bridge_add(&lvds_encoder->bridge);
 
-- 
2.11.0

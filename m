Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757180AbeDZWcr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:47 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757127AbeDZWck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/24] drm/bridge: ps8622: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:25 +0200
Message-Id: <20180426223139.16740-11-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:gY1XPf7F4vkfzHrUEFrTBb6qL3Yxy+E8YnesxeKQhAcxWvbZ3ml7S1bFzMs2hLFlU+aHQGWuWSRj2oyA1nQ8D+yLl31bz1DViLnMbf6HC/GiIgKuZNGDA3eWBJscIf3AJnxESL+JxLOVBIDN0b4ac1B/va2EE54TIgvh/iWXLqdIGPkhKKajEu8+OsHAXZ4X0k9edE9e6yYQBa3EHIFJcxAoxrpUgA3Za2xIrmv/qRFn08SR0HpeZXV3kifCfryC;25:wb/5CrlRnpUne2NS43dxDfIVaG0vhJDU8kR8JTz62WYeRsxyj+O8l7w85Eauzyhzq0KXgE/kRh36e2FlPnrKJ6ukKLGk9J2AFAHItOKCz8BrmsOmeN2JURrDsJUkaOxpKyda+3bmief7wsRyjotflLa/xhaf2kwB9w9oJ1oYFE3Bnc25DUGYRSBQpvhlAlgn2ZZn0kB6RoBMZnEH5w2cOVGkh/1O5t05Whz6iy0roCB8bZchtVAuleO84CZc79lYq//EaalilAZHa19i/wuorsniUQ75cRoyYUp4zxHo7MpPuboEi1SyuhX/CKfj2I8lqO+aSC7Ot9FIHkFSAYOYPQ==;31:czZ2nM6lV1oJgCxSusm0qBV9RTUhhw3vyUzVueLJGx1jJJhErixTedJbFdNnURAXVARax2gehP0QmKF5cn3PMs7x+Z1SdSClvXTZ601XI/MOczgCrzF0zg7qucob05WeCd5kuF9GQ6IJIE9ilQbKC+qRSgh63jdqbOThMQZcRFgkqMql5tTi2VJUgn4ba4tkhLfhfzy53GHT69Vipct3oWlRAwnywnvrWPAcnhqej38=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27821721FCAD4C4F1E0F4073BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:T0bVVsW+987LDU0NC16VHQL650ChvkZUq9MLC079MvSydQQtQNgEsKmxvv4prS0oUX3Ml1DrbemCd3+9al2DbfWQz5rr3HWNgYnH+MICGEoiF89zJHVE35xlG+L7f6yIJps5AIIPG2UlO78r914mhlVK5pZWZKRTkIhsJpXCZLO7208iAKCA9QlHIv8MXdvGd9fn+Th16Z+XdrCF6c5ifh5pISeGm+udSWNxnnGrJj2dTzaJxmnj6ze2e3KE4sghkS0yjWI9db/ydwmjd6WQlg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:wjH3IDIaZjHiHfCAFB93mU3YBLED/QKvtTCoRe+?=
 =?us-ascii?Q?ZnKOwhqWQW661TD9QF9AOG+hIyvBo9EjNJo7l+DUAwX75vP9or04sEgIZA3X?=
 =?us-ascii?Q?VMcOlM2htcSSrwrfosZHKD60Fh7FkH9ErFFh/qHN0wnmxC8GQgYvIsyIaW5m?=
 =?us-ascii?Q?Qso5IbI90zOzBCI4TPGpF2MLryCfKRBbO045mNMCvcwdyQWf6TwZJqvSnacl?=
 =?us-ascii?Q?WGp6S26K/dvJIMOIDgfWaAd7ZyQBlSKAL6rys51rDib5SE5zNEieVvA8rb0+?=
 =?us-ascii?Q?nlnSLhsApRK5/nEbc8OavWJbpM+H5br6R9vBdSCji/PIsVJYXRlHKwzTMvcf?=
 =?us-ascii?Q?pFqgzCNplREnHST4HSY52IdX+jRpMTFit97EAgLasVPvzo32ZgdDEMVxijMj?=
 =?us-ascii?Q?2jAMGQKrpI3Y9tye8S3CB8hhpSJBrdFtXx8Cwg63kyTnX5f1KVNDq9xZ+U02?=
 =?us-ascii?Q?HBxCPGCEtBKXscLOQMYNZ9htDS8rkjnXOsDHo0VALCheylPFWItiFcBMmyDX?=
 =?us-ascii?Q?6NKzRBCp4eNgD7wri56KKjEN5D/OOuY43QQ0iWQ90bKKkD1eEj6VF/uYAYSY?=
 =?us-ascii?Q?QthNj6q95HzzRT3AyBXK21NddTgL4aRQmEwJa/Y7jM6Ctwjdnznt9l+NlFdL?=
 =?us-ascii?Q?p4VX3jp5P0JEj2GYSSFyux6r7sBrj9jvc9vRc+wYbLL0CT6BSpfWZfZwZ2bc?=
 =?us-ascii?Q?bH2jah4bKt9erB6gGZy5jh0pnK19kL0HDfj5bohvh1JWr4x1+fZxnY5vErq/?=
 =?us-ascii?Q?Fyg4Gh9Xhdx7kryXHTqgBS5iZWnHrhGlzAT1XdrlWjs4UVZK72PIKBnBACZp?=
 =?us-ascii?Q?aPT4JMuFOevSZqhTJhHCQ1vCnb+MJCMjpS7uWke1Kbmam95dnqZX9zqMLxeu?=
 =?us-ascii?Q?Hyg1kJ30Qw5hZMBVxuAzcMvvUBGlCzA6LgJxQzYh71aETMywaQqHaUXQFUS3?=
 =?us-ascii?Q?hos42BwEF942M/6rE57b5ROLH81O3vMvj6AXHt8z4oobizFxXO36rF5BYr87?=
 =?us-ascii?Q?ijD3q+XJ7LuudPYl/QH6JfGqpCD+68EyzfB1gpNFGV+5TV27pdTg/8CD/ch8?=
 =?us-ascii?Q?1j6NPBra00hooageFPlayJ4/oqMiD1H+8cKZBBsbchuQg4KuGFJ4UlJHS8aK?=
 =?us-ascii?Q?tkS1P5QwdpEY3reCI10q22viK3SWL2Zz3ccAybejjnx0bMrJMglaafl3S+mL?=
 =?us-ascii?Q?RHw45BIZEa6MTM1s7Y4T1SWACDFXpuyHc0BK5/9g7DsWWq7XnOBTI+Kx/zl+?=
 =?us-ascii?Q?7l9Anwfr1wQIxS7f+iR7qnfN9fQ253o9FlgSb0s06JCl7UyALQ+pYog70N6C?=
 =?us-ascii?Q?nAVvnm5p5IbVd9YWx7L5YJvxV4jcABDUbzIJErUpQdg4vtVdTCKIvUqWsVQy?=
 =?us-ascii?Q?9lzGqYQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 1radVfykGVrPVZr3oIK8uL/O+h7jCGQ2NVAuCphYe96txDRJ7pIwWmuvLynU02VAac0EM8IS+QrxV81jKZLxkgdFyWy/Og8dAGe/y5xt/By9VKhWz1zphKVc4cjYUPE6E63wBScUf9Apj+RDghsMnW6gcerXuAKwW0n66HSd8g8ZYJO4mCVB0vgjYyfMDdff
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:dbRY1omMVkNhnEq36sJDwdvcTsCHhtRdOQ+McfScK7R5qt+8NGpMhWKIVxfrM+PX6+Hn0pQqzx/y6iEsNs36TrY8HmJ1FkrBZikW8vo3DkwWX7ikt3pBKE519PqlixUaiOcTW+PHTqucmyryi7+PqmPNxmkC8PPlqFQrDgOBixY5uXi3ytRz0KZRXrMY1tjVxSNPZOQDPRzCSuWpAe/5/pMBItMKfQuvQ/L5F8auSTnQTxmS66BQBXkl4oS7Z+VGwgNUEHZdDqBFkpbBvxc/qX9Q6hwr/2jhrhS8Ta9k/ni4ArhINm+IflS31iOBTBXYptFhhLHPOqLKgTIpeRBbH96Zjj9wgQxQmx713MKfRvlFcVXqjd1ZQv+oG6nXFABnbUqepOxZZpDWQOOO52hwtBYjXFuzlUbw8+BFcxR8FAM3660W/EGu5He4LUfBejMKnGnLM0ueX89YgZJxDwjqkQ==;5:5g6ik1vzYPQMJQcqOrL/zugcEDQfdKr0Xn40qUF//oyxeQfkt4JWfOX5ZulUt27vSWCuKLvHcNpLcLlSU5eP3V2Iy/ySgy5tQ77jyQ22Y3rD60feSHM0RCraYXjW/4/p+CWxlXh5uHuHgwcZkEmiHpWvib8wvXfWqS5IxUpkQkw=;24:38aFJlF0G7p7VLUq0x3iDH3ZoVQZBuj9YmLGi+wFCmPlu1p/0QddtWpDF+qIKkjWK8KOT4aSg2m6ze4NpaLRvRSVn74t2F+8rtB2f90XiJA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:12v+Zo18Q4IBmZ4Et5IWvPuHUXNqoTwCMQl+UybUKurDBtbZdxeV16k+At1yhvveBEfg7GFZxRPaaf2GdYcCQ9tU9DeOHb3MXLSf0S8Sr96xovVcnbEs1NLJWZPSVUn6F6dH5McyGU1NsSG7gUuLaHaOqyS/mCvupoyv6rjzsVdB73MWhcZiO7aqDTQTIaU6/CGcdRqoK5zXgFeqBOXwi0ZUip5GDJhpgZQYnT9JWYtCn2vOf/SaU/A+xJwIbxTM
X-MS-Office365-Filtering-Correlation-Id: e16cbcd7-1981-4e1a-1b0d-08d5abc59a26
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:31.8857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16cbcd7-1981-4e1a-1b0d-08d5abc59a26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 81198f5e9afa..6dd19a5fcebd 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -595,8 +595,8 @@ static int ps8622_probe(struct i2c_client *client,
 		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
+	ps8622->bridge.owner = dev;
 	ps8622->bridge.funcs = &ps8622_bridge_funcs;
-	ps8622->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ps8622->bridge);
 
 	i2c_set_clientdata(client, ps8622);
-- 
2.11.0

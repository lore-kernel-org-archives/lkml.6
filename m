Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEDN5r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:57:47 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:46048
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751716AbeEDNx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 17/26] drm/bridge: thc63lvd1024: provide an owner .odev device
Date: Fri,  4 May 2018 15:52:03 +0200
Message-Id: <20180504135212.26977-18-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:P8n6TqDSbqRJ90V4gV1YbJEmB+93TYWTa0aQ+BBgdpuBBAF7jxsnvYDPFABKJOOC8TLBRw7RTdu1jeEJT/YQ9FLuyTKmhFiMs0CRfpEtWXqfC7koPfw8nuculV5Nw8b5l5yZYAnhScNXkbPxckeoQOBt8KqwMONObe9j9TdBMN69cNQ/gUEgJBt+2poPaitYcvgYS89sTMU8BTFwJotiehAXkQ8/QTnFyqfWwttbpK9yVi0adRUSxq8yydCWLQFW;25:zkwrLUzqDotyacoVVyc87cd+3cmwA8DUUcg9UI6cndVrCB/rsRmdYyLYgoeEAj1vlKZNfeoBPLXaOqBeCATo1StaTqvvgWsFKT7s4h5SSrMr1E+HzoBkCyoUONHQHKBOUhB5sT+w1ZMdHAqPsf1iOf9Ze8VcRmjiA+PsoQyL52EWZHZkmCfl2IyG2xLCgvK4JKTjR+dFno1Dtw2tLHFDBYra3uD2aijEJuK2jM/PwLL6RGYGn6Tc7UGmd1cv6F2epyHep+10kQHMVKGujKPvy/FkC75GR64nWnZPOoXQCfG6zJALxq89E97JBONfsZRrk/l0vU7xCV5OK7igsiJQfA==;31:uhflQYLL42mNwPZZTEmUVhYiC5Tu47gJmkPML3IgK7aPGZy321eCIVtfGsYhEO7kJoLWSJomYlCNAB/iXAF0z65B9RCQjOJ1nL//Tin761DCg8QV/ek4YeAsmMmdAKtHETD0c+b7DJ9e8A6kDcPEg/i9yT6p/uROYuJi6eISuzrVKR7HbqNhFppnDXOltZoVLE5hr7fx3d00OLJdwcyK+cPX/lV6imJVnvxYghCCxgo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27698BC468B0FC73A62688D2BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:5nha78GX6IT88PWRuBYA8rswd/OzD4265Z628zEuTOpR7F3TZnTG/FNjTunc3GnUaZsOauzvhJrKthDLyAqAMw6CZe2w1el7JLHf7PJ0uas2Hg7zA7GBilpy+QGntD0201yBv5Xe+JEZZ8wU+4x0EQ21j815hRq+awbeg4d26Fv1Q9FBQyn0vJsa23ieIgjZSfPHwMo9ZfW6aHi59KgJJhRzLN2/gxInTuptxRiGOxvVu4muMj5mFs5Wlob2+vezD0LIoIQH83VTfkRItrDpDA==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:lv/Hontpmso60mUBjUq8HCQfRccGx6dYF58vDII?=
 =?us-ascii?Q?E5vl+vw0jySZb+RPDUTiNTE6xMx0+btRVh9+OD6mYBptDIanc7OqxOrHtD3b?=
 =?us-ascii?Q?YS4e25reeYmeeGF2nyZvONSteh94ACwvPX2Kp6v1Hj+B/ZrolxbiCooDfrec?=
 =?us-ascii?Q?oIlCnUE2E/LFp+EkAF+CxAR81SUzYXSR6TGiaBqAYcSUSkubKx6r9kbc6LHJ?=
 =?us-ascii?Q?ZxyjvziAzaIX8G65ZO6kxUNibQx05mjFNjkjMppGkFrHnzyEreFGHaN1pPQS?=
 =?us-ascii?Q?6/RSKZAWIeqz+I8aMDB/wXG02Rbn3nRZho4pJLp6lO+f6mBgxdBG7eZ89AG6?=
 =?us-ascii?Q?rrhy7iADdXDQjhv3Ht7tY6nnzXLDER0DG0U2cA/la46TzPdnpKTA8X8BrYRn?=
 =?us-ascii?Q?/D1A1+G8Uhcs00wN/xSY5y7fQ6TNUW6VtTHdZp/Q+jdgFMKTaXJiIsGZh/sy?=
 =?us-ascii?Q?5xm7OPqrQyzohgDYrV+bhC1Fct8j2GXgrwlYDxkbJ/0Q7nC9IlNCP2Fx9kcq?=
 =?us-ascii?Q?/kMzcYoZOgEIcbpPdndaEm24jaqugL5YYwnTvuJZBkq51yFnT0rgGem7XpBR?=
 =?us-ascii?Q?xfTQwCpEALNZe2kgaBr8u8Z9RTBfQcoS5y4bfCcMo6+OEdUbtif6DwqGAbU2?=
 =?us-ascii?Q?aS8kxv8vtvgC4b8X4z9p1BVG59Rg/dCuVdnz8Gh+aUaxhGpbeiUX+X8kqcHo?=
 =?us-ascii?Q?YHTW7gBDRn9Rtsl9KZVmIjLIXO/WqOYjHAjMNGeuXnDu34awnTyprgVl3FwV?=
 =?us-ascii?Q?8kM6ikQJVS0waZSsJJgrVoDXhRpzGZFH0v+N9qfA+JIYO65xbZ2Aom6blIDg?=
 =?us-ascii?Q?kLGU/DFOqzSluxuQEczDvWf7xUGiqNhMCbZ+DInkYp99nHh29wcMTt1mxhDX?=
 =?us-ascii?Q?yJLwJPF3FIO5pM20koEK5ob3CrmnEu2mq5vsTZyu77xzIQGlyYknkcVnUKpq?=
 =?us-ascii?Q?Jp+VYgtwUkz/HOWg4W7wyunTL9xWuBpKM1ds+rpQRdYhv3L1jOyrtZtQMPqt?=
 =?us-ascii?Q?eUt20ckU0T5umE9HqGGbzLjYN9dA1cuDOZlChHSRadHywUqZdkpef9MHDfWq?=
 =?us-ascii?Q?NM6gQQ+kgQI0GwGpnPuf848KVjTrXEB2pWR4M6JhdNYNVxUNGW5TCmCw7JOM?=
 =?us-ascii?Q?Haz19Wua2i0ae3OwvO0El6oQX0Voe+a4rmylFimlbPvtieNKFlDdoEUVmm40?=
 =?us-ascii?Q?IcSQykQj4F0FWhZo7tzjwkJGdugpww6PD8QexmawifJt4H0IyxzXhW0rQPjM?=
 =?us-ascii?Q?DgbhrlDFY3ORrHWWQ0VCgNH8Xeca0CYKecN91PR4r/wAo651Fib7UOfDvQPg?=
 =?us-ascii?Q?v8Hdgeiq6RejYKvby6X2+zizgsRFTE7RdNYltq+onaaJUgG3EOl576Cn5rfX?=
 =?us-ascii?Q?9b/ZPSg=3D=3D?=
X-Microsoft-Antispam-Message-Info: p4Q/u3anhYuBhQ4hQvW8X2dQgE221PAfTbxL+h7UWeYH+eqQ7vh/EUmMCpp/eZq+KJlV0iNRHicNBfoFkl6CuKW6AGYpy+fh3CNdf4W5hsDGEtKIwPdTi8yDKpx9ZBYhwt6g+JgjuuWj5xStdmoDKALmVxN9vftWVmuKIGRRM5T6JHWZs84ZTdSCBHUCNshn
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:uiLR4Al3Y1ax7+iF+6ro7ri30ugLMpN+fO/YmRUSj+v4r6deqjO29dHywDOJUoTpaZWDy8qZQkK0qkMR/XA5WgH0DFQTOJ3pWWv78d6uMii5bPsK431vGunVgezBvUlRuoLQiD6GOuvfwqPcjpspNOaXjRPYXMt/UL3OVGeNBipA1dzQX0yMCyhPzK7LsH5h0baZ/Unv/UXwtNt1fAZEpllTYpqQNUc0BcrOMEav57q+YNJTv0zW/KKhSLLkAtfY21XPQfGAUWY19Dq/RxmwKctZOHcZCOizQ1LLI+Pk9BcjePVRj41kGAcIMzG6TfFe+BKy5yc4Ao5SiSJbxygRdMQZzXbNw2NCuqSq39X6uv5NOW/RwzqRYjv/zooJ9r1ITBwrB1Q/mjM3fwrRw59E+o3NloBdMC78brnzhwzhe13Z0tE4JEI1pHrCF5Iy0Ynv2WY3dswTA2ewwLLFwS8f+Q==;5:7oz1kK+DWVw5vw9nWATeyYvyq8cCfEEXWiWJBjaAGtzcP9E7RRptZfW1PnyVg2TiGOLRheOXposSpXiBTufUqlrPPnKNMBEwBZWxXR5Dc7Z4XPvGtraVHbAOETUmUGwathvNPaDM5JfUnV7uz32/8wwhCxNWKK6tEb2hS/ITAtA=;24:cumjhZfZHPyHv8NVASt9auXavUUgpaSW/zsUw7RfTZQR9JOP8QAQI+tRHpm7SP6Sbz4WC29LdzknuwTcXZaCy0ioYcqvyd7jwtAlIYcGvCo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:fOXoF8FewycGrX1J9aaQ15lSYfkuEco7MvbRfljnOvvQijkHc73RhVwY0V1/oV5flrtYcgAhAKoL6OJR3/llnvMSpE3VEWHRlexpaz5EOH4Oe6CVohRbyCXOeb9mW5LZoNeTXzVKVgwiH6WF4nM3O+OzN4NZUMN/KOEV/fjD/+U8r0Fvuzh3Z8TtCUlPvSCqdDnbwai1nVJywVS6kTs4v8IVq9BlDLag15VMqPdzzFlRUnDVXFUZlUwIMboePDFe
X-MS-Office365-Filtering-Correlation-Id: 5b3563eb-7b55-44fa-4f65-08d5b1c667b6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:23.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3563eb-7b55-44fa-4f65-08d5b1c667b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/thc63lvd1024.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
index c8b9edd5a7f4..4765c9c45aef 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -167,8 +167,8 @@ static int thc63_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	thc63->bridge.odev = &pdev->dev;
 	thc63->bridge.driver_private = thc63;
-	thc63->bridge.of_node = pdev->dev.of_node;
 	thc63->bridge.funcs = &thc63_bridge_func;
 
 	drm_bridge_add(&thc63->bridge);
-- 
2.11.0

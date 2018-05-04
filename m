Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeEDNzU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:20 -0400
Received: from mail-eopbgr20091.outbound.protection.outlook.com ([40.107.2.91]:36544
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751792AbeEDNxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 22/26] drm/rcar-du: lvds: provide an owner .odev device for the bridge
Date: Fri,  4 May 2018 15:52:08 +0200
Message-Id: <20180504135212.26977-23-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:k4lAPUOzoA3/XJS2qyQJYQ4SmtpgAgcR4HIyUSEG8BzMEIC67FYKoM0ztjYOfoBwQCjb0KgbMV+AwiNsvZjVWK8gEoHgVV2TldK9v6vsA79E45ccR0mKpwQ5Xkyn1zN/4NUujMDJIH5yV1pkG5u1UFDcn3rGqy+cvpViSXVrImXMLuBTX/w6WUVsNT/l8FW35Z55cD8D7nevqYP83fF7qXgfUjuB4oZbTK7Y3mmU3p3Hh98Q4V0uE2Tgoj/kfm0U;25:vmaRV2rha/FwzVqbYh+7S7toO+1P3Dt0aGzq5lwBd7XoFaugEyCqcnrwkkBwS1z0aQypS1J+yd2YHlOWa+9GZRG5ze9/NvBs5RrOV7ka0z4AKM6pSPD+U9a4XiQ/9MlZ9CVyPocdS/YCQuLNgNoertIgbK3gA6FAu9P/CoJftaBdFAtdkcOeOL7vI5XVTrAqOF2dg0av+rzSyowd3w9UprVlihnaXLFrLak1ksxrO9HjOs49I4bR4ZQNMEskHhFQdrSDbek7XnzpRqicg5S2kyc7Xu1DXKoI3A5ZRevEVUn9GQc01SRm7DDchVrFuIIpBDw+PuzxhfXN56Un7RrAxg==;31:qQx1Zp5jL58MrDYtFbr24U2/oIK4l1/JO0LeeyeqRCnphPRhuSimo8S5Du31NVtXHXkQmh36YVGUR/kwx57HusWppMwgcbREmtDV1RdCGQdAF0kCR9+bEH6yriDxDP7Wbvi7B4fcfjgIaBXS8eLu84ZaRBAzdrCTgZGfodT4zbuRZZmFLKu1k4EP3FpKsHwl0k1sJiP62Wjb+Ee7Ug9ebU66kZdrDCIQrBLPK//TiNk=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB276990993EFF6B3ECABF58B8BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:IAmpKioVahlyQqkw1AK/O4CJJZZVO7FOKJuNMn03ZqL/NZAD2WYFQvz+LwHsSyvxmP87YjZgUH4aVpTPn+cRSTBK3dGqnbFdhLnPHI8rsGpNm1tu0fZE/DioCVtjD8THbhigHENOn/uRLTkEDS8HwfUTIFcXyMsskj6FoZPaUe/RmdF0hCbe3dXSCAMLTrqs1DxnV1bh9bm/C28PAzGSsKTgSDTmJEEyR4uZnqyWRJMDMffedMlkm8kpNYYZHMOC2Ya/hYkUiBpnXH7AqsDzRA==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:mTInUo6oFbPbBpJb40GWGnzq/pYLh/vrRzx15c6?=
 =?us-ascii?Q?xyGVvELNahIU0M8n+qaPhxJRjFto89lyc9soth+bu9cyIxMvRwINkJaxIDIK?=
 =?us-ascii?Q?m5k7SxRaWWAeo/wsa5mwNkS/yOIED+D/tetKWxx9u78otkajB3HHZH6CpkMp?=
 =?us-ascii?Q?9V+dHBCLSO8yPMT8dtzEXU6R42NLYESB5E5JfJvdBy2A4O/G0tnn92rTvH0s?=
 =?us-ascii?Q?98LsnJyl63dEWzUozk5prwujLmRv8eS24S15lBuhQPokINemaTp7P7jjrFQC?=
 =?us-ascii?Q?0IDpqHWq6VHM5gM3u5L7afynsgmMNd6iIE59Q95pWqb5wPTLJPiiGWf9gw8S?=
 =?us-ascii?Q?IOtNGQgBlWf3WXsxy+PXHkeRKynoVH99BsjKYOaryNNrvQbQGafTSRdBsntz?=
 =?us-ascii?Q?TGVPsGEJ//5c5x8HkZOs3tcJujOHarHmcBRzp1tIidw/w+brfSEjj3UJrOBJ?=
 =?us-ascii?Q?PR/MdwDhnGFbP7LhucgEl1V0sF+bc6AOvVQz6JnpbgrkCTtrv8a87iOUR8fO?=
 =?us-ascii?Q?LgdfqIn2wVgW3WIyvZJZh4Ez4a1m19AhPyH2sn0sFuS46GDLnAbmi+iV93Tz?=
 =?us-ascii?Q?LOq5au3DE03uKJy81k5B6TSWgRHpa4di2b3kZe0plp59KNJX7jb3suknWIwV?=
 =?us-ascii?Q?ZDltuUZ/vqCSs2FEESGokXzEWQ7QUbE+WYsgqDG9I7mSVRZdDKeIP1JPuUW9?=
 =?us-ascii?Q?zqX+1DXMWr79H0ZObQ2JMDfKgVk7awK+n2RZhktSaPxaxCmyzxSp7P2uFGCB?=
 =?us-ascii?Q?j8Oo0jjAStBD+cE76EjoOMdXj1SxQIFkIAi7g6JcHD+pk93Rxtg6KVbCAm0h?=
 =?us-ascii?Q?J71C92LwNO2KvA5Y9LrwRA/IehaCA7ZQBZdaK1rd41yP1eSiPRWLueeBRn8i?=
 =?us-ascii?Q?3Fnlmscr2stURt5KsDl8zS46KQ6rrfTglki4TUGtfiPyZjyTj5/CSYwq+MX4?=
 =?us-ascii?Q?dK+C9Jv19vfO+RrgJUJLrf1C4eiUoTK0GX2UFMWV1dc0EAVfQxiTt/Ypbz86?=
 =?us-ascii?Q?xaST+TV3hsQmyxsCAO+7cP77MKckHLKv31emRtB8hFnwcgNq2yJxj8Hmbyfl?=
 =?us-ascii?Q?pgta7av5AD+drQBmnndjC/5S+UfiBpY8towO7ItXLs80qa81JsPHid+3HjuI?=
 =?us-ascii?Q?mpks3LVUJGCSmv+fQKBXjm0+41wQUmKe2CMz0gWKTBFuyeT+GrzskAyu8A+k?=
 =?us-ascii?Q?HoslzbNogVDyUfP3NuezpMZ9PPrMdaEbfiWHe17OufAn8EjYKSnlQQYvCigZ?=
 =?us-ascii?Q?woB02aZgvbkWyX4ziNWxN9EiPTOdNnlG1olJJKJfGS9wXabV9eyFd/10eGxa?=
 =?us-ascii?Q?V6Jpy3VDnEoYMSqX5KcbxiJRifuxoGcJvNpOSsnlXKzcMyK7sxh+R6+zCcmc?=
 =?us-ascii?Q?9/92nfg=3D=3D?=
X-Microsoft-Antispam-Message-Info: vX3v7NnSjaW2E6wblb2XFk1fBE0aVuH3NOOZt0t0Ciug0eiVQIGhdGMuP/TjgKIrZieGfj+4FyUZxGzFlvlHRCD/FLhiBHBA32xXb42vab1IrBd+AtUO/n3EL/ZCNSlR5HSaBHFERn4KxY827t3+CnkcAgKarJ3LVxhn/G6HxvFlME1J5G14cRiME8I2n4qF
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:y1tRXBAZIxBndKeuMnK3TLS76NgDzHgB0RDO3BZfetjdxkcbpUYQYfZ/fYHI2zh6vjvqbqC5GUDXcDFCYKpHVLuL9zymQQ4N940BdP4eR26Is4V/0l9b9z51d/dqv0NW54TM5lLgoE+6DuSFxW/vcIcg56iUOKWvqajFAs3yGeV6Nm9TeyIti+qsG+s1yKeWG7++vl7MnhKWK6PN30OIMZ4DIMSZgP6c3IU9cAD9wqmGzU7/y/bu87ivFf80EzEYqAg+aIbqtx8nv1gEG+UbV9Hhupsxo3PYOToaeijF7sMcAJ1cmcIkeuaEF4iW2rW/gQB2b8fZmeqhYzbU4zGhTvmrBe8pChWzDyg3EEJeI32M9sVV8F3Uf+RoW0nG8fh+lVmDvkV1onGj63p+ZaGNIN+m+TLZ/Pn70beMDwNGtcxJ47VIhpOMBsUVMXCByZcAiCofgEoa8dbLAUn6iNbp+A==;5:XT+0ZFqVX7+g43kQyu8xioP88IxiPY72v1D4cFHp3fD1d+tEDY5KcnNSWvwUogIxFSvWIg14jkhF6RgCl68gF6Aahq/KvuV4MZTxsrAtPRjh52LGVVtsNWXThadXVOiVzCRcwxtE67xLDy17zu47QX237Tsh9AI3mo+KGZIJtw4=;24:PuniirxW9Su0CAmVgEeeWOn6wwPwVti6VSrHzbRJJFWVkmj4YfyYs7BEIWjcqiYfLBU55+21m/jOkxwXib4eBT4JtOLgwHbQ0qYfR3V0y2c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:0wIN0p1rhcTo12JW1E44VXVf9wQZmaJieVbyt55A1oW0Okry1Yv6KrwgAZ2hA1DvZbMZ31d6Om7XcXhERVGsFvRX+Mrkbzb8QLfvJ9xGesWpQRzyB8uomvrGwuK9POfdCjERx2wt5upxY2o54l9ChHl8RzCTXWvEj9AcXufhdESyqZ1b1soEt8i3bbAiwg5ZikZglcZe/68Blnidv/szBK23TPPM1FZzAsE+KSLygBSQRWKKdHSyVdPlZbgYh3y0
X-MS-Office365-Filtering-Correlation-Id: eb1a1adb-b536-4d3b-7010-08d5b1c66f11
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:36.1452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1a1adb-b536-4d3b-7010-08d5b1c66f11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 3d2d3bbd1342..efda02f55c95 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -463,9 +463,9 @@ static int rcar_lvds_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	lvds->bridge.odev = &pdev->dev;
 	lvds->bridge.driver_private = lvds;
 	lvds->bridge.funcs = &rcar_lvds_bridge_ops;
-	lvds->bridge.of_node = pdev->dev.of_node;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	lvds->mmio = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.11.0

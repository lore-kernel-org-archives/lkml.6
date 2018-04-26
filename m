Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757147AbeDZWck (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:40 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755175AbeDZWce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/24] drm/bridge: nxp-ptn3460: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:23 +0200
Message-Id: <20180426223139.16740-9-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:kYyQ4jrpxWn/aWSNYOA20Hncfi+jOvqpg7dVS4+iSIZ5sMPD0zriw8xXW38xUv2yDVMg24zg+0zkKRlnoBdCY4qICT4X7fnh3fbyioo7h+Umcd+atqEVSfSxLmijN7k6LnXT5R++0I1YyJjHqeOOFN7elLNtaxvTCpU2r3HK4SsrL2ZiX7a3y2PuInKfzVWeCsnYUBsP3Zpdz+cMSrBd4S8G7f/jwD89APHLNBJRr7gHY2wQQ+sz1z+XPPHHP4Cl;25:r9vAbwlkWhQsIHJxkbq01XB5srkABJ7dKXnKH0RQhcWETGotzUyV90QVNX9NVu9nmQh6VIee3MtAO1MDWtWr5n8bmWSQki/w5Zs7D77a/uFw4PyThcGFu1MrjuX4DB+KJFn/8zhNOiWDmUEsD9IfZ5kq2ef540TGMz+yRfmYOwMyUw8L06Y8WAVuKkdRY1T6x6WvDu0xK19tCVDfXfPGYhIDAzFHcpXg6eiC4aFzTNO6tznvV4pDqIkt0+JlZkl1wOVcqRqp/jA7j9S1ndd8SGSdI7YDTvurVhB6IeY/C+pAe6hx7wlkSsQzgnegmzX1iiGUOW6icPYJiz6s8axV4Q==;31:F2UXKMJZB8d/sMs4UhZsikqEWbmEx70o4Yf5FpFGF/l8f3XctlZaIPZIHdMCshMhizFjktXLNRk+hAv6+tEw/s7uAzjdhVVSWy2Idz/lDz2jOCpxyvYMTSuhv/4uNNfZauYCua3eI6fbGiLNSfXV1vw5IG7Nfi6DJ7+r2YL0pYfOlG/GnhRyFf/6h9MrVuSxunAk8gxa/4sC3/i19Qnco8FwRYP4KMEJri4Xftkcq60=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782D4AC284EEB5671A74ED1BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:/eP8p0BDYAciLiwLqidDY+AR4RVWCqFtph5SBb6mLD3bcQSHzEk0xLaeO3nkr+rtMi7Ph3QZ9ge60q/qDCtPCYesEEifpJoVtYyvc7obpSSTAAabAikpLCNUMivRMaBEDWdz8AH36g35rFCPlCsEB4KvFNopoGQH/VvNtcnX3veL5uecxYVqC6iGdO0fuf3o4aB012QGAMJ+yBMGjabdntL80hvTOxnk5Ds0K+cqS9IWUcKBEB/LEdk6sCLIyfnev9d8/jgKRHK2OuMdSBikcQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:2gVT70evePdxpN9j9d8iwD/THv47BTLF3gTfXH7?=
 =?us-ascii?Q?KKzbMx4ssFyRMMaJeLV9TAz3mPcCnYEIoD7btpwzdPbI8jmV8iJ7DIENWVb5?=
 =?us-ascii?Q?OkxgK/hGixCX+4IKTq29Cmn6m7sMBbwoh3VzWF69li9i5i0KVgBJA8VP9vpz?=
 =?us-ascii?Q?ifXAI4+N60zdZdO1yBA6p9YvnnDQDLxLD8lexEYWxeeX5dnnreG23pWVmkqF?=
 =?us-ascii?Q?7UMB2y4Ehoq16/aPwepk2mV3GWB0I67ibOLLw/KLBKVbHCxQ0pQSnY4xjjJ0?=
 =?us-ascii?Q?Cr54QZ8gi+IJNc7OvdPf84o2gDTpwdHbB8BTx2OXTjfN1+uupkj5CsQM/NPM?=
 =?us-ascii?Q?n8HPYDAsxdok+8ISNTZEiDnW4jIMIqY8oe6ISsl/gEJH8J8GfnpkUh1DSO89?=
 =?us-ascii?Q?ueZ/TxeqECWcT03dQ3V4W32ldSgMbKmZb4jefUQIMAOtSjbk2EujTkqJKQuv?=
 =?us-ascii?Q?DOraWy+XMArhBznhKpAUrBGSf0lxU+FNFdgKQO4QCIjBWF5lIhL3xkuvRQY6?=
 =?us-ascii?Q?/GJie8kUSeUq+J0siSK2Kqs/ZS4GlZoWzwRXi0FEtJMd8VjF/HtjSDISDeh9?=
 =?us-ascii?Q?Xdvh+8K8ptzr+ju1+xo0NA29zTvjxIdFmWfXfAGvFmyG099uycDdyl+st3ke?=
 =?us-ascii?Q?yWplV2TSrYsxgk7dB1L8qYrrp7Nlp66Ata1k5+b93VOl/ADepuqbSKnNhC6G?=
 =?us-ascii?Q?k7hbNid3hOPQGDFhesueO1nUpqLWfjeDXFmgjakjOhK0I1QrC4kombOR57MD?=
 =?us-ascii?Q?BUqNu2Q1H052cz8ZBSiwauLWrSbDTq6WKA9rmGbEOsVy+XhYAiKS0GIVKTr+?=
 =?us-ascii?Q?lTChTyK7+RNHIh8zkKdwv64amXQ6blKx47KVezQa6dGlD5Igu2jx9t5QYPi1?=
 =?us-ascii?Q?IUi5rbYmVVynGHV+Y9yzN+tKt23zEdL0PltdVc6JFosX5KuYnh5REUwN25jH?=
 =?us-ascii?Q?6hfqtpBylhQ4GxcTjNHTymIAN1C5mBpd0bwYBHl94HWh6zfnQrRgzVBeuk2e?=
 =?us-ascii?Q?LGwliFLDlq6agJzNzC6bWeWdEZG32w+kUKZbPNGXU2iJ1Tea82VoOKGzRt3/?=
 =?us-ascii?Q?p7fGgBFkboUtg4K/4VlNFSZlNb/TsWfVooAeia/Yn5iVSaaKkMmwxlSE45Ge?=
 =?us-ascii?Q?OmH0vdVMLcfvlPT7g1vfIei18WtLO/lomjUJrVeyUPsPe6PU48MLRjjWxprC?=
 =?us-ascii?Q?BB70G7KbHctpHRrSX4WpPEnR9fsfb8aZG4d5Y/oIr/ChuBCnOsY2P5ouNUBx?=
 =?us-ascii?Q?Uf/SyVIoKfngk7V9ZPtYazmDCIHqTFY0InBl6nwy8mSbPrsEpZWA5rklCrgo?=
 =?us-ascii?Q?MQvHGcQQmiPESFejLrazAAvBV2UeI1U3G0L6QlVTf68I04GSm+E7K2Qf7Nt0?=
 =?us-ascii?Q?Y9rBqiw=3D=3D?=
X-Microsoft-Antispam-Message-Info: S1aRO4k1MRqqLXQ04kQzhY+LSIwQq7jAFqiCJT8OJdULPFu0i8qDtz9npIkU5wUUpexGle0q5vU4f7N+kJm0zcEHwBVpU9V7//scJ8hzLe/GRdozjpv0sV1dr+MmkI6TOsWXfUylDa4jed8swyB9kzkQR3MmAWG2zxNup/mmS7L3txFGW5cqqtKq3F2VqHvP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Wg6w4uHgYo8ZreMXwygzke2xnEBi98cL8o/h8A8cJ1F9x3K6zppxR7y7o1ndNG2xSa8Jbfjsv8n2p9alHal7ZLBxhwo7Fw2lybvBi8QtVnARIo9aC8uNRdRfriRNN8FeOeTsEtRu3vOx8oZiSa06Jsj/T8Fut4Xg6cm5+PzU5xvsQDNSOhL4yQN/Y5u5J0lqGLkMPZZzxIdK97FWAtmFNYLggcTvxI1ArUzMPUqV7ysD78omZkaelKfpoKPcyXFQUlDQOGQiuh9NUhClvPQK+cx8lSlfvWxFX52AcPEATkBazV60nIuCwmi2ugd8x+6/fGw/bTRipmSfwOYSZ8onScu0hNURLyoDdRxbJZeG/qXrQrCa9WxIKmRBKzi4uWTpbE2bPETNA6ISMh/Mbhz6sMih9+QXQq5nEc6xuk+doRxzt5NZvaMNSjbGsfx1mvOUqRxyA4eSqZfvDTLbwIpBKw==;5:fEEl0mpPHQm63h+EbQG6q75Bt7XrUas3rL19LAAsc1VM4GS3g+O+W61phkeEtJrIvLiyywSL8gV74tywRdsJt2RrQcGNLFlB+Ujdyf6fymt1SVvZoz7UtGznPd1i8p69PMRB25tOBuarbL8wKrP4GLFkPvy+EUi13h2l+mGDUgI=;24:8vD2DxMYAATZRrKwTEvO2rQScakC/g3dBoP9Fql3i7xKpFpqGkbnSliSlJb9zHz3b9G0gXVZztdBhRk9PJEWWExRfNhbgmCK1kodGePZaqo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:CZpF3j8ut+F2LtSRTfog00wmQ6TQC3uzVY+pNZU0DK0X0gODMoZbISNZm/i+255Nao5Qls7j8Ciy6haeh5cUINkhIB1f65GGMsjLAHoC5Zbr2ttOpjixNpb8hDBKrYqrMnc5tV5hwnOqaY69X75dQfLQQWETIs/iyP8HtH8jgkvYEJf8MeMV59NYDeUpD8jbrTZmyhDLOCb0q9L8EnEacYy9OEEgMVW/B5ttrmlP6HPABdZV7Rp863/pBG55WOsv
X-MS-Office365-Filtering-Correlation-Id: 89442b0d-4fdc-4a7c-fbc9-08d5abc59780
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:27.4481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89442b0d-4fdc-4a7c-fbc9-08d5abc59780
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index d64a3283822a..e6a15ec60e12 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -329,8 +329,8 @@ static int ptn3460_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ptn_bridge->bridge.owner = dev;
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
-	ptn_bridge->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ptn_bridge->bridge);
 
 	i2c_set_clientdata(client, ptn_bridge);
-- 
2.11.0

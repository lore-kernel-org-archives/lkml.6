Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEDNxH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:07 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:5280
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751461AbeEDNxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 09/26] drm/bridge: nxp-ptn3460: provide an owner .odev device
Date: Fri,  4 May 2018 15:51:55 +0200
Message-Id: <20180504135212.26977-10-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:Fl1jGU8kHRawhDFKcabDaYg5Ei1J+C962nFSauxu6RAu+yzhSDodfYPwy7obu3xmiIJaZeXG06RaRvccbIF7KZXpvFFhETcYjxnH7D0RA3b3ptTooONxf9TNYGugQNpDsYCbTiqmEJ3YdvYk4YNUI7nWPHmoi07+Rnz96U7MzKXeYq5l0eau9x+tkgw+JAPm5oKddQH1UFvrgS5KRdxcvwJcjdu1YwPa9gsyqiDX+0aCKrkfBud3sPIwfroVpMfp;25:0Gmn4jI6rXbdtQvrSihF+yJajDlYi1pxZubotTVjG4VKymG7g4Eq/mbirVnJNakq2xfYsMS7jjQkOKeSoEwXIsNDKGAMrF7vqCHBvJOzG6NlPHFmQVm5LTPKXYX0I3Pl1a3nNVrf78oIFbLPajwJsI4SY8rpdYH5uwK1kEYo3MOEr47rGwxz8chOEA8mNGsIjBBD7h05JiY6aj7aTkTshWh6ldDsOxBlmBCsCv/7X6PwgChpjQpxrBfTBoWRIUhxWDnRuiywfhQdsz4m3lDipTiS/WMXw4k9IYmHcrVeH64LAFqGFRAodNTn7/an0pxP9ltIdbHhQ+TPGr76V61cmA==;31:vg+hIwQgL2glZaQRRAwuLa2GyA55oBXvZab7GUgORbLHLQFAWvLGIuKLy3Wnzv7/8X/8mZmZlAURn3r4EIpzPhKz8e35AbZRPSJ8Og78aD25+wQFzSOGVXAPwEBsZGDec/a9T5PMf+E0PpCYlA/DZDeQkq5F/X23F8CWxuOympYNKenFmG/bhkzODjfGKwuQBpqk5riJW01yrJHiWi5EKD4a66QnLIWlabrOITsvLuw=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27693BE9A5050738B82439DCBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:a4YvqVwefhqNGIHMQfRCZc8XTJ97fpSY9J+If/a67HKCJq/nYmPXEeSI//Cd+TG1U5AqXnA81DOihYltX0B10AnRc5IXGab34HI7cD3K9aMJkJt96nuwrHW4YncQtcj4CorGy6MCj5ociYSuWILl18gNo21FldU7YJVgI5nO/SE8gxKTBoI91XSee7Ebz4XhkX+epYKFvD/nAOsDtal6rnSxcihP3DgodPV/ulTNCw5rTAiPgQjIqnnaT71rQBYE974o/woZZ9Lz3i14ayAaiw==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:l+wStWQ1QEIPXTAcrL7OjzMg+O3g0exUhAwQm+4?=
 =?us-ascii?Q?V0937W6NqlA53DeWm3TC0QU/Qyss2C7IbAlRVaiwKHHXf66K8TsheCFZtY3q?=
 =?us-ascii?Q?XGQzXtaLzZ7TKDVsd9MPYxvno6BCNvKbbtF+NW5YiDtdD/ynXzg7f3eMUQYp?=
 =?us-ascii?Q?oCbCDbXmtSWhyXZ586kA9grD1+y33/SL9aKuRobqqXPZrKqln8Hb2s2LKzhL?=
 =?us-ascii?Q?BnrOacgoLQgwX0YSlA36oQyc3ccRoXb+M/Xe6qwCI8dFp+IM0SgghLVLql2R?=
 =?us-ascii?Q?Nw+QV9JVXxY9voEFh/LrZh/WSRW0yiBQuxWvi2kB98P1syBp1RR0A353U4sh?=
 =?us-ascii?Q?hy1ld5KORYIdNamMzkMDxvTHDtauhFzLAWdiMocK/S4rpzlA5K9x/3isYnX8?=
 =?us-ascii?Q?9uqrfqRRMC+BvpTiLFEflk89vPmSQgzWUa5osslbkq4JTZpEQxvv6yOHrQ4m?=
 =?us-ascii?Q?hQS/zMCfZ2rBqiRRkhhRtrXBSeT15tYzlTCYbxWih1+OcxArxsgjW9L9UV2V?=
 =?us-ascii?Q?49rz6EKT3pcjLKznCgvZCZYGbQ2kBIgHh6R6ibhvOagwT/einZc0os6vIplZ?=
 =?us-ascii?Q?7/iv+ll+fV1pkDMyur5MCWrkun+/QABJ5GhQKwBbGDjHWpl/JubLmbNR4gDb?=
 =?us-ascii?Q?dzbNEXQOBD1D6Aq3DIIyJ2ijD/lbL6kdvkK097bsgSi1CE9/0vFpPcEgfZRU?=
 =?us-ascii?Q?hQ+ZNbCmbl+G5cBEqppBPOnOf/7qRmADKFITs06c9YNAwf7ac3flsR5OpiDW?=
 =?us-ascii?Q?BdeXZYL3qdTzYsqi+SrNKYz+8y9d2oGwRFurQmXv3lUZ0Yye7CLYdUldsX+R?=
 =?us-ascii?Q?dwlkasNbNmgb9GemHZPREnNY2g+AohgBPrN8Zl1rjWBgn5UtJC0bohCI/qfw?=
 =?us-ascii?Q?6CO6gdbUOo3V4bMz46wo+G2xmToVS7HFIlNfosGE6ter+eJuMzCrV/N4wOxG?=
 =?us-ascii?Q?oEPp4Fl09Y1tClPIybeYSpl2wMTivlvA3DMCxsDQLSrdGeaKn3KTT7dYNOIj?=
 =?us-ascii?Q?2BQsAyqr8JjudUTT0lN4exw+aVm+ckCg/hitORsfjG6fE31+Z0+j3F4ecA8V?=
 =?us-ascii?Q?ZYNYk6Fo3BEsRKgZfjbkR8TA1XmRPkj+yggrTC/AkyTtxOJmy6g9y6/+OhMT?=
 =?us-ascii?Q?ex5d4Iq5DObN9XG3j2Gn15v2JtWNJigV8PsFjvnP/iBvYzsouvwkA+D11u0e?=
 =?us-ascii?Q?LhLTsdcmUFCRs5tNiAoUf3vpmX/znZfwdeO17zr1AMjydTP9LsOVaMlbd/83?=
 =?us-ascii?Q?/SKmvZRL8XUjNXD9hguoJ6goyC85ZANo8+3NsE8xP6o92vw7IxOzkcMs27sZ?=
 =?us-ascii?Q?ChcFd2YOiY5KV+psoVkCThL9VYRf8PXxgw2DiFl9rpwYxA1bwrtgyg63879g?=
 =?us-ascii?Q?zXPUknQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: WSWmsLPh0jElIIs0XLp9KSIZYxmPt8Eeh1N1OEz+QJBhKlHt7rbahhBxuLLFE0sgVZSM1dj7GZSOe8ZkJSsQNozDIrnSeCJGlfa4y/9EjeEe7YpKsYaRKFIjtXirwwMsmydsqJEkyElvhM7wvjKF+BF3suDlrhppcG7QpNDU7DK2ruw8M5U0vp5wFDef6+tJ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:RnLtuDulIslh6DV0eaqd/J+zcRV2/N2Mh1wTl7PreHmCSzbo3QoVtqys+hlqnQqYLVP6lNew4igA46a5xZeOD5G59BI8tk28wsRixNpKe00zcYgdh/ZvUO44Jprs6SUsJpgyle00ySSKK2aiZ1fAAzFDJ+r/mcVib3coCacEC9gFUi8CmRbVSH7QdlprzjgVqVMcZxGd5ol3SnfRLrbSQQBS/JXM+L9jT+75oJBd6u7mrNHwpq1iOc6DczQIthw1oUm52xXB4OFsX5q0IFi/QBUtR0bbmpSVMF/vao5dO84AtxeebE0mfZY3Q9rrU7H3zP2nsIb6VVnqRhzsBjxS9rqua6JjhwA4yQC+92b7G9fa4s29jIZsC7ihwkdPXesfADCRwIiZIyIS2Y0GTRC8iSjyQ7zcagaRd3lyZa2oHZrFqzB927yOWdW5CS+76+opZoyC1DQyi8Ydp1oiNKfn+A==;5:NEXFugvLUgQNG/JNRSKgd1spTmx4y6qDkL2lWiTxuUvgKW4vyQHSUo0PDmPGmDJwLZqoZXh6mVzgsLTQx4bAqjg4Y09Xi1ZCJu7ln0oLXHGc2fAi01AQizxgCKPx+vMK3ekTmgtW9GXxoA7a1eCewsLfLYk0tg371GTd1fWNba4=;24:gkqetGFedeqAYfJw88DoQwxjiT76Dlz8b2Yo8u4p+8dbgy9ns24DkjbAKsE3bNPn5iA7iNQY8MExaJS8p22EJEDCcUW6FDJDTgDnH4FHOAQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:o1gyF5JhOIeISMVc5yF/OfiSlJt6etPsEO7YsR0mC0QwEG/GZgV6CDyXG9Ux/gfHoH87MHC0OR4ui+43WTb7yFjUavdiP3zVhXYaYPbdLYiIC38ynnxnaLvTUm3wgBtfm91rdnxopYKcHueqNqhRcDfKFxIAjBp0DQC/MMHlNOwzAPxKaBDP0cyWxt/TTrftVTJhPKhGR63CqUDHB11w0B957sIEMN3l/wyowNeqoy3uuu2giS3MkwkiEhWq89Or
X-MS-Office365-Filtering-Correlation-Id: d9005e0d-a8f8-4e6c-6674-08d5b1c65a51
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:01.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9005e0d-a8f8-4e6c-6674-08d5b1c65a51
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index d64a3283822a..fa832f32b518 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -329,8 +329,8 @@ static int ptn3460_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ptn_bridge->bridge.odev = dev;
 	ptn_bridge->bridge.funcs = &ptn3460_bridge_funcs;
-	ptn_bridge->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ptn_bridge->bridge);
 
 	i2c_set_clientdata(client, ptn_bridge);
-- 
2.11.0

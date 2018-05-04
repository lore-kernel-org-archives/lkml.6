Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeEDNx1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:27 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:2496
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751652AbeEDNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 16/26] drm/bridge: tc358767: provide an owner .odev device
Date: Fri,  4 May 2018 15:52:02 +0200
Message-Id: <20180504135212.26977-17-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:mLi6YqkoJFmC02yB2bpRzGgSQl0thf9fYUnGOQLTxpv0yhm/8yjovXG4sJRjCZQOe8yQ+TZNnVvZthKIapNItNFIpk09/hVtRDwrhjGZ+u5VtYH9IDTe6v+PiTrCKQ0Y3SRbN9RLZETvI5nWwn8q2u+xTYOhwmjeBLsOyu1Bjgu3zJiecqxosSVHl2erxv6hv2/5PdQAodHls/RpUjf4zt7TULRAJ2DHHwxB3WeJUIFU3uub0b7lyBrhxLnJ2Ng8;25:4Gp3aKKwCRurNnAMI+IDDVCvB75bbFdpZaL9uTgJ6IRq9AarPpak0auAJoIhMQVYu3WLyX9Qegnd+qhLLhOulJa85DAuYSu3QTZ4gs8736yX9a/UiT9/d5JTAmX+9Jf+Oi50NWVCe91PlOG8tpuIZqUgjvFT//3d6Em7QREyN/OiSGx3V9rm3jF515WPxjRo4+CdjDAlhfRJStuDnR5+0IbrNLhMa0vwNFy96fxYh9Q39JUNQxE4d7Z8+s+kKPby1Xoihzf1wIQkm7D8ctbuD2dsCb8twOl46pPsqKuk91czzC8boIYIrjTgtE9gET7z9Go6+w9H2p0136Yt4uplrg==;31:VvyMl6fiiggRKlrrjP1SKyLVUIKb6OzN+0JDaxFsK2JLgHdw40oUQdlj46Tk2CgQ8oT+2qKA94QkJnskJ44ronehm/9Z6oRh/wTgY2o01E22Gymh9ZqHmx670UTKMz4Sw/NukoAK77c3x0xt0zQYas17p47ATjrMeJMd0G2igLN0DavTH7Ka0ZgEogeC/jfPGx1T7/ZCNhXVyWO0uAEgkhEfTN2rqEM8StKZZugQu/g=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769133484648010B8D9F7FBBC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:Q7iFT1yXGaEt9IzVMCefsqtliZaYcVy76+hzGLrQzktAxa2A8Y7G+Fx9kC/uPMHgdgZ0rOzfisCbCFx0m93SuRcFrVK5KNuWZMTogZAh+0DOlhy5wP9ViiL0zy+1h8COgUKmUcH3Uo4z1kculTbqNzaqd5Qam/51KJGUQtaV8IhfpkceF3OPpnZrMgjolTkf5C6NStPJVS3TbqvNxiGTbSp3Calp6lMAtbautURAfZSIDSQMTqJlLTtiyQyc0w9Z2HYEmzQfMfinzeqOYE7hzg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(575784001)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:AucEjIRYNV/agEosOsv5V+3Kq3CjsejGliH7uB9?=
 =?us-ascii?Q?gBLhGZLsXkVUISmMSqmCFRewpKpAgKd92eMW+gAIEwxYzjqQRRbe7PihEJlK?=
 =?us-ascii?Q?MrodBnlJ82s9IksoYHEo7H/v0C0GY9ZcnT3IuBL++Qp+JtQKqiaMupHutzIP?=
 =?us-ascii?Q?X7UWu0xqw7uvaruezvn4n+evZEZRTjAX5H+iEnABmWg484ac2n7UgkIzroMP?=
 =?us-ascii?Q?s0RkljiB52VerBSzlW4+cxAHs5SWN1BLQ5hNi/iOgV5Fi/qqUldIjjXT3Frd?=
 =?us-ascii?Q?LF4K2tE4xuSikAybuXo0YyeNr5CxdfMGvrUkiaMP8+/D5+N93YXEaGkR3oqr?=
 =?us-ascii?Q?maOZZzKjtrc71t5ZPwkWYimdGw9nDfNHiqdYb+hKxxc4zZgkX+covG5gt/wv?=
 =?us-ascii?Q?JUYqPelkDOFBjSMiaReD4B3ef7OaaonwyiKfoB1wxffhBPJSqtkkFe8naj+5?=
 =?us-ascii?Q?8r4g9l4IrPzst1JitSf4vM7JHxzCqcV+n7Oqtp1yPKAJrpG2GbiiwnsCcN+x?=
 =?us-ascii?Q?/cR89nDOt9ofgHaGC+LXidur4wKCAdu9sUW/d2NF7A8eEdCHS3OkBVAZm024?=
 =?us-ascii?Q?6r6XliniwPCwrNkqbLamihECOTNjq7jm8MKfOAgHqAGBxSIrrRau0lr/8mVV?=
 =?us-ascii?Q?Y2M2ygxlmuO9Cb4TL3aYQJMD/kYfdtDhlEymSjhpUrJM6WkkuNswcD9NvJoJ?=
 =?us-ascii?Q?3UAnp19SZvPt4GHZRAsaGwhP3F3G8RjNO+d6D5rcSWP0lGsjUxRxkBgJJ6H5?=
 =?us-ascii?Q?QPQyILk78c6a9/0tgexbTC0lxJrdAAiu7rrZ2Sl53IvI68nN4aNjkRC7NZ9O?=
 =?us-ascii?Q?bFWoExG6ICVaV1DcnkFES/rnKDQmNYF7ujJLf8e4euhFwDK2uUuoUxwDvGGo?=
 =?us-ascii?Q?aQXC1a6KAbHduUYaDY+akQ28+2HJEjJiTaxHsPX+EvOV6e3cn6BUv9YEkI2Q?=
 =?us-ascii?Q?odoKW6ihteK511QjfrzToDFK+xaXja7ABErj2TZ1hoZcmdo9NbGDhiHkBUSs?=
 =?us-ascii?Q?cJQQW9Rknu2vW8zcZLGsxHnwMF//hWV0E9MnC+FizGKwoUvKvo2gsx877JQT?=
 =?us-ascii?Q?NLTCZstUpn6uQ9YjELbcbPuVKq2GRsv/bXYj4JwLEhFG3Ur3wUW8bqSd+86S?=
 =?us-ascii?Q?PiSDA3O3uFww+1imYC9Qv/LmCMvsp4UOkF4iurN3vcoqFQ6OK9frxkX4J/lJ?=
 =?us-ascii?Q?9XN9DLnq8ymhYjd8RgANai25aGNEAxixDAL9ROuusqKzHcxqGmFE0Dt72Y8B?=
 =?us-ascii?Q?Y5tnt7cQ6clxVMxBrS+pSmlXEW0rtr/6GzoBRMKOpMY4aoN4JCwc+gTspSu5?=
 =?us-ascii?Q?gbSKpvPbNGLpbx7W3GgO+H1EPY0aMHV/f7TBLuDAdwydsZaqVxypwgskS7AR?=
 =?us-ascii?Q?0KyjUepSggBfr0TUCtDWOoJjunms=3D?=
X-Microsoft-Antispam-Message-Info: JMKaoQnTcIa9X5rE/EmOPkRp1P860nWqyY+q4QyRCnZr3EffabsNQrKaMvyS+MljCc0g5WL5ryLZdFhDLySDYjnyUZMxODRGbJxA4dfZ/iE3AkLRpj+x9IpbW1Bpeve+pwhTteYfBbX7SnczJfqTZP27zl6ivO3rzsWw3o4vyNSQSkZWH4qe6WD5PmGxgonB
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:xgTaHW0g+f9IcW+VUCTZgJ+go2jGl6+v0mFj3szzqICY/1S+0IukTY9v1D3d6DjiVnhTKm2eVnn19M7GWOm1dT409VoIE2nmh2JWlAi9KHVPieyxZU+PuGC//5sEbAHAwM2Y1pbwiTYWU3aFodavVZOxOF48wfzpwAIj/ohIk2QwmrKUJaSMQW3h4wn6NOEULkoloIQ1WpjaOGO6qpQWDg548jPocUG8zzupU0cALE/ELYv4qo7Qe5amWckMWYPwm8WVAv7tfGX4hNALW1bsXQFzyXG0ysFPVLPBPx1DlRlj/D1/nAdPLkNjOqCNem4ItxER6eNVNy6nXxIau3KLR5M+khiDFEETR3WFOzRWtDtfwdhP9D92yue5tTdpqvfa47Yuh4YWFoYZLeD4lx36XTR7SeiBNCqiCHlbkSStT6AimaJMwV69VCqlaL35iKEzwsDqt6v16LIw0V2cffWePQ==;5:Lq5X7LC0vaBkEzZS9TjjatdeNcTzZKQYHX4dF4PXMAFaO1hYIZwWjeHP5pLKXwK+irG6wMUEXv2Uv2E14GHIDyHGYeyUDFHJLNGs42/TxILdl5PAnO6bxjLVr3pLcM/1/G5OyxwlzdceE8Z39buwHY85rVNhJ6qdeFUMx2D5zcM=;24:osEpELKnIpXuAYpf2M/LbCrLDu3BQkv7hrItFb5bHpZ1mSMXQ5o0cmHpwJyeL9Az91hP9NaXIFbhUJVt66V/eP+fCDAgKUkCqn6cZTGig9I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:4cgEH7xM4fxXK5TjHdgU7P6k3aSiyKeHgO0IK/xxKJWZNqGRqDem905Z9qK3tPUmQRMJ0Jdm5LxxmqblNIlaHXLiyQ4TYB6KzurucI0Gfo7FHDYGpbdFeKUI5ht8k4yzDZ5kqrYSR6wJR9CTOiV37NTripmoFLmOIHaDYuSUB4C7NTdb12rZ5X6GI2esIAreSdsGC+plYBdD49PPlkuUAHbvNUA1uviv4xCdNNZpF2V0EdU5ZjovDs+QsfrIbSDx
X-MS-Office365-Filtering-Correlation-Id: d1e75b5d-a994-49cf-be72-08d5b1c66639
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:21.2879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e75b5d-a994-49cf-be72-08d5b1c66639
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 0fd9cf27542c..75f93e1d0bf5 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1331,8 +1331,8 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	tc_connector_set_polling(tc, &tc->connector);
 
+	tc->bridge.odev = dev;
 	tc->bridge.funcs = &tc_bridge_funcs;
-	tc->bridge.of_node = dev->of_node;
 	drm_bridge_add(&tc->bridge);
 
 	i2c_set_clientdata(client, tc);
-- 
2.11.0

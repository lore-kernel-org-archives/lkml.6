Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeEDNxX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:53:23 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:48365
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751652AbeEDNxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:53:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 14/26] drm/bridge: sii8620: provide an owner .odev device
Date: Fri,  4 May 2018 15:52:00 +0200
Message-Id: <20180504135212.26977-15-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:AN9vlMtg4khHYX2NRoY33Ml0FCqOh6f8AEkf68ba/PWRYbRu6T7IdMu9ts7aJpIP1BrGpCZs7sb8s0QG0NkVlSC/pgxZmzcmNeWHmKc/gkNZLk7tt1WJMSVtt40LWwClWsBoLGMflv1wFlc01JqYrL0BlHXRlM92/kYsnfjkREKDVDUVq+jqj7dRIQ5wsOVNQ0Y1m04Wh57eojPoZnlXA/YVw2EX3Jl/uOQU7++pifcijoOZw5ANgjgwtm1kOTY4;25:J6EeUXg3HVKKlZAkUKbSO9XjD33iAx+mn+AWojHzAzDaOCVkOixSzDDI2EURKZv4iBoW7o2d8vP8h/da+qwVlf1zdUR1dbInFJD98MgMCW9pps2uknil6aJFMPBpCOMF5wjTHukYgK4e2SWq7RhLvDzsHvKbMGTHLE/+NVKYWV8MJByg2Zm91uPwYVMVhMsnoB0hJ3Y+5iIA4awlIS8dnWIkU9UnfwfV1yj/+aI/twpzgiYYYZp2/+gEpsj6LGYucrYQENMHSFOdQtOCqZeieGGJE427bUcHlytZyiLml48peVkei87WXeqZTRi94NPUtnOlqWzIlz/BXSDBPUCw7w==;31:UZ2QyFc+ad+W0DIDCZSWqqM+HCH4qpBpzsjPX+ZM8fPi/QAMEWV7Ie8NTsXZsScFlBVmEktHqDOKQqWOBD/jbFAKU3vTjwca2FIRLmya5MKWfm9EqWsLEt4GJJQPDvVvsp2hO24QzEDrEGX6VOvky5PrKi4HTGtoFWeuPGbHjNuyqXkHNf20sPqXPwYyGp0jpwxvcF/mcXas6yZXX4QCRlZap9iTzpGfhijzpt2Q/DY=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769EF8A62C8DD06CDCD6B56BC860@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:aCjHZtLqestwLE0Bn3zDGpyJDZOw79Fl9D04ZwZ0g/+Q6SEPgDyc6K8ERLAxOUa7K0OEWRhLPZQkXfiZdm84HXME9oMlkJdCgfbpvV/iTQDpDELmx9JvDZoojFm+LHJYiFGWmmYTUZk+iho2KBtdZIqk/JMjv0+K04SmrlJcTCfO5WLyspSNwAefXI1DajpN/13xyz6VIOc6kx6vR735vJ0vOCgFBQMRgjycr7uSnQO9I+Ad5NtRJVyinGZhCyLJk436jkrKX4QvOFzOZ9TILg==
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39840400004)(39380400002)(376002)(346002)(396003)(199004)(189003)(52116002)(386003)(50466002)(305945005)(6506007)(54906003)(74482002)(316002)(68736007)(5660300001)(16586007)(6666003)(50226002)(7736002)(8936002)(81166006)(8676002)(97736004)(6916009)(1076002)(48376002)(2906002)(2351001)(2361001)(16526019)(81156014)(76176011)(4326008)(86362001)(6486002)(6116002)(3846002)(53936002)(106356001)(478600001)(11346002)(486006)(446003)(36756003)(25786009)(51416003)(476003)(956004)(105586002)(2616005)(66066001)(6512007)(59450400001)(186003)(26005)(47776003)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:GDnLcqSbVqtrUVN1dU/zl43fvAKsWJW9VwCckb1?=
 =?us-ascii?Q?mz1sUjwAcs7dKyZfiMhLFY0bxC8ZEoDtBuSl15wBkCH0ZpcXRKxMba70S4Zs?=
 =?us-ascii?Q?OcL87PRH2YS3HzdIy7/g42rF8zSf4LY31B46WNT2qgmLnQG4jWPSeve9Mf+O?=
 =?us-ascii?Q?21MkVwrP9rzu7hqhJzXGdEuGa/kUAm7XL4G0N91bVPmDVBapGUnTiH5K5MhP?=
 =?us-ascii?Q?7Pm2rOXPO5rjzFvLk2gBooTMWg92MRXrgaJZlF/0A7/qDts6Ed+7Y0alC3Dz?=
 =?us-ascii?Q?yMcfoWlbvSHrW/EuDXiRIAiaADn0f4wz3r+nnigQX9L+pTkbDfhUpLfH+t/s?=
 =?us-ascii?Q?+djj1jvhRSMlmJVJygrNSUEU03y/3d2p1Lr+dqxlFX3MfMQr7s1e+nLHp7o3?=
 =?us-ascii?Q?7Si3ewJ/Jk88MUu8wNvp/aZBAVoJU9vknt3jImJV5JGN8Hq8se+5EeNLrg0L?=
 =?us-ascii?Q?6HjA+1DQhWmNSvBu9mCwdXLwkyXCxCqgfN7JfariVqnDEtemYMcGkIVy99Hr?=
 =?us-ascii?Q?ERvmQSN3v9Dh4Q3vujn8kMmLcVsMFp12cunK2wWlxYOguE2f3xF9oPJqAhwh?=
 =?us-ascii?Q?eCyEIamixQ8V7pmO7z1nptL/f9gU81gbZJIxrke0qzCycmjHymfSHupk1uTZ?=
 =?us-ascii?Q?+6voQfOe1SD/gUL2Jnt8qA8LUqk4KU37FJDhujqgIaN3Yks+EcRH9/lMt9gx?=
 =?us-ascii?Q?gC6meh6631f9xvjhT81/nOAA1Rsz8LWNRlxnQQGv9dP/A8ZmhB8eGHC7Cgjx?=
 =?us-ascii?Q?BnpyJx74WyXNSf4kCNh21cPCkB02VOGJHDsBE9WZw5c+Q5E8P3UVT1ncbjAj?=
 =?us-ascii?Q?rDjB5nvTre6Z6lfJFfgZ6In75qtQf/bDr5MyD0S6IxFSg5TyzoJZ/rvtD3+o?=
 =?us-ascii?Q?b+3IFFja5EB4ci8qT5DeL4t+FzmQ1hAY+yFOuqp6XQE+UrhCR9BAoEJ97Plo?=
 =?us-ascii?Q?VvNcvAOtQAmsUchYaZBd94zlS8jW88pkbVGvSrdP0+BpCArRO6CjIcayiCPQ?=
 =?us-ascii?Q?vrYXi3zYBAkmIG4/4gxFFiAi965DnkwsBoHcLRcz4/34WpBs7c2D4qd/yUTn?=
 =?us-ascii?Q?dCW1Sjelo2in0GZnPEeZoF8iM0JUD4fdVVAmFFTAWR/I0qHELHrY4xhmBVBa?=
 =?us-ascii?Q?3YnkCn+qxHApSSZTQ+DmAKtHZTd1N9WuAeiSssvK/Yxz0hQhU5TxE2M0j8I9?=
 =?us-ascii?Q?E449GnaEXquCSoEgpDcA2Ew+AG6SuzitwxkM6wn2GyVyKsFzdEeaZvs0u2FP?=
 =?us-ascii?Q?pPFlpTpHCJQDHDDsX5ZqT9Z/POYTAf4ELEacDQlFJ+prStiRYhCvh/6ItUzN?=
 =?us-ascii?Q?qagtAeCpKncAUZe5plUJU0PN61KIFcl0kcG5MGA1REP8aqm369sTPQStO77m?=
 =?us-ascii?Q?OKG1TjQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: qGyzIYn0Vmttr6Ad0oW71zoJfDNwmw6jkNRlr9qXAoFHZsMo4Nagx2qA+Mya0riRh1APTntDQOryOEj4RGCnMFqqYbK/19LnhSokRZqoUW9weNXeMVExX5M7p9icXTyoRMfzBV8Ng2mpSVYlQ/K8uegjFR+gzKphcqO+9MyWzZ2KxUu1jAMEPbh9xcGY7JtQ
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:Rz6O637ZC8cArZJgvCYlOdiOTu/VzkMsT/xr17XgcMls9gtMeGPU/jYvFDkszZPn9t8N40W7SVFpocYMpwznSfX9I6djGn66h8zIm9RumlJZ35NTM8QlhmqiQZPdImEdHu2B6HH9BJFYVRYo2c9IHr7heC+tFwfmXOd8tUzbUitS8CPNPIU4R2GLb52A4/nnHKshjTleltU3mpWuOecqOjVdFkhdhTM8DQ7d8gn9hIGGwEubohsnEYaeimN32wPp6BpkwUFhDWlss6w4C3BSD48DF7E3DaMXTFMEX7rU3fhaYTcTZqGNrClhmJLstaEck+Uwqdru/jmNNQtT5I8mX8omSP+YJGN4v6Lyb6BKXXcCaRso2XUqi0SMxTZdhDg09srd5bg92Grlsw7rUpMiZLrZpjl9AI2uIxCS7t+uyOqj7R+VMDGxs960Oyk+DMwW9NoYj1xKUHKuINr1sXFXOw==;5:4y2Oe32MhxkuLFr5dSU38gEoqH5TN04JlrmDOGuCdtUGSCzEUd4nYYEnSet4AVmFek9DJCWAHP5RP4do0Xgx3gzIPtoPN6ThY3nbt+bT5fHVjB4Rx3YQpJhdHP8KdS7A5/Lh6EG4z5Cumq/dW6mKR7L8UhpTgY8KdSuQOf/zWIk=;24:tstleW8eLeVGPZaZEdkTnkPSO9T3tjAGtz7aVhgCT3iCWbxZqSAZBrS7XmNfQyS+eMqjEfmYQCTAbXPG9pBlgvRn99wZz8VYUzOGyWcMgZ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:773vZWKMLcxDSczLKfADLa0T+mk2rdbxjr7ZxvxwwaLZb2mlWlCDQFbrucg2fgZpfcBBmlW1XR0KGH/qDPU8uII6AUQ9NQLbjWq2IN4k45HVCC+5U7JwFtaZ+w6rDZ5cYNJZTs59oi7k4zj/kygtvKYdc44DGmb9/2bZNFXObmiq6tun3EklDRr3sJxULFNCjR11jD3EAnBUzRgAs0Osa/EU81obD8EQjGycZSLbKayDZSKZ8IryWUNV6EymGlHo
X-MS-Office365-Filtering-Correlation-Id: 1878ced4-8f21-47b1-7925-08d5b1c6631f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 13:53:16.0875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1878ced4-8f21-47b1-7925-08d5b1c6631f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 7ab36042a822..8e35578b0488 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2387,8 +2387,8 @@ static int sii8620_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ctx);
 
+	ctx->bridge.odev = dev;
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
 	if (!ctx->extcon)
-- 
2.11.0

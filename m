Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeEPKTc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:19:32 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:16256
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751904AbeEPKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 17/26] drm/bridge: thc63lvd1024: provide an owner .odev device
Date: Wed, 16 May 2018 12:15:01 +0200
Message-Id: <20180516101510.13215-18-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:tQvSpuD+HTsJ3R6e3AwDwv5lW/dRDGp9ZT5t35nFQojKhJOdnjmFKnIft7n2OqqhJIq6UQ5N16/Z1104X4ceQiIAUomY+dUeXEcCZFSHTXsJXlMsfy/nmbd6ga9cE0AmYZysHBEdmO7gtjRAYD8oZgA6dEMDuJ38deupWajIncutMhHpkdx3vBxk5GEZygXhQ0JecxvOHdMnjkmN8GcTcPv8zZxCn9HBUOxTlsuWmyJqphXlT1kltUVTD6kRrC5N;25:Z1EQ8MLy3WVY6f0bM0HShiCW2xYZCeKTzPMCN2iri4ju7MIYx7mpnYiowvW/46Bx2TModXEi2AI3p3TzDFpMJd0G+vUXxv8MHrkRBHzX1BqZcByB3ii0uGjqoxxdRYTT8ZD6xwCzoam72VE52o2PzBm+HhSOO8IPOfrDKlBqbeyYDLNfvIKix2+k4ygo4/iYi2HU+Pi1B6WMT6GRaIyPE8WCA+4e3Iizurl/QkyZpMzJp7Z5Ifhq+8K13OzGdTqjFDEMYUkLKMulDOG6eAx7H8JOqw8XoCo/6iW0mZPK8DIvIaKAmQkEllHB9+EqJmztrCtrzjBfyNoKr+nmmma8Lg==;31:aFZ4vSph20b68vJl2JfDGUgFQab0jk2Hxkx/PnbhXJ6pRksbu5l9HqJwpv71Dl+U/9Vv9BWgNXqoXyoTRI7/mL4QCILBrs4hq5ekMQJilnaC6kqfJSQwftJfSs1g3xionHtNpg3PQC1RQMXvdwmildRAtdrd/omTj8lD8bix0bVp0xzUVqoASCLrln4gqYyBGec7uQ6/BCJhFGyBz9TFB+emeZTrgjm6etw5K+xjK4k=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27721395E1A9B6658562FDB5BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:CvfrKzTMmEw+sDxV5wJ2d9MlUSzV2s8IzIwnQ7hwHGiqI/I3fvRy5jgpdGB8JS7KTwk5hDtO3/qewh9+4eGnUucUrK7Mqn4IvGbCVcV7fIyRFp6RINFYpDQi9UxqflOqvOZo7zC9fcLbwMDTJnejtoENfIrbPT/kYM5IQ18jcUZRsONwqvxCKpSjFSn9z1cC5jXsgIPZWt4dH0H9vMgfw3/8Fq2KCyUrEZ2Vz57DClswaxOG7Y7swLPawvyUYR2JfzkqvSOZ7ICscxrcFXc8ng==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:lTwaZR5kaDZf5N3Pj3yqzkbXODCD72b1U4WH1FU?=
 =?us-ascii?Q?HEBqklK59K+Cas+D3U1x07an6c7deHpROQ4obtt/Tm7J3luzRWDqoyCaCd2O?=
 =?us-ascii?Q?4TyziJFi47GAe+ipXbHXVodGYNaq6rKSAF1frpSn61jcyToA260buEvK0ljO?=
 =?us-ascii?Q?DlxiPxj8SVmUZYcX0LgPuBiJ259hD5z14Ee/+S97Qu2cCj2CnYsBZm/M5WNA?=
 =?us-ascii?Q?F0f5ldW15shY8+jiKtUJJz5yHFZAWdvYef7TFN6wxdsKlDwRblBMsER7xvaw?=
 =?us-ascii?Q?/MrLGeW6zVabca9Jy0/rxshps4vYI0HCZiNhnd3J3rgmawHHOPWgo4jB5ZyN?=
 =?us-ascii?Q?VM9lQWbmAt7prfw0vaY9/p4P0rqKBsBIuklwXqy6olJRQ0lMiecIH+7JPhV5?=
 =?us-ascii?Q?dSDEoMiSwDRAnAm0sj3UjDviMFIK71LXHvo9gHzY7OUl2dz7KnRJMm53Ky//?=
 =?us-ascii?Q?HvSowLLDdZuFac3TQcg0IaGUUGgWg2NrN7NyTct7rvDYxf08PxMsjxMvFPPJ?=
 =?us-ascii?Q?m6QGx7VqGh3mgEL4enY7dyAETGefRlgCrGzHZD0B1SUNl3j4CUkAJGysQzXr?=
 =?us-ascii?Q?UXuP4byfLPdARgeNbzZUM04yZlVR0OsfyQN94g5gYWtZAvtyPNWrwKMoJu3e?=
 =?us-ascii?Q?Y+91A5fTLt9CwKFjuKek/r+1zvaj1/b3ggg7hmX9ms5EyjqxeLj4UWLk3zY3?=
 =?us-ascii?Q?8QxF+D9Ns/t6TgspDsX1w0sCUOKncT4Q31YigPrZTUAWtU7VU6tFnxIzkMNx?=
 =?us-ascii?Q?KBCkx51ph1Wgsngmbds5vALmhGivnYo6gwT9KDKuhLNfd2L7DQQc/fXRkugb?=
 =?us-ascii?Q?XG+k072BC5fBPt2D8EUPZ0QTpnU6NZZ7DEzu8rHg/ZnLnTAngLcRKmZX8p8D?=
 =?us-ascii?Q?58dCigRxNQXW9pyZMlzr5622kS09O84aFItPMnLzVxIt0p3xiot9H4kJQU1N?=
 =?us-ascii?Q?Ly1b+7lCSbYnGGPmufgghz+IFOBFh+CVEaKM+gnrn+uIDhQxIqUMtmb/CoCy?=
 =?us-ascii?Q?akwFjfogqSbgqEuu8X6PbucWza+i5maHFwIiPB/bv578/uqPGcVhJyfyrgtQ?=
 =?us-ascii?Q?Mit4nlRg6yIgUrB9rhxxIOzObX04uEWR8JuwARQtBpA7IDH00aEmw08inung?=
 =?us-ascii?Q?GEiAJEWJMfKFMki0xLxSE/uf4nPQw1IRCWgoo/Xo7R1/mtX4pD+7knmkhhfX?=
 =?us-ascii?Q?NnW+3UJ+rPL/Z78N684OVhQjXRhnHdiJn5wl8bEsDryin5JYVgKDFYMMU0P/?=
 =?us-ascii?Q?clwxitkdcPeBUpGDkar7j1FQTFBTSLLuu+O7AdQYNhP/l+ID7OVLODLGS2JT?=
 =?us-ascii?Q?Ce47ZU+UfmMkImw6Y9y7apzzl3f8H8Yn5Xka8eo1f+VZ940sepuIAq/g16Ib?=
 =?us-ascii?Q?e96C6mowQIg3TjP12tdvZigsWAh2iJ9bnWxK+z+wRe8LgEDUiUz+D8De7rx5?=
 =?us-ascii?Q?Cup0Fk0RBEqdSjQQTeYZQl9BaJafOQHU=3D?=
X-Microsoft-Antispam-Message-Info: HP7wTog41odolpdbn5n+lHRdNCLn6yC/zR6O3IkEfFilO9ttnGNhtbv1VDtWaYezTFx/AUjoMw/7jERvbzXoQiBYqb+XgjCm+z98eYv4bBQYfHJh4eMCr5w2zk5dhAkCSyMsj2+H8Y4kT3mRUh/bRv7b9qDwu2rBHoLRFa0rOOMIcXAVwef5AcGADhYaOdpP
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:4H/ql67IeVYjnb7cv2ONEpWTv85U0Vv7hL+3MRoqMSX6A5DWN4htCBjD5YkzOE58B2mzXOUOnB5UlsamAFW23mc9Ty3AEiETu2P//5mODS9vs3ePW+7I6bR6Rd+Wog0x3uHme7319N7W2KlRxyMFiPJKIUkwydnu0ki8FyvaFsFBvQh4EjVdQQC2Kwmt654kbEWTdUcrJCRpxcJtIhvNXQGiJhSrcFrYQBV/bpsuAU1QRRq27sM45mgxz2sLxhcvUF1C78JJ8azRrRUjfFn8ted+HkTgUNKgASxIuzoMKQLijvmqu+MoITFwDDGrPvE4lJAdRWFo1mi8x7tjmhlPsPA82UR25radhnK00GYoA4YLofIh2WMiwtE/yFmxU7JFpMfE1t3chONXw+/z0SWVEQAc5G3uVwkdZWFA4MMuYyl39wlbsszXJS5YBnZUopaiKoBlODxkCRltqDGAsbykXg==;5:oewX5PXoxmyim3jm0K8rnyix2anq1XZAPtGFyeWa4HpbzGVCVVeDDc3z2nRE+y2DebH9FWyrnUzrOipclcpbAV7AKdgipUq46ma1eCVUam9hk7K8iNom4W1ngxKx1l9ARdO3mBhTW7mwL47ULnQa0iy5+jJJ0v/WeS/h6GMaHYQ=;24:joQYknUjIVGMCHPOcc369uXJ2tPMiwYMV2HQbqiY/R5PQ+X7YiE0OiQq3+pCc7jniA841DQFCFgC15xEtJMeEQ47o71+i2MOpJ1+lD+cL/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:JJkNbMy/Q7YshHSa59fVTQHgo/028OCa/epgx87aeLQhBh6Gh5JTz8OdFlDtWtpepMB+HVMgX2/1NCrXO/iP38aQnmmldQzQuH2m8/JpB+49RvPMU+mfzaFg7+FmQG50weykt2FH80fBZUYmHmz9m6Nh1oPaCpS+XUZJyU4PBOtQpwKLa1yyJMYDW6iHbpjMVOKws/GfIKZS1Q2H5hjadrjylsZgDppQJ2zANlNQv413BwujWxqspsyYlcG20Epw
X-MS-Office365-Filtering-Correlation-Id: f38c8fa0-67fd-4a5d-87b0-08d5bb1612cf
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:21.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38c8fa0-67fd-4a5d-87b0-08d5bb1612cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
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

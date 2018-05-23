Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeEWJdv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:33:51 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:55616
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932163AbeEWJb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:31:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>, Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v5 4/7] drm/i2c: tda998x: find the drm_device via the drm_connector
Date: Wed, 23 May 2018 11:31:19 +0200
Message-Id: <20180523093122.27859-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180523093122.27859-1-peda@axentia.se>
References: <20180523093122.27859-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::23) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:2Er9k/pyAihIQdhBFmV3YKyd9w2RSY+8di16/BPi781Yr9WRLdCLsl6T3HB+/d6wUx5A9plQQ3sMGOz4df51AyKf5sRARgiE0m57u/I2UDjNP8rFUDXZF2RJgQjF0ESwO7xF8Z/Prk/ojKOQTlMJIwW6Ccyx+aLSE+qCkqLrKgdHrc3H8SDgvvmHenrAfHH+BT/Mk2r+tGxVUCe0b+5a7M5eTjc43LVso+uJi+tdg6XFNPI3UB4R+T2cyab8rGYF;25:FsPiNfNXp7gfoJ3gKNIAv016ZQHcSbgPLhQ+VbNmNVla5RU3Yggo9Dunre+53S/HXpGGS0iEDqeVf5lX5s/RHV0F5Zi3WmRtxWX2RzkhP/XCQW3MGE0YiNsRiLdhvHUMJXjPlLqINNBucEXELrwMtebjbbZYWFcTuyldjRzdA5ReyfJSiCgtAZerLj/QxbwOv3PV9yRFmoujz04x22TfjgEELfbVEVEjexUVcW0ppRlQvVwvrCH9DoDEL+ukGt2lnkDauQx91tC6GPzNA9z9Z3mj/FozsXtw5I8zSQlR6ER3Zc0QFubdsa7/oUwfYGvhrPBBW33hh28CtF19AAobaQ==;31:CsgtDu9vpRjioaOIKFOaFWHayYzVJMi8fXkVS1AfVcxq3PhF6LWPl1q8yGZqAih0azxskGi9LI4ab8lMEA8VlZO0Eawn9rcIpyEJaLUDN7h0vSRlBglRb53K2+KWw9ZmXewR5stozMqVAkc/atsgf6f48xaU0ewtKFoihYD2Imrz2ugu+beBCiVcoAdMgkJu3s4LQCkWng9COwoQot5r5Uj7eRUA5bWZPRZK255dzWg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782471984B4F6C9E94466F2BC6B0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:eW735mbI1AH+pTMLMo3Bke9rRYPfiyXhdDd0a5V8gYhf14wVQs52GAaoThOkVUng9FU5AgCl2Ed2cXIJAXQ4ZwiyEbGisOtc7Kulm0SlCD+sSyuBpJSFTSuCObP+GcVehS0zQGMaTYK/USLCFN4xevBLjzZpKNmqsqCijcBz2XdXkdEqSB0Eugdm3RqCJZ/xs15Kp1+a6aGSwvKDs3ldqNeXqzcCHxyRqO7ybjL+V0QpQpnxLmqvsmRBe0FJQw6orBeYLc9KZqEhPM8pq0JzUw==
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(376002)(346002)(39840400004)(366004)(189003)(199004)(486006)(68736007)(956004)(476003)(3846002)(97736004)(6116002)(478600001)(2616005)(5660300001)(6916009)(6666003)(53936002)(2906002)(4326008)(11346002)(6512007)(446003)(1076002)(36756003)(575784001)(86362001)(16586007)(7736002)(59450400001)(76176011)(52116002)(51416003)(25786009)(7416002)(305945005)(8936002)(6486002)(2361001)(48376002)(106356001)(66066001)(74482002)(50466002)(47776003)(26005)(316002)(6506007)(81156014)(105586002)(16526019)(186003)(386003)(8676002)(81166006)(50226002)(2351001)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:SQlPKJh4q0408FGKzGc28jEI5a0ohjs3GMYWyMB?=
 =?us-ascii?Q?gr3bhAMrZAUsowiEMIkkLjXc+iYZF70C6EtUOgVM5ng6gyGwmX2hpIOTg9Yt?=
 =?us-ascii?Q?UpZCzb6GjEmWiqlF192oj1w/o4oDGVjBfYLj/kLQYA5x6njVjIO8mSrU0jAV?=
 =?us-ascii?Q?wo7KIWS6YYNm21ppghwKXiBh3UuVKeidbiANkuXXXCDNPGILs7VXL7K/75ZY?=
 =?us-ascii?Q?9JxdWEz/ESJkGxuG9xnVmYYT7FfqBVQcQVj+KsasR/PYe4t4IrOTsCQ1fQqG?=
 =?us-ascii?Q?mnYpG7VqbDJ2/wCU5yDnQ+XKrE2Rmxw472Igv1o92jDfqZvGNJMFx+/YkAEs?=
 =?us-ascii?Q?F22nKOtoy4klYNG+UBKGpVIo8F353n/fiUD7MbM4Zd60J8luoPf/aSHZwJST?=
 =?us-ascii?Q?ZXDzCoQu31fuORSup8mGyU8gVN8F+cxhEc5AQYMIsPQoXPeMX4Ot3BrNKJes?=
 =?us-ascii?Q?+I83Qu2iwSb4ZU37UOSrD4JsUFVTz86pOH7gdocQj+mki2J0FAso/gon0m6G?=
 =?us-ascii?Q?kGQmzMJGUKFvObNerfho+i7kD5TWqj1XVN850WcAEHkpD+uIM2isoMRxiKMp?=
 =?us-ascii?Q?M7XEPN+ty5iW7rL5sVamzZiRZWQDoF3yyZK6+AtXcLI09haKTFR6iVA5kGzX?=
 =?us-ascii?Q?a1+bgFn89OFk86STAdAnqMobiXnZ7o/SmUmj8NI2VbF+pFP+I1+5vIebQaJN?=
 =?us-ascii?Q?thDoDVZkOZoXRbkJhr4GJB3owb4ETaWhJYwBgK68n9R0ZBZS7OpyFCbtcbRF?=
 =?us-ascii?Q?Ch2kiS94qADuSheUnjeBgVu3/CZ5mPJ6JS7gwql0bo8Cg9/yDPonoz+QBqQa?=
 =?us-ascii?Q?sSD8YJnbkSVkObLhckkO/vCYu+Q1Myb9h6Njj287OrdVMovlB39pdyN/fRqC?=
 =?us-ascii?Q?lsG6CPFnc1GVKnaMEgE8qCT7mmyM71uEfCaDNcO2RpuBcyCJew9m9Iwx2Kpk?=
 =?us-ascii?Q?ykRU7JWnYfD3YtT//L9rwa6M4ppKkGaXIsmmLyjNqJl6o4TS3W4XVFHQiY0e?=
 =?us-ascii?Q?r9iWwwfIna8ClqvdmCs6gmeV964zXd679esWMhAP/WFF4PnbF5YJWdhT1Hnf?=
 =?us-ascii?Q?tiSPdBYmt600MQL+mtGLNJXMzI/gbbiI+bMB39cqEoqjFsS1lzfAp16s5MKw?=
 =?us-ascii?Q?rNDcglMf6qCnZqBmbIHXc5CtPjuviRJWv2sCCzNV6/ON/7bBsHBWrr32VHUn?=
 =?us-ascii?Q?SlGvk1m/lapwFtIesQD+QlqMgMdhPv/kFhJBlrmtxj4ilXqjfFNNmLig/Qkf?=
 =?us-ascii?Q?docUSRaSmnSYKkc7hDZuIcwYt9dVylnP48yacILZ8JB7tVQKbBwk6E2C1jsY?=
 =?us-ascii?Q?R+4cfv9ZY1/fTV0yU7GZcT4Z/n3CcHo7qx9nbuGmT69ENCSUN04hCYFCWotV?=
 =?us-ascii?Q?bn7W5fRAOJjmLmSedJ6Cuy1o33lg=3D?=
X-Microsoft-Antispam-Message-Info: PXf9mHejMc23jVMrUxMfyhVnFV/6+UqqWKzeFgpy/na2D3vRmx6UYm5VLl/sO/ho2PddjJA4+lWU7/oQkpEu180IErMk65CwRKHcL+itAG7uRml8RnEKe35g6qjtxlPX0oDlniWtYdFW+RLmYQsRLiPkFSL98Br8IH4thSpGxvnA0K/sWy0loJjvOnuCLCxR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:lW361n5I8KuHmaSS1YOvrWWhsmYO9TW3IEwxzb4szBetG/elHWy/TACYr3y/9NvB07Y8e+PvIJazeeJbgyMo21Bxqq97FEyWkTUIagfWOq9gnt8NmFeqYViPyM/Lp60xnnGNCr49Vqg2EoBEOOqLMiqB6Ng1Y+MzwCKMpDyXndMgu2WhhcNjfBXV77LrHJtzMAhoWK2NKuy9SP550Z/zIU/P/hGUZFodf0NbL7xAjjAD691F1Mrw2KF4RG7xzfwjDqQOLUYw0M0d76HOhx5BxeT9GKJm97uWNeNQ0v7PuNO2iw36g8BNjUS5FvvWyO5ZoeCMgcdWw4mnV+Sli8Ne9tdZ3/UP77FDqXCDx+WkwkttIMs2uRQo7bXjR9+Igs1qEpJHQiehaP9fiuzqQyMDnzmu6p5o9WeLwriwBJpmYAnqj2sqESDdVbRGloZJkUa1R5bAUGO2/P3BBogb9Z255g==;5:mHCSFichi+frJ0vvP8daTG/nJhtox7CIupsNp6L011WvV8z9pVoJJjRZKcPHufatMAkTheZlBtACjWhp2eLJvFhgsRfmSBsofugTePrFYJMXvyt+rzqry1akPk8ySz6VNANeWxKJN2uA9M4NFcBtNNpthjVL+Nr8CspXQAp5Wxk=;24:hugkfVnhCtHRUOrHEvw24HKCIf8j0KKbWq/0L/l+rEOGi+cQ6roMvLmlKC3jEUhYUUgiGFGO9MPcmRLMhMc85D6YuQSKBOE8Q9/cqGuwBfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:2sGfvaJnQMeiL28zACzEDqbt3+ZwZlRIrE9kUrHvQh1ROULFDbdXY02lkRz9NGJw5hl7q0kAX+fh4GebOt4MGAlU65Vat7tBLTA2uWCz1ueiNAURX6UMhbaHxt7e7Wn/SvHhNP2VnYXv7b2VJfQWjhLinKlOrUuDPnBrVh/779Jg4WvYkNtuPst8gVBRKuNugDiuVT97Bk8kY7/82GebNbrBZIsHOdlijN16k85pqzjImzrSND92Z0OuokrP+OYj
X-MS-Office365-Filtering-Correlation-Id: 84f90d9b-fd94-4810-8b85-08d5c09003d8
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 09:31:50.3470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f90d9b-fd94-4810-8b85-08d5c09003d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares for being a drm_bridge which will not register the
encoder. That makes the connector the better choice.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 421c8a72369e..933d309d2e0f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -630,7 +630,7 @@ static void tda998x_detect_work(struct work_struct *work)
 {
 	struct tda998x_priv *priv =
 		container_of(work, struct tda998x_priv, detect_work);
-	struct drm_device *dev = priv->encoder.dev;
+	struct drm_device *dev = priv->connector.dev;
 
 	if (dev)
 		drm_kms_helper_hotplug_event(dev);
-- 
2.11.0

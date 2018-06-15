Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF70208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cb5hizxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF70208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966243AbeFOToQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:44:16 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:2496
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966080AbeFOToM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQbI048j78inhVgc/MxGKcIpbpzVl2w7EMAj3FyyiBY=;
 b=cb5hizxiBQeMV55R2Y1Wgk39jyRXYDAEYF8ouVKO9G/bOWYMDQE16q7Sgf+OccU5QNeJW/nmIS6O0O30mDESzduijnzWW1o4azqsEZyQSEP3YVzB6x1i/phIN0i2pwSILKcmonD6y/ZQteUThsYO5WzM0taHvOvHyjca5Up+LkE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4292.eurprd04.prod.outlook.com (2603:10a6:208:67::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Fri, 15 Jun 2018 19:44:08 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Franchi <marcofrk@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
Date:   Fri, 15 Jun 2018 22:43:42 +0300
Message-Id: <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:203:2::27) To AM0PR04MB4292.eurprd04.prod.outlook.com
 (2603:10a6:208:67::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4d07158-8ce5-46da-9460-08d5d2f85ccc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4292;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;3:GDn7IfiZf71c4VcL5phExNTObugbXZtMJqp+I1f+jXniJt3MpRbGjCUxr5C4Mc+XZeZVO2m8Ulmqk07EyxK5JBqAm1lIKXzq+nB/O+5E4qjHefzR85VH3M+nnShDQa3Qo1omoFYDikF0QydUkAVPuhwvSDt8gluZebxNzx0u/HI+cNR5JH1/hUlmOiIJIGX7umhK2boQGAPJv7k2Fw2evIsLtL52ISK26wiQtnSsjVbKOyjiyYPooM3R3K7gDQUK;25:j0wPTRy8epsqLXtWr4FWkkjw9sjaap1VJWs1l3ba01wiqFOI7Z39/JX4kgJV4WRAJwolh2JMNMuIMHkkkPNxfqcDwsRDIcRVp1wIG3AGBXCEFOEKgA769eMh5XEOhjuIQX/XbympnbSOoZEjLopCbCdOV7P0zI4FWG0bhVnA5mFHNi3UTcRDqcjeeMJdPnpYLiE7RJ0sCmba0MO69tMB1t1Mi96TvgK34wrUal/VT/V6Jf2AV/jmwrXuW2w7KmngjnmWGizgptqE8QKR2ORyd9SFt7mZt8bWb00+1AmS50MJ2K+Mgy938BBDt8bzuZVoKtgYts/RRzM1KdsCmWzwyg==;31:02mA8yV5gZ+EJUO4PTPmjUm5nmzsCz4pTOUDEopSKp2he2Y/ByghrJDXo7P1f5Ib6uqPYgu7c+JSB1RwSxVysrsGWkn+75kFLqKMhNo39djWKB93PotKvsDp9m8Nobi6vVzQnBbjkhKsiy6VfCiBMybgMlYNhKo4slt+F07qhONYLJ/PvTohds0FJLVOECuAjM15ec5bD4qtvvYHgj/X9eOaFqbtQUH6l2cd2Cq4pHo=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4292:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;20:Op3+Vh/xlgtxufswa0ftgLzRRFQtcaP7zCNt24J8m3c2IhYKqpt8wXj0oAfcftnN9ANNLkhLAxpCYn51exTBlBH+10kaDellBEr3tYBXUVqIyl7ZN5Vr6k/f0APbl5wK0pfod39Hc6U6ZZjXyZjKwc1jwKKHOtZi/I7V8sqtAmQU3uzCqXpo2Se9Ov7BVAsOHTANOucFyxoxbyVnvNnJyz1UlZSYL4H/11eN93Tt/cfGVlDxii3hmK3LPkQgHCO2R1v+D2HavEnWWEbAsEMRe8BirCDADVepfYb5teCvqRAoD/XMVAT169eL8/9ZqkOj5+sesPcTINoSe1Mt5o/N7DyxI0S20FbJecjnD/m1NYfCw/lYV6dsuHf1JH0UGhNvOUzgONB1yLb57dcL90vmdeE2aDmiofCSdVfGGcAHki3WcmjO38gO3DkhkwtKC84VD9a0AA6YGYQIyefV7o2XZXD88P/NHmkBx524tCY1ACptbZoCBK/g2x2PoIiYZmfw;4:EyISydYH0oclFgheMyt8aNGSXGtaWn5N2u+BT6XSbUpNpfT6/6IGrXasJweVl47srWsn6M+O+aZSeBjUQLwlGlA1D5zl69KPPFU6TjVfbNEnbYHsgbm4azU1wEwLue56KvJRnxAc3nOkkPw1HhQ4Xj8Yp0ZKBPMtU2yCt5Nv634tEPsmRuqNFiuQlusIRzYp43fJem3CzEpR+zS+4Vh8fm4aUbTR9mdD+C5siEYGbTfbhopMcQR2twnBYOYJWhES9YvE8KHMVot0qscUWiOjDtCkcRlyI7saVueTPZPMQzuGesXeODTAxrlS8ElGEP5K
X-Microsoft-Antispam-PRVS: <AM0PR04MB429216F92E0928C58137B601EE7C0@AM0PR04MB4292.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4292;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4292;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(39060400002)(54906003)(110136005)(16586007)(53936002)(106356001)(316002)(36756003)(118296001)(25786009)(6666003)(4326008)(305945005)(66066001)(86362001)(5660300001)(26005)(47776003)(478600001)(97736004)(105586002)(7736002)(16526019)(51416003)(386003)(81156014)(6116002)(3846002)(52116002)(68736007)(8676002)(6506007)(50226002)(81166006)(956004)(76176011)(59450400001)(8936002)(486006)(48376002)(44832011)(50466002)(6486002)(2906002)(476003)(6512007)(2616005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4292;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4292;23:bUHvU0CEZoXt6GFsjuXyoDddEP+Ji3XZ0fZNmM5cX?=
 =?us-ascii?Q?N1X15CX2EaHkq16isfwXyguuB3mgKHq5xEzUhh5TPreZmyune2K81DW/GKzT?=
 =?us-ascii?Q?0KgptEEamHxgpPOQGYPo+lN53OVpokPGHT+wJKMdGe835CjF/N0e8bsmRJcH?=
 =?us-ascii?Q?DUWF05Oqzlhck3F9zSXxR+MSABv+zQbImwzlRRsTEJFWmGxw4pWPgv6GFYVM?=
 =?us-ascii?Q?1thLOjUbAhEPg1cP1VjxGqiT6Ak03G1zXA3fm2wjZioZYoTdPg9TSo0sVj/L?=
 =?us-ascii?Q?qFJMclKiGCZVECF7i6OH7vpWa7CcDV0Rb3evv1H5AKh07ijr1AGvXxE2G2qR?=
 =?us-ascii?Q?xfpcbnA+ctl1XFh9O/BWjtpVDEcpxFM+7wIMB3oPBlLAiQr6Krcl+QFLfaj7?=
 =?us-ascii?Q?/Bwd4nC8RyERdoxIJ2v5Ej3dU8PainCO7W5Z/eUlWqkS0NgHueEiRp2opbBj?=
 =?us-ascii?Q?WplpHNIElVvziaw0rsXoKK6LzwRtiNv/PqKXZ2gmT+nSGU/77gF16vl1NwZ9?=
 =?us-ascii?Q?g58w4nATXat9aVtqCVKsAy5fRXjGkCn1ByA1opCtG/WGpkSMfVdKvgivlFv9?=
 =?us-ascii?Q?M2PUh4jaPsMFKWWESZxh0700V9f1xb5rUFwgXwO/pt6yDw8BFpsX9rqEjxxY?=
 =?us-ascii?Q?gQkTMiGYOq8jc8H3BZVNZLhYKdbPfZPgmI1NraBTP67ofNe5RywAxTwjVnyE?=
 =?us-ascii?Q?taP5/kJyf6UFfTPa6y5/A1aj34qotVvIaYKKoifqiTqPf6Kx97KYQX87VbG2?=
 =?us-ascii?Q?kofdo4PgqmgUUnSCiu2TfYvXKFR2tStRnX2pF79yKGpiI7howvYrGw8fnwD9?=
 =?us-ascii?Q?jb0+0MDVV65BAwv1dnB/6W92y1S7qWlrZnYXxISw1xsgIoiyVmSp2+4uEAwO?=
 =?us-ascii?Q?jFTnJie+kEhhcYqr5ReBl3bDnedCor0GJRxUbUfdAjgIKDGeBWVN79zed+ZP?=
 =?us-ascii?Q?ExcoE35eJJQYz7fVBONNU80dAGnWLG6qC0xZRiieAfI7ILhp/b7dGgcEdSeA?=
 =?us-ascii?Q?ZHXXNNdVTizdXz11Iqi/Qtt2D+n9KtaW6eKb19Pk5HALPy/Iz4+rfEgXivGx?=
 =?us-ascii?Q?Cj86hYoZKqvl7XX2OyQiEtD9sd9LW3dSl8gPfILhayVbFqy/BtUpZ7+LpnwD?=
 =?us-ascii?Q?cSAWVzfxJKCqcldZMzfcaaxjXQFfTk9Bt0Wg/ry4H4pii6PtK5dPacq4oeF/?=
 =?us-ascii?Q?8nCmrWMIZ4pd94cFN3mg/h85HvFG1jE9qUw4Syx3JS5tCkj18DfTc3eAeNPr?=
 =?us-ascii?Q?gr+zHi7fN8T258U38rv01ui208Sl4/dNNtmzTQJasM529k/jHTg/nPumx/7J?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 9r6+q+lPUCJboKJ0k8N5DZzngB7nvo8CCt6K43mXZ+CYCKu4oBSZmuIx8lB8HZFIuZPsYWIW1ON4bb/DGbQQ6Fj+ZFLNgKt9yThzZ7W8oRPoUJlwjMVhJa1eVy7bPUTaYv5OKfVLbx9MlJ+nhiSwxp4rhLAZklI9fsV8hZD/yrE+pYAK13JzfRiR7SMcGINI
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;6:Q97wFD4Rs42g3Y9ZzEpEV2o+lOsUJA8qaoDwU897TUIdrigjWAIBcMMNtRAijDjUxvS/opJ09pqa7uA0Hbs3s2yrj3VRcn2aAbNhv+TDHllek6KiBMKTl5UfH1Iw8hhyPEwzUfyTlmjpONFbTGNO07FARAuOSQoS9cWu/bxldUYxmj1R1IUji4OinZHf5O+dbzYPoejVFz7ZLom25ll0r2thpc1iUZdK6CC6g2CURE6h6SrfHJZssrhOupKnrznmUEi4xPfinePTcc24by28kA+Skom9e1//yJknawun3fdDKqochBBws96Z3bJUxlLFdqn6EieCAtxAT0GuPg4LeNfKAeVzNe7TZMT0LqtqzmhHwRMHuojX6E8oNRPgzxzGyDXTSUz0HvcP5xwlyiy1MdQHVLyFlDKlW3iDpxN9NDAHjNyk/HUxZpHRdiJ7SU+FV39U5y6u2v9Ola7P6CB7vg==;5:yC0Zpzfx3m/vOZvDsCZ9/kqJb17xjzfA9RkkL6OvYP85JVSpvENpq9RRLHa/asSv0ZYuxfZTnHRWEOJ53/2hgT/7RkU+LB6SVcbU8CVnx+/F9dCxGPSpcgnkVntb5ojsDEdY7Y0xHoTelqlWsQnfAiuGXabFZ30VgQVZVWBGyFo=;24:ZV7/weQVknvDk4dyVjq0BrtEOKs0OKvKQQ2q8FwgVQ5qwAZaGG7fX8O6yCVg1rKDNbqFA+bCKrMOi3n/u0RX/H6L/HEylSp7qwi6P7Mb0To=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;7:rdE5lADuHj+2lumEYEONkCd7v03m+32Q5fca7EjnnyHfkXoOjO9GYU5YGOJfrTj+6SfAqGxvNeq/+uj0izPsdAgA6LaoWjTquQHojWdvLUflngwo0Hhlaj1CSLO+pn8fBhY8nm0Z0Vjf/zd5lu6CN2NciGpLuL+GLkClxNkof6XEp0gQW12qNwYkv3uLYqBGyBI9PEXAKPPrgMzUXaDkFD8cFx3oeeYFmwTjn6tyruRP+5ymOr0QnG5zg2WtZmf+
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 19:44:08.8114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d07158-8ce5-46da-9460-08d5d2f85ccc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FBDEV driver uses the same name and both can't be registered at the
same time. Fix this by renaming the drm driver to mxsfb-drm

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index ffe5137ccaf8..dd1dd58e4956 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -417,11 +417,11 @@ static int mxsfb_remove(struct platform_device *pdev)
 static struct platform_driver mxsfb_platform_driver = {
 	.probe		= mxsfb_probe,
 	.remove		= mxsfb_remove,
 	.id_table	= mxsfb_devtype,
 	.driver	= {
-		.name		= "mxsfb",
+		.name		= "mxsfb-drm",
 		.of_match_table	= mxsfb_dt_ids,
 	},
 };
 
 module_platform_driver(mxsfb_platform_driver);
-- 
2.17.1


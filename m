Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FEECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E005620685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YpVs30Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E005620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbeGWOoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:44:05 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:34496
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388037AbeGWOoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvkYSipurL25fffJg1WLxt2pWx97wcPy2katyTAOXdg=;
 b=YpVs30UniGYxwPvyvzW/LbsEOae8uB6p2/fjCnFWj4tRTFs+VIUhywW/ZOzXEPRbJ6h7bT0YDGT7XUZnDaDsK1KSmdCz9Fi5irgMTScW3u/OsTUYKi6/bCMl0GFAvkYSB/bcR0ntvHbsbQkdx1gPsxdIQ0J96e/qkc04Cbzvl2g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:28::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 13:42:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Marco Franchi <marco.franchi@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable DRM_PANEL_SEIKO_43WVF1G
Date:   Mon, 23 Jul 2018 16:42:27 +0300
Message-Id: <8c6f4f407f363ec6980b59f7a2a9f29221dac29b.1532353109.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM4PR0501CA0053.eurprd05.prod.outlook.com
 (2603:10a6:200:68::21) To DB7PR04MB4298.eurprd04.prod.outlook.com
 (2603:10a6:5:28::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0e9582-7dd2-4e6a-2469-08d5f0a2294d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4298;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;3:eS2LHDMsMxXo5QAid3XY1kmR8Gb321FMcqImUCm11nSFxME+5OXZjG942f2GLG7y0C0YxyRdceQxImULBR0MgD9YGCcYOdMHWt58wPvd+Rl9gGTze0C2MBkV/5aDdCcP03ft5ooi4mgwIQYuC6VYV6UVkiu5x4KoXC2PAId+uAJbFLTCjnLGCwyKQCAonLWPLmj9Lqc6823dHp+PxgvsJUGwHa09/M5gM4ijhjvI/6Jn9nJyZE1Zl06YPgv9YOw5;25:Dx44M6sW9gpFvkHYj1iSGFJmSH7PSY58m2+Cdw8pRBl4LEuo+Pk5LbP3BJR5h0sQDZBbmswXkZiyFqbhxfqn78xEUAVFzigQK68zZ7crmEsHr9tK0jBbnppykOp39L2hVQJmDWrZN+o03a6H4FOwMGwL6s6g7TQU7uSQheQqWRjz0GJq5CwjLqXzYVG7Ft+Gie8K7ur0aaNu2897Z4chwGJv95gwZmuDjP/cXVHfnEYlfr6gGtOeFJJeaYSeGVrrOSyul3MsrxqNLNTA9US6MiEpw32r7gVKsFDQG0nN1Wvy4W4CCMnUa9dm+hF1al9p91no3LA8cIQzKnpVo9gzJg==;31:R2YFAzet/M4qIhmDHN+xC3eHIvxccGEgxT0lMf7drOn3TrlQ8Jevf2oYGIFsOrPCdqFGi4ix/ysRGAAvVmOh4LDUasY4njKbOG5t67+8gUWc7GwIBJgvKbEjY+fkI17NKGPiDzmN2g8S1tt5Jp52ulnqlgTRN4L46n/F6BPRt2HRH/YbzGT3BcL/Xc4CEETyM/gdL6cPl5TGEWO0tb9e46hN5HYJ4cTMZojDIb+a4E4=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;20:esAcXT+Zj4tWHL5box/e8TdXrZmUqvea6b5EK+oLd8qSl4ouJ7A/+ee6/casmQJa8CqIygNI9f0a79SkBxO0f6Dme43xD3gdU8jzN+RckbA/Yf8SUrxe4/cHTQ0CtozYjTi0wSWhiwBPUYHJundwC2iCjx5yuIlml096m3WNitbygKDbEyjeC2H2U31SWAlXYbSFn50Fkb/FXvXDgA7Xqv5BH9A/h2awZVfO1keD5xXTGz9+2wEiReVfc2NjIbFcZWXo+hxmiqSdc3oME5S7nP3nEolqGHYU3qft+GmLQtPewMMlOVxN4s79c6zegSpPrpHuybcMoVTZ6IZsw+Iv1vTIQfv20Qf5A/NChFH3ezeWV6IScly5WFXYAVUIMj8lXPh1tmcjpm6ycYeRDfmZ2grk6TpD4iiWbuZvjZpaoYIyxvlDx8wFh3rxJUqM+lHfK0hi+qTg1Mu+ZEDtWsWRcQM3bhxvNEB0WwfEu7FQRDxY4QmTE+WCo2MGNEmr42vl;4:fQ6nzLY921/a+Kl1YdSEz5ImPBgQTo4QQws/u0melQedZI9J+Q0ZAnXhuNd/Ne94QmbpcTgbfDQzcKywbF3SUpMrTaf9KlfrzfCVaakxlOmogkcGVg3j2irgmT8FjlRLOOv6WnqWfMGgTTFgZ9Ba9wzgDTD4o/yl6Png7ZmDE3y+nH6/mVbf0o/gcJLvVZEVv0lulaO+8AztB3XC+exmZiamlNGkFOL0PnG2/0bPBjkrskx0k++RP/VsosctK2/i1CjE/UWVy6FMgVnrrodUshbKiOZRR7BnBVK96quFgp45DLZBM1FaozVDmBpI37eV
X-Microsoft-Antispam-PRVS: <DB7PR04MB4298E5C64054C15490A7FEA9EE560@DB7PR04MB4298.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4298;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4298;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(6116002)(3846002)(36756003)(68736007)(6486002)(478600001)(2906002)(48376002)(6666003)(50466002)(53936002)(5660300001)(25786009)(305945005)(7736002)(4326008)(15760500003)(47776003)(316002)(54906003)(105586002)(386003)(6506007)(106356001)(52116002)(51416003)(16586007)(26005)(8936002)(81156014)(8676002)(97736004)(1857600001)(186003)(81166006)(16526019)(66066001)(44832011)(486006)(6512007)(50226002)(118296001)(86362001)(956004)(2616005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4298;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4298;23:CkgDNBYVjnOSt6gQBQ+8cA52G8rTy7QanBdo0GqY9?=
 =?us-ascii?Q?p0mUiaQvKvzbGYUIoWF42NzS2+LwN3gzuFdUkjtnUv3U7CjQFElRi0T078qX?=
 =?us-ascii?Q?/gZdBlkVai0J+9+5+LTIOfWHdOFTP55mcebfR3GEpvkxxCRm1RwQl2IZ4h7z?=
 =?us-ascii?Q?NcHRhR1ufd2fop2NZm5+icS/zFI+eLX5Atr9aE0YwfAH4GhkV9qb5Dcir4sR?=
 =?us-ascii?Q?Sj/cVHwgwbl15pjzus+1pfPw1BeAnJXl08N3uzWgaF1pLih6i9YG18/FC6au?=
 =?us-ascii?Q?rAPn+Mnpmrh+HVYxB+e0+T2nxX7oxvO8qoh+HzGR4xhiqGuMa88v7MHsb25a?=
 =?us-ascii?Q?+9cuGh+Z6fzG90myruFRj+S7tnTw0BECRKCIOt4hB68EN0DRtX9adTO6s1ES?=
 =?us-ascii?Q?0EF950OLjCunPEKYQK46CVFhyyU1RnqN/qTH2V3zEDCUup6l29HRSdUQ0pzs?=
 =?us-ascii?Q?+uWvJau1/4H26OchvfFUkUq3RWT6GcU8bvm1SoK/YJ5CEXEBDaFDMwD/A9XB?=
 =?us-ascii?Q?gEk/cBgjD09iOEXiDVxGQ3q+R5DcJNI/h/nw1TBMk+NZpVQ5smppj3be+eYL?=
 =?us-ascii?Q?Pg7C+3tMoN3a6X5ph2Lq6fj+3uJmQ2hko+Gyo9fyk6rFuPi3r4XPdh8dMyI/?=
 =?us-ascii?Q?tBrGacCH5yezPex5yCQyUXIXuA+Y6ZOA9mbprtVCB80S8UtjO2S/EEm+yd84?=
 =?us-ascii?Q?+T0Bm4nrS/MobFgQfnm6KkxfS3gyIqfOVSX3iHTZ2ML1LCpsQPuQKvXiZ0jg?=
 =?us-ascii?Q?RJo02Wew/hyDgzlXNfbiC7iLNn/CjSiUei5XelCxGwiy7B+KqP8iRsUkFGYA?=
 =?us-ascii?Q?mleacNyJLnYqhNfCWOuA8UOwf87m8XMWMawyCLvY5dN3PQTwGEhbLIGbHylu?=
 =?us-ascii?Q?bCK+tPBStoACGcwBT0jtmXFzoQNvq5k+hLAxFYFafX3pxbwAFaBYMrW/JpnW?=
 =?us-ascii?Q?Yi4uBEVUlfCmKG75acehccbS9oRMteDP8ua32kNhIlH27vv+ScxkkYxTBfFv?=
 =?us-ascii?Q?zEPRKTHt144uym6O8tf7PevT9yTEnmYbt098rnXr6OHBr7bDj+Ps1BYEjA3S?=
 =?us-ascii?Q?4NA7CpyL6IRfmPklQT0yZFrZ8c8Iwn50rPvqduMwIL9rGlyXRXM7CpxiYYJu?=
 =?us-ascii?Q?R1LIhnyRmvRRzauO/YwjXgkdrZ61lCSJzOI3RfmRXZ72kj7kDOLQPO5SY+sc?=
 =?us-ascii?Q?Ete1+xLuUi0LX+kwDWWVyR+sdbUz5oRGGvNV12p5I0n5NlRZRx7N3slJw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 9bB/7JUiIiOgfu4RYeMb/XoXdBZZfxpbCkTVpaurxDxhPl5UtA0QQJPr0a+KyPoBwdWUwh9uZlsDYRYvVLnhyR402eHuebv4S1vvluwZcqmK+LZIh4eFV8BAnqTkFPdgynI811epS2ewhxmqSV0wW7OaOGl/uQ3sc1K72mo93Rax9MbpqJZKRavAQa5SgU4g7phim+XubcDVNdSkrG36lbyXccTx5P31VqHvhfPOYPnLG9N6rpVu47xBQ+xXt8zPQ4d3yezZIdKSihSpOYkn/35Y1DqKg9fh01Ol/mJlw4I09gT6iKpDHIyPobpb1T0ESJGPSEfRIrxZ2BToQuFCETZoTI9d1Vw1PIBdSet7WWI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;6:S24IQ0Nr4TT7LYxpHFb9nC+KbF6CLTsSQZdE74BExmNTPcdTUddav4q8tPrIaSmABboQ+c5a5qngdtu7xdENxh16Sxs3qIQhqcfSNZSdW1ORobP7eF0UJI/ku17XxtQK5fYaNHcXFCpwzFYQbJxEnc4+Y7xhubgfNPfaU1okhpwV57HAy9P8TkJhTalAGTOsT+e21zmfvo1Fhxy/NhQkc1m8s47IW7TyPHqdIpdv2tXZTmjCyojpr/XevwPlcZka8oeAxpNBm5lWInT0lHtPjyYT8Nmhp1xEYD3nEagALbnYccCfgZIMIHcAw4EJ3vPtRZE70/OjcHK/AjOB46cQkVgcZKea207J1VeqWztchBw0+d6vW5oc25790AINnRAr5woL3jxUpUUwxcL+bzW2LW54LqDX4v5XLQeBMyducsYv9CEGMYW4LBRj2XpqWollYIdBcelTEqKk4UGeeitmiw==;5:8v+dJJt8x+/x0ZK7q3dPW1CCWP9+gnDFzuwOSJ2U1IoocM72RVOajMUxvAx8KgVbHHEFCQKb53u85VIDjRXIxhzuahxN7sAvOtCmsqeq0DgxaTj+XyTaOMOS56XKLcvMgP94T9f/Amw3iKv5XJhnl0eI7TpO9dmPKwiiKZ3L5ZE=;7:t5K8jBw11u09o23OjvwjuI6dmjoe/upjKN3tHUdsRKyaWP6kbkC8Uw0sH6oomiTeEfvV2iVPCLrJSQa0nYirUbgqMbL7oOWhEhGBP0lisylGglvf+PKGrUQ+ui9zBu6vdufviM9ibx94QP8MgI+rImmd5cX5Nr7fkvolZs7EFTskroen7zjTHFfyC+zwBNtOEn3zc1DWY6H+cqVbIEsdjtdCoCjEod3Tp9+0t+hFVLH9vA/g/xh8wS91nTTO3acB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 13:42:40.4051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0e9582-7dd2-4e6a-2469-08d5f0a2294d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of the default lcdif panel options for several imx
development boards. Now that we switched to CONFIG_DRM_MXSFB=y this
should be enabled as well.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c127608bcc..7eca43ff69bb 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -255,10 +255,11 @@ CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
-- 
2.17.1


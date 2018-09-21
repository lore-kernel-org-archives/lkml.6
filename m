Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071BECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443A420989
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="EgtsO7gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443A420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbeIURn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:59 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:28767 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389933AbeIURn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:58 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie3.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:23 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id B2FA473191;
        Fri, 21 Sep 2018 20:55:23 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="291574206"
Received: from mail-ty1jpn01lp0182.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.182])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUbvDZYLb/kT8Eb0iW4DhZgbXf2vzyxLYkTo01MSDUc=;
 b=EgtsO7gKeKYcTIDNdtGOI4AjFHAZ8GJqB30Pi6ubPOh2Sp7SUcIrHu1hFjfgcm++OaIKQguWKEdCCG/a+2tMvVlT/uQ9iPd3vVCPXCFkNG10FmxDbcOtyiuXAsGbggCdFq9ekX846CyF/wPVYPdIW/aHnJsW7Oik2TplC98hvZE=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:22 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 7/8] phy: renesas: rcar-gen3-usb2: add conditions for uses_otg_pins == false
Date:   Fri, 21 Sep 2018 20:53:23 +0900
Message-Id: <1537530804-19399-8-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1537530804-19399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.144]
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To OSBPR01MB2296.jpnprd01.prod.outlook.com
 (2603:1096:603:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3be216-c74c-44b4-9941-08d61fb91c49
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:dwrmM0JIbHkp4j7D1Zm1RE63ELb+Ok//MWBi+JW1osskU3c4kB7apTYGwAPYMKRSxlMwIwvgwrQWUGVA8jk3EFeXrR/NIrzE/aDhCl9tQyOGuN7/dClB3RKKq5KzDm/ZR2RVPk4HdQqcDiwGobkRk7g87HzRn4VPABZ9y9Nc2iGr2XBbvKYkkDnKl3AYkMcbbapfCTRgs28VDRY1Hp5z5TmO7Dl55VGkOtOzfsb/wW21gF/wnKFl1vO7SVrtU7tI;25:U4D3RhQmrApZCyzoObeDd4dJqam50mlioJgPGQPslMeVGRhr5VidZoOHdOBwjW7kgkxa33FYMYHxtRKg+xBrOinrWhIuR6SWNTuBYqAlO8r3CPVHVz8qYrqnLW3+7C60CeIeG0R3HE04MBO/KxDPyKZ1HOg46KND4hDLiJNlVo4WuQow87WB8vcbibIAxL+dKyUfCjmbh1l9ejNs+6K9nIODjKFkb+nAYgZ+qh6PIJUdXg8c1XbbOUSVoBihpboFiG35kopr0OqrNdpLdfAnNTVdcvXGAYbkPU1H1EpJK9VjlfTmvh1iDc4YpFV+C4ucyZD+5jLx9c8ZlBmMIA9aVQ==;31:FlcIbooL0B8aGJ2rv3uDMPUthOxZC/J9DtgkshKu3tlQUGjbUK+WNW68wxgsp8MXnme6ByXyyKqjYbRiElD/BrAjae5VZTFRSYbf4/8BYoJcfHNH3ybIDhb5CKe+4pp7gqBpQ2yUeLxsgp4zXud75mKP3oBgtQZ2ILHFOtSZH0Xb9RWsRZ2cPDIVn2dRZgEMGsUuT74tdGuFTdNDTNoAefmnRU74wvX1f1Jg6/VoW44=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:jq2SxECgOhHHrfbISP74IGUY/dBYBSMdkSmAgr8zYknG4E/EUhrTg9t7VHLerFOhGd4qyjX2CS6QLL6TJj/9MRFfxjHT8JAJtlCkAwtwdOBmcwaXwgkvvogxY0/DDl9+bzcKNE6Q3yMX9mFsGAKBnKG6Nj878BuU5ItOyYPgJKX25GJHJQcI9CqrFLsRvhv0viG6U3MK6w1jIIyVo7caffOdkFIgour+khsHjOv/aaGcDg0x6xcaUPxKWXp2PBGFD4ulUAZ8Pxkmaup1Z0GdpQCPTZAHllC3yWzKWn5IcGF/pQmISGCVGWDCXiFNbGGJzRt2O+xXnIceFKSuTL1ipQFFUeyquH9t+S4zdzIV9L9Rvt+M2AbBHR1SInA9ho+KyzIOk0Xnq3VAnsfM9HREoDqMqIysQ2U61RTzHiU/mtnLY7X4eMQ+0r+mdvWr256oXASGCpAAz/F9n89TQ0MYqGxtuo0f/4y3gd9bCMi6PtvmtaXLvSDm3Q8skypRj0WY;4:ki3BH5Qg4h8JEhYGBxLdhfLrqBK4FYrdB/sF6NTdW3xPO93Yq0sJPhDTOrOpIZu17KHV8AJiurqCR2cZJtMgZnJhmefJKTNYNvCiFkiE3WYL0yKzm+XrvfsNgsCBItIN2Xqw/qJTVC/oL/XEPpIhYY7UozvcGIXdj1S9WpZvE7V0XISx1QBk+PdZoccBrBKV0EnaeXiYTbUUg2xMaEP7H8e9+GEgoCoE3DYxwGoEEHEbUuDRUShNwEqbDek3MttsAV7vc0IEJA8q7rJyEUECfA==
X-Microsoft-Antispam-PRVS: <OSBPR01MB229680EBA6CD70A1B9A8BAA3B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(14444005)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:ERTng7U/UYeENj3jaGgyEnB0D5jljlcuUbAKYgqqU?=
 =?us-ascii?Q?QL3jXOrjELRa0fJy/FvA1CkHN6vYoSDjiYfif8p3w5G/I5PNXZLqiAuSeyFb?=
 =?us-ascii?Q?mqZvvtMYd6gaxK0Vu4OzUgYYYUwXeGpnY9Tm7aDVpSuiBssBgk0FSaclyOas?=
 =?us-ascii?Q?8vzk4Scuv7oukXOcZCLM6X0e4A3XMgtWE47NGtAOlxKnzn0SGf9XZQa/p3Dd?=
 =?us-ascii?Q?GdbM/g9rJHeUAhO016bWeVNyjVzdfKaqzYossjR011tiA+zBriqC591AjAeH?=
 =?us-ascii?Q?q/DxfHszBOLuuD0kCeACpGjQGPFZHx+qT8/r4+KOrCxJQNOES1YuoH3FdIF7?=
 =?us-ascii?Q?szNErsqnfuAWnn2nQztsIppHW+etlZBOJGq2+kk5jjUFaYnBC3UTh+JaGFoQ?=
 =?us-ascii?Q?ct7v+RlGICWstVlNr+Mw6PssIg1mulMi+umqw7qey9en5fceMMzYuPTbR3pa?=
 =?us-ascii?Q?L1Eb4RgydMw1Wd5Q1Z+OFNWuB9jGEoRd7pSJoggTIp85cQAISLxXh/RoJ2wZ?=
 =?us-ascii?Q?ZGQuHI1qOIdfFY117mFj3GX6QNyphUvu6TpC7R6iXB97O8cyiTUTmmgC/jOE?=
 =?us-ascii?Q?Svf99ClOMVBfptF1QLDlc3p6o8vFq/1JlKX8qhQ8ej0lbsfUni7rq5hQDq4E?=
 =?us-ascii?Q?NQMbEAD+m7KTQx6czQ8DJE/gKYjTpak+TT5DIoJhfDY6FexeSPyOBhyq66on?=
 =?us-ascii?Q?l6s2owrN5BzV+Py3uL1hivsx0ixex2t+sNf8iaRF15PprdSlK363sXkjQcvS?=
 =?us-ascii?Q?vEsmriE2J20ZY2OQdqIE2aP9iIKYcovOR3zfGMlRmk0q97SFEvK12iHKqQ6J?=
 =?us-ascii?Q?6adtrvwG/Gk2wNBZ98KAwuVah+vhaQiWCr1K9vPyp2+Z+WZ02YA9kUciNqwi?=
 =?us-ascii?Q?eGP99Ra6ZqWKyy5YqL7zL4/1sx4NBnK6Fj+ZM1k2o9m8bGKI2/roW6hL6+r4?=
 =?us-ascii?Q?efXITUt1t9ZvJ216gGbsfPQZYZimKqiqBn44JDLBv2HTrIWPT0tvTahiLq9V?=
 =?us-ascii?Q?UQPuQxYAIansT3dv5SijZbNmGy6/egubJczg2WkdBAaZQSnDqxmTq69rhXAx?=
 =?us-ascii?Q?K1Tt7IAhbTpMHmJ0cuy6ce+0ZtpNtpa3DpekywSD0j2mWXVspNRqbSJ1TOaf?=
 =?us-ascii?Q?r1vybBr9XSU8I8BPgbrorHQ4jfs/Rqkq4jqDnL0442LNkSsOfq7DVEHG7IAC?=
 =?us-ascii?Q?R4GgrdJDsybevO7z+jRnb+RKDf1uv7D+E2eGbMWZmYoZHpFjwf2IDO8Xc4Hu?=
 =?us-ascii?Q?l64ZMn26qjMVjroVHY=3D?=
X-Microsoft-Antispam-Message-Info: EdS5/BVetjGt+dV97rstXFfyOuzbShSd+e3aAbdEmNwN9cwnP7ZEkdVMrIrxOIBGsw6jZd04MhDyzDQ8tTZ4asnkmi4R1yP86JKrJpwPPmzwidzhVv2fQz+jmEh1AYQu4jwE85voA7Iup53cpGwSGYW30MOqpdMn8o0jwTu97PQKZlm0eLN9SfLU2g5AXm5URsT9NGiaSau0t/GVCjGjawuX1bfkbHzCv/egs+kfo0/ov2CGQ9tvms9gCplJND0v0cOmCASgQcatR1YxD5fQzQTmhX/usl/Pz0SlFoAJdNyE8bEOVpupjme3nzroYHkh5WY+9/VQ0+WNpGG2AXgLHPS81UxMGfQZZKgySIv+JaU=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:eTnjEcOKbt0fAzrUJBFA2Hp4ziU4/5F4P8UQaQtUuk2sy9mtT7AAVEZVAJzKT8+hwLbbG4a2plpGBKOjqO6ZM+4eLJJAVb9/+EUmsw8Osqe2UkmqQzJMn61aBB9GXdx1/Vce2o5BHzIhnksGrwOdXE+yRkT2YKR79ghnbMJLY3w7AFHc3wHz+mROwUK+EyEF9n69zYMO/2aOfpT3xLSStxdkiKEwkRWpe5CRHI8xwt6eTiZrgcKqXt9payKTNG6ZM6lVPPVopwF0wE3P2OH5Zzu89/vosBDtScUBOI48E9/b2RQno+nlHDHQu9bMTuiIdyz4iG2n7DNIoTkJBtOYKOXzelPc+POyCS/xbh1Hs5jLzmtcU7VLrg8Wa8Nux+gSLuWeaVz4vA0XO/SexorkZDTHlfLMAcw83LbDUcQWm1o2JDdCX0fecO/IEAc5FKFX8nYpWZ6/YHwK95gCdAzMbg==;5:NEiNp7hgcB5Xcm6gqjlczfk42i9A1xVr5xqXUUna9WDdEjfyNwDBs+Ja1tyKzjybahytXzdyBOAlZcANVPCJzRLNoj6SNI+iKQOsF+/LHHbKhTm5xE0xo5pHdIsBHXsqh2ZccZGl4vSEReJ5BotFZyBXYT70VJbxwSmhuXAewwo=;7:Bn0w7g8CG+qBARtVgkxwaXFy2oMi+3SacrBXsGXXA6+2LWXOA1fY5XyxRiFueNxyBDjg+gXfU3F/5fKSmOI1TjB4PAHNn9q8rcKQWaxSZkp2vcIfiBXAOnZlJlZ4q+ZX/Y6/zpk9ZmbfYIrxJAs0KYb7ACwLNmiBXDGOjOn6z7lIy2a7F7HOKh7wpEXquWAGcwINaLV19R04wOda6ERrKSGggdVdd8BH2d3hn5/KnRkFbqh4tsFt8/VS51HIZ/y7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:kZx5/CxJHoXw4XFBIwaXzBmYLh+yzMUQbu/XeNGFxJZgDDL0NBhcQNySQYq7U80Ec7kZggKFDmWFHiSKmI2Yb7O54keybBVJPqloYc8o9HMdPvnJNeHxa7Yynm1Pw5ZL4aeWrKFNIKzmaI5bSPbys1oE93W8srhnrd3kAN072hM=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:22.2119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3be216-c74c-44b4-9941-08d61fb91c49
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If uses_otg_pins is set to false, this driver 1) should disable otg
related interruptions, and 2) should not get ID pin signal, to avoid
unexpected behaviors. So, this patch adds conditions for it.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 93ab860..3f2efe5 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -148,7 +148,7 @@ static void rcar_gen3_control_otg_irq(struct rcar_gen3_chan *ch, int enable)
 	void __iomem *usb2_base = ch->base;
 	u32 val = readl(usb2_base + USB2_OBINTEN);
 
-	if (enable)
+	if (ch->uses_otg_pins && enable)
 		val |= USB2_OBINT_BITS;
 	else
 		val &= ~USB2_OBINT_BITS;
@@ -210,6 +210,9 @@ static void rcar_gen3_init_from_a_peri_to_a_host(struct rcar_gen3_chan *ch)
 
 static bool rcar_gen3_check_id(struct rcar_gen3_chan *ch)
 {
+	if (!ch->uses_otg_pins)
+		return (ch->dr_mode == USB_DR_MODE_HOST) ? false : true;
+
 	return !!(readl(ch->base + USB2_ADPCTRL) & USB2_ADPCTRL_IDDIG);
 }
 
-- 
1.9.1


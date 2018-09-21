Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C52EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D0A214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mqX5SGT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D0A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbeIURn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:43:57 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:23472 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389903AbeIURn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:43:56 -0400
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie2.idc.renesas.com with ESMTP; 21 Sep 2018 20:55:22 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 2F77F7412B;
        Fri, 21 Sep 2018 20:55:22 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.54,284,1534777200"; 
   d="scan'208";a="293141290"
Received: from mail-ty1jpn01lp0179.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.179])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2018 20:55:21 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgxRHp4FYGWP0E6tlW/Of8AFfRo1i25w6H3z/ieCTO0=;
 b=mqX5SGT/JVRZUYtYwe7079CamZeyJtzg3NoQFZQ3iVxE/r1WUovQg88p0CKIdNUDmnvWtqGTfO4EIebqPFjqw3fx5mTayFKGRupl7tX37N0v3XqPkv8cj6U6s0gYCKFb2Wf+dykurA3oj+8OlVeou/NPMJ5GNWQPZRNNKF6Zcnc=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
Received: from localhost.localdomain (211.11.155.144) by
 OSBPR01MB2296.jpnprd01.prod.outlook.com (2603:1096:603:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 11:55:20 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 3/8] phy: renesas: rcar-gen3-usb2: Rename has_otg_pins to uses_otg_pins
Date:   Fri, 21 Sep 2018 20:53:19 +0900
Message-Id: <1537530804-19399-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8054409-9ffe-4eba-2fd3-08d61fb91b58
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(8559020)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB2296;
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;3:X3nPuVSJshpYuWkKYACMcCA0b3EE1DdyJ+sOvYXG7wpvhTG0Jokps0MIJYahzEbYWN1kksWFsYvliwoc6kmRJMqgeJIfhzmtc+JNGdTni0kp65zfqNxApEpDcorxag8ilBqS8q4So92mzXue7YaPdqNaCR8TEpJVcts+qZc/uwzoE4M6ERO2v1iGYA1tcGg9nCCSmoy9A73q2BenmgBsG7ajq45bAneCEd5BbGaOnZRkWDm4RLeuJTx2+wN9OgGd;25:eg7A+tQH3ZRuwvkN+QZfeH/yw57m1NpDVKZSeguhyx5ZZ/D646+F2zYkrvm4lJtgogvetEWaU+H/tB3vYxHjNZMd/BceAoE/cIsZdMcqfFmM3Ae7gWXQynSYt8ShCAvt7ZZsCfqfUf68FPk2RhkQPuw8CsGQlND5s3ZhGRQ9wvUaC9wur/jGl+TQ0Y4NDgU7P/McS3Y3qO8A6DJwhD9OdXZWYpoypKJ4jyA5eXeBhpY3Nx/nkl9vlZUDat/eJzUV3NxSBh31fifq/18DzR7tmYREsy5jdejcdKfQjjKzwHiur/DYUecw1WgcLl1r9QbYLiUyCWNqgUGG0I8rMrQfZg==;31:hgs/+zgFpT1F0EKrD7mY4gUbk4HdphRyvXmS6/4YsvpCcsVcT68sFPn5u8rQyv4Vm/W+hKOzTjkIQ95J7LDRXwcNP3yts78+B9uWbgZA8xurMyRaFDdHkvLNX7W9zN0DQuOh9TKcdBB0ky/k62BRPGQ/ELMwQHpLBvT69JN6YrpO8HUELQpxvOt8bV2Upg2vnJGBBu7xH1TdpXgflHPlfmYcbbzscCEDz6yqkT+llHw=
X-MS-TrafficTypeDiagnostic: OSBPR01MB2296:
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:1CwXX33v7AnLyiZMcIm3suYsswAwTARlzDNGUpm4RVUMAcfeo3QVUFfiyfVEa3XD3ZzDg5S3+Ft0X+lPlQG9MDoRqQM1nzhU3q86AiJyHaygm3XjjGpmRIT7drWwTZz6Y1oG/3eNG3HpqO5Ysw2BGl8NQJ7anvPtGVtVRB9wREfCdh4Bba3BrKYh0kc/tBP5DaAQvzIuSWXWYKb2UxyNhNINMiBYm97aw68Uq4qVMw5+ZwpuzRhOKrMcYxhUmlt06ru/r0ABX99cxzZVpzjemlj/KnS+948G8Gq9AsI70GeUidDIKD8VtfpQ1KvFwoZt34/ouq19P6rnRrQjxXmoxCxoIZppVZdxpd+Jl8iehb6X6RyFbWjjRNQsat0dRfxzCTjwWHq7jM1W4HV7gHj1/xGvunYbi27JoUqO88rb/zTl3pr2dCd6SaZr1qITeywyH/D6ndDRQK9I2QxcGzauQMfi16e1Z1BnMX+/WwkT5PNZ2ysomDHX3Z7djw+rsfi2;4:o30dO/REW0NX8UeIVc1J+zav95jUuCVc5bi+oOn7ajnL+0Wwkm6BS0YvLCtAtMUU9cXztgXrN1JHIW0jovgCSDLQVekYtGWvesmr3D216LG3+witeQrUPxYh0tRZpZPs6ojQXtH13CpXW1kKIsti+5xlZZ8nXY57uBdp2K5t4xD73ikiimcFh35ibFDHq4dbEHBwj4CZ9/a3gxot+i+4C4fJ79OVTqyhzYrSDcjXi281Iz8CzbkzT+zRMraLUcTJJTqEqJ95TvmkoTwaT/ep7Q==
X-Microsoft-Antispam-PRVS: <OSBPR01MB2296599362F453ED3209BA64B8120@OSBPR01MB2296.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:OSBPR01MB2296;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB2296;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66066001)(4326008)(52116002)(107886003)(6512007)(486006)(6506007)(42882007)(51416003)(386003)(47776003)(78352004)(476003)(26005)(6486002)(105586002)(11346002)(956004)(2616005)(53936002)(446003)(36756003)(76176011)(69590400006)(16526019)(25786009)(97736004)(50466002)(81166006)(5660300001)(50226002)(16586007)(8676002)(6116002)(3846002)(81156014)(68736007)(316002)(48376002)(106356001)(498600001)(8936002)(305945005)(2906002)(7736002)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2296;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:0;
Received-SPF: None (protection.outlook.com: localhost.localdomain does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OSBPR01MB2296;23:yMFpz9PdrZ+URJwXWj+2WpPyLCGXNMX3HcWultdl9?=
 =?us-ascii?Q?sXNl/5BIeNgBa1EO9cnJUx+Fn0KIIAA2QPrEi4sejDoZ3AVObQlGBZwqCif+?=
 =?us-ascii?Q?97Edk+BUj3TcPtXtbaT0zZytOexKJFnLzorc0nnOIhUev6FsG9r+s/mAoUEZ?=
 =?us-ascii?Q?EAx0e3WLnVkDn9lPeJ9w19h9M5PA0liZTr84duYLGy1RmaPqL/loXreF9ubZ?=
 =?us-ascii?Q?IGTadK9NfA7GNoIp7iz6ud0RufNludKpdfJY6mlTWFfRzXB5hOJ7aP/EzAW2?=
 =?us-ascii?Q?ezae/MqdQR1wSzUMmn4zaS3QPeVKog/BqBETd+EH3vQh4wh48w7r9Ew6W9l7?=
 =?us-ascii?Q?NJfRft0beKc0zmrsQuFN3/N3w/SejWC7AQxX2ytcefNeQR18ycRHAgqn6vNS?=
 =?us-ascii?Q?uYNmYIeOgKEy74awicTNioCaeiWIWSwOCTMXWGOovQYPL7L2SdW6aOQdLo3A?=
 =?us-ascii?Q?i/0HFUDmKxrmTZuUrMlK/gNXU/UpmFcKizjhVBfG4AEEAiHODYllLHq57J1S?=
 =?us-ascii?Q?oAd6J7dPbsPQLXEr0lZQCPqAllo57h08tcIan4dq6GkGEdjINrLHq9lBwa6U?=
 =?us-ascii?Q?p/RcBJZ3zIDK6JPHBhe9UhQWKMhlx85FekgkAslzSRIvOb1a8IJ8cmte4NpI?=
 =?us-ascii?Q?lna30y3mNea4UquoZO3X9TsaYsu0IhsQHHxclqa6tKPKjRZQGJCMe3DCOLuD?=
 =?us-ascii?Q?LlnBboCQBBsx7O/9O6vjbBz8DHblmWTkv52gaqlNRX7VdKhKeFlYVp5ALU21?=
 =?us-ascii?Q?3aUZvl90hl/mdfuOP98X3zgguKYA85aVFA9LNHvakILnytqo3GcaoGJIhXRU?=
 =?us-ascii?Q?WZh+v+gDxQwVpcjRZ394VZcaehrIgt0bTP2gk1QkueceiqjeBEbGYwCiHm/h?=
 =?us-ascii?Q?oA1CEUQSsGe8PJJx5cD7Z4frVQ7ULwvVcEud66mq39M8IS9RV8eIxv4w4X45?=
 =?us-ascii?Q?fSMFtBXNCiQ7F1VxRvKn/Wf/ACpFTyq1UPuvZzyZvHjwUdiyCi1p8kG9fSL6?=
 =?us-ascii?Q?h3UvKgaUZ2m5Z7YiQrHyXYYons4xzhf0l41pIDMFLJ/hImAZ89iBtjdC8sKA?=
 =?us-ascii?Q?DnUpIHSJUsdWFh3Fm3Ug36jg3UlqYgojr/oqkZ6UdA+uKSzcGRy9UmFfLsYJ?=
 =?us-ascii?Q?MCRnaXDkgKJuqpytfsq5nMy4yVYFJF8zAdaEnhDW1/lpiK9GiyzoU6m8ZLwh?=
 =?us-ascii?Q?9aXkWNclKcx/wPTKund0DTtIqCovXfe6KRAZy++TYQQJDT+JLOnNMVo2g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: YmynnfHAQDtr904bdj8SrH6XS2jDD72nVRxcGYBWQY00K3Vo/szjw4P+n7OUdY+98bswNgyKmqc6Ub5i4bUdvIGLpYI2qC88k+nA0HxoQpzeF4N+23M5kELvbd8sH8341g1rR16aMre9+BqHwAgqZOat3sE2wFfh1T7rjd8b/ntszD4PZzajRxolaGiq7ZTDU6xbUgwMPGB8on9RO4mComVrN57ObHAmur7rd6Qij1iZ7Jv7mPq95gxyCn2YRpCXWuykSg9ZEmGN4ur9UOCx+Si17W5Zo6xWvauoLfu9gAztZKROOsAz9PtYf0GHMlzFotSnuaAI0f2LWbFP2rpGSBW6BxEYR0mJ2/Md6MO+Nw4=
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;6:Wukj5s0Nozs/pJq5gZtuOI3Ftld0PwGiOnE0K4jubGpdoaSLcDq/18EQlr34HF5OotXC0dWm9PyVsaQlv48tjVs7jaH2Wfi+tPSBma3Q3Kosw3yYT62B50NsWpiVGsMtKbh8p0vw/8ArVsqBSvxHu18KhX+HCZeRgCJQr+7aQX5usm5HerCOHkrjK3a10/rQ8ckrnFFWJxGFwsVXxVcTmZHAnwC56VgDeU9fXOXCEnvcYZza2PhCIieoeotKUrdmtVQ4aEClJvt3oGn2uHMrGeNS0zmovChYYuuWdgmntJ649U+o2s7rx1B/ePaEWW3T9s/GUVzqdc3cUoBG3wLgyLfbZ740xK6pbub43JqHQAjy/Ht77Y/pkSSkuZmIGjdNiovMNFkWlm3azm4XrfCo6xYRrmmjkQ31aRlSkoRXVqUDdmYcTDUHOFKHfthWYyf7Q1bQU0HLwXWhQF0nyWH0Qg==;5:YVyBrEWldmsGO8NSMl6QO0etgA8YL9LIraSyitDe1tUkdsl60EgQ/Tl5sISrMdMxv/5hdu/5SkFeJtXbYx+6ARxwHCaQFyTql0VHM/5SJEg7lCIIc7Hh0FDPaMmKmkiUHZt/AzrUFWMRnRkfvfjVcKfZUq5H5RsICkAhFfIzGYU=;7:bIQ4WH9Mr6wv3T4jctagRClsGkNLi0A/uyhYbrhm9qYZBDMuQ1rFjj9FaxPGCuMxTI5gBoFfkDFcGIPg3am6/n836vOtqVNs8pBbzX2UNtGPq7hRsGt2CFhHN76M2h+sLC9QzXKhA2Y1hik6nnRi+MYOjs/tG7tHswu/h/dFr4S2xABPGwvJ18SQHCoDoxN5n6TwmMpmxRRXYpYZm3BkUvvDpfQbCmscXfxURYpCQC88t23vg51NjYlsQAJirQMj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OSBPR01MB2296;20:xFt1qKMj8FpP0Y3r4mjtFZhNmSJ1OI+hE9l85QjbaemwATy5mV8oo42VHRCWQhGYmn33eZYF78Ot3MPmxuEkfrH3KfQbOp8j+VE4S9+0f7AanTaI4FzAZRHoEsaQZoR19fCRKgjPLDlmfGHj1NuthsIyRuri2EJOTOk1VncNJ1w=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 11:55:20.6307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8054409-9ffe-4eba-2fd3-08d61fb91b58
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since R-Car E3 and D3 have dedicated otg pins actually, "has_otg_pins"
is possible to misread in the future. So, this patch renames
has_otg_pins to uses_otg_pins.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index a6db25c..d69317e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -87,7 +87,7 @@ struct rcar_gen3_chan {
 	struct regulator *vbus;
 	struct work_struct work;
 	bool extcon_host;
-	bool has_otg_pins;
+	bool uses_otg_pins;
 };
 
 static void rcar_gen3_phy_usb2_work(struct work_struct *work)
@@ -234,7 +234,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->has_otg_pins || !ch->phy->init_count)
+	if (!ch->uses_otg_pins || !ch->phy->init_count)
 		return -EIO;
 
 	if (!strncmp(buf, "host", strlen("host")))
@@ -272,7 +272,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->has_otg_pins || !ch->phy->init_count)
+	if (!ch->uses_otg_pins || !ch->phy->init_count)
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -311,7 +311,7 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 
 	/* Initialize otg part */
-	if (channel->has_otg_pins)
+	if (channel->uses_otg_pins)
 		rcar_gen3_init_otg(channel);
 
 	return 0;
@@ -445,7 +445,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	if (of_usb_get_dr_mode_by_phy(dev->of_node, 0) == USB_DR_MODE_OTG) {
 		int ret;
 
-		channel->has_otg_pins = (uintptr_t)of_device_get_match_data(dev);
+		channel->uses_otg_pins = (uintptr_t)of_device_get_match_data(dev);
 		channel->extcon = devm_extcon_dev_allocate(dev,
 							rcar_gen3_phy_cable);
 		if (IS_ERR(channel->extcon))
@@ -487,7 +487,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		dev_err(dev, "Failed to register PHY provider\n");
 		ret = PTR_ERR(provider);
 		goto error;
-	} else if (channel->has_otg_pins) {
+	} else if (channel->uses_otg_pins) {
 		int ret;
 
 		ret = device_create_file(dev, &dev_attr_role);
@@ -507,7 +507,7 @@ static int rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 {
 	struct rcar_gen3_chan *channel = platform_get_drvdata(pdev);
 
-	if (channel->has_otg_pins)
+	if (channel->uses_otg_pins)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
 	pm_runtime_disable(&pdev->dev);
-- 
1.9.1


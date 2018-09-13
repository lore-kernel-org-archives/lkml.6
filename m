Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609BC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2A20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gmobQSBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB2A20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeINN4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:56:42 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:12448
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeINN4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WVxVoObikgPBErnEfip6fb486AZvQIMhpMrmwjOyY=;
 b=gmobQSBFFQLaUs6B/gVBvSuhhF9VwmeuJfYEUCasp+2x7dK14xv/6UUZNYy4oGKh24Rd9yzDjFQwFpai1mvHVCYCJ6/aJMd7tDD93fl8Vy3+njNFM5ipwQsR2/GwiRSuguTWsSt85EVXyKg0RZBWy8x3LM/oIgehO5q3wKErGgk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Fri, 14 Sep 2018 08:43:04 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2 2/5] soc/fsl/guts: Add compatible string for LX2160A
Date:   Fri, 14 Sep 2018 02:07:52 +0530
Message-Id: <1536871075-3732-3-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cb9a601-a1be-44c0-6a6c-08d61a1e190f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4800;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;3:YXPF+2hdgmDolpcLkINSza0NeZbsM5q2YBbQZkkI2iB32q/G9bYlhs74rFQUcBDFWhGeVsSvYi2nbq0ngVLCbwKDn6bR5A57wXO1+eMaxsaVcixJR3xIuXWpcqUGBg5F41eQ4N6oYwX11SmyzhF0mbFByHiY8Z/Int4V8mh8qypYlbE7wBZ2xRolFC8X5MjoWEI/L6aYedwfmexM06AwfzT2dLWb2t0ioN5E2q3dAu3CXL26Qebfq9gu32oPZt7R;25:wocMhdTyfXsojvGCJxySFaXDlgG1/agSQoykLsolAEL57nmzI8NqOv2pz5TDIQHXfz6YGwqiqQETbb2PLOT1c3bcml/BMDPogqw/5HbVGbbhqJi2TbeUICJU/YCIMfFcKqP0H9kN+igh+KDSvmVEwmK2Jk0A0j18olDUq8aDUTqhJ3iBYlPvSLG0KQXBmVoOofTG1DU9OXmoAiyd+iGVIM2j4KubJdWDCw9f7UG0GtxRR4TO2f5Wr6huANO0000WnJnmJoeH7SGMXHyOIGCMyg7G97JPG4WovliBGRRUHdDbHuMfkN3sjm7gNuy8v/EiwZpfLW8ycgx8YX2BtigbPA==;31:FyWhqb2CFy8lFxagsOIRciF3Ig0Z8SgZqRqZQBu/ylTy3qCLBT1Zx6jBxA0e8XRKnICUQZaqKzX+YNGKEf7rnvyfFB7A0CE5Uza2xB4+5EW5np8sOxbqZXAzS7rtIutdH6rrCM+IBG0H1IkJfdm7NgnIX6JN5c58JIW7joj7gyoMzN4ES/gOykW6FwreAi02Ue1gm51mB8eUwu8NHO+/Zk8wj7MSV35mB9skHwii52k=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4800:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;20:GgLWhErht0I2Q4wsWrPC4ZLaGzvevHFUg5I81DwHIhCPD24OSfQlkS8XBigH6mFOJ86OQSWdP23/QE2nwX7xN6PCwP7U+Yiqxobw/1c94uW2gMq8nuJJJJ7m4chqU57y0uT9hr5b0QDe1oy5Zyq7gd7xZM8wKZp2RrM2akF7ylnokO7PLM3uPjLWTkGsp+cD2/yum/Pm20GdThRbnh/iFjbp6yhjxCzpSbL8yQOuMbzi1xPxXcioVRuhTM1brqmcPoRmGvMavFACC923MgoI2YS7xn7OzGmW9ykWab5tuOSeQYAQRLbMSCumWZ9ZN3gsnbhooZvPhr3DtTZ5VO93PBV0CPVSpidK04YyMJgnakfIkETBSumsAROZQnHQscD0ZHKUH2MD3wHNaSmtyTZWWin0vdoC0bHLyhymaUEOvuC1dwURCmXC8GOs+H7ys6SJoavk/WDwPCknCTiHWIdhY8N3u+kRYmRCDV6UOLiOr+iy/GW/fJ8NI5CMMfU/RK+H;4:4NNQaCgpOllGE4PLCOHJ3BE0OQpJY+n2HPOBPmyb/nHT2Xu2wQtycW1DZXt2smQjR2uGUcYi4Tabqux3ilRhYaLeX1GKOtg99OzVzY7QPmtQuvBdeZ9lfjlRIHLd90F3LQZfTx+IhEyqQSxGKLruNoADUDGuOrCh53ODMXJlrpgqUgstOXbhh7PyPNdOfTkd6K0bubRghCr4oY1co0BSEgTsybyTqUSUGpt7AUEexhYgQ4oTz9GpY25201zb1fkrCg82ydaNRp+CZc6XDOsBGI4faeL7wlfQ5f1ae5GO6xt/3z7PgxLObp2RDCvK0lS0
X-Microsoft-Antispam-PRVS: <VI1PR04MB4800EE5C09764550BE4C2124F3190@VI1PR04MB4800.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB4800;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4800;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(7416002)(305945005)(7736002)(51416003)(2906002)(76176011)(4326008)(25786009)(36756003)(68736007)(52116002)(478600001)(47776003)(81156014)(81166006)(8936002)(6506007)(386003)(55236004)(6486002)(50226002)(575784001)(5009440100003)(86362001)(66066001)(6512007)(16526019)(105586002)(2616005)(956004)(11346002)(186003)(486006)(476003)(6666003)(44832011)(16586007)(8676002)(316002)(6116002)(3846002)(53936002)(106356001)(48376002)(446003)(26005)(50466002)(97736004)(5660300001)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4800;23:ScoH8hosWScCD7LBRqiWHNVVqoZCoNCwKVM0I7QXU?=
 =?us-ascii?Q?HRmu0CbiUSLL0lIkIC6PxMYiKxesnxggVK8TrMTvmQZfYyuOBe6GSYM7G66q?=
 =?us-ascii?Q?Gcd+yTT0zr8NmV9q08iME8MM+VnyT4jE5WBcNC7rhlP/E7l0w9REG6G7i4bl?=
 =?us-ascii?Q?4VM3cQj9VVJ/SerIYXBTrD3o4ppmrf1u5FH9ioUl/we5drqHmMZNu0GO6E44?=
 =?us-ascii?Q?bDQrBSz1QRgxfp8DPVo4BseaRk+FducpGDSWEviE1+Vd9BvtHn5OgREiuvpm?=
 =?us-ascii?Q?5J+fKJlc74SVImZms73Pbqu4tj1KOJbBNyVQ6v49bx/MZwlh3ksQpxgQlhzj?=
 =?us-ascii?Q?8ysw5YZAwgNGFWjgrYOppGBRXrChOz6aAA/dqaPXAP5jsqilMCGOtt6MjlSt?=
 =?us-ascii?Q?uygIHxZBmK9K8sML1GLxXaKD/StyY2D+NAGmOFiEekx6gncxYbX/uOhn0iVC?=
 =?us-ascii?Q?J5mit2xbqbHf9iY1wWCYyEGjWUHUV4timgezRbelQAJ9YGWaPSNWN0HDuvfX?=
 =?us-ascii?Q?oBHPhIYm4OflROfUUBa3t2aesTzkh0jaZ20cCrgI9jd8odvpJy0yw2Qd0sxn?=
 =?us-ascii?Q?NDHz4AUQqFaSqudGuL59RMH29XJLhlZCcfqPlubS9d+4epML9jGF7FIaUxNb?=
 =?us-ascii?Q?7X1e2KtfaD7h6RNKso7Xoe1sjpFo3E8oH08iVeHyJ9NEEBnExAVFnlUAtd7l?=
 =?us-ascii?Q?MibgLWBHqi2mViK9jP3Or4LiJR/tKIJ395rBgFeKldORdT5zkfji1rdWKlql?=
 =?us-ascii?Q?xwAgp/+KqbxLCasXSirgkT0ATHbG0rm2JtZmDp7eTOh7Eskc/mhsAKfFiFg/?=
 =?us-ascii?Q?p4aIRGkVuv31qeSKt/Waz3RHffCQ7PUnlwDXwMIgdykFJ5cO85Vgqc+axaGB?=
 =?us-ascii?Q?aAp2tVhvuCuuKg6NXl3hKsulzTW9bY2Ugc8yiin0OB9Q9l9TPsPNuuUI5eMN?=
 =?us-ascii?Q?tS1B/QB/zG3ubo4eG5ndFAulvg5rfPriJ9N8JJCcSJN21zIwW353q8mp1yt3?=
 =?us-ascii?Q?5/i7w4hkQ6uuA2QVomPKH/meES06ZYxl789aQnggarFRxUCToDpoBo/7imUJ?=
 =?us-ascii?Q?mXE2mYpX+PBlIJOX5YiGVkE+TXdEfJm0io7BgeBNWQDNKBrBJBKa9hG/UqNR?=
 =?us-ascii?Q?nhQ2ygBVy8Io7GuJKS5qBbc8IwLYGb7br20zu9ZPZUph9UHVA3D617cDjYuL?=
 =?us-ascii?Q?BNF3gfVYUPzZw2TS0P+YctC8FWKwm2FGYhzj1mzddMHWuxCz5Hz6qsxJg3a6?=
 =?us-ascii?Q?Zf46aKDevd3Ex13a8LiIhovWCEvRWijNe/7x1bj4i5/XeKG+jSdSqOh0NR7V?=
 =?us-ascii?Q?4CL7dT9ZacsekPpE2m4sH+usCzVyuDRR+R0wJ/borQt?=
X-Microsoft-Antispam-Message-Info: DXqHG+hyObng5NO9VLpKB8uS6reyiGsKFfiLlg0kPupHzqj1dNbC8AKUGffUqNBmK3CmsdGNlmZn/HLw/nhtGfpTLGIevic9qMeJStcFz6P6J7glNZKFldm1grucpujxljwAON7wZtpj2m62WLsF2ZmJJkLOBmKcxh083Vn9XU9/tnHO5SNDZm/qtngjH1SgXxiHFcbOuLfjxz/36kbBE1D+aoT3PID3M+LeS6Bq6aOgwWmxoEy4dbnPUPmzSoRRYpMTMfN2+W9ubH2Cyo4AZJTC7Egyj7jZOmLfuCHt/orxu4bMqX9Qr4KU916nFqrCBdWIlwHd0aIekNU5lY83RzehuwP+/MHg2Oos0K8jFhU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;6:d69SfqJt1aeAygpTFUUds04+aEKHReSjRL2gLC9j4LnVBnAH24k2smRFvkSSZQ7ybDd4PMQauezK8RZ7WlJEjwR4Hh41XC9vUOGGCq0sJflicTL35+enempXC6CFSDmwvMaHBzmsIvo3VKcEgTv9ncjs8ZkudUCa6E8+ZNC/yxzFTebCmpLK7mKoPhI0GBsORuL1MyQBXWO+lmeZX+YauuJhtrq2/yRWbl6/FS6HW5EPABa7Rc7Uy0Hn6mAjjMwvOyO7C9fDhvQidzewsQUJ0UHxxjR73hab386DKC3gowaFzOGD0rw59EhG3J4uzOQIk/zNKVY6xoWwVmypJm1x0DBU2vLhlEgu7uFJz/9UPWeiRAi5/D1q+PJlyb0pQ51WWPBcMW4XPvBg/NqVHIZQ3jOEadY+d6C/Kbl+x1ThXRiI/bOu4N4xqKvTIPDxbxenkqCZqr38uiunGx999U6nSg==;5:4V+IjXy8jDgGkcDFKmsTA5DPxJHfNeswAPeYR2ew9RN+w4Jl7+qHdxRaa3FWSHxE9TN1hkLxaOp0btvKhA5qOhT+cOECm0/5hyboEqcOLI18LdNxpQNZKZ0pk9dRWBnzF/9ApLa7eyHT4VKHjaRvNW45gGFoFVP0I5M2CTU7zxc=;7:iICVYpMXmXY/yJi0thMzL6RnqCxot71O07SaKWawV+mkh49j1tmwMGUqeYxZPvHxhV2Vlyb8r3S89lKmuBPaFcuSgvMg7VgW72LJ5mFT6z1lLVtLshT1PCThYHnOyL0gvsZidIrKxy9vTMCaOT6I6AeWNA4G7tvyNFf+e1bxo9gDXqZ1/xcN4UT/qouF33flJ/0ExtahyTQYBla45Xd/p3+/vCmZZTtcoh8ydWWwASq6JxPQnLvhY7eu+VgtZBpF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:43:04.6372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb9a601-a1be-44c0-6a6c-08d61a1e190f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/fsl/guts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..5e1e633 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -222,6 +222,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4


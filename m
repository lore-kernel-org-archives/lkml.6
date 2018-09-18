Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A86ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B52120652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GrjkX0nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B52120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbeIRL4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:56:16 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:3250
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbeIRL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap//2N3XgXIs0vcxKMleyRK45UqgNYAKxjGmzKm5sDE=;
 b=GrjkX0nMBidLDbH7ggTEsYiEe2aWtjWzZc9I96ca84m1EyZSng6vwBwQbWfZBTTumQk9udxsIec/BikotOHDs4oEuixoAeLOzMkoe6JMJkIaXrFyq2M+kLmax2J2JMuBGt5514GWtjK2+vTgobes1mIigOvaIaq9UCZOPuSuw1E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 06:24:23 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/4] dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
Date:   Tue, 18 Sep 2018 14:19:08 +0800
Message-Id: <1537251548-27845-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf2b3f98-f202-4e66-13ee-08d61d2f632d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:IuL2GFMiJBxWdF/xojf8Qplt5ALMIMRiNHm6rcOMi/OUigftBj93EKA/4nKNLNH6aoEGl18fGmOKK/almb401CnPvv950NJH29TGyZnSexCnm5gHwS0WG1n/LGilPmR5KzbQyAjUJZnGCgZNZQ7cBx9uYRmKv5PE82LFzTSvqihhbrbvoCuo+PWd257U68CHIaYZ1v0R9kDBP3vk2Ce1lKTUbOwZlWPwDH4vTpTt3Ol5LivgDPGFq3IwJHwLAg3F;25:jcknC1Vejs2hkcZWyJtE1y8hCfbOTijz0RAE0uJe6Q98TtZkm/LK0czLU3ed1Y5HumUWrgEbvPlSp8Soh6NW0/L0HgxMBCUIqxJvbCkY2VLkXlgiSt2qwrmpks16frXipEU0xEkx0HE55TgmH2EmN7sbYzxy69OHMJR5d9DBQzLmoC57kOlD9VJBvenjY7gTOwotoD4YJHbJYFkcIm4QIFFxHrQgEVM9aiipCJpd9M2HIJBdJR7o3nSOoAG7CsZX1wGkD404GwV3+W0kgf9Db0/s9vHeLGkzX/1om97+wHQxJBd0lX4Vpp7UhqNN5tJjCCga9XGJ1PbkuELXDimCnA==;31:3S0uLliFZAwEcS0afvdoeSB+VQxamO7d6ebql4nVozRRey7dqINPquo+UCIhFnI7lRqOp1XX3wPwFjgMO59HcqMWQ7xHUUMSfwoE5It7SMzN7eenHkF1XP86EnllX7iQ0GHZNTUxqWGGG7QlJs/FjsSv00HNAHm9w8gn31XYG+cxbBWYWsNPImelFi/SwUt8cqrhcRujMLzV6P6RJEjie6z8OHs2rIOs9YDbbX1aG+0=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:TFwIosGxPNiGjYEnNI+jfzIpN8kOotqTOazpMDz+dyaYRfPReP8j6+H4uulBwLWkoJtf5+Nv6LRKWCx1y0IJh4sXLLJOgQOMBf9Vj3d3vo4do5IbNtvUmLMFLgTVGEgJYDh7yydBSxxFj9vLa07+icL8gbS6eqElqwSt9vGj3FP3zsF5rHn8EjyYRn3zDrThr009x1PSQAHNJxyZVtQOlCmsY/ToB5WIIqvCjL9uOwyZKvsLwf1iL77VbBhaq+0NWJmB4ex6/2B6yxsEumnY9bhCfbCuqjfQ3BpdgyJsgDgy2u4W0vDVZrY3wVypIbYnrbWYDgBTbi1FYkr7HW7veHFcqT/L/4chAEx8u9eoHRHAb2ec1HOU6BtLUDbcJW4/9K4xOajs+ZHPS9vWZMoRcUmCCXb68wfzBSbS2prIwxP84YM03GNfArdlftA+QpesiGAueDe85IKzsZakyqnIRFZv/F8A1K7vHhykavAtsKD9gJasIoqpRDhwBD5S9+s8;4:imOIyK4FAtkh02jv2JGVJniNFlN4g1h4APKm6XftwcUkoQ6T1ZgSshEUmKsqZgcdPc0T5eoNL0toDqICbMPoVRM+XMFcrl5j3KKb95Y0OfDoHoV9/dM4QLcu+jA/hXvdb3Qhz3MB/u8CYGP/YUxmsk236Lv3oXjPr7liOzbHqeQmcdzwSHvlHwy0ut7qY7SMZZMeDfirlrnUkzzxwWai19NvWwkew3y4KPerTudOPgwd7Lfn2pzgOgE7h8r6n0WYiyJ3jExttL3rtM09pOhzKeP7L6jNT7DTS9AC7+Hvd2h7yfLywcUbIfJfgOAJi7TV
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39152A5DB3A733E13108056DF51D0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(186003)(50466002)(50226002)(8936002)(47776003)(105586002)(106356001)(478600001)(68736007)(52116002)(2906002)(76176011)(66066001)(5660300001)(97736004)(6666003)(25786009)(305945005)(4326008)(7736002)(51416003)(26005)(316002)(16526019)(6486002)(3846002)(6116002)(476003)(2616005)(956004)(8676002)(7416002)(6512007)(53936002)(6506007)(386003)(486006)(575784001)(86362001)(48376002)(16586007)(36756003)(81156014)(11346002)(81166006)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3915;23:wHA/cD9U3ymyTu513d8iMbtsLHK+u1eaRt6RriK?=
 =?us-ascii?Q?qCzQS6yv2w4wP0TMN+mraho/d5aiOLwpPCdDYnDKZfT3BzOEYcfEQa3056RL?=
 =?us-ascii?Q?Vm0vpl7N80uM3jp3XDbL+X240NEZ7i8qFC9Yi4EdE+yARPxZpCGvLqPMIXqM?=
 =?us-ascii?Q?U8rdGgJvjMyWDr5CDtdzDGInpk1YJHPvYwNpRyDJsRObMe5wYydPUh35ZKf9?=
 =?us-ascii?Q?BrCKUlkEj81ApYV++IOaRnv+abrZB5YrujYeOgGgpwMTOp1QXukHLTX55dK3?=
 =?us-ascii?Q?4qu73IkKNOPN5FcZINVIitrRmBkXYmZkQWzgjEsruCAhUNETUFeb60ysWnQm?=
 =?us-ascii?Q?kgDywx5KqGSG2CUHrG999Q/ndsq0wGQ92i0CHviPB1azRA7ku/zOhJ/zri4E?=
 =?us-ascii?Q?67ojBhtd1B8e+CZ14QbTViCdsJ9bD/1cG42EvyZ8mIBF2CpflX9irmUtYikC?=
 =?us-ascii?Q?p/Nc90kt0JL1gwIm60upihz5NFr0f9rEQ89D7k7pVsbBBV2F3HQPPylYFirw?=
 =?us-ascii?Q?dIFJrxuR0tko7Qcqx4OYGIyV2hG7cnttn4UmeLOazc3eLYmNEZnuFKgb8GB7?=
 =?us-ascii?Q?b9RnFQi3nTBIS6ZUK2lhqEXy+66IwBLQGqgBrwTep4ks6S1QJjzHOFH2Koc/?=
 =?us-ascii?Q?+WMN6W6dj9iCGFY3lOuA4oaC3nX3mkjpHIzNaM/ZCmWJBgU75SglXaDOHPMB?=
 =?us-ascii?Q?GIOZcrHdmMnwp8GFFPe44Dkc/CPooXYtOGjFo4FpPHpO2q6KK4RttG9t2gz6?=
 =?us-ascii?Q?CEkKexGmH8TNr9VRuUYqAgTvZzdigXx+aet338eRi4LijDIJVKLwIvYgRF2y?=
 =?us-ascii?Q?KioH/MKcMLlB+zP2Psxc/Oj4pyvuEzsMDxt5fjmo8WPuPCnVyK+r1cy5tgSl?=
 =?us-ascii?Q?8E8wRwLFNiHM6/QEmNed+K1LHMbpxHwBvbN8qLQiNbFbguBsv3qLow81Cd9S?=
 =?us-ascii?Q?M/zTWBlYAseWv/FOnZ7PuTaKZxbia20g00tBTE5qjprCynmuBeMRCeu1/6gK?=
 =?us-ascii?Q?NVQ0LsAUNN6GpyUSzBfX5VBtiSZ1k9vOA1oHkJZLu/+USKcBb21gJD7s2p37?=
 =?us-ascii?Q?9CiLuerbqnlfY3KpuIL7HCLLhGQcbAT5v1p5c5l0a1BOdV7JPOzJzyawo02M?=
 =?us-ascii?Q?kw2mFAwFQswkOlYqhC7zod2Fj0+95v4h7WRhItrIDJzbHW+8rlY1GQT3L83N?=
 =?us-ascii?Q?NaKXHd2hbbI75FMgC0cz3ShrGbaF9KLTd5fYYRxWKDSCVyp6yCX9tmkmkng?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZvWi52GToDHHjai8wldCmg/EAibryO0LE1hqQZtfjz4/apdIG9GYrnoHJOrz+/by4Ixa7nKsVpvLKl34oEUelEyhAYuIYbRFZvZE6McwUY6ppNmWmxVvRGaOKDal/1Lu6QucPZhQ/roS5UvvtvQxf/s8KXFsCHCwEAh2B3LjaXxeZDoTTrEPD+0bIV+Zj8URPNcemIyve6JO9RRqDRoo2l9H1BoJbCpO7XumwrR56Vt7HYAV70Qs2bxJ46tjd5GPiTJlNItDUfnFHD58605UzwRaoZLEdQ/Ucpk9JaPDS0SKhRxmMeyX61AAP0K8Q5TdUD703CUWAcVyaPnPYghA0C5p5jeNJhj6ke4c6b6ACgU=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:uTNVDYVZ5/kGdTJ9q6qkeFNF8jaWYwsGesI/orkaqEIejfbE98bZCQtlw9wulq3T1K4fwxisbE/gfQHgygUd3r259Caso1P0eEYvur5L72RoHNVedJbFIEIb2kFcCZh5hbDiElEm6PGw/honKU9KvbwrBHq0Yw3ZkNsHWvEJjvR4jqBHSs3BFcvvsRKP8CU/rld1aEUtrdVujLxfWRgqIoh0NnUVDZhC9w65VkWit4utOlz4t40KrhCxqDqDiLHhb5opkYrmf0jHqE+0XIWZwtt1JhVNqmjUwCLNUnZo2JM7fybdiFqMUmiIxrJsdc79budRA8czcDtjj+8WJJ05J1g1YXlwSX+GICzaVuDU1QFJJtr33JyfBE+nLEb5iC54guh6ldmr11KIxouhMqL8B7HYf0gvy+KZWM897LyKczW9f3TX/RxcAqotYO8ynWF3T+fwcU7k+RcJKVLsN0GeDA==;5:FJaumxrQKqFLvWu1xlUV2HqIKN8/DS/P0mdClfdwkmRH+byJ4al7OSujVB/796W9g0q4+lSMoJjqIPt0Tt1vBF9VnPzGTDg14ai/A2ZTLfqEuNNGwLgroUNAVFCRRao3SbxEgECrsrblUKwfhbuQ+x5vf0uY5HCONVKJDWfapHc=;7:3Kv49/19fOrLr84BVfhiKleeRWx/EsIJ+9a4fM+sA9jyuGSxiYAEcsigVP6Al+XaUPap7p4dipvnTPPWHkZty3N8ifThdjR/RQGudBoC22l63FL/dSCRxElO8o+19xRoPGX5MPIhDnX7I+L16x8d86lfp0VrOWuGWHYWqSKVr6GOneTI7N7cbSHum4TZTZ97Wi5WL7qXYQ7o5nVtnZJ3umFSCaAku5KsYCpZJnh8d6t5iSnSJVwNGREV90b8CDF7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:24:23.0652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2b3f98-f202-4e66-13ee-08d61d2f632d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds compatible for i.MX6ULZ 14x14 EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 968f238..9a0ffce 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -85,6 +85,10 @@ i.MX6 UltraLiteLite 14x14 EVK Board
 Required root node properties:
     - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 
+i.MX6 ULZ 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ulz";
+
 i.MX6 SoloX SDB Board
 Required root node properties:
     - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
-- 
2.7.4


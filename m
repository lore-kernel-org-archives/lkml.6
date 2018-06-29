Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE9123DDC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPPYHb64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE9123DDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeF2De3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:34:29 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:31136
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932140AbeF2De0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyychReeLXpv9HGXG6iAnO1rJWl5RiYeip9sovYtsqU=;
 b=gPPYHb64qyQ9sBUQABQymo6YMNL77rfHYzjAd/QFAUHHTyJ96ffHqr3FpRusk/N4XXoLOcfQQsyXvYWb/M1FyaOvc3mBQNIHSm2vlmgxh8q+mJJYr1rcdMqdjaGdl68eEDk8mwB20o+EKOVyKPSXwJzaxlKxG5stnUqMZ2uXE1I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Fri, 29 Jun
 2018 03:34:20 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] bindings: add clocks optional binding for imx gpio
Date:   Fri, 29 Jun 2018 11:30:04 +0800
Message-Id: <1530243004-10529-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:203:2e::19) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1c3f3e2-f4f0-4c5a-4e31-08d5dd7134aa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652037)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:hf3odNFcoEUDAlFq2e719el7KujQ/hzFID86OXeBEJUkNL/88CzVGgQEoJOzSukRyZ0l67hgHAsUxeA5/HLfT+SwHmk+HJYoAA+B4+vJvUlG6TZVn3fP6XPhPuuyXmEJc1tN58JWuPaqm4GVkpe3ZeZfaZ26Eaw4NmPPClAmB2pZyCyFTJZJk3LVJKLCNIyDhwKvueyy+bk9obEjAL2cHjy+Nssrq3rYhc6DXs5/HwaXtdR0p12tW53gKG/YzhPc;25:Rr6IfiDlX7JNud2cy4QEf/vCXp/0Q/nfdzHtsIe2Hd6GGxYBdrnnILAmrDycngA15ktt0LcWCl6lWJg4mC+nn+r7T+UsJvLoFII4xYN/618+Ffi06HE6xtpOZwFEbSp/tPdi9S9CC0AvLJ7fIEKYx1JM0T8bzgnuEBG19b0KSZP7eHF+cCXNwuyWBR+8PPuSmPxq4h9j9PBugzGbM9YQI8Q5J2CLCGwlxPtgjM+l6xIVaK3OKZPz8njfz3x8Je2zzHWEGwqMHqfBkzKtY12UxTGIEtroAEoEu92PHFpI/SeEVW2iNSeIx2KwzNvDkjMVCx9HrGojtw2pgh18CSCp1Q==;31:3I59BC5RX+/lgNAfLgXit1y4ZVWqS5CssVedohPp04CBzmC2SFPe14HAXXligPBg5bzu6fJigO8hipFhJOOzqi+0dH6lIOJmN/khfwQ8nST7yDw0J10LZZG6SrqW4H87XOG5aVRIS2rpoyojv/z0n3q3qqwnTxLb2XXTxNcpc4ZLqjwH/A9xlXToZxee4zeuRA0DkVi9ryXvqGI9J/yKbxnvAPEDsPVOjUJziuuVBEo=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:O0HqdLmtSFy91Qi426fN84EaIbQq/cxjBucJWZOTXYdYFckLd+8agaoIkJxMBwBVLOvcjyK7bM4gyuoBoxmnYDwftlIP0ezon++qKB209BK1ws8kYvW8kIAV6aGcGbYeP3EDpXMb8Y5UwiHgoPKMGGDEs9i+ZuZvWROxyZILZHqigERrj2lCRLiuTCczR21rgPFAnbJ1xw5HrLv/SpjAvwhdAtlfQ6ZWLl4lSd/wLIVuB0HwPt4tez8y6EYRNJhtqhfnzVGFQ9Yd0FkIRd6z/lLr2JmDIBL63UDvKER1RrT6lGysPloCussV88UGKb/qhYl8+zUQPjEk8GDj1f59tPXLxI6iMsnStqeSrrmlve7HPmlpkIMKVwR9glRydGX+OSiMdFACm+KX3Y3pUPH2v2e7vIOeLhKIw/TxlCHEvQwILSCt9G7Ez6FlN6cKHhYTqY9vuPKJShXENkHgXRNUK1sAM7Y2Dk18wM1dI+katoSme86ywoOgoIDsAfirmwjA;4:rr0jCxhastJikneHfqLN7seZ5wusr46l/KNxbPi7jQoIV31LblTid6IIsbITeyAdDGzIVCkC1W5tFjK9nc3jtikJR/NpWyvYW5FrwYCUSNEf5eEQ0B00D9lWQWxpg0oVnCuGLJrPzYIJtfIYvJXmgI0oSuZHfXxD8cCKb9frb9/4pz+olFLC17IC53CDXfaURZQ4IluhVOaGvIKOhEQ/wUx+sxAEHtBEMJAnWd7zpDGJVKfjVpfBivaD+4y5apfEhwpTSdotmzuyd7njOLa5jKCIffgEPE2PQqhBxH2rK1GbkZkIl9eG8w1KnaS9rruk
X-Microsoft-Antispam-PRVS: <AM3PR04MB13150EE78CB06C901685DCEDF54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(81166006)(105586002)(106356001)(186003)(16526019)(4326008)(86362001)(47776003)(53936002)(25786009)(66066001)(478600001)(26005)(36756003)(476003)(316002)(50466002)(3846002)(48376002)(2906002)(16586007)(8676002)(81156014)(8936002)(6116002)(7736002)(486006)(305945005)(2616005)(956004)(1857600001)(6512007)(97736004)(6486002)(52116002)(51416003)(6666003)(5660300001)(50226002)(68736007)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:VO08vwzReZU/T9QZhlpbdWP2d+IzGtbt4XItrNyZI?=
 =?us-ascii?Q?SePFOaqSPQIKctSiO6Z8qwcjpUxwjb0d/nrhzPqVcBVyyZw45ZLDwT1daOZD?=
 =?us-ascii?Q?0xD4pwNz7VISPxMQd+6mcgQ3V1y6DW5iWGGoPAVIiyJ5FzO8yPy0O1FargQN?=
 =?us-ascii?Q?GZTavg7Yn+L479OiGMYXLPEI0nM61gMwcapj2g7Q81Yftlph7/9EHAX35SLI?=
 =?us-ascii?Q?gp8F1l0BtCpr+Q/M3gn07EUBuVDDZsNYvsMD1fmZR0fQqwskxg1+Uem5p/Yg?=
 =?us-ascii?Q?Zl8DJ5giwbBm05ZlgQmi2FdDhKAWie5aGHUcsYSCkHQaxtVcteIKLzqhPNfc?=
 =?us-ascii?Q?/ipoRXEGF18pL/NBO0p7P7cEzJG3A9oO2cvKPLIF99WEJd9FFyUqB/tkSrie?=
 =?us-ascii?Q?xnYBWbFnKZYEG0S/63C302YBFPQ5+DoDf6LHVXlVVm69oZBUocdzoHTNX5ds?=
 =?us-ascii?Q?xZeHqZAjlv4ar+oX9c5Y8QvsTJP282UwRhiXuiWmKWdx3vazaDF6RMg3WO9P?=
 =?us-ascii?Q?gOx0WuXxmxEkMOn4Ce7UI/CMixgzmjM7PwI2evk+eHIQ8mTandURQimuf0yp?=
 =?us-ascii?Q?eRtG0E/MkMfoHWiD2+YuuxAxG0dsyFq2Ptb9NRlz9T1l84yjC8GyRcTU5YU/?=
 =?us-ascii?Q?K8wSqSeYAtUQDqGiRzCvr7VMe0aKXR02D4iIBNJo3EK7hh39JMd8XKbKrk5I?=
 =?us-ascii?Q?U0xSW4F8v4IvYAXcZPJaQDrFcoaHQz+bAKBTnzncoe+scoPpZ+RYVczl1sAV?=
 =?us-ascii?Q?EVdp47WrsO/sQ5rzmylG6wLL0Afa1IWjtbSU1XivoZjAS7K9rPklMDpy51/g?=
 =?us-ascii?Q?2sdTDZnhAmbV2DS6jjxCzqdhmsc++zlPoCpsuumW51OAieKX/2h80dxIFX/X?=
 =?us-ascii?Q?LjtQaMIbf0neyTDrgTx0kkZlelQzXu9X2kGhiXRqPgFx8u54dkNrtv0XDAAb?=
 =?us-ascii?Q?YSriuWTHWtGeNrRbwrpm/38QrpKj2JE9bImKFUSWwobid417/URmlA05OSId?=
 =?us-ascii?Q?+lz6vBIiYyCgewW7DduwveykTyFN6gXqaaIXXtJ0zdzu+vRW5kj8n47bgcRX?=
 =?us-ascii?Q?qu5+uE3tgwc3NX+Jg2lx7x5M92Ubng8dCgVQo/j96gbbZD2/t/Py0u4PANv9?=
 =?us-ascii?Q?OyLjW37+r0=3D?=
X-Microsoft-Antispam-Message-Info: 7YqQkxNdWeGLuscz5uRuMbNpwTsUl7J1GdLLK02Hy2OTMMNzco2/iRAgQzjquyTnbx3POW8uUcUl/kb4H+Cm5jzon4TAADmqTH8C2yMH1ZO4m95MSXAGIkPh/Q2CGwP45l4QsHlIP7TwG1sA5XTZyfXmdXMFFPWwIseKbQES2O2krUjFfPktHfeDutssy9D4NLdNZWystc8S0Ie0vn75+WaDWjvbOYEcgYaWSdiiOHER8QtWROsHQgK1n4LHaql+OCPzNbn6WYF5wN2Eo3ZCqWSf05kGR/EJbzH+Fyl0M056C01tgh50d8Pm7Pm34VnKvK9tosgo36Y4wOtRZX4oP/tiJkOGPHtoyTjX6QXCets=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:tNL+i4vvaaTeWrXcUSwA3jt0MZkOeRrT2CZmF0Xh+CCiqa6kZ09URE/khbn/JyRXajFaaCap53DwVbKetKO3IRJd4x+Lc6koV58mIebJQuxFisHoD9QVQuP/oMcloNURIsyRxyJl5TjtkhYonkIw2GXdJYU0X+00GKpneo2alnFzIGJ/zkrki9Xhkqrh17aUFL6fwfG3dfRmKaOb5wtFXIsFC5wciHH81yKSDftkYVFlgL/lBILSA+LiN6/ma2/f1nXOxJeLwxklBPoo6pELl1ZR7Sn2Ko7FDqP3FF4Hn4z5tpzv83uQp+dPBk2aYSCQ9v9cIhAcXaixE6H1/d5pPu+FdR+QH6WUNxBlZXk+KmEtVprC1hB4iFOYJj1VkAcJiEOLnf2NnAtWepiunGVZF4GESFO6PvIByOMl75i0k5A+h+EDkcAThA1RYz2oxomyOx9NQOCen6wQ//aoaB5Y8g==;5:xchrt2k7h1WFRojsOwWY/GFBMIPUqAWnbaPupKvOXYI4hxrlTCg0yoh6Z5Uixm41/scNRJ9SS6b/7FwISMw6PbHc2R1KdjvdSdWPXnUQwW4gd8kh2/QaGJD0NpmCNRbNAOaqEwiG2Nyb0Vvs+ZIMv8uI+1dn+GBbFiW9HTc3wE4=;24:YuvxRrXekz7kM3EC8AD+6dx3S4HuKzvZSwc9ftcTJ8QfLjXBIH/FMzVvDFTktZXb1cRDW371Rz17S27X+7VIPIp2GOhtZZvUzwMff9gbcdQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:CGlRNdyGotLYt0oWpX1W70gNUdOoSyzoBx3E0tTFXNC0shODPiRxDmCneBKoBtRkCvznCbLr9wHCNzap2gCiSMi3ywKilH5FzNHiShMvxasX7T6UljFx0iMV01AxDE+5DCxCN7edVovFI7aQVZEGgzQAo+i2GYiLxe6EIPTqD6mY5LkN94sKZ5Tgy2B7+jp8E+JSLiKtrRFna3sugz4qq3yiNWQz6u5V7yaJktYP4+hbuN8Y3BCzB9SWM2/xpKoz
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 03:34:20.2963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c3f3e2-f4f0-4c5a-4e31-08d5dd7134aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some i.MX SoCs have GPIO clock gate in CCM, accessing
GPIO registers needs to enable GPIO clock gate first,
i.MX GPIO driver will enable clock gate if there is
clock property in GPIO node of dtb, add optional property
to i.MX GPIO binding doc.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
index dbd22e0..1b3eed0 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
@@ -19,6 +19,9 @@ Required properties:
       4 = active high level-sensitive.
       8 = active low level-sensitive.
 
+Optional properties:
+- clocks: the clocks used by gpio bank
+
 Example:
 
 gpio0: gpio@73f84000 {
-- 
2.7.4


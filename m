Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BB92082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="chEEA7b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BB92082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeH3LEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:04:46 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:2048
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeH3LEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFVg6tZ63JoD6DY6DjG+AURXA00BM+/eZM11++MV8/s=;
 b=chEEA7b4HXepHMbnZyuZ5YMLTf5QF63feSrpKQi7CXxJHHNQ/o3E3QZxbOPKGbzkReqeMyH6RXTDsRw8w2hifzAKp8REgg47W+fQpD4GAUyG+PZ1+7xALU7REvnQ3r1YbcAwrnVTNQV0ZpOSblA6lLafszNb8nLqmVhNDMSnF3U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM6PR0402MB3909.eurprd04.prod.outlook.com (2603:10a6:209:1b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Thu, 30 Aug
 2018 07:03:52 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6sx-sdb: enable gpio buttons as wakeup source
Date:   Thu, 30 Aug 2018 14:59:39 +0800
Message-Id: <1535612379-8793-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To AM6PR0402MB3909.eurprd04.prod.outlook.com
 (2603:10a6:209:1b::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f13a5c5b-42a2-4330-a2ac-08d60e46c0a8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;3:FGjQVtFQmEaCzKshQNTPZ851TlT7FAbSnoo8ars9kv5Y7+q3g0gUitjIRS25Ron9oq5RVVKxh84+gjkGhAGy/X2+N6fVODZhuLqoMoNTGZ+ybl0ddc3y1pF3CFYdh65p5Ur0j3eDewTddBa/1HJCrTzx5ABp7SNER8ONS68kVC4BCqQJ+rrrYY8xBPSaDjl79tnOoYP2ekvYjZB2X1BwJ8W1mhFCWZRTM/tcnasu1CZAt6AoAuDv9rAArOFOMSAw;25:vneQT3cdYU7xUx1q+u6uK7S7U1TAWJHm87VeVvOFJ2pdkKKegt40X6L4DUlBWayoL9dFacohjF3N6AnHolaDa1RwaNWDMtjmhrMZoy+WoWwXgGCFHbx3CWktrr7viy2zKN5bfmIoB3CLmN9qLWsQnpKXmD8uQ2tb/oggwz4+66H6bByjOFnGNMyi3cCHX5uUjuYL70G86/GIEBOrkb6vYp9J/f+HJEAKOz4DC3UE6+HZoPkuOReGZ29GNeNGeZ63D77W3pLsia08rOu/rEP0CAmJ56+G1bogBPp8js1zXBa2b00xfQNa7PKf8JYcama5MXmuXSGIzH6UNHyNa9q5RQ==;31:RPqTAYW+pI8U+zX4D+iYD0eZRHvDj/LHXPWI+9MVQzvLDqZRZ1NxQHrmnIoo1PvQzW9SeQ4piTDaukDU3Du/8N/DLIO1nopn+WeY32rsQkg2yAyU38BGAY/xndmezOQBgJPnrd6rm8QGpCZrjuQ1xLVfnaZ7+XpxBeaIQIO5+kgG0OVIVGqM9584szjlpvTLMZ4VUMz4Mb9rM9XfyLFmWQ58am4lAFDjIOWLJKUDCCk=
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;20:YTpfsIwr8pTj7DuMasnmXZB+t/FCSuJd4gFEKgCczUCfjsAnsxZ0FxIo8OIerdiyxh+mOXPhOeP77csxrE0+QyxPTwjGznfDQgeZAbv1Mp76TmYaI97p/CaHSH/ntYtHDjDfRosJ8srPHc6FHqwRPGvcsSd3OW0KSwM+DCdRy/zoJAYvKq3xP3rXSQlPCiry0dPbEjbEVzkM3s9odnLfaeN2xaM4CecFgmGdeV5Go9Tv8q0N5BiqS0LwSWuYxuagmP3E47D+4e96TclxoquqO2F7nhxOjYOQYJMgdKK173TSubWuO9nImJKGsNc/3ugLUxC0lZ2+G5OcrT5McIQ4nhuCyiey/37oW3qbbkqd2AZWmsbgHwyUVExNxpDZ212l7jV+coOo4/Gbu9akFMr5RgiIWdrGGx+7RXVhKe8ItAPBvM5wQ9V/FvIgEHDCx6lGQWHAs486Nad78obMAIklAwHLBmC6MdcYJWti70s6PqdgKGWz03VwL1/xpsYGJFIp;4:FwPcRepfhS+eOIOEcxFNL7oFMI4NroPplyK4wG0nc6cDgCk5gMAq4/Ty9ArjAcV718Arlr9o0QNwnLtcUbA7K1gQhAVQhByTNGYxetyE/1YVcaZmCbcFP9fCcmpOWDgpxhBCzbezM5NKEKOlrRCtWLUCsKtDanUk8/FMVelOA6IRiJr80ksFjZahRtMntHOa9KV+ZPwi584TrwMbm/yEMs8WEJ96WxleP1/X1pFgnA+KSjp55ZsNWwCKe2hTFtOYjseqgROIlugkXiw7r7YKHavKyhF0oEE90cdz2ryoZtymlongyI0bb0zD0MpeYwsm
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3909BAB0428CAB38CA34C3FBF5080@AM6PR0402MB3909.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR0402MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3909;
X-Forefront-PRVS: 07807C55DC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(386003)(4326008)(26005)(51416003)(52116002)(8936002)(6506007)(53936002)(16526019)(478600001)(1857600001)(186003)(316002)(6512007)(6116002)(3846002)(2906002)(25786009)(106356001)(86362001)(48376002)(105586002)(47776003)(6486002)(7736002)(305945005)(36756003)(68736007)(66066001)(97736004)(8676002)(50466002)(81166006)(6666003)(956004)(81156014)(5660300001)(16586007)(50226002)(486006)(2616005)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3909;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0402MB3909;23:y0ax5qrukNNPQcPMgPdzkx2z1qRj4+HHE04j2n5?=
 =?us-ascii?Q?KO6Ax8f9PJgiFuXasd5axY4BS/voLRSfSzxaufWgTeuVFVkAWQwFqTMpNgkQ?=
 =?us-ascii?Q?2dvBNIB41vU/rX1hMwB3TfadpIHB0r3Lo5pzKzpjeHDr+iyufAF0iW9IEY/i?=
 =?us-ascii?Q?XzC3VwfkdxDRd7uKcpuZn8PP5DrNrGdwa6vDsZwr++LSxa5osP0TVIfYVlYn?=
 =?us-ascii?Q?0CIKyNsumS1RWsXKmSCWKq/cnMLfLyAmoMjlB3G0GmzVb4sWJlQkLLEvDjGK?=
 =?us-ascii?Q?FMOAVyLbteHSKrEHKvNYvc08PVglGF7LaqccWgNYApR5V99g4Ysl+MS1qz9G?=
 =?us-ascii?Q?zekhWbNaltjhO1kf6V0JXI3crMhJC1rv1TXz2YuYN0xPs0ZupUjH4H6lsUZ5?=
 =?us-ascii?Q?x9b7LAHfPOVVhMHoiJ0pqYSG4mrpU3xXX4ZA16nuheU+MW9y6CSTExC7397G?=
 =?us-ascii?Q?JEvHOrS+A8FGxlbo5c/p/EPUx0U2W2FlNC30ixYYnVB6TkJYrXvR/WUO8gfG?=
 =?us-ascii?Q?uDBXFao3gB4ip2K/A+RJaslYJqjsPBmzN825bfRek/c7dWMBZu4EGMn+cplB?=
 =?us-ascii?Q?qDEl6yhp9D33PIz6rgsunV4LYWxqBeoPOZMoQ3IwVg+/T7s5S6JDEM/RiOQ6?=
 =?us-ascii?Q?5HF+64YsbshtKs3+Yz2S9iqHtvQtfmxBAbFUgh8Do2id6nfugF2rCNGXiam6?=
 =?us-ascii?Q?h8m3arYF6xf4sA/f7YU7wYSWxLIi03Jz/TgzM+VLW+jkW16jQqHFYpzX/FXo?=
 =?us-ascii?Q?MHBvOeYI4fM7KI60FBgAsgY651bEPUy528sOrDajzW9ptFNCOD34JY+lvS1i?=
 =?us-ascii?Q?baMTpx9EIJIuybIyvlESpHKvTmvWx5bXhFkzPHbrbmwXMg2F9Xb5B0+8FAMQ?=
 =?us-ascii?Q?/KuQNpmXVDFFKi/dVPiaNMryByMTv3Jf8RVXCEOC7u8NARVYkISI3pewQMR8?=
 =?us-ascii?Q?DzzPh59FXE+TatFRkivxOaAw3G9nb0CGW1DeotGy7TfeZQWEycUhRAjmIBpp?=
 =?us-ascii?Q?tr+XLpKI7VSFNFrT0Gi2RscMdvw0QkO991rDiPO/kbd87X3pkLVlOBXZ/lEk?=
 =?us-ascii?Q?cdn04qdoxm3Xb0dcDouFzj1CUcbQ5yrEGCeYYdO74Kpv/Ufkx5lhrkeTiz0S?=
 =?us-ascii?Q?UPJOMSeKe6ihshqTkqshA2EpfPugfl4Lv?=
X-Microsoft-Antispam-Message-Info: rz5XDGZCxEyc49My0hBMRhveF32SZ9lOJzqXkJCxaNRCPTGIGQ3xLiKFZE/yBUC248Wuqol6i5I6kdSNoFfHycB5QG+f9rwn6dfd2s3X6oe9J9c2sgj5AtrUKLfFQ65huN8FQByoxpn/krOb3LUZd3QZMp8lqCGRXR+Wm5m0VRsoVNFBl47FmCcSMJgU6ymy9xokHfo7XQc30a5KsWrA+leVFi15Vaf7MlH5jggRVZkhJQjwSIyNLWdxBNGL7vhIOFolVZeRgcRmObKF2jTp6dEKj5xN6e+/UZ6iy1suB1503PmDUkiwUr3OUU8PEaLqjJC4Bsvy12Qk6KhXoE/qHYE+Od5VaKyFawI4FYHkCHc=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0402MB3909;6:efyqA2WQqOShawhKsOlAptJ9M2DSfDhXGDezk7MPyLywrYX7IdrLj8FwPYasC9v6984kZK1I6zMglSlFrNU9EKEBkZXMx9AflN8atbqKpacysozHCxpj+f38Mzs0BOH7Ecx2xyHxt7rANde22ThPbwJIAHh1fvkG7Zy8QlMcvh0eaHedyoxWnE7X+cSGofIVsux35rHgq6EZC5eqaHSEcOAPYwvzzsg3rNzLnnAWnQNLnm0S7NC/4tj8VN5VbXS5uKXGa7rOq+RpJJrCBCnsjvHzK4XkqzZnwREwLP6VXRJMAjtw5lSjspWpQY1WhN2F7C1g+Qy7iB+j1+mFRZIQZ9yOhcalQPZPHSpd/6yAJFDNxYzIin+9UBq6fobyAzVb+K/2QLh/iYj3OesD+k1FHCofQr/4CMfstl91Sp/WPtkITme2kecCLlVl5OmqHQJoDaX5Gwb9w5Zz73n39bMg/Q==;5:0r/3bXHwmikglG0KGam5Jq355ZgCp0k71AMFYeH09FUFB97Bq9c1ziROAa745VdZkq5Gjew83/RZcmTZf0gcokrKaHbP1x4CRZnzkUKq61zA6QCR0JIi2StLswpvpcD3Vkj6+fyVRY3ygCTuWo+PHtBu1p5gjmA1QED5qliGHCE=;7:IwYYbrZAk38iI3B3ER371MZqt/cflDbtJ88nlIfzaO8eo3TQUAbIU6k3G0C80RCD7qc03rW3remeIuyYPJKa2XIDPwOIiVudBre6z0p6Pmxr7nkgw0s4MPYG4ZFKgQbk25VpCshLL7VIt8hfQS2s05EOFhkMYEb0jPvZdnE4nzLGDJF69axtRIs3YOMND1AMl3vnl2QCWiHViZIYp28M25hBcsuyUEQQiTFKhmU8+3sEC6/QtuCiZylRLACPlXbK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2018 07:03:52.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13a5c5b-42a2-4330-a2ac-08d60e46c0a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables i.MX6SX SDB board's below GPIO buttons
as wakeup sources:

SW4(FUNC1): KEY_VOLUMEUP
SW5(FUNC2): KEY_VOLUMEDOWN

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index f8f3187..53b3408 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -40,12 +40,14 @@
 			label = "Volume Up";
 			gpios = <&gpio1 18 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
 		};
 
 		volume-down {
 			label = "Volume Down";
 			gpios = <&gpio1 19 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
 		};
 	};
 
-- 
2.7.4


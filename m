Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F14208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SkZ7OKFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F14208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeGQFrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:47:42 -0400
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:2671
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726983AbeGQFrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQOYV+xwyaENjbcJiiQtPPjZtMznybFhMHvRoCO5QXM=;
 b=SkZ7OKFa1XupUDl0SBK8bPmeuyHrvGIYN8ULMLj+5X4+fJCSj7Adk37Gze8Jf2DTmhFiEteR42ejpru4GQs2/SfX/BqY4qOsXQRriXYRI8Do9dxY/wLxr48Op8TDXqmIP7qdnOguqCdaAsVhy+ACxEPbK3E3Q7fM26t5rkwmgUw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 05:16:49 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yibin.gong@nxp.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/4] ARM: dts: imx6sx-sdb-reva: make pfuze100 sw4 always on
Date:   Tue, 17 Jul 2018 13:12:03 +0800
Message-Id: <1531804325-3476-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 830ae403-8fdd-4157-cf6d-08d5eba481ff
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:2CaTbPk6AGTHO1mLDrV/XhpdL5RCUAtl10GKraz/Ga4i13qWVrEshFdF+HW5qA4t6GcPVKOs4Avjvr8uzGecsNfwHEFCGrlb4/H5xDo28kEuIgXLOVbhLd3XwXjbJKKB9IzP8POBrBxV4FZKPsJvc5XN7+C62TkctZKJHBSqczUGq2jwj5C+tKhj1F6Oq5RY+/J/h+XCNFeWppiZ1pzVr4IC+SYvOIXyCrsWTsUC3nipeQ3f32c5tCTrN6Pj6SKb;25:cu4hQ7i45uuAgGlQh/BZBiQCYekM/SRx14Kkqm40cOggOvyqa/Dl0qIaRr3b6xla+NNzrQ7+YA9oOdcvCMh/FTg5dryK7+6Cjh4pOaIYGd5Bmh/LiIKclBd4nosrJKMO1h2DMDm8qzsLfIIplsP356NB36Xn9Wd8+uhxDeijHRyxH08fkoGpMO0a0nbN1ppFJOhVGd6qL0ZOG74lewGCtP0Q1o2nxKuiF0RQHaD6zqJ0wgPUD1iHmMpmOp3IaZuAiQxQLdtwzvEFC8mHw9xwjEcoJtGrL5EqWSHaGymR4AIuiUtQHZYIcAqStRpAYTiBzoq+NxfWJD2ozYa9b7Nubw==;31:OVK9L+OC9UrqXkQOfMaBOnjJ7alTlYh/w+y4MMu2El1+0xjxjlDi0yzmKNQ/sZyNrvaq3Ah8Jv/LoQBROROgCC8/mepU3XKeMERt2zQ94Tx065WMj9FuKpS5RrHMo49LTgZrwiiSJXGkycLHp9BsFK70izMDx/yK3pcqjsgSfaYVhPC3LvVY1K031Yb5pwy0ySdoMpBAXD3Ax7sDTIRSQC2JNzJuJBuHH3+B8vcMaP8=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:iFk/HzxbWI5ZZv/4L1x0VlCRvit7sLgzvUm2EMde/4+odbF1rv2SJAeLf8yqtVa/6r6sfincHgoUhUVk80HsChXbvas4mgUAEkQNoM9riwdSkPvn9Ufv/EzrjyXaaUjbXtCmdmhLxzuef2JJD4EVKu6ICmTSWZLMgk7Ay8IfxD2LDZjlyyNlAT08bbUqE73sGfxBJp96BhazflcTLqegUm4bdxolMc1fSjDAS6S1gSqyDUyrOdX3UeqJyckhGqgg4Eosf9LdYjR8/qbBKbNcTZUBs7wASG7F2GsYE5F4PA1kbUpIFPriIY9wybk4HPQRMTvdLTZKZ9lwOCQFx2/dw6q5jOlu7yQ3PRQ0EIHHClGkEsvJaDa8ix72RXdAzG2G3YfagXpaa4rzb5ZpnxEJNqnXdXEOR7hkkyo8rjwNL+MITvZl/ufxGtyNymypZBkM4Y/nk0KvwCO4jvinOckte6pdeCR3gjOj+vZklkyNBhDP5pD2U/2lnBg6Aek4rdNj;4:KgSr2fjntAO7fv/hntFWytErxNZl1hn9dcQEfeTFoq+kj/FTAo+WzA43zEoaw9B2CDytLVDQX2Vfp9Dd0p/TpKgNBcncRg/BJGZzTvdMtseDC5jMkhkzPowoORW3hY2lvfVoEE2PzpgacduzPCmplAJYdNJG8KJQ4Eozb/fsWxQbHcZnax+F6853ygbxjMtAsS4wWdTiJp/7yeepWvrmBUIPO6MRtHWGUeLmWsAM3Xply3+DFw7TCVHrZyNDAg4zvQDXXMNNzececcuUOopOzaYcG1ETZkizTEYoPtFQCi048EMvhfB0bvkVXQx8zemg
X-Microsoft-Antispam-PRVS: <AM3PR04MB13150291A8E4A8145D9DD209F55C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(50226002)(66066001)(486006)(6506007)(25786009)(2906002)(47776003)(16586007)(68736007)(478600001)(6636002)(86362001)(316002)(6666003)(36756003)(50466002)(386003)(26005)(5660300001)(48376002)(106356001)(956004)(2616005)(11346002)(3846002)(476003)(81166006)(81156014)(446003)(105586002)(53936002)(8676002)(8936002)(6486002)(6116002)(16526019)(4326008)(51416003)(7736002)(186003)(97736004)(305945005)(52116002)(76176011)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:QEOqJPqO8LbTXZWR4o5JF7+jHZbscIS/OQrKVswhd?=
 =?us-ascii?Q?Unupxw9gBEbZJwVdqkty37WI8KVLNtvAw5i7IaoN89P1TrVTkMclfWZ19Rmc?=
 =?us-ascii?Q?M9pZN+JogX46/ZgmzfdcDnhmDTkakCWGp32zsRtbs09inVGF9tMgN/jPNrYI?=
 =?us-ascii?Q?ZTh7ywAeKcx9RaGKNi4GE4PSsPA/C6sx2lWcK18/nOz9sVp96gprG6dM1y6x?=
 =?us-ascii?Q?AIXDh+/7CdpMZ2pEJGyZaVsyKIxLmM+eBV//A+kXEa/D8qbmhT/LPkzcMb62?=
 =?us-ascii?Q?lpYfATfUuG/nbibuKCsqbG5Wo3gmybv/k+4OlRGS9b2/bpdkMRwIkp8CAZ1o?=
 =?us-ascii?Q?IzHPRnw6QRgUlr4ddA9Zou5awkNMI7lFFANO09ScXQ8clBRIICHLrt+cJm+R?=
 =?us-ascii?Q?uZL7lJSQgl5m8Cs2snxz7tXIQgHnOOKK5lqCd4a0UMB5eCA07OCmD3OzeTz7?=
 =?us-ascii?Q?Qi4l676TTZ8241T7bKd14ZeSZkH6FoVvyfZsFHTbdVEf8mwYcBaEt0sfE+y0?=
 =?us-ascii?Q?PVmvMs0/2B0tVS4NQv9il18goPJLxdJUyyMpZkNyDQcpPo/0bPhD6+zuYNTT?=
 =?us-ascii?Q?p5JfUo6eBEdo9sW3Qt77eK4sjWFV/pdOV4nTSZKZUrar7psWYa+9n+O8Xhod?=
 =?us-ascii?Q?fpfTZeylphgchE/eGZWpbplqDXTUUHlUV2QEleRRHM7dJTqi/l94Ihak6U/e?=
 =?us-ascii?Q?9AlMwAy9yZ8iPr2QTtiL8pqw319WN7i8F06ZUC8He4dkxQ+o/aFt6MVLgSqD?=
 =?us-ascii?Q?BxImqVJ+5JWL5MxLLSZor5DfhY0mFf54DZ3Tof7kVQL7OBWYKEYClZaWb6Ft?=
 =?us-ascii?Q?3LB5+NpOU2ho1vMb+1O937T9/LmX6WV3LqU36HdRK6mpB+v38QYV4qmg8JL6?=
 =?us-ascii?Q?sLaUePD1pNsDIfrTaWnbtJmcKHU8AMRdhfxYK/d31nSphJJOZLtxW232wKLD?=
 =?us-ascii?Q?hYDRB18ieavhuLmqT/12YHRmB6jhosZfPjZrtK931ArOqDJjsC9WQA2BJIkN?=
 =?us-ascii?Q?nxTDPk3//N2iyxP19TYavNkSsIru1zi5BYxC2CONTXEUYUJgWu5pF7AuyaaP?=
 =?us-ascii?Q?T3uR/wYkpZTTrxa23AhRfYK2uH/TO+KGoDjTNfPHXhmzpR2cEJwyeUl9+nxN?=
 =?us-ascii?Q?sx8B2sbP6jbxTASD50SnXfyuecZS+KwwISZLK278Hy2/5+9fqsZXIMa2frGT?=
 =?us-ascii?Q?KDKyhBZ3XCe4ibQ084Fz9JLyYQfoCZ8SwI4NjtOM5Bj+wSi+9qQiCFDHA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: LIOQoS658zAWe+aMp1nsAqEAD1hVZJE4Ynnrprgj/3cK2HV1dqghFCs1MTpgO4BrCQKk7tCPPoL6TGK+25ja368hEknJwlPZVpUEcZ6oCL4qbpGrQRe82yglDYChdv+++rDvClMa1dY2CXMOUgy6F5eOFypYeAHac3GTDztkEzzPtt4ArSMLpWi9QDm+qQz5ocioOrtsULE5KCNnpylCFlK6imlTaUKTrEvRszPWEjY7ijlZbBGrvoXIlGJGHy/kSVsEdXVZq8eJvdifwk7/NPr6oKkr9OdRAG0YHwONuM7FcAbXgLDpij9cPVn2WxEE7u+FWS1MDtkgU9dURdyWORrZ3ZnKlmSXvZxgvRjMZlE=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:JEvY5BwIgPqJ4mioqfxIw9jFKgTAoDnuHwNWzOKUGgqHAhqQNBAcQwC+GS/kNJN84jFqIBRBHqsPkDDWbIq+430RIz0VoFkaiPeXC5KzamPH6prirs01+caIbu6HIXseSWx7MUN2+4vDriD3sANy2iOW1Ec432lROHh7J2VuznTN2WvVYtFIQ4qDNTzF4BR7m9sZa/vcZa1zU28Ae0wu8xyRaErGj5COBJi5Ld8ZJ5iitTWttRdKXZ2NiJwDe/Z8iTybJAH0ONZJOXqvoT+eDMLIF7AQig6xj6znOtkbvptOuMLwj/+Wqid51KhO2UjcLjdnXKLHAq7IFE0oUi1qkFhhpsqWvQgS2VY10b5+Tc8pQZR+RkMjjhBjZBruiatp/GnoV8pUQMaVq0HIIiFvC1GwYQzPedUwDh3HRpHM2qklruDTZOB3plDQwq+y4/ACSaSSfGh61PkwFoIS2Ii1/g==;5:8RE2FzwLEs1N+GWJPZ/lI8L3uVFCuLIr6KMgwT8woE17iRhgPL97FgcD1Dt4K6PCPYgsy7YfpFlRjbK68IqgpiV3FngLSoD6dHr2dZaWOhXuNrmpcZjgiQoa5xDNaQg+27gx9zZjXaR35kD12md9VbJg19P1oYQtvc9rzOW48IA=;24:aS15xz3mUarA2Li9VgD246kXKQ/DXwMEqb6ls7T798Z3XM41kfupy3st5UUjgpQayfzVX6nfhPeHNBfkNduRt7H0R/0VXwPL/7tsbMCfTm8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:qEgBYkQuX1+2b5Bv6YjR5eKVVnWHdiZugcSJhpy2xjx4/x4zCvCBvXH1RIWZv7oPFqyt4qK4v0onFE9xYX+ROAqy0s8H1EVfS6c/45WDa2KxZvuc/D8m/YbrpNRQ6FN7q/lD9AlrYtmGP6vrTF24oBEySx5xPp882aM18Yutk/YJRfja42uyzAj/rwjQRLpI6VbwRy0EGLqo3p9viha6HnLOMOV6E2PAO9PD4rOo8i/isH5SuCbN0dLs9e3VSMrf
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 05:16:49.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ae403-8fdd-4157-cf6d-08d5eba481ff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SX SDB Rev-A board, pfuze100 sw4 supplies
csi, audio codec and i2c etc., these modules do NOT
implement power domain control, so pfuze100 sw4
needs to be always on to make sure these modules
work normally.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb-reva.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index e3533e7..9cc6ff2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -63,6 +63,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4


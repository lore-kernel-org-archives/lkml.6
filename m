Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393ADC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF09259BD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="yE95sAQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF09259BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755476AbeFYM5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:57:33 -0400
Received: from mail-ve1eur01on0041.outbound.protection.outlook.com ([104.47.1.41]:3656
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755411AbeFYM5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gawOgebb9WPZ2HCdxBwkF+Hb5qxc3P20FSxhYVYgwyo=;
 b=yE95sAQ03X5clwjFPP9SZzJUfIouX3CuU4OM3cB5Frh8ZkRz8pp4UTicg0ctkbf5TsEi3fybt4CSyCleD+sTANm20NrLV9B2RfnAj+QM4iYPnfRtBVzuukXFPAG0dj7t1CQw4NRZPtM/qfwHTq2zSZL3PxPZ8pI18uqjypk+998=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM0PR04MB4657.eurprd04.prod.outlook.com (2603:10a6:208:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 12:57:27 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     robh+dt@kernel.org, thierry.reding@gmail.com
Cc:     mark.rutland@arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 1/2] dt-bindings: Add DataImage, Inc. vendor prefix
Date:   Mon, 25 Jun 2018 14:41:29 +0200
Message-Id: <1529930490-11874-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM0PR01CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::17) To AM0PR04MB4657.eurprd04.prod.outlook.com
 (2603:10a6:208:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c30235df-6fe7-4421-a9a1-08d5da9b3471
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4657;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;3:VCTKHRkYwkdurfV4/LgPx+DLnEnmG0Shfn/rTD5VKEWracVKBTbiNUafkFuUbUbotnIyRdqufevJyzPX+Tra7GwpxSWcd3m4oyhrP1D6bV9TZjjUeeqI24ZEiI9WB9GKzUDiIZrelDaVY2QRMTUv74FVTHFl3IR4r9gDEy68QDOOE47ilRqfcqHlNlNLKunoOYqFVh1jG/vLWN0lMH7yQxeuTYklv2TU7xc4kt6xW88iTZ2Oi7+FMHGtBFLUVrpF;25:0gtyHYMRsXoo9YBjlsg07nxqqqtY44PBqNw7Th3mlI9ydJjPU4C9F7etCouA+NycSC552b17C7Cw3LPiqjVGAKMJNG1tsm67nC0WRol6nGUWKWi2r0xzvV/PGxbUKTcpJqWvvz/4fQRXCmgUFIwx+tVKdQnW5zeVwzXX0+3p+1XqZzHcgzbwMNGKOW096OVKg/+6XWBHWMfJDcJmCWRzurIF86f07yEyh2tYQ097C0SWFNzgqhxMa+NzQKhx5qbzMng/Rfo5wWXdoNxfl7vJ3NGJtFLYfg+wvECzzfcyHx3FJQ3MD2okx1iJsk/z7y1xwv4F43mB8tJI7J9R2IqkBw==;31:uLdSqIgATNEDyD8062oNLTVof0Z4nhUOR8jtW+kqH/QcZcnxygZtWRrKbxMs7bWoBj8aYx0CPSvsI3gcmqV/U/83Bqpt0bZs/y+Pvu5b00Inb/DeHmr6c6jNVXPpp2nu2waMXPzG2uSkcPusu2qlGkHgtwjyjMwBrJ/5U3TaWOM+TCToeL+qM2AJusLrHjss1lQgcESGhbHZW8roK633efkVSIK/BpLUGaCc6/Yk1AQ=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4657:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;20:cTtggSKByGeybzNpVYTQ7mZK3J8KtBRc/SBuTgRbfwZkp7B+5lgni/ImkNRQIeGinD+S5AzCt2C/du4iHUxA3w5X4C/BGmU5fVPWmlNy2p6dFlYxAlk6s7m4sRKv2cyqcm5BAXe7AmYy88OJtbvmFej0xIImUDCgIWLBj0hNUwPH4YwSbWVYR02qey0lSWSYgScUK9S11Gpr4Az5sjhCv5j1dGpownw82RzEnZeRPfDsum+Ez1NYTEZuV40UAfn1;4:hIkIm3mBs53RpT2eRbVAPKddbfSKW9d5cmIvP8ckI4NrcTuvJJBPb6oR5iTA2a/LN7aKqbnfRXn3ANNqP47vifOkEuyz+RxBfnAnJJEm3I0r/DkxCrITC/+iBpwAgYX2Hm4uK6WgIZCGJv/Bw9qat8Yp/rHHVTxrVn9R2UQm8V86Qrvhy5dnIf8QFAoZe+SkNvVOE+4weEwXB2OdRPG9Xscc5l262lSFC05C1fH23vU+svfiqGq+gjXJUXZRY1xBejAjGiN5cRXVpcup3OvMkA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4657711F5FFA304CAF2408B49E4A0@AM0PR04MB4657.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4657;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4657;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39850400004)(396003)(366004)(189003)(199004)(16526019)(50226002)(72206003)(478600001)(26005)(53936002)(86362001)(107886003)(68736007)(186003)(5660300001)(66066001)(97736004)(25786009)(39060400002)(6512007)(47776003)(6506007)(23676004)(6116002)(476003)(2616005)(6486002)(105586002)(4326008)(2870700001)(36756003)(316002)(956004)(52116002)(305945005)(386003)(3846002)(7736002)(2906002)(486006)(50466002)(81166006)(81156014)(106356001)(8676002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4657;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU3OzIzOmpmR2hJSjZuampYN1Q1MXVDVFI1MEJKcHNG?=
 =?utf-8?B?ZGpaK21Fd21DRWRlelFlR2FWcXIzdWQ2MC9PTXFjZWJJekZMT0ZBRGdDOEgr?=
 =?utf-8?B?aDhsVjJaQWl2bGxwdmVnV05heE1WZktyaXY0Qm9UeEpzUXc1SlpWK0graTF3?=
 =?utf-8?B?c1Bad2NtTHNxK0ZZN0J1OHBYVUtLV2x3a0VCSW1XbWhETnpsRU4xMHFmMnRN?=
 =?utf-8?B?Tm54VjR0MkNxZTJNdFAvV1NuNUlXMjllUEJKalhZYVdodzJDQ2FndEY3NEkz?=
 =?utf-8?B?cFFyZnhJMENIei9OY2lzc3FmU0prQi9PNWdKMldXNWRJVUJQNHBLUmJTVXRt?=
 =?utf-8?B?TFRPdVhEN25SK3E5d1d5NVhkczBtNTNYaHBWVlBIYTVobG5xWEhGVERVSGJR?=
 =?utf-8?B?ZVh0c2dZb0JWdUNWYmJXamlZZ01reXl3eHZzQnJ6VWZybE5FWE1nWjBiaHcw?=
 =?utf-8?B?RnlqYzN3NGNKSFl4bGRZbXRnanM0TEl6L1dteVlCSkJrd0VORWV5RUw1c0pv?=
 =?utf-8?B?WGRyVHYyU3F3djVKVktPU2duaG1GZVZmSlFLUGp5U0QwaktjbFhOZ01UdGFX?=
 =?utf-8?B?ZDNsMThlTkhqMUJNdjFhLzFsaUVPSW9pb2xFUHFtZlB4ZTZ6WDNzOGUvc2px?=
 =?utf-8?B?STd3Z0F4V1ZFS1pMVkpSeWdkQ1lscTh6VUcwUnhaK1FGSE5FMEpoay9rbWlZ?=
 =?utf-8?B?YXZBWldIQjNnR214RU9zUjFyY3lNVW9SUGpMMlYzazNLQWg0T2Y5Q0JaNGt2?=
 =?utf-8?B?dzR1VDJlZDdVMUFMR0FVMnJ5Rm9sTmtaUmhXd3Btb2UzYjF3eWFodjNQdkhE?=
 =?utf-8?B?SVpiczhXeWVWMnJSMEpFK0Y2Y0tDSGlhUG1GUUQxczV4a1V1OThZZ1oxUmpa?=
 =?utf-8?B?SUxxdVl3WnNHWUMxT09wTFAwL1lsT2xoZysrbDlBSGhiekdlZ3VHanlaTHA4?=
 =?utf-8?B?bVZzUWRUT3dzUmJzNGk0T2k4RmpzQ0U2MDBBcmtCZFVCeFdFMitTdlExL2pR?=
 =?utf-8?B?UXF6ZU5GKzNBNDBkVk1pSHJteGIxbU1rc3JtWmRldFRQcWJNTmhvTDVpQjBI?=
 =?utf-8?B?aEpxWVA4OTRqVFJZTTl2Z2R3ZXY1MGIyRTBQYzc2RWVTQ2RvZVdpTHpsQmww?=
 =?utf-8?B?NWJLRkpCazFueDZzMDR6bGJGL3FuS1V6VTFsdnBYS214bnc2V0hKMlJlS1ox?=
 =?utf-8?B?bUdITUtBT2VuM2JMaXBEaVNSNkpaSnVRUVJ3Nk1oalN0TnpoM2FPTXZsV1dQ?=
 =?utf-8?B?ZDM5MjZhcjNlWEhtWmRDMUFCZHpMT3ZRRHkyRUF4eUxhYlZRdkpVMGhWVVRC?=
 =?utf-8?B?T0w3YmhnajdmQ0gxeFNoeTBUK0ZxalduT1BvNVBaeEpwVnRvQ2dDTEppNzFW?=
 =?utf-8?B?SnFCWDF0Q2NXQjB1cTEybzJWWEFaK3NKR1cvN2hQcytNWHJJMElrelFqVkFO?=
 =?utf-8?B?ajUvb29FM21xYU1pdzFFcTY3STlwMGNxZW1Ud0c1N1dXaUszU2tmS1ZpeUJK?=
 =?utf-8?Q?rYXwlCL7iyoytJJaJuvNOkQqyNovCOwVSaiK43sy9OBkJJ?=
X-Microsoft-Antispam-Message-Info: nE0+zuRT79aNowATIBwFcdR7YbFu6CfH8q0LMr2iKBf4IZXlQ3DmWZSNid3+pj9PITaL7ArgRFC6CsjpDgN5fJ2x7ket5Ioc85djSTpzI45cG7J02vnpz2eriCdWapBCAAPjcOsJVxs/pt83tSSducbrBnASQamQbts+gsrpPJ0g1OsuxTx+AP3qPrObYWrZ5iyk5UDCVJ4f/hXh7pcpePeKosY8Ton6TEh/r1YAdi8cfGiPZ6ZhwmLgDGZ2gH0yL6bLBvGZAlJsOyfsFVLp/LmqaDezg8pOhPwcrazpRHPihNZNKqSkLbh6vK1f+vK+F4Rai9N79LSrpzuLSKAS61F1Qu8hQa3q1x7u8GAxNAE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;6:GkdLIlRC+1Fh8sn7KAtENry3LopIREEDGxaA27jAOrqlqEj0DpvcQO923ZNEmt4faDMWwBlpdxy2SoalD02fcmU/+YGscOK8Yzvx0NEJKRvnSOQ4CZg4kAOpXOcBfAT6gnMVnDak4PAL2/3RP456mv1mWA/jIMoeCpvwcG2ULbC3ao7mFmE/9xVyFtEpJ3Xeh23cvUVNxbt5EUlJ92KbEsNpCkeGA7NggIEwgldEB8/jlV4KdnzVQzB9RoE9SXQrowSiwqiLc965tPp+B9IWSj4yjruFBiEUykgSiWW/l7JgDyAuRT3rV/nboN6aI8R1YmMDMEx1xOdW+FEetvuePrmqyPnzqJ3a4bO0miC9Oe+b0PxyNvGSzZzfUVdRVPJBNlQfvIvM6xThwy7IGCJBTpf0oEbSZ/ITknvHyN2IKlobY4X7MJZeqy8d0wICrXbFe5LMRMFBW4Do2wJqSlBNRQ==;5:VgiYsgf2ljxBu6r4it5wCDzZ5xv1lGtXOsVxt0MqU5qxUG1doJALr0gKeUhk0mFzMFJtl1fPCyiKZ/Ag+ixWHdbSk90TukqrQyiGpWxRZyKsP+2QBczz8apFxmWTVY5NhxuVWIkaC7n0icaTEYh+/sVRKhCf0HPgUqBsQ3IJyks=;24:Kko7Rx07B5/kSEBT9tT4f7r6MAwC1gpflQZznugNAwx2vGXBzankmbYQOnrGL5FpRY7gZ0a3Z0FP4EbUEO3k4FeCxi4sP8g6azWZtgkemDA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;7:gav0dGu2zVufJkBC9RDjQanNUSdzm7krmNnsYXA+yY38e4RdEqL9lG30LQ2NimuSkjFIjgPEVAty6T9u165Y0FI3iBstHXmtuAVMEOSQbUPODb5bQW9jxZF7a8QOUX7bNjPQpJNFqmp9m01YjEpsUiJLIhwIKjr1KJIaKzDArPcti8XrJvgQYPDwC0aEfexBhgHloOxHrq5taBXVCYkekI2hVM5NSjK21Kz6bAS4e/XwZA3aXKlsbmJbojDBEHgR
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 12:57:27.4751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30235df-6fe7-4421-a9a1-08d5da9b3471
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DataImage is a Taiwan-based manufacturer of LCD panels.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..500d5dc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -85,6 +85,7 @@ cubietech	Cubietech, Ltd.
 cypress	Cypress Semiconductor Corporation
 cznic	CZ.NIC, z.s.p.o.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
+dataimage	DataImage, Inc.
 davicom	DAVICOM Semiconductor, Inc.
 delta	Delta Electronics, Inc.
 denx	Denx Software Engineering
-- 
2.1.4


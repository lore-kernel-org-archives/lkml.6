Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16934ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB55205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="oW31NVLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB55205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeGRGf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:35:29 -0400
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:20288
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbeGRGf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E20IyzLT9JJlxtjc3JHmsny8QyS2NkhNPpiLz9eJ7wI=;
 b=oW31NVLyr9v0tDL3nPlvGGVSIX8NLV0CM3rVrg2AMnch5WZ13zQlyUTWDCE3OkKJYdZd6qCZKI6Myb4ejokAr+Rv4I/JMoS1knacgxO41sR0q+NlB1U6ZYqNd4Ba9EYM/a9Mwgbbib9EK6QLDTSgX1IGssDiKZwf5epkt4EM7OI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 05:59:14 +0000
Date:   Wed, 18 Jul 2018 13:57:09 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v2 1/2] dt-binding: pinctrl: berlin: document AS370 SoC
 pinctrl
Message-ID: <20180718135709.35128a54@xhacker.debian>
In-Reply-To: <20180718135613.1c559b9c@xhacker.debian>
References: <20180718135613.1c559b9c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR06CA0038.apcprd06.prod.outlook.com
 (2603:1096:404:2e::26) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e524ec-5d38-40df-da2d-08d5ec739838
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:dc+kNui1/OCZiSpiUovJmB0kCQaMM808wU+SwpyxPOVQfaYdrRYsrH6NPgfySD59tqGY8w5TGJZYsZRtB+5gDjuPSmRvyNvfSVzLmU9DbjjwcnEaMqGuGvGZSJkur39nCP2wuDXt90NRZWBIcvGvMOKqYYinz+tPKRP66xVXw451YbnFNgx+IkA/W1SOTw9LFyfDYPZQEstOTtNaWu5WNKGJzHOIukPs1ReUC4SNn9seD1c9ymzROFijjo2WS3Es;25:8jcMRi0otwOlfdXYZJrEKhAYANpgAixyK3RSlUnb6GqtQ6erEsc39ukw66muoYc1pcrx8nQPfCAgVMGHbmaGngV5hGfn8qwDH3Tl6EEgG7vmcLMvcsN+B61WfnmHKJjQWJ6RmShqdjyfg9wgpT9j5f9j63/w7t9ym3q/PWJhCuwq0qmYhPu+7fa5Lvz58cFP2jah6lp1ncJ6svaPewNXHfkIKkfumhCxkA1PHhUZxRumKwgt+6rZRDDTFv1FWC70MCJY2++SkQqf7Oei1yM6cIYaDfqUHbFPk/xVB1jf4BRLLOx3ApHL6NjGTHDCDlxVZfQDGP5TCbB+SdVY3PxTeA==;31:96R7V9yAWW0dCWQBhS+1LFsXHB39D9N8Y9pV8hPHhttc+pFiygykPbFYD0JyLyJBcU/46YNCy+l7MD1rvTJTaoBPWOAB2daO9Y4IX2LUoB7NCCf6mETIWfTrrMLoeZbeozKrehoGsX5s6Y88N3Zy2Aw07BC4JlMa5pP/WG8Jo3lyCDbEsz86FhxKvk0sXRuUp1Fdhm+TKp8rmYyjFq0Iif3TLNSaYM4IFJLBQUPrzF8=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:Mu2EuKtB9Mc9aIL1OLwmua2dwZT9cvYkqPupS3u3eJkqXc24yqPYy6GlgAz5+Stgw3IgDNEE+KdQZix2jpWsA0h7SjfRM5TdRRVtOlLL/+wD6tpCrkLiKKQqZMd7t0rDTBS0cTF6Kznwgds0Hz9rqi3u6RTpnNdbsBEvayFtcniKJRaw/LsCTOsy8CTQ+8NhU61nroD/+lZCUtG0H+EtSGcCR5Dct9eScuSFTFS6n2XY3F83uCDl7Om4XheV5q0KTilLdfBUR+sooUzXNqMA2TTm/1YqUzyGARdA6uD1SUcsEqihadAuKrlb/t87+m+hNNjYkl5Um2AW6mR0DMQOzWr9DHjZ7a8GBQsYsf5GTCYVWKPUGY3zI5qiw2y0dZ8x/lDH0ko645pFVDWoRHRmUklTPJLLZylHBjM1FxCAOaApydkqUFpMl6mVEh0kCgSYRAgpNF/wNCcQY10K0FwvFQBftDLKSVHrtVkdbYzVQOpD/F9YT92DGa7+FZLcuu6n;4:37YlDdA18ImioCKIhRtj/HJIr/ep6cHS141+jCMbmW/2eMYv53Ndb+X+SylVq4gLBy9BOxd//D1PG99nwelZr70FaGCVo6ikIdxAG/GMT6gAC9orBpK31yjKLTw5BjHAv8WDfIcI6h+58S2mK9UF/rcm9G4ZhVat2Fyw6xJbLc3Z7myy9yV5cTo2iC7WCX1Lxs3yk7JuXYXadHcClCLR75ktod/Ue5459hdfQzyU1zzHf8ErX3mzJEeinWy1Z2dXIKG66F/N8U3vpehEtM4uUg==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26367A26E628733F4AC9D63DED530@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(14444005)(66066001)(50466002)(47776003)(16526019)(110136005)(11346002)(316002)(446003)(186003)(68736007)(50226002)(476003)(86362001)(81166006)(97736004)(8676002)(956004)(8936002)(4326008)(72206003)(81156014)(478600001)(486006)(26005)(25786009)(55016002)(52116002)(39060400002)(105586002)(230700001)(23726003)(7696005)(2906002)(3846002)(5660300001)(1076002)(53936002)(9686003)(386003)(6116002)(6506007)(6666003)(106356001)(76176011)(305945005)(7736002)(33896004)(129583001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:Tcc4OLhWvmpV5CIiMCaSZpFKKb+Ke1vLHGT9xemUe?=
 =?us-ascii?Q?yxVz3R2+ERSkPeLBS5k5XWxgJ5uKty1KcCZRjtJi3AnZFfzfpyyjTYCiupHV?=
 =?us-ascii?Q?6HO5LhdeTjmRPvBEQhSLq/HItbMXlXKXlabO5K8V7cPOdUcYT+8+DOAXKKQV?=
 =?us-ascii?Q?BdONl5nNwm+uFKm10IpFBYobprdCb0Ap0/O7/TQmXEFP7l3pmpt3fcfdDGNn?=
 =?us-ascii?Q?buUJUdNIcSs8u6p/ShTvj5n1JJy6DMHW9+/+EY/uhrAc+BXs9I8VjbV96n0b?=
 =?us-ascii?Q?YJpHYG9ERvN9CtvkU4ueTYzWcn21KXHBzo8iBzfJsy3osZjQfZn66NYwbcNt?=
 =?us-ascii?Q?1SxDBOcXX8S5CsK29lAtdEw8Tl/PJcWWG+h/TvgMWkpOeLOYvtpMmJHh37tN?=
 =?us-ascii?Q?lROyPwoe0Zc62K6SmZvQULT7Y/PuEKPsIlO2NZF+naxmn71W7nIWI50k3Bh1?=
 =?us-ascii?Q?pIHymUzuBeh8rlTyVJTCBvP9kqMNXgOYjU16hhFlfMysaQGtsUMmyFkhRO0p?=
 =?us-ascii?Q?VzuQ3e1tnleIqb861rPJgX+t97UCC2u5jkDretEi/pGOJRMG4ho6cLj7iK3A?=
 =?us-ascii?Q?U/fCpUqR3U79tbRJw7J9mATI39sWaZj5hQlCLudmQPySKeY4cLzYjcQg+X4r?=
 =?us-ascii?Q?80LWgdn/q0lPUbCFOXQDWNPZV7TXhEa63Pov3+L4JxAehwFOt2H7xSFgAmhw?=
 =?us-ascii?Q?6cK1POFekwYcf5dFAHfc/lJYdnw0PolaRNevJ38r3v0owBKdT+sLushI2kZK?=
 =?us-ascii?Q?MnOnLXaMaHS/4udSlSofzvoyvFOnITByviPdkC4XxsroPVc0m2OuX2gOnNIB?=
 =?us-ascii?Q?rDC2VfkBUIEveaZYAuBu4zq9PH4aEIWT2JqflE+ACYznXAdjEKdnnMmW/5Vn?=
 =?us-ascii?Q?GQp5kds0xdfDLZ99/AVTFzvs+m8nwuQ/ZUz8o6MMi5hvA2RJF65pfsPJkV+f?=
 =?us-ascii?Q?YW/+/AAMhkkc78awRi/rcyvBPo2qOJdpzYt3nEy2ySm1du46eqxJuiEeOZ0f?=
 =?us-ascii?Q?GHQCVwvL99oFVznvyN+WMqjPrRzGar4QYrKTsHyUbbmsNYv4DMjysb4JOQKf?=
 =?us-ascii?Q?CF4gYjoaUtXXhOQ2cFXe2YrxYb883m0hSncQ5M97BWFRt0Pmr+RQafNr/xRu?=
 =?us-ascii?Q?fWh6HgDq/aYFwf/RRuN1LnI9gpzrRBxBrt4uWNWTso6MJGO1kULAlQ4q9I80?=
 =?us-ascii?Q?HqSKabDt6F0e4nuy3HfWldyU1Kzrj9w1W5dKToJZL9QYclRfWGkg50BarJd5?=
 =?us-ascii?Q?eWZ9DFq5wDm1JvdNFqWN1aJVcze3gOe6awG3Va3sj9IDYAek2gRawKoRcOvZ?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: QIA0UTslxsQftCqJp1MyaU9ymWBf0G3xxBnoBtDY+YqeYyu0NcvlOYWTKG+Bi8i8ZdwRTM5VIX896D3iZr6l6kaQrnNUIKIzOd+05kbYORVERXYwz9715VEaZ5xqexVex6b/ea7YRzjQxunKZ3TlRaRuG25yNgefpLvK6EJFoD9QeX0IrXHjcEy74L1iLidvW53TdGdwdh9a+vSv2lanp+aVBRdmHaLx60SkXfV4W7jD+2FGEs2CAfkVFk9t1NysOTKnVn1WTn9wqLIpUq872s86jlCB6eZ5a3SfmnaI0pl7zrz+OLeiuLuiNxnoNxAyI3vwb/7Q5FMo87C/PAPn/d4KDMdmklUp82mFZva/tYE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:67P/Il058GqZDR0dL/iiHs2ep8ez8TmcOQbK3m6rQzETD9CI3gkwDy0uMUmmDQB/9zG1znDCIK+Gc5ll5hhnNUtD4i2rJYJ06TBDp7eF9fkS+BGkKEv2SdQVwQUMX1pKp61vp7AYmSkARx7yfDhpNpZ8IjdaV6cBhx/At1dhw0g8PCXYVUi64xTECcx6XvGOTAf568dbQnWsA+ghCubew6QH8sVv10N2sWASXVElzacPU1XDZyGwCBNlXHWLgG7HV+I8tXSFq1dd5ejYiqj5dNgs6shko7dTlrGkkYRLXGza55wmQGbk7mH434PD+k37LE2cqGBik4//zcMoJkGZ4jBucGhJlJ+fIEM2mZdimTDn38fcYQDrzZX2zxSSQoDG+cJdWNzuR2E46xK9BFgJtO7cJveCvMYUTEUUOQ8AYOBSXUbGKT6rtaRhBwaEjFPV5A5M229/N3kHJnqscl53RA==;5:+psfL9i1fb2UrjQBS2WLFhRaQxSIjeL6miH8aROt3Jl+pBsJMopbVRE/vP9e9scKBXWui/hB2Pt68aWhyfVhg/KYUMnGby2XsmAb9BfhLa/oTFLYztOuOj45JPqnqkdq52r10CJ9qYv5B/qrxAvpWPMHRdibanMAKrIJZHw9d+M=;24:25Qo9wSZ1n8ZSPQnKHfzCBKDtdacNoKPBmxDbvAGZmpfCy+C5v1BvLBbScJmup2KkMROmYTsFMFbPr44PE+6+M2NOcE8rQM9UrOd4rVcHOE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:maEQDAX77jxq+dn956TMTNIx7O/8C8zxs0GZWeedRMyrJAmbJ5ZXvMj2jBE0zH4zEdlOnzGN1pnMVSzD86X9LgZj+FfzWOaUOT4wpVwow0MkHtvA6iTxlj3ysQ70Y9l5s5Ob7uYPudBTUH2muNlYKnbICWHBPYd0IlInefNUApqcnr97WPOO691f4Q9UGgMM4GacjbsIo0uv1IaS/0k2NbIJgZB8UENBi/gXo6gNMpRhhm/0lhq17F2Qrs4a3ksZ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 05:59:14.2093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e524ec-5d38-40df-da2d-08d5ec739838
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add as370 to existing berlin pinctrl device tree binding.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
index f8fa28ce163e..0a2d5516e1f3 100644
--- a/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
@@ -23,7 +23,8 @@ Required properties:
 	"marvell,berlin2q-system-pinctrl",
 	"marvell,berlin4ct-avio-pinctrl",
 	"marvell,berlin4ct-soc-pinctrl",
-	"marvell,berlin4ct-system-pinctrl"
+	"marvell,berlin4ct-system-pinctrl",
+	"syna,as370-soc-pinctrl"
 
 Required subnode-properties:
 - groups: a list of strings describing the group names.
-- 
2.18.0


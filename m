Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F343FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6D220861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wa/zq9ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6D220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeINN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:56:36 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:12192
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbeINN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZDWbX4cj/ih0jVtIDR9Buq1iviUhi3RmGmHoEO6l2I=;
 b=Wa/zq9ht9q2cHmbhkg6BkLBvQm+WPG8NMxmiSvFk7I3MOTXzqwKVjB54hn9hXudlivUaFJDYwjMaWBLEu1rmHW86OyYRPAP03HIeFqpwItmmLmsE6I1pFF6zDcuq3RgZXDcQ/xIrKPPszmxq2xtr98X+k9on6GXNoVGrAl/YL4o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Fri, 14 Sep 2018 08:42:59 +0000
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
Subject: [PATCH v2 1/5] dt-bindings: arm64: add compatible for LX2160A
Date:   Fri, 14 Sep 2018 02:07:51 +0530
Message-Id: <1536871075-3732-2-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b8941c47-2b6d-4780-c7e2-08d61a1e1611
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4800;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;3:cAlcm3c/LYVTVTsMGeqdlaas4w4ja9wH4BTDdzbf0DD04mSW+AvDEgd9o3CFpyh/aH2xMFZJplvENm6FWT4Fctr8ngWjeMtWpcJIXCsIPmXk3t84Pqph2u3yJGKd8Pa5WiX9jq4eJ/7HQ6qH3tJ5D6YNVncBxN7DXwiz9QAF1GrCXqXUG9VRr2Tfz5cAGl4NF2aqzi3r3Hyk42gvv4xYZGFgSWuSyINrZy6FzVgndIPfFiHUwZnI1DzZSPRKtVAg;25:D9fDxdPlUo1cHs5d4I9cNQ4cwnqKhc694g32z2829C3HWidw/cW1qUGaeo1Z6Gv307Rj4CO3T37CryJmgjFolP71juCfrAEFKKH7EUrdydl1XtVbbo7VDDDlNHDAliRrpIbeBaczx6fqY8KcdOKguGbIZawy8UcWy2+78UQThQMZhpYAPDPYOMVT5AxrOvCXAyAQZ9xvYYpAfJJCmSMNq9xRboFyXVodfjQlfJ2quScpacOJ4b/2PXNDtL60f8EmRJmXqs5K+hTRCwrp0bNa9R4g0xdVyxw4Z4cfHlPTn6n0eLOA34Uy9okSepshyV9HBBKeAcRpyeQ1a4FwJIhMqg==;31:sd9kT5RAHsresanm7uj/BRpmopGGUnpAt7pspFiauwWMcnSngILIMDzOK4GZDkp1UMgxOVt0Za7hgBo9KS8Wdn3JVAdq9gYTfFu37ElVTLFbOb0pz0bwJ8cUF0Z2XjdRHvVUWCnCndu4V7Lb/SZzHXaQCatSeeQMRbhi+E0hE0E2JswETW1YQ2MxIXEmjubmKe/1PtLJ6o8CBIyoTcL/nS6fbbJK6mS4AAXqw85LXnA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4800:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;20:62HAR/pWY0n/FIQvL55JRJUXpJEDdscXfJOXcgrvgCG3FW38rLloLlAv95OnR+TJjjMPkmi8qV/evH4v1Xwj1MUBATc/E15d0EJg32Jw96F8sr8Fxu2JmTFVOYawydRsXkCz7t2qWJCfVwn//Dv8u8NrUS6wMpfQDiZZy73MACTaikN9UzDsGzxQvFsdfs/bgjqO8eWtcgIfkswNz9Q/V7OjScOFbFLycOP/b92SA/DdOxGW3W92xcJyCKX3wq5r0yOfet9sGmkn5j5tV3f05B+iEk2Zc3XMe2bA4GYwh3V7wVspKQ9P+LvBu/tMRLulg7Q4fnv7CMBYvmFgNKTfZjRAxSOym8oeVBuyzAOnn1LtKP9mQWCreVHBZoH7aMnjdXpwmJGvzTK4Kn17DLOOTpfUIVbkVm29iHy7dJQPsz+YB7hAcl/hsD6uAgtkd6njK6TNbaYFMNuIzh5JuzxYRcsLMFUTN6DNSDMz3BJ/VBKQCJWhkcOY30aCi+l7fPXX;4:Vim2+9TQr87t7y+bG1W2fQH8h5x1gQcwJ1zhS9c1jWx9xYJfrcURkdBN0fyxiRSvJ7KCQg4nO2gtBJ3PSSnzFYeLDH7kLpsEL9zUv0ZKIL1hjG+NkbhskqxHVANCT1oVhUZ7YxXGaIIMAB3DJYUvbOaFL+9Chh5QUanvdCeYnLyyJkASAuEHfzogA51KPeCoSq0kUU9Cn+PZO5JPdcg11nQUwcH/HmdYU9uarS6XTAoM7bR9Ca2Ao6GRJNiYStxQZE0vhuSVCe0I6gqeTqAjJkvXvwSXO25HIT2guzFKmY8TRxB9G3IUuOwZX3cMIabQ
X-Microsoft-Antispam-PRVS: <VI1PR04MB48007039CAEEEAC9A7D32807F3190@VI1PR04MB4800.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB4800;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4800;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(7416002)(305945005)(7736002)(51416003)(2906002)(76176011)(4326008)(25786009)(36756003)(68736007)(52116002)(478600001)(47776003)(81156014)(81166006)(8936002)(6506007)(386003)(55236004)(6486002)(50226002)(5009440100003)(86362001)(66066001)(6512007)(16526019)(105586002)(2616005)(956004)(11346002)(186003)(486006)(476003)(6666003)(44832011)(16586007)(8676002)(316002)(6116002)(3846002)(53936002)(106356001)(48376002)(446003)(26005)(50466002)(97736004)(5660300001)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4800;23:hFYGofbH106kzuvzsLA39FdH8kQsPnOawmuDmkzlj?=
 =?us-ascii?Q?xOmherjFoZyjgWOsAyvUuZOguAmjVCgaX0DWOsfJAUO/9YCPvKJp5zKietn1?=
 =?us-ascii?Q?F+hdiDtbJ8aUGjQqVsZhQo1Fy7rDVYljfIntWRamA8q9xInhL5o4brrgsOV/?=
 =?us-ascii?Q?D1tYc22waCzKc+JBiu/64odcmPga9z5UJdWO/Hn18aQeYaO9y0KdF9jVytAG?=
 =?us-ascii?Q?WCBg96zCHSP8IfzADuXKV4gR6WZcDWEEKgydhVX3VVfZEBTRqNL8dzNy6gkx?=
 =?us-ascii?Q?8cDXgBAmgeia5RwvHqI2T1GdRnViyvh2BVQJf/+xDbjVzSmKfpx+NjEf2dWq?=
 =?us-ascii?Q?Sd+pplwOEWoiW+I4kjEEoZ4paaeb4egS/JsqRmIsA9iBSjzsfxBkdSZYnpci?=
 =?us-ascii?Q?/AgSUJKEhapEGGYjoFdgb2qv6KvKwf64JDL7F9/3ORHbyL3UNswySzKQ3bVz?=
 =?us-ascii?Q?CIFRx44G5ss6pUCky4OeSWXXSsHUIeVgQJA9YYSLuWxUq5f56uV/OHVtdwFq?=
 =?us-ascii?Q?8EppxcntabHu8RMmCmj+OSIwIreluzHr/+bPloBbyHMxI90aAJDGYg+7qaJU?=
 =?us-ascii?Q?RXDlocXs12qqDCMXHvTmAO0i+aTuuomNMQXljWvI3/hAuv9YfNVGFwsKpwvp?=
 =?us-ascii?Q?5u97j8aSMgW4+rY/TsdHsRbcHauuVAzbs1KK90ZI0SmJ1PmtDnOyEwOn5RGr?=
 =?us-ascii?Q?Jj5UIfBu2Hk9fZSk6Mfn2zxAKw0UOIxsoImdf4mzJUZcfZnlf+XPL6HoWu6E?=
 =?us-ascii?Q?Hl5XS0vNOhB6oo+YipJThhmH1hbbpm56Pjs/28z0qqFqRBbjz/Bq6H77M/5D?=
 =?us-ascii?Q?E7s98JI1umA/sXp5IiDSw4kv6x10GOgJjZpIS7usGUyYDqvDXBm/D30qZror?=
 =?us-ascii?Q?3hAymHenDu+7UIkqWNcVaWFFayku9096eaRiRYrUdI4t2hQ0WqRwB8wG+cDf?=
 =?us-ascii?Q?Si1FkYSXhWU2Pmn9zI596TN/V3Yl33lgO7+ghZeFKVqNJjGA8syaWjZCSkNj?=
 =?us-ascii?Q?5wRh1pAmpNfQ2DrCO5XHQgbe6qEZ1Pp+xwH8e8ylcEJrNN58W6Wxkmhv49YD?=
 =?us-ascii?Q?vxpZom6l1Kv6ufWFrHCSp+Y6YdjbaiU+9faTFDsDxewo1vicJtdG5RVC6C0c?=
 =?us-ascii?Q?lOigoRnET0oXQgunAgXYK6txPA+migN+LaiOq0olJ5C9wyMUkXPV4t8Q10yo?=
 =?us-ascii?Q?gyc267whHoCalzSgb4clCMlGrRu7SDQc2CslMhX3KfNq584YkxkLBaMcLOjo?=
 =?us-ascii?Q?dTTofNSHH4M6Yr3VFZHuUHXBid/ObxnC6u5wLdW1UOTSglTDthk/w/0zcvxf?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 5/4UsA+Mw2E97LlNwzNAn5FZOBAInOgtXcoaymHW4VinaMGJjQ7vYbpKhuFCwaZuDqDWB/fXvY6de/sz0CHcKZABLzg5VrAvYMK17RHUm5DYYd+3lKISOW6jO7/DDRoUtSfTjDfeCXUQv4JcNwImi76daFEl3+wEpP/NOD87bLQ1zVYTuSaeEyaIIjFIRmDxN26pLsnC9jSQpx54BHh5UuUBuS26TkLr4/dzsfhmoXxpfIbM4nihfUGbXcaB0PFn/3La11gl8jfYSFLav19OuDaujkcer+3x/zc/fxJyqPZSNP0HDBG/J61rB94mmNHBP3oktSJlxG9vEMsWi/6LtBJSxiwCXOd0xDSBaaNDW9Q=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;6:XuNYo1uzgSiMPEVwZ1oZCXhe2Iv4yNkA2kZ1H0A5QOc8to1reJlfWjW/KNflwCnudi+XEzw7OCwKT3ki7HNigdFfU0XKgXJGeItqqtc6d5iHzs6oTkgh9TqVeb4zB0vp+DwGMq3q8vDRRt/0wpNCCdxPo4RukRtE9UqbuKLcU3XSP7aTU4Z0BsZAmqn7vSE5gnAf4o/BssaDrrUfJ5ySQwUTlR8nhQ/oPRXmcPIwuSIcclFWF1UtxXuUX0cjxVcMWx2gTAHjn31NRa73E7bWnLsmyefDyXAnlAUnw3O1dZOFtNmKZ0B4ydb9Kec4OH4mP5XURFVN3XzC5HlPzvLO8lOEnwD+6a5qjmhl0Z13rDISG9HLn7xL/ZKZtjxhZ5E5ZcwEKXCH9ysHDOZKrRgwdOOEjEsO0hHUbJKWIoug9M0tUw8XQpaNH+klT50VAU5xwOCCQCRoF7mm33QAcLE0Xw==;5:lToTtCabCRlnbAHTJtN0L2oCc2Cs1YIj38D+VPfCjQkgn03E4klA1SzTX1DxFJsPnZPvuYECPDsjRFkZbLT8+oRrodXG72Q31V9CVkWOF3AQc/6eSW5wpnp1gf2p0rBFtCAGG6VhN/7Jj9p4adE8zAqjOoWqrfEBGLDky24v1i4=;7:ir1gFszCdoIoLgkUrDXe4cu55UUrDFkgLWAaJLuOD1FDsoAZ6maASBGjVhdeZcaeK5scaRadg750zlJStP5GtWCjEtTco9yNtGLZTLvZ90dOUbTRtflhQTLmygaSgOLrKY43P6JwhkNTtkDCIwLeFpKsm/mev/m8kf1ISESNWU3tOYmvlsj2ftqAegvTRcQhJWWxUqAICQgCJKcf9zelVms+RXOIK/xUWBoRSGwAFYf2AxKExBSGT1td573lwQy4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:42:59.6576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8941c47-2b6d-4780-c7e2-08d61a1e1611
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for LX2160A SoC,QDS and RDB board

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..76256bd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -218,3 +218,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible = "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
-- 
2.7.4


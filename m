Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADB62173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b4Rw32of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB62173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeHTWIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:08:55 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:11916
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbeHTWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZDWbX4cj/ih0jVtIDR9Buq1iviUhi3RmGmHoEO6l2I=;
 b=b4Rw32ofVO4pMppPYfCMbAczKUn4/DbfFptt2RNiBT9/qpyWLfovzuFWTK/pvKJ5LhQuhbURanQVbQYjJo1X4jp25z6iJ2SXRdVlzfDBcOqdiiuIeD9ueRllLscCYbjF1+EI3DfWGrIWJXMUVJZnCLsxOFHwl/U2wf4GAVuCxII=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:51:57 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: [PATCH 1/5] dt-bindings: arm64: add compatible for LX2160A
Date:   Mon, 20 Aug 2018 12:17:12 +0530
Message-Id: <1534747636-20064-2-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fcef1cb-d20b-41e3-4ed0-08d606ce0394
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:w281lhvoCzjiePdLfJ3p+9jf1T4y8bptfmcy8oeLK1bErgVhgIOMnPztx6rJrKsJVWlVNsTdZcGnmI3MLsVYldy9sPK+5UdeKzhydms3rTjX0sLu2j+Jf/vt2iZt5YPE8jhzRNlmDtSxFICWvNINqAqF6kXJYYqSJ1OMB0SVSnMglAYnR55j0UuewpQtjpjtuHZ505r0ClBH7alPov4Ab+zUVKR6O/vZIYdqa5T0kIOzff/6ZwzhWB2HqAhddovt;25:24uLMNP2vWG+TDpon5RZVJfJKKuokvFAf5o715/s7+dOwHNXJqnOhpKr7vigdaBNMvLPY6vFxVdCmkLn7CaqCfs2InvpMOD0UHfNZEfS/iEr1R/NgG/ipH3+lkjFarRbiQjkz/tp7IG8UDZEqRDvDxapVt9+54iq0wi9FNrFMgCfQ+b5vE8h//UJSAepl3xbzR62Y3bQHO7bPWxwyDBk/jIqxlkSZUbQT+c6UBZcaRkB1T1CVAeWJHlXbV+MVWeRhj4FlU3HIT+ol793YYaJFaTTwK8gbesq7B+Yb7hV6a2goLAtuxJYjbl3H2JTpKVETOVL2seHjz0faGqSJ0orsg==;31:UiuMAi2uC4hno1xAv0D8FOXEzky41uvgBqlBNIa4yPrAOJGffwwY36M3hVN7ExbceTmgawCw52tFFph4dIN+gHLwyBrQc7xq7NO0CUrtRUXqAqp7KevNfQnKuiayeFnvWN5RKJkwnX1tFG6fi8EtPz7FpmvowU7UJP3z67oCWIgIygeuMDRb1hyPSVvNicw+NXCn/Uy4z39jOBR5Mb2vScUXdHUGnOFbGlxCnVwQcEE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:F9mzAwPpuas+YdbEzN753oZ4baTlpx0NavMVxFT/2epyTsr7hEMDybkbTWqUWRtV1EemnZM0akE5Lr4enX0AImZCqkM20lfly2t+BYrHOrd04G6FsmaoFh0OMCBul8+WUpUXAiIgeib55RSCn9lUwdR6RDjQtnjKpcD4uHms4lM/wrR9mg6X7eDOuBmD2vKe1QPY7t3GY63ztwqCqGVG1pxzeNkrcAigcQ49OGObHJOYK+uIt9Endwbea+vsgVswSPq0lFk/Ty7PXp70oi3rDv50s1ct+jmfu7hINU5BNiBtoxocWheS60MAXYZDM3TUbb5hBFVpllJkFm7Ox63EPMPGonrfcYt9z7woMrbCYtlKHvdslc4U1qTY5s2YYE5G5wuTAcCu3Ta6Vo1R4oLCeVdvGGiHTtoqtAYunnj4j/5umKZVtk2vl6Z5TKMC3oOE2Dbr+tpoadIr+7zE7Bw17EL975FG0qiqt+57DnL1FFGWxTivjFtCGBTN+JVbq7Ez;4:ldi3UcgPf7ufHykpeNGBq+/Ee7cx/12BONMyg9gCE2iE1kuTQBFODKQzCtvtb4dfVlGXpO0JA0AEh7jSjKBeoSCNZmhSVE3biNVyNle44DUIreBhefQTYFMzYPceslmzOrDV5n1uizaaAK//OWiUZK4iTGqfMuX7CUtABf6pJa1HPR+eu6XRRVI9uCC98dss3btzxvN1gBL4qryeqyqh8fRUCy+o4spGQUx3AQrdcpF4PBqDMrvKdwz93eZnkeBzkuyAJrCGzCHiGdLbaoQWGmTSKXHlk+lJhgRX5BeysRfImoVPOr5U8l/H04IBPj2N
X-Microsoft-Antispam-PRVS: <VI1PR04MB47995E0ACE36A3A9F4AACB6FF3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(6666003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(6116002)(51416003)(52116002)(76176011)(2906002)(316002)(16586007)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(446003)(11346002)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:7U9qUpqb6bwXAo1hLZy9c8sPNRbKOU/hJ+JTOZi6Y?=
 =?us-ascii?Q?l/YBouF7yv7eI1Gkh9X0qs9A02/39Vjx25Yheov4b6HpzB/8WfQZKwHs2soa?=
 =?us-ascii?Q?LqzH5j9eoB313Ck4ovStUCaIOiviv0TPlke3AYmytHO+W9acD8bnjSavbIKa?=
 =?us-ascii?Q?0NLZnD/3lDGQQuoiZMT3SEGAMxcK7QETyrB9uqz8ONutRW81w9p5uuUK/HXe?=
 =?us-ascii?Q?m4cGcGmkPpobUr96go5GwsWbc/5WX5sjcYwnhaFw6Y+V9frGZMsxqdxgMhkT?=
 =?us-ascii?Q?K3DMtZ27qcChvVGHS9Ir8xArvCgHxP5ZGEkDTvoxh+jlsKdZOwJ7iZQldSkK?=
 =?us-ascii?Q?iZyIaj+1iJwY9mv8AIxV28wqOdaZK2E6zIU428sqAHaZPrs60Op9eQ5oIP3w?=
 =?us-ascii?Q?Td6+2prvx/6eI05eFRcjm8B8VLQHKCHo6wAcvS8xAtz/cbDzXrd8N+Ex+qq1?=
 =?us-ascii?Q?CRZ6NBQhjzf51NqYaBluBlHzuEvGFm+JjPJIoFirvgbKyD1tGOG6OV4SssFY?=
 =?us-ascii?Q?8HcXZZOT5KlYBEcw/VJFn4frvsSLxTExH5lo7tONE7RvEHRr7dByef9CxPnV?=
 =?us-ascii?Q?r1/nWbIfyJvf9CE4OPeRbIc+nqzzB27cdvTGiu1GYjqipxxjYA8iND3tYfeS?=
 =?us-ascii?Q?FF3osPAlLTbBsA812YwPqXMDCZ1hfUV2br7Djpi6p9NYcrn8ltP7U396FjzP?=
 =?us-ascii?Q?K7dDKtCxePqLNrw5i4tHNkDCSN6McKiCmWTIqyBLjKvgKRk6dE9UuLkkkTPI?=
 =?us-ascii?Q?iua8aMINXU2timwRaqARvb/0ZhXUW3IU41JB6zkF2NsX0JxPxHqNskx2dcVs?=
 =?us-ascii?Q?84BuHo1jEp2+1SpXzBdrrx9k1MjHP3U+dgk159kUOLGB33mA86tkFSQWFJgV?=
 =?us-ascii?Q?AdffQbonyYSPUMh864UA1HcQ8vS12WKAYD2EJHnzY/6hwOEzruZviT5+V8zP?=
 =?us-ascii?Q?C7/BHlViqs6EiCwVD2OWe5HNh/8aSC6tS6aZ0MXALl0yfUfnBPvTKt8tctbY?=
 =?us-ascii?Q?r+hBGrEJe3XYQhMsR63WJWULdgW+dTr5Ezhr647GmoUkvMXHZ7afuBHktnp8?=
 =?us-ascii?Q?1lADGfmlJ9B3Ujdd1yfWXkvuUd3qcaONQxqYq/HSqPf0nHe8wMvOOqyAgkZd?=
 =?us-ascii?Q?Zyg2/s7/4QDQ4ufersmoIKwfn1Mtt+DWYkv/VyuL7ybsdIqv8NgkxKEPoJ0Z?=
 =?us-ascii?Q?ArDF9zB5Oryj3xUtQS8lh6HKpvLrXdOnM6+jRNEu47RDnnO2mAnBM43gADxv?=
 =?us-ascii?Q?5vYt8bIn/JcF+1l1xLRObfY6SErd4LElTRdhMvXJiioJvheVE4l/0bwIXgjY?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: AVuZwp864W8aCa5YwhVouIW+vTWSUVhEV7vJGNSItfoj5Pi0hNWPpZeGIlLujXYegDXm/iwq+4CdPIhOXUTzfo4p/VisK+Qtu3Ajf2YuPnF5/Jvs0bEVKPL11/Yg11fTOUZbjQfRXnlWbKYtDp5cnZtb6xnqsDX3fqH0zJHWgnWd3BWkQPuDz7jyHUqmvCvBvEMP/r5fMX2WX9BJMAbjeiP4U3LUIc1gX446xORNnhV/ThtX0asLlL0rcBXCKD8t9Lqn8UA1n+a0+o0OcCBD6UWqZgqR9KhW9dAUXXxPCzVhHruvhPq2RbH0AsdoFOaURP17fg4l+5qZJXXI9RaoQ4U9r1HPk9XjpmJ7IFqCVwA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:SsJtxy8TP+6LfNpDUuSBy7sY94QqpjUbxUDTWJ1e6bn5gwTzg3VTTL9yMiihslF/Zwmpwpy1jhjQptlg20/b/pFRSk0Rp3PqbxlJOmT0iYC59PNua4tdRbiefhNBPI7PdKcIiBzRYYYRaeRxxi1VJtYth2Vqn5mhigdmD6B1CENsqBCuu9w2kK3VfBfGDopGxH2trDTnlJ2Qcu7QsYhqHbSUg8fgflUC64or/HkKIwB2GuLQOc2Jk4b4dNr1vn5jignphvnrDp2yRPGGGmOyAVWE+VugTM3ycopnMDTCoDrELt0yEB8J2EnUFNqplOtUqna8KDLWuDTFSIocYeQXsVJGDoRgZdpggdgn3Xqnx8zl7G/tkzI5EftIUTqiPpuwWpFeS+s9o8daHb0Qv19EREBR/Vnijdsryy+A7o0sEEGb8b04MyZiyR8n9xn4PuVhuCj90VI78EkbwfuK0uErhg==;5:gHwPOE/Ec8tWyAL5uYGg6bPQGat1nyIqaxJA6L4+6DYZE+aZ9vsc3x8hJwvH6BB1OuogVmK67+w6Ajo5YA67RW+jZX7J6Ctb0xFkLK0j+xQyqD2KRp/WZixGzLsPcqdhyuSqTMKcKajl18x6aCPDTPtIK+pZYjpvJXHR5pfES+U=;7:j3U7MNggGR0YK92bolJWVkeSy1V/iFwmR12lNwfuelLlJwlYccxOeFTSHYZwgdq3yeeION4Pfhm32uHwSj4SbPCYc+j00ED+JOzpjy+BHV9JXTq+nrzVWnFw0ztk1zNccOoAWIpaT8h0H4MqA3xhOAmQCZClTwD08Hx2hFOR22yqZ5hc2hd6mHb/HkwUi2WbkABfSU2JPC/77t9CST+Bwr3LrDEFcC4e7dke1SdgPCJdzFBjwjjZQHMzRudkWEgA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:51:57.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcef1cb-d20b-41e3-4ed0-08d606ce0394
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
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


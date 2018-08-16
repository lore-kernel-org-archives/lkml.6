Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C391C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB3F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ax3xTPqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB3F2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeHPWWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:22:39 -0400
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:50006
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbeHPWWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QeUO18yvdbsruVpw+dlEcBZmWwxYMvwAtSRqC3aEY4=;
 b=Ax3xTPqvL6XjN9aaWC/6TK2niIsX4OgIpBQ4IBlr/Lr5Aik589n1FVtKwS1SMbc8gQaqe3JsGRbt8hTMYV+fDYlJT0ZHKzRzcUMqoDpNBS86z4QOFx+2quGBtrBnq2HphMbqO42GJcR4kvG7mHRCUpSI9Iq7C0+LS1zqPddIrWU=
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by DM5PR0201MB3510.namprd02.prod.outlook.com (2603:10b6:4:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 16 Aug
 2018 19:22:01 +0000
Received: from CY1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:22:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT041.mail.protection.outlook.com (10.152.74.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:21:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqI-0005jv-VB; Thu, 16 Aug 2018 12:21:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqD-0007wo-Pq; Thu, 16 Aug 2018 12:21:53 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJLoMw021522;
        Thu, 16 Aug 2018 12:21:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNqA-0007vv-4t; Thu, 16 Aug 2018 12:21:50 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 3/3] drivers: soc: xilinx: Add ZynqMP power domain driver
Date:   Thu, 16 Aug 2018 12:21:44 -0700
Message-ID: <1534447304-12919-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(2980300002)(438002)(50944005)(189003)(199004)(63266004)(106002)(8936002)(77096007)(9786002)(110136005)(54906003)(316002)(16586007)(106466001)(50226002)(50466002)(7416002)(6666003)(5660300001)(36386004)(5024004)(2201001)(14444005)(186003)(107886003)(336012)(36756003)(51416003)(6346003)(48376002)(356003)(39060400002)(26005)(305945005)(478600001)(8676002)(81156014)(81166006)(47776003)(72206003)(4326008)(7696005)(126002)(2906002)(76176011)(11346002)(486006)(446003)(2616005)(476003)(426003)(44832011)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT041;1:jWAyC+SFYohGTFydzOqih/9DspBbThKm6DGWzoBfnU+26+nSQLhZ5I351lSSUGfisYsO52ey4wBJ84Fq+h6SLOerQHm5mntVtrA35bk0Bs9pB+b17wShwD5+utwXCYCS
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ae4c5d5-fcef-4b47-c7b9-08d603ad8a3d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:pg3gzIct4gnwYNAwNK4Y7nWo7wMCcJDvdxnKbdrKVux7b0hvHJQPkjeo6GAGYJoDmMp+oFNQB8HnLHBLDT868+DKhGdFtwhOeC0SEeHXlHrKTjR6oBoLRbQyj1ku6CxXHaQUyRTMYOH9Ncr6SOFeMMDgnyEMbKCvlB2M2vCGKHm0cmVClZUNr8Ohy8Q+8BCDu5GepzmGYRhhuKkhI8+6h0ktLW3MgwJRS2VG4h2/5ysy6Z/UqzfV+X/xU6goKuQ8hLty9aqvmkHr6Y9xflK9xM4wUZfom/NbTy6v2YqjFH232d8FDqDyH03YZw9RCPgzF0tE/j0oMpDP57KEqXEXqqIegTWPR4WnwkFL/e5hoc4=;25:+yxGinwHR1BRCL4LeM7oiXS6wzL2/Dad/T6AYM/pgxGTnsuuN4/jr5UaqssaMpXG64DMQF+NWQUn16Ppj4jfPWwA9yt4c7ZiHKhPPzEjUO+6wtCFsrhEDzsrwkvkBeRg3sW765aDcRaTtHvvryw/oXyIJpyBrWh3k8M4zW6t4F/atMu9jnHP2a5wdJn5fbkwyJzPxXTUr6262n5bf0wod6SnweaVzlNouAXed5SCBEsfAtRvL1KSthQxWGH69MSxAfaDdBFcwypqCxU6BnVkwzCsbDy0euaZrqwduQ1ftMr92AM+OY8cjyNm3mw58bhs/sFQvLtib9PadOyImLF+1Q==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:UE3Y+Tj+Gt5jb0I+538E5svv3iGMYiFY2vC2QQXlTF3eSw1QLrOCKts6cHXa3bL+zgr5kJ/MhG9BW4CSRs0TSgUgBY61shdhtNqv7LoBBD7SSkP59/+CbTKUqXbuFLr4tR9vavlKEAd00bnN1m0Z5ti/5SgrpmyL1aaN2MtdtWz6v+gnykGBKEWCaYat70S9m8cyjGRg2LEt2fslKEF/d8HsUGHzHi7m389MAm9Oafw=;20:qMy/VldNp67b8Sc0Spf7+96U9GqtDJ+3HPbpTB0lXNhf18FpYh7SJP6OPlGIjQ1JWpsS0EZd5zjC1Bq5O4wyIp+/MrR2MiK6pOISPmNtcao2ABeGy1pcz4PLUtBt7PeC20cKMvwKPez0Fep9GTURi0HvupdhH/5iE2oqheNgtuxL80h07EgJE+/v/k0fLFgOWRZUFWq+Skxl3eeZ+NYMBj6eYY80NEMjtFGGzkWfYm2beNo+UNNiGSul19if9TSDPjke1QDA61Wbunva8NFU0qb8b4Pb8g6bdC/HdbyaxY5PFck01tr2nCm4sRJXx9eVty05v5430NeL6eqiyAtN67T/Sxl6K2yip6lfMyqz96LzBFIUdt5bu98jQnVaP58jnvKZWUMXINU8g3378L00s0BX1WqLNuYKJAUegsiF9XGHVfy16+0BgBguXoIkm4lmYyLJw2u0qX/N53czXF4tcPM+ddFt/1RJeedzTFnvoNYmebJ4WOp5nF+9A1OVCwpD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3510BBB431EAE0B6CBE46E7AB83E0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:pgq3Qma7muayJQUmuSMFvhvWhaurfu4pRaV/76uMgvyWZ8h2R+QJ0rajEa7pGtmLC2wRjQptqa3oauo1aOtFvPu9YTxUmtTb8XFvJspD2Nn98NaaPXeB5KQzljM8Yt++WYlpWigPFq/sO2O0IwaX7oP5XMxF8NFJKiQsvr4cjFycg2sJk9+Tn01AzjIJUZ0dWbwJcHmufpSpEREIcFf90kdc7gmzRflt7NQiJl/QKROkzSm4XgrDIKuxeCqPO29J4adtSTWgPJQALOX3QIKGCRAqexuImIIH2Sp/jUCTF+y6RSD+BR+upuYF7qJewsB2efcW1gPGbmGi7Xpt+U6uUc4G7eq5BNkX8k9rA29fCDU=
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3510;23:nG5jTwNJkv5YpBvcSkPjynkED+IrXOhskdOdYse?=
 =?us-ascii?Q?rEL6hOV5i3e1ZBAe3vr1EtedZ6zlr9byQc+n/HcUZj0Lzp881c7HpTlU2ofp?=
 =?us-ascii?Q?6pY8E/mPHpriVm4M5LAOYZHOKQCEnfs9PP+GsNImgc7qaWwZZRw1eUXY9Iax?=
 =?us-ascii?Q?XgeWVCQjlaE0ggzGnveRTaE6MPyvGsq7Far29Ac05dUANR5odmzIL7aPimUf?=
 =?us-ascii?Q?wpnBWWUcDUnF01gjLLhlhEzvSZMbGTyolc/S3Jbo2uk02XxWmktEooBAL0Aa?=
 =?us-ascii?Q?/KIWzV8C7Vqylh3+AbrBsz5WL2vZf4PJafgsZ0O2v5z+TWbgECAG5QL6QDhW?=
 =?us-ascii?Q?gmtibefyZcnYulFVqNdn+txuddHyH1v8m8wFHDiqFTNK6VN0cTe7jX8Xun58?=
 =?us-ascii?Q?RXxLhHYHgIcY0IQ3j2kX44SXXpLLK2LbZuSoQORBhbe7pz7NfAO2jZu7KBBn?=
 =?us-ascii?Q?ue1FkQyDwlTTS1mPEWYTksexkrjAnaizdWbsiIY3mwYoMmrMuKrusJkLkerI?=
 =?us-ascii?Q?lElD81uoqTyDjVvHq4g6wFbjvQea6RfIHH0b54xKWzaqFQ4n9y/EPq1z1yUo?=
 =?us-ascii?Q?UpZY7wu1IvrBJt3KzAAbr7NAzOaREFOHxiVyXr0moO9+Cw1CnHxUyzjsm0gz?=
 =?us-ascii?Q?izJo4eZp/dy2tbXVnGZINHcP0g4BjafoLay4TizgQK2EAygGrpT0OSMCRbmW?=
 =?us-ascii?Q?yEvILSNmQG9T4p41/UBlJ95y09KlvihbguIpv8UPewGrVZSz3YxSSsTEclcn?=
 =?us-ascii?Q?sAeTCwuAWu2s6YWDvV+imbEtVA7V8o7RypXRYsliWpzEOTeuXlLd2SaZBdcR?=
 =?us-ascii?Q?//grLyAuHNQLa3uRGXMIeyi/AKBCukZncoy/VRtoQWhJSrg4PAmrmHuJkACN?=
 =?us-ascii?Q?04MLd5zMUN4jvtxErHpADWyKfR04Drdindst8R3tXLMNeRbO0vF2b5r0cNBn?=
 =?us-ascii?Q?JRtYcNRAKndKQM38zAXQM5vfqWbkbQvw8ZDCedNbzE8u5nkNDwSQqD7cGIpA?=
 =?us-ascii?Q?CDuVR1G1nynBrfcFZ56anVVmZz+ypXJ/4fBh8Tq8kSFDonArnd7nStFjZGuC?=
 =?us-ascii?Q?G3LTpHk84CqexanAsE9Iz4fn1t4ZVgQPmersY1v9fLU5AT8oSCUTIM/VveIj?=
 =?us-ascii?Q?Bqfaj0C1XB03zD7VzF/uXhTBUj+AcKw0xD3hi9XVlBxvvRWZvC/MLkSldrK5?=
 =?us-ascii?Q?7kSvr1b73n3EDc9OrRuJ/lp0m4Da47D+K4TBjk/9DcUYKw6G5YJmSkZ/hMlj?=
 =?us-ascii?Q?ao24byL4JJFo+4rCQb8Cv3VhudR7JWV7rCvv5NNKM6reCxec+ZV5mjEyrCS7?=
 =?us-ascii?Q?ZB3Pi+qDkL6e5ra8YTplPp9SF3AnUNAvkaGhmYY3PxK44GLkbFuUKnxmAwZO?=
 =?us-ascii?Q?yQu6zsg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 7DZZQe78xIbwhGxwMhNt25vI10ICGfaZ7gCWA7b45VPO0nqYWBBLo1K2/u0qu4l0JtjG+k+/XoZtkkEYD/xdXlual966iMd3fjVvdIb3Q3dzsr4TkhfEOYBQ4/9Ysn8Wws/u6P2WfnD4aM/sXcOE50ojdUHopE/REsb11Ddfy26vyMXPLhuKOYm7G7yl6/WQ+ZPUCOZc0jmVyBhpVmUyYZXQQZJ35U845YyiiGJ/nfejmWt63OIepH4kbzX0R4MfhU0mOIbqPIX311mQVQWnklgShDkLGWwInJd3itYKAYJva5KH5YchI3oIDD0oHr03YO83CSCUxywppmxJ8bdGvU2Uwp3YNJNtOb2E51ar5FE=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:o9f9fvK58HU8ie2GZyvbxrag1z5k4oepN2FCd5kL8qvApxXtAhEuV/Y4gL8KAkz6xZbowY6drJ3BBnczauzAkoyk2w0CtW6cx1pglL6BpuVH13UarszQVD9S8njlnfII08GBpO+RkTFpuJJ68kaTejh56lOjRQlugX26kz9bOKwYt5jN4B8gLaSA+EEzz7cvYWdFcgteIl3jSB7Tlzi3Sor+EqyUPYz/dP+xHI7j5C8Xkqr4POLqVVc+34O1Xkwev/Wm2FF0UAamIWKr+RmcDeLo1LJghKcu6ZuxV7VcuXe7lwRFP0d2xEBsq15htxQe1tN25Gk/IoxiLDmSmzqQIQkT4mxnJ7r6f+q789UJe/z6T0LYlXUB5/vMq+9leqkdx0RjQl6hRoMhaGL8+dk5S8S4AcY+2LNC6hxjId9Ty7QbcbbVWM7RtyvrvSkr68egaV+Zzqf6gd5LUwPo3hNP8A==;5:aVEJNUGNigaZ5jT5kLI89XDXLMwgFoo0VYv+5OUTN3v7+Zxz3hmqfj620O+i846m9LX3tDCyzr0570JP2aREkwyLe7koM0NhB/dcnwHpGX0Co5F5Kw5IHzYYM110uZDu+tlnka9l74I1C4dyXOs+CMmnvSaFSPBA+0c7uPaUhoI=;7:bYUEL7vmq1VI7iCUypJ22YBpcJS/b55iANZTF6EVC2s1Io+3OpkmxgcM5PnYkulsfVcZXutb/H5QfistGgsIb1AKKzg9eBbZlwfVcOp1EB289RZi5JIxUbgn682X5NFY+3uUg3R9gORqb4XIN7IDxZsTz0ksyOmGLV7JmMqRr+repJZl9+crBzY6eZcV8vpy4ciKUxJr4B7A8Fskdn+RvECJtmHBqrQbucksRnr8kNR3EixasMrfLMTLLeXpRUMS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:21:59.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae4c5d5-fcef-4b47-c7b9-08d603ad8a3d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jolly Shah <jolly.shah@xilinx.com>

The zynqmp-genpd driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig             |   9 +
 drivers/soc/xilinx/Makefile            |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c | 352 +++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..964b205 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,13 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ARCH_ZYNQMP
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..f468d1b 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+
+obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
new file mode 100644
index 0000000..aab462c
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ZynqMP Generic PM domain support
+ *
+ *  Copyright (C) 2015-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Flag stating if PM nodes mapped to the PM domain has been requested */
+#define ZYNQMP_PM_DOMAIN_REQUESTED	BIT(0)
+
+/**
+ * struct zynqmp_pm_domain - Wrapper around struct generic_pm_domain
+ * @gpd:		Generic power domain
+ * @dev_list:		List of devices belong to power domain
+ * @node_ids:		PM node IDs corresponding to device(s) inside PM domain
+ * @node_id_num:	Number of PM node IDs
+ * @flags:		ZynqMP PM domain flags
+ */
+struct zynqmp_pm_domain {
+	struct generic_pm_domain gpd;
+	struct list_head dev_list;
+	u32 *node_ids;
+	int node_id_num;
+	u8 flags;
+};
+
+/*
+ * struct zynqmp_domain_device - Device node present in power domain
+ * @dev:	Device
+ * &list:	List member for the devices in domain list
+ */
+struct zynqmp_domain_device {
+	struct device *dev;
+	struct list_head list;
+};
+
+/**
+ * zynqmp_gpd_is_active_wakeup_path() - Check if device is in wakeup source
+ *					path
+ * @dev:	Device to check for wakeup source path
+ * @not_used:	Data member (not required)
+ *
+ * This function is checks device's child hierarchy and checks if any device is
+ * set as wakeup source.
+ *
+ * Return: 1 if device is in wakeup source path else 0
+ */
+static int zynqmp_gpd_is_active_wakeup_path(struct device *dev, void *not_used)
+{
+	int may_wakeup;
+
+	may_wakeup = device_may_wakeup(dev);
+	if (may_wakeup)
+		return may_wakeup;
+
+	return device_for_each_child(dev, NULL,
+			zynqmp_gpd_is_active_wakeup_path);
+}
+
+/**
+ * zynqmp_gpd_power_on() - Power on PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called before devices inside a PM domain are resumed, to
+ * power on PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_on(struct generic_pm_domain *domain)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						ZYNQMP_PM_CAPABILITY_ACCESS,
+						ZYNQMP_PM_MAX_QOS,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered on %s domain\n", __func__, domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_power_off() - Power off PM domain
+ * @domain:	Generic PM domain
+ *
+ * This function is called after devices inside a PM domain are suspended, to
+ * power off PM domain.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	u32 capabilities = 0;
+	bool may_wakeup;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_requirement)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	/* If domain is already released there is nothing to be done */
+	if (!(pd->flags & ZYNQMP_PM_DOMAIN_REQUESTED))
+		return 0;
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list) {
+		/* If device is in wakeup path, set capability to WAKEUP */
+		may_wakeup = zynqmp_gpd_is_active_wakeup_path(zdev->dev, NULL);
+		if (may_wakeup) {
+			dev_dbg(zdev->dev, "device is in wakeup path in %s\n",
+				domain->name);
+			capabilities = ZYNQMP_PM_CAPABILITY_WAKEUP;
+			break;
+		}
+	}
+
+	for (i = pd->node_id_num - 1; i >= 0; i--) {
+		ret = eemi_ops->set_requirement(pd->node_ids[i],
+						   capabilities, 0,
+						   ZYNQMP_PM_REQUEST_ACK_NO);
+		/**
+		 * If powering down of any node inside this domain fails,
+		 * report and return the error
+		 */
+		if (ret) {
+			pr_err("%s() %s set requirement for node %d failed: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return ret;
+		}
+	}
+
+	pr_debug("%s() Powered off %s domain\n", __func__, domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_attach_dev() - Attach device to the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to attach
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
+				 struct device *dev)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->request_node)
+		return -ENXIO;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	zdev = devm_kzalloc(dev, sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+
+	zdev->dev = dev;
+	list_add(&zdev->list, &pd->dev_list);
+
+	/* If this is not the first device to attach there is nothing to do */
+	if (domain->device_count)
+		return 0;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->request_node(pd->node_ids[i], 0, 0,
+						ZYNQMP_PM_REQUEST_ACK_BLOCKING);
+		/* If requesting a node fails print and return the error */
+		if (ret) {
+			pr_err("%s() %s request failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+			return ret;
+		}
+	}
+
+	pd->flags |= ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s attached to %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+
+	return 0;
+}
+
+/**
+ * zynqmp_gpd_detach_dev() - Detach device from the PM domain
+ * @domain:	Generic PM domain
+ * @dev:	Device to detach
+ */
+static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
+				  struct device *dev)
+{
+	int i, ret;
+	struct zynqmp_pm_domain *pd;
+	struct zynqmp_domain_device *zdev, *tmp;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->release_node)
+		return;
+
+	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
+
+	list_for_each_entry_safe(zdev, tmp, &pd->dev_list, list)
+		if (zdev->dev == dev) {
+			list_del(&zdev->list);
+			zdev->dev = NULL;
+			devm_kfree(dev, zdev);
+		}
+
+	/* If this is not the last device to detach there is nothing to do */
+	if (domain->device_count)
+		return;
+
+	for (i = 0; i < pd->node_id_num; i++) {
+		ret = eemi_ops->release_node(pd->node_ids[i]);
+		/* If releasing a node fails print the error and return */
+		if (ret) {
+			pr_err("%s() %s release failed for node %d: %d\n",
+			       __func__, domain->name, pd->node_ids[i], ret);
+			return;
+		}
+	}
+
+	pd->flags &= ~ZYNQMP_PM_DOMAIN_REQUESTED;
+
+	pr_debug("%s() %s detached from %s domain\n", __func__,
+		 dev_name(dev), domain->name);
+}
+
+/**
+ * zynqmp_gpd_probe() - Initialize ZynqMP specific PM domains
+ * @pdev:	Platform device pointer
+ *
+ * Description:	This function populates struct zynqmp_pm_domain for each PM
+ * domain and initalizes generic PM domain. If the "pd-id" DT property
+ * of a certain domain is missing or invalid, that domain will be skipped.
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static int zynqmp_gpd_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device_node *child_err, *child, *np = pdev->dev.of_node;
+
+	for_each_child_of_node(np, child) {
+		struct zynqmp_pm_domain *pd;
+
+		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_count_u32_elems(child, "pd-id");
+		if (ret <= 0)
+			goto err_cleanup;
+
+		pd->node_id_num = ret;
+		pd->node_ids = devm_kcalloc(&pdev->dev, ret,
+					    sizeof(*pd->node_ids), GFP_KERNEL);
+		if (!pd->node_ids) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		ret = of_property_read_u32_array(child, "pd-id", pd->node_ids,
+						 pd->node_id_num);
+		if (ret)
+			goto err_cleanup;
+
+		pd->gpd.name = kstrdup(child->name, GFP_KERNEL);
+		pd->gpd.power_off = zynqmp_gpd_power_off;
+		pd->gpd.power_on = zynqmp_gpd_power_on;
+		pd->gpd.attach_dev = zynqmp_gpd_attach_dev;
+		pd->gpd.detach_dev = zynqmp_gpd_detach_dev;
+
+		/* Mark all PM domains as initially powered off */
+		pm_genpd_init(&pd->gpd, NULL, true);
+
+		ret = of_genpd_add_provider_simple(child, &pd->gpd);
+		if (ret)
+			goto err_cleanup;
+
+		INIT_LIST_HEAD(&pd->dev_list);
+
+		pr_debug("%s() %s PM domain registered\n",
+			 __func__, child->name);
+	}
+
+	return 0;
+
+err_cleanup:
+	child_err = child;
+	for_each_child_of_node(np, child) {
+		if (child == child_err)
+			break;
+		of_genpd_del_provider(child);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_power_domain_of_match[] = {
+	{.compatible = "xlnx,zynqmp-power-controller"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, zynqmp_power_domain_of_match);
+
+static struct platform_driver zynqmp_power_domain_driver = {
+	.driver	= {
+		.name = "zynqmp_power_controller",
+		.of_match_table = zynqmp_power_domain_of_match,
+	},
+	.probe = zynqmp_gpd_probe,
+};
+module_platform_driver(zynqmp_power_domain_driver);
-- 
2.7.4


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEEFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA5920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ENNT1Nox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA5920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJYU6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:58:52 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:6377
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbeJYU6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHVi4ueb5H/YnN56KNk4EJTMiQBEuxoQHoDhprC3Gyk=;
 b=ENNT1NoxEblsV1urozt+DkuW/N5eoo8z9ZZiebyDZBGtHUgT2D1X3pabUVikGr0STINe8QWmWKRE6kZAuh8KdkrisxTc8lJvTNXPJaqNm8njQ29zY8e8viR2++X0L7vNiQXWiRLc5MUm4ByUHG8yHG1AkxN3AEsGi7uKNOqeDCg=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by BL0PR02MB4452.namprd02.prod.outlook.com (2603:10b6:208:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 12:26:17 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.20 via Frontend
 Transport; Thu, 25 Oct 2018 12:26:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 12:26:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFeiO-0004dW-00; Thu, 25 Oct 2018 05:26:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFeiI-0005Ch-Sa; Thu, 25 Oct 2018 05:26:10 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9PCQ61E021752;
        Thu, 25 Oct 2018 05:26:06 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFeiD-0004vY-Lq; Thu, 25 Oct 2018 05:26:06 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 3/3] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset controller.
Date:   Fri, 26 Oct 2018 17:54:24 +0530
Message-ID: <20181026122424.30831-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026122424.30831-1-nava.manne@xilinx.com>
References: <20181026122424.30831-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(199004)(189003)(106002)(7696005)(26005)(446003)(106466001)(50226002)(186003)(36386004)(2201001)(336012)(126002)(51416003)(11346002)(426003)(76176011)(9786002)(77096007)(81166006)(1076002)(8676002)(486006)(39060400002)(8936002)(5660300001)(2616005)(476003)(16586007)(316002)(2906002)(110136005)(63266004)(81156014)(356004)(36756003)(305945005)(48376002)(47776003)(50466002)(6666004)(478600001)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4452;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:Xx6oxRMCce31CzfViQ3O3daLcsq3cZhLB8Q9vAlOd85BSBDZpk9W8Pi1I2F6QvtrxLt+tEkf9eJu/5mKWmk9ztrAQ74gsRhIsTbDwkvDJpsSxW+1e0RnNNUJnc86SVJw
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8457c48c-9f8e-42dd-a7b2-08d63a750fa0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;3:VIGyg2XEk8+r5c2CBCJ165pHsF+TCSo69L5ksHRfVBvsGxe2O9ox2IdCf3hgzSqTQt7ETaY3nRJYfva5KJnJS/X6pfbWrYX4ejDcrRnxzCsUNxnhC/JXfLqYIlzcOr2wUqdhGN6yDGio6ea6ORq3sOuWiUxFpe0IT0+/rqZgs77IlSeEZydLNVRMNdGYx05oz0IL0Jx7AKtlTMDGQ24Zl3ifXEbNm6gyk/sPr2g9gtTOcfQvqosLxw+bKlGuJ6QWZa/UPXqRByyi+OC8JacBK2auFH53k6Iere0UI6zKTLL8Pq7fIb2/VQ05bTjb++ZHQOytVB4FVvKVSe1eThmkwviuSxoobgVxmTVc3gGmlKA=;25:l6U0r2iXVXHo+kWOZEW+ICGWpE45DYubL4bPvWgc++V2GL1Nn/XaICEQxmz1NF0rDkKLXdksB6YNn2qvaB/e+8XTwpPwbEcd3p4xH41QGHab7FjzJIrIrXnt2x1gMOuoYBPM2rXU6nY1Gtsza9iFy4AM6pkW/q1NkZQHqt9mlD10+hjTSOBhXj6UKGUfKJYBLypZWqx7iO6Hbyy9rbJajakdPdSvcSZfPu/Cf+Cua+BXoywqb/MwPVdGbxMMalhJ6R1Ve/PVZgKKpgA0M+CgBr3pImNsTAfENXpWJiZuqXu8s+icYWIfYKRZl3eAa7+GB8RrgB5QIfoZkAHFhkzC+Q==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4452:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;31:dtNxcjPkZkWMKRaS8lfcxz2BOCZjja8MEpjY6Vz/RBPLl7usovTYiRrS2qD3Txy0WeVJituwfCSlKWZB9kUg1b6jYd2PovIMWrjKj/uhkMGGJi+cqOX6KoJTRx7giQ6hYOyzFcZ3Lbdzh06w354cYrDagGnOAupmy1aVfTlwlcCW/9Cl4WbJvif9KPWEsRBahZ0a3orounVxze0yLOWdQj3hX6tv5K8Yc+4b1EwUbJw=;20:VqQt8zUCvgGWFTXFoPpbUZOoOk0jpBuabALA9ED8RNIegvg8J/DDnUwfQWFCcLFymyPAC6xCjiI4ITXd4/+JLsqwuR4qAOc4HXqBNfVk+sY0ifJLwY0F+PHJym67K3f397ar9lixm/IjkTNTlbdFyNxrD2ZLy8u6CJaR2ItRpO8ZmfXXvcjgDzBcoIbXE43/HYjlDWhgU2Tj952/aR+EanAscD560kFgb0uCj5B81UF1J+dJDovagIjlsU4qk+Cbpqni+u+ZWjQ+F5C6YqIHuynYsINNnmlMSjxyc1F96ApxtePHeRWf+u6iNqUmwOq7KLYJm+QI3w3i0XQTqGwyoY4dFXHIdWIO/BmG/0xkwxmlI4kToFQzlz46+txq3pOzQZ8biZYwVA+RJqC3Q0SNztHLxInDBOjTilaKr2ClW96ApAqk5SnrwCHIyzvEkNcfp6c+hbsWYszgirgcmgixghXc4oXaDEONxD1A11EW33kWBFbcjPAexhyAHqjuvgXK
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44529A098FB489AE6D89D2D3C2F70@BL0PR02MB4452.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4452;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4452;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;4:u5uX2A0LC0batDhPBOI+IPDtbAmYEC72DJ0eajmPovclAVYxgfgwyVyOZ+MiUFHXEcq552GwMvF1W4YmBG58uzjMKer+B1McpvV1DWJmO+GEQIxYjytb3Rm35z3W6UW0e9JVjuQD9ccj8TxtBf1tyR0tV/+xiEp87cwfZRHM+Z1fv18FLzxXN4+OGoGHf/dVnpKbtrPN00Ai13qFFJx27pQwMTtAC4SxKKK8LAu/nbbvghkY35Z7sNVu9iwnHdu5RchsfayV9cwoEYv7vTdeQpHxONSDcx8S1J4hEg3U0/zixydy3pVKHCXcPR5QXTG2
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4452;23:YtOj6Hzct8dxXrl9rdbdeKmIW5ihqrb5vIzOpUnz+?=
 =?us-ascii?Q?U5wOC8dPXktxqHzSn+zpobYFECo0mhFS1XyU3U1j8q2LtEfboQIWlrr3NSpM?=
 =?us-ascii?Q?BK1aKnBihycDVfPATtz6Ts9BZ2Kku8MrFfPZMzeg0MuGSL8uv+rDY+pB5FP4?=
 =?us-ascii?Q?FQ9+kh61jKWOxNyUgjLApHE9aTTc7J5man4QEfHfyUQTmfP0JCxpUBAkPPFv?=
 =?us-ascii?Q?bf6C9h5iOGtckKzNV2VvO8mk2/Wql7MwOninp6KTAdNozt+v2pcbn5wWlM4e?=
 =?us-ascii?Q?keBF7xgGOSsfd266Ti4YvwoCo46vHTzfyQ9iZRvhvENjCr7cXinq/bUhBX/+?=
 =?us-ascii?Q?JCXq3fBBBMNeu3FB1HVwHqRoo3/gnNyVXjrHxXQbh5BXQJNsQs7BsYVt9mII?=
 =?us-ascii?Q?CwFP6OkxPF7NdBLdNR9dKgxX6UBpH8UCE3lEIe/creECrZhkUukP2PkZQo2y?=
 =?us-ascii?Q?R4wKF5phqS9uiD0TdtHELNqqRsa8XA4+2aRQuDwCWvWJzvYAvJQRgPm1LOqv?=
 =?us-ascii?Q?6fUyLFj2vEaP83EtTbviuAzL1x5HtDmUsUQVw9M06RUccC00KUgUaI+QCjZC?=
 =?us-ascii?Q?qQSyoa95kkAj21UOliDSTD344jXAuM8fwunulnEH1SaUcpHQm3zp6us1dYe2?=
 =?us-ascii?Q?oePNcTGe0hdV8Z3KUeZ6mdy2m2cf/6ifnQPRYBmezk45ChAWCHDpW8kXQ5aW?=
 =?us-ascii?Q?qpA+yrZ32E/+h1D5M+q+aGajSJ2XYtTXCSZqmZGwFbGdBJLTuZSes3PKxuVM?=
 =?us-ascii?Q?ghj6Ayhp3T/BMFOTHVC71hCOfHhnCPPNG8avn+n+CGMMIFA+bEpGdmSIDDUc?=
 =?us-ascii?Q?6CcB7lahhKptyPQNJRrNM5gCQ+xlVVETNPj7bI36jR+vKiuU/NPl8GgbNvE5?=
 =?us-ascii?Q?463ZZHlOMLRWTWFRNk1/X7YNRjtV1CYUWsQZ2qWxiocf8Lmb5vyu690HgUPr?=
 =?us-ascii?Q?xaBfBUqzfXF6Dm2xyx5BSRPAt9cKJQfEzo4DjKgWQidqdDQnLItO3Pc2aiIp?=
 =?us-ascii?Q?IcUriNvLBvKrbu2LOEE/5w3SDkNdsbmh0cteorS7sZXmJONyR5wSCZsyfqJp?=
 =?us-ascii?Q?MM4jswCiOAFMkbbGs8l8ZYYfYaqOjP7cCdNro+Q+g3NkJ608xxbghAmKQ5fL?=
 =?us-ascii?Q?G8YAvQ9C53R2C4/AYr5CT2n2XHkCVWSpPexUkS6JIVQFl6pQQ+iKDS7QmIz+?=
 =?us-ascii?Q?t0NHDP9iroveaI=3D?=
X-Microsoft-Antispam-Message-Info: g+mSNqfV0wEE0EYj+tx4h2A9uXkF78fb9a3F84OA5UDWwbPlEy7Pr7VojvXs0dRH05Ajf27g2yzOX8OOrQWeDvKvUmK1vT7dS5a4esePdeQTK+CDxiZDZVuc33nx9XKi8rh+/qYVA/0EqfCuu44YcGFQsQvoj4h9vVox3xW548S9CRUqQzTNzoI3HkPS/l4b8QMSOYRP/jBlAnoqiNtd43wvh2Puv8Vl3ISbrUCRREtks10WUDoH9iQfRLcUQourvDgONAwIh9y0jsDmww0Cv3fOYxsjhtcoPlXjLmszWMxEccAC6XL8WhN+vDVlPO5GNs0hTZ+OH+v2RczrBlGR1BkrUOSzA4Vb7glikS6Ec5E=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4452;6:PQ99LGQWixSUvXR2KJjo9l01i6W79jQWdnC0ouKDMS9f9TnAVKRQ35cnotZ1mbCjbp/YV8DDKwpTkwhwlQNr6sdSc28rAwehfAOYE+WmfnvFSUoMcGPf8k3/Xo9xFFLJB0f68ibIKGEXJ4sVEIkne3BY2AIQ6V/4jhA/6uoQX5+yIRVCehC4OzjvhLCJQ9IkXYLd615EdB6rAo2wn3ZIsWrUU3FmzU1Azc6zQpqybZCBsqqNLNoG70/5ZA205c3ABJgGOYRX+/InZx842TX/gVS8U0II7tIKtXO1Qkg3ApR4eG4o5gWN2zlwumZSg2uhwLBOouUfNOLyPpGKyv3AuVxb6tH0g4z5sHnEhdkwY7M8tLalARIa4ccHImC6sVu15ODLuVDDhgSW5wpZmh9ivF39UGNcYEtsVK3ReX1aCxv5a6WyKP5oCMYCF/yEEZ4zheTnQUM6UGr/+pqzotUYqA==;5:ikD/LiBmXGvYC7BLWAzxSpQeRE27UE+XRiTzYvoQXvkag/E/T6UMHa5BHuhOJPSq8rZnWcq8Wmd7IJgb+VyTiHlbgogo09OeUhJmC3sh0AFPaF32MPjWYEBb9OA4JcuHHyhE31zUdq0Y5TmJbZR7jxTd083ECz6uYrbmqEcl7s0=;7:fed+57H2v82Bmp1j+kKXYx40t08z/2FPcGqrMqewIdLAIBsHPWj5qFmU7znF8p7WBmqueeLRMiLTkpSsY906UMmJ5eIUETYhIepC14oEowuqzHBl+zIU62rIFHeY9VgngmKItuIvBnP0eOHRJ+ZkzE+oAbCjY0LvljXjmnftnAAV7zzjY1MyGb1qjABgQnztLdy37+e33N2gFSOsJB+gGpLxupB43e5K3XRKTj0cUGTj9tp9mgKIcRo89cY0Wsdd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 12:26:16.4619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8457c48c-9f8e-42dd-a7b2-08d63a750fa0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Fixed some minor coding issues as suggested
		 by philipp.

Changes for v1:
		-None.

Changes for RFC-V3:
		-None.

Changes for RFC-V2:
		-Moved eemi_ops into a priv struct as suggested
		 by philipp.

 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 114 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 4243c38..eb315d1 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -24,4 +24,5 @@ obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 0000000..cff63d9
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
+#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
+
+struct zynqmp_reset_data {
+	struct reset_controller_dev rcdev;
+	const struct zynqmp_eemi_ops *eemi_ops;
+};
+
+static inline struct zynqmp_reset_data *
+to_zynqmp_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct zynqmp_reset_data, rcdev);
+}
+
+static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_ASSERT);
+}
+
+static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_RELEASE);
+}
+
+static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+	int val, err;
+
+	err = priv->eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	if (!err)
+		return err;
+
+	return val;
+}
+
+static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct zynqmp_reset_data *priv = to_zynqmp_reset_data(rcdev);
+
+	return priv->eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+					    PM_RESET_ACTION_PULSE);
+}
+
+static struct reset_control_ops zynqmp_reset_ops = {
+	.reset = zynqmp_reset_reset,
+	.assert = zynqmp_reset_assert,
+	.deassert = zynqmp_reset_deassert,
+	.status = zynqmp_reset_status,
+};
+
+static int zynqmp_reset_probe(struct platform_device *pdev)
+{
+	struct zynqmp_reset_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!priv->eemi_ops)
+		return -ENXIO;
+
+	priv->rcdev.ops = &zynqmp_reset_ops;
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	priv->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static const struct of_device_id zynqmp_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-reset", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver zynqmp_reset_driver = {
+	.probe	= zynqmp_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= zynqmp_reset_dt_ids,
+	},
+};
+
+static int __init zynqmp_reset_init(void)
+{
+	return platform_driver_register(&zynqmp_reset_driver);
+}
+
+arch_initcall(zynqmp_reset_init);
-- 
2.7.4


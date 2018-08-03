Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE712168C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="GNxLPaP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE712168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeHCPAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:00:03 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:36160
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730028AbeHCPAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukGoisITB/zyCmVcdrf+fkC098ao/0ih+sZs+W7fDTk=;
 b=GNxLPaP0fLSVxac1THTq2LzpMbm3YXRCCegVHQCS3lDgQk4wQCHCo4wrl8L5LF/WkpEWQwanU4ORSjl40Enbr53wf6zNiLXR/1tarKnCbvozYAqWd8VWHU/ovdgGm5q2dfreKQW3i2cA6r1GmxXMgt/L4Qoqj8d1Ke9w7CTJczo=
Received: from MWHPR03CA0034.namprd03.prod.outlook.com (2603:10b6:301:3b::23)
 by CY4PR03MB3128.namprd03.prod.outlook.com (2603:10b6:910:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 13:03:39 +0000
Received: from BL2FFO11FD008.protection.gbl (2a01:111:f400:7c09::168) by
 MWHPR03CA0034.outlook.office365.com (2603:10b6:301:3b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Fri, 3 Aug 2018 13:03:39 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD008.mail.protection.outlook.com (10.173.161.4) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1017.15
 via Frontend Transport; Fri, 3 Aug 2018 13:03:39 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w73D3cDW012064
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 3 Aug 2018 06:03:38 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 3 Aug 2018
 09:03:38 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: [PATCH v3 3/6] regmap: Add regmap_noinc_read API
Date:   Fri, 3 Aug 2018 16:02:18 +0300
Message-ID: <1533301341-26560-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
References: <1533301341-26560-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(305945005)(16586007)(316002)(8936002)(356003)(51416003)(7696005)(8676002)(36756003)(54906003)(11346002)(446003)(426003)(48376002)(106466001)(246002)(106002)(110136005)(50466002)(7636002)(7416002)(72206003)(336012)(186003)(486006)(77096007)(53416004)(50226002)(5660300001)(26005)(14444005)(44832011)(6666003)(76176011)(508600001)(4326008)(2616005)(47776003)(126002)(2906002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3128;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD008;1:0PRU0IWJGm1Uvk7qp26qffuHE+ii7Agw04S+SKWNzYofCO+IbjUNxD98YBG8Hiz0kHEF/EWFedwlqdFVBKmm1SSsyxYTM/mBZ1Imzy4MwDCcAfA/+peiWW41AQxXcVNq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca5ce90b-6389-4693-72b0-08d5f94187fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3128;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;3:DIZXJnWxBp32vfZwlaBs83sYd73fnhnUuJvvfZm8HHsYPdJXlXnNxT79P/iZ/FGEpKTob/fUO78VeEEnWhSA4xnxeMHMWqqhG1wl654aJtv+CCgMDwlEuI7R4mon5SPxAnZPf96/MdhRKhj8pYpfChDEgIUe0Pu1exmL08NviVT3vn6VfdwHklnHBDrv6P24xTkcmwEuY0I83G0JSz4IaracWjnFB52NpfeZgnwkAtjNG8UeCgb/4cw8acelrdm0liPMTuYx+fSfzA+okINjaBZah6ET7xGkwoKQk0jmM9/N1gn0vAdUCxiRE17tujnBW1gNTrRutZRmFJygKpD5AYub5wr7gNB4RZXbzVhlDFw=;25:omkqZEr8u359/O1K9AxYKVpW3vGxG8NMI1jp6sRjX6+KqZ6jibY+JgjduwXwghkOK2UWKBHWYTfUtQ5lEiVoYJq7iAvTxgBEYJ7r32cZu9KdC+CcrHb5okhzB9tzuW6yM10Pto+SnA5a2CbvI6mtOmlCYdrZU/qNbMNPwNFB/7GZuLex55A1P4ARyAtHWiUIfE8HI+H3939lvVkVX2oRGgLWZDApvB59qZk+mhlJeK0mfpWr074eu/ANArPu8IZobDhUhCLv5lhMIUgfyu0Q9tXZLdtRA3s8PYqs/QkuR3/kew2Kh9kkVWRovbKejE1SiPS2m/6FRZDPph9+JDDT5w==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3128:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;31:89F3q4LhgY8Kpp0ZMFQqO7YkEYj4ZFnQjr87D1yOTlWRqcoH0YOTVMjAXOttlY8gIGRQNq2I0gG+/86aZDhUOP62Yp8Tjvv+RCPvSrDZvOBM7xyVEDzd/th4/wjES3hKTerAKsaoOTfJwdb5XFhoeJxfS3c1dO1cr1WyIwAUpm9U55/U2cFnlNVymHnT5oyXFXjbo1ToK0uwoviYY2HRM51bai4RrLM0TXx7CWMq/hM=;20:KygsJZVs40arVN3GM8dCsZXbK/9Yqe2A4v+HF7vfb1cpcD26THIw66ApaADKoE4SJ43/9CtaAuLJsA0X8P8oO7Tht1V1yTXugpPPc6KMtafaSpQfICLWQCwQfqxZibObM2feqHAXUN0MQ8pQuTdmp7FjWnjrEDHZKF0NuoLIYpKfUxLjhn4KahHLTERSkqOZ3gJQg0b7cK4Y8xOuRpbQsHaFEI5qYVT9FfixElS8yG8AQVYhmiy+etnCUKKEaeCZNbBO3mWvSRIbAUZ17K40rO8e1yx2Y1taK1sEJHPgjtUHEaBI8/3NFb4b8aHTMqfOvB6z4bCX0/G10PDhRk6YOOqPX9JtfkwQ9iJYngsIRUgVaJQZ13xl6EJY9Jt6u/cWMaNQPZ03B4bRuwo1d0RJ8ZP1MkH4XXXZID+zf9SLSKwQ0Y8/qdEkZsZiPL10/Ro234GsOpn1+7fxUh3iGdsY3sOEqPjpAYk4gWuHRS1DJOwMrhCdVI7qgehk0qRPuNiP
X-Microsoft-Antispam-PRVS: <CY4PR03MB31288EAF01573805AE005E149D230@CY4PR03MB3128.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3128;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3128;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;4:JgrKfQl3o1KMNn/EcB4XT1C+2n85xfzLzCdr8wIKIIybtmXsEL2olnaHet2tzEZZsfTST53xRbl8Rvx59qui2yEO6rHnSqpEFvayUcRptQ0Rpa8kj5dmmDP4h/7uRS+pTkALPtmrayRSKsK9ouOrQQc8pToYDo5YIkuBTVbaWKBI0jHhSNw6fyZF+XQ8Ica9XwAqHSgWHldaZ5sspe40Bf7C+jwv4Z0LqXBA4m7WHKKoNQRR/qNmQ9WIr1n6eBigfE609i0pp19i1xs50CWnPJu8m3MFFTY/asFe9iAWsquqZfB4mUld85UZOR9wYusrFljZtx9VVjicK7sj/es9HUgPKptqWU4hS7A8zB/49p4=
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB3128;23:ar7P04GY+xBoHZX3QNzeVuyCRR3ATdFb693z3UDEx?=
 =?us-ascii?Q?b2Vf2Lg+zrW2NzE+v+dbxOAugLZXts794D1I4fUYsz+Ue39dW4RfSI9I+rQf?=
 =?us-ascii?Q?J3N1m3MfemVTJG1r12EiultSssDBzC+TWY1kVvUhoYrbzrYoxkZ+qi3+o7/Q?=
 =?us-ascii?Q?N9pvyJ+fU7dEITYM6TpHM6BL/+PixTBDw/lYydMyoNelrdA5RaVLA6SUh1SX?=
 =?us-ascii?Q?XME7mSX6af90taTXdzQXw8M/A0pONi4hfFNvZEpA2chB4VHdIfaabEo+c3LE?=
 =?us-ascii?Q?Un6THnB21xPplFW6VWzNoMQmS0AB5T4YC76Z7eBkXlprtdRZvD1C1cHNtibV?=
 =?us-ascii?Q?8rkIm7zYEhfnOLGHVuW2GAA1rlsPPMMNfTmi4xFDlQV5tHS6XHIAMLycJrpW?=
 =?us-ascii?Q?41V8W+97S+KpPqk6UFqFvR9uSWYgNRjFiy2iQfF/Y8KqVPRJdn3DGsgtGe6W?=
 =?us-ascii?Q?1KdM9FjuOg0D7/QNGrBb0+8mZwTKjANhw/tjXdS8GiMxzO4m2cW2LNriGbrh?=
 =?us-ascii?Q?1EfWPvlTTWbnGRhtV1mPRgHpvN8IQNH/owVe+/TwKmNGeOVgMUOQEcosTLjv?=
 =?us-ascii?Q?Ve8amZDyK7Gqm63Gne6d9WLjNerHbMIAX9A7TgmpngKKTiDh2ytCNp0eLzTf?=
 =?us-ascii?Q?H/NKLR6jfmeAFl2DSfFzVsXjrg2cMIL9yOUOR6kGtamW2BgOFeu0vA/u4fB0?=
 =?us-ascii?Q?wEt00cUlZmGzD3LKLzOfu8BwnWHjwpp7RkAhitCEYJ7+nBBQqZKx8IjtGiZk?=
 =?us-ascii?Q?PCaDRBwzD7t0b4x0U6zMRWFtXyYTpTd9MAbaenaBoPFYrCNuTr6wDAf721Vy?=
 =?us-ascii?Q?0BWFVQBlcJEmKqn3JhbJsEZMDPmMQiVN2DKbKrTWBOpFPx2G+9fPRsS4QkYm?=
 =?us-ascii?Q?IdMG69LqoXjLMnw6l0P2d1GI1yEbxl9dYd1pkUpampUXrAid6FD8yM/h/KI9?=
 =?us-ascii?Q?jK1yU1VWp5IcClk9EMd7oIAf6mysliVzf8WPaG443UkzH9+2UxPCza1JdbKD?=
 =?us-ascii?Q?x7pxyElbhRr8zCF/CUiZZd7MbDF8RsyBPviU06lKWj9RGnu47G97k1CrQHF1?=
 =?us-ascii?Q?sxKf/WYTdKDNqppjKR9b6XGK5RAkRY9n3I/dT/D9Aoo2sqP202iyiibtGzj3?=
 =?us-ascii?Q?utdLcYIUZA=3D?=
X-Microsoft-Antispam-Message-Info: alM4B+PYsd6XAtDBqTCIFg1EDnIzgb5Ooh8PizzO9mX5VpYqc9KHSQ8OraMCJVYAgxb46xawiz5lGWlo8X5MQSO3hMRdEGRBYY6Yf5BHxBTzr2bNgL6hkpj7CrelMIr4agGHku+rrxn6h5Dg9Ypn+3e+Zhm2RCtCjJy+3tn5oazGO81k0C4xG46G/nwUZ617TSxuFu7eggE4ec8WGMmFoo3MzHMRn7RhQosJyX1s+NuZcxYLQuS34Km6ijG+2krKEe76pDNWYgI+DsEgVCU1nO/9mmLsJN21okaqvImv5DK+5MeHne/F5IrrgogqUo2sIpkFeCUtvQAB70QwP1v0d+q8NMp9I0sBzS1gNAtJ1ks=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3128;6:P21NhTcQh1d83OLn1PbqK1tUjnAen5a1D/tWikJm7bVkOJyUpPaMoo/7oEBzvy+OLjASNMd4/foIzV3t00HxAUMDepJQF9cb4JcRem3vGBrKFNiEMSjaJSd+rA0gGZo1wCJLg0pExGwql4B2BGfLg0p8ZxizhAEhV1O5x3ZVJ+JmzOQv/PJJKYEEv5j+yayGQgotBtQIddymc9ylidFVcKaokBbT5ZEBTl9U3bQTzkKXRoCdcrCZCWe9ux2LeR6Y/msBt6mcsgQNmTjMWROkP7UJLIwuXT+hi+RZ2T8IxOpQiw/HjaSdXHSM1t20Epcry4F0FjZmzeyNAkb60yiIoUqLoj6M637kFulSOwrMKnHk0LwAA1tewfHedOQnHcsgUOGAU6ClFM+GPSfn8zFqZ3SZw/LntxqkjMrr+7zv5BGO0QQSNzZ4+GqZbEY3TpHmZntDCP949gkMGpXSE6iBKw==;5:/g9+1JPZi6hIfTM9VkWOgi4/3igOyCGFkdhCPTecxXsZ3NsIhh3W9zE813Icj/8/Nx821RDUGhZwhtiJyv/UEyw/x44HTrmqr1iu/l0qFFpY0Xo2OzD0STGIn9qlWP5Xlqded/U+lD36il4YAa2Rr4Mj3OvVguVhkM7FPmtwDoY=;7:DCmPYzV54BH843tRMD9POt7lHLWQjK4SfZ++YhXnd0CIRkzRDbt9p2995MWcKM9osT49Ic9jUEiPjtKVkjYcvs1qBSMnPZ43WEBo06qY/8zTfS7ssvtGIQip6w3GHi67KjgGSAHqibFckSeoKoL3W/kO2frUuSWMRGNnsvUP2Pvbjy5ro3xkyT7wM2t6LIlHPMjIh9AybB7OwS2+Zj6OPi/na13ZRSL+R0o5Nhhy78wP6d0Ts1XwYhtJ6jJLoQfu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 13:03:39.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5ce90b-6389-4693-72b0-08d5f94187fd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read without range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/base/regmap/regmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h       |  9 ++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..e632503 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2564,7 +2564,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_noinc_read(): Read data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_readable(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..b6e6040 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -946,6 +946,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1198,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_pipe_read(struct regmap *map, unsigned int reg,
+				   void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4


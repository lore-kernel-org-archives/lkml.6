Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3FEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E66021C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LV6wJ6ew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E66021C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeHIMzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:55:43 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:28428
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729928AbeHIMz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXubrqdZnPn+pHL6h70dULRISxfmOtbaLYGnCyJ0rC4=;
 b=LV6wJ6ewjyodwYeN8sqJHH6y2KFC+3IVe/xLWG8Uao+DU40xsv7UW0qIGGTsnf0vHDqv9DG2G6OorfL76UXkw35lfgC9/r6v5kmmeWLvnW1G38ssXToLL74ZbI8ldREL6LxuSvOa/XK4RXb9eHTl1Ch82BSczXCoK0CQJntWc7A=
Received: from SN1PR0701CA0050.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::18) by DM6PR07MB4713.namprd07.prod.outlook.com
 (2603:10b6:5:a1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Thu, 9 Aug
 2018 10:31:12 +0000
Received: from BY2NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by SN1PR0701CA0050.outlook.office365.com
 (2a01:111:e400:52fd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.22 via Frontend
 Transport; Thu, 9 Aug 2018 10:31:11 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT003.mail.protection.outlook.com (10.152.100.140) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1059.4 via
 Frontend Transport; Thu, 9 Aug 2018 10:31:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w79AV6VG029442
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 9 Aug 2018 03:31:08 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 9 Aug 2018 12:30:59 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 9 Aug 2018 12:30:59 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w79AUiSw025027;
        Thu, 9 Aug 2018 11:30:45 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w79AUhOM024965;
        Thu, 9 Aug 2018 11:30:43 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <dkos@cadence.com>, <adouglas@cadence.com>, <kishon@ti.com>,
        <jbergsagel@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH v4 0/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Date:   Thu, 9 Aug 2018 11:30:28 +0100
Message-ID: <1533810630-17673-1-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(36092001)(189003)(199004)(4326008)(87636003)(51416003)(48376002)(50466002)(42186006)(316002)(7636002)(305945005)(8676002)(478600001)(50226002)(6666003)(26826003)(107886003)(16586007)(356003)(2906002)(36756003)(186003)(2201001)(26005)(47776003)(486006)(8936002)(476003)(126002)(2616005)(106466001)(5660300001)(426003)(110136005)(336012)(105596002)(86362001)(246002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4713;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT003;1:M5mEnymf2jMQx4ZteZQnq8T+bwff0voNu1ra5cezntyCw01yFBGRv7oE0TC8ldd1PG2WQoSsYGSiXVQIcw8SEtIozoCrgWllBi4ItiK+i7u5c5TmPmuLtrQM0czBJowD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a9a7982-9bb2-497e-0267-08d5fde339d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4713;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;3:DHki3d9w/4e1XBdEiuzmDPSyyFrI4phD4talwJJg/J39/RbDDmmsSflz+UF59NQPF3Olmnv3IfdOD03nqG9867MzkF8o/QcPRZYFrpN7hcRuUmrlKHCedfieKKC9ckgBSmzRH0TUy7BuZQ5KCi5IiH2liFCPEhfp66euI8PNaSGs1sRi3tQW9tezTwGab2gVzxS5rPSqLQjdFWJ7t1IFiburAksao2/eue3pgCKy6t0+ZJz1PDL+zrW0BPDzJPu9KYLrRbbtvXT9J4/xqsI0gGirojQZeEmLjXabD8opFvMKXyI2aykBivUll9/Smn9rH/aeltEzts8bN1ACoMCALNQYw3LsDgiv6txja6jNKHg=;25:0zCjFIZti/h9iZj39QWOWxFMVJ/gcdSCsq6nPs75ZgC6FjYKwQcH1scBzeJe2EbQloDziO2wtKa1xdBNDFHZszLL2KMqHT6MVZY4A1NYpK9By9WNfTzaahySdV3ULe2eYeGUKVqMJPse17TBy3YF4lVJwuOTxUW/9+eDA2z0jNve5W510fh43YQvl+g9nffJ8sZN1h7/ttwMMYiaG8FQxxziI7OhmVmK4kDgsKUi0SPIcMEALBZWU4TKMUTuoM3VxotpF7aQd4lLy3805hHt6+hrkgAqZN+0D+5zc4rrKvCiFzmz/bcrENbYTWpj6cX63OhaP4tOHRl9zVCaOUERFQ==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4713:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;31:jKEoOsS9hPefzW40DobsdCxMWSzlRM44AwxnCn9dBkzkni6La4jpl7oGwW6xfFCqNACJKzZO1APCWckPq1LGi2obl/vAPc88RxEwmoXp1vnkP7z7EX4q8RUsQ5SnxQ/8FFj8vhCf4S9n4Edqo/miZYQLkKE2G4gX2HcO3Pk1fUJ0+6qKXWJ4b6cvREJ+Gs8I6BRywmMkRZxEjSMNN3sAP2DTnUi9b0v2g9QLwR6b8Lk=;20:BG7/g1LAtMMJTOPLlDhvdFu0xe9ihZFlZ0aYu2EtqAqhe9iYtaZOE6aZn1p9yh8YiwVoxZSYbJWuynIPWLeEc4MK5RYl5ue2rxv79r7vABMCEAalfJvUCsUrnPkrjZhy/7r04vzK+7b8nQwjvAvh4TID0gVoq0vCo9t3V3YVZXHA2BFYJzQn4V85ZXtsY8uS6xVGvK/oNH0TkjDX8MdI7e8vNg1V47O3G8Psk0C55Gw6qIwESBEmW1p8Ci+oWvxyrkusRBIpAOMue7GsHEgUyLFE6JH0hUuw4bi8Kj3BJ8Jk59TJSaXAujX3U9OHohqwW+DMbTkDhaDB1VmWMQxKYIx/ogYq/jghvEptIsH2asdMQIBL3as3yYsaqymyzNQUC3eT7Pgygnzwe1qL9uisMYw1o9winq6dPIXrG3JO2LEh2tU2Hvr0icWsGNCt4G1qq+rfiv2Q01bBHBKBRF4NUSqI0CWAgJIwR6JV3iI6fvx5QkIPw5gS3OGJZWWDo28S
X-Microsoft-Antispam-PRVS: <DM6PR07MB47138DE735165F8E6DB53875CF250@DM6PR07MB4713.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4713;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4713;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;4:BEtwOS5GyCrS8QOAhH09Z8HGKUWrjTYIg8Ug7AOHa5c+fZ/1Ha0Y2xEHnZoymwecZ7kuemOOxGIFh5LJU83wnE9tWeToqPJ8prEpUnFGxONfnmAqM+zrYPnNcgtWijzYLzVLcxF9FurMCxzaOHdlVhCSTn1Cb/WHnc28VRhUI1EbU9nVJaAN+Jl1Hs/xivDjMKk+9n5qnQX2F/eeBwoTmls98/cCPJ1G9T1+9+skDrV00R4pJb2wTDn+bQYMPY+lOFDVEfiofPNFOqPkF6jbpQ==
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4713;23:0on+lvnl0iHi2ZrHlVMq/1SXABC9L882wWeMBmWnH?=
 =?us-ascii?Q?8E/SabCs9CZ+2+8akTTVgbldRIEUebriPkv77UDgAfsg0Za5vdIpHVAgnY9Q?=
 =?us-ascii?Q?scDRrGC24h9YszOLF8FeKzjHDX2cgAZDIyQ7FDzy4bknuOlzdV8zNyvZnTXf?=
 =?us-ascii?Q?Jn2B7iRWjlDoP7iY1BdGRBDIpSKkiTvOHBAK5MbFECLVphfxlqWn2SKB+tsj?=
 =?us-ascii?Q?hT5ZzJyhJ2OEjmHgfS7id3+ulXVgJvb2W/t1GtO8AIFJmoBxQ3LRJSYShs3+?=
 =?us-ascii?Q?hqAmEc7BSC+cSgeKHtMgMP3V509ezeSD5wz39/P0buM6EAPatE4gCBIcB/vu?=
 =?us-ascii?Q?fM0qxH20YSN5XRsdiZR4sNIsmLINdPRnRgvxOAnrxHjLKRwgRZJ0IlaeSrLU?=
 =?us-ascii?Q?CxCfRHqE5+SQSJWBqmH4JLVSV3/Xs4u3I1VsE/9bOMDUiOq3XGbN9wjMcKKL?=
 =?us-ascii?Q?/mpgAtDNDTTN2rOYJ14OjxBr9nyMcvo4VgIvXK0owSZq9c/W4zzvz7Ov0BkA?=
 =?us-ascii?Q?yzirQ+y/w/6XOmKYGlcpH5HFGzu+pgHfFTspNBqcyIdc7Mlfaqd4QAZF3ccv?=
 =?us-ascii?Q?bjg+t0dzNkbNpQw79c+l3YM8MVDME+ueDYG/PMa7EWC5kjXMqOfsRB4H/Fc+?=
 =?us-ascii?Q?UT0OnPlnWjovuyjysjBC8+xAWWbJ9MwwAxOIUa9tiEmvQRh4ljiXhdTIQ9gj?=
 =?us-ascii?Q?VARTDGmG/mo0ay02tB87NQITmetSUuDix9/nsODJnK6E3617JnltO6t+RPs0?=
 =?us-ascii?Q?0HfDns19KhNV+OUktpjTh3LtRciSE92mEC2RSOHie0v0kgrBoA+1PQ95Rw0f?=
 =?us-ascii?Q?n2LKVmQlBlt4IzZCN58SDbV0q7odqEQsVvl8Ww8r+ewkWf4AQZYcyvUttq4U?=
 =?us-ascii?Q?WlZ2DxlGkYbWn3WiyZg33EKmGx5rk0k80QRFXRbbPwxLXhWerzqAojLr1/cp?=
 =?us-ascii?Q?gbZu+ii5EG8TKzmeLWYAV7bEvqk92D35K0wE4VoISTjzeKOVGXzJ+IXbgNev?=
 =?us-ascii?Q?36copLsU9LgNZqY8ihQGOCqxOqd5xJ1JW4VSxi026PIOw=3D=3D?=
X-Microsoft-Antispam-Message-Info: JxYnuH5fEYaX7XI0DYFsgkeSx1S+j+fXDN/1F3CVmhyW9rvW04zqRdKH8kbKdWO63eOlPUzkMz0WmkpkRvpgOfW+zsqWm0VNqKt1cqgu0UXB4ilRwHtWx2cXHbWuNaiJp5taZfLyYwJzf8k0VECAKDx/rkzvI05RLh2GT9L43bkOtlFee0idXeRiFtR45ddhb0/PywdxIDGPqMRbYrp3TUqYJICXo+mXfobCMjEosexNsiVduKE6LBUgPkVVjfVqPVkzwFf2x3NYt2dQ6g8TuAgFSZJ1WiEn3SJ1MwzTAbjUa/ItGG/HjtboiWmlda3cIV0cXUrp0TBdss5EaxfOFoEMPPQLgTUae4JKJnZDW4dcWKir2CLRxVdP3s8jrxv1FSn32OwCYrQpCiFLhD977g==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;6:OJZucFSTuzrnWmSQd9m1Y+E/kGfhzoKja3iSTG56Uj2rAYwmueiA/+lKDQCW1jlZ+FLh5PkxcrKRZmLsjH/bvpjPO/wxuoeAC5ZMJLTktahPTQ+JeVKYMJpDvV3dbqtAnhtiL+gobKh72XhcIArv6f+eFPf/cdfsnbLk+DKreq/DxxhoRJT5nzHTk3ni/WqUiFUzvWgBgOeEBtfu0Yz0IEvOXfXZxv3BERHAHQgIXpy1M3U3GT8IsowyiNiyVgOaWDEi3C/jP/VFBysFNsRFT3XqHxvP7sKzqFMofapvUeIQ2iwSFqsEirBWTnv6JvUVaAjRm3Vq/EA0h4KXTlr5rEhFVSnIMmzhCaNLdJYlpv7hcuRY19Moq3/8IYAi2AycmEx1OLeQKDhfmDZcjhXzkQkUIdSen+GknhTqag1CKNQJZL3ZvtISsg9qRJYpdShrUI+HiCZmRWqhb8VwNO85Dg==;5:Nd+EnK+S31NpPmkQMo00PRnvgLsEUFiYVOaEseHHPSXPldu/oQgZ4ZsGrZRO7lrbZpEPgBcZ3WAgjkzAqiGAexUCATtvBSoX5YyyQH29+aC0xlXXY8bljyCobbcniFwPncNkKYx5K8hjzQM+kqY/Qlati5zojnWllpTu0xJc75Q=;7:303YnoXeZBkncnLnMOuQFF10ow6TloZI03Z5nB4cpgC6nWiIAiSZQviXMfblGscN1jB29SSHRQmy5aWL4sWS0U9L3IKTQ2mhrICCpBckhJGhP5/EyYsHENMv1UnFn78wdGouxXMZpRPlkS3Ds2Re7sGTvWuZq6anSSU3CMpVNIrH48abpPHj9pj4rn4Mqv1PT48zNDDdDSEGJPNhO4iWByPfs6M1CvdMmehmSUE5Zz3DJX84xqUSh98m5p+x975y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;20:Tey5qRlRMti1DyeRYF1+c/qxbJfwrLVYmhN0yheb03iK80ArJ/HhVzdMVBoDnsIMnftcw8YWPSAQlbnLKfx1YlekBIpfcBaaWjIGJWMj2/QS2LoV+W9rN1/BHgJT3iByK1yq11frslbNDsvuIHlLa3e4f74/adga7KEJbs4uQjb4BCBXeNkrO2HAvbFK/hcTkZJ9TpR2onsgnX8yLJsrHf1ymVXV5GM3Xm7a0zddpCr+TRD1DT28J6ncpvwU4X4m
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:31:09.7951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9a7982-9bb2-497e-0267-08d5fde339d3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4713
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add preliminary support for the Cadence "Torrent" SD0801
PHY used with the Cadence MHDP DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

v4:
* Comment formatting
* Describe "num_lanes" and "max_bit_rate" properties as optional in
  dt-bindings documentation

v3:
* Split devicetree bindings documentation into separate commit
* Merged phy-cadence-dp.h into phy-cadence-dp.c
* Moved probe function to end of file
* Minor refactoring of cdns_dp_phy_pma_lane_cfg()
* Fixed SPDX comment format

v2:
* Fixed Linux/um build 


Scott Telford (2):
  dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
  phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |  30 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |  10 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-dp.c               | 541 +++++++++++++++++++++
 6 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

-- 
2.2.2


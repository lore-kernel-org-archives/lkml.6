Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0DFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AB121763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DZ3x+LxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB121763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeHCRGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:06:12 -0400
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:2801
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHCRGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYFPTBoojxYAAxQq+wjmSpKdgtYm1C4vEMmjnIfz6Ww=;
 b=DZ3x+LxRBbDQIxkZ4yUcneP/xppag3C0vDvpZkSa9YL5fdxSI6eQstb+/zLsdHrkFU/m80/wYtECU16mztuGvgbo87hUIvlkgYkQFrIklgUF/rA6zKhW+FCOeh1wFms6GGMu2pfue6GNsxxQuX1PfW/AQiTDhRkZmoy4V5v6RTg=
Received: from SN1PR0701CA0048.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::16) by DM2PR0701MB1343.namprd07.prod.outlook.com
 (2a01:111:e400:5119::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Fri, 3 Aug
 2018 15:09:06 +0000
Received: from BY2NAM05FT017.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by SN1PR0701CA0048.outlook.office365.com
 (2a01:111:e400:52fd::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 15:09:06 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT017.mail.protection.outlook.com (10.152.100.154) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1038.3 via
 Frontend Transport; Fri, 3 Aug 2018 15:09:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w73F93aS004802
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 Aug 2018 08:09:05 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 3 Aug 2018 17:09:17 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 3 Aug 2018 17:09:17 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w73F92Wt004601;
        Fri, 3 Aug 2018 16:09:02 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w73F92l6004593;
        Fri, 3 Aug 2018 16:09:02 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <dkos@cadence.com>, <adouglas@cadence.com>, <kishon@ti.com>,
        <jbergsagel@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH v3 2/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Date:   Fri, 3 Aug 2018 16:08:31 +0100
Message-ID: <1533308911-17286-3-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1533308911-17286-1-git-send-email-stelford@cadence.com>
References: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
 <1533308911-17286-1-git-send-email-stelford@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(36092001)(11346002)(426003)(36756003)(446003)(356003)(7636002)(8676002)(305945005)(246002)(8936002)(42186006)(47776003)(16586007)(316002)(186003)(26005)(336012)(51416003)(76176011)(110136005)(4326008)(107886003)(50466002)(26826003)(106466001)(48376002)(5660300001)(87636003)(478600001)(105596002)(2201001)(86362001)(6666003)(575784001)(2616005)(50226002)(14444005)(486006)(476003)(2906002)(126002)(2101003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1343;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT017;1:beRo35N6MQ2XepJ2h0rQWRRxFVYDwWW4anS1SMsD8tS0wFPY1MZMAfQ4JaXuPv1fbmNZlElxWW47R6++ubjzOszuJvI1+L2leVOTvwajpNFer8yda+iqyxk6Oo8JIPLt
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b245e04b-3c7c-4f1f-952f-08d5f9530e59
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1343;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;3:YcCyTydz0A4nW+mZ5feRMT6i1+C+sGL7Hqfh26JJ8EBV+B21EB32eZXYbq6mQ4BSknu/fdMQYb9K/yORFl49TT3v6aEP67cEWgUx+GqwQSF7uRJKxyuWHlvlrhh4ZgqSYj+inpsBBhKp5G3O1NXFw9VQuV4L16UL9vXNHGMIuYhZFYnsgVEOextfutLnkmwMOTJOYgRbIYt1X1YQRjkgTy+NWDpEEcuqQ5JcX4e8Z1gT2kSNQkqefvfc5K47yF43PsCgLfv9peb66Z5WgIlK7DFpGRAOHNK5AEYe0x+XOuW7lnQ+hFFDy0mS0bu2SlB0H8tYP9h1ziqp8ovRl4yJGWuTHlSej+0ZNWFmQfPJBkk=;25:PGiHKcavz4+W3tX6AdPq+OTzfYACVnsulrv3eNyHDGb/vW1wRbHZitRthdJEy7gwKI+kRP3lBWtBUr064MvL6GFNeEmvWDJ/r+6ySnsGLdA+ptmTurMQEXt1AXcN3RwVtdJ7RQpskC7R7njDePZ3UcZPz5wDpi309uoTuwDe1T4WtLp6Brt/B3dsifJj0gcgkY1qSxhKAsHtTUNmDVCh291ecqFh0xaHT4fXXAWz0a9cuK/1EFyR6UKgMIjQdtNyklhBr6eJ7oIpGcuEIS0St1ZXzhITTSbFrFseU8wCj5Mz+MqCcReoTcKrs6J8zzqxE0qMMaG51Cj1kSEIgIsw4Q==
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1343:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;31:mfMoCkmBQZHr9s/eFQ2P0cRlAj6kxtrhvFvG9AEGvrrc1X17h3qDVgMTfGPejSSlqCE4YlliYwNB9Old03TAhv8Jc8RzbXpSpHhVehzceUmJJg4NgMIx0bV0LCVs518TVXi8brIxFz0WdkKDDKcyeQxcme+FtKG4YDQ8UNUMUwJqKVTim+17YM7YhRIYSfNTx/4SffiNSzTJok238fOtZ/NcR8+j1BlaZa/WCW56xR8=;20:xbh8Agqs/kMHf88Wl7+Qimg7n+At89vNymPNs8LtcwNG3PaNuDNd9sWSxRcXqVtTVjVAJNXW5l49XOliCs5oi7rwhajxaU4fjwu8Q9iqUdrlEeY0vRPSbQCzZAKKykqfYhC3Hy5NADlzZ6blqULpBx9WLirGAadTQoO1JcQXXguD+kMjFiJQ18FJZThqM/Uv5b6mhfPjYfhdbBrBTlqVBgoEPqE1UE0whliHmZIkz9rqxjewhCObCqr5pzO3z5N1BlkkBf4u9UPzeOnQR0QkaojqhghrStrQMev0uQzgWi6ilXCnXiY91UAT7E9Ym76X645hcftVG387yaAyxriMDcoUcpLdhD3jkej2nC6sfMDV3zy8zLYLMA0+8yUMK2yZ27diF2mnPvGSdLiqknuknw6VVafxsF4G6MRxxutYsitA69XQQrjpRYgkQcFnfcYFAODxJhLUq9/0ugxLncPdEagHdVYUSv5fEnCwnz/VIEbh1tvt+Z8d+6rxnrPm4NeT
X-Microsoft-Antispam-PRVS: <DM2PR0701MB1343A4C818F3269C3EB3E953CF230@DM2PR0701MB1343.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1343;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1343;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;4:B1LumKsEITwuSojcnXspwdfT3cFONGLiLK6V3O8ay+rvi27nvE9gP3GDYyEW5tuiYz0qN4Jy4HK9EAyqTjTmYbSaIpPT2XenoLPcLDi8CCwx4qrTPpvPZevn0tSL+Wcj5y0b/eAgP4f3hQIhsyPjGpcjC6ZkHZ0fcuN1bizO4Ze33zrjF0utam3HhDYv7daNcQ5/HI7v5T8vLn4gimJOUaOxJEOZzD4050XOmvwWL/dTs8/hdpXpLH+BJXKTMkhg3C0ItAzHW03zAQu7JWUnaXgxZzZbSWZCfxaHXys09BUgfbQWaL7jvurco1EOEMue
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1343;23:GV9T/J70uX98h8XWDPPnK9WgM5HX6KPpIyJErjp?=
 =?us-ascii?Q?Z1xV8Mb+QsWogvS8NSU3XByV9vnfDJ4UbmteoUoQxsRKln8JIWru6TooOAwE?=
 =?us-ascii?Q?zT2MTKRYONV8KJExDOkirZwkECpxpQXA0iadwclU03KSZiuNvFbH7r7UpYzo?=
 =?us-ascii?Q?xPF7owIfU9rQ8V51lUy5cM2IHljeLZVOPXFp4bqNY/XlbIQ3fRmfp9BSeNVY?=
 =?us-ascii?Q?/VxFHmCxwPxKxbUWl0Uohv3l8BitXJk+VEPTsYV75ux++7jfc7/OvPUeg15N?=
 =?us-ascii?Q?XVdb+zQ6fppDgYZLYb60Q7OUClgAJTo6RrFN2QO3jTTwz1Dpc3rlw79BB5Yj?=
 =?us-ascii?Q?VgaiFeIFIKHBZ6JZGgkFhoks+XmIaS3HJCa6dWDH5+62Rt+n4UNY1a+1AQXt?=
 =?us-ascii?Q?QABkHn5Sif76Bif5VETb2p1VNlrJc8CFoHelI+/QTeSR3M7Wi0l43U8nZrkU?=
 =?us-ascii?Q?SxbhUiuoO4QpfLCbUPMSlxH7mwe66vEvMeOumMC1Gli6HBk/07pkKJ1Jpwtf?=
 =?us-ascii?Q?C4q/Hu0MhBNmFoQTYGFrrp8RIDdk5opKur7mDawDjy+2AuYP1EGUkVU4tkAy?=
 =?us-ascii?Q?kz+pf0a54Goho0KNNUIIX7E8f7LIfpwjQNGWLC0d7K3jwlpD9m9VXXPVYlzn?=
 =?us-ascii?Q?c6q48S7VEZV4YGletngwUDHU/AMwbammCECWr+rZh+LbEIXOEDqEZPrz9ZxI?=
 =?us-ascii?Q?vg6cdqbckYcKLQxe8GyxEMDLrlr3/KXtD6bt2Bz9GfsaRk2AxcqoVcs9Bwm/?=
 =?us-ascii?Q?tA4+3AUpmZ5Z2dSo+XPrDOK2ohyt0WqwlekzhhUho6ZY7Z9b0aAGqfQYD6T6?=
 =?us-ascii?Q?DSPL8p9EJsHZsKlcAnjwfaM82Tubv4N/XNLq5KtlrlxZAqlhnNlNo2UwbWDr?=
 =?us-ascii?Q?PHftBTD7P8muqFIuZnuhOD8sZvabmrlcTjlQ19P1fkuBy0+FB5F3Ux9FKooA?=
 =?us-ascii?Q?rqoE6QxcDH2agrUhX7VkEm2WnaJTMyn7JD1PsWVKXGwDydng1LgKz4FNile/?=
 =?us-ascii?Q?r4A7q/PpvdCrTXRpBeMy3LUnpByVtzYiVQkS74sAN+rifxfOjnXtMuSnALMN?=
 =?us-ascii?Q?Mt+a0W1wEPtcK2UCbqxSBj1gnBbA+0OqLZCAWHTTIPMmNdmhC/7kGTq3nmog?=
 =?us-ascii?Q?IJelzkqqdI4m41ql/6XCnEuB3VYw26kGup9j7qntBSKX1CsPI5Y8QUy69z+n?=
 =?us-ascii?Q?uHimxN8jWTWPNdafQI7L8qkHM9C8yOAf5uBCwsZvNRoKLTScsTqsnD3XEJg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: Luo2XMNd1qG5AbwY2rQ/XsnsDswj80JVk3lVZfCTB49gBrzntgA+zAg3zAeA0pPX7qHc/OYTcm2DpHI5ysXpgLgEncVOsuiHIJXQcsifZOJrggzQYCrAjUA0+JVBQ/JvHz4UGERtiOqG8gFFHXAK9kWPzKwwxSE9P3PYZVfs3D9dyoQT82PQOBs4Cn0b/UauMZa48bIj5MBDQdiuaweApjSmjtYREI5w3kjmo92yHY5yoj/LCdMx0+lbfrhcyG6RAxWEWW9czA1FeVebzPvR3wUJaSjWK/asDmHQMNp9HgniBw2ey6BGOCXLiM0FX6Js/807t0fgszxlMap9OIbH3066FL20Pa6Iz8U7qO+GkGvGnf53lb3vAtm5NSh2SvoSV2ufstZGCN4VQSy0sXbdhQ==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;6:5HPydSgJZa/261j43FKgVK84PJDoVvuvS5Nb4CPPjQKg9xwSAP6j2JIs6wD48pdhbxdv1yCp+FW+Y7Am1xE/MQC9+VaIkyn4gnFj0Uf7ZwshZiTbEihwmcsfYcDv8xwlI23D8CFAadGkoMDIAruKdFupzMe+8cuVCYkGLXqSrleAyBkJpMabkhK0fvfpPLpXYO5mUT3/3CCrUBsVh1XfToaWzqRkhpaIpBuRvUz6ln5fQQxU7qxpfMEP9a4KKGXNIZ5OfyqkMn2QCs5I1talisf2C2fc5Mck7gAP7U3hJDm8Qr5BRhIU3fwCM8BAXJeQoN1uDs0iReT3DlySMylQyEoO4SFpuURijzwlmR4klgdEgcdoQt6pnnUMipDpv2h5kJo92A9YFK9ew/g214JnGhvgf3qhwgf2k2+hA0nLKue3Zln3mM/7753buvSrkX2jqbg5mDSYyIq7j4l0o/3CRA==;5:9amYrpTVqvwNx0jkHNxJDrQlpsJ+5dNTMTsgdo77LsF5R3ZeTwYUj8dp2EJIx4vtp/X1b/W8bxZeuzUT4/rG6VlmUJSLqMtdON9bYVHbBs2v9gdv+9QBZBJu6FLQm64/ybq8Jc8t2E2LdxnjpXlTCAAq2c6kXDyjfHEFipqxbzg=;7:5jM9YmysMRfCFQakdmdQlszB1QjNKS7eUKpMItIiGKvU671SQbgmuvU/7ucG4vW4oYKWJ1fHJybA7Dy9Jq6s3BApXFX5rD/lSKZZwTdeItdv5koxitWSAoUq9nN8Pqj/1Mb32aFW9Pfo6tvlgTkatb8yOgG+ZdJMu1Ygn+6HBPwDXoEIq9SjMEj/niqqEOjCrP57mklmLvCELqMKYCDa9w3MfFH9Kpi3rOsqbiHWvPBPUF1TVln8mEXOrRuc6xPa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;20:blNlwuVI53Ip2Ewp7qi4Eey3702s3xgOPFKfinB5xlZyn3PSZHBvFNm0UgJ1bkg/fKMmNDZcZ7AAG5juRb/0ELLUr9DMiBxiq8ht1CUd5eRPAQ4YU21yQei5FSgz0RFHpcQ2LtHMZirXuLiuXGWXCnlb3LyYgBvIh6E6cBk2Tkf65DJyiGfkgfmzLiCK7m2/t4TTI9rea6UFdATXX1ZtsD0KAbQKgRlx1o+ypwgmCxbeT5G4xIs2LRV+bsJJX666
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 15:09:06.0521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b245e04b-3c7c-4f1f-952f-08d5f9530e59
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the Cadence SD0801 "Torrent" PHY used with the Cadence MHDP
DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

Signed-off-by: Scott Telford <stelford@cadence.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/cadence/Kconfig          |  10 +
 drivers/phy/cadence/Makefile         |   1 +
 drivers/phy/cadence/phy-cadence-dp.c | 538 +++++++++++++++++++++++++++++++++++
 5 files changed, 551 insertions(+)
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..cc47f85 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -43,6 +43,7 @@ config PHY_XGENE
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
+source "drivers/phy/cadence/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..ba48acd 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_RENESAS)		+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
+					   cadence/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
new file mode 100644
index 0000000..57fff7d
--- /dev/null
+++ b/drivers/phy/cadence/Kconfig
@@ -0,0 +1,10 @@
+#
+# Phy driver for Cadence MHDP DisplayPort controller
+#
+config PHY_CADENCE_DP
+	tristate "Cadence MHDP DisplayPort PHY driver"
+	depends on OF
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Support for Cadence MHDP DisplayPort PHY.
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
new file mode 100644
index 0000000..e5b0a11
--- /dev/null
+++ b/drivers/phy/cadence/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
diff --git a/drivers/phy/cadence/phy-cadence-dp.c b/drivers/phy/cadence/phy-cadence-dp.c
new file mode 100644
index 0000000..10f2e21
--- /dev/null
+++ b/drivers/phy/cadence/phy-cadence-dp.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Cadence MHDP DisplayPort SD0801 PHY driver.
+ *
+ * Copyright 2018 Cadence Design Systems, Inc.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define DEFAULT_NUM_LANES	2
+#define MAX_NUM_LANES		4
+#define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
+
+#define POLL_TIMEOUT_US		2000
+#define LANE_MASK		0x7
+
+/* register offsets from DPTX PHY register block base (i.e MHDP
+ * register base + 0x30a00)
+ */
+#define PHY_AUX_CONFIG			0x00
+#define PHY_AUX_CTRL			0x04
+#define PHY_RESET			0x20
+#define PHY_PMA_XCVR_PLLCLK_EN		0x24
+#define PHY_PMA_XCVR_PLLCLK_EN_ACK	0x28
+#define PHY_PMA_XCVR_POWER_STATE_REQ	0x2c
+#define PHY_POWER_STATE_LN_0	0x0000
+#define PHY_POWER_STATE_LN_1	0x0008
+#define PHY_POWER_STATE_LN_2	0x0010
+#define PHY_POWER_STATE_LN_3	0x0018
+#define PHY_PMA_XCVR_POWER_STATE_ACK	0x30
+#define PHY_PMA_CMN_READY		0x34
+#define PHY_PMA_XCVR_TX_VMARGIN		0x38
+#define PHY_PMA_XCVR_TX_DEEMPH		0x3c
+
+/* register offsets from SD0801 PHY register block base (i.e MHDP
+ * register base + 0x500000)
+ */
+#define CMN_SSM_BANDGAP_TMR		0x00084
+#define CMN_SSM_BIAS_TMR		0x00088
+#define CMN_PLLSM0_PLLPRE_TMR		0x000a8
+#define CMN_PLLSM0_PLLLOCK_TMR		0x000b0
+#define CMN_PLLSM1_PLLPRE_TMR		0x000c8
+#define CMN_PLLSM1_PLLLOCK_TMR		0x000d0
+#define CMN_BGCAL_INIT_TMR		0x00190
+#define CMN_BGCAL_ITER_TMR		0x00194
+#define CMN_IBCAL_INIT_TMR		0x001d0
+#define CMN_PLL0_VCOCAL_INIT_TMR	0x00210
+#define CMN_PLL0_VCOCAL_ITER_TMR	0x00214
+#define CMN_PLL0_VCOCAL_REFTIM_START	0x00218
+#define CMN_PLL0_VCOCAL_PLLCNT_START	0x00220
+#define CMN_PLL0_INTDIV_M0		0x00240
+#define CMN_PLL0_FRACDIVL_M0		0x00244
+#define CMN_PLL0_FRACDIVH_M0		0x00248
+#define CMN_PLL0_HIGH_THR_M0		0x0024c
+#define CMN_PLL0_DSM_DIAG_M0		0x00250
+#define CMN_PLL0_LOCK_PLLCNT_START	0x00278
+#define CMN_PLL1_VCOCAL_INIT_TMR	0x00310
+#define CMN_PLL1_VCOCAL_ITER_TMR	0x00314
+#define CMN_PLL1_DSM_DIAG_M0		0x00350
+#define CMN_TXPUCAL_INIT_TMR		0x00410
+#define CMN_TXPUCAL_ITER_TMR		0x00414
+#define CMN_TXPDCAL_INIT_TMR		0x00430
+#define CMN_TXPDCAL_ITER_TMR		0x00434
+#define CMN_RXCAL_INIT_TMR		0x00450
+#define CMN_RXCAL_ITER_TMR		0x00454
+#define CMN_SD_CAL_INIT_TMR		0x00490
+#define CMN_SD_CAL_ITER_TMR		0x00494
+#define CMN_SD_CAL_REFTIM_START		0x00498
+#define CMN_SD_CAL_PLLCNT_START		0x004a0
+#define CMN_PDIAG_PLL0_CTRL_M0		0x00680
+#define CMN_PDIAG_PLL0_CLK_SEL_M0	0x00684
+#define CMN_PDIAG_PLL0_CP_PADJ_M0	0x00690
+#define CMN_PDIAG_PLL0_CP_IADJ_M0	0x00694
+#define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x00698
+#define CMN_PDIAG_PLL0_CP_PADJ_M1	0x006d0
+#define CMN_PDIAG_PLL0_CP_IADJ_M1	0x006d4
+#define CMN_PDIAG_PLL1_CLK_SEL_M0	0x00704
+#define XCVR_DIAG_PLLDRC_CTRL		0x10394
+#define XCVR_DIAG_HSCLK_SEL		0x10398
+#define XCVR_DIAG_HSCLK_DIV		0x1039c
+#define TX_PSC_A0			0x10400
+#define TX_PSC_A1			0x10404
+#define TX_PSC_A2			0x10408
+#define TX_PSC_A3			0x1040c
+#define RX_PSC_A0			0x20000
+#define RX_PSC_A1			0x20004
+#define RX_PSC_A2			0x20008
+#define RX_PSC_A3			0x2000c
+#define PHY_PLL_CFG			0x30038
+
+struct cdns_dp_phy {
+	void __iomem *base;	/* DPTX registers base */
+	void __iomem *sd_base; /* SD0801 registers base */
+	u32 num_lanes; /* Number of lanes to use */
+	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
+	struct device *dev;
+};
+
+static int cdns_dp_phy_init(struct phy *phy);
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+					 unsigned int lane);
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy);
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+					unsigned int offset,
+					unsigned char start_bit,
+					unsigned char num_bits,
+					unsigned int val);
+
+static const struct phy_ops cdns_dp_phy_ops = {
+	.init		= cdns_dp_phy_init,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_dp_phy_init(struct phy *phy)
+{
+	unsigned char lane_bits;
+
+	struct cdns_dp_phy *cdns_phy = phy_get_drvdata(phy);
+
+	writel(0x0003, cdns_phy->base + PHY_AUX_CTRL); /* enable AUX */
+
+	/* PHY PMA registers configuration function */
+	cdns_dp_phy_pma_cfg(cdns_phy);
+
+	/* Set lines power state to A0
+	 * Set lines pll clk enable to 0
+	 */
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_POWER_STATE_REQ,
+				PHY_POWER_STATE_LN_0, 6, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy,
+					PHY_PMA_XCVR_POWER_STATE_REQ,
+					PHY_POWER_STATE_LN_1, 6, 0x0000);
+
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_2, 6, 0);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_POWER_STATE_REQ,
+						PHY_POWER_STATE_LN_3, 6, 0);
+		}
+	}
+
+	cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+				0, 1, 0x0000);
+
+	if (cdns_phy->num_lanes >= 2) {
+		cdns_dp_phy_write_field(cdns_phy, PHY_PMA_XCVR_PLLCLK_EN,
+					1, 1, 0x0000);
+		if (cdns_phy->num_lanes == 4) {
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						2, 1, 0x0000);
+			cdns_dp_phy_write_field(cdns_phy,
+						PHY_PMA_XCVR_PLLCLK_EN,
+						3, 1, 0x0000);
+		}
+	}
+
+	/* release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
+	 * used lanes
+	 */
+	lane_bits = (1 << cdns_phy->num_lanes) - 1;
+	writel(((0xF & ~lane_bits) << 4) | (0xF & lane_bits),
+		   cdns_phy->base + PHY_RESET);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	writel(0x0001, cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN);
+
+	/* PHY PMA registers configuration functions */
+	cdns_dp_phy_pma_cmn_vco_cfg_25mhz(cdns_phy);
+	cdns_dp_phy_pma_cmn_rate(cdns_phy);
+
+	/* take out of reset */
+	cdns_dp_phy_write_field(cdns_phy, PHY_RESET, 8, 1, 1);
+	cdns_dp_phy_wait_pma_cmn_ready(cdns_phy);
+	cdns_dp_phy_run(cdns_phy);
+
+	return 0;
+}
+
+static void cdns_dp_phy_wait_pma_cmn_ready(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_CMN_READY, reg,
+				 reg & 1, 0, 500);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for PMA common ready\n");
+}
+
+static void cdns_dp_phy_pma_cfg(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int i;
+
+	/* PMA common configuration */
+	cdns_dp_phy_pma_cmn_cfg_25mhz(cdns_phy);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++)
+		cdns_dp_phy_pma_lane_cfg(cdns_phy, i);
+}
+
+static void cdns_dp_phy_pma_cmn_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* refclock registers - assumes 25 MHz refclock */
+	writel(0x0019, cdns_phy->sd_base + CMN_SSM_BIAS_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM0_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM0_PLLLOCK_TMR);
+	writel(0x0032, cdns_phy->sd_base + CMN_PLLSM1_PLLPRE_TMR);
+	writel(0x00D1, cdns_phy->sd_base + CMN_PLLSM1_PLLLOCK_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_INIT_TMR);
+	writel(0x007D, cdns_phy->sd_base + CMN_BGCAL_ITER_TMR);
+	writel(0x0019, cdns_phy->sd_base + CMN_IBCAL_INIT_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPUCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPUCAL_ITER_TMR);
+	writel(0x001E, cdns_phy->sd_base + CMN_TXPDCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_TXPDCAL_ITER_TMR);
+	writel(0x02EE, cdns_phy->sd_base + CMN_RXCAL_INIT_TMR);
+	writel(0x0006, cdns_phy->sd_base + CMN_RXCAL_ITER_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_INIT_TMR);
+	writel(0x0002, cdns_phy->sd_base + CMN_SD_CAL_ITER_TMR);
+	writel(0x000E, cdns_phy->sd_base + CMN_SD_CAL_REFTIM_START);
+	writel(0x012B, cdns_phy->sd_base + CMN_SD_CAL_PLLCNT_START);
+	/* PLL registers */
+	writel(0x0409, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_PADJ_M0);
+	writel(0x1001, cdns_phy->sd_base + CMN_PDIAG_PLL0_CP_IADJ_M0);
+	writel(0x0F08, cdns_phy->sd_base + CMN_PDIAG_PLL0_FILT_PADJ_M0);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_DSM_DIAG_M0);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL0_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL0_VCOCAL_ITER_TMR);
+	writel(0x00FA, cdns_phy->sd_base + CMN_PLL1_VCOCAL_INIT_TMR);
+	writel(0x0004, cdns_phy->sd_base + CMN_PLL1_VCOCAL_ITER_TMR);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_REFTIM_START);
+}
+
+static void cdns_dp_phy_pma_cmn_vco_cfg_25mhz(struct cdns_dp_phy *cdns_phy)
+{
+	/* Assumes 25 MHz refclock */
+	switch (cdns_phy->max_bit_rate) {
+		/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		writel(0x01B0, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0120, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 9.72GHz */
+	case 2430:
+	case 3240:
+		writel(0x0184, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0xCCCD, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x0104, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		writel(0x0159, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x999A, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00E7, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+		/* Setting VCO for 8.1GHz */
+	case 8100:
+		writel(0x0144, cdns_phy->sd_base + CMN_PLL0_INTDIV_M0);
+		writel(0x0000, cdns_phy->sd_base + CMN_PLL0_FRACDIVL_M0);
+		writel(0x0002, cdns_phy->sd_base + CMN_PLL0_FRACDIVH_M0);
+		writel(0x00D8, cdns_phy->sd_base + CMN_PLL0_HIGH_THR_M0);
+		break;
+	}
+
+	writel(0x0002, cdns_phy->sd_base + CMN_PDIAG_PLL0_CTRL_M0);
+	writel(0x0318, cdns_phy->sd_base + CMN_PLL0_VCOCAL_PLLCNT_START);
+}
+
+static void cdns_dp_phy_pma_cmn_rate(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int clk_sel_val = 0;
+	unsigned int hsclk_div_val = 0;
+	unsigned int i;
+
+	/* 16'h0000 for single DP link configuration */
+	writel(0x0000, cdns_phy->sd_base + PHY_PLL_CFG);
+
+	switch (cdns_phy->max_bit_rate) {
+	case 1620:
+		clk_sel_val = 0x0f01;
+		hsclk_div_val = 2;
+		break;
+	case 2160:
+	case 2430:
+	case 2700:
+		clk_sel_val = 0x0701;
+		 hsclk_div_val = 1;
+		break;
+	case 3240:
+		clk_sel_val = 0x0b00;
+		hsclk_div_val = 2;
+		break;
+	case 4320:
+	case 5400:
+		clk_sel_val = 0x0301;
+		hsclk_div_val = 0;
+		break;
+	case 8100:
+		clk_sel_val = 0x0200;
+		hsclk_div_val = 0;
+		break;
+	}
+
+	writel(clk_sel_val, cdns_phy->sd_base + CMN_PDIAG_PLL0_CLK_SEL_M0);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < cdns_phy->num_lanes; i++) {
+		writel(hsclk_div_val,
+		       cdns_phy->sd_base + (XCVR_DIAG_HSCLK_DIV | (i<<11)));
+	}
+}
+
+static void cdns_dp_phy_pma_lane_cfg(struct cdns_dp_phy *cdns_phy,
+				     unsigned int lane)
+{
+	unsigned int lane_bits = (lane & LANE_MASK) << 11;
+
+	/* Writing Tx/Rx Power State Controllers registers */
+	writel(0x00FB, cdns_phy->sd_base + (TX_PSC_A0 | lane_bits));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A2 | lane_bits));
+	writel(0x04AA, cdns_phy->sd_base + (TX_PSC_A3 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A0 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A2 | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (RX_PSC_A3 | lane_bits));
+
+	writel(0x0001, cdns_phy->sd_base + (XCVR_DIAG_PLLDRC_CTRL | lane_bits));
+	writel(0x0000, cdns_phy->sd_base + (XCVR_DIAG_HSCLK_SEL | lane_bits));
+}
+
+static void cdns_dp_phy_run(struct cdns_dp_phy *cdns_phy)
+{
+	unsigned int read_val;
+	u32 write_val1 = 0;
+	u32 write_val2 = 0;
+	u32 mask = 0;
+	int ret;
+
+	/* waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
+	 * master lane
+	 */
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				 read_val, read_val & 1, 0, POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link PLL clock enable ack\n");
+
+	ndelay(100);
+
+	switch (cdns_phy->num_lanes) {
+
+	case 1:	/* lane 0 */
+		write_val1 = 0x00000004;
+		write_val2 = 0x00000001;
+		mask = 0x0000003f;
+		break;
+	case 2: /* lane 0-1 */
+		write_val1 = 0x00000404;
+		write_val2 = 0x00000101;
+		mask = 0x00003f3f;
+		break;
+	case 4: /* lane 0-3 */
+		write_val1 = 0x04040404;
+		write_val2 = 0x01010101;
+		mask = 0x3f3f3f3f;
+		break;
+	}
+
+	writel(write_val1, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val1, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+
+	writel(write_val2, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+
+	ret = readl_poll_timeout(cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_ACK,
+				 read_val, (read_val & mask) == write_val2, 0,
+				 POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link power state ack\n");
+
+	writel(0, cdns_phy->base + PHY_PMA_XCVR_POWER_STATE_REQ);
+	ndelay(100);
+}
+
+static void cdns_dp_phy_write_field(struct cdns_dp_phy *cdns_phy,
+				    unsigned int offset,
+				    unsigned char start_bit,
+				    unsigned char num_bits,
+				    unsigned int val)
+{
+	unsigned int read_val;
+
+	read_val = readl(cdns_phy->base + offset);
+	writel(((val << start_bit) | (read_val & ~(((1 << num_bits) - 1) <<
+		start_bit))), cdns_phy->base + offset);
+}
+
+static int cdns_dp_phy_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_dp_phy *cdns_phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct phy *phy;
+	int err;
+
+	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
+	if (!cdns_phy)
+		return -ENOMEM;
+
+	cdns_phy->dev = &pdev->dev;
+
+	phy = devm_phy_create(dev, NULL, &cdns_dp_phy_ops);
+	if (IS_ERR(phy)) {
+		dev_err(dev, "failed to create DisplayPort PHY\n");
+		return PTR_ERR(phy);
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_phy->base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->base))
+		return PTR_ERR(cdns_phy->base);
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(cdns_phy->sd_base))
+		return PTR_ERR(cdns_phy->sd_base);
+
+	err = device_property_read_u32(dev, "num_lanes",
+				       &(cdns_phy->num_lanes));
+	if (err)
+		cdns_phy->num_lanes = DEFAULT_NUM_LANES;
+
+	switch (cdns_phy->num_lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid number of lanes */
+		break;
+	default:
+		dev_err(dev, "unsupported number of lanes: %d\n",
+			cdns_phy->num_lanes);
+		return -EINVAL;
+	}
+
+	err = device_property_read_u32(dev, "max_bit_rate",
+		   &(cdns_phy->max_bit_rate));
+	if (err)
+		cdns_phy->max_bit_rate = DEFAULT_MAX_BIT_RATE;
+
+	switch (cdns_phy->max_bit_rate) {
+	case 2160:
+	case 2430:
+	case 2700:
+	case 3240:
+	case 4320:
+	case 5400:
+	case 8100:
+		/* valid bit rate */
+		break;
+	default:
+		dev_err(dev, "unsupported max bit rate: %dMbps\n",
+			cdns_phy->max_bit_rate);
+		return -EINVAL;
+	}
+
+	phy_set_drvdata(phy, cdns_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
+		 cdns_phy->num_lanes,
+		 cdns_phy->max_bit_rate / 1000,
+		 cdns_phy->max_bit_rate % 1000);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id cdns_dp_phy_of_match[] = {
+	{
+		.compatible = "cdns,dp-phy"
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, cdns_dp_phy_of_match);
+
+static struct platform_driver cdns_dp_phy_driver = {
+	.probe	= cdns_dp_phy_probe,
+	.driver = {
+		.name	= "cdns-dp-phy",
+		.of_match_table	= cdns_dp_phy_of_match,
+	}
+};
+
+module_platform_driver(cdns_dp_phy_driver);
+
+MODULE_AUTHOR("Cadence Design Systems, Inc.");
+MODULE_DESCRIPTION("Cadence MHDP PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.2.2


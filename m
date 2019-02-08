Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B04C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2B320844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="Zqqz5UQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfBHOYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:24:07 -0500
Received: from mailout.micron.com ([137.201.242.129]:32136 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfBHOYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:24:06 -0500
Received: from mail.micron.com (bowex17b.micron.com [137.201.21.210])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18ENZFj016223;
        Fri, 8 Feb 2019 07:23:35 -0700
Received: from bowex36a.micron.com (137.201.85.222) by bowex17b.micron.com
 (137.201.21.210) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 07:23:34 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36a.micron.com (137.201.85.222) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 07:23:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK/f4+UW+Ikhcnl0D33gyGn8/ILoLHKl0OiHSw09uvQ=;
 b=Zqqz5UQtWPeBo4v6YpsXEFFc74XO7vvdmCH8DEXuR7qa72Pd2EJ9vjsJ9mt77Z8TXWKtDFMxuufbSglqsAiNl2PsHspPCiZw/haVEvahFEhMYdqKjhMNW1ofgkjlFycxTQtGxc0OowpD7HhiuHNxBwBGGfDlx30Fmf82CE0HALM=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB5143.namprd08.prod.outlook.com (20.177.125.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 14:23:33 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 14:23:33 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4g==
Date:   Fri, 8 Feb 2019 14:23:33 +0000
Message-ID: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB5143;6:RP2YyMUDqfhb+9yhokj/mZ2ZKFk0uubEutOU8O1PD/HmiZkYrjS/J7mBbpuNoBFRbgpRI/eBQuSkKKPgNFmDgNE1ORP4Xi41Q3/H2NJc00KD8ximVR8oqrrsdcuYaavmSYsRUhWOvLPBDI99mFWmRgU+dXusyzOwX49IzbSRuc+XmO7DDHASwAGndzjvVwDrfIj9u5Sevyf/5SLqp9vjhAYjjG9v8wkZhC1BECJPZAX0N2yigWojD2+230D23V2Iuz78qShvC1qNniQVYokmFMjnExUkbw2bR1wAfz6Rm6BvoKzv6Y6BWaiR+6CPHld2OFE+/3NbszXgq+74c62PJaFm/Vla5jS6Do4MRuypLp8R54ni+c8Br76h50dwQaLRbs+tK+fUCXdXEGnCQ55KYkIlxWPDQ36W8Eyd34SjX9SLSqGeCllDpoTROlyNBMnYjPJd7xs1djtr7fDaSfzxkA==;5:dc7Ijwvxt7fwCbyTfq4iYZyAblojBLMWIuePSPIBLy+nv99rgmHdjH95JdNij1jv3+l4aN+s1J+o3nOSuhKCsf0olo4ZjRi8RabBRw8p+cST6jcRmDYPlhQ8AYbz/nFPvXD77F9HqIWcGOjE9LnDT5tte/M7O/cO+N6HyRDaTHU3luG95tRp3KBBQP3QQL8L0HPrcDwgNkQEF6qH4Inf0g==;7:xsUcSu5ujIVByo7W0duJWTL+G1IXoEhw5YnskvAbSOnt5KyqHb7bJVDulU5N+4D9df1u4M+Li9Zqfa+f7HhI6zAxALZNJswFa2yBIwZz2y7SJAJHPMks4uwFBQjRkmF0QqiFOUSTKqgiy6HwtzYd8w==
x-ms-office365-filtering-correlation-id: ece274b2-e5d3-4202-79b6-08d68dd1016e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB5143;
x-ms-traffictypediagnostic: BYAPR08MB5143:|BYAPR08MB5143:
x-microsoft-antispam-prvs: <BYAPR08MB514315233C2662670C905E5DDB690@BYAPR08MB5143.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(4326008)(486006)(2201001)(476003)(86362001)(102836004)(54906003)(55236004)(8936002)(14454004)(106356001)(25786009)(3846002)(105586002)(66066001)(6116002)(81166006)(316002)(81156014)(97736004)(74316002)(9686003)(6436002)(7696005)(110136005)(6506007)(99286004)(186003)(26005)(68736007)(55016002)(8676002)(4744005)(53936002)(14444005)(256004)(71190400001)(71200400001)(107886003)(478600001)(305945005)(7736002)(33656002)(2501003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB5143;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tsYKyieYwBxAZD1gwr6ntV812qXlGviv/Jgi/F2vPs6USn5GPHoXsTCXfz8VgGjQE9uhy5HMP4eA+5vwMhefFo5oW6bAgsXhT3IHAhu2QLMA9NRD/j6zD+EyWEJb+mCR7yDdezWjyNPl5D/02IHIozddNX8Y3Qle7cSdV5+remSEO1FwU85g0eVrqloR3kp2UpHwIZinJo5WDYAc8keeUzYMgK7SKwgJNe45POP9QPOlPhAtY4+0DgaBS25r75SUNjO8GWWQQrMfVsSmHcKOVt/SntiKJD+MrS6nHF/tMyTohKJXRAvjanjtojNvjXq5lQ+eswpx+5Zk378Lxx53maTmSWcQfjSlKqPJQEhuP7c9ydrb0m1KGDj2ZflvZxMQJQiWZN5cZd5K82xV1CeHCCAFerbgKlqJslPj4DPtc4s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ece274b2-e5d3-4202-79b6-08d68dd1016e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 14:23:33.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5143
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No-1.129200-0.000000-31
X-TM-AS-MatchedID: 701236-851106-700648-700270-188019-148004-148007-148020-1
        48050-10019-41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change SNOR_HWCPAS_READ_OCTAL to SNOR_HWCAPS_READ_OCTAL.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/linux/mtd/spi-nor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2353af8..b3d360b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -487,7 +487,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_4_4_4		BIT(9)
 #define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
=20
-#define SNOR_HWCPAS_READ_OCTAL		GENMASK(14, 11)
+#define SNOR_HWCAPS_READ_OCTAL		GENMASK(14, 11)
 #define SNOR_HWCAPS_READ_1_1_8		BIT(11)
 #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
 #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
--=20
2.7.4

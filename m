Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759EFC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F52D20878
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gjhzYegK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F52D20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbeIGFeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:34:08 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729527AbeIGFPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4cixG0qkIW7dVBELLfBhIR0vOLt2i3U1qCKZrhErVQ=;
 b=gjhzYegKyZcVshN2YCIaokLUr0UDKOyDr5zxM2hAiSljP/mR7laPabzegq6XvxbooDhRecVESbFAUsKCiC818TryA23qONARAFk4+iZi8FJ25TiKcen6H8ixTmgTA+3+lyExJ3t5gOBWbnJ8cuYCunmr8FmMS2reqrjNf4eOCsU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 82/88] iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs a
 special usage on R-Car Gen3
Thread-Topic: [PATCH AUTOSEL 4.18 82/88] iommu/ipmmu-vmsa: IMUCTRn.TTSEL needs
 a special usage on R-Car Gen3
Thread-Index: AQHURkLdr7X/KJL0EUatMMbq9Fu+QQ==
Date:   Fri, 7 Sep 2018 00:36:49 +0000
Message-ID: <20180907003547.57567-82-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:05fz+mkiJawIjZum3YESNyyYAAHCfZwCpn4PPXAuG54dRxzJ5L82tiLmwDVlcL7xwg3sau4VsvwjxP/IW2eCrkLp9rHhkVLKPAm6G1VQRbxEiE0JZijB4m8J/PkpiyA1zSr+rcW8EH2YJCLGSCPzAdcrvs2IHH80VA1aBdONln3j93CF8KenLvG//z9AWD8nrPiFO12rRfBLRGr00u/XMlD2b7WX30nX+WVtyQztdNHExrKDqnEeVj6G9TfM0WjsWqB6kdo2DHPq1yuNDdeefxNVoqDWpCMNCGOaY7sNet6+jcDu3m48aX/xozUFPVW0BgWmNBBsWfXbYkdbPHB3sUghXuKX3sutAB3LqdH4aB9BnxK8y01zbXG73MwduPuthZvKj/4zums44gN6j3QDbQGdGHkMZysmnfkCF+5iXSI45QYFyvuAns/5nRg3BhQmp+G5HGlwhEZp8IJnqzv8gQ==;5:EPiB4yeRDGXOgO8w4YEaUatP25CNB/vG+lKgzv+EhI34Q4Ay/tT7S+EBoh285Zs6Tm9fOemZhE4HNHw7UVkDKc+kbiLXqk+c90jIWa8QObhAVVdQueBZmTXvT4+fDFp9Xw41TZV7gUfeWKBmvBylQ1d47terS/ROFMt0G+8nEsw=;7:GGF4Vs1mIE3iIsFsFs1tBtw4+gYGvVrE2vcx4kK+dLvSXQ6nekZ7ug0PMnzKKtTAY+OLYL5I+KIO1/YTqAecp9REaNQL7YG/04TURx8Go/ddDFz1FXVlWIQoWy+0HpFWAUfEENXkCQpBMuR+XJL1l3J/KyRr3TA5mXFcZ5W0J2DlVu8wKtEQ5XiePFoHBtHzOdDox3QjHr5x90PMclwOZtpIBedRLEirgfXQ2P5r8XFmpqLXo4AUuzgC69hfEOSC
x-ms-office365-filtering-correlation-id: 95566583-b23b-4b4a-0a4b-08d6145a1d15
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083942B9589E609A711D31B7FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hvKZoqOki9LdTBntAlkxgXJv37PHi/SEdMB5ZLlB5x2alZOUULeRCWD+nkdSAgZBN50c9ZFEgTJyRLcJj8qlGaKzwon5dUv7dO23SuvEjCjwKILg++SHNzANltoeKCpHRsjrQBSh3K+/AGYhtmsA5lLSGIOK1EnOcCOptqJ5fHE0La+lmhXc5HmtHYp+i2cdFy4sX42biKT5syjDsZErNxNlUDZSVYI6wv279tC3WK5wL6Q6mjlCShcMC7mjL+30Erzkx5kH/NtVC2iLxUR6TSaukoFrUIfqWdqxqtI8FX/0bxUHX+Gs3x8rUGR20X4eI5KCI/ZEZVRjIxnOeNFJVRzS9FcxXnVOIn5cqEH1WfM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95566583-b23b-4b4a-0a4b-08d6145a1d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:49.5152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 2ae86955703e9e6a119af4bbe27f6b6dd7a43131 ]

The TTSEL bit of IMUCTRn register of R-Car Gen3 needs to be set
unused MMU context number even if uTLBs are disabled
(The MMUEN bit of IMUCTRn register =3D 0).
Since initial values of IMUCTRn.TTSEL on all IPMMU-domains are 0,
this patch adds a new feature "reserved_context" to reserve IPMMU
context number 0 as the unused MMU context.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/ipmmu-vmsa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 40ae6e87cb88..559ecdf84729 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -47,6 +47,7 @@ struct ipmmu_features {
 	unsigned int number_of_contexts;
 	bool setup_imbuscr;
 	bool twobit_imttbcr_sl0;
+	bool reserved_context;
 };
=20
 struct ipmmu_vmsa_device {
@@ -917,6 +918,7 @@ static const struct ipmmu_features ipmmu_features_defau=
lt =3D {
 	.number_of_contexts =3D 1, /* software only tested with one context */
 	.setup_imbuscr =3D true,
 	.twobit_imttbcr_sl0 =3D false,
+	.reserved_context =3D false,
 };
=20
 static const struct ipmmu_features ipmmu_features_r8a7795 =3D {
@@ -925,6 +927,7 @@ static const struct ipmmu_features ipmmu_features_r8a77=
95 =3D {
 	.number_of_contexts =3D 8,
 	.setup_imbuscr =3D false,
 	.twobit_imttbcr_sl0 =3D true,
+	.reserved_context =3D true,
 };
=20
 static const struct of_device_id ipmmu_of_ids[] =3D {
@@ -1018,6 +1021,11 @@ static int ipmmu_probe(struct platform_device *pdev)
 		}
=20
 		ipmmu_device_reset(mmu);
+
+		if (mmu->features->reserved_context) {
+			dev_info(&pdev->dev, "IPMMU context 0 is reserved\n");
+			set_bit(0, mmu->ctx);
+		}
 	}
=20
 	/*
--=20
2.17.1

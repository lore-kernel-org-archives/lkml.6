Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5336CC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065F02084D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NcYYojOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065F02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeKCJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:24:47 -0400
Received: from mail-eopbgr740122.outbound.protection.outlook.com ([40.107.74.122]:19124
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUDQvu9Fo8yJXBEdRafM+B2eLz1aG3qLlTa/16rLfXc=;
 b=NcYYojOZDVrxfzNlYz7aCV/eZ9+N24bZ3gfzYfjqZaOAd6XVxkaKNG6ahZuWXzveHpoKXbyayh+gBW8r/osBac3KT052V5cOb7mbl1RsQnlLDWo9NM59/jMvAhNL9Ji4XQAA6Logf+dEIpY0jQiefea2A6OfpVgqHiXFQv2vShw=
Received: from MWHPR21MB0766.namprd21.prod.outlook.com (10.173.51.20) by
 MWHPR21MB0704.namprd21.prod.outlook.com (10.175.142.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.2; Sat, 3 Nov 2018 00:15:25 +0000
Received: from MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6]) by MWHPR21MB0766.namprd21.prod.outlook.com
 ([fe80::1982:5e59:2489:88e6%14]) with mapi id 15.20.1339.000; Sat, 3 Nov 2018
 00:15:25 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v3 4/4] Drivers: hv: Enable CONFIG_HYPERV on ARM64
Thread-Topic: [PATCH v3 4/4] Drivers: hv: Enable CONFIG_HYPERV on ARM64
Thread-Index: AQHUcwpRb97X/W4qy0mRO+wL1BLrSw==
Date:   Sat, 3 Nov 2018 00:15:25 +0000
Message-ID: <1541204037-18043-5-git-send-email-mikelley@microsoft.com>
References: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1541204037-18043-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0011.namprd22.prod.outlook.com
 (2603:10b6:301:28::24) To MWHPR21MB0766.namprd21.prod.outlook.com
 (2603:10b6:300:76::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.107.174.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0704;6:hvg/Gy6JRG+BcI72MQESHPOv+l5JRdJvLBkOzbgvqZ63r7churoZ6gnWyAYIxJOJ4QlV80h+MCcc6MDzy/8SpApFifWItuj8ktSfDN3zMeno3RjqkgAdAg6iRbmn8gz2LGnTI+rMZuct3Qg7cNVlFpRI3XO38TjcYuZmi+MxM9u8qYw26LgXyFjipu9l4bAl6dquifUQ5hRk+uz2kcOjIjDuiD7k/g8ZnFd3eyF54CUbtPNIIYC574BQqMPlbDWNedw4VmPC1uGaRqufKgpc0pQM4AZqCBNNbFFhwgH6ar/pwVTB1ynktJDVEUhXbxMeaSDxoBxIyLXUMc6GqJZHYuoeZlXjQR4S8WYslo2wkRQ0MSuijt9sJQf7Lic+cHAP0J0bvBgRxuyV6w7YseqwWZ1LzYKx9dt8tAcGvbxNB/2pOR8ioJepnlB4KgtC87sR3J0ZAaloCpALti673p8FDQ==;5:cx36KZIXPkPndO706U2t2ALBRcpKHsnQ4EJCZ4qQ4xVc3XzS5dB7pBoq2yD6/MORRNpAUWahdXdQ8PEScrZn9tQAdLxlSPS7qvT7Cl07GP6tPo6t6QTchLAy/ILdRL0Grtd78UNpzQWMvbkdCH11P4wJKot37JkjQq4DHjuGm2U=;7:q1Rk7VPZJ9uc1srD8KI0bf3nMpXQ0vpuan36APTYSJjOYeqeYVARcFlhUDDkhY0m/gVBENVmCraRfdOzmvIYlWT8COhrbs/VcPLp6rKuYkmxWqzx1nnmjAwYRv/w35i6MZMehCju/mIsNDnU5+5WRA==
x-ms-office365-filtering-correlation-id: 0fe5df7e-fdc6-4630-30a6-08d6412173a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR21MB0704;
x-ms-traffictypediagnostic: MWHPR21MB0704:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <MWHPR21MB0704AE9B1E7174A0CC48669BD7C80@MWHPR21MB0704.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231382)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MWHPR21MB0704;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0704;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(136003)(396003)(366004)(189003)(199004)(14454004)(81156014)(81166006)(8676002)(8936002)(7416002)(305945005)(86612001)(7736002)(5660300001)(6116002)(105586002)(86362001)(2906002)(2201001)(3846002)(106356001)(97736004)(71190400001)(71200400001)(10290500003)(2900100001)(256004)(14444005)(508600001)(4326008)(68736007)(25786009)(102836004)(66066001)(6486002)(6506007)(386003)(26005)(1511001)(99286004)(186003)(36756003)(22452003)(52116002)(76176011)(446003)(476003)(2616005)(110136005)(53936002)(6636002)(316002)(11346002)(10090500001)(6436002)(486006)(6512007)(2501003)(107886003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0704;H:MWHPR21MB0766.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fZisNp+3DrUbQlh1nDk1QbzPnhWjP5t0BsZZBQlD31gVwsuWHI0hmIXZRprrViu3EoVvWffRBj+YW2ruy1uZc/AwVgVZMl5Q5xFzKwy3B66S5YL9F//7KZCBx1IUbO+yGY4LdE8gYIpLzmMjEn2WZeoidqBMk7PnUdkEB5a/WpQjVgQ/p2mpVPtE4/BhGzroJF3oKvSLGtNrANvpz1MYlc/Q+jEOOG8PnCFFLuP9nxeEd6SxCVWqfE4FIQXkdvrNXE+CM2oVfva1DQVjKDvXxY/40Eyu9s5bgp/a1A0Viu9lQ/fZ8Rk6QCpeWMuLr3De8mWuCgb1OCCCqGDB4r2BYZxTKcoxBekLwMozoefYCkg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5df7e-fdc6-4630-30a6-08d6412173a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:15:25.0973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update drivers/hv/Kconfig so CONFIG_HYPERV can be selected on ARM64,
causing the Hyper-V specific code to be built.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 97954f5..c3e11a2 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -4,7 +4,8 @@ menu "Microsoft Hyper-V guest support"
=20
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && ACPI && PCI && X86_LOCAL_APIC && HYPERVISOR_GUEST
+	depends on ACPI && PCI && \
+			((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) || ARM64)
 	select PARAVIRT
 	help
 	  Select this option to run Linux as a Hyper-V client operating
--=20
1.8.3.1


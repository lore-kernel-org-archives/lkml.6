Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A5ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CB21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hfkTUhK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0CB21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIOGrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:13 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com ([40.107.73.103]:49315
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728273AbeIOGrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJAoVUVwLsAgvcV/GUipfmf/nxuMq6j3X+LuqSr0NGo=;
 b=hfkTUhK+0wHAKlfo8i7wIDw5CA4FkgXJpKKuCwesdopWLI0As9kpKt2gOjUcPh8FI7nL6jsdiMx8CjjSAAhQomGYAEmdfqujFdfN7DlRjNDvfs7cSaWFLIhbOoxAaWDwE0tGt135wneknv2KXk9e9BdsetBUU6ojr1II7cn6G/A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:30:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 22/92] arm64: dts: mt7622: update a clock
 property for UART0
Thread-Topic: [PATCH AUTOSEL 4.18 22/92] arm64: dts: mt7622: update a clock
 property for UART0
Thread-Index: AQHUTJOg6+iunSg9qUyd21JgNZsB+A==
Date:   Sat, 15 Sep 2018 01:30:04 +0000
Message-ID: <20180915012944.179481-22-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:VmPiy1yNTdn4C55CMHgWiD5PvPJD5KTgYp97TNLJKDzKvOY7fnfrS8LXhO1n1mTL9CBX8LPu7H9XgSTOJVbihVtP1YSbVaW56tgRG1N7KrfBgbjV11vCuzF3KAQA5GywcQdoL1F9+y9A+sxW+cISPLOVl5paZqFaEYSe5OjolD0kD9ap/2D4hiTQ79DqF+T6PmqdAju9ICeIFMXfFGAqAxG4s90xOW4aaLuwzmfb+FA0l8pCpm/vUldvxnSHlC/mqUrcgJiq3rRVvjUPXDeyuU9FjW2HLJa+vJtGxA6lXsR8Nx61gQAEr2Obm1/+qTHIYVvqJnENzSHgRNeGctnwXZTKhFwEIem/1i9a0pG4dueQiZ5Txe8Nn1yhQPcuqGHb0oTiktJDSi42fPzueQgoHo2CM6qKOPNF0ZqTmFeoSI0bLVwK05DoFc5whaxvRHGgaI2MQHl1mfc/eUQ6//PUzg==;5:z2uCnnqZTIOfanG9QICaOvHflMu5CNAQHwFiZJhTKdrZCCbZBYJatrRP30DM01wrYbJ8oKlcHFSovkcD6Vv9EyMcnVVQcSbw1aghM3q8HWAGM3YGE3jwV4Pe/4l74Ry/1PurEj4G2ePQcn8rY+AsgXXfees44s1Ku4bn4QWpLj4=;7:qtAaaN/7QCVHlxk2IppxxnDwKVk3JkV5XW6v6Y2JPaikZWUWHDhi/3vqxQWBqcjKqBYL+wS6sx5doEXXUKAAcKN7Yd7Hjd/97hTD2gp171iY86Z8OAyWNal/VZZmdMzG2YcSLRTbx2cMId9lQUrfbY7wN7Ohin22cONDbtgjMpNxBFNI7HRdp6xy4avLoF07Oeo3HCegXrkrS0LDV8fWWzUNwUqy7D44ZJacEFl16w5SDml6b+hwu7p2Az8QSu6Y
x-ms-office365-filtering-correlation-id: 23ef45cd-a121-461b-864a-08d61aaac371
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB08247D2C606A8BB8143B86F8FB180@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(6506007)(1076002)(66066001)(22452003)(99286004)(102836004)(76176011)(2501003)(5250100002)(97736004)(54906003)(6116002)(186003)(39060400002)(3846002)(107886003)(25786009)(11346002)(6346003)(446003)(486006)(476003)(26005)(2616005)(5660300001)(10090500001)(86612001)(86362001)(36756003)(4326008)(575784001)(217873002)(316002)(68736007)(110136005)(8936002)(81156014)(8676002)(2906002)(6436002)(14444005)(256004)(72206003)(7736002)(53936002)(2900100001)(478600001)(6512007)(81166006)(10290500003)(105586002)(305945005)(106356001)(6486002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: V9qmtb40cFwhfJNRnZde2pQBgSJtFDn6tBBxzGHP3le1EYFNMEhltkK+MjOI4BhrHkeEsDNN25q1WsLrn0+YgtZlNyo/kg1pAzwn5PG+iQ+tKqirE0HsrK6y/ZQeBIGCyuUyRefyAD+bj1kAXyQvSx3QoUg3/f/b9k3aN6M72MFCjk4/xuAZ8ST2I+AR0ANBZeJkMFNQmP2EYfMCACamUQ+opxFEipryUfKXEKeCQnjzIh0Z7GLVxlwXAlBYeAnRXNmpyH6etgD3dRlR9Z9HpWmxdlxRxcWbkjjXli3iL8QhLyyIGXXFG83yjv/6Odm9tH6adwQCUkItjtsRn/DjSp3JvpPWmn0RLVamn0OuroA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ef45cd-a121-461b-864a-08d61aaac371
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:04.4013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

[ Upstream commit 2b519747ae4859e886c37834d766fe0c7d8d82e2 ]

The input clock of UART0 should be CLK_PERI_UART0_PD.

Fixes: 13f36c326cef ("arm64: dts: mt7622: turn uart0 clock to real ones")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts=
/mediatek/mt7622.dtsi
index 9213c966c224..ec7ea8dca777 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -331,7 +331,7 @@
 		reg =3D <0 0x11002000 0 0x400>;
 		interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 		clocks =3D <&topckgen CLK_TOP_UART_SEL>,
-			 <&pericfg CLK_PERI_UART1_PD>;
+			 <&pericfg CLK_PERI_UART0_PD>;
 		clock-names =3D "baud", "bus";
 		status =3D "disabled";
 	};
--=20
2.17.1

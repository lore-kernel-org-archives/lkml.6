Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21283ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD74921476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IYLD/R+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD74921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeIOGzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:55:12 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729829AbeIOGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPKlESEbbukYz3qXnqYFQ3IXnBVDSQaVKEOnIHLX1T8=;
 b=IYLD/R+wSEaQDjQ6RU9NWzpOdgqHt3ZqG7993VpRxCW0eRlbpbrzbfIwjA1CdUPNaELufho5pK33fB3iIkttOwPHTu2vxKLgupDABzndEyJa+Cl5j8gqwjTJT3xzg3q7Qp0GZXBsjKrTgr4wMl9Pko+FzslRQYNum+EjqDbmfmI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Burton <paul.burton@mips.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 05/20] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Topic: [PATCH AUTOSEL 4.4 05/20] MIPS: loongson64: cs5536: Fix
 PCI_OHCI_INT_REG reads
Thread-Index: AQHUTJRWopjyAQHaSE2l6tVoJFSJBQ==
Date:   Sat, 15 Sep 2018 01:35:08 +0000
Message-ID: <20180915013502.180110-5-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:v0yvgUrQ9F8wsreVM3rDxw3oc5q+hb0JkGkDcAprniRuNizjeruoVLBHWGzKxz2mmWGT9OlexGYEmj1SZEUCXH2+reN95Q2bNq4L/63vLHiN+jBSy4S93IFfWTfQFsT4fGttd2QKkGiiTDokqzynRP3a+WTUCA35WVN8FTN8wbsoJSKKUJriI2F6JHatTw061nI3VR1aFKMkdU5B3oyR3OzA3ezU2Bdi7r307HRUqsezuqLHz4nSNTad0HOzRhvQRPe23z98P6hwG4HmmbPv6CAWubqcBDGhLTtASBb9AlUCfwhwyRuUM0SyQpEqGP+nPs2l6xn6qmwx3KcZ+HggTrFAogbPHL7BWJVjZ9ZyuhsT32urb6uu2vNpel9j20VuSt+f9UlI18d6+QQbZhaf4c/o3ziDj1iOVjD19ncupDzz9ap9SFtaRw6BsBveEgWBv/J3Dq4GpDeLmdhzFwIdWw==;5:WfjafDTCzttU6/87c1QkVaUKdMHZnyiwNzSliBPRXUZgGqvk1XttodjqyKymSnGxhDj28QhC2s9orZlpPKYf/rqoto2SdiwuRagp1DHapDvWmOsoC4fKA01x8RLGqcVMjmGD2bNpnzicgY18loFU1IbGD9T4+Mu0FSszuPkud4A=;7:e4plMGT61gOO9Spgy1ISmWcJ5hjiPwpnL0Xfw2Y2zdYRZMGSWGpdheI6CdDf5yMcgCl68c/ko8it/G++HtAKySXib9Ap7chLQoBkgXlNxHn5kmGH4HgrGYIMA5/HDrNbFJxDUE/CbsUxu74fH3Jc5urM1HlyJGRF4+gxNIcxzPXrX89YqSZW3v+DtlbLLGCTLVeEuvcDWRDFlhrO791SddTCjyWyXinOFZzNQ+ZYbQXmKmPaYPI0WccBk+fDU5ko
x-ms-office365-filtering-correlation-id: 676aa59f-bda7-4563-62d6-08d61aab7ea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181E2538C4F7C970371F719FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(966005)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: CtiERJYqU/XFqPu13DEeVAj0VUAfijSHhEyv2UwrU3IvIlcdVdd7SiklKxWflLPI2ws/pXLUtEyoyHptKOx0SaZ9nstQ973widhbn4tSxCNmULsTSnO0G8BFx0gxTKF5HcQlMoVD8lA8TcCMxlJ/WVAzwO33qlqiGdr/grm+D3RzwPPUSkSOCvGu7z15oRi4pHm8uqtV7hbtFnbhm34/+7ML4voccdHExk3O6jvKMlFdYIoz/ar3Dq09p7h3OP12gk8mLG5I34dveHIyPtpUzb/CS2ujktNO6Ep5FN/ifYNbt6lhZeyH3Hj+fN/tRwuCgEWa3FrSAi5eoEHzqYQEU9JWVhujqdviRCarvA4h5U8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676aa59f-bda7-4563-62d6-08d61aab7ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:08.5510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paul.burton@mips.com>

[ Upstream commit cd87668d601f622e0ebcfea4f78d116d5f572f4d ]

The PCI_OHCI_INT_REG case in pci_ohci_read_reg() contains the following
if statement:

  if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)

CS5536_USB_INTR expands to the constant 11, which gives us the following
condition which can never evaluate true:

  if ((lo & 0xf00) =3D=3D 11)

At least when using GCC 8.1.0 this falls foul of the tautoligcal-compare
warning, and since the code is built with the -Werror flag the build
fails.

Fix this by shifting lo right by 8 bits in order to match the
corresponding PCI_OHCI_INT_REG case in pci_ohci_write_reg().

Signed-off-by: Paul Burton <paul.burton@mips.com>
Patchwork: https://patchwork.linux-mips.org/patch/19861/
Cc: Huacai Chen <chenhc@lemote.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c b/arch/mips/l=
oongson64/common/cs5536/cs5536_ohci.c
index f7c905e50dc4..92dc6bafc127 100644
--- a/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
+++ b/arch/mips/loongson64/common/cs5536/cs5536_ohci.c
@@ -138,7 +138,7 @@ u32 pci_ohci_read_reg(int reg)
 		break;
 	case PCI_OHCI_INT_REG:
 		_rdmsr(DIVIL_MSR_REG(PIC_YSEL_LOW), &hi, &lo);
-		if ((lo & 0x00000f00) =3D=3D CS5536_USB_INTR)
+		if (((lo >> PIC_YSEL_LOW_USB_SHIFT) & 0xf) =3D=3D CS5536_USB_INTR)
 			conf_data =3D 1;
 		break;
 	default:
--=20
2.17.1

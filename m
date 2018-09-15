Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690FECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39A21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="OR6PRRD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A39A21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeIOGrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:02 -0400
Received: from mail-bn3nam01on0134.outbound.protection.outlook.com ([104.47.33.134]:14354
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbeIOGrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhIZssLqs485n85a4876WMS0ls7ioOugApQ/sga61CQ=;
 b=OR6PRRD/IDLYeSflZ9356PZmA36+NOc0zcFhaljERuxG4wu/A/bHeRzXuWEQrZGGTQuC9MvA8y1XonNTEfZTdhePeiL2+gC2pdcqZp1g7B4b4kR3tJFyFNvyf5QfIlg0SWYWpnHcac6vOJOHdM1SU29lIekbglv6b7/4pQILcNo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 11/92] mtd: rawnand: sunxi: Add an U suffix to
 NFC_PAGE_OP definition
Thread-Topic: [PATCH AUTOSEL 4.18 11/92] mtd: rawnand: sunxi: Add an U suffix
 to NFC_PAGE_OP definition
Thread-Index: AQHUTJOcSKmhGqy4JEK/+O+mvhtUfg==
Date:   Sat, 15 Sep 2018 01:29:56 +0000
Message-ID: <20180915012944.179481-11-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:x+o4/Eht2R3iiEpLJ4vL7Kdpayig4+tJmnwc6ZpABC572Ev3v164tPJQWlHD4I1BWkiW+wjYOAAMwToKv0a6uHDco7pLbI3X5rnjEuYdrZw5JN0uKtQ/uyfCWNxVN0Lvwkjt5ZcnTgMj43k58G6B138D2Hb0NtaBEGUn+X7OL8uh1Z23TigErSkcGccilxkA0au1XD6QXKS698b/5iGO3eohLk4L5z2Rvih2AwIv80fTewqnc1Mf1MEjNncGHApFG0yeCDFnum2mjCBI38giqMJwgZR6n8dlSw7miwbG5WHVkWB788htctU5RZtc5US7xmGylXL5J1DE66JKcghpwabKRsGmiqPun+puX21HpzeZv3IUeDnUvjdV/u0Mxe15OQ3XvbW/UQf3+O04wwDA07sdDi3aILHAcMI0Uuv9swxaAtALU/iKVnSS+Iyx/rkwOYOpOxGV8rpg0wz0KZH8SQ==;5:WEWjaicZLkfS8I4eYZbTZwBnN6QcNu+2jhTucoylYlOJ4p41dQkJGTJwcxGkCvjWsac84BKrYIxaWlyZID4IWs4vCI/tHvPn2JeBWJ/HSqjXhoPH2guPkwckP0r+CPZsIzkfzagtO7G7CDiTra0ccmzuglGVrJj9PGAuDZvYkPo=;7:8Cqs0Jlt9j7+XizFmhYZry4uwscZokDigkX0I6C7z/CuqwLwBPRuqSqwOu+6Kep/s3BFOWLdy+63wWYwntL2Rl19CKXofGmfQB+ZSFixu5BuMmE5YTy9cnBCBJDB8cGdI1Xp2gmFpbYqUYKliEXkjMMDnYJS5kZrjcf97sCtMfQxZoR6HcdqulwIysEztAsLVA0dBpv6SKjqytxFHWpR8VNslL5F6ZD3q35eg0yGrYngGR8jdOuWBsg+VGwaP1CZ
x-ms-office365-filtering-correlation-id: 9e0bc8f2-4f74-434a-0dff-08d61aaabec7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB084023E09D7854BEF3AF3D88FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(14444005)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(575784001)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yMkGDgxtLnmd0D5w9VFl1UPw61xYqgEnybtMU+SD69AZCiMgM8Az5Up2rDajxXcyc8/HAKTDn6tpTBHpvMJn0RzgHQ+OpzJJi0gMoTIAAl+1UKoF2kjJin/LYpvWXPXZM6xSfZu3oDmD7GPNuqzTuD7YTll/wDqxLs4/bimjgUtCMFgQWf+hocu1uzpqHHBWgEXbzls0K+vm6cFbBiLz9qVmeK+W2Cdzpq+Sph+WvTAdys4J4Znd/oRfhyv7fEfoMxkIbEjBwmziXoObTwtJPXckB74etra8AiHfDCklXh8Yj7+f024EG/KwMTs6zrr03kre4ScPf6A0gvWeJlesfmLMIo24oqdvskegYQHzxOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0bc8f2-4f74-434a-0dff-08d61aaabec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:56.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit cf3e3fd2e94f4648f17fbd5e0e26409d5d1face9 ]

Fixes the "warning: large integer implicitly truncated to unsigned type
[-Woverflow]" warning when compiled for x86.

This is needed in order to allow compiling this driver when
COMPILE_TEST=3Dy.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi=
_nand.c
index d831a141a196..99043c3a4fa7 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -127,7 +127,7 @@
 #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
 #define NFC_NORMAL_OP		(0 << 30)
 #define NFC_ECC_OP		(1 << 30)
-#define NFC_PAGE_OP		(2 << 30)
+#define NFC_PAGE_OP		(2U << 30)
=20
 /* define bit use in NFC_RCMD_SET */
 #define NFC_READ_CMD_MSK	GENMASK(7, 0)
--=20
2.17.1

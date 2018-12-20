Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF8C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88789206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggHyH60Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbeLTV1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:27:22 -0500
Received: from mail-eopbgr50051.outbound.protection.outlook.com ([40.107.5.51]:12096
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730527AbeLTV1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ber3Nd94rw/6FniHn+7f3rVCQOyefV7cU9k4gmeehzQ=;
 b=ggHyH60ZQT/iZQYyYgGQo3fPfLAirijKyCz6glQ0JjCiHUGdRJ4fGp4u/PxIMU437dt0A8T2SScgjlztqarYEUgiaB8QnlYRIyNbfNQZlVzZWNk4CdN07lfc+tM6UpgCjP6amVmXr4utGwu6KKUrS30CT0hwCoudK6mnnXd36Qk=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3711.eurprd04.prod.outlook.com (52.134.15.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 21:27:16 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b%3]) with mapi id 15.20.1425.024; Thu, 20 Dec 2018
 21:27:16 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM dependency
Thread-Topic: [PATCH] crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM dependency
Thread-Index: AQHUmHipoSWTOtLyrU2M7jIivETqVw==
Date:   Thu, 20 Dec 2018 21:27:16 +0000
Message-ID: <VI1PR0402MB3485B39F40CFFDED08D8701698BF0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20181220152815.3613164-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3711;6:F4vPHJcthArhpjr0kNXueZk+xv0+YDu1Iyryq+W97UaLfcAxCsFyU+T8EgNrpo96j12Ua9BiW5Qg+rrYmWUELo2i7bBZJFTEb2LIBhqsFKscSbuAVb4eNyiA6etxUN5QEVH7mtgdUwrUfVypC9zXr68A5q6cr+xEyCi8XVdn4TxdhSSuBkARNXmfb4E7/HZqEL/4StxOGlPqdrXaGAgaffy7tBW5teYXd1Lhf6szl/YvtvCF+Jp8ebMkxt+VS9cdWe2R+figiun6uLIjaJ7Wq9irrGhWa0ebBMUltX+24c4pgDdbS9bSrtrN08V5pb7/lO95fWj4IQKaPVqYGU4q8JYHQSLJNzQhsYU+bJwKXbL92MN00kT9hWe06MK1/Ae51cIpY0rKYysz36IKibrFjbhLGaPRq9ASUpa/GRvuA9unKH7ydY0+dbjUgqun7VOMLnJygX8p4nCXGcWj06pMAg==;5:qZ9oN2I+HcqpYIFJ90HkhXUHl0kJroy/q3Zg3sueaRjADVUSDBidDb3iGDKdOervc6sLlo6R2YTX3vavXaiuXAYRnj/0u8E2IAWLohbz/4+DGHudpLyE/7OK4ir8Rg5gzYBCdAbcPJssD0pfXsdBSN+4WP/jqAVhJMYzGQQdj+o=;7:SRH7bMxkFfoPsw7GNkmVEwcCPGefif0168aWKpqlww65f+MZAMjJcONWgdPZfs1uLUTvYNwL8YUHWzW2akw//1HJ3SnmrwNNfSRt02/jrsR39YhBnXlHeWH0PmLZa6oCJNnmELf3Hd6ZGf/ILV54dw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 958b0e31-d246-4e63-30f7-08d666c1ea68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3711;
x-ms-traffictypediagnostic: VI1PR0402MB3711:
x-microsoft-antispam-prvs: <VI1PR0402MB37116AE3C5AEDB960CDB664698BF0@VI1PR0402MB3711.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3711;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3711;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(86362001)(68736007)(4326008)(256004)(14454004)(5660300001)(54906003)(110136005)(316002)(105586002)(33656002)(99286004)(66066001)(106356001)(71190400001)(55016002)(478600001)(44832011)(71200400001)(6436002)(81156014)(8676002)(81166006)(446003)(3846002)(6116002)(476003)(8936002)(74316002)(305945005)(6246003)(53936002)(25786009)(7736002)(9686003)(2906002)(6506007)(26005)(76176011)(102836004)(229853002)(186003)(53546011)(486006)(7696005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3711;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I5GhAOxzI1V8T16t5nFsN3smPrdaXn9/N+hoLjOauz53RqvEm+WBnChlzfrVRY04XpLsw0t3dgp0BybEinkjOzm3BJuIFIZqYdjOkiIOEUR/8RzoDZhqisZlZU0ivtklfJqYsBlp7o46rqf4drw3aVHhgsZGftM6W0sogYxG+VFzqgpLlywyy5L90YCxB0e9ZNE7hemj/yxPEv/NtEFKFisljkKwW+m/IzR8V+K7y6qUTtlJtkTuVd1WIx4w4PF10igeGWukbhS0rCocWr2IAHhQHTpO9bC/67U94pJwmI2K7hFPCTc+YhVc1uYUOiEk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b0e31-d246-4e63-30f7-08d666c1ea68
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 21:27:16.5821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/2018 5:28 PM, Arnd Bergmann wrote:=0A=
> My previous bugfix was incomplete, we still have a broken kernel=0A=
> with CRYPTO_DEV_FSL_CAAM=3Dm and CRYPTO_DEV_FSL_DPAA2_CAAM=3Dy:=0A=
> =0A=
> drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_en=
cap':=0A=
> caamalg_desc.c:(.text+0x14): undefined reference to `caam_little_end'=0A=
> drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_en=
cap':=0A=
> caamalg_desc.c:(.text+0x310): undefined reference to `caam_imx'=0A=
> caamalg_desc.c:(.text+0x4a8): undefined reference to `caam_little_end'=0A=
> drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_en=
cap':=0A=
> caamalg_desc.c:(.text+0x664): undefined reference to `caam_imx'=0A=
> =0A=
> Everything is fine for the other combinations: if both are loadable=0A=
> modules, or both are built-in, the flags work as expected, also if=0A=
> only one of the two is enabled.=0A=
> =0A=
> Add a dependency to enforce using one of the working configurations.=0A=
> Overall, I'm still not happy with that dependency, but for now=0A=
> it documents what the code requires.=0A=
> =0A=
Thanks Arnd.=0A=
This indeed solves the issue, but as you mentioned won't allow for=0A=
CRYPTO_DEV_FSL_DPAA2_CAAM=3Dy when CRYPTO_DEV_FSL_CAAM=3Dm.=0A=
=0A=
I think a better solution is the following:=0A=
=0A=
-- >8 --=0A=
Subject: [PATCH] crypto: caam - move shared symbols in a common location=0A=
=0A=
There are several issues with symbols shared b/w:=0A=
-caam/jr and caam/qi drivers on one hand=0A=
-caam/qi2 driver on the other hand=0A=
=0A=
Commit 52813ab24959 ("crypto: caam/qi2 - avoid double export") fixed=0A=
some of them, however compilation still fails for CRYPTO_DEV_FSL_CAAM=3Dm=
=0A=
and CRYPTO_DEV_FSL_DPAA2_CAAM=3Dy.=0A=
=0A=
Another issue is related to dependency cycles reported by depmod when=0A=
CRYPTO_DEV_FSL_CAAM=3Dn and CRYPTO_DEV_FSL_DPAA2_CAAM=3Dm, as mentioned in=
=0A=
82c7b351be3f ("Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"=
")=0A=
=0A=
To fix all these, move the symbols shared by these drivers in a common=0A=
location. The only existing possibility is error.c file (note that naming=
=0A=
doesn't help and should eventually change).=0A=
=0A=
Fixes: 52813ab24959 ("crypto: caam/qi2 - avoid double export")=0A=
Reported-by: Arnd Bergmann <arnd@arndb.de>=0A=
Signed-off-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
---=0A=
 drivers/crypto/caam/caamalg_qi2.c | 7 -------=0A=
 drivers/crypto/caam/ctrl.c        | 4 ----=0A=
 drivers/crypto/caam/error.c       | 6 ++++++=0A=
 3 files changed, 6 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamal=
g_qi2.c=0A=
index 425d5d974613..cc59814afd29 100644=0A=
--- a/drivers/crypto/caam/caamalg_qi2.c=0A=
+++ b/drivers/crypto/caam/caamalg_qi2.c=0A=
@@ -25,13 +25,6 @@=0A=
 #define CAAM_MAX_KEY_SIZE	(AES_MAX_KEY_SIZE + CTR_RFC3686_NONCE_SIZE + \=
=0A=
 				 SHA512_DIGEST_SIZE * 2)=0A=
=0A=
-#if !IS_ENABLED(CONFIG_CRYPTO_DEV_FSL_CAAM)=0A=
-bool caam_little_end;=0A=
-EXPORT_SYMBOL(caam_little_end);=0A=
-bool caam_imx;=0A=
-EXPORT_SYMBOL(caam_imx);=0A=
-#endif=0A=
-=0A=
 /*=0A=
  * This is a a cache of buffers, from which the users of CAAM QI driver=0A=
  * can allocate short buffers. It's speedier than doing kmalloc on the hot=
path.=0A=
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c=0A=
index 16bbc72f041a..14fb09223156 100644=0A=
--- a/drivers/crypto/caam/ctrl.c=0A=
+++ b/drivers/crypto/caam/ctrl.c=0A=
@@ -18,12 +18,8 @@=0A=
 #include "desc_constr.h"=0A=
 #include "ctrl.h"=0A=
=0A=
-bool caam_little_end;=0A=
-EXPORT_SYMBOL(caam_little_end);=0A=
 bool caam_dpaa2;=0A=
 EXPORT_SYMBOL(caam_dpaa2);=0A=
-bool caam_imx;=0A=
-EXPORT_SYMBOL(caam_imx);=0A=
=0A=
 #ifdef CONFIG_CAAM_QI=0A=
 #include "qi.h"=0A=
diff --git a/drivers/crypto/caam/error.c b/drivers/crypto/caam/error.c=0A=
index 7e8d690f2827..21a70fd32f5d 100644=0A=
--- a/drivers/crypto/caam/error.c=0A=
+++ b/drivers/crypto/caam/error.c=0A=
@@ -50,6 +50,12 @@ void caam_dump_sg(const char *level, const char *prefix_=
str,=0A=
int prefix_type,=0A=
 #endif /* DEBUG */=0A=
 EXPORT_SYMBOL(caam_dump_sg);=0A=
=0A=
+bool caam_little_end;=0A=
+EXPORT_SYMBOL(caam_little_end);=0A=
+=0A=
+bool caam_imx;=0A=
+EXPORT_SYMBOL(caam_imx);=0A=
+=0A=
 static const struct {=0A=
 	u8 value;=0A=
 	const char *error_text;=0A=
-- =0A=
2.16.2=0A=

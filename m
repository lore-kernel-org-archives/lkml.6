Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F31C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DB020879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="ejmanl81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbeL1KJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 05:09:46 -0500
Received: from mail-oln040092254071.outbound.protection.outlook.com ([40.92.254.71]:6040
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727902AbeL1KJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 05:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQumtwz8GTsV6uqERyjCXhr1/PTGDaFdSTfMijoVl6Q=;
 b=ejmanl8120VpqOyA6ngFlyKZJ7NE/XYEqg0LlV/+9DGlRO1K3UI61YZYSwr2NaP60vN+pFjE5h7FUiJ+7Ur9P+fX9xbmxDw+N7dsPliDPuoGK9GxqfenFtn+i3hmCyx7PfIjh8m5TZqkyCjGg9IbpL3799Tu/Jmf8+JD5xTMndtNnms9rihbzKu/vrND5+5aau9s0Pjmtvp1E//Zx5Jd+WrJ2dHHirm65DQ9OEQYSt7DhN7iNGLGj+0lfQDI1l5Xg+UbCF2LYACG/c+9BEfaciIhHGODQ9iyg0w+VoYdyfjCsxxMLOU/e4CjwuzhGs9bjgBCmcDrnahQR2pcWsdYYA==
Received: from SG2APC01FT114.eop-APC01.prod.protection.outlook.com
 (10.152.250.51) by SG2APC01HT110.eop-APC01.prod.protection.outlook.com
 (10.152.251.179) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.13; Fri, 28 Dec
 2018 10:09:40 +0000
Received: from SG2PR04MB3415.apcprd04.prod.outlook.com (10.152.250.56) by
 SG2APC01FT114.mail.protection.outlook.com (10.152.250.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Fri, 28 Dec 2018 10:09:40 +0000
Received: from SG2PR04MB3415.apcprd04.prod.outlook.com
 ([fe80::e997:7be6:4812:2393]) by SG2PR04MB3415.apcprd04.prod.outlook.com
 ([fe80::e997:7be6:4812:2393%2]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 10:09:40 +0000
From:   Huang nut <minhaco@msn.com>
To:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huang nut <minhaco@msn.com>
Subject: [PATCH] crypto: Fix typo in "pclmul"
Thread-Topic: [PATCH] crypto: Fix typo in "pclmul"
Thread-Index: AQHUnpVypD0WoAoFD0Wqg95/KtDM2A==
Date:   Fri, 28 Dec 2018 10:09:40 +0000
Message-ID: <SG2PR04MB3415A7CA56902CA965E6F62FAAB70@SG2PR04MB3415.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0177.apcprd04.prod.outlook.com
 (2603:1096:4:14::15) To SG2PR04MB3415.apcprd04.prod.outlook.com
 (2603:1096:4:75::11)
x-incomingtopheadermarker: OriginalChecksum:F29EF6D04BAFC6EFA2C5888E95E32843D96BB6CEB250AAA003A935A740781F0E;UpperCasedChecksum:D3F31779830019F48EEF6C46505B09B68BB3A695F28A48E26FDE4CAAE357011B;SizeAsReceived:7438;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+aReZ7cXMCUWBlvoBDG65kwS/YxNHQOV]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2APC01HT110;6:96zjJj26m5+Gh2gdJ/b6nNOgQ2C+0fRCSwwXVEPyCFHqOgIMhKJWXa/KVXboaaOHHJyBvX2dJClFPHkWHBeYNFtNU21hS7iSpshqvnaVgdWgpLrQkV84+1kJJsX1nVWY/LTRvA/qRWVlEcSmVO30Qx8Br1zxR/eFnAxtQKjnc/PssiMfEHMhPWDtLKYqKfyplgqsivUsUQEj5de2owJ2f/BNGZrPs+EdLEG5u2QIVS3UTIqRYmzGR0PKVc+pZ7zl78GIr1NLyCvH//WjbV62FlitpgDo/X1mMyfo9ZWG6NiUt+lI2QUnPjn9QDiEUGn/UrvLLIxCfFfrmbqO/cq7q5mlG0L5ZFCEzFkidfGWH9fUtx/9OyprHPiY9uJ4nQyw9MmWlMRC8R8xYDnNK/R2YqOEMwLU9HW45YKqEFhjQ7NDGUVJmDF9A2nmfLl1iEGzcGurRaH47vRUiEA6QHTmYg==;5:iUIS/nEbKTLrdXUT8y+vZZ9ynlEV6nWglhlr6Z5y9YxyMRVz5BcnpxDFOBvDQ/GRgUsuQewqpZGqs83rHGu679S5z6mrUL8m2fqCxWBWG053Yzx4NX7xLtGsm9o5qyqg+MtXKEW96uHH2qTRWuJxwoEzjHCp8yO7/+6nZXMLLoY=;7:MkDc/sgo0qEW9jFFwKEDdTIrnnAg4MQ5RuW+r/v8WhPk8aa7hPCPcBrEsjPR4OrNSgIvM4IqV3ix/bywpY1icWGEVF1B1Ta1o5SXVXSSFhVltBpEOXUoAE3ebrb9QMdupIEGYv363/KAxpsNm1WbRg==
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: S/btQ8cKWiTyF7sT7AOcRkGT5A4LQ1+dfDIQxwdQptatgU5qg3B3STmPKs+RGD9T1Xd9dT2NNxfWw94zA76mjbEGMTXufhEYWVlW3X2cA//tzAOUkm35g8pfTgTJiIA2EyvPEZKN1f7Fya1paIbIsqO0jHk2M1Ko3k6kSA/lPFIIzR9Vtnp/D9yggeyRrX1+s/mKHIyxb1C+t0W2rn/pBogX59kIA3uIv4GEU89wy1Owr8U5k8T+ii7SnhuBbXetggvmp2tqWCFLduue9aF4rFryYsditwR7ssNfxRmzEcv6BJM36Fr9cr7YxAYxlVhxC65vZaT0dFYyhyqjF0KS9GnAU6T8vx/mZz7ab+BT6ctKhxkINziUoGqSbE0y5PnOTemI2198KlBcSRh+JJMYDow0sGHPuyRVhxPv5Jw2/XBZJFHWKCduTC7cTD7YEiBl/cmkFNztYmTlBJicht/njC6Uve0RMjRs1SFa0+hHuLzUAs9cuQFaWCmchCxGt0M7k/i+XYH0CTZjLfimw9q8sCjUWAtCSbJhRqCq2RSQmoW6ywsq454Fe/uSUEtWVuc8+/DkRCEfIQ2gg8pTjVGMBwsrLCO2SfeMWEeCUsjy29rChNEmu1w6WCQYyJkkLcw+r2aJFWNCqPl48M25RD3MlLVjokuOreAsVP/MJXmE6RxKktKhuhtWR7RwORR7zfpjVzJH9ExhlaP+O2jJlITGFftiIx/9uHvtHO2pw/r2Zb+u/Ey4G9N9gKb5ue+eWjJT3t2KjiUV+QM=
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT110;
x-ms-traffictypediagnostic: SG2APC01HT110:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SG2APC01HT110;BCL:0;PCL:0;RULEID:;SRVR:SG2APC01HT110;
x-microsoft-antispam-message-info: +VP04a4iVQ3kFdoTHbu0MeBaQDWH6RghwfFsIGimbHheCdYXnMBgVMPhfj1BNG2A
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f9425f-b52f-4841-d6bb-08d66cac9482
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 9a4e3081-9524-43cf-bfc3-dcaef82d5da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 10:09:40.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: haco <minhaco@msn.com>

Fix typo "plcmul" to "pclmul"

Signed-off-by: Huaxuan Mao <minhaco@msn.com>
---
 crypto/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 045af6eeb..bc854c23d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -642,7 +642,7 @@ config CRYPTO_CRC32_PCLMUL
 	  From Intel Westmere and AMD Bulldozer processor with SSE4.2
 	  and PCLMULQDQ supported, the processor will support
 	  CRC32 PCLMULQDQ implementation using hardware accelerated PCLMULQDQ
-	  instruction. This option will create 'crc32-plcmul' module,
+	  instruction. This option will create 'crc32-pclmul' module,
 	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
 	  and gain better performance as compared with the table implementation.
=20
@@ -671,7 +671,7 @@ config CRYPTO_CRCT10DIF_PCLMUL
 	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
 	  CRC T10 DIF PCLMULQDQ computation can be hardware
 	  accelerated PCLMULQDQ instruction. This option will create
-	  'crct10dif-plcmul' module, which is faster when computing the
+	  'crct10dif-pclmul' module, which is faster when computing the
 	  crct10dif checksum as compared with the generic table implementation.
=20
 config CRYPTO_CRCT10DIF_VPMSUM
--=20
2.20.1


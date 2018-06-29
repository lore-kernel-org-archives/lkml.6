Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E291C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C185250B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="i2xTyzhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C185250B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936280AbeF2L43 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:56:29 -0400
Received: from mail-eopbgr720068.outbound.protection.outlook.com ([40.107.72.68]:29738
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933005AbeF2L41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0QolwHSpKCIM9zPbPH7zm2WgaDgHd42aY+Mb8j2t+o=;
 b=i2xTyzhLPxyFR0JY3fQeUi6hOLW8FXBeBvgSV+oRfPsVFVlicFrwISbzm2XdBrheNdjt9Cfm7jQbIXonhk0a5Bk7NzSu8/TD+rP/zvF4pRsYURzhFHb0x4prZFdjjtPRFfYMmOQZ2SihKvFfqPsU9/fbxPZxSvlU2Aad6gabTcU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB652.namprd06.prod.outlook.com (10.141.227.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Fri, 29 Jun 2018 11:56:25 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::f168:d301:338d:cdc2%5]) with mapi id 15.20.0906.025; Fri, 29 Jun 2018
 11:56:24 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lightnvm: pblk: expose generic disk name on pr_* msgs
Thread-Topic: [PATCH v3] lightnvm: pblk: expose generic disk name on pr_* msgs
Thread-Index: AQHUD57E2zqzU83BgEqhBnaMjK/IX6R3ISaA
Date:   Fri, 29 Jun 2018 11:56:24 +0000
Message-ID: <13BD1F74-4DBE-44BA-A774-4844E2886F73@cnexlabs.com>
References: <20180629114543.28510-1-mb@lightnvm.io>
In-Reply-To: <20180629114543.28510-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB652;7:Kxrm+TDv0ubxGHt+GxHSiFnXAKEtzCxAgqvzKnwFB8LIaR0jTNTcTLPeUWYwC7Nf1KjdZGaEh280ogRX7MgS8KFs0Dvum3Efn+XyPdaTRWQBq/9CX2lgJbaDoifjF7Ah6oq49ywXhHd5qpUMqhz9//u4Ei4OHrGcnoJkv3XscQYLmUcPY3o5VALrc4w0NoVhihCZlZ66HFgLk99krxdw27hZMVodl+nwSbeOXK4uCWrn1/DPc7Dfesui9Tybbgm7
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39840400004)(199004)(189003)(446003)(6246003)(99286004)(486006)(316002)(68736007)(54906003)(99936001)(478600001)(97736004)(11346002)(66066001)(81156014)(106356001)(2900100001)(2616005)(81166006)(82746002)(6916009)(5250100002)(305945005)(5660300001)(25786009)(33656002)(7736002)(476003)(186003)(76176011)(26005)(14454004)(6506007)(53936002)(102836004)(6436002)(6486002)(8936002)(2906002)(83716003)(3846002)(6116002)(14444005)(86362001)(4326008)(36756003)(8676002)(256004)(6512007)(105586002)(229853002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB652;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: ce744414-1b6f-4dc6-6d6c-08d5ddb75696
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB652;
x-ms-traffictypediagnostic: CO2PR06MB652:
x-microsoft-antispam-prvs: <CO2PR06MB652E00AF0C16D3E6C1E63C5BA4E0@CO2PR06MB652.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB652;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB652;
x-forefront-prvs: 0718908305
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +5C43WoYwskcZs/zftTouo4dXTX9D75bLomE5mGESWfP/+KhvnN42TOYYhgsGsDbEPnr9Uhm13OocZol5nQflY4prxAr8nBej8jZyGEDUHK3Yxe9C6OULrHumDQ0/eEHHRkGOrJoUVs7hYYdm3Is+yLDwNQMfKFW9csK5cirCwMPWxdnxPqXdYAw2SnIcq6ntzbCVQIYEvbyAFjcnYk6ZDvLLk3XM/3akX9urCJIt+QFLc7/7iy2yjs7wFYct/cDgWo3kw0FySCvGWosvtTzcQvrbA2ta3nTIKGe5bsP96advkkCetRqTRGvMhGel2GWdQyvaJGT29g2mCZHgtZAH/XUon4u2wBGdMD/JQvxEug=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce744414-1b6f-4dc6-6d6c-08d5ddb75696
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2018 11:56:24.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jun 2018, at 13.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The error messages in pblk does not say which pblk instance that
> a message occurred from. Update each error message to reflect the
> instance it belongs to, and also prefix it with pblk, so we know
> the message comes from the pblk module.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>=20
> ---
>=20
> v3:
>  - Missing kfree's when spec not supported.
> v2:
>  - Forgot to test with NVM_PBLK_DEBUG on. Fixed up the broken code.
> ---
> drivers/lightnvm/pblk-core.c     | 51 ++++++++++++-------------
> drivers/lightnvm/pblk-gc.c       | 32 ++++++++--------
> drivers/lightnvm/pblk-init.c     | 80 =
++++++++++++++++++++--------------------
> drivers/lightnvm/pblk-rb.c       |  8 ++--
> drivers/lightnvm/pblk-read.c     | 25 +++++++------
> drivers/lightnvm/pblk-recovery.c | 44 +++++++++++-----------
> drivers/lightnvm/pblk-sysfs.c    |  5 +--
> drivers/lightnvm/pblk-write.c    | 21 ++++++-----
> drivers/lightnvm/pblk.h          | 29 ++++++++++-----
> 9 files changed, 155 insertions(+), 140 deletions(-)
>=20

Looks good to me.

Thanks!

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls2HmUACgkQIX4xUKFR
nnSSPBAAjHYfi34kgXD4L5EX1DKwxH5Ja+wJcm5XrrS6E2bYEuxClKnOrfPv8PWu
/s3qd7AsafJcb8+iGrOHIMs8nGBOo6sZRueKHN6/Mjk6AO6HVzAwFjJgC5DcCzrP
bPhD6TxZHesqNIQNwpB2EoGdcxzFwWoxB7+dBZSjsAWSe8qkt4DebdQKq7O3Utyl
DpxhrwRwMnwYypv9ASR69N6q7qjj9xC4gNH375weh737wi16uSDERUAsBrP5Yegh
8wKDAigJ7gEhUziSH+c7CCVNN0yjfxHzAfE4p3Lsaskijo8jpJLnTTMcvKGLFFg2
/lKjVf3A+zuZwIkt1kGwbQieF9BoaAfzO4aU4WzpbqkQPvBnaLsoPbgiaj/VZxvm
hpATnxuCpKDZ6T8SwoBw7WV3Zl0QPYu6vjzshU0JHBRu+fcitxxxjIaCCoBHFnDk
TJfy+7g/In1NFomTirIGEeqcN0cqk/4SCXYlpwRCKC42M9Xk4Mi+w0LkjkCPkLsG
kQqn1OqQjQ1lisbNHs31O9skFts8z8ZJg4eT8cb5a7PsA+G+Hs5DjRrX7GievF+p
SsTsISt6POyljG042KrkY4NkPsx15mBvnyo1wsO6C9iqFqtLp1fhVi724ZfVnP5T
qjhubDLeGueG8PEgXYrRBylwqM98egD08Lh5bahe6yX8Uy2r1+8=
=1VZt
-----END PGP SIGNATURE-----

--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940--

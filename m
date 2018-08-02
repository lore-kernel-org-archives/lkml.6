Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2522C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B501214AB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="dSUzpamD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B501214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeHBPKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:10:08 -0400
Received: from mail-eopbgr700086.outbound.protection.outlook.com ([40.107.70.86]:39552
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732270AbeHBPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtNoqjnycce8khkqvA8r6jSkhEKv+yWIiEneTwQfa7E=;
 b=dSUzpamD1u0U9uU/oEk0zeRqsSC4KuLgmkH4hwl579GMXO6IVLPpdkeoPLGOwrCScmuIsEAPqQDgCHNvzRMZq9xYHNqhHGFpyXwXic5DOi1moTsdr2JYZ6TrJZZ0YjpIyoydMS5RSEATZWKfRqiF666KD8839KjdNPNaS3sXAU0=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB459.namprd06.prod.outlook.com (10.141.196.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Thu, 2 Aug 2018 13:18:54 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.0995.020; Thu, 2 Aug 2018
 13:18:53 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Thread-Topic: [PATCH] lightnvm: remove dependencies on BLK_DEV_NVME and PCI
Thread-Index: AQHUKlDljh8yzVauHUm9dfX7nLIR6KSschIA
Date:   Thu, 2 Aug 2018 13:18:53 +0000
Message-ID: <B899AED5-11D4-4ACB-B10B-5C080AC9B882@cnexlabs.com>
References: <20180802110625.12463-1-mb@lightnvm.io>
In-Reply-To: <20180802110625.12463-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB459;6:Q6qoIlUVXufTOA9fGjxNkdCHXIgfH2YGt0DZ2DVZhECB7qrH5ZEIY98zULP1728S4ihFaT1mn2pnwbpIF7HHUfgeVrfX0PoUydjkv8DFXrrT1frgTHhMV5nsmLZ00XVEIXQ8q09LKyF/uafqNNRk34E3oglbror9oZlQt5HDo/dkskanmgsVS7t/Fmpln97sBLAYC3zCUJ4HvykK6ZTp0wY2BLOTO2iSOLSj7QSY87rl+PfwTOD51vzAUB0W+kwPu34Nxs75sEeDPrz0k4g25cbUbOvN1VynHqvtCOcFrUFCC6kpY/z3jQtadaOEllvhxg1KgHedGkOFfdHH7TjO2bM1dJ9zrEbkFJBgPEVaBiFdF3xiClHf+aW4D7r9h6+mXcClap9XEM6m+WLJUKQSIvtro8nvS2xwZPfJYbBAoOJWSnn5pf3fzBhaB+sK9Z3tOALUlI5tJi7kdUGoRxbJGg==;5:Z3txTr1uUSXoHxXfrGmCCs6NX4KneKx+nsYmAdrGe/RzQ+a0WG8zmDq4ZELNncsuEoD6MgKYlKnVBJihzmfjsh8Mit2rW1zPt25PM0UnHiU5eU+llMbgLC0IAYLedbL4QrwuAnMFLTfm9AugBidcxkiWYR000Mlt5CDwKXmx+VY=;7:2IMYLTNenFar1X8FGazPjh8Dzu3vAs9+p4Vag8wmaxRWcji7Oce19SRUbEIPFo2wULae/+T/5zCKdCUnwh/RUKcRTJggDluZr3gskU7L8gmDeQueO0wAy7YMgKwjoggnEet42h8IMhkaPXx0WtPUmsJsSKxZGqn/6l4aIq0rlafIP/RXxZ7pHE0VbHRQh4fI3hhS5ZPFoLDCCk58bbPUD+QSaoYBxZtpRlvCMJfGD8oHDXwvzQs92nuxg39ZWGHz
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39830400003)(376002)(366004)(346002)(396003)(189003)(199004)(81166006)(26005)(81156014)(82746002)(2906002)(8676002)(99936001)(3846002)(6506007)(6116002)(33656002)(83716003)(486006)(6916009)(8936002)(102836004)(5660300001)(66066001)(54906003)(186003)(305945005)(11346002)(2900100001)(25786009)(6246003)(106356001)(7736002)(76176011)(105586002)(4326008)(6512007)(14454004)(256004)(53936002)(5250100002)(6486002)(316002)(6436002)(99286004)(86362001)(446003)(476003)(229853002)(36756003)(2616005)(478600001)(68736007)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB459;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 53d12a19-ec71-444f-f0c2-08d5f87a7ea8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB459;
x-ms-traffictypediagnostic: CO2PR06MB459:
x-microsoft-antispam-prvs: <CO2PR06MB45958B83B636511868552D0BA2C0@CO2PR06MB459.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB459;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB459;
x-forefront-prvs: 07521929C1
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t4wU8RYgZZZ36gBYbaoN0O1z/TyRmzSQXkp5jw+ePjWZHty81tGZRP92mShoHGM6RSJhugZr6PixI7Dq/MYJhlEsHmM68ipuSZuT3Kj37ur4wBnU6wA6+VYFYr5qAI0CVlJwz0V2VOxq8H4pg8fxbcjPG3JSd5vk4WHEB4Ybgu1RuTESe5folBpbIvahmPny8fllKGqmyHbJOVTjGk/QHYwOeKKNxuGk6Z5CD3iWGsTgHsMO/KC8Rl/v6N7rAOHtpJieBGeQVUVFQvKrASKirpqX2XGqITrootXXYmmOj6ie6rMnvb16Q3nxQ3SB66moVZrWdTA8JhYPQCm0Pr6xTivwHkiu6yB+1SoDb7zJl4s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d12a19-ec71-444f-f0c2-08d5f87a7ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2018 13:18:53.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 13.06, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> No need to force NVMe device driver to be compiled in if the
> lightnvm subsystem is selected. Also no need for PCI to be selected
> as well, as it would be selected by the device driver that hooks into
> the subsystem.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/Kconfig | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
> index 439bf90d084d..a872cd720967 100644
> --- a/drivers/lightnvm/Kconfig
> +++ b/drivers/lightnvm/Kconfig
> @@ -4,8 +4,7 @@
>=20
> menuconfig NVM
> 	bool "Open-Channel SSD target support"
> -	depends on BLOCK && PCI
> -	select BLK_DEV_NVME
> +	depends on BLOCK
> 	help
> 	  Say Y here to get to enable Open-channel SSDs.
>=20
> --
> 2.11.0

Looks like a good dependency cleanup. Though the nvme driver is the
only one that hooks into LigthNVM today, so it will have to be compiled
anyway.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltjBLoACgkQIX4xUKFR
nnQgmA//UVT276oGQeV9xzaMVC9heQ90/1ifJqucvUz49ZRgC73j9Fm7kdlwJ08P
hyi1gXUFjCgxa7+3g2nbQqTXrNsIjrtROjPyYa36/99hAqDLqOlQxnjgFO6UFAG1
3+0Rz3hTJGNZRL+SzMlcMc+Qpsk+Ezq6s3sajDQdc5Lx7qq25iF2dH+/1/iGgERW
zZlX1FOA3aQAWaFjXjw8tDCaM2rnH2p/39/Ekq4kk8/0ifOb0oYUtLJQ7F0k/kdH
vgyuejcU4YNfxHvcuITyc82HoR2Z7yZotWHliGpQVpIHwi58VTXbMyTpNGrI3nib
MM57u0HOGWfI6AS6zuJgApQGDa+wfPh7+TVsbMEEwAgV0ICDLJ8MfRVq2FlJ4p/s
bw+blqFglVdelH7NK53P1tBDwnqckJQpUQWCjsBvWKYPqrzgZ4tx/eoRogkiaN1Z
JBdbjfx5/r4hm1MFXuzQLvL7I952jKQNi5MX5Rbur35xyK/DcEgYr4vIHRMzx6TC
KHPx/m28Ce19d//Ey5EmXdhyWzhDbN/UN9ebackYxs85MDmwtP9MCdVPhIiJMneA
VRQL+gc5BIZtDQxhTJYjHN1AP3A0MTM4HTGI+nXseDX2yNeFxjRcg50jIaEJnizA
/0OJ3YmE3S8mMDnBgM89dyODHHSzDSvdo2C6tJSJpiALYfUI8Kg=
=ykDF
-----END PGP SIGNATURE-----

--Apple-Mail=_D1E0DCC2-711A-4576-A471-453AA1F88B05--

Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B24C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5968F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="BsE5bk0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5968F2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeIKQ3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:29:22 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:60544
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeIKQ3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0dCDeYuxSocy8YNw7vYAKCZkILm3nk60Wfrv+YfACU=;
 b=BsE5bk0/pN4T6w3vMiFSmQgLHhPXawQzP7C46JMo9fze91d+bGy8E85BuHi9AAY5zh8mlqnzOwlX1cauo6TsiNy1XvoVkNgnb8TSfseO2tptTIkZgMFZwtx3MfnhEgKxTGqiLJiIu2xm7KYW7/g1t9vI9OMYID+8HKFBypyhsyM=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB523.namprd06.prod.outlook.com (10.141.198.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Tue, 11 Sep 2018 11:30:25 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Tue, 11 Sep 2018
 11:30:23 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Javier Gonzalez <javier@cnexlabs.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Thread-Topic: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Thread-Index: AQHUP4BwZTm1hVjhZEOpHx2Evg7pOqTkrA2AgAYt2ACAACy+AA==
Date:   Tue, 11 Sep 2018 11:30:23 +0000
Message-ID: <9C271B60-C421-4C9B-99B6-C30B65494095@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
 <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
In-Reply-To: <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB523;6:zf3m3CoIdVLlsfKzpbBlRm/NNuwe92O7bS2hfGoynyusKGVvWwPQQuCLMNHsnlSPxR02WCM4579K9aXqyy1aB3L3K5y8koYFRSuGvP7vYLQ2N/hpN/HGe+wSq9ShsK0DE9LS8eOXksuay3lt3ZYUGZiHYTL8XBj0wgPwfMj58OIlT7AP8xUEwTOdltG9j3cMP6rVs8AYqG+Bux42hRkM8A3MPtjbjLPA8qJXkZz+jLsMEsKuPvWXAFgC/MghY5S4ZUIJkriaspfMkEegRR9qyAMpCKA49+6z7ZExtnZBLKgb4PJoBy97K7yr4mnBgdDt41Zo4py8+KpnUZ1fogKRjquNv3GCR5fjZXsZJ3A+mmA/2A5GY4uDHAPRafX3lLLQy/A3MhBQzfM2+JYdMMzE1s7LegzMYlQklIDcw0s0HPfJ2OEWJrOfLpF3aCc1xFpNWQKonw2n5HuSmZpBWg/MoQ==;5:MgstyzOT2iUmleVghG5QUF8iAQZJlqZ9gFwVLxORxb1UFyW7+xe/iLfSJi26HYaTgOyZqoYLzt64hqrWtm0WVHDgNv8SXTT/EAXUw6QTqapcRlLzaj58QivR0Zxg8dZ0A3E4g/Lu0J4LiL7B1dOx/L404z3z4PoJ4cKtITDL5mY=;7:pAgNWek2hqb+/Y3GdN+eJrDz7Knkoenlrru2nmrNSyVKsfhsRihdg6FYmrKLhWtm3O4Yq3lhmuIYJa0PJqLiYWYWnohDozQ8w4KQNAAoQ910LnFK9DJrZIg8+zvGFGQ50XkjADN/Nh/Br7YAP/JEnyRx4zfqbNon78KKjvh4D5L5fXpCaF5vgeau/fWOD8a/on0R9IrhFrAvkS5P1srkp15F0iN6+VH9wu6uZ5pQcBhBtC/14ba+4phlO11djW+c
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39840400004)(396003)(189003)(199004)(6246003)(229853002)(6506007)(476003)(86362001)(26005)(4326008)(5660300001)(8936002)(68736007)(6200100001)(305945005)(82746002)(7736002)(15650500001)(102836004)(97736004)(66066001)(53546011)(2616005)(486006)(446003)(36756003)(6862004)(478600001)(99936001)(11346002)(25786009)(14454004)(316002)(54906003)(2900100001)(5250100002)(106356001)(105586002)(99286004)(33656002)(83716003)(93886005)(256004)(37006003)(14444005)(6436002)(6486002)(81166006)(6512007)(2906002)(81156014)(76176011)(3846002)(8676002)(53936002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB523;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e68759d2-bc4e-412e-cac5-08d617d9f70f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB523;
x-ms-traffictypediagnostic: CO2PR06MB523:
x-microsoft-antispam-prvs: <CO2PR06MB52346396E05E77A4CA0F86EBA040@CO2PR06MB523.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:CO2PR06MB523;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB523;
x-forefront-prvs: 0792DBEAD0
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xtKprlzaDEOEwXys1/bFNa9Bwh+Dom6DNcNEy6K0uM6iQJzhzU9d0OOaM7iFqA+y37ZGJupXG3+QipDPSDSk6LICrrX/pXfquLdJjbBsMhI3YZH0PH0/sDy+NOwYhdrj2hOT6DcURqv6dro269Wmjz8nUDGF7rgDhAirAj+Fi1qmS0kaf6v6U+WHjdgaVD2P9h3AkcuWbg1SX8eHhB8FCzy+GceszYkwV7hkIrAkDo6JZVfscimGSy3VoWm0IB/ctlJGQUXG3rO3JDiol2Zi/FsHE54ambDQOPmoxMmWZxM2xcNAAVzqC3ch4cDe595FyXYWcrpAop63HRY6cd7cCjKC9c0gsvRRgENthDcXPxs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68759d2-bc4e-412e-cac5-08d617d9f70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 11:30:23.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 11 Sep 2018, at 10.50, Javier Gonzalez <javier@cnexlabs.com> wrote:
>=20
>> On 7 Sep 2018, at 12.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>=20
>> On 08/29/2018 12:09 PM, Javier Gonz=C3=A1lez wrote:
>>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported =
though
>>> the standard nvme identify command. Thus, the lightnvm subsystem =
needs
>>> to update this information on the geometry structure on bootup.
>>> Since 1.2 devices report these values on the OCSSD geometry =
identify,
>>> avoid this update is it is unnecessary and can also corrupt the =
geometry
>>> if the devices does not report the nvme sizes correctly (which is =
not
>>> required by the OCSSD 1.2 spec either) >
>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>> index 5bfa354c5dd5..33ed09f8410e 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns =
*ns)
>>> 	struct nvm_dev *ndev =3D ns->ndev;
>>> 	struct nvm_geo *geo =3D &ndev->geo;
>>> +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12)
>>> +		return;
>>=20
>> The lba format sizes are not explicit in 2.0 either. For a conforming =
drive, it should implement the NVM Command Set and expose the LBA format =
correctly. Although, I do get your incentive, and if it is okay with =
you, I'll reword the commit message to this and apply it?:
>>=20
>> "1.2 devices exposes their data and metadata size through the =
separate
>> identify command. Make sure that the NVMe LBA format does not =
override
>> these values."
>=20
> Sounds good. I'll resend either way as I rebased on top of =
for-4.20/core
> - you can change the commit as you think it suits.

Since Igor will send a patch for the OOB, can you pick this up
separately? No changes needed after rebase.

Thanks,
Javier

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluXp0wACgkQIX4xUKFR
nnQ8MBAAzhUR+BsO/PngkgG4zefDhQVmdxqD9o8fkJTWQ7lkhREHhhrXIrzDc0b1
BBASza3GFUL2frk0/vpLAhOHAbX/d0q8TgEriOiJRzdscusXBlvIiLE2oRht318p
x4FY+GrN9n5ZLWBooT7mjsfFK0zgHPZB8Q9s57MmbpIDR//EAbd7Fxha5qZY9Hxk
Q+VP/64xeK5dGD978FYlVdU20q6C/IxQuWBNyRwtq2Zu8jYAbIfYvdo3hc17LMtK
ZLLAmuvmiWOgux51CFDfpfKzVSNdHk1IOqFKjVu9yIqONCrrNWeWew6sLlI2Lw32
U4i44MHW80Kge9Xq7r4Cwd+V1EGyAVE4a63okWixAOHWP7a+DimDfteKit/1Itd8
ZzKq3VJnyVF1cDCejGI5/tp0U1fjVed9R/AuvSo/4/sZdW1pz/y23V+MQufQQqod
dnlBoHzOzBVdsRbMmjDUezLx46WyFmSDvJJ9jsc1chANyeGY5LKmMUtRJ/lq+7Hj
Wj2G80lXTTk/fpMbrAaDca+XsTvjHPqr4HctGn2Ppc/FUct31em8ZTMoXh7snnDY
SUgZItM2b2sYq9dRDHKEOsN+hFjfDYQpbc+8WRaVMJil7EBGSZvy1PJvOsyKozz0
tnTIFTIg1bIw7hnlSaLviW4f08DL6GUJp9t3rPp2ts7OXjfwDZ8=
=J81c
-----END PGP SIGNATURE-----

--Apple-Mail=_95538BEF-79E2-490F-B1AA-9EEF19F4197B--

Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7B21734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="Q3Pm+yEz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7B21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeHCODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:03:36 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:47760
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeHCODg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKqEKAdOYVSviN4/fzTxEdrIXkhRYtb+PJLuFJV5p4U=;
 b=Q3Pm+yEziUH9OQVaIT2UlyIhV6kNtnJfOLULhXKhxaiQUjkhLrf59LwVDIY0+hsTi9gtqWw12EtxVjpzxuXjwgI+Vmm0bClgeA1HVraZ93m35mZYKQ8jvjVVKAmXQV4aIbw1CZwAYU6HeV12xbcnRJwwiKw6MAXzxOsRlNqG054=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB570.namprd06.prod.outlook.com (10.141.230.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 12:07:31 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:07:31 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: remove minor version check for 2.0
Thread-Topic: [PATCH] lightnvm: remove minor version check for 2.0
Thread-Index: AQHUKwjBnQOrlHyXU063xXFhQVi3bqSt7wWA
Date:   Fri, 3 Aug 2018 12:07:30 +0000
Message-ID: <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
References: <20180803090237.2022-1-mb@lightnvm.io>
In-Reply-To: <20180803090237.2022-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB570;6:D2evgI8Wtw50llLK4PBrXWtaFeqFBpWQ0mveNfmgfnseranT3Fn2NDhE32hTd3IjTmcmgxVDhbUTgNv9qsPp15W9p74avf3xXBqtUksancLANlBmKqSl258EFExmzOMMuWTezYSmGZPxWeosDwRrDO1hjzhRuywcK2IE1Iqw9atb8oT64dRV50X+n/jcp4RJrr1e/KumqA3bHVoKYGmjqS6UELdPvlivDi9/Gq1jHK017iosG2p5qUObLVdux6q22Szt5uNSKBZm5Qyjqc4LIHdLQ9D0yhzRJGeYRl6aNkKHtzTVcaBiCiEFxSdCWoVYkxE5rYWN8tJfmG3j2OpqzKCiDfjV4Hg0yzBHl6oLjzShls3jzDYyat8byTyKkLYwIsocanHR7Rmlv+tNMcWXv40AGuPn7sj50Ls7MzdHHuGFl8mtuSYwndiACugRhcmKPsmMYiNVj7EGUFVJiPlDtg==;5:/Oc2Ij6+pE2mGxKyoqK+tONtQFSslVjw14rsVBCJNiqgt90LMaKDnkDxZGSxAC7bKJEgPEPXFu2kNTYtxl8vFTjztz83k3FaFETwTsdB4wHU3ymFnrecu0OFp6w0IbxeoC+nY6VJM3US5Roc10BKvkntBj09Ong8Uj/gqJi5rN4=;7:kL4mRqGpfvl77OYchPdmrZpdB3MA50AD6r1WaLbaWLwftNwpLDuXnvKlIeJsVA2PVKF4JuDm9A6MJVW7Y5pAToQdxThtD0jS8guSPgobMHlAX1V94c9KwWogp+QDImLkIWUuiiPbOvwpWcAT7H0VXLrCpY99L78VD8Tm+ssjdr9bX4XIu0fkPDbzL7hw7HTjZLV5i07MyLXIcoZlW1N/AUqR4PK7I4sEZ0alDZjz73dCHhyfSDfDMXDLAb3ksC8Q
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(39840400004)(136003)(376002)(346002)(189003)(199004)(26005)(76176011)(83716003)(478600001)(4326008)(446003)(99286004)(66066001)(81166006)(33656002)(2900100001)(6506007)(86362001)(8676002)(102836004)(256004)(8936002)(186003)(6916009)(81156014)(3846002)(14454004)(6246003)(25786009)(7736002)(82746002)(476003)(305945005)(6116002)(53936002)(68736007)(97736004)(99936001)(54906003)(11346002)(105586002)(5250100002)(6512007)(2906002)(6486002)(486006)(2616005)(36756003)(6436002)(316002)(229853002)(106356001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB570;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 52b6864d-69cb-4407-cbab-08d5f939b06b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB570;
x-ms-traffictypediagnostic: CO2PR06MB570:
x-microsoft-antispam-prvs: <CO2PR06MB570E2CA7FA8F5F85D2F5BC5BA230@CO2PR06MB570.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB570;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB570;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KPAdPvmvnzCtia5RxyPwEvZXNGGkCkANCDV8VTZdX0JgOY/YjyB7FyfTVgIsc8lq1yi0bJ9uNOU+ZaIytwfpOOek5YSWfaklDbTumzez8Bl02no77+BXrgGZgiWwH4Ce0tZgC0Sbt5rQNEM69rqEiVkRECfYmyhdDxtIgd6N7oLJSPEzLu3mZFW4vguwfELN5hwQZylt09O8flWW3KOdrvvGaI3BfQU3KbRnw04CgSAuaPmXx9EPf3qLRV8S+cy28yd4un4W7uAozp6ip0Cb2XPlrWAAaww9eOPmfHGDGmfqUw28p7f56js1E0KrTa1FlUX61L4yekLGQs02Zi/RLZtJ3pIdB4NqDRx0SdyO1BU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b6864d-69cb-4407-cbab-08d5f939b06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:07:30.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Aug 2018, at 11.02, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> A minor version number increase should not break backwards
> compatibility.
>=20
> Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic =
geometry")
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/lightnvm.c | 6 ------
> 1 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index d9e4cccd5b66..a156fe3ca7d3 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 =
*id,
> 	/* Set compacted version for upper layers */
> 	geo->version =3D NVM_OCSSD_SPEC_20;
>=20
> -	if (!(geo->major_ver_id =3D=3D 2 && geo->minor_ver_id =3D=3D 0)) =
{
> -		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
> -				geo->major_ver_id, geo->minor_ver_id);
> -		return -EINVAL;
> -	}
> -
> 	geo->num_ch =3D le16_to_cpu(id->num_grp);
> 	geo->num_lun =3D le16_to_cpu(id->num_pu);
> 	geo->all_luns =3D geo->num_ch * geo->num_lun;
> --
> 2.11.0

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkRX8ACgkQIX4xUKFR
nnTNehAAhYO4sb3WnD435eBZs+ZQlmEJG631NbXuYcLfxh68eI9Pba6oweQPzIL4
QuYyTJ88g/QUH1okZJFyZF05msQPB4koljZc1KAX8Bjt50zY9MWB9g0IthszT2fS
NjgzUaJjonyD7CZtpwZOPR869D9VrGv3MATrO9+P25VLfwz2VJrLA1C5zDjNZXqA
xqMtQ3tLR3qtmKXvVhWofAqEO1SXk9/i5foQcHLB4yAWpTrGltsCFrGMlhDq+1YC
902UBBpaAZZWOLdkzrmYVD++Rc7OV6gnnmU/5yQJLtEnhMV9Lx9bbkhRm59+JHcq
Pd0VBnxRuFamjMU3CeM6fCZrX4NbR6nXFk1YTsu00iY5r4qGyz+z8WSSlCxF1bsK
q2ZapOnH19LPkNhzcnA/pARa6TDVyllkylEBZIUbs9RSMr4jGkzlhM1V1H/t4oZL
22Nj3d/+kbi2snaV5XuA1S68pVaeLAfElSeICOaVJkj85XBORMiWGMCDN/xqx6Xn
ZLzSvc4C4Do8EDaoUDZHWShDS5kCpcSChAivttONZTLI/ALB6/8JejH7cV9x96kT
rfCX/hBu2+7PedOOt6kZO0Y1ceaEUg5Qq1+2qoGGMCDvBq/Uk6tdieFNjYk14Erv
dllFLF7PhOuWOWk6tg13jZOhbIu2Af+vZJghI1RIxoqC8CGh/SA=
=sVA3
-----END PGP SIGNATURE-----

--Apple-Mail=_6BA32728-121A-4EAB-BA22-5F3BDD9FDF5C--

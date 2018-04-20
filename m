Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDTSvy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:51:54 -0400
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com ([104.47.36.55]:50336
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750985AbeDTSvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:51:50 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 3/3] lightnvm: pblk: fix smeta write error path
Thread-Topic: [PATCH 3/3] lightnvm: pblk: fix smeta write error path
Thread-Index: AQHT1/0b8OpU9eEjKk63ot0afhGD4aQKAUQA
Date: Fri, 20 Apr 2018 18:51:47 +0000
Message-ID: <621D78CA-8246-43D0-930D-866C3EBA5FA2@cnexlabs.com>
References: <1524155964-3743-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524155964-3743-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524155964-3743-4-git-send-email-hans.ml.holmberg@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: owltronix.com; dkim=none (message not signed)
 header.d=none;owltronix.com; dmarc=none action=none header.from=cnexlabs.com;
x-originating-ip: [50.207.153.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB892;7:uw3d8TDKYE8WH3iLtxDvCmAcntIlBoKHpCBJYkEbTN0pKp72JHhxYVzcDvhp5cFyk7Tv4FWg8L/H1KYO8xfeRM3bs55T74j2pzDvZmWTy3hR+nz3hswuw6osMgJ+YUjqM5YEZdICu4dOQlEzNvpIMW0Six7Zk1RA9l2/DlPaQLMygXqxVWTh13JX96jYPmxuGCkb9rbTY6e5lb5uT9m5TZ/0fAi9jtuC9Pfd7U+6lITJHoz+cXyc2YrOPPl0TQ37
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(346002)(376002)(2906002)(6916009)(99936001)(6486002)(25786009)(26005)(3660700001)(3280700002)(6512007)(305945005)(5250100002)(316002)(7736002)(54906003)(6116002)(6436002)(3846002)(229853002)(36756003)(33656002)(186003)(8676002)(486006)(83716003)(6246003)(107886003)(2900100001)(6506007)(81166006)(4326008)(446003)(66066001)(11346002)(8936002)(82746002)(478600001)(76176011)(5660300001)(86362001)(476003)(53936002)(102836004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB892;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB892;
x-ms-traffictypediagnostic: CO2PR06MB892:
x-microsoft-antispam-prvs: <CO2PR06MB892FEE6F5C4DB0EC045338CBAB40@CO2PR06MB892.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501397)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR06MB892;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB892;
x-forefront-prvs: 0648FCFFA8
x-microsoft-antispam-message-info: vqFfQek/+Cce9Aee+fZMn0vLW4sv19iFnOlCcoeIpYij0nhprthhLqDVJDnL+OYL1OKtn0Rui9MUp4lEAUf1BDlGRVVn7PA3La4AjJog58iIMEVYsCWqNe7urLTS14kHpnJydYVPiZQD6K3sNYuuQmCyJk/Oe5ZmWG6pjefWttQAD1A40pTeKDbiKPg13dhr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 713bbe6a-be18-4001-86ea-08d5a6efc559
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713bbe6a-be18-4001-86ea-08d5a6efc559
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 18:51:47.9760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB892
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 19 Apr 2018, at 09.39, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Smeta write errors were previously ignored. Skip these
> lines instead and throw them back on the free
> list, so the chunks will go through a reset cycle
> before we attempt to use the line again.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index f6135e4..485fe8c 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -849,9 +849,10 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 	atomic_dec(&pblk->inflight_io);
>=20
> 	if (rqd.error) {
> -		if (dir =3D=3D PBLK_WRITE)
> +		if (dir =3D=3D PBLK_WRITE) {
> 			pblk_log_write_err(pblk, &rqd);
> -		else if (dir =3D=3D PBLK_READ)
> +			ret =3D 1;
> +		} else if (dir =3D=3D PBLK_READ)
> 			pblk_log_read_err(pblk, &rqd);
> 	}
>=20
> @@ -1120,7 +1121,7 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	if (init && pblk_line_submit_smeta_io(pblk, line, off, =
PBLK_WRITE)) {
> 		pr_debug("pblk: line smeta I/O failed. Retry\n");
> -		return 1;
> +		return 0;
> 	}
>=20
> 	bitmap_copy(line->invalid_bitmap, line->map_bitmap, =
lm->sec_per_line);
> --
> 2.7.4

Looks good to me..

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>



--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlraNr8ACgkQIX4xUKFR
nnQ5jQ//dF985kd7LBAsmSbHMt2nM4pjd6iBpGhi0S0+n3IBCOGd9DrtSAIWlV6N
rn0ON0iU3i3I47FAL846SK56aFYOBF4mAyNtZXLwH3JVJ2JF9V4q6LP1+6B43RuV
+0jIBQ8uW0lg1JnqlphFHu8GsznXUHJPjAtRaWEPXBcOeulfCqCR6yCL9FPb0fYO
e+X4ggQyY1zuiKo0Ro5N2JTNk3xIr/bXrK9vwPoqGiZs5w1zFKxZxjK9WRkFZDI1
1wfvNJe7ZHYUs3eAzThZl6A+ibbKHTf//dYlsZnIOYCaq83vppXCzFWE+7YzqVrT
Tf97hl0AU0FcM9301mXJaiIqBxLFH5RGRvUpO8lEECd9C6qgOgPgy9MratBwNA09
ClTgb4vuymy+Gv/hHPL3gJOUtBKGrOasdMKzBfAoCkSlYuJQLbTl7T3a1522nfa4
vJVfoGa3OVRwNkl92+nOUVllGGsMqmWo5CoCBXM4j0mx1zwjevdkYhx7tdreJdbt
ClcwhsXbUNisVB2F3uE6a5Hy+BsVt6ATAxc/NmUD9i+nWZCJeVw93DinC/LC6qBi
vAhNGdrQpZ9Z/zUtCgOP+676A3FYCo4K15ufsjirt/0+FJPcl7VrVDF3y7cHItBj
sVqD9IERkw8QxpJKbEOqCGpH63+ikewWLNw79IqmmEyV39tPI2g=
=uwEZ
-----END PGP SIGNATURE-----

--Apple-Mail=_E8618736-166D-4F11-A6EF-EA599FBF81B1--

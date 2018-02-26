Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeBZLWH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:22:07 -0500
Received: from mail-co1nam03on0080.outbound.protection.outlook.com ([104.47.40.80]:4448
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752584AbeBZLV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:21:56 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvme: implement log page low/high offset and dwords
Thread-Topic: [PATCH 1/1] nvme: implement log page low/high offset and dwords
Thread-Index: AQHTpMk3L3LvUzxrNkeggVtcUPAkmaO2nmqA
Date: Mon, 26 Feb 2018 11:21:52 +0000
Message-ID: <4189F394-D92A-412A-B81F-FE27E7D302BC@cnexlabs.com>
References: <20180213124916.28653-1-mb@lightnvm.io>
 <20180213124916.28653-2-mb@lightnvm.io>
In-Reply-To: <20180213124916.28653-2-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3123;6:GA+M33M+nZXbMN5fgcAUwiZ6EzC8E3eOBCNm7X3pK862nhePYSL7TvQHao6d+h8tW+GSoPo9sqHuoeiXStBaVVHQkznyLOFfUBdZyMdTOGGTjLU4HES/qsgfLVWQ/SjXw1lqVnw+pgxWhEYWyzkJakRuwUniZAR/0Gw/r0lb467gGrl0+5OEw2OIFAQkj/g5u+Lb77sqkDoJeTNazIl7PX78yv3h8cHxEoOMHqR9H/FxpcCGicLMFHiZbv/8JBeNydy/kvn/92qV0DqUuPuxcmGT3iIZbjBaSplm+5oUTBwZKTPQWsZL9QpviiP26KNZQl01yKQhsf7AQeOeQLto/5Z/BUSFOW1HV8/K9uZaK1/BWL6mdxWMoLhcYj+KwaZX;5:7x+L7e00gkgbSSizB0ZOkTrKQcnw0wiRbZM4GxUf8jszmn+od/t2EHeFVcqTfUa4CItoUjQyHll5uQ/Qgvl1GYcw8xaRTYLzl0+vacBULVqf2FQDuvcg0wqo+01i6sv029jTFzJZXvgBP8xxq9cmiwOi9WcEqb3uYOYcTgd91cc=;24:KQHor70wNU2jwakzy01upWzanx2POFSWwHjpSw4J1Gsb4fwpgfh97Dho7S7yAjgQCx/ESLnF7Fv/POlffxTSdnynTXyQuMc0iNrTCnrq6zU=;7:1ZPFjDLw0CJepVQq4x/xDF3U1XSXnHCdoyFZ5R9kVxbm6QxQVE4eM2XJWSeAdaTPNHkH4NMo37nJcgHtlEQrrTtOL/wsKGaiV828jDaIjKb42mUx7k3cjgP7llDlVZJozfl/kp9g+61N9f3pzYsKjK1/sNjhlDKMejDu7w0MMG3Ow1223SJNTmp7VWGekBN8igaVU9pNFoDjvkGdocVRiFcrLcly8a0rU2hqzY5AELEDw3DbOXQexS4ZIeMl7BZS
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 93e2617c-64c0-4e80-311a-08d57d0b22c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3123;
x-ms-traffictypediagnostic: BN6PR06MB3123:
x-microsoft-antispam-prvs: <BN6PR06MB312304CC0BB5C2BCACDB2F86BAC10@BN6PR06MB3123.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3123;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3123;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(39380400002)(376002)(396003)(189003)(199004)(5660300001)(305945005)(3280700002)(316002)(82746002)(99286004)(106356001)(53936002)(54906003)(81156014)(6246003)(81166006)(2906002)(33656002)(8676002)(8936002)(36756003)(66066001)(229853002)(6512007)(25786009)(97736004)(6116002)(6486002)(3846002)(14454004)(6436002)(478600001)(2950100002)(6916009)(7736002)(83716003)(26005)(102836004)(77096007)(3660700001)(6506007)(186003)(105586002)(99936001)(76176011)(86362001)(2900100001)(68736007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3123;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ef3RYd6bA/PgJs8pgrU/YYwIzZVE5AwWEhb5A2tE9lxx27gXxQ4vKQMPxrWg47nlvbVsAxnNTYj6zST3M6MlsmRN5VykCjSmXrvA4ddPOIx3uKSl+r9DNfWaWnkQceMo6WqHQme1ugphHjJR0D78QKSw9qbaSxWLFOiz5OWNREo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1BEE4221-12B3-4C39-9355-627FB1EC1757";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2617c-64c0-4e80-311a-08d57d0b22c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 11:21:52.3538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1BEE4221-12B3-4C39-9355-627FB1EC1757
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 13 Feb 2018, at 13.49, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> NVMe 1.2.1 extends the get log page interface to include 64 bit
> offset and increases the number of dwords to 32 bits. Implement
> for future use.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
> 1 file changed, 24 insertions(+), 12 deletions(-)
>=20
>=20

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_1BEE4221-12B3-4C39-9355-627FB1EC1757
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqT7c0ACgkQIX4xUKFR
nnSvdhAAkcI2fw+U25Wtru2hhcX1iAyU3lVYcXIsGTRsO4n2yMP6PnFai9vV6kg0
uVP+3TsM6qLb8ixagVMdJLa0GL//hwQhzLedrL9nKy7jf3AJ3rrghMe2dAFsLpg0
DiMCHf1xjwXn+xnNqUHRISREVSSM0sl7vfU3SEwb0rttfi68Qa8VvpKBFmp2W/+r
8uO2owYDTUb1Sfhg/3sKEK7Z6JkjA/bnhUZVFFatduC0AZ5qxGtWQDSevcg8qzQC
5CUGHzSuYAdnSDPv22Bl+HWwQr+7pywSkjP/th+Twlwl+6aOjOgAhHj4ZVV8Py6K
73Go6pnGAH9t9iiOLEIM5IwTXsZ0SXYjpt88vWlF7YSQ+s4E9LMc/W1kl/AXHjJ0
1rTzYgGYrBm98Js8pY1k35MOPDNcawmdH+9RrzlBVEp1uLY4nbcApFl8+iOS6blx
txCga1pNsnObx7zwbVX/1ACGxUg45bVC+B+L9JkGZkbAU/gnS7CuMhrYxcotMk55
5+DOZ08V/o6a7hQLcuA6X4ouaVWQkbHJLIBFuA5VKr4aUqUF1nyPNQlFt9PMlEa/
Bnheu12tp+S3YznqUCoCTtNE7a8RnFz5jwit0po6Rni6ySHbi+se7mAr4hA7FEBR
X8GDOg76tGQPLY7KY6GNWO+QKE0dCEfI9cBjd6mKWqu1ET7Ps4E=
=BQkU
-----END PGP SIGNATURE-----

--Apple-Mail=_1BEE4221-12B3-4C39-9355-627FB1EC1757--

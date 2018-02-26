Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeBZS1S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:27:18 -0500
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:13976
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751165AbeBZS1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:27:16 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Thread-Topic: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
Thread-Index: AQHTrwQnyzTAP60IHUq+h1EagnZ9EKO2/qiAgAAAiwCAAADeAIAAALoA
Date: Mon, 26 Feb 2018 18:27:13 +0000
Message-ID: <49DA8C17-0960-4EBF-9FA7-364DE5EAF405@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
 <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
 <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
In-Reply-To: <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3266;7:IQw+iiqmBMMurQT/4wOWuOmGkkKroy1522iuMVTwlC4V/n55h8sYfhnw6x3W06Pb0LneLZZwp/e7AgvjWgXe2DpL50oP6WZDtUb85Ma07uoZ+6mLWaaXyoaYfqZ0HYDa+yqb39CeLYFO8Y3DeLH9SyxEdy/Bd4UUKmW5xNHCf1x5fJGJieHc7ksoSz83AxqPmq+vtaQXNdvt+swUg6EgTxNWafsw24HZSMZZBWhPfKFyIQ8jI1fBUh4apD8x9fQC
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 2bfb5bfe-2589-48eb-94db-08d57d468eb2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3266;
x-ms-traffictypediagnostic: BN6PR06MB3266:
x-microsoft-antispam-prvs: <BN6PR06MB3266D827BBDAC2C87604D765BAC10@BN6PR06MB3266.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN6PR06MB3266;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3266;
x-forefront-prvs: 05954A7C45
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(366004)(376002)(39380400002)(346002)(396003)(199004)(189003)(2906002)(8676002)(2900100001)(186003)(54906003)(66066001)(105586002)(106356001)(77096007)(14454004)(6246003)(68736007)(86362001)(83716003)(6436002)(76176011)(81166006)(8936002)(53936002)(4326008)(6512007)(229853002)(25786009)(3660700001)(6486002)(81156014)(26005)(305945005)(7736002)(2950100002)(99286004)(33656002)(99936001)(102836004)(36756003)(316002)(6916009)(53546011)(93886005)(6116002)(478600001)(3846002)(6506007)(82746002)(97736004)(5660300001)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3266;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mPw4mIsnV+SADmxZ93RL7J3vMekjG+Wdp5V7HFw0ctIyQV1XXeGSKQWlIUuHexVi4dkrQQH9sR3hC59QMWleFIoc99jVMEqe82BDiiClYsC98C6yquKp9/iQitvVEAQVvCJqzpCzQIn6iVO0UMzGH242mc7djgDPj7queMWHgvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfb5bfe-2589-48eb-94db-08d57d468eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2018 18:27:13.6169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3266
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Feb 2018, at 19.24, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/26/2018 07:21 PM, Javier Gonzalez wrote:
>>> On 26 Feb 2018, at 19.19, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/26/2018 02:16 PM, Javier Gonz=C3=A1lez wrote:
>>>> # Changes since V2:
>>>> Apply Matias' feedback:
>>>>  - Remove generic nvm_id identify structure.
>>>>  - Do not remap capabilities (cap) to media and controlled =
capabilities
>>>>    (mccap). Instead, add a comment to prevent confusion when
>>>>    crosschecking with 2.0 spec.
>>>>  - Change maxoc and maxocpu defaults from 1 block to the max number =
of
>>>>    blocks.
>>>>  - Re-implement the generic geometry to use nvm_geo on both device =
and
>>>>    targets. Maintain nvm_common_geo to make it easier to copy the =
common
>>>>    part of the geometry (without having to overwrite =
target-specific
>>>>    fields, which is ugly and error prone). Matias, if you still =
want to
>>>>    get rid of this, we can do it.
>>>=20
>>> I do, the variables should go directly in nvm_geo. Thanks.
>> Ok. Is the rest ok with you?
> I'll go through it when the rebase is posted. Most of the patches is
> dependent on the first patch.

As it is now, it will be basically %s/geo->c.X/geo->X/g. If you can look
at the first patch now, I can put all comments in a single version more,
instead of going through one extra cycle...



--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUUX4ACgkQIX4xUKFR
nnS7UA//SC+FR9+b80VmVfi/OmtiDU2KXCIR4C9Qk5TgZyPdxgfSzqRZ5zFj5O9s
gEGpQ2sRxpejDzuYfMhkj/9osTwuFg2fvM9a6208ziR5A1R5+w6ZAMgfaNPIBXJ6
bwO7MFCDt3Pk/0ZFQ1iqRVsv+T+kXWNmH4FAVD2gvFsjETuEEzLe2dtm5TMC1eqC
dAqkDxwpDb8u1FXo5nFrGDGV3ko2kYRC6NAKPfMO0eskmxiFvrvoUutkR3UGZLEz
KBBd6IhvKNQ5KO9eqc2RnKGfeKJKzrgGT0HudPOk1wFxlG5Jq3eBfr36oDQnLDpF
9jPJC3hjpjPRFkpgHE4CdgIIXh4l2qJSHicqpe92vY7H/hhDX+lrS39D7aXUZRxv
weiskUqwiZKkVTt/DHY733DRnPqe8l1gfY0ZSFcwc59xrwyfeQQHxKVX8S7IDynS
6u0rl+q/AIsMzFSuhdX7t6qSxleMnxPLHVNokitntJYyoR6/N68bIRinc6ilJmtX
0FQhgXgs/j0geUV3CwCKkjFFHay2ZX9EU4w8b0thLlnHx+UD5ypSpXMqgc+pLI/4
+R5NzZIG4+KdvLdpW6zr/k7x2/i/UX2BDhXZtEvoQC96OQ4QxwJA7hZY4h2DRekl
SLB8PUZepVhucdrEo/h9gwL2l1BHFMOF4iAWmaAU6wERPe4B54w=
=xjFZ
-----END PGP SIGNATURE-----

--Apple-Mail=_BE59A5B0-5C13-4AC6-BDDB-7884027188C8--

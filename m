Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeBDKhq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 05:37:46 -0500
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:64032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750818AbeBDKhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 05:37:42 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Topic: [PATCH 5/5] lightnvm: pblk: refactor bad block identification
Thread-Index: AQHTmjgzfFIfrni0bUC6szzPt5VlUKONrQcAgAAGGcOAAJnagIAFxvOA
Date: Sun, 4 Feb 2018 10:37:39 +0000
Message-ID: <DEB69E27-635B-4B4F-ABA4-08BEC14B291F@cnexlabs.com>
References: <1517364411-22386-1-git-send-email-javier@cnexlabs.com>
 <1517364411-22386-5-git-send-email-javier@cnexlabs.com>
 <bdde0655-0904-0bf1-7029-51708fcff8b3@lightnvm.io>
 <F1AA3AA6-8F23-43A8-9C4C-5F684A80782C@cnexlabs.com>
 <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
In-Reply-To: <33896b20-c555-7c60-ed47-28156f4c93bf@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3571;7:AhWarNoTWEThBO+BaTkZY+H4HnSN2EtJpsdypWgRv2PeBNEcsJGI9GiLGZfd6lgSbeCBW49k6j5aWzD/xsG6ZITa1sBCOLqbJUkJoW8wWyECa95KjEhmiD/0ttGj/bYjryWePTADa0sBYnfv9c+O+q44TmhBA3RyDdKoZP4HnSgYtFGgegNXDq+MrvDfuPK3wm3+Rj6ENJfBvjuTa+SXuvyLSrO6gCPb+kqlVxPPsQF8TMohpipqJGkHO/J1l3Rr
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 0a7ed5c5-5565-42b1-5bc6-08d56bbb506b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3571;
x-ms-traffictypediagnostic: BN6PR06MB3571:
x-microsoft-antispam-prvs: <BN6PR06MB357127E50908B8255943E1C5BAFF0@BN6PR06MB3571.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3571;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3571;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39830400003)(396003)(376002)(346002)(189003)(199004)(2950100002)(6916009)(229853002)(6436002)(68736007)(3660700001)(6486002)(6512007)(53936002)(6306002)(99936001)(99286004)(5660300001)(82746002)(6246003)(4326008)(66066001)(93886005)(36756003)(106356001)(305945005)(7736002)(102836004)(26005)(53546011)(316002)(54906003)(25786009)(105586002)(76176011)(97736004)(81156014)(6506007)(77096007)(81166006)(8676002)(86362001)(186003)(8936002)(83716003)(478600001)(6116002)(14454004)(2900100001)(3846002)(3280700002)(2906002)(33656002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3571;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: v/Dyh8PTUGqDVBh3Hfc8IL4AJs3Pn0pgWqikEDyP6ODUf1NkER5nGx1EfVi+hX746mtRigZ513kBylOF+BOQAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7ed5c5-5565-42b1-5bc6-08d56bbb506b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 10:37:39.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3571
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 31 Jan 2018, at 19.24, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 01/31/2018 10:13 AM, Javier Gonzalez wrote:
>>> On 31 Jan 2018, at 16.51, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>> I have a patches abstracting this, which I think it makes it cleaner. =
I can push it next week for review. I=E2=80=99m traveling this week. (If =
you want to get a glimpse I can point you to the code).
>=20
> Yes, please do. Thanks

This is the release candidate for 2.0 support based on 4.17. I'll rebase
on top of you 2.0 support. We'll see if all changes make it to 4.17
then.

https://github.com/OpenChannelSSD/linux/tree/for-4.17/spec20

Javier

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp24nUACgkQIX4xUKFR
nnQ7LRAAtDotghsKBW/aWyeDw4WdKX9eMGcFOduPuw2Ub73JheSsGWjLA55PFHV8
WhuLhHanLrGm7NeIdckXoOaGQ05ZsHZySz5d5wx9SY4pPKo2p8ZSKRa8CNyXhzdk
RFpx5M5ZGaDMBruIWdRUh3aYaZKJEAubQobi2cEFC0DAJr9xA2I8Hmx7qYzgth7k
2QvHytDU1lcurYUp88JQ6VV3g42Loayy5lUI+M+rvlCuJcIuebz4LWF7XHRrmsei
8SJGg6nZzist5XymmrlaLrACEt28QG9yztcZpbG0MWO2UrOGwk+M+bptn9PCFzbC
7cTBvOMemcjeg1i3qnPRcNMiv5P1LOt77xy1cxwVF7tBrhSBxGvgEZv1v+X3Bcg5
63vc7BhnupG+FqfrGhsCyIT+VUbMKqM11S2T2pBSR/o3fSII6hUSvCLazBUxExTH
1krlckrV/0j4Rnx0nTKhket///sSXcrauKyH4o5aQC7v5T5re+U+2MhtE7MUgemJ
7HCOH4re6pnCr5Wh0pAeOgqeuOIN8S24wRgUYwD5ZDdKUTaQ3ezgdG0ITUSBs0tB
MylUyZxAXRQ6fLqRKT6RgsAlgIYqfG57XnL2GkvoqJB4gBc7Q+RFSiVU3aL1Ys1S
89XXxyULKGzMFBcjUqXk3p1fSHlC/lxCuhxSRJVJjtGYSEBkwvU=
=KPSN
-----END PGP SIGNATURE-----

--Apple-Mail=_EC7FDE25-5114-4980-8254-57B37488E934--

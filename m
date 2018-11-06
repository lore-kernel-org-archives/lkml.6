Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DCBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFF20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="c08sHtXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFFF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbeKFSn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:43:29 -0500
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:46706
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJtL9aL2HWyT0IVxC5i/g2hotlKMwKR5e1GHFNaKtBM=;
 b=c08sHtXnfHXJJ4dmqE8gvZSADW7G6c6PjalXZU3lMeEKiIYqw0VTpPsa/N9AdW6wh/fPgZL6wbcESe3CzxbEOtgycWpHz7OBM0bOQcDk2eOwECfsq8OQ+WcqExzdQBLsudfvfxCecGXBol39dUxe7UqANNoCpnq8hur6lc2K2Lg=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB5273.namprd06.prod.outlook.com (20.178.26.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Tue, 6 Nov 2018 09:18:28 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::b431:67ba:743b:ed1d]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::b431:67ba:743b:ed1d%3]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 09:18:27 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 0/7] PBLK Bugfixes and cleanups
Thread-Topic: [PATCH v2 0/7] PBLK Bugfixes and cleanups
Thread-Index: AQHUdQLRTryPhqbUuk+NdDNoReSN3qVCeVIA
Date:   Tue, 6 Nov 2018 09:18:27 +0000
Message-ID: <6DE4756E-A324-49B0-A588-1B2F74ABC789@cnexlabs.com>
References: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
In-Reply-To: <20181105122610.1555-1-hans.ml.holmberg@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB5273;6:NsQaAoHGeTaaBpz8G44Xn6J/laGsYduOvNbcQYwIpMI0Uw1uuHOqbgIT5RYPjgdc8PqCcJShi78IC/he/8PQcT8tiBEWS+n+ENnv5qyQMvx6mG0tBcDrZRFqvbjLoilm2O2p1opyO20bo9/GuHk5eIYlbbRU4lW1FS26/VSLGdrVCsmyEY6b+Gc3J1kygBSbtMTwIaBXQuFMUS76bzDYGHLkNG+munS384vXXS/hIrPUzsgHf/oCWJaZRoF9XSVORHSiCW5mzge9Hfkp0xZDedVXDZ9v6U/WuR+Zk4WyLoyqCJMhdzRVBsCkd5FO8xIqUj4v0l/EiqEWxVyDBti8/Gt/XrdT66Y5Q1Nklkn2PZcqSJLCNwTIBsIf1kZcTxrO1gKHwjoepHEQvwug7/dZzx04Ex0LaX2LtOWf/f3pYCzxEXjrIWu8nVvPnxqfems1aKJlTxafttwN4dkRo/kAkA==;5:aqO3MEaTAFx5sO2S7VmmFbRIp9bMAtjKS1DPwT9UbJSow9ltXLVTyzY3DSQ9C71zn+tlupId33IoTLML5AQ1XNuPP3NQlnjbMmvI6Cz2x2j02EYgbjVMHbJk5ttQ+U5NkIClgMTceH9R9VeCuZ5CObr+zC7WJQsuzpv0HLRddMY=;7:7sS1mqo4OK8gEiJUa68YU2WcGlO5QdPmOg6NpulTsiTBjTeJkjxOr9pHWKFluUQGK9dYCUaYgohrpsHycds3/AkEK16mRILuf6BICJGRWqC4bsgg/R4T/BB4u9YhDRW0UfqgIFvErOV+a8yhZRO6jw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(39840400004)(396003)(189003)(199004)(106356001)(97736004)(36756003)(2900100001)(107886003)(53936002)(68736007)(6486002)(6436002)(6246003)(99936001)(2906002)(105586002)(6506007)(2616005)(102836004)(26005)(11346002)(82746002)(14444005)(256004)(476003)(186003)(446003)(486006)(25786009)(76176011)(66574009)(229853002)(6916009)(4326008)(14454004)(83716004)(71190400001)(71200400001)(86362001)(6512007)(54906003)(99286004)(5660300001)(81156014)(81166006)(8936002)(305945005)(8676002)(7736002)(66066001)(478600001)(33656002)(3846002)(6116002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB5273;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: d4e1e112-08f8-4303-50f0-08d643c8cfb7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB5273;
x-ms-traffictypediagnostic: DM6PR06MB5273:
x-microsoft-antispam-prvs: <DM6PR06MB5273A5CE128B60589AB87928BACB0@DM6PR06MB5273.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(4983020)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB5273;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB5273;
x-forefront-prvs: 0848C1A6AA
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2o85/Z7dixPut1ALKP6p4SMiHBP0WYiBTCVE0/WbOndtJWaRH2ZyUKkCkrorAJcP+VwcZYRXVZwaq2Uxh8WkJCcvDsgP1V48dWFfN8XBTdEVtLmT5GL2hkgZLjQVKYc6xPfo4mzTG3HIadnbVeiV9cww89zGo9iJJt0tlJ4Y4crYhsHbsv3IWlf9b7X3RUqSIRMJGVn6aDdYHt7X9WIvI7hqxkzuQKMgysaTsUkCWRs2dc0bddJ/RwgCWCNdRUwmsTj9tzDxoZ2fWHK/y1fbIDlGkqJXs9S8HZtWj+y85meLJyu6Ah6xqxPIQccp3wdQ8IUHuJlIb7nZNjQWSs0lc6g0EYZ3q6M6y9PbbWW2Ojw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e1e112-08f8-4303-50f0-08d643c8cfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:18:27.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5273
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Nov 2018, at 13.26, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> This series is a slew of bugfixes and cleanups for PBLK, mostly
> fixing issues found during corner-case testing in QEMU.
>=20
> Changes since v1:
> 	Messed up from:, now the patches apply with the correct author
> 	Pardon the mess.
>=20
> Hans Holmberg (7):
>  lightnvm: pblk: fix resubmission of overwritten write err lbas
>  lightnvm: pblk: account for write error sectors in emeta
>  lightnvm: pblk: stop writes gracefully when running out of lines
>  lightnvm: pblk: set conservative threshold for user writes
>  lightnvm: pblk: remove unused macro
>  lightnvm: pblk: fix pblk_lines_init error handling path
>  lightnvm: pblk: remove dead code in pblk_recov_l2p
>=20
> drivers/lightnvm/pblk-init.c     | 48 +++++++++++++++++-----------
> drivers/lightnvm/pblk-map.c      | 47 ++++++++++++++++-----------
> drivers/lightnvm/pblk-recovery.c |  1 -
> drivers/lightnvm/pblk-rl.c       |  5 ++-
> drivers/lightnvm/pblk-write.c    | 55 +++++++++++++++++++++++---------
> drivers/lightnvm/pblk.h          | 16 ++++++++--
> 6 files changed, 114 insertions(+), 58 deletions(-)
>=20
> --
> 2.17.1


Apart from the nipticks pointed out in V2, the series look good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlvhXGIACgkQIX4xUKFR
nnQ/8A/+M+VmnsElaf0iNgADIAcKQT3tikUQJhgkPqX6L9djAZ9qhV37LYxwVy3D
+ynl4lMsN16fXxM3V1bgxdMtIOgX4+fxZRvoyuyoLLJ9zyjbIwKVTRcmALsaXqRA
rsCg2bv3ixowzx+8569Niwt3PVfYFD9AXGVbXpSTjhZS24y7K6bzPcO1a4stG4tY
O7ZKTxTERCG2aYea9/Ai+Irr8vnJbLc7oMMdTqTLwKiNC24IwHTco5QtL3r9DRyv
YRA2q9PzE9H1A4giV0GlNUF1ydAtRAN0F9FjZaY6aVCN7dPB7YyQNC46qbkWkrhC
l6Ai2hhvHbrz1XbxBs6+CRxta5ZxICD5UncMDofdac7UTKDLFUKTdJy+wNOnmbBU
DDWiTOZQcO7lbkspsjgvee+cuO9x5bnMfMSIlMNxQ2NZWpxqByd6YE6csei8o9MB
gOEzv8TS/Ui0uIsgxpN2NA1+6uFGCRpd2y3gWleoZ+EfFISMjDYvt25G+RFDt4TD
ew9QrAp97fzbgoOFvENUeIqY7O8RoqmD3jvedO6SFiyNVg/bEJ2avSLVUyZnHXBr
rEzPYak5j7jKghi8LQO1hGn3UloBaGMl/nvuyRddl5CqnBOLwoSfbdX8S3FxoCd2
iWAglKa2wh5d7BpmesGhRjbJuYLWeM3LpqiyjyTSP19f2CCqMQU=
=RZMJ
-----END PGP SIGNATURE-----

--Apple-Mail=_008BA30E-FCD7-482D-939C-3A8D6488B67C--

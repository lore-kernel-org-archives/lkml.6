Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F22C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739502084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="rp4wh9E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739502084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeH2R0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:26:24 -0400
Received: from mail-eopbgr690082.outbound.protection.outlook.com ([40.107.69.82]:40736
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2R0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWjshQIGPHOlte7Q/6A+h+zlEY4vfhs31aiST06ga8s=;
 b=rp4wh9E7gNP8YE88Z0T5sxfdQYG7XWYon/4Hs/M4T29EYsgKc1aOLiDkDI9rUPVGxh5++WQN4ifu11u1VK9DLBR+zr5pMuizIDeeYJknm8pUh/HLioK/yuxKIEszLPEYs1HQuNz6nngX53RWpJ4RHqa+TAmnX5m35iaAoCtdJwU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB474.namprd06.prod.outlook.com (10.141.197.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 13:27:43 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 13:27:43 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Thread-Topic: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Thread-Index: AQHUP3b0c02+jLolfUKSPiOQdz1hBKTWtYWAgAADrIA=
Date:   Wed, 29 Aug 2018 13:27:43 +0000
Message-ID: <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
In-Reply-To: <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB474;6:83Sv4u3Qlmd4f5FLmK0z9VDTlGiVbEPcLH83cId5jmJkg22hRpG3i7OROz1Qf/f6NdKZBndoU7ulwmBY8smsWFRsaNREvjJJDRdvDlc81LM7limUdwTG7IXaZy0IGuc28KK1DRJFODqh7EcJRNH3S0dfoEaaw12zhdhewZ3PcWSYLyudUd6bCnkoDXEhSoV76mHjqpAWbowug1KL+soVfNLvHpy/CVZEwtHafD0gFHJkF2upqbRoi9Y5QNUrehKeacy8ZSnvmOAnhrUx3YVzvTtD+gRQa3VcV9nloqQvl8QgLhOOeE1/vBd/uxcSvbrTVTFGkS/wHheG2yk9Of1KmmJoFt7tozccT1/l1YEvX1ZbZYexBEs2/o8H5KgUjniLIarCEnYm3lTxYasDxUGhA51EuxKDsuMvHDwz+xim/LRNOGWgZBnRY9T0SDZI2I9aUyUgoEgSfz+B3739lIYTQw==;5:ma2cUkNycYr0XpqxBWa9bnL24d5e1thGBw/DJzf2duR/n0nvthw7pumltIz0FYa6omRnn1BbThyqr/jWKMylcsNNF19c/88SpmNxMRNWoK0xL6HPreUIY5xsKumHtmzERffXJHFQdpxKmr3HLC/JJYQQ/UmsQPXbi1CP34TjCH0=;7:ErCudzW80fK02FSrJxV4Ejjtrrz+S2XqA010TmzuoFURqQkMvMjHBjRyp7DVaG76OvqTAhIE9Q5SbD7Sb0goHi3lrSaeSsJp/tEy8x51Rd2bhgulyvWg4ZHvwI0SB7ZPzI9ciXkCQJWoJoHl3gvbxw91GGDqe3OoaxlJ93/ssAza5XKvW1/6F5JNKrpCRlS0PUmOe02f/K/7G5nEJWvoLL3uWDKtq9NbFQ/6tAGxOfsuyjA9MjmgjVReWwLuzGFD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0464ef79-f118-4b87-9081-08d60db333c1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB474;
x-ms-traffictypediagnostic: CO2PR06MB474:
x-microsoft-antispam-prvs: <CO2PR06MB4748B5923A30F06E8EAA50ABA090@CO2PR06MB474.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699016);SRVR:CO2PR06MB474;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB474;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39840400004)(199004)(189003)(66066001)(256004)(14444005)(5250100002)(14454004)(6246003)(97736004)(4326008)(81156014)(81166006)(486006)(82746002)(186003)(8676002)(478600001)(25786009)(2900100001)(476003)(2616005)(26005)(11346002)(7736002)(86362001)(8936002)(316002)(54906003)(6916009)(83716003)(33656002)(5660300001)(6116002)(102836004)(305945005)(446003)(76176011)(6506007)(53546011)(36756003)(105586002)(53936002)(6486002)(99286004)(99936001)(229853002)(68736007)(2906002)(6436002)(106356001)(6512007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB474;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kYpU7PqtZRbZdU+ReRr0VhCManvj02jm6WpiLHZo2Ms2zMXLas0g4N2THeiP1RKXtf0EwfMBuexDXagrYfujGdT3nkEKOoi6JkcGvib6sd3AsHCRV3qNeSMU7JBepvEreZw/D79P7/kUcE4VLTWSIj+7A9JK/POaQ7VhfenAr1cM8/dC00nljFtpIx/K4lQvXu4clTcNl4zuHofHR3ylwtPGGXA6LtasKewNgPT23fsUIgzKlRrCSu7eM1cr4mNAnhOgt0m12dG9TGyICln1YxAf/CRHtxmODaC/f9ttarYuoVlRv7LVQFE77um99kwlRqATB/dk75K6Q3dW1Bl9Z0T3SDAjsT92YbJc6S8GTjw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0464ef79-f118-4b87-9081-08d60db333c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 13:27:43.6833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 11:01 AM, Javier Gonz=C3=A1lez wrote:
>> Collection of small helper function fixes, removal of unused =
variables
>> and comment typos.
>> Javier Gonz=C3=A1lez (4):
>>   lightnvm: pblk: calculate line pad distance in helper
>>   lightnvm: pblk: fix comment typo
>>   lightnvm: pblk: remove unused variable.
>>   lightnvm: pblk: guarantee emeta on line close
>>  drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>>  drivers/lightnvm/pblk-recovery.c |  2 --
>>  drivers/lightnvm/pblk-write.c    |  2 +-
>>  drivers/lightnvm/pblk.h          |  6 +++---
>>  4 files changed, 15 insertions(+), 8 deletions(-)
>=20
> Thanks. Applied 2-4. The pad distance does not compile due to missing
> update to pblk_pad_distance call from pblk-recovery.c.
>=20
> Also, it looks like pblk-recovery.c is the only user. Please consider
> moving it the function from pblk.h to pblk-recovery.c

I reordered to send the helpers, but you can see that all these are made
to support.

  lightnvm: pblk: recover open lines on 2.0 devices

Can you fix this directly and apply 1 too? I'm fine with moving it to
pblk-recovery.c. The patch above will use it.

Thanks,
Javier

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGn00ACgkQIX4xUKFR
nnT4thAApVuQbg0NYTAdvAG5Czzb4phHk/sIF/RkKyGnPD25rcBGya/N2GwQSmUP
EEY02R2dTclNsdqu8uqevSM9e/1o5uymcIn367m1uU6rsJDL9sU0d3bxyIKgdEmD
BuQ+0kPwu9eKOVPYi44km/fKrDNPRrBbV8WBWtdQQR0zRYr/Yyej/ut5SglsMRyL
Wck0pxSV2xRZcOt7OclrH/I1ALsPaawbAXDbPfgukP21sHFL5O8m6AStwPrXfcAu
axO4/WzMQxs7hjpLZFeyCMavwvMGGNYT0dz8b+3nTaajVjdUDyXM+ngvtL7RLjC0
C2yvpuDa6KTPAM6EIkR+NHwtnQwtQqXNPLAK8dBfnEUqoF10cC4bcv03InnGn7ZK
vhKovfnxPPTz4mUGO/mlPIIUmeTdzFS6KAHJSfodCUCkdKDiXGIl+IPGpUv1eIE2
d6X6EnCWBwt3CCP6tV44qL1dYHVoFEHWhFsAeS7KaXIMInNlK7Bc9GbuucxW141w
bOU2LUAacth+pciWBFp4jAxMGXRNVHWupexgUNavGAVmLBuLWfQ/8LSYQx5uNT0R
WcFg+KAeoHgGch+gHBGkvTigmIm6DlOiLoXPZwaynBKp6XuXcJoBlEXm5hDDFS9U
heEaYWGU/jtYhcRJQwhWcmpJmJb1wFVeHUSpz6Kzc+RsC+Gmaxg=
=6qew
-----END PGP SIGNATURE-----

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146--

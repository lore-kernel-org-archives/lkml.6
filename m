Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25DC267EA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="FxzpeRSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25DC267EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbeFZJhj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:37:39 -0400
Received: from mail-eopbgr720056.outbound.protection.outlook.com ([40.107.72.56]:23802
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933189AbeFZJhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swMCK2lEHalQFxD1hvIrLxYDCq2mS4ctvksmt5mwcjU=;
 b=FxzpeRSOxwlw/QgQdAgPCKCB4QY3LwEvedPetk0iqrc+lW2uyiehpnWMHrlBSzye7ABOcrnKvKggIggmZerbw+KMrTgLVM37n0XuFZ4lr+pFG/6tcgDumXU30Wq4BZ2htSg/1wVkThn8tHE3mNx5TCF3ZBwIJ1ESH+4jTeIElEk=
Received: from DM2PR06MB544.namprd06.prod.outlook.com (10.141.157.151) by
 DM2PR06MB464.namprd06.prod.outlook.com (10.141.158.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Tue, 26 Jun 2018 09:37:34 +0000
Received: from DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::45a7:a991:6196:1e6c]) by DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::45a7:a991:6196:1e6c%2]) with mapi id 15.20.0884.025; Tue, 26 Jun 2018
 09:37:33 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "hans.ml.holmberg@owltronix.com" <hans.ml.holmberg@owltronix.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Thread-Topic: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
Thread-Index: AQHUB6z6kgqdJ8jhqk2jGNQq1yO9haRyQ7cAgAAPiQA=
Date:   Tue, 26 Jun 2018 09:37:33 +0000
Message-ID: <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
In-Reply-To: <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [77.241.142.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR06MB464;7:qa04yNvjkVHcsUxjuRdrvGUdQvoD+Z45pcZb26VM25t1yFh1/RQ4Q+srGOLMzNgFPpU+ILnSjzHc7pFM0gy2VqwqDoiYrT4+7xYDfPRTnNjmooWTLykuaCz/UgAjACL1VBlCmd7ZnLtW+90A5GHLMVbELwSrsTj7zcnt1XwmzFtw/hpps+msal3C99DFEB5l5QegYdAO7ex4wQyTkv/uVu/7Ep9eDtia2z13obdzfNcykmiukdl7aDg8Sf4HJvI1
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39840400004)(366004)(136003)(396003)(189003)(199004)(99936001)(105586002)(83716003)(5660300001)(6916009)(106356001)(2900100001)(25786009)(4326008)(256004)(97736004)(6436002)(14444005)(107886003)(6246003)(86362001)(14454004)(6116002)(3846002)(53936002)(229853002)(6512007)(6486002)(476003)(76176011)(68736007)(26005)(186003)(6506007)(53546011)(2906002)(102836004)(478600001)(486006)(446003)(11346002)(2616005)(7736002)(82746002)(54906003)(316002)(305945005)(66066001)(5250100002)(8936002)(33656002)(99286004)(8676002)(81166006)(36756003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR06MB464;H:DM2PR06MB544.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f41e230f-821b-47d0-a143-08d5db4871cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM2PR06MB464;
x-ms-traffictypediagnostic: DM2PR06MB464:
x-microsoft-antispam-prvs: <DM2PR06MB464E3267B4C4D475A1C4737BA490@DM2PR06MB464.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR06MB464;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB464;
x-forefront-prvs: 071518EF63
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZlLbs2gENbFLz0XyERirXvquUQs2HQ07r3SPXLGMnOH/dE8iISMYOsxZb3XEZK+31uwJBFk2pHeYtEJZDPEN9FrrJyfsSvoTPbUcoiYunh7jpWyXRxEAflT1NInpvUA6UHfr4kvXQGJFe9kc/cTttV+t58wKGXs/opVoM9lNO7Xj5W2D2U7jsfAeXoNMcpgKVeFO6plNg+KNzYV14H42dg4ah97KdTMI7YMbvj4xmr8IIT31ffEfnVBBrE0vOYtZUcx+QE5FqqlY1cp9AH/z5GfgF1KPtTRILYeBm2soit+qJd7eJo/Sztut07rrmjMIqNvLeET9DV1CeT5FxhULbwMaEeEs/fEFkJoVLb81fN4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41e230f-821b-47d0-a143-08d5db4871cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2018 09:37:33.5310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 26 Jun 2018, at 10.41, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> We can't know if a block is closed or not on 1.2 devices, so assume
>> closed state to make sure that blocks are erased before writing.
>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report =
chunk")
>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>> ---
>> This patch applies on:
>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>  drivers/lightnvm/pblk-init.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
>> index aa24264..3b8aa4a 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk =
*pblk, struct pblk_line *line,
>>    		/*
>>  		 * In 1.2 spec. chunk state is not persisted by the =
device. Thus
>> -		 * some of the values are reset each time pblk is =
instantiated.
>> +		 * some of the values are reset each time pblk is =
instantiated,
>> +		 * so we have to assume that the block is closed.
>>  		 */
>>  		if (lun_bb_meta[line->id] =3D=3D NVM_BLK_T_FREE)
>> -			chunk->state =3D  NVM_CHK_ST_FREE;
>> +			chunk->state =3D  NVM_CHK_ST_CLOSED;
>>  		else
>>  			chunk->state =3D NVM_CHK_ST_OFFLINE;
>>=20
>=20
> pblk should scan (or the lightnvm subsystem) the blocks for their
> state, such that it doesn't have to reinitialize a full drive if it is
> already in a closed state. If marking closed, it does a full erase
> cycle on initialization, which should be avoided since it is a limited
> resource.

In 1.2 there is no such state unfortunately. However, pblk will never
attempt to reinitialize the whole drive - metadata for closed blocks
will be recovered and only those going to GC will be erased before
usage. In fact, a full close drive is the state pblk expects.

This patch only affects "unknown blocks", thus the only case in which
pblk would attempt to double erase is when blocks have been pre-erased
(e.g., factory or through liblightnvm). After an erase round though,
pblk will only erase pre-usage. One thing we could do is attempting to
read the first page of these unknown blocks and mark them as free if
"empty page" is returned. Is this what you mean? Note that this can be
costly on large drives; this is the reason we returned to the pre-2.0
behaviour with this patch. We are implementing a log that, among other
things, keeps the state so that pblk can have an accurate state for the
cases this can be a problem.

Javier

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsyCVoACgkQIX4xUKFR
nnRs8A/+NlK7hPfhxlTp/bzfgVEX6M8kNhygjz5EWpr6gkBIyd14V0yTaCPqMtUi
seUoIMqNTyF71Pyi/CXz886p0fHkYBODl4xF/uPHXia3YliVFFq4aeMetIlNoUWc
jVGdMOsdEXIy9NRETbv5B5wJ1IQf65fcV7mA1C0Ikd9Y2PKlx2xRJRPgeAv1Blnu
QFZTeKDJEKF6jrI09apdJsvp9qr0dBcGJ/amt6GQh/wVIekvjeqxLMwaDay7S4iJ
mpBcLp+bnwaKUw++vYpHlkFilYRz6jundzbUlgtolf/yITAmzDYii9ODVVn7wVuU
t0t7jAPp9L+VCYtXBFnhhA3znM8YsH5xlBnHOPYRWKfrBNcEZMYB4SUepjg8KQv5
8o1eWjxnxffaUR/ASXsTMfq/zLEoogamdxcdcScFTKBFvly1vtURdct0GAxTR3vw
Bv+eAkDOSF+GiVs24ws7fyA1o+O3ExArioSb8x50+OsJWx7l84lwB3g+dkC0VbEq
YWA087nFuF4SLbuTgZAzX3qFohnGwzWuTy3sJ2GWtDQMbEeD6V05gFhLInsp+yzX
8b4eKy4hEY+Uf3S8GKx4pg3Gth4RmilThgODYWS54z000DJQsHftz+tFRdKsnfp+
uaG+PIxkymJj4RkwOGK+gG3W1OOp/SH+NykEPs+beBHoEI6+OsM=
=lXkH
-----END PGP SIGNATURE-----

--Apple-Mail=_15C8F904-66A1-4CA9-911F-E01FFC596A9A--

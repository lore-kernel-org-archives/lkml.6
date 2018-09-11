Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED23C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BF520839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="mAu553FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BF520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIKNsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:48:50 -0400
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:17821
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeIKNsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/19UlkRBH+B3QWNvZX5Mp2Kdmn4xvld86UinhguqrI=;
 b=mAu553FMuKRz7E8rNEDMprA/mCDphEzx6NvV5S9U91phx4vJQ45MlgETn1ubag9E5Z4XSfYGhfZhmjYo9tv2W3WaTldriEDLvjoH/NH1er21DWoiYLNqT2+oWP2HuKTsXYgO+i+MPfnZOuZoW4Wg4khuCsjkRrlCikXNWtQIYLI=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB906.namprd06.prod.outlook.com (10.141.228.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Tue, 11 Sep 2018 08:50:16 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1101.016; Tue, 11 Sep 2018
 08:50:15 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Thread-Topic: [PATCH 2/3] lightnvm: do no update csecs and sos on 1.2
Thread-Index: AQHUP4BwZTm1hVjhZEOpHx2Evg7pOqTkrA2AgAYt2AA=
Date:   Tue, 11 Sep 2018 08:50:15 +0000
Message-ID: <7493E737-A7F5-4F86-A91D-8BA01755714D@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-3-git-send-email-javier@cnexlabs.com>
 <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
In-Reply-To: <4ac29eb8-65bf-f733-d196-80c5bb41876c@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB906;6:1Zr+eQf78gbj1yZJCBfywpmSJ/K42CrqKhm0byZ5gNHk/naPckPEyJzgBPxli+dH7zZRz/jxkwm/cIYf6hRKsoKnYi57HroY3uzIQDbO5j2GQoDWEgrlZ4f2voYXA84Tao+XjYMO2tLeX4fA9Y39rY+w84RcPzdAewiVl7zCV/79gakKzVTPP1qZjyhDwMJyXf/jBbIsDVdvnKolFaeRCM+UIVA3Fy2fyT9ulnBMEPiy9wpAN04tHcsUl6n9RFTmZBaI5OXt1EdlT3UQgEdgVW2pmKlfwSoxW/9AAitdWF/wZA7uFMEUV8H7a2nZOozGJFi1cuf/CqkLF7sUyolupUMguXQGdlFEJOiq8tZe90Bvw33LK4yoJhAFTZ3LnGcLsmH1qb5SAae05c5F2q3SLKo3qtqPQB8CxHJeutyhFra4Sot8Atra/wtaxN/U/5KqZwSxQpVuDWavuEz4kLoIdw==;5:aqtyJmx0CPX9tkd01A1/35yALMa4sK0Xh4lySCbYNsaDXwMgY15CuodBsrn20U8shNRmfyl55ZQwWmrT0Rn0P08O2K7nwfj4df0G76bzljbd5OhT63cTFHFDuR4WcB4fxBNcZqaRV6nXEVzgcqM6j6Nvo0gANxZGany32zWKfGU=;7:b4ybOP8NFuSGM3pTYHQm4aNXaZ6EZHFFXv3DYpR8ROreJEjh95Nkk9O7oyhqfM+sSAO7nioGoN0fTokosvwyawKFnSxYLyUzYGi3Q1MUibSJP9DEaoUHTZ5Df9ylfCY2SJAQvW5Fzg3OHNytk0EqYsUrVc3KCLh0Vw3CANZ3/r5DF6IQgu9tnK5jP8ubdhe0VUVQXW8tR9BQL/ufhVZM0s9UQTMffcLyoprJ/DKl7VRcmPAwVMNpqB37mVJHT81f
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 23b6f88d-1c9d-4876-5dd5-08d617c39823
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB906;
x-ms-traffictypediagnostic: CO2PR06MB906:
x-microsoft-antispam-prvs: <CO2PR06MB906C4788EBC9A483CF9948FBA040@CO2PR06MB906.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:CO2PR06MB906;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB906;
x-forefront-prvs: 0792DBEAD0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39840400004)(189003)(199004)(4326008)(5660300001)(76176011)(53546011)(102836004)(6506007)(7736002)(305945005)(6916009)(25786009)(6246003)(2616005)(2900100001)(33656002)(82746002)(476003)(26005)(486006)(186003)(478600001)(53936002)(6512007)(446003)(11346002)(83716003)(3846002)(8936002)(8676002)(81166006)(5250100002)(14454004)(229853002)(81156014)(6486002)(68736007)(15650500001)(99936001)(54906003)(6436002)(66066001)(99286004)(6116002)(86362001)(2906002)(97736004)(316002)(106356001)(105586002)(36756003)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB906;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0ErDZxCrS2H5zvpqp0OpMHd6IVr0jV5FyyPWapD5CYNBae+HAAsxMZU7Bz54z7gHiPhc/er4ZzNE1cIh7ZBrNYE+HTEdgQ6ao0G+r/GJ5ecEWGlNdWH1cTgpuB3faPVn8iC5UWJs26px83+vE86vipX2LZjHbtffUzE4I6S4OwhQ6RaG70ukgf+wetFT1xKJTRm4ggDMFjAzaT3JxQitoz9luh7hNbbm17B83JxhtHr+0XzRL3+6pIAoUc3zNkQFjo/7SHb9+kI+0rkCgwcm9gBGf6jhQBBPV3VnikuZJ8L9Zv9ttQOw+g0dFoubDf8GQ1G/h75pg2SjHgrcon4FHGggf8GSyt0IgvmU0V2iIi0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b6f88d-1c9d-4876-5dd5-08d617c39823
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2018 08:50:15.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB906
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 7 Sep 2018, at 12.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 12:09 PM, Javier Gonz=C3=A1lez wrote:
>> In the OCSSD 2.0 spec., the sector and metadata sizes are reported =
though
>> the standard nvme identify command. Thus, the lightnvm subsystem =
needs
>> to update this information on the geometry structure on bootup.
>> Since 1.2 devices report these values on the OCSSD geometry identify,
>> avoid this update is it is unnecessary and can also corrupt the =
geometry
>> if the devices does not report the nvme sizes correctly (which is not
>> required by the OCSSD 1.2 spec either) >
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 5bfa354c5dd5..33ed09f8410e 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -980,6 +980,9 @@ void nvme_nvm_update_nvm_info(struct nvme_ns *ns)
>>  	struct nvm_dev *ndev =3D ns->ndev;
>>  	struct nvm_geo *geo =3D &ndev->geo;
>>  +	if (geo->version =3D=3D NVM_OCSSD_SPEC_12)
>> +		return;
>=20
> The lba format sizes are not explicit in 2.0 either. For a conforming =
drive, it should implement the NVM Command Set and expose the LBA format =
correctly. Although, I do get your incentive, and if it is okay with =
you, I'll reword the commit message to this and apply it?:
>=20
> "1.2 devices exposes their data and metadata size through the separate
> identify command. Make sure that the NVMe LBA format does not override
> these values."
>=20

Sounds good. I'll resend either way as I rebased on top of for-4.20/core
- you can change the commit as you think it suits.

Javier

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluXgcQACgkQIX4xUKFR
nnS1QRAAp9vhDsE8e4vNrjXa8GQlK6rrGLNb+P/7edeAbsRbQynhaWMLwaFBgkW2
sUE5ooCszzbZc4YneyRAzsgmSddnU7DrRlnH24Cc5ExnNvqPTLZG5Qz6dCrwbvMZ
dy51Y1cjhiymcpYH9mXBAiz4fzj+ZNx9Rbyr7NqLm2QAe8oVSvVQwoOJuuk4JEB/
p95KEJRdl2deKl5e4b2+7MqTQlQV5j6TWPOsY2jRd8kKXKfzxIH91TuGAmG4AgU5
/pV3i67+qcCFYHSSRsl0rsykZageIcVHm7cLWx35dFwRt0Xjd+lVZRrEFEcyrDaD
th/FlzygQuuikEcG+fpNGvi3RosJcTTxDMqIYz2rKePZ3pnYLXfI96Ll6do6C5Vh
nYmZ5s7eS0M7X1LoPcBq7zcSz4JnzFLgrmBu+KX4Isp9elLtJDJO6zBztDNaeuOW
yZDVxjW6GWfx4OM5msV32RB8ehEnKdIc32uSFQ4o4eMShtGpwXy93H1Bu0h+/TeK
b0IZp7KvUyGyQJrlkal2yQXSv+BijPKPgSZ1HZUpM/JYNT7GUHL+Ef2F+6IyvBoU
IjNfLvmMEIx/H9ypgXkUItPSbKnqw8FWmWszuqbrMoX7bwSroLthApwYKiImWamG
+dMzmQ+P9NdZw003K5cGCin64CoiQo2Lou/9c844kR+rzN5CRs0=
=WQLW
-----END PGP SIGNATURE-----

--Apple-Mail=_0CFEC981-5C7B-4091-A588-A47E99D88670--

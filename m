Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17221C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F7D2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="T+6X9Rzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F7D2175E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbeHCOOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:14:51 -0400
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:31325
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727148AbeHCOOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJJAfvuLUtnQLmXqF+I/cUkfL8TAhfmJV5mG/AaKJa8=;
 b=T+6X9RzilTrcWFj6OII4OAle/ezqbAH262ik5I63BzQ3G6gngP+bYQtPuFcWpPhzcFbj9bdLhYm5GOhWN0RjqKqoaW8Ip5zFEycia0fz6e9eFpj80hMSXq6yDKbrU7snuZQZMQOTq+YjjgzkUYyEfBME3MiWWw0+LyzZP0kLkgY=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB635.namprd06.prod.outlook.com (10.141.228.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 12:18:30 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::311c:7e3f:3043:5287%8]) with mapi id 15.20.1017.010; Fri, 3 Aug 2018
 12:18:29 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Thread-Topic: [PATCH] lightnvm: pblk: remove unnecessary drive version check
Thread-Index: AQHUKqOqJvYCHWb7506nHMv0DcNCh6St8uCA
Date:   Fri, 3 Aug 2018 12:18:29 +0000
Message-ID: <4382FFAE-0602-4A16-8120-E930141606ED@cnexlabs.com>
References: <20180802205841.22039-1-mb@lightnvm.io>
In-Reply-To: <20180802205841.22039-1-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB635;6:9WM5KDMU9iSJmme1DPU9SenMhMBT0+kQX/gNpTRl5i6ewS3JgGHwbK9ko+6/g8/Y0BipM+tnpFL+NEiRmfhmn1HKL6wvR5XQeFuHY6kS+GmhGKAB+wvadxxj1HiOsSjEctwU4WU4aCbxxVmEsPOWoC5h8FSUTY4sC9SBJ3svP8Y2VihbAyuNX+UGM1BpRivMiaIck8hYexyK6TE/T4On3wAaWeNUP06lqy/eG4MzmguHe/2tIn37ZquRPpIfc6ghemBF/77uvS4grJDLf3DqLr2oQU8yDRS0lQhTOlhbfJ5/W3xz4/oPqgUP7EyDSgQS5wW3VxELpxDQrOjebmwaLXx0F529ZMHFZErJLkNdqY2Kv+gyVfJTWzhd+pRkEdgzvu6+Y8Tkg3fIb5/Fdg3aj7ajArEBwqmbKjrybZ4wCC3cWKweOXBIolz/ur/c2+ndbkzmwmHAVgARaDUxKIv/OQ==;5:u5gLZYSUaxlO8+ZkcWguIQk0DHPTrobqYQ4abv+hiyP64cmMxeTKBKn+hWzOU2N9JFe4uV44tBRjbMKZxitU3NGuVWQJn8RQDYDJGly9eZJirAiBvCrCLB4IQ+AtDM8cJHaoJESnanvESsS3YBofaNPl0bMQs6DcGQLvfSPDvMo=;7:QN5h8wXdcy0QkDP4nJlp/8tx79w2OMgb3DKZBwa0jh8AwHPGjbQnPKuB3y24U0+/js0wJ2fXDQk+AihW8sEk38lLBErRcM0mAhchvyP0ME0LscNHEugDPMSd7No8LeHTnSD0REvbAf9GJfSeGw136e5roDozwgBiXjjlZjZKQjlqT61MF43t+D9mCwx/UAh5d/NJSJSAbqRKNYeabRNftY7DmoiGh8TTnTBeuInaQwldW34gOy5KtH9FqgbWSrqn
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(346002)(39840400004)(366004)(376002)(396003)(189003)(199004)(51444003)(102836004)(3846002)(68736007)(6116002)(6506007)(97736004)(26005)(105586002)(186003)(8676002)(8936002)(6916009)(81166006)(81156014)(33656002)(6246003)(4326008)(478600001)(2906002)(25786009)(53936002)(36756003)(76176011)(7736002)(106356001)(6436002)(6512007)(486006)(99286004)(476003)(2616005)(2900100001)(316002)(5660300001)(305945005)(66066001)(11346002)(6486002)(54906003)(99936001)(83716003)(446003)(229853002)(86362001)(256004)(5250100002)(14454004)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB635;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 326a219e-b866-4682-5330-08d5f93b3910
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB635;
x-ms-traffictypediagnostic: CO2PR06MB635:
x-microsoft-antispam-prvs: <CO2PR06MB635B4B71D91407CBAA4A8A8BA230@CO2PR06MB635.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB635;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB635;
x-forefront-prvs: 0753EA505A
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MmVw/xcXQCcLzaEFFhwguQjPJrOTsH/eFBIwJaaUoBPDYDszWcryHEp+q1qMbuu30VOGcZSJat6rG9iQ0XVdJuS/QArGpx9VclGP0SErrL3XFhv7IHMFW9rjmZFZ5HxSAmzTKhvzvgmUB/u+SAeFlNa3O3sG4qxtVt3UgUMgsGmYTdaTA5CnMdBKCZ77wICoGIrGL5fDKMppSN2d7Y+HuSiR2IZsC7To8bDY5GLFoe5jRxbi6C6pLC+6QqlQ3rVZ7l2sgqKjAKutPZiiZ38OVBLHyTDzSMVuCd6vAxmzsCT36Khpx760UQWEHVMqaWJlrdZ+94izzMYfiTlzuRNJDVSe5xgF6ltms1pdFA+w+Cw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326a219e-b866-4682-5330-08d5f93b3910
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2018 12:18:29.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 2 Aug 2018, at 22.58, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The nvme driver checks for 1.2 and 2.0 compatibility. If an =
unsupported
> version is reported, the device will not be initialized.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c | 8 --------
> 1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index 537e98f2b24a..e9e2fedff387 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -1202,14 +1202,6 @@ static void *pblk_init(struct nvm_tgt_dev *dev, =
struct gendisk *tdisk,
> 	pblk->state =3D PBLK_STATE_RUNNING;
> 	pblk->gc.gc_enabled =3D 0;
>=20
> -	if (!(geo->version =3D=3D NVM_OCSSD_SPEC_12 ||
> -					geo->version =3D=3D =
NVM_OCSSD_SPEC_20)) {
> -		pblk_err(pblk, "OCSSD version not supported (%u)\n",
> -							geo->version);
> -		kfree(pblk);
> -		return ERR_PTR(-EINVAL);
> -	}
> -
> 	if (geo->version =3D=3D NVM_OCSSD_SPEC_12 && geo->dom & =
NVM_RSP_L2P) {
> 		pblk_err(pblk, "host-side L2P table not supported. =
(%x)\n",
> 							geo->dom);
> --
> 2.11.0

The same comment goes for this patch. pblk does support 2.0 and 1.2
today, but it is not guaranteed it will support a new revision straight
away. So I think that a check wither here or through the .capabilities I
proposed on the other patch is necessary.

Javier

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkSBEACgkQIX4xUKFR
nnQhVBAAkisfae1+/wXH0oRMNssZjaVUN9JSbo5mg1+dxwKo3tacGYyE4c1Vd43m
ZjPqY8am7NLO5hF9Vd6moz+l0T6feIQdYY17DJNY56aB+wZtszTB8uQmPmJYeLZT
kHWS0voZSDF1ILDhdvIiSPQIep7WjubVYRm7b/aSPac8iJ4yZtfSd2kpogirpK58
xrujIe1fu9VZ7ynM5sDnCbNPNzvARgehx8ow+0S06T0FinOwS+gYCTYvdi/RMycN
08yPauUrSDh9ywiycs0x/v8IK7zungHeK9kWOBP43dwDhj08vYA/TKJUgC0G8BiY
7UTGt7giuOdgrWqZi478XeweI5Qe8CwnOYMBYGbZW+H1XjLtp5U8h+FGcms+0JsI
cmaxG6mIh4YyQdVPzPr63RUOiDMt5xR2C1SroaiRXvNZsYlk6hqwOMYvvbBqiDJa
p6Cx0YAYdweTEGN4n9OiSCyhjdFa0cBuNkGAY41LBVNxeGl0RerYB/aR3tP4rRcn
0kvyWCK9ZiTGhzlBuU92C4njM8B5xFY9hzXiOmpMOa1yHgmrm6e1H1M6lIO8ToIK
gDFdkLYWedoB6/FNdWscywcZSRpKVNU8V/PUudO7VkA+NAwJjJKRBAMh5NYaxGhJ
x7A30GxDEvy+q6lNEcvQGDNKlB3QsHqboCLWO+eoAFvVyiqdGnw=
=W9X9
-----END PGP SIGNATURE-----

--Apple-Mail=_1AD2DCDC-FCD9-4104-BF12-23CFF23EA93E--

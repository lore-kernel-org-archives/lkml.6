Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1C44C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C13F208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="BQflPFnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C13F208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934130AbeFLOhp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:37:45 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:23008
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932905AbeFLOhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enNIhC4m7ah9eX/OiHH3Cx/97hJqDGtwIc4V6wyUSCE=;
 b=BQflPFnt889/IaDNDi7GKDPz/DM1CZPbdHFN22RdBQVYz9J5r1GGZNG8cXU8VidqZMTeKShr/b+RyF+MOqkz8T5K+Et660R/shCBPAK64pxErtTxonwQp1gvhMSi4BiljhXWkI/95faBpDAXvSS7s9niykNLkzQ93Cx9ViezEKw=
Received: from DM2PR06MB544.namprd06.prod.outlook.com (10.141.157.151) by
 DM2PR06MB846.namprd06.prod.outlook.com (10.141.101.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 14:37:41 +0000
Received: from DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::214e:f707:ab4d:55b1]) by DM2PR06MB544.namprd06.prod.outlook.com
 ([fe80::214e:f707:ab4d:55b1%7]) with mapi id 15.20.0841.019; Tue, 12 Jun 2018
 14:37:41 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "Hans Holmberg" <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] lightnvm: pblk: enable line minor version detection
Thread-Topic: [PATCH 2/2] lightnvm: pblk: enable line minor version detection
Thread-Index: AQHUAkCkq07DJ+B2lUiCJkAenk4w6qRcsVAA
Date:   Tue, 12 Jun 2018 14:37:41 +0000
Message-ID: <EB675E5E-C873-438F-B695-0ABA580BCF77@cnexlabs.com>
References: <20180612112918.25795-1-mb@lightnvm.io>
 <20180612112918.25795-2-mb@lightnvm.io>
In-Reply-To: <20180612112918.25795-2-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [216.243.17.15]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR06MB846;7:ZB325T4fSkbbIRlBrXm7/Ndw3fuPRtTerHqlbiDjxwMvN827TO4X+T63JJXJ+04hzJBX9+3YbQS7p7aC0sdR2znWSZPMkPweOYEfLVtbbWCbghUuU1OB5N8BcF/G22yG4S90SM8PlSwmKvMpnwBk9OY2hCAzg47WrBlO//P/cZ4tKnN8DMKnDKhzoOHgl3eGQlGFnv06QeDLHwJmkKLfG4wNBToZ5yk1LFxGX3H2yfDKWUXgks7t5ujTXHnL4k9x
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39840400004)(346002)(39380400002)(376002)(366004)(189003)(199004)(4326008)(25786009)(83716003)(53936002)(446003)(8676002)(81166006)(81156014)(6512007)(5250100002)(486006)(33656002)(6436002)(478600001)(11346002)(2906002)(476003)(3280700002)(3660700001)(6246003)(2616005)(2900100001)(5660300001)(6916009)(99286004)(6506007)(86362001)(575784001)(14454004)(316002)(186003)(54906003)(26005)(102836004)(97736004)(76176011)(3846002)(6116002)(66066001)(106356001)(105586002)(36756003)(8936002)(82746002)(6486002)(7736002)(229853002)(68736007)(99936001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR06MB846;H:DM2PR06MB544.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM2PR06MB846;
x-ms-traffictypediagnostic: DM2PR06MB846:
x-microsoft-antispam-prvs: <DM2PR06MB84662E50467D286C6955C40BA7F0@DM2PR06MB846.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM2PR06MB846;BCL:0;PCL:0;RULEID:;SRVR:DM2PR06MB846;
x-forefront-prvs: 07013D7479
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1HnwoUOUn/iHf/jBKS2iPG5VAuLpaeprqardDnHI5y7PKdT+NXJk505lVlM1DFFBzqBaiEucb4QdSkY5A0ovZY5Yjg8qYBve61hNi3WZRnzRpNdSTjfCkY+Xu57N8WVYKXncVpDCDoCr187TbnHmGhen2/FxEvaec8WOTxiJ4icqCaw+unjJ5mzzAgck71dE
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 93fd2f07-b30b-4f79-ee35-08d5d0720d84
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fd2f07-b30b-4f79-ee35-08d5d0720d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2018 14:37:41.2586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR06MB846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 12 Jun 2018, at 04.29, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> When recovering a line, an extra check was added when debugging was
> active, such that minor version where also checked. Unfortunately,
> this used the ifdef NVM_DEBUG, which is not correct.
>=20
> Instead use the proper DEBUG def, and now that it compiles, also fix
> the variable.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on =
recovery")
> ---
> drivers/lightnvm/pblk-recovery.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 598342833d0d..b1a91cb3ca4d 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -742,9 +742,10 @@ static int pblk_recov_check_line_version(struct =
pblk *pblk,
> 		return 1;
> 	}
>=20
> -#ifdef NVM_DEBUG
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> 	if (header->version_minor > EMETA_VERSION_MINOR)
> -		pr_info("pblk: newer line minor version found: %d\n", =
line_v);
> +		pr_info("pblk: newer line minor version found: %d\n",
> +				header->version_minor);
> #endif
>=20
> 	return 0;
> --
> 2.11.0

Good catch.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsf2rIACgkQIX4xUKFR
nnQ3Xw//Qbf2YhZcGXAU1rBzHloXlvozISBkSPFUgHhca33ZJ62jAYRMksjPU1J5
dUrqJ5TLuo7v0tdMtZASFha/q7W5VO3HZ18vStcaNIOPRFLlC1U6sj9NMw5tZ2Nl
WLIKhQNzgk67ayeVEUPNLL3BiiazoXJ7dOkPPHwwBgCRymcuHE8isNe7PjyDHxxd
YKC1tJZ9fG1GTv2azrWIM+zQ2WWT/8XACr73QfC6ifrxQVgHf5/RNbZLTCWJe0Tl
aYk2g4X6ZhoDveRUO0e9dvkDB6N9dXlCiaCGYTqi/T+ItGIefv27OAqmPpBlefHo
jTztn56hFBcVSp5ISX0ZU7ZS3rxL9WWUwgDrBO8RCeoKXVOGWe80FAXf2WX29oDi
v8OMCkXqlzVq8vMF9mVW/zg6lbj+5hvZsDF027JYBU3UsCAoc5lK+p8LsnORzxQ0
tX0ai2TGHRWi/Akr+yClIVeuY+5MEa8DvmYZ/kRbi/19lW8rsrNRUDSAJZpBw6RZ
vI0Fj5oj29N/RGshERwnqLw4hTiV+igpReu1VJ61FSnbg4f+g1SjWMmb3pBWGBFD
67OhIEus4fsj/BvpGl4SLOrvw9dvd0TDaWfcDvxP54xQ2+AF+umqPj6IuLVwTX9s
PtuV+A7GXDfKAnhbtR2EKss+YtFKi3kfe3bjVubutDJeGgBPoxU=
=/TSD
-----END PGP SIGNATURE-----

--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0--

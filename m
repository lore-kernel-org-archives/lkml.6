Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB92820647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cnexlabs.onmicrosoft.com header.i=@cnexlabs.onmicrosoft.com header.b="ZSH9Jl80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB92820647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeH2Xz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:55:56 -0400
Received: from mail-cys01nam02on0083.outbound.protection.outlook.com ([104.47.37.83]:20150
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2Xz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhoGBYWtSE07hfKAZPc3+l+ossDrhhYGq8iOYeHWHI8=;
 b=ZSH9Jl802ML0AMeOXr/cLJomNwWLeMQa0vEDnTHsgrnO73iLXlI15Hktu/I4s2BLe4Ie0Qlvav09N9EWxdblp/KjKtTCetAdmxr09sxcTr+kUNPj1JA3T8/3T2G1VkI7lxZdLTncJ8PI0iVzuxUWXwhc2LSNbWQAlJuQOhV3gqU=
Received: from CO2PR06MB538.namprd06.prod.outlook.com (10.141.199.23) by
 CO2PR06MB619.namprd06.prod.outlook.com (10.141.228.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 19:57:26 +0000
Received: from CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150]) by CO2PR06MB538.namprd06.prod.outlook.com
 ([fe80::2131:a303:c149:1150%3]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 19:57:26 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] lightnvm: pblk: support variable OOB size
Thread-Topic: [PATCH 0/3] lightnvm: pblk: support variable OOB size
Thread-Index: AQHUP4Buf89JhzLZRkGfGLO3MMbYTKTW0GwAgABVk4A=
Date:   Wed, 29 Aug 2018 19:57:25 +0000
Message-ID: <26B5331A-D040-4AB7-BB7C-5752A76F5515@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
In-Reply-To: <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB619;6:sBtu0NY6HIdezltqze/fY5rZORJ/sE4a3uqRazh7XM7cpdq1+XkQSrTdpwXwM5ago9UxSQQr2mIqcpBMVb64bs15+MiQu1irbbT0nsHImujfIim4MKNkwI85k+EcNS2vHgFmUVq6lEr3x9eaAt8JH7ndUxuuxlypz/4SvhrB+KeheR6opuHjbvEa/jvZLLLDq/L9MwLnEOY18Lxo2QGJBCNPkR2BFrTTVsJjRiDfKZhM806kf6qf8Q1E6xnPM89AMeYh4mbSwuwf9vKWbKveRKWRq1VGhXU2yoyGVrmSYFyhIlVXR8cTOIDqBqWg7AUjuGUJb612RHFXym98HRbaANzKmHHgjP6xCbJ857lo64TVw9ffUZ7cpj3zIb0Kyr1CABYqfRyPI+YEwaZ0C8EqxlS+xd/L0+730AamS/5FmR9zXOVFOJat/+91eIu5KEg3sCr+T9yrxcuwagea4C2Lug==;5:/ffrCwubAfiJVMBBavLa41cm1UVIsYFDJmIwweH6clxlY7zKuAB4uaAQIgN6zltqBgDGOSrLzf8qIsU4Jb9JeWDxHGVJ7FGD2sAwNAObdd00UZsseQEgFZ6cAKgKT7VVI5gwOmVWXSrNIVDrcu/qLLTJHneftwk0VKcQdOidrZY=;7:2DtZmv93YJVQkDE8zTOOeeWu5gwjrTVr+MovmXqlpafeVGhQ6oUcuhvZ8I/L1ppVRWw1LmlV9agiYGtsGIbpfevcvrN0OyfmOS5ssx26+JJAYvziTfljK8ut4f8/DoW1RNl50h6/GqKCkjv+OgAsQYvIqxD4vesLG6/7VthsCASD85uxTUqJRMSJfQpoEQ2LEgexf4ko2SlM3QNhBe0/+Gv/UxAflKSB73tq1OCy0Jk9bz8bM0WwH/pN91Z1c893
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fcf23bbd-b156-4080-14db-08d60de9a4a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB619;
x-ms-traffictypediagnostic: CO2PR06MB619:
x-microsoft-antispam-prvs: <CO2PR06MB61909F97C73E1ECD9A3EE6ABA090@CO2PR06MB619.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CO2PR06MB619;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB619;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39840400004)(199004)(189003)(81166006)(11346002)(53936002)(7736002)(82746002)(54906003)(446003)(2906002)(305945005)(4326008)(25786009)(6512007)(81156014)(66066001)(6436002)(476003)(76176011)(8676002)(86362001)(14454004)(478600001)(6486002)(99936001)(6246003)(99286004)(6506007)(6916009)(256004)(102836004)(486006)(5660300001)(53546011)(229853002)(83716003)(68736007)(33656002)(105586002)(106356001)(186003)(5250100002)(8936002)(2900100001)(26005)(6116002)(3846002)(97736004)(2616005)(36756003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB619;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: slMIgbMIocM43IUx3RKlLehPfyudNzzUSG37dEEzRn80q2LdwamV0bWuNVsZU0jPEqkHN/SQV3ogA/6kfoaYbIM5c7xeuSX7V4LTuo0p1dmvuTcWVwqIRJaWI/VShWd6xpwGGnE0LOL7rLDDEWqkJUdmJqvoGQNkOCh6dQ8mjfjj1NadDEX4j89fKbxY4bAHN4bPSc3X0pmIvUBq+vj7Df9+QIfzYL8aOFSLs51eq/5Zy3nTM5LpCjRpkxta11yg8knjxTrkK9Zs9fwbV7yYR4pR/DCZHG3Cn2Govs8CVNIYtz6tf6fRrnoB95jq3s1raHEZO/2UN6wM5A/nflQVNUAKIc7dwpNabtnyjWHXxKw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf23bbd-b156-4080-14db-08d60de9a4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 19:57:25.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB619
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Aug 2018, at 16.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 29.08.2018 12:09, Javier Gonz=C3=A1lez wrote:
>> This patchset adds pblk support for variable metadata sizes on the =
out
>> of bound area.
>> Igor, Marcin, you sent a patch some time ago implementing a similar
>> functionality, but it never got re-posted after review. Can you test
>> this and see if it works for your case? I did not implement support =
for
>> outlined metadata for the case where the reported OOB area is 0. It
>> should be pretty simple to do that on top of these patches though.
>=20
> Sure, we will test that and let you know. I was busy last time and due
> to that I never repost it. I will do this on top of your patches,
> hopefully soon.
>=20

Thanks Igor, this would be great.

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluG+qMACgkQIX4xUKFR
nnR0NxAAiVQXJKYU17Nm6QtFwZyBfRovomCllDAImTjYLcJ7hMwyj0WOuiJkR4wl
vovKkkrf75h66FP3eDWdkLMFBR2WcFig+W0VXXZKY7UhNrH4acoKyVgeph7Q9wB+
vgw7v6w56dqXsQC2Uca1k+9q/zgEaK0Z9dLAVmGbtqnBPTSnbstaUDnaFaYfq5S+
mEeNowMY5z1lcFPwhGUkl93eQuy7MdyaMDYBPKdXDHAmkEh5VY8FPmBjUk5zPMD6
0q7xuR/qZByky05pndKTJArHgvsSTKu3Gb7HaHQvUl9EzmuGel8BScHH0xd/Pup5
2MsQiD4FdnjZJmF37E7arLXbWwlQq1f3oCl99Er60KgEzQ8T6Q4zRJpAvoeLopfy
DPOwUmqgDKe0RqOzb2jhPdB5ZaibswfEfi8RSequFDGNXRjikWWnkThZt/wmc/jC
bmCawhhQ3lrM7bI+htOmNVWBitNaL0Vr4Y4U4OiQ7NebUPGEeO8s0+2sQm1mWGbv
K+5QIAgDIzdqPtLTblvhgZFRA7WKVj7z8lMR1cUeZ3IOmI6NqEKEbe0SssriXcNK
PxjUX8QiZ94awBXRTOr5s0wgtmQtU0uSwWMYOqhiqcMBVlhLFEYThDzQTAoImpTI
OBof8SGdnmB2vgy4/xC5y8i+RgxanyUD6twwfXBN0Qzp/VoZA4A=
=zYZi
-----END PGP SIGNATURE-----

--Apple-Mail=_4CECD028-685F-4020-98D7-91CACBD021B3--

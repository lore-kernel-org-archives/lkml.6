Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233757-5-3740708848164016567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233757; b=RDaRdYmyowO9ZSmXTB2Tytp4smPglHgYP5JWS4IO8TJqt1rILW
    9Oc/uteszXwFfNFMjnAXDwRsPr0NW3cQXWv718LkeBkGUCOTgRrOVrjbk8HWlcdv
    rSeM4nZEC3pbQohFVzmmaO1ua3RSV+iXrVNSGppq2rPeFCcrRo+oRfWWl7UmPNM4
    PUZLZE4GMbYd3cRnrnF92WnprEEXRMsYGcO6I/FkxHe05oVZbPEG/jpHIUh/tfI+
    qqyo4wI8L5FsaS86p66Jxz5ICHGiAj1kW+Hq9bW8u8LmPRVeGgSYRCYFeWojrJRa
    3/ytGJVF16OPPoKPWp98Oq/3ueVllXdSc8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233757; bh=JzEawsSquc
    liaVg4V/r2dqON5iLgZCkKsx3ytkSV/Wk=; b=q7iULXWTdV1pNIHD4+yD9/hea2
    jR8Be0LbwzR1Q5kmwQsRnfDmLKI5wPBfPwb/A+fg2aKA+Z/Stbuvtn6AbRF7FhTk
    dxSmsH35VbX+llqzGRb/Ynrf+KHXdhmzKBSin6XDCUUe8o8RJX3S2i9jwzSHn09Y
    PDsT48JFmyUJEhTCUNkc+q2sphMXPFfKl3ToNTbr0WT/5BuwXIINT9SZGjDhAIoQ
    yI83CtdwiMOCjDIl7uNqx/Dl47kqYVZbamvlWzFwX8S/v39u+tXIchkXU6ZSgIg8
    T2EoEdEUwj0LjZ7KlNdaC5UvNiXxD73KL6m6eEgWusOKtYSgHPthvargPpPA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fCoV//gQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fCoV//gQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFg00mGbKlZE+Jljik7SKBsX+wQeaCBRItZNOJJbNY/HxMzc758Dpuou+6a4QyvXAg00des6JO+iIB/V33gmLD1JpAjbmmeWt7+ma2MpWmrC9Jy68cee
    Lg7swiA+4x934rKemKI7Xq8eoLg+WI5Gxj47Q1ZfgKYhqK/+5hq7dhOnSh7KG/J9BOb+WvyvfyklbbDTN9Ury02vBuhZckRQO8OhdItVWExlqoR0dJz4me5+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8 a=yMhMjlubAAAA:8
    a=JTNFr6GP33KXRZpIn2oA:9 a=wPNLvfGTeEIA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755894AbeDIA3N (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:13 -0400
Received: from mail-dm3nam03on0136.outbound.protection.outlook.com ([104.47.41.136]:25507
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752959AbeDIA3J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 091/293] ARM: dts: am57xx-beagle-x15-revb1:
 Fix supply name used for MMC1 IO lines
Thread-Topic: [PATCH AUTOSEL for 4.9 091/293] ARM: dts:
 am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO lines
Thread-Index: AQHTz5kRUjk1USNMOUC3puYvI9IWww==
Date: Mon, 9 Apr 2018 00:24:05 +0000
Message-ID: <20180409002239.163177-91-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:0Nf7PPzQZShq8ewci4EmoW55tgobzhw/CzLWAFgkOjdkylMoiEIzmTg3riMxuIRnQWI+HzgZWvVYAzlnTl6bxBMG/nzsZNm3hka/Xejho1Ckkj2MbEWnNJhxf9SxLX8rUAhgqyYolimjp8k+6Ds4q0DooulcdJqmTwysA+x5LM2bCh3S6aGSMAvGQThn+hXUi73EJT+a7Id8Fv+rf59P1zr6Y+CaF1k2yf1zbhyQY/+JoriS0lISDafeT9scylWA;20:NkjdQ3/wTChhVK+PRvagfn0Ic3hEmTQALlcsXvZLp+2SFJL3Y+CpCw8Mv1DjgCdFPcSLAm3rX3zjNijXyeMPL6IRIij2pUQPVI2X4rdwJ4Ps686JRtPJ6AENQEWLfbzBQADzZVklFOXTK+ud2/nuuIBmQrS6IDq6ATV2bdsUdDk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4478f0a2-1669-47d2-b39b-08d59db0e849
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807599CFD3FDC2F9CB2FEB7FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8s2OGEvIbxBZ8nqErP2ii0oAlOCiM6OawLqsKe1v4q7pr8jkT/423Y1/NB7Fy8JKjTfXvOtkP6oDwdIwLumUcFFs/W9pTlpXwYZd9NRyQNJ6w9Mot4IFF9CSOo2D+LtRsygp8EAJHiXYibtOy6UpErImLb5vl7qwp0Bz+vXsp3y9QPyXQsS2FZVxCUcgICfzy2nDL81ESHXUswI7dgZ/siWY7MZvFpjxGuSOnHEEeBJVQfFN7G1eFCF8J41OAe0Aedj3/m5UwywNkxa5Ukiz7Nhb3byc7N83UBwvk72ycrZkOagsTZ74KnUzRRDsP8f33eFmKEq3bT7efqQZJZZLblo4lJCZcBbOt9/D56COD/4Nn1L985fl4PmpFvPvcn7ABG4tRbef2LryLuyj12A6EhdcgJFNds+z5Tz1guQrKHo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4478f0a2-1669-47d2-b39b-08d59db0e849
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:05.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 8f323f8d8332455b633acabddb15483d64757965 ]

The dt binding documentation of omap-hsmmc recommends using
"vmmc_aux" for IO supply lines. However
commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add support
for rev B1") added it as "vmmc-aux". Now that anyways it
needs to be fixed, use the generic "vqmmc" binding instead of
the deprecated "vmmc_aux".

Fixes: commit 0af28cc92690d8c ("ARM: dts: am57xx-beagle-x15: Add
support for rev B1")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/=
dts/am57xx-beagle-x15-revb1.dts
index ca85570629fd..0e16913d75c4 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -20,5 +20,5 @@
=20
 &mmc1 {
 	vmmc-supply =3D <&vdd_3v3>;
-	vmmc-aux-supply =3D <&ldo1_reg>;
+	vqmmc-supply =3D <&ldo1_reg>;
 };
--=20
2.15.1

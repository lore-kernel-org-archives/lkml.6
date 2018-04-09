Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244025-2-8102626772222844656
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244025; b=LtZkMtPbiWwsrxNbKIkyYi/hA6N2dZgsWcf1BOa2Q6PLyBGaOm
    cJ+VrrXpKaULEPEBlKrL5ubnUWCC2cRedBhkb/SE+A2C4ufOTOQBFrDR7ZOlz0p5
    yBPlAZA0RLJ7Wvztba1In/swTX3OnJGGxxYEurvpJulw7HSzqN1sPKz43epbIvMp
    2cK9c0lw+kWVXzvZclGnOkBUp2nnvRvtlfOQpmzcmiUnlNEbQSydo/L+jY7huJ/E
    sK7RhsDPSpXbrN9Nw0G/Ywq9nUBB5P97VvQNyoHTMaQEuR1yXLoqKHRMb0IMHD/2
    WsVO6jW+ZzOgfZqF5IMt0ZTaxSSwCrVnPV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244025; bh=PgB3nQNheT
    O+n2hNSbOP+bHl7pwilIW9rNRcSd/Bggs=; b=wGnXFCQmt5ytyblmTR6ufYa85j
    abb2NqfIAQttuukPNd1dL6lxS5c0raH/ZVBxzVMPollPgi77ZYdBW9Zzd0L4VQSb
    IXdBubwlZh7BdROUJY4fRKh7TvLfNwp9TuXXhvzmlTV9eHws81tg/yemVEWflee9
    aoAk+OStmIH4psuLLQ8YVSMQCKZITsbbiELkGMIbOW+3BziasQadUCOwXRo8bULl
    VpmzB/N2GwnO9Q2ocS5A+4CP8Zb8WcrYeTQ5sC8KGH7a1AQklCjOHCEf1r5pjdTX
    IMzhaWL8SGQXf7l3f7AB/rJisvwTaLM5L95u6GYGMINocSJiSKI0HB4w7PdQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dx7emu/J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Dx7emu/J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2YKNAISBjinm065cC0FI5Nz1tpo4fSPd1y8oHfOANmh2/vJWSVDBa7aAk+fDklyuxh/MB/aeZQKsJCHi5I+YRc2bGuM+fsZRuJd2CFS1s4IzqwjZfU
    pmpVgmdzAeEuF5DqfpzStCCgMMaFM62v721Ng8MeHHvqyUs3Pa95Irsnewuu7/EUzMmkidhHv/vY6SXkmzl7SRYxuXsnxg+OZcum3o+uhgUHcoLdm2X4+A/T
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=NzN1MpvFrResoN3T63oA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDIDUV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:20:21 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752598AbeDIAXA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 048/161] kconfig: Fix expr_free() E_NOT leak
Thread-Topic: [PATCH AUTOSEL for 4.14 048/161] kconfig: Fix expr_free() E_NOT
 leak
Thread-Index: AQHTz5iN7yMNiuB3i0WslwohjQCRlQ==
Date: Mon, 9 Apr 2018 00:20:25 +0000
Message-ID: <20180409001936.162706-48-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:IEcZZ0am3u+IJrJdehTYEO2Bba8kJsVFQkJp0yhTmrLhuasmcB5HL4D5m+bNf2/qWHT0QXSccBjuLmc6AVX/AKcNP4Mplx7R0fL6O4NSrlqRCI74DWGQf9vK7lIZuH3V83NkUOgswTo1EhjUL57hgBLKsFoqEFibaSdObH7AAmN1ir+ovrGr3mxV5xRcicdr11+UTixYTJCa2sypL47bZ1nZY9ESIqd5e29lpiKm47yrNUOIKv4mTb6Zjz93zUaD;20:2DEPsM7dZtt/yO/KYQczonN9lmcBQUwkz2MZtfRir3GIwgmW/n+39e3zZZ1H3UfoPbkivmu7o0Nesfgsw7uW6f67i/U0AvzxSarNddtkpbJks65kthOXJf/VvkCOjK310J5rN8WkxGh6/tfjJ6KDW4TFmFxdSgfuTi5IL95k8yw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7482ee6c-7466-4192-eabc-08d59db00abb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014CA65386A887C0630EBFFFBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(39060400002)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: mFYV856HYP0whoxrBbFQpSnOPCUN01XpRtziRieTCLBkwsBqSBHwek7G5J+acskJGtmSMm5Gc4dzhbO0k+z5r+/tNr1LrrH4Vj9EkaWZxg3gjt7eJ6snwaaYjZhmTVaaDgYeKFrCevTabKFR+7Qtbo+oldKHJBzcE9dhW9MoosJAK2/6KtuX7K6meQqyE9iiyCPJUQqNO8etJUXqeGn2KyvYucoB4XAMlszx6lXvuObZz+japDUv4mQBI4fTLvAP30APSA1CDCS6L9JmobruQUqYCt+vAfGX05EUU1xGJvyeT7tzKvln/F+vo+iSdoqhkYLgRetKQzah4VieQj9GZ5cNYFucjk7+zt/n4uDYtwz7cu9UF4mF+tIIc6btvYsCnKSowH70MICBeaKW0Z0FsnoPW4r0+Vmo6xm84XXVTNQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7482ee6c-7466-4192-eabc-08d59db00abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:25.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit 5b1374b3b3c2fc4f63a398adfa446fb8eff791a4 ]

Only the E_NOT operand and not the E_NOT node itself was freed, due to
accidentally returning too early in expr_free(). Outline of leak:

	switch (e->type) {
	...
	case E_NOT:
		expr_free(e->left.expr);
		return;
	...
	}
	*Never reached, 'e' leaked*
	free(e);

Fix by changing the 'return' to a 'break'.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 1,608 bytes in 67 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/expr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index cbf4996dd9c1..ed29bad1f03a 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -113,7 +113,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_GEQ:
 	case E_GTH:
--=20
2.15.1

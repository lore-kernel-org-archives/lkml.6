Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246550-2-17652483031507451758
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
    1523246550; b=EVoNvrSPQnk696JrRhqPfqDbUrbvFAvg1nryO4SqJnV19zIbRI
    7fhf5e05WR983ot8Vp6nMo8ZM+0XKpZOLP3ZgEHlwsRP9cZ3nZsTTkUWP6oZ2n1Y
    BCBVDSh5RgaLMNcjlmArDwjbYUMCsFFDVcsFNuI5+X5W7JQuQP+g5GBIYFA8cSsO
    ou5qU0peSZJ2qUeKp7afrJkGkiSzTmJOzfG3ZsZkbjwA1lOe/yg28CETGNB4tVbL
    ETrszMD6pUTbYGqVS5LXap9Ga2KIs73uKMlfKYrK4hedKUv1Y5pqmSJb4oIv9pRg
    jPCmoZ05sqwYbbjHpG5FNh8GogLWxlXPym4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246550; bh=AErbnI81yq
    CiHngRh9wQPXsZoU01i6BpcvhfN13QSPo=; b=hdCy8yisugMvXnX+F3nw3V40O5
    Y9mb5Nm17MSJS+CaUbTzctKpTUAaBckzx8QgO2zuCmmaqZx3kpZfwsVytM8IJrsR
    3FD3meqpw3jTPvWt7qZQb67E0ochgsWg5cRt40LPlvM5Zodm9OtMmdVhsELFdV1c
    xqvcxrUrzc5nv7r66pbitcD6aaueEiODpijMZajhnwAevkapNCmwRTVyt6PiuvTL
    yPaE5pM/ubKj1A9+Be7rQ5XzFltafiFOdd/l+nnqDgeNwaEIi/i9Q44O/XrkTX9U
    kHytkg/OLOLe5uYweqGEN1rnazzga6Mm4/CTW5c1Y92ygujeoLVk98oNSg/Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EMCie6Xk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EMCie6Xk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHxAkZmEkqSOZUc2DFhqr/j9j9ScXpiSDlP8tD90nqu+WY91gRZQFLeXjjeldBTX93jQ+z1R46scD1Lahy4h0n1i9I58EQu0TzrTK10GlIaNDLs5Fme7
    lpOBUiiW5aicVnjzDo6LHw9mPi9GDi0jkPRTJkUx/mzjgRV+Z5oNtNTZkIpPjDGkuQ1Lt5Jmx4vSsRuH3vZk+nVhFyc6zsyT93KhRH904N6X++aO/25MlfY+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=NzN1MpvFrResoN3T63oA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeDIEBn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:01:43 -0400
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:42112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752981AbeDIASJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 056/189] kconfig: Fix expr_free() E_NOT leak
Thread-Topic: [PATCH AUTOSEL for 4.15 056/189] kconfig: Fix expr_free() E_NOT
 leak
Thread-Index: AQHTz5glVoxWzfXhGEGy8jIbymy8lg==
Date: Mon, 9 Apr 2018 00:17:29 +0000
Message-ID: <20180409001637.162453-56-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:JrtZS6WjcjAPUoFXZZWnIcN25kNm96iIl49MkhQJmP3OB1bqSJ7JtYOUO1GC2Up5UAFmvH0p/Cr0NxLQS7niWe0KHYD2DsR57wcEJav+ohV3/saEq5YLgz9od+qx1RY1/FynM2IjcYO/1uj6Zi+o0fpLV8e0nuOgZ5KtOFUjY24+Nfjus+dDFWk6+AJV3XtU4UrtMdxLTT3MzzqdM43w2vZCSCNij7EIlwBftl8hsaKiscIzN4yeG68YRALGWlTb;20:O2KAFVIRnPTqSFNWw8avFYxviTrS/C6nIPrTXhmwgrCR+l72CxMlZcUNJ7Dv+mDVTq+46Q8udnWk5kfbh1cHjmg3mcDNi/vMzx4OaiJW8S7IhyPUj4S2B9DyuH64PKGmNWqPm1Khdy0ZZJZ4pOzFlMBoxIBUj5MdfRuNFSnmsrQ=
X-MS-Office365-Filtering-Correlation-Id: 1b0d3a25-48e4-47c4-1888-08d59daf574a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046183099CAC0E7E756F1FEFBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(6666003)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(39060400002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: h+Gj18HUDVCwEBFycg6uQMyCR7wCCGRJIeiGuDeeFlxqBZZmGyLsVNp7hqMC1Ugm+RYKtW5JohulQM6IPnibgL+mEIEBY4aFalWGpTT6X8m+/cNxTOEAplJstNljylNWnfWF+LD5XIp31gVEn5r6RoTIl7WcwQ+UT3eDiOoHdfZbY6s4CTH9m3HHxAS4In2HVK1ULbjKdDKnzgTWMGazGfOG1O6TeP2DFv0HqDXenW2QTeGjyuVjpmDFf0S6ff1wxBMQT2q1H1D3LElY37T20Fyj+511Q9+PioYR3yWfEDHmjWx6ouCYkK+SybrCjtvoVoCR+vy4Km0LJY88DJn7UrXR9AjA7xdxzTCrGj1DDNK/BatRmpsQYfukgpr52fUk+CIw9qfQueKItI4Ed3FawpPO7XqNoaoG+xAXelwX6Pk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0d3a25-48e4-47c4-1888-08d59daf574a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:29.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
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
index 8cee597d33a5..ee23ebc881a6 100644
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

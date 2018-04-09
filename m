Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234892-5-16762282727695679009
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
    1523234892; b=d6BFt0bB/7T5BVHa8CNu+hFd88gz9XecqouS2cxEK+KVLEEHy2
    q9btHH4U8HRbsLhvLmQUqG+1ABdgOOxnc2qcWB8aZc4C7uFc9eX3R6IG2/j2Twn8
    axli3zJzs76yq+U1nSQ5zVHdbkr83BzAr1FbN8JpBT/aOXcVg6CeN1olJH1Vv2RZ
    GqnS2PdOGqwWEQQ9LL1cFu+HD2RIbRg1MXahTxFEn64/D5k5UrFBlICp8iJDiEis
    7SxdnN7LLrZ8H2P0jcgJj2Wj2iDp3+ogx5oy4OMERF+gDGp0tf6J367n8nvj4NEx
    ClLaEEXhz1ihIFaQiRhN+dBozLGJ2RxaVaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234892; bh=IHmfI8Kfw5
    LFAPc2fSwuHWQR+tjY1ghRUaPdzGKY/ZQ=; b=mmApXTb32Cs+OJ/i4ARhDW64QS
    YRBnfn3lw3AFWNxS02AF27brecf/LPdFPXU25S6TiiLsz/GaRvdBmyDayMa3BmHs
    m4tlqpgDIX62BceeYgxTiGibNQfwVIM+1604eF6ayaCDC6wEzIp0Rn9kcYX1QuzM
    rohap/1bl7j+H2gSb7Hk61rE2SMZzGxlZnvVboevjSJUkLIE989WciQkRB41At+7
    waw00h49vCLP03QCAbnlaO8mZb8SMI9OxDfOiUXG+gsY+4qv+VFibyLwK+MXjdv9
    HHJurl/oFQMJj7kDMDYoGXk9CRKOlJs920ypy/1/uOJkNVCWyuBh0ULB/ifQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J+BqC1jU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J+BqC1jU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2+bZPKIzd505TcSth/BelcjJ45pHYRKfqsI2R/s2xXmHV+ttMzeUH/kd26fnRHYyDWeotnTctkIhDsVqsYWRWk9KjVubw1jI90zxxUbHMUoiMY806u
    fYPfWbISb7umkQOVJC2OV4S86dRu6uzQRPHzVVcQdwHjm6b2BNT22ocAmnGSUh0kFggGJocsPO/QxKrDyVHGTxWAIMdo1PGG88ab+Elc0IV48jHtIZu+Czpa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=NzN1MpvFrResoN3T63oA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756403AbeDIAlk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:41:40 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:61949
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756349AbeDIAlj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:39 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 075/101] kconfig: Fix expr_free() E_NOT leak
Thread-Topic: [PATCH AUTOSEL for 3.18 075/101] kconfig: Fix expr_free() E_NOT
 leak
Thread-Index: AQHTz5uDyA4tsRzuxk6hYCKqBsKoNg==
Date: Mon, 9 Apr 2018 00:41:35 +0000
Message-ID: <20180409004042.164920-25-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:Cnly9KaFyevtXTS/vJSGm5onmmV0YICrGfGqZ1IibipjhT3RZ9/9Vk3+2GokdixRT+XEVsGtgX7jpLa+QKVO+CRgittddNoHYUrygUbHEa6vcGFIRh0pMiFjtg2h9LqZ7DPHrsHsO/JTkHLU95kI9u1YNKtucKU0Vu/AKinhk77Ow9qtfbY/SGmML+txvjDs/A/hvp1idssQ99CXj3tDTPxfVqtPYqC6j92guy1S4MFHCyPP+yX9YsgxL+q9bhzh;20:I8Q/TaMnHcNYBFU+NFvA+UEB1Z5LFU3VEHaxrJb7hM7xM41mJhL4KOV+ff8HWMubIckrgCgN3XPCAC424afIQJ8AmwFuPe8xPCXokz3EVYzYWIk8T0ug6kBZReE7YRYtCfmNclgmwwlR2Bc9dW8tR+moNOEzYC+IEwYbAb6Ddk4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 80b96aac-5d10-4ae2-49c3-08d59db2a6fc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062EA979E3171E657A411E0FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(39060400002)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Du7GLthiXl8aURFMCaRC8NMQlIbLnynRjvzDtRWs+f+YpqiZKjCxhiLnC1H7kYBOfBAM5hJ8KkZt4fZ6W/W4unufAoGQcstxf7PD3Ky1G/s94teOnRfnX0I52UrlOFS3tSi8FAH0sYhLYjEHdMda2ilme6MrnYJlMPucnAka6Arw1PBxMNGMP8THuR15HC15vlRLlEOawMYL8UY/EgVFH6TIQlYZ8ZFyX4B/P/g832EMvpJPouH23Vm7ptKrgM2KAQDubCJcvrx3L/Pq7nfyDkgISu0+ysGD2RLjqwjR/mE6zEuv7YBePw3568lsIH1OzyvYnGsnpEVAJqiz54e1HU9l4PAP/qNq+Q5hH+/WnHcj4hRBX+jbKewJNi/II9HgUF4p/VyoRB9J+1WrfkK09Pp6QrAXdvxc34SBArbPqWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b96aac-5d10-4ae2-49c3-08d59db2a6fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:35.2834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index d6626521f9b9..23cd5ce862f7 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -106,7 +106,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_UNEQUAL:
 		break;
--=20
2.15.1

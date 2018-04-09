Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234924-2-15917887996798250860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234923; b=kgHJUPGVpKxRCIghKwoTXLEYsXNhOSxoJkTHdidMt9x+GXUo6w
    nzx8dfLjuymdf+ZdYM9Wrhbaf8FpR92OvcStdyIxNlvwG8yBGFBulrVbUfUgMw/O
    RTdZQVetn8UZSfNKyVzNnjlMeKuGc0x2G1FavbDK0hWkk3xSqRWUYS9Rdm0gZJrf
    y0veHZhW10OtTCBmG0SM35PRaDA4iCh1wu3Kw2AyRsorHFpXUaF9CA5Q/doo8e/s
    CUvxFrzK+3cYSEPdWHv1UyIZkKzavivJ2/NrK0P491gcqglyIRrEyJD+CQ5V0/VC
    9Wrg3Y8YcQwDGwABQ/LkdTxlxlaTO1xBrT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234923; bh=2+UHVpWuo8
    iYnoJucI8VNRa0U0S+XqiPF+/c2GH68lU=; b=FEHhkazgiNn5KfmAS0cPC8T4GV
    OPhzcnYgeMdk+Truw/hUeVO5+JPg0FZ45tpq1xNK7yzWdvPbZGz3JOGmedpBblWC
    X3TRPaJX9fyq3YS0CzKbhEbuqTJIcyDzJCEjs0jM/fFr1ALMxZDXJ8wTZUy/TTJ0
    7GqRv2GDn5c2g7HAbPf7z46nR3XPyPtwbvZvIQUZVh3xsI1D45YAy4v8yK1NMjFf
    YCKV31+UaAMT2sCAJLS+H6qLJ1ChsHuhxf2MBRK6TBR1EX1asVTIgwkn5q4eO4Ra
    INoBsuONiqLDktKLPR0EvQWJfDnOmrZptBMp474PnHvwuSyV9Rxkof4DecXg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SXXXrzeW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SXXXrzeW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN29uf5WUfO9XMXcmrstS6Rp5Eg14Lb4opxp6ArS10JyI2Czs3ORULpJfIfujziW90tQuaqm6mcARxfd7LNFSvj3D2+D3/ihoH0WpHLgSbBvtSlpZSY1
    VbAMHT3bR9j9U0XxcplhMYcZr6k6m5UYnaxlIwm1lo5Hn9VL9SsX8r7oe5c9qe6B2VkiF/giT/6A3b4xNs++ybaMix4v2oTkMwK6zuQBWiTvU+PkX9jHkCDa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=gZW_3bEixuK0yuQyb0QA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757088AbeDIAsK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:48:10 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:14462
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756361AbeDIAlk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:40 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 074/101] kconfig: Fix automatic menu creation
 mem leak
Thread-Topic: [PATCH AUTOSEL for 3.18 074/101] kconfig: Fix automatic menu
 creation mem leak
Thread-Index: AQHTz5uCJGUHhCQ/nkSagq3rTwUa7A==
Date: Mon, 9 Apr 2018 00:41:34 +0000
Message-ID: <20180409004042.164920-24-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:CyJvTZ6YEVnMTD6Kb02q3Lc9y4UvmkHV+vXnlo7hQQikNmCgDixnlJq7iaYRKCP6xiKYq/V6S1EqHiGkZ/TsAOsLDFUHWylMS8z4bJAyDK3NZtk9jHQOfFNaXmbqTt85McIpsvMfxleBvwcwmzLrlPKkEoRD3tMrEpTTRu8tFW9QvCs/yTOTy+j1ENSU7sCnTqTkLQlGf2pY9MxW3Sc2Agjh9svXvzfvLMFTe/yChqCyVqLkKJdNFmsEWvTiFfyU;20:MvfWs0Ma2mMD58HzUDcaWQQwFrsp4RWhUYrXpBUZBMjkfadtRRV0AgvdNGsOTy64aVU4CAHmz2YRBkRnDrzyU7BPV7QjirAs/arhl4SDu5ErOgfPH5QHdDAOcutSi2KIX9vh0jkH97N1T9QwjnNqXduAc5PD0fbOChaHOohKUho=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25bcf8c5-ccb0-425f-fe83-08d59db2a6af
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09017B3A5280CCB182CD6230FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(39060400002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UtUslY6IoxEeI2QiWEW0j6mXOLevQTMDYXNpgt8yT/Nb/XaGdz0NGwDo7EuRb7Mzlr7iuyjZO2f2U+xYGRYoTbHVr8k97jF9XUNzWBpMpl1eWEXTHj6J81Ii90bdN7gSi7UyODakjYu8OJ6J5rjU2dyJgWZWQeZOgET6P4YENnxoEXupCpr0YUfuNlVgtCjjQwgRJXkwDSZUlImE71MKvaI00AoyIwVNRs4gZLoQAtLjDgyjluCd1F+OI2zQRGne3WI+UslFIN7wq9DWsawjza/jzgBgizturhpGY40oqi/QM+ihZWrXSODTpv6EZwhWWRL+lbHFRqQtZZfzOebB3tzFlHednI6M+WRhHnIp/uFWVn6XVgSf2Az1vFZLVAuYWh5Qv5WBN1yqP6umvyQ1G0XxJGmRevcV6opOPJXtgiU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25bcf8c5-ccb0-425f-fe83-08d59db2a6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:34.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit ae7440ef0c8013d68c00dad6900e7cce5311bb1c ]

expr_trans_compare() always allocates and returns a new expression,
giving the following leak outline:

	...
	*Allocate*
	basedep =3D expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
	...
	for (menu =3D parent->next; menu; menu =3D menu->next) {
		...
		*Copy*
		dep2 =3D expr_copy(basedep);
		...
		*Free copy*
		expr_free(dep2);
	}
	*basedep lost!*

Fix by freeing 'basedep' after the loop.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,376 bytes in 14,349 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/menu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 72c9dba84c5d..095a6094d736 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -364,6 +364,7 @@ void menu_finalize(struct menu *parent)
 			menu->parent =3D parent;
 			last_menu =3D menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list =3D parent->next;
 			parent->next =3D last_menu->next;
--=20
2.15.1

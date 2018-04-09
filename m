Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236427-2-18327603783967871730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236427; b=VNJn6xpwNnRugBw7kU4o5ewo1CMQztaNL2fuAsF27M5e3/hmb7
    maESGSAWGtcm5JUFTNmTMhTitzVwjSTU3xWmmlhAAP/JOJQkvQd3kHRuAh4uwRGo
    bhTS8xhovSiaDl4ZiptYa28O9nHof9uFtc2EiJjLPldTXb5mIbQaBX8bsPz3O/Ap
    iLCL1Ag+czd674nyEVySsx+u7nOzGEq43jA8Lmh8QZLhOcJvDdC1FnGYjMSPI7YL
    lXW5X54lEQ4SQN3/Qq8nKUK6g5Dk+m0Txk76GTR5tkIDQA2TM30SQ9ynU6f3cnGs
    Ilr/eHRtl+Hg/FDUim8fMWCDF6y14tGyt8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236427; bh=kzJRLuIMWU
    yFdkm7AXIwaE5UfqcS8vCyaVuEmJRlnmA=; b=qB7KFiGSAkByNKp2xe1apYi+QH
    dpfsx4e7nYtanEd21PH9ugkVMREFTQWOhXPdM9xkOsCDsbKITApy6z5zjjTdOFPX
    kWKr4Qa+tbL3RIA2e6yIl1gwf6VsWOae98xCYsFLT/RXBioHPNgNvK6C5AX97TRW
    Cmbk5e0HBRVWcQkM7BB/msge2O1Lo3YEIzd1H+hxSzcderNbDILv0+nAsjFTU1AP
    OaR59qz8f7pEuoit9m07iIzVb20RWVl24DCb+KbhjKE3AhMy5NXka89xWJje0hBK
    ZiUko2CDeR2Ax3Ya/SBHMWg8ypw1T2sP6EIXb6mwSEs8FJBCQmjAHyzqN6hg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPDz30wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OPDz30wj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnHPzm6zwG58ukCFNIpDg4D6ReUQKcml9mhNH3S9xbZjYYoUysNCKWO/66NJbxj0OlFvN6eTQHlf+gru2e/LjAG9jreR1tT293Sm6m17LyhtnVndOKJ
    ANCGct79u3ZSGYXjCjV0OQG1iKkbsE2cvMDmoXaZKjkHQbT2CY5maSJElMgcP5MqoAn/w6wa5l4TUPYQ7BHiYBcA+yGU330hzQ/bTjOwgySBBkkN4lhusQi9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=gZW_3bEixuK0yuQyb0QA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755747AbeDIAig (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:36 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754975AbeDIAid (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:33 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 121/162] kconfig: Fix automatic menu creation
 mem leak
Thread-Topic: [PATCH AUTOSEL for 4.4 121/162] kconfig: Fix automatic menu
 creation mem leak
Thread-Index: AQHTz5nMhsiFa13REEqvaS4lWkUduA==
Date: Mon, 9 Apr 2018 00:29:18 +0000
Message-ID: <20180409002738.163941-121-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:CxqPrbgiVvfcssT3dxBwc4H4z/RB/DnIHQ/Aaj/V9Yue+T1D7sUFbM3RG6nkmrJg9b9jzj6EDSoVOL9XgSXqe+rOXTCpKYPqww8GeekjxHPmqOeQPMp9KZXH0P2vo8xshz+X0lk6M0lP+3C+/WaBZ6jQvjXT+E9Ey+EBNMQ0viKID5ziZ+0gunYnC9qhPeKSbbig/Pdl9HOddphnziXJ8WwZKcrHdtfRd6bTQM34VF5XNJriNa6hjFMcb5KtfDDc;20:sLaRKU3YXp/6+l/gvomU5BcnzOhGkUZtxfVHRNlTBJpeWnTYBDHdOPBDxn3SFnnvuwpisPHQdfPic0MuOUr5/PJPNM6YaLKxbYw9pjluYkBoieqUcXETKW/LdVeuncFgGbVPe9ChberHWBnSgyLEyYR3npFWTl1osFE+RUy2b8Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6700ec4-6f15-4164-8f2f-08d59db23810
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109538DC9E751489D164C78BFBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(575784001)(36756003)(6666003)(6506007)(8676002)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2HRpA5nGmenf4PkuhrF41Yuz3feYE+foAjGDZr7xHty3l2ZOUa8XmYPgs4if4gXm3KK6JIFUGipGCwzB5/1P3AKk78tffS0m/P1I/wZbLfnD0AkhRYaqqj4fAZ0UzLCt/zVKDMdEf0psY85ExXZKe1ggCsN9JtX1EEz2BFH9QpbYYHxwhlKgzYcmPqk9+9cutfCtK9CXImM6ZYRBJcHYSNJIJEWVprNNKmCrOnWMYlp9FzM52EkLD7pBg8i39YwoHSyzGsDfbCGbDk051dfBaY5Y+KA8JPOeAzqEu2viEuIMOWzPlPW+VTOPTikqcHVeUbfllf5AOZS8jNgE3dAn4pZwHnOfseQuqjoNmyzr/wGMcPWPd4FVwbhxvCxFmBfSEkQwl1SrTIi+nPAiUSlA2cVWXmw+vC5wGHCIzko4mmY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6700ec4-6f15-4164-8f2f-08d59db23810
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:18.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
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
index b05cc3d4a9be..8360feaf51ce 100644
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

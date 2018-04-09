Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244087-2-10159045452412635836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244087; b=Tfm0tSljyLnH26WslDp4zj2To4hmjK8bxT3e9gEApAFY8CY7Oj
    oImN7YWlG+Qy46DG0bLGPNOCJNRE/nJlb88ykAms6z0Bf6zaESdGymwpxQNNmYWX
    O3amiHYAgJu2p0roooteFAHdSs9Pjw4jsOXJo3+rzVSl0Hr59A0B+QV6IsPAji4L
    dqPoKfJgDHg40+cYG+mr1h6ead/kvzN5jY9PyB4wK3STy3UMzD+3qEfnzuIBvcbz
    vpH6Hqgmqh8IrVC6ZIVP26CvMvBykaJHTJEUaBN14DKZQlNcGu8cpb2eN+W6oUL6
    mL902Ut11uVaU1jEeUAMT3W5nEcWmm2IQclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244087; bh=NVdslaOFl7
    DXblFhtaOiH7vOpo9R3RS176rq1db5QI4=; b=Otia04H52QYLszxmq272XAJUUU
    g6064fqjpoE+drDEJmEGAvqOjL5yXb6m94E6H2vHISxMgi526ibgmslrWve9etWN
    f+8PysFwb0xeH6Jt02c7BzsapwK4FGPod/ZaFclQj2g17QFJjkDVrPVfky8hSTum
    j4RXyrKH3UxN3G4zO6YRxFI5jf0/Dd2vxyynQqPMK3qTW0O6cu4AySzZDgVENHxV
    2abk3krKlgxYgH94vOGsBmywrMckFkqARW4vhAh6UiuE4EHSnjkORvsddJ8jjplu
    x6EejOQNjDFYGdb57piPyRT5offfWu7XtNyONhjDhgWPEKDvFUME1/rx05/g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MbaVBDwC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MbaVBDwC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8axi195smDKxWIK1WEm6IHIcktzLjYCtuJ1wW5KtFN/FTu9FD5M0GWCk+cqljDLkyY4wAXym36qZ9fAOFR5wnHky/ge5F8My2M8APPtQA7L1JCfxZl
    QR9idtemVc0wVX5DRTdQ8sYyBUk1qX9dg4yihb/0uEzEiA4ytb53N2xxzkGpLwHpT0sKewJEdeyuZsabAeeVVH1Y8gDX6w9IScln47S7KIaz0kzjkbYuZc31
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=gZW_3bEixuK0yuQyb0QA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeDIDUh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:20:37 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754726AbeDIAW7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 047/161] kconfig: Fix automatic menu creation
 mem leak
Thread-Topic: [PATCH AUTOSEL for 4.14 047/161] kconfig: Fix automatic menu
 creation mem leak
Thread-Index: AQHTz5iNCoD5Z7A0MUW/OMGLFb71tg==
Date: Mon, 9 Apr 2018 00:20:24 +0000
Message-ID: <20180409001936.162706-47-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:PQbBfEoKfgDQHgxEs6nv+KloxXdGBXL/uea1g5N0pSFbK8c5nZvmfzZkOw9dRahcXNi7/UGeZUsprn6Qshp+lgVNAnqZb7tGRubKEnX/tbmV4xsfN141MgaY0N3PGVlUZ7FirgQ1+nIOadWrzzACIoPR3KmNDEEiph6zeB+fyqvYLfpcModYWPTYvQ9QGUeFM9H3wVhKUVR6vDlsRSZWL2eKBiwfIhGMN9cVh6MeF55Vkd75d3Hvhc39RBfWDZt/;20:kq7VvsTU4IRvxgBZRZh5KG4zlSYswhvZ8D5FhkMQIXcq1CtMnwaAUtDNnZeo4owmFLSJJUkf/tAdyZpGD7FaBO/rUg1iWezd5VRHF3N6gNDmsIMxxGeWtsQT9KLlfLDyr0KdTP7OEs3K3eyFoln1YuwwnORi+7LEGbIn+KMJh40=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c0bb493-96b4-4943-1607-08d59db00a66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014DD5D262588BBD46A9955FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(575784001)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(39060400002)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(107886003)(66066001)(86612001)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: x8nwWdZy1rjgqLTnbYMvmwH7r4VIR6dbiwx+lOCxndGeqXqnPDXLSCS4ivnxc7hWnq8N+6psVVef9ADHBd62m6kfjU/BM8VFPol4rgsMmLFXTxBQijJILTBSEqOG5JpotXxjegpe36qMzSuJ2whI2SQG32NJjcxWIGMecAhAYfzvOy0ou1zD3PpxXXmlN30wzSLhgTeyjGzpLESy3uKi9oTFmMNr78XAbXebX7kYzQYXJCc/lrzeswpvb4VwrYeZmH81rH/iiyl8Rgvpoo/caun5KnDIMD1kfIzWHD+EJh0tW8hK191aYa48FoSxYU2XYSOBeuWeFRHZnP3gtLZcg2mlhJy9T1ad3NWBfntBX3OLc0Mpyaix5+zy1haHdQbdXLIoZ5gd2PG0RX1scokio59ktVY2n1lCMAEa1PRZTPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0bb493-96b4-4943-1607-08d59db00a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:24.0506
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
index e9357931b47d..749c2bd5fc51 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -372,6 +372,7 @@ void menu_finalize(struct menu *parent)
 			menu->parent =3D parent;
 			last_menu =3D menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list =3D parent->next;
 			parent->next =3D last_menu->next;
--=20
2.15.1

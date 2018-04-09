Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236406-2-578137071510106500
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
    1523236405; b=JOtsW7+Q8UjTA6M1VftZGDiLNJ1IwdmHGJDx93JaekT39LYcn+
    qlhedVERb9VooWaiwszmDUeiN+STnyvCiqPQx9JpYSa6mgFxWkqqHy/02sT2ZhD/
    Q9WYlE/rOp+9Ehn3FrotSw67gCxNM9XCjS9KYbo82vvZHs+MptJ5Oq0lJK25k6lP
    cp4T63GmZUgwvFlmSClUwPLsmWOb3bNflqzkb/6Zy6vvcH+a2142CJ9qhwjue/dc
    QuCslb7Jw8BLDJr6Hd55ulWJH0ruIBBx8gWRbYZGAgNctn5d/od/FVFb2puKDRpv
    2AlSaMZeIasTEHX71sHY5GQyd1LT/O2TNNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236405; bh=PgB3nQNheT
    O+n2hNSbOP+bHl7pwilIW9rNRcSd/Bggs=; b=cQ+oHTFhfhmYoRPLCm3exrhzoJ
    CVtUw5msAIeUFdsn3WnTRnP9TDScivykgT8Qe0XuKNz3Ovp3odwcHmpDTR3llV5t
    mhDOFa1Ymyb9HLgdKR/jFcbX/cGm+pNcBUY+S5zbeS+EJE28q0xTIk1au48/i937
    +lE2B/sXLAzqkHD+sBmkFMErmLh23FMtLUVLkBzDRn3WCXs8tKq5zZS1UGekzPSn
    V8gElFDMm9Hc6qFv2NrZ0QCysYOgHWCTRIuyC+EKthc0Hn+z3GjX5DooIBabhTaJ
    zMuF2kgUvEd5Xn6iqf9TwlqYMh0q90B+K/7s0zUwfxgE3LPGaIzhGMooAihg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bxWQVZbH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bxWQVZbH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPx9UsRpMisYVdXoZoc4m8s0l3LnOemk6lcoIUFRxIfvuCi2dS0DS2w0tWpUjs/WRVuh6iJ9RWUaIJeIHIg8kBns91OdlndqQFETgffyg/X1VRoP6GBe
    fAB2SLi6XMz+kIJmU9Q0b8v2KpzSfpAuVB0BkdouBWWj0zpjs7NHGeWVHDpeIj/5JIs6Sy4ls5l+/lny6IszmGYqDcXLpA7Ulft9L8ReC4EG1aBzWjx7q9sl
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=NzN1MpvFrResoN3T63oA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeDIAih (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:38:37 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755134AbeDIAie (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 122/162] kconfig: Fix expr_free() E_NOT leak
Thread-Topic: [PATCH AUTOSEL for 4.4 122/162] kconfig: Fix expr_free() E_NOT
 leak
Thread-Index: AQHTz5nMH0VVQCpJTUKfiSMnVpUEeA==
Date: Mon, 9 Apr 2018 00:29:19 +0000
Message-ID: <20180409002738.163941-122-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:mCgwi48WVC+mwJ0AxQ1voRg5I/pH0/zdDX3HK+bV+djzw53Ko0I7z9XZrH3rfJ4OlAro5m/YCQ6ayx4w3BHGTNTC0K+cHRLqCR/GArADfYVlZ6F8FkIMAIvOZ+6CUB7SUC2yQlJ5qB6ldTIwooQA8UZ88PPdLOiWagassa75cA9vuyow0+nuxcz9CT8P04w561lDxLqWacceX3nmrgSZP+Rhbac4ru9mvv0hCXDH2a726WekbrrsY+c+IUo7zOMz;20:2rMbW78wujd5JQkwoiw6kV8K0sBsg+3mvHFVj5D0rgcb8CnSN4NW5SxeCJPqZumwuHJ5Y1pIcRcEX3Npu9juMP21xCg7zEpDmNMUmYPYNL4dZkgp89tKzcdZ5mr2aBe0CwplIAUtzvwshUTSBNNBUGFwgtge2iCCIc45s//EHa4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ac329ba-669a-4cde-8c54-08d59db2384e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1095D38FABC693DDCC961546FBBF0@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(396003)(39860400002)(376002)(189003)(199004)(26005)(10090500001)(476003)(105586002)(39060400002)(86362001)(107886003)(11346002)(446003)(2616005)(102836004)(76176011)(6512007)(97736004)(36756003)(6666003)(6506007)(8676002)(59450400001)(99286004)(4326008)(10290500003)(81156014)(86612001)(81166006)(186003)(486006)(2900100001)(106356001)(1076002)(72206003)(478600001)(305945005)(8936002)(25786009)(3660700001)(7736002)(68736007)(66066001)(110136005)(316002)(54906003)(3280700002)(2906002)(3846002)(6116002)(6436002)(53936002)(6486002)(22452003)(2501003)(5250100002)(14454004)(5660300001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SPcvwdezqbQAc8yLTlttmQRwzAIpKsX9BvZ9q96JYwdlLJ3nFXUG+KlEhnSACSVbuxz2Cf/ofSi4viX56Y/iGMLFz1ZxZXb1c3DLmXdy2DjmByj9fPmI7ndb4m48jqIpRtyOYfedSMz9XYA3uACesdvLbMDTmTtnxEXmzS1B5RsechXOxLG7goR2OWHkkJf9L64NRfIsoMSzpLB9urBuOw2UoblD8HM81hj5YFhlbujRrpe0m8NLyVFRcCHzM4ozw26lPB07PMEvoZbaxluN+e+0zUCJ6nWMX11KhLs4RZQmG4YvDj1v/eOxKTGROl1hyt66uBDSuH68wNXgcjTLfxctx84UV/DvdkspHVyMtvWtf1BUKsQN+y2o3wSfWJHygbw8ls/yeec6ZbVAuLK3ZwE6MiWB7ULBCgrR/KZRNvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac329ba-669a-4cde-8c54-08d59db2384e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:19.6930
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

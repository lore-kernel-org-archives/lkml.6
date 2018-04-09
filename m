Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240112-2-14997787968709680827
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
    1523240111; b=NT/LKJNxmgajF9zduAc7jcfdaPfrSuqnrTGQ1tbvPwpTswDk3L
    aRR5CaDGxu9kM/2R3JXayxUW3+qBqWw+z26d0FwEHIMFJl2yAsfazTZQfrs9d6R4
    D44EVXc78cNoTm+k7JSsiTw2neswT9CpRuJI/oBrLyOHomvqlBPSWKzCzyF1Inwn
    FUlt10/4ey6Qt0M20lBodjaN0z4JzH8HSOpsaMgLP/1IIxj9oyZPoslgg0utasAU
    Cn7gik8nX/6M+SNi5txkFW4fihrrY6Y6kwqQ+D3kyAlpq+DLClKQe0dGdsVSVyxf
    h4xIkndAQ4gFIVQcxRuCBH26SwhBr7M8hkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240111; bh=eePZViUbVX
    4/ay6OU1Hq3yx/Yzr6WvJrwZzwkJ2l4ig=; b=HDzoU5sLeVsGJkehvMJSoTk8+C
    aQuX7KQQOf4Fz0qtFHatKZt9XRz7LczUgJnX+Srz7JFQHrj4+mQE+gLkB/FQ7Avn
    qMtchB9TH3qZto4Bd4431FsBTUXBzImur3/tFYi9jQ6B8N5UFj1KPvwSZkCrMjw1
    H/acustZaPJpcLUn2w9KsKHyZ4o+i7qHBpm0Rn+T1ysJ1bzd/O98EY5UGWnRve5L
    5s5yEHfvTehn7GdiYhtJ8c700xMOhBTcpvjBDG9oLL78zfG8zZ/NbUrrqHwwFacX
    3GTvxt+75/2Md6CH3OQKCr7g9XJu5WO6WLzRVWhPhrRMJ1BSEAZDNBxen2Ng==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V/WUPfzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V/WUPfzO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKGoeI0wKshJ4t2oah043+iHPEb5jCQHpX2a6nsFSs//hqUaWna7mTJ3d3dIH5Q1MsWnULSSYQd1Qod4ILANY/ae9gDLvDSkbN/39RL3s4mpNr2N7BaV
    4zZAf5QRwin44ff7lJEm8Pdp/FFfjyIyjCZopcHaO6VKIbMlAOChA5k8WPZvlapHnUp+D9UT+jXDKrRe+A85e1VnSmVbuymFrN4VyilulYHlK2d0220FiviN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=V425UOodqP9GXwjpo3EA:9 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeDICOn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:14:43 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:52647
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756108AbeDIAag (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Nitin Gupta <nitin.m.gupta@oracle.com>,
        Julian Calaby <julian.calaby@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 145/293] sparc64: Fix gup_huge_pmd
Thread-Topic: [PATCH AUTOSEL for 4.9 145/293] sparc64: Fix gup_huge_pmd
Thread-Index: AQHTz5kpQ1uW0kxqpkCXtVFxonPwpw==
Date: Mon, 9 Apr 2018 00:24:46 +0000
Message-ID: <20180409002239.163177-145-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:m5vF7hC7vK5pwG4UjJCd7Dyonqkurf2xk7Co0EfwayRntxW/+WK+z4ezVedflLCNpjf0TLrrQeT+UmIEMOCVKxS8ososLHS2RhzXKIPA8bXR8Azrm5Fm/3/nwKhCYyaWNQY/eRR/CBY0QJOLw0fA+hVNkoqz0j3/wrlZHIVA/yzTD+49mQq15WObrsnGgynj5h7J/I9xyRnAOxwNp8NjHFrEdxwkRIoHbU53r0kjcK042lNj0S/cpvOjm4FEjQEh;20:f80f9ny7FNfcdvH3btFtyPh7lOhrNXqsCodC0BEqyFhyjPAfoTGRVItXWOfwSkDMXXD+S9eTnmJDCcjzHPFKXmD2cBf7RwUBFlpE4HWivBxOHu/rINJ0moQeBEZBoWIRN2Q/elsKkPDEnQU7x5KHOXSZK2yp3by917NEyO0OHFo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 082b085e-8d06-4772-4bf7-08d59db11a11
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807D2F68DCA5640014951B7FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(14583001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3Dsx8G/cUECEisyXeKOhuyT0nsQ5FvHQh2EgFdIt6aNFvjjB7FXuO85OQpNX8JR9LfENfyTvhrVdK4TTQ7ri0W9NfQ7Xh9QSmpddxbx/7g5FRMu0MYxc94SwfYWHcxblVT2W74UpGfRndaa41xCoRIrjTAp9JgqDnlI5mUFAagpV/d6wNhPGm+j+Ga+ZWPCMn2y136ico5Fh90sOtfbYvlio414ZIs5pR4idu7ZWOFHE5o5MqDWLVH03zOlNTm8x/JKbb7cLd0e9IRpfS2QkbRUWwV7LPQgJvoyM2FXIOPjSDVSFf25HbgRcWNQ474XK1wzGHvW9xMZvHGaEl9AIucoJEep5E3KzIerzrxMQCEDVAnZstI7IZV7cptarU5xIBPqeVD7UQT065fMns2obSVd8t4Ysmt+d53DWT2zdlBM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082b085e-8d06-4772-4bf7-08d59db11a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:46.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nitin Gupta <nitin.m.gupta@oracle.com>

[ Upstream commit dbd2667a4fb9ce4f547982b07cd69dda127c47ea ]

The function assumes that each PMD points to head of a
huge page. This is not correct as a PMD can point to
start of any 8M region with a, say 256M, hugepage. The
fix ensures that it points to the correct head of any PMD
huge page.

Cc: Julian Calaby <julian.calaby@gmail.com>
Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sparc/mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/gup.c b/arch/sparc/mm/gup.c
index cd0e32bbcb1d..f80cfc64c55b 100644
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -78,8 +78,8 @@ static int gup_huge_pmd(pmd_t *pmdp, pmd_t pmd, unsigned =
long addr,
 		return 0;
=20
 	refs =3D 0;
-	head =3D pmd_page(pmd);
-	page =3D head + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	page =3D pmd_page(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	head =3D compound_head(page);
 	do {
 		VM_BUG_ON(compound_head(page) !=3D head);
 		pages[*nr] =3D page;
--=20
2.15.1

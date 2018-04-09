Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234407-2-6108017703974813051
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
    1523234407; b=KrngXbJ0ZACN+AgPMgkXaDCW7IqxYCNI9qL9owft19kZEgqsUa
    O19DkDY4YRGGYJSljTJZKPaQKjGbbAxRKMJY1y64DBBQuMm0+2YmX7drLBKs+E46
    T4cIy95poCnRbCuOWnFb9Jhe2Q16V/3dJxA7jX5bBUu+TN3JARdiiRL0XPnvty3n
    /sSrUJCk0oKibIrfOMsdoXeNmTrv454jlVp0lRzVZy7nF66ef1mTraJwX598JKie
    krWZ/3nZtPpgWMU/ZENHlO22NEDrAPxb4hCTde0aWt746pGBis5kyTJ2KdVnMqCr
    DJVlueKU54j9Cs+GjP4772enm7KV9+ScAX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234407; bh=XRnbKSqyH0
    ItemG8lmifh+/hTe1AiGdUofPKROOJ1Es=; b=T8NeTq5zNImGvR533AnEos0uCA
    yrRd70Vq9puqOT90GUJcajV1nPw/vW1eLPToWYfc1T5PyrIbJzFgF0qa6Z3g4q8L
    7ylEMAKF2iPzAtaxTw9iiZQOVMEFA/IKXeyfgjQeAONttA5HrANxtpLdyEkKAjgX
    YEv1JkecUR/fK3BvlqaI0u4qY0Qj3NnwRxi5MUDRj0xFjSBmwEIc0MZuIZ1AVodT
    Tzxz10gOLwbEPnbt+RNDY+7SV86GZQNU0Hr4LylTrIkgI62cXTwY40j1K0OXm1FK
    ax50g1JQ4d70jkQMoopmWlNiA02cge3pghrOAlEpVVtvXu+PP941kUodU86Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KFrQA0b3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KFrQA0b3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDGjHHTthhPIFcCTiuzjT45I4g2puIdaQCSy3NVrlOmjzUfpWs0a6GWbmc2Ls5rCGjDrK1nSA6tJiTxytzZEdS7WnkBmnA82cDMr4+jZXWAZaHWNq+tI
    dQBUJR4F2Ka8IJtS5K0wQDcXmluQqMxEjrduVmicrCdA5SD+CVtGw6kzxyrY/lUi4g6gvRuL0c9/RUCLSueje/xZ1QwDY4B47lob3h3fUcAkCPRGL8bPB4Bm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=x5rFD9gtvE0LbX0pWFYA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbeDIAjt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:39:49 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933215AbeDIAjr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 024/101] PCI: Correct PCI_STD_RESOURCE_END
 usage
Thread-Topic: [PATCH AUTOSEL for 3.18 024/101] PCI: Correct
 PCI_STD_RESOURCE_END usage
Thread-Index: AQHTz5qpIdRS8cw18kKrX4G+5/28Ww==
Date: Mon, 9 Apr 2018 00:35:29 +0000
Message-ID: <20180409003505.164715-24-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:PpTolWPps8RnWpUH433b5zfTEMacvXzZ6YJoitVoLszgj8oyQtG9z3keMbHgydFZytmBtV2lAX1gyJVrXJowUAMKRoqVk3NwwAW1SGXlZXTxS8118Cx0ZlPh4oxSqpIi700LbFHv+7+6XxoI3wkD852C5qWv57oxa1ugu50fr25NmSU8pYxp/I76RMbXizuqcmVeqnHyAFO5S99Mv/2Z92ib/zyAc83onh0v2K3vt71hwXJfOqAEsA+kSwWs/n5Q;20:PvOTbjho3XN/78DBIcXnqMjVYXUCIzVQhdrMGoIiE8v4T71y4zvR+5ji0Q+XqB+4Orh3GatkTbpOvzVU4X90Lib5fYvXvJJ0177WAKcV0AOlQ4UdzZzw1mXF2Q1ZoswOGTEh+XB2GSuUAaI7EodI6tGnG70m0FQU0VIGOgFlGXw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0269be7d-111f-4d6d-484d-08d59db261b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966FC3DF6CB248E52F70533FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: ixjlIk1zcYKfpINSU6DIcjTXSYy1iOuSq6WYj9kJ2s7bIfQyA8mKhjzQYLVKG8BcQOT5DrtgfwiyK8DWCdm6JM2hKMqxMkYg2ZIDAzILB/22JMi50kruk5/i7eKJLdgtg1AYUEgUsSqrfmcw4VHjU25/k0Rt3NnkfSGLde2AcFnyiuK47V/1nkekvBbibbTRyLLYP8U7AZi8frDQi8FiK8BmVZyNaED+X0/O67lk+je1BLynGwCzpnasYnBr0QLrqMGruxrOyWxAST1XebR8S5JPlSNMDLvHNrEPrFMajn+LWu7AjvrpkmN3FKQMK3U/ujmUdWKX58fNq4WtcCR/IpRVE+uDGcLzKl/T1M6/C+204Ui8k+mhL0/V2dQJB6e0qZ3YQXSDsaCwt7J8ClWRX+blaGIMy9LeCDIvFulT/Mk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269be7d-111f-4d6d-484d-08d59db261b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:29.4392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 2f686f1d9beee135de6d08caea707ec7bfc916d4 ]

PCI_STD_RESOURCE_END is (confusingly) the index of the last valid BAR, not
the *number* of BARs.  To iterate through all possible BARs, we need to
include PCI_STD_RESOURCE_END.

Fixes: 9fe373f9997b ("PCI: Increase IBM ipr SAS Crocodile BARs to at least =
system page size")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b3e63f567c56..71536c16de9f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -305,7 +305,7 @@ static void quirk_extend_bar_to_page(struct pci_dev *de=
v)
 {
 	int i;
=20
-	for (i =3D 0; i < PCI_STD_RESOURCE_END; i++) {
+	for (i =3D 0; i <=3D PCI_STD_RESOURCE_END; i++) {
 		struct resource *r =3D &dev->resource[i];
=20
 		if (r->flags & IORESOURCE_MEM && resource_size(r) < PAGE_SIZE) {
--=20
2.15.1

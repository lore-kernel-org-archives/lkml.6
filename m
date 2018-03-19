Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521494251-2-4813929424910431965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494251; b=fZNMSgd1PAsAQBK62Bwf3XtudUF6XitCoStjvt+jhDhI2Xt
    avc94ymQHGuTamRq2tYVurjBDcN91p5pWM46b+X/kJjiV7Nt+23fNYg3k7unE1xO
    fbMY52IGxsO6r7bQ6rSvJJniBxc4lgwwPAYuta8MqqQSwPzLQ+Wm0uOXEkaC3bfM
    Nik+yp9V71LmkibOPUEN5yDKMsFZZySvXaa3R6IAnQ7TjVbSOI9aRssbk6FDW3Md
    TEiDjl2sCH2tZrgbcc9/uRYchXPLgVwnhEkkC1OUOCa4ifu1RGYCl1GyMujD+Eh/
    gDHXB6e0VCsu6u5Se7+Xn47nWUWrb4CJrkpAByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494251; bh=3VNyog
    tcvuMypMNXhxO0HiRvQY8IX3wY5kS2jVpnNsA=; b=vpZG1WSBU78DCzLtl8GhJa
    Wtrp9obD4V+FTOxPez2IrXFFnobrh2KA9jx/15JM70X5acmZ693qTin8KWvGv+9t
    fqJ9ifE1e9yPn3e13w5SqDi1mMrGKbK0KW4i6JSQdjMwSZyZ4zfMqQ6uHIe7aaWY
    gDYsVIeC0cJ+oMeAfBeRVu7Pj1B9VigBDj16LWqRi0OdzZnyGacIZUFpV21omfdt
    s/btwHjvUL7akF6qp9EX68xLy55q6JZ1zDYQ1/q0On0o8XW/rYQ3myIi5WvtnFYA
    Pk4UV6mwyKDMaYfZVi8pzj2FuHYveVhQVn1ftA8KP1lL8b2EnosvGw0QsV5cejIw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAgErPQ+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeifeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EAgErPQ+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeekucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdeifeenucevlhhushhtvghrufhiiigvpedvle;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934913AbeCSVRW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:17:22 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:44079
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965290AbeCSQBF (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:01:05 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 115/281] PCI/msi: fix the
 pci_alloc_irq_vectors_affinity stub
Thread-Topic: [PATCH AUTOSEL for 4.9 115/281] PCI/msi: fix the
 pci_alloc_irq_vectors_affinity stub
Thread-Index: AQHTv5tb/Z/dON47X0SOmn7mZ1rXtg==
Date: Mon, 19 Mar 2018 16:00:10 +0000
Message-ID: <20180319155742.13731-115-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:cR2mceUcvMJIl7K2KWLInMhasIukfmVPAPPjL9ZDshleLWo/X+BNrLGeAvV9qTqojQUCGdqj92BJ093G+bbf0W4jaTJTN+ZDjfD0smKi1q3TjoLzXwFc61AtZtT0x0hCHBz3xrJ6TKhj8RruqcAsn10HSx5aBgdW+mTcjPbHsMpBi39khgLeC+vFUGdW73dUU1mt1SqQ07tEAfa3oOyNyvSPSoICmHyz1ThKUUj5HFg/cYIS5QYXJe5YUL9vJhXT;20:sQjY8XjIPZibOZBDCsDM5hbhO142t4JTJIPpuDqVUT3TejxPu2uXf0u/gDueIOE92V3pD2QIaGquXkNAV1IAhvgEu7KRk97m/cZ05B0LgAW5pIUc8gpcMfWo/+SnaqKdG0ncm1NlGIF23lZqSsxdwBtSAdoqdLlptfybFgozJeQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f366a15-7828-42a4-a1bc-08d58db29d5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031114B635104692F9CE33AFBD40@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39860400002)(39380400002)(199004)(189003)(25786009)(6506007)(66066001)(99286004)(76176011)(10290500003)(54906003)(68736007)(3660700001)(97736004)(22452003)(575784001)(107886003)(53936002)(86362001)(110136005)(2501003)(5250100002)(86612001)(14454004)(478600001)(72206003)(316002)(102836004)(26005)(186003)(6116002)(3846002)(7736002)(2950100002)(10090500001)(6436002)(3280700002)(6512007)(6666003)(2900100001)(8676002)(8936002)(36756003)(106356001)(105586002)(4326008)(5660300001)(305945005)(1076002)(81156014)(6486002)(81166006)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: VTblJTwQKl9VqWPixoGsBWqwwgWU1cM+Vs0g5xWsXV4AajUG4Jno8qW1D5GXsztIhSFVxCU/Zz0X6xVom1Ax2IIdTVCcn6/OssyUXGq0qsH4J50aTRze7ZSn+rET2jv+JiW1pOkRiRdhoT8gNlcSHs2xblx91lUdxX2g650UNQif+g8BDwoJ/FMnGh7dAMeTWeaP05kdM5NV7+JqqD+GjOg1LcR6plF15lOsi+VzXF1fA/u+XMcPNfVb+a1B2UgvPlk/Q03694H9+vG1UwnQr6JCaSJ27ft47SEP7fVXMKwU2foE0ILDS0BhF29nZ+c0E5b90auUs7CIPbAC2z76Cw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f366a15-7828-42a4-a1bc-08d58db29d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:10.4551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 83b4605b0c16cde5b00c8cf192408d51eab75402 ]

We need to return an error for any call that asks for MSI / MSI-X
vectors only, so that non-trivial fallback logic can work properly.

Also valid dev->irq and use the "correct" errno value based on feedback
from Linus.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: aff17164 ("PCI: Provide sensible IRQ vector alloc/free routines")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/pci.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1b711796d989..36522905685b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1348,9 +1348,9 @@ static inline int pci_alloc_irq_vectors(struct pci_de=
v *dev,
 		unsigned int min_vecs, unsigned int max_vecs,
 		unsigned int flags)
 {
-	if (min_vecs > 1)
-		return -EINVAL;
-	return 1;
+	if ((flags & PCI_IRQ_LEGACY) && min_vecs =3D=3D 1 && dev->irq)
+		return 1;
+	return -ENOSPC;
 }
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
--=20
2.14.1

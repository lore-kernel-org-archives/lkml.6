Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236735-2-1885128286216236672
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
    1523236734; b=kAyQHD+d46KBROI1Ga/NIW3Ms4lrVnuJ1kqNV9lZpBfIjfm9pt
    s3sK8kWdhVHghIdYSz61GcaDuf1j70lUhCPaxSfQdLU1UUF8FqJiFvHcrBFa4hNH
    SlZEKwKj07tVck+uOSQBX3ftqGfsIlE+BAek4MlscdSQCvzqKdzUFea4+je97+wC
    /1JYBDV9O05/XFCSdY2GgroMKqFZn63pETkH+rntiQ7j0aGzaMYoDD6sHk9Nkfc6
    ff9aZrM2h2C7ta+6AEHfK2kYy05YHWtMH3yKLbNuY/KMMVlvHxDOQpA2uSdhA8EW
    AK2SmtfvIfQQUyHJdGQvdRSOdCZx/f/ta5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236734; bh=XulxUIFdhH
    ZDdGKXd2K0KQKa+bKjnPUefq/SOyen564=; b=EVtodmLKPrBXziNoovKaXisU9W
    gQqSvM3ilQ6t2TApsO7eD0jitB9hxZgG9X3xEH7ux8JmFA3QfWCUyj4ueUHp5B7E
    iuxsescuuj1iDT/9ExME156oHpdbJzIp7Sb5FILEs6ShlVeFIpr6YyEzWqGosLtP
    yAo8c57QhfF+65HaqBKmIqgCDcVoqPWLrNBkHfOqUsVuj2AKG6SNKRTJpFrug3c0
    xQpy3a0AwnQ7dduu/Hp0ieK4gNgFBgX348/vbi0zeDmNUChdIaojYbkO6iwXNewI
    MXf4ArNq2ZBkXSJSpkSjxlUS1XopqAjTfOmD0ZAj2EUPm3U1vyz718BF5E3Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eEoN9BOp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eEoN9BOp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfqGWofUMyZ9eunVOKy2VwkT5OrrWJVVB/xQJxk1TyiTca3ppDPOIS6aTGajPo9odzBsKcjl2Uwj1PrKw1Zan5cA8Qx1B7EolFLzhzeChh+OAWWGmq8
    fPBVXEg5Zd6ImPabCdjJR7XqJCqxTRj0LqJlsQa9zaq5aEuZyCmJBfedoYDOW/OCIOiWe/r+U10KPUCMfzQTRW7sLAA6MUDblQANL+Xsys7ZSkTEVkqoXpAb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=yMhMjlubAAAA:8
    a=6qjhLcChD2huaRmL0j0A:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=6heAxKwa5pAsJatQ0mat:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757260AbeDIBSu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:18:50 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932824AbeDIAhr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 101/162] irqchip/gic-v2: Report failures in
 gic_irq_domain_alloc
Thread-Topic: [PATCH AUTOSEL for 4.4 101/162] irqchip/gic-v2: Report failures
 in gic_irq_domain_alloc
Thread-Index: AQHTz5nBg2svcAuZeEiWgsn17yEWoQ==
Date: Mon, 9 Apr 2018 00:29:00 +0000
Message-ID: <20180409002738.163941-101-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:XPu656OxJdrKjuGnXUMggPDhNKbuwjiZuckHa4vt8mUGeps5R528gbs7Vj2kENvAEuZU7TGIp5dL4loD7GJutd05ET+06PIQl6ZLp3kw7+ehPUT449sDqHjFdm8MWLBxUCZNoEV5Hkf+oGCMXEcMaCwpLcQnMyhqAzSjn4HB2mILivFEcwzNrPRNfzyMKDh6KBbkL65n+5CbZ8g5ojU1Vfcz45O4oSI2pDDDbJaGU8/1KI2a4NdRaku4QEHRxCx4;20:tFw9UlgbqXz2fhM9iGkratlhOZaVLkB1GIFbhicS3lyEp2C+FsN5R9EeoGI0brA/TGrwpjVzaTZXzShUvTfcAYb+JzZ46y5lgRRvrBaKayIiBqIys53XIPCPMZihgmBzMpQqPDoR4QA/4DexUh9IeXEFWC3etquiLV3H6r4AkNM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3e6b9763-8d43-4508-1fda-08d59db21c65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110E990A3B5C3D375B5BA02FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(3660700001)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ewy1JfafUdoVXgx5umgYqEJXqKbN5CGAAKYnsTEv03xVdB9o/TX9gjhw//DvL+Hl2ga7jbu/nytFqv3uzZpGD/7hM6CkYSqkjd6hAbQTg+IgvD5REh/Cs/5JI7bE70meZ2ZnKqAHIAAqUuwvJHC7KIPq8PvfIAT+72RzsFUXLopShprO1avr2B18FHocwLpGJ6Lk/Ur2ZOOh/GvDApDJ9rnLv1LoW+iBq7A0c88/BbS9047w92JEWiAsNjEVRAy0vNVAjgbUqscEgWFB0r36Td1+eItxaDPCUeXbCHrPb8zj/LG+HfYtktRwjTnBYkLKbPtUy7mRB+M9kf2pDROhqMdflPmu8l4SopQ+xQXxIkyqZPMPP2m/y0gfUcK7dbEDE83CHW0HaIcql/hsQ/KFnv4ucP3OrxqlF3Z+vSEuFQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6b9763-8d43-4508-1fda-08d59db21c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:00.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 456c59c31c5126fe31c64956c43670060ea9debd ]

If the GIC cannot map an IRQ via irq_domain_ops->alloc(), it doesn't
return an error code.  This can cause a problem with drivers, where
it thinks it has successfully got an IRQ for the device, but requesting
the same ends up failure with -ENOSYS (as the IRQ's chip is not set).

Fixes: commit 9a1091ef0017c ("irqchip: gic: Support hierarchy irq domain.")
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index cebd8efe651a..c3ddd80d16e0 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1023,8 +1023,11 @@ static int gic_irq_domain_alloc(struct irq_domain *d=
omain, unsigned int virq,
 	if (ret)
 		return ret;
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		gic_irq_domain_map(domain, virq + i, hwirq + i);
+	for (i =3D 0; i < nr_irqs; i++) {
+		ret =3D gic_irq_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
=20
 	return 0;
 }
--=20
2.15.1

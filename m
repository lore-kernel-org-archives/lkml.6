Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239208-5-7198789643265205031
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
    1523239208; b=DMnHE+HOxGaWhagtjlFy89dRqLykxxxTRUhqmhcQJgBm/e5o5B
    eX15VZFbex8BsVPDII8rY/Wxzjc6wWHXvj0e/UH5Pu9UA2gflxYh5pV0uqCVTInq
    umpMqWf/TMgYYPdRzed9uJUbxwgnuw8UdsyBJZO8JFC4Zc4WEAR1xeNlmT11WF0U
    f0d0lOY+pzEP60B2q8L+q2ipRVAE4ca+SurOY9n3edHxKfh91TjGbDc8pHGKJ8vC
    xFtHb2SOOoLX9yGnAXVg+YRuf9+Ja71+41nK0Zhrm5JfS23WUnkUcWIt4cNa92Gd
    WDZVXHBzfQt52J0gGlCw55U3HlGZifsLbEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239208; bh=q5qJbVhQbx
    lknUqU1dHtPm6O50Jz/i9mzzR+bxv4mRE=; b=Vz68izFKYd2I1tICbQ1b2dX8A/
    GWwxLcHKWt/c43cu3dtPUV4PnWJKA2nxC2qRvnD746ecWAAAqN7E5FwJE8yp40sj
    8vRX1D2z8dvpNSRcx+pAOHM03sew4NsZ0YveFuMMMU0IEZGfJN05cwk1OenN92Di
    5rNYK86Uh/Z2pLutKyCOMZWWLd4vY6A1PXOs+hx3IrmxqRm9KMUqzuTGoQdh57h4
    MwUyhm36aAJAFkd3w+4/99FM14YeoZ6tZyOueLYl6gudp+H/3wI12gAoKv02aPxi
    SL0UD2iFxRVMBt5i8dmk8DFg/hG/2JTB3EWF3kGO4W4bQ+TYs69izHR25wQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YRz6ho6T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YRz6ho6T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/83cYNgP5JuTYtxRKPfDC0CIsYHvzosFZv6qCcYVDAXP2FIc4y+OiLCX17iEOcf01CyBLb7GQX/AL7GRIrFbRcr/dzVe6TbDB+7CVsME+O2e8RFkHE
    ENvXERdU8E2Y9P5CiFn5aGs3wCN4cyttjyvABYelMrKLn/UwKKhnd26rkk9yGy+53gxCPlG3NiuUIqQ/U7stP2bxVDshMoMFia1du+wNWbcS+cLbNJt+yjZg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=yMhMjlubAAAA:8 a=6qjhLcChD2huaRmL0j0A:9
    a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757564AbeDICAF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:05 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756474AbeDIAcQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:16 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 205/293] irqchip/gic-v3: Report failures in
 gic_irq_domain_alloc
Thread-Topic: [PATCH AUTOSEL for 4.9 205/293] irqchip/gic-v3: Report failures
 in gic_irq_domain_alloc
Thread-Index: AQHTz5lG3PosLW9DP02npwe30wwDAg==
Date: Mon, 9 Apr 2018 00:25:33 +0000
Message-ID: <20180409002239.163177-205-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:/iGxAStPtvuejygmH6xEaWabouqHA/PzNa9gFYtmUA65Xy1JP8Swr0SJYwbfa6Gx/D5666bNPd9pQGqIJUs0jXjOZwjaStsV18F6z/x5G6OhfELFEJpM6UIhE1I73Sia4y584erNbrQzV5QaGzyeEdBk6JccKRMISr36VABb7Zq9qxOOPcp5Fq6S/qj6Yp3kVIrwvwwKeB2NN5qYF8VuvfNiaaH7ohgUZk96t+YYnE/32OcFHcXQTCSt8KVXfTC9;20:SvvoX6GY/g8oESk9wt4pGvLdFq336oYYr5jgQ/qDX3VufR9mCLvlpEXqzfoqJuwnn0AB6cCBV6mCx2lT5lpRxngciPamlrJIu+jGCdiBBwzFwuCRd/3MT1u5Rqo+0Fq6MuxVeEHxHidw21h7KeOWgo4mF1ke053JcEKKIx4Tcgk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 854a81b6-b4f9-432a-f6b2-08d59db154c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08702AFE9018B3D5FF78EC8AFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(575784001)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: I237fOSaiqnzt4ARkacte3mOh3/e1qylMO9utbchpsflhgDEO3WbvOnVzpvF4nfNVBpHGjVVX0JEAZ570huuI7YhysYQ1IXqID/MqoWHkhqKPcrC9/D/dGyV7+CIrwVWiInoeqfSL5s1j/XxumKEW4whp/iRvXnU4l0IJFdspoB5/tN1ez4heRYAHbCfj7iRzdrgI9A7O2w7o0PNMxnmNWiV/F4gEfaysmN4Ug0kwidKhUOKe3LxD3kx3SABRCE6tiAZvktd/8Qw36Hav0bSb9oNCqG3llS83aIuzWeundQoqxw8a7WCmB8Ay6TmvDZ8a9YdHx2p/AvswDQdGNgRbtX8I5zLIU6+FKdo+nboOQOG7JljKcFlUmo6Xo0qOykm61a0ut3v2lp7c37fiZVv8+je1v9hAvugg/McbWyabYo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854a81b6-b4f9-432a-f6b2-08d59db154c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:33.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 63c16c6eacb69d0cbdaee5dea0dd56d238375fe6 ]

If the GIC cannot map an IRQ via irq_domain_ops->alloc(), it doesn't
return an error code.  This can cause a problem with drivers, where
it thinks it has successfully got an IRQ for the device, but requesting
the same ends up failure with -ENOSYS (as the IRQ's chip is not set).

Fixes: commit 443acc4f37f6 ("irqchip: GICv3: Convert to domain hierarchy")
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4a78296b48..8c7f02318a6b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -832,8 +832,11 @@ static int gic_irq_domain_alloc(struct irq_domain *dom=
ain, unsigned int virq,
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

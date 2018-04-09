Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523239243-2-10577731996443363610
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
    1523239242; b=Pz1ZEqQw3k9c5sqpHfH71RlVgubEEqLTpz/5sMrs3mwUw8rkB7
    bH6Eq/7C2VxfiSXceGZt+7vPGhIEKYI9hT7g6OJXC3t4DlAZid9/ytA4njk9eIpS
    fLbjp87Ajut/Gq+Dak4m8i1FaWmTU18FD9QkBLcHNu0kRwUqrS1JHzZUa7HZiWv2
    IWC7kzVFwHPKtVJZGqldaw5pJlJ08OfiVQ7yFbPmNK+Ax8bb6m+bWRBJLNomstxS
    bkJUJkqv/1yTpX5pBBWrafn/yB3U47eWYbcnZ68djN4dGOd0DuK3XoPlKqcehDho
    v3Y6t6PN3RTrW074rFiI+FnhoWBvvu9SUM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239242; bh=SYxekZH3S4
    sverNuHW3o1GS1QsAsEJDBnKUylKERaXg=; b=ktxI2lOqXZ75YCmcQvuIGeqZI1
    8d4vJeUDGw/h1rtg0AhDhFblyVEF0aRYxDO9CyKFleFsSB82jKfwwxbfbU0+8i4D
    lTDURnhEuJvM9gz1FLvKBB/g3Oj+edR5HonRrcKqFKBaHQoDeWWMP2VY9IoVXgng
    hvROFemQnDvVjduAwDjj79alRoWYoXEhSgGJ7rumw3O/4nwSd6YRZaT/+gIrXeQ+
    DcP+oW/RM5c/K8hOxP9ijJ2SChOHJkjzXxS9GmPxhirqIABpQIPOlkGXId4haaMn
    4Xe5zn/yAX5t2P+JWGI71N1kxHfNNdgqPSglQsN/yL/iiqOqBuD/5Kb6Aclg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fcQYkxmw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fcQYkxmw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDaPBUXeww1xp4vImYxMPP/ehI1LpQ6zSZoSapOm7/jBbZfMX+yEymrZ8UgSdEGl2RneGpQsssyEeq+lnpNftdeA1W9xgcum+Q/PjedDtpNJ0zf2+RC
    7kJ0wCkdiT9+vyj5ueZTmglvqIbwEHO1Ho0KKienWiXttRjzJj7oRKKUSXoEPbdcf4+i2iOzojWsu7blA5mV1MtP+SvV/cWJUDgz7zPAEO7/cdg0vGjfLYwR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=7CQSdrXTAAAA:8 a=mpaa-ttXAAAA:8 a=yMhMjlubAAAA:8
    a=6qjhLcChD2huaRmL0j0A:9 a=wPNLvfGTeEIA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
    a=6heAxKwa5pAsJatQ0mat:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757575AbeDICAg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:00:36 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:51937
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754677AbeDIAcP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 204/293] irqchip/gic-v2: Report failures in
 gic_irq_domain_alloc
Thread-Topic: [PATCH AUTOSEL for 4.9 204/293] irqchip/gic-v2: Report failures
 in gic_irq_domain_alloc
Thread-Index: AQHTz5lFeEVBnZN7FUOF46izyEuJmw==
Date: Mon, 9 Apr 2018 00:25:33 +0000
Message-ID: <20180409002239.163177-204-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:WI+63vzzqQVpd3otmRrsmpkXyXgrTlb2cv0PH8ejkK2k83aJFD9ZazWObUj0PIPxb1oCrQon4F5nfshyZKXZscERXYV+antb8u9jnW+a6wQsnguB875hoEerUTLSG0FrdQnh0DOZlgLLi6rYQNfwr0LYiSbWA5IPJeeKPgffLUMKyfoC/KixM7Tuqc2y1KeTXLrb3RAdr8eOC0GoAl32b6plK0Yqhdk4FOAf490BlK4YBubdNOoGzyk55sHUe7Cj;20:amseRNsUO5a8KwTJATbw40PEetM0tJa14JUNo4i0gNDFBUFXqUPpJEtUQmJQ16jhzxnVy2axv4sCFunoL8olbcEsnVI6UvX6vGrMPeRZFyYS4o2BIECGlBoKqggHQM7cvzKVSVlyYlGFlOXpUzgF4JpMBn6KHP2RU+2CCGi+wMs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c6d9ea2-2f7d-4a9a-34a8-08d59db15482
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870E9107418E509CB83100AFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(59450400001)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zDMyZx2sGAAP2DGy2agyjW6i+awAarU7YJLz7FXX7VgYMrd6YrEx3TncitFpG5IK9jq18xEDv71NgchT9yEwa2SCxcbfo2Txnj50E4jW9T1HZy7kztTqcwUFoEI1m0KJLkWogSycveUEw4/pwFLVcmnHqnDRwiOaF+Ai++rgg+I0JVlyj302Fx0lpTrZ5IoS5YzDNL2rmdI0YXUeoYHohUZGHL005El80FthNJGLRgjKN5N/a08G2lvWpXuDTbjORQO4HztG8inCtnDLX2GzWA4i0BZuPDdIRc6om8C1nRIqSFRpNAt/k7bDXkOPGO4bS8JpyJSMaybCJaChWUqOcXDbyAxonPMoo6fGtvGq4EmoAY9MtDLgHtdzlmdTU8DY/8HF6j/Mpy5RG/kgepzgrCeu+32Pjf+dbAHlG2drrdQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6d9ea2-2f7d-4a9a-34a8-08d59db15482
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:33.2221
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
index d6c404b3584d..230a4da1e196 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1027,8 +1027,11 @@ static int gic_irq_domain_alloc(struct irq_domain *d=
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

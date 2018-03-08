Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487859-2-11513615135538191056
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
    t=1520487858; b=dEqLrVLvWeDRT1Z1oF1/TbtajtkEzqTAjkkXdWdO3sMUsNO
    e44VWbCDqnEy64xtyx5dKzlQ+GlPclHFQDo+ByaAI+/727loVU5R7XTMbUZDDSIv
    qMtv08ApXFcHQqqvFDgYGTtuFtT4srtNjU2/fWtpHZ4f1nPZlAjGdzHJv7xHfam0
    bGKvXwGdR0KJXeE7CmJKHFqHarX0TW77YkYSlnd1d7EoMa5Spubz6TDfcI+XFu6Q
    gsCu8/+lAr344k34DbyWgyUf7eVH6OG+gfDeqUYXt1pFZqbfI90GklHGu3/Iu4+X
    FYNxSn+BLgbd9PSs97D2GmUcxHAnYg7pLJVBe0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487858; bh=YXbPVx
    DFWj2XiKdgppuPnmMiQh6bMiAwGa32zAqxs/4=; b=bFreQzcEW7qKeJ2DlcLLxv
    e4eE3JN81vNeOY/ahvTqeRiApmsJzxHuZujFwZAGHx9OPPmW3nthD2jt7mLSuxD1
    i/UCpdSFMlKWVaFESj2xch/J1ZUDZeZMKzYgGgUWqB3Imwmp5qBu1JEn8ZH5GdoT
    Hac4mS5SEQdUvU2YpAP/7m3Q1Z95Z0a6NHHRk4McwyGPa6Ihzq1OHpO2WOEtlCIV
    SJBn7ToPjlgM43TtNHNUkPmZymL0zkd2KOffnqtvaErCSuKfGlrE/VURRKctrML3
    vgnLETIWZwJ459oNrqEm8xL3o9Zu/fdmYnfKBUVaNrv06VT5Cl8FZBllNPSSlRxg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ro7Odixr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ro7Odixr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965993AbeCHFns (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:43:48 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966200AbeCHFFS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 020/101] genirq: Use irqd_get_trigger_type to
 compare the trigger type for shared IRQs
Thread-Topic: [PATCH AUTOSEL for 4.4 020/101] genirq: Use
 irqd_get_trigger_type to compare the trigger type for shared IRQs
Thread-Index: AQHTtpqG9GJCRJBS4U2sIWxi6ZQqWg==
Date: Thu, 8 Mar 2018 05:01:32 +0000
Message-ID: <20180308050023.8548-20-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:HNsySqApxWdD0zzNclpmBrCYQrWloKqdvVxNwmnACCFoFWC6sr46XAVLZIVP24J8U52n4h+LfpNRrO3bMJ2o8I/lAq7tozSeY2Vs+zeXvglPiOFWrpKjqZALVrg4J/d/VN+UzDc3/XIkXpztwtiXvSBsR2wm4oOrctzuwHXUx5TccRjZf/KlXpeLACehxoVYU3BUPem0ea3W5eNS1SJR7UJ18Kfta1zbBUxIjBIqTKTsWbNmMgRQqMwG8kVCqUf8;20:XWFZa1oRuu/NnBxMPTMPEP7OXVB+i1/aa1xioxp9eQfIcIoj2IXSSKRJZ6u8A82LPLVaW0iIMp/iEkMgWmIhB24F2ETYMLRM8beLXyG8FnF0pwjuAPKvf40MalBDHmpuCu6o0zaRMr1CQtuloAuLocMWjp03ujlz0Y6o+fFDAx4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6867d1c5-fe2b-421e-dcfe-08d584b22c8f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727BDD11EC3C4FEC4FA6857FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(6306002)(5250100002)(53936002)(107886003)(6436002)(966005)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: N/WizQp+jpRnwbbK6DVjdBUu5pPm5VfeWbGLW7cvUYBJKGf4dgu+zfdsrH5nPpXREBTOyf8S/iOUvI5tVyjciztoUL69yQkEN/6azmqgCm377kcl8UiTG14jf6tIkrO7KNa/puEUBiyvlPaQzHMVMu3IEEdboqRBgfwXwinoHBpQNBmcd3sXUXVVRUqnGkno2nAatxleHot6HJD+huXslBxvkH5GqDBVqwE3HUZ0atFBhhS0RrjzjXp2FZWLzMUb3HeEbsclwP0ZAWLZf0PBTKKFbjBb4nr8VCbzylTt8rPSR4cxpIqa3cNG/59mW3YGFVTYP5TVd+H13M9x0IwDsw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6867d1c5-fe2b-421e-dcfe-08d584b22c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:32.3967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 382bd4de61827dbaaf5fb4fb7b1f4be4a86505e7 ]

When requesting a shared irq with IRQF_TRIGGER_NONE then the irqaction
flags get filled with the trigger type from the irq_data:

        if (!(new->flags & IRQF_TRIGGER_MASK))
                new->flags |=3D irqd_get_trigger_type(&desc->irq_data);

On the first setup_irq() the trigger type in irq_data is NONE when the
above code executes, then the irq is started up for the first time and
then the actual trigger type gets established, but that's too late to fix
up new->flags.

When then a second user of the irq requests the irq with IRQF_TRIGGER_NONE
its irqaction's triggertype gets set to the actual trigger type and the
following check fails:

        if (!((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))

Resulting in the request_irq failing with -EBUSY even though both
users requested the irq with IRQF_SHARED | IRQF_TRIGGER_NONE

Fix this by comparing the new irqaction's trigger type to the trigger type
stored in the irq_data which correctly reflects the actual trigger type
being used for the irq.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/20170415100831.17073-1-hdegoede@redhat.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/irq/manage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index a079ed14f230..4889a8ab77ce 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1189,8 +1189,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,=
 struct irqaction *new)
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
 		 */
+		unsigned int oldtype =3D irqd_get_trigger_type(&desc->irq_data);
+
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
-		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
+		    (oldtype !=3D (new->flags & IRQF_TRIGGER_MASK)) ||
 		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
 			goto mismatch;
=20
--=20
2.14.1

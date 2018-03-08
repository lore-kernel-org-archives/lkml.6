Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486305-2-17262858755800769874
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
    t=1520486305; b=iywx7iM33UGDIZ8STbQv/a3Mz4a3AXB/fngLbk/SDPCvZdK
    2WpxAeHz8nedfrbFmM3P1cYcIxJ092VgnSB6Ar8OUZYpdn+rUNrrJo/vMpqxiSRo
    rtmM0Bv9YKhBpkPa8EQnKTkk499VYbb1qnnqAgpljuBeu+aePEAaUPneWJ2jz85l
    2pl0j62zkaJHNDa7hEjB5zvU0T2WHra7MLFXZspaExHj28Wi4lKl1Wn32CFeSe1P
    MOpBu/5A5Eqbh5MCY5cp/wJZitvUye5Kx90qPSDYYa2ABPcl4iwzeI7eihytGUJW
    1I36q6A0XxoiRVxzxDprcq6QxSOW1ZoHnB/ZuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486305; bh=Mh5eR8
    lCN5VBosfP1eQGgbTKKqCaaY3lQLEMEXP2ttY=; b=H3VYK7pe3/ESUn0w0dbcRI
    ILm/rZF2fWJsjtZrh348ILAOhX+QZkVVIQe6VpFM4GfdCaNwsv5jHb8DACzksAUA
    4q/1sOtMSyV/vDk08636d2FovquLOQOSc5Ud4uPVC4pMZ2Rfcj+dlFIBhbLUOF9e
    qTzCZF8zbYNBgfX+tWrbd0hsme7K8MNKPLWOd1xkVz1XjT8wQ799FvJec+zoQaMw
    qKJ/CNIHPONHDdHbQyPAO/9frFqawAe+fR54bqN8+Af8z7fZ89oLtsA7lzF7OJYL
    HmxBnIVzrA6QPFAdbW5tB9/p1Ux39QnSfvJ9rTguaEuHqHEUn1eMV/kJWK2NDvUg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TtLZcvF7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TtLZcvF7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966447AbeCHFIi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:38 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966277AbeCHFIg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:36 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 13/53] genirq: Use irqd_get_trigger_type to
 compare the trigger type for shared IRQs
Thread-Topic: [PATCH AUTOSEL for 3.18 13/53] genirq: Use irqd_get_trigger_type
 to compare the trigger type for shared IRQs
Thread-Index: AQHTtprCz+nV8XiYtUyFStTX6svnVg==
Date: Thu, 8 Mar 2018 05:03:12 +0000
Message-ID: <20180308050230.8876-13-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:fp27MotB1HLahDp28F3not3tAEZHCc2bz6Z0IKuQAD10FLzplLN8GZpvJ88+BE87v81SW/+hY4yE+6yge1gXTd5OQvyCe1mOnbcVm8+OnEmW0n3AATl1yQjjWfXrFQSnPCZDnjWA4QaDnza0BrAIql6m5uc7WxphW0nitR5hIky3fZp09TfarSHf57EEVX98AF1ORsi9IJA96fHrf8OHXBsXO7GrfS+RNJn7pbawuTaBz27SMUiivQyCxC5R/h5d;20:29HYA7197WHqojj6G0QjsJtZa2jIb2ZkE8t8qe5izv2IswQDKiyZdFfRuHUrC71sQ7yJORydsleSKJumdXoKnzvLQdQASsJhA19r7hsneiobqL05eqzt7RW+lDHUkuGrWP6X0VSbF6lRQu/AF1cyeL7AxD8nvVIu6fKpu4E+BIQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8603b1bf-abc2-45d8-7505-08d584b29401
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871D9628E453E213864267CFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(966005)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(6306002)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: aPFzgi+5JgyZR7uBKURuNlYdoVdfuv4+1QU4dP+kKlE7PMhOThwEE307FcbgoNnkKfFiiW/6OpvbL3EmInXKbvYseVTL/QZJDnM/Xfr5xQWydLQjpb9o2iyoULG1S2R0WCwynI6V1qXSUk7n7dYXaTN93nqGdGxs+YY3OG1huEQpJjEbUnHwpldoUFDMdMaX35Lzz07MYsynZJGvixpFgpHV5o0CNyyjdMtA27JWo0Hy8m0SGEshK12DEc0k6fP4yVf6GFiDgjbox9lIVfd1dI+kh3GgZQ4fClEVlkf1ZmDrDg2mqKMTJRLexgWQrlwSr15iYbpcsv8DViTQ27fbYA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8603b1bf-abc2-45d8-7505-08d584b29401
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:12.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index e7ef539c56d9..5f23a04789db 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1058,8 +1058,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,=
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

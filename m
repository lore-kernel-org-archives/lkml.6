Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490397-2-10773418189760380157
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
    t=1520490396; b=HurxwI0Pt1wliQYh9Y9+lpdTqQWYifkAlHlJIvbKH1usrJt
    MQri8rU4u1iEKatocQwjbGbYRcUQFnJSxG+PqXT4rt9blwi8LdbGLIVouuM3RIwk
    Y/Fss1BRXxd0UwbwyQ4/1GY876PFP6XU2LqHBYBh25Skt3vdJdbpGer38dSZEh5u
    zJC+yT3AJMZ8iO4rr9xnFv6XN5j0le0yfQcBseolH8fpfk3RnQVpRFg/fF7wWTH+
    tMXvTrfKqkIw0jBvz4LuXescL88ucWQrHc8cVWrSGzvyZfdyvxfJ482yw5U0NY3y
    ZEXOFWKqjvAzLPZFFIlSKZfSLnQ/4zHOx/AcE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490396; bh=yCC+4r
    hlfwndecPePzMdZdpNpHZHyRaY3ZQs3xhtF3g=; b=HVrNjs2qRKpQqs3Xpr1JBq
    h1k5esfx8HcOaWjHSaZflKb0gSXh9vUGL8NGPUYhLUuDmfTlSBZBhgbc/kmgMVIR
    y79TZ+YEOqTNB7mxOYGZWW4r5/cnOj43F+XUTbWstdBUxA5oPNARxn3s4Xsz+ii6
    c8ggSbihq9OivrgVr0ECIHMKr1eKgrCGRdMwgMj9wzC0Fd5MYGZMutjR9hLOH3n6
    eTt3zU49IrjOtm5yfm5hqa6Z5D5MrYFc/V+MTEFW4p0OGvqFFwUZQWVqM0YoQLxZ
    VcYLI2OcLvDGc438mJQ8CcPzGleJmac3i7GumTXgAdlmwVFcAJaagaUt3dBPnJkQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NC9iL8zN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NC9iL8zN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935390AbeCHG0W (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:26:22 -0500
Received: from mail-sn1nam01on0111.outbound.protection.outlook.com ([104.47.32.111]:53598
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755294AbeCHFAk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 036/190] genirq: Use irqd_get_trigger_type to
 compare the trigger type for shared IRQs
Thread-Topic: [PATCH AUTOSEL for 4.9 036/190] genirq: Use
 irqd_get_trigger_type to compare the trigger type for shared IRQs
Thread-Index: AQHTtpowWp3g1Wf9r0KaatsZ5aY92A==
Date: Thu, 8 Mar 2018 04:59:07 +0000
Message-ID: <20180308045810.8041-36-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:AxD+dR1kyW2mV6qTqOupFVIPx27gam87ISnPxpwNlpOjDwitzv43IE5RbLyQZxg42Q1mcz3C/W/gJVEd8riOT+ZOIeIorF9VQFjmESSBCmXBQKZ8ns70wN9hYUELVOvVI7bftFtoh1BIZc5I8EkQVZeOY34vn1m2tm0rHLoGmeesemr4Wqi6DNpZsOFPIGNe7YcOxQpPlZWC8lj/VS33h0xLasyTI1qYUp+o3YkXhu9ZuLKAUhyZRg98w354gWS4;20:OH9rI7aMe5I4WZpmNsKofGsKyRU6BuvOH9qoZTBydskKbNGUaw6WHriMEh6B4micgtSbfBo4dLXltnUmM4XPBhHmV41mK2GZYnRnCefn068q4e0a9U+zXX+fx5+aIokwiBCY8ho4xMeT13mNPHE2TwHUTl0rcfYI2ZTbdVJG3dI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07afbb4d-7884-45f5-9e9e-08d584b18903
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111242C95C403783C501512AFBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(6306002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(966005)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: jJqt9STpWj1lidj+bExr17pc9dKZpyk8Wrbm+MWOSizrNlqYCRyuQibDa+Dm21hkn+jzD32jr5rDbSqhMyn10SfnaMGb9sxHlZtR3wuhgqDnIo0QPQHTxemkXlkqh2QvAaPuOBXoe9qKiXkmZT12Ff4n1axGdkGBq4RDuRHvfHIKBc1+WB+nN5hTQYLBujmUW/0BNjFzutn3j5lC6sEwMLhXN2OUeg/M4RMjGkEkKgELKUjuVQTa4fyHz/oIxRXA7jbdRhDJbNMMYVDC5OoS8BTQqnlBVPMWtv+HrFiUI3dEULK5N1DJ69HS7VQPw1mtXaXivtQPI2y0lPvIMv71gQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07afbb4d-7884-45f5-9e9e-08d584b18903
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:07.2340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index ea41820ab12e..ed18aa4dceab 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1210,8 +1210,10 @@ __setup_irq(unsigned int irq, struct irq_desc *desc,=
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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486446-2-15377282333489594547
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
    t=1520486445; b=ZkEYefWbWXTQEzlrMldPKNR3qLibod5pzIAQ1U41EvDOgMn
    /b08MY8Nxvi31UD46MIgskW5EWm1kLpcKea6bEuAYjOsJcfMc6m4u5j2S8InCoKi
    AtUeJ28WDBhZ2ldl+ucuN23YcxnGOICHUkhFMjQuonlbiNf7hcQanzavSPdq/2eQ
    dk6p/omRgP4uxSqwd4J/Rhl0RoPqDXSxVdlqHBj0ZnlSsg8AirPLYfjXtR/akJ0l
    /QbQiAxAEfxesMYwpt+2W8oLfEu8X8hRV7HF/Qx7rcjyk2fxRnSzEvj+n4LrK4Jq
    D4sB564DwGwdTpWnTB/HTL2lQH0xCtJkHrMj4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486445; bh=TjuikC
    hl0h+Mbh8wKhGzYBA3zoTcBgaCTAxNKytV9HI=; b=GBPcNrMOnDP6uNV4eEPZxY
    LkNzw7aN4pkqXgkKligDFMSGkcE037jwP1FOk6B+o7Lr50mWohc6IBmE5eDBmCnp
    Fck0OKYf3O42/FrmxSQumWo0gn1nIv+5pjb94YBgvjKwmo2wmEzjR6OUPubzxzZP
    yj2Y9lSAEmhW8HC3JanYIn4hOdY0fxTctjQLskrmZD9/+t52R7JX6MA2NB721ZsR
    3c4F0NeQpxQWhZQJnkJ5eXeIjyoG0Pqhz1DI16ms+SX6nb7Dvl7VCHD7Ffe37f/4
    RvjH9ZPWUnwzHBv0uUMJjEPA/giWvYTYik4hDcv54ofkFFGu4sjWtYLfLULGJtSg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVoiAsCz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cVoiAsCz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965610AbeCHFUm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:20:42 -0500
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:48480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966463AbeCHFIH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 09/53] x86: i8259: export legacy_pic symbol
Thread-Topic: [PATCH AUTOSEL for 3.18 09/53] x86: i8259: export legacy_pic
 symbol
Thread-Index: AQHTtprAvbeJ4dk7yU2h5aPuqVGKpQ==
Date: Thu, 8 Mar 2018 05:03:09 +0000
Message-ID: <20180308050230.8876-9-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;20:rTW2WSAXqh19lR0WCAWMl7TrcsxoJa2q9dZZUGkbEGV1SpcGGjpQjqwmPfl1cKHifoU9xz9Djv6Rw+4H4koW1fb88ggl7NWqaGKKLzG+MLki+xXuaG9I8jG48tTw5FrEbu4pbe0QJBOHfyzQlKdMihFDvx9gtcA8yyRk8odDKBQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d54e53d9-981b-40da-f081-08d584b292cb
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871435764BC288589145C88FBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(2906002)(86362001)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: DtTXI64+wIFprYaIbaO23dNytEFCw6l0QcjPAoyDZKHPxJ5t4XE1MJy5HssHVSpuRg3YbWVocL0fddxVBS0t7FnyGyswJ2dTTRhq+EgtJyGbxsB2FJlKQ0F10lv3VfbLolnbc9MvlVCPJGGv49tGe6BxbWPGkluzwsRSz/ksftkjlwtDDHY1MrbwRROlQVmFXMVTn3RNmsZQuxqydD17hchjZIw5ADDdWSKbfE40PYQa++yr4vdRwaClpBP2QHs4UVrqR4zBpaRsYE6HZ11S/iwFIYsB7ULBK8owT8yRMtU4uVXREC+1TdwhQfNZMQs/xK5SmNivo9vT3qC3HRYC/A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54e53d9-981b-40da-f081-08d584b292cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:09.8169
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

[ Upstream commit 7ee06cb2f840a96be46233181ed4557901a74385 ]

The classic PC rtc-coms driver has a workaround for broken ACPI device
nodes for it which lack an irq resource. This workaround used to
unconditionally hardcode the irq to 8 in these cases.

This was causing irq conflict problems on systems without a legacy-pic
so a recent patch added an if (nr_legacy_irqs()) guard to the
workaround to avoid this irq conflict.

nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
an undefined symbol error if the rtc-cmos code is build as a module.

This commit exports the legacy_pic symbol to fix this.

Cc: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/i8259.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index e7cc5370cd2f..6c7e7986939a 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -405,6 +405,7 @@ struct legacy_pic default_legacy_pic =3D {
 };
=20
 struct legacy_pic *legacy_pic =3D &default_legacy_pic;
+EXPORT_SYMBOL(legacy_pic);
=20
 static int __init i8259A_init_ops(void)
 {
--=20
2.14.1

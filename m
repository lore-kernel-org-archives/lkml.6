Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485524-2-14923402247756048598
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
    t=1520485523; b=jJcfVwPUenihzd8CD/t4En5/ZGHpXqCaX5IfH8cxQXZitys
    9QhRcvxtv58EWcg/tgv1bG9roeR4CpFW9C0jQjbnPli+Yux2Y4orOdLQ+1YFdX8w
    j2Z+rooflQlzz3AYToHFlQ47YjJKFhIcMJrqBjaWqInOEhfUYCcqhoR2LyUeHrc2
    7eq/m9ThLZ2+6ufD2zfFg8wWLYew65UWmyXMMqrrVzulF80YL7PVK1VZ3ykivFFV
    B9EdxAoQWrgMgLuOhQrSv9iWuTaJVLHLm8Lk8/cJfj/muqUn2zaEgsZ3l71PZKWu
    IsBnxTJNTZDE3+xP458tA/OAEEb9ye33oa2zQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485523; bh=6dqQ4o
    MV6NjQ0YhUwRWagnxwiZLw8GnSENimy0C2a24=; b=d/gUi+4FWq3I+ZTvkWCgid
    LT9HolXkrkWcg7xFAV6cyUwDt6fxkOvV5bXe7ipoag/4LhHkMrrS7kmRSi+5VPu+
    mcTYeXtSyGK56KDcMkeWChyvPVSeBiVHGhls3WJafCl5RkNsQW47of49yBfRdkfT
    yU9dc8nIfQqzjXiWGUHNK3GGzZu6+WJ7j+Qcbe/DYLyJY5gYUC7Va/nRXJqJ/mT9
    G3KU9I7DwtPJ9nke/nZBJZ7wiFlRawXt4IEiYfFnL/vTh1BpzYL6dpg4KOwQTmIB
    xs3UzVHg8ijXz5vVBCGT33FB+3HymvyCDMtgB4OHCZu9xEC2IZwjzz8aqNlQ44hQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJut2FLS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eJut2FLS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966205AbeCHFFT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:05:19 -0500
Received: from mail-bl2nam02on0126.outbound.protection.outlook.com ([104.47.38.126]:13526
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966189AbeCHFFQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 013/101] x86: i8259: export legacy_pic symbol
Thread-Topic: [PATCH AUTOSEL for 4.4 013/101] x86: i8259: export legacy_pic
 symbol
Thread-Index: AQHTtpp+51lYHO0ZJEilOihUsHtEDg==
Date: Thu, 8 Mar 2018 05:01:18 +0000
Message-ID: <20180308050023.8548-13-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;20:Y+OUmmwR+rych+FuVIQ1pwSOHYuw8maS5jvYp7b620NQCmd2Uxey4ggoAiQCrI9ytaKwTjeL2671fSKdwzCips+gKwOuy3UbrmX1+9sqRRqxZJj7GQ+aic+K88cKOta/UZeXFRDobdXyWcutP3CX68DrVPyqYR6nfiIHrgEBXK8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3a441a7-cc73-436d-ff9f-08d584b22a4a
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072748CE056FAF3D2141B8DDFBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: +Bcotdq7/mtFfU57q0RbsfapN/fajbjXgbG2ehwMu/aA5joBDAMfftR4XQAEvukfTHysTyJXDatIzRVcmUPqyhnT7pS2UajdVaBOdNGRreLE+4Nz31O2x+f8Fg4Vygr4TdztklduPb+9ik+hRMzMq6kJlemQWzreZIVZWJbD6D4hQCU949GDbUoGellQGfu6r2WRSfR64nr39HwQKSDJX3aKH1ZYvo5D/Za8vigBoD7NJTXMOr7Rxsh5CFSnBt7WSULshHfM6TyV5Sbt6yiUWrHEtaP95rpQI0BV2C8AG9bjXsjO3HdjMELSyt1wYRMXJuj4BsCqSe9qWHUoVKctgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a441a7-cc73-436d-ff9f-08d584b22a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:18.5880
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
index be22f5a2192e..4e3b8a587c88 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -418,6 +418,7 @@ struct legacy_pic default_legacy_pic =3D {
 };
=20
 struct legacy_pic *legacy_pic =3D &default_legacy_pic;
+EXPORT_SYMBOL(legacy_pic);
=20
 static int __init i8259A_init_ops(void)
 {
--=20
2.14.1

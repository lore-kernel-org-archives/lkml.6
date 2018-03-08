Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490636-2-1784256007504938635
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
    t=1520490635; b=vKnDbDWcjjL0oOQukPKzrBFNnut7z+hiMEA9iZmYAGRIYns
    X/NpbiIoB4jG/QPLFCnFwNWeCghHCjcWd7qn3wiecOPN2HfESqCx5JeTDN+eAo7h
    f7AaN9xv4I8zqMYTKf4N/r6oBYz+cJJEVaIPKL33mEZis5ZSxwpV7MKK0Z/NDgeH
    GV7gVBoQKjD3RB/GRxgR7zLvHBydiN4yNq6Y/8h0/kiBqwmU/N7CvjnskE5GQgtd
    ZppBac3XxCC6ML559SN5B2oLR0UH9n5fElXQgHJXqBeIdRbzruHln6k1anRdC2N7
    POpQ718SVvBanBgL57pzgFCImpCkmN3iwPE82LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490635; bh=6dqQ4o
    MV6NjQ0YhUwRWagnxwiZLw8GnSENimy0C2a24=; b=NITxDuJbW48ZlmFC17PIrS
    Ng4G+BfiHbczD87mAeZ7oRajNxpQ4KFTMjo5qyYv0BiR0WeLjpzIZIMYLG35bbYi
    doZz+YKgDB7XfH2hlwZXYKNZfFsFEXnNSvumpGm4/vNQFnqkH3qHWET35k0vsRdu
    e9L/d8O6JODc/2Xen45KytCNXfjTEktIGw8gz/SMnMuO0ZkfkS0l/DqlayrtLv5S
    qELb0bLsCd7Y3Urm6OWYV1KedbRUcj2GPuyZKESiaNK5vuaF6mGV7yb6l72H9a/w
    rcCwV5QWH1LL4eXzT/GFcOX/VqfrNxEYHy65gCVCu6XXeFwQgpVEksPSKK210vvA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Whaj1txV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Whaj1txV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbeCHGac (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:30:32 -0500
Received: from mail-sn1nam01on0129.outbound.protection.outlook.com ([104.47.32.129]:47332
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750966AbeCHFAG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 029/190] x86: i8259: export legacy_pic symbol
Thread-Topic: [PATCH AUTOSEL for 4.9 029/190] x86: i8259: export legacy_pic
 symbol
Thread-Index: AQHTtpotY2TsTj+OLkCrSYohtUT+LA==
Date: Thu, 8 Mar 2018 04:59:03 +0000
Message-ID: <20180308045810.8041-29-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;20:oW50kBNIMvMdjctTjaLS0zyrOGQPLTjEUUb30NdldpL/F0owUQKMlgvuFEcfagILGFOUaCcagPruM/e6Y70BEyQx9Yl9s5ggkwM1xg7gcK2DKxwlIhkgoZAOz7Lqy7muigJvNVwMigWGaQqi7fDpEzEtjarXiumVpzwch9+luLI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30414345-3538-4704-77af-08d584b174de
x-microsoft-antispam: UriScan:(215639381216008);BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB111242084173CFC3890636D4FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(215639381216008)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GAq2CbkLs8f5iNwTpm39pzwcI2YYsHKVR9+kkC3f5AQEpixEihq2qQWPFs/iUWPwTb5ka6Sf3VeEpT55YTdFSmsyOfCCx6hymd9KXdUG9kC61kElKkSEBRWvJNhijfBIIFLUBgp9ePYFo5DM3Rv5bvvlFJDY6/kOHdDxkeX8AVWubKuVaoWVB7AlnJQ7foqbrDhUxDjborRmdhDLaKd1F0WdK0bx8O3Lz73EZ/7e/XKih5E/XuIBfC0F6BXs54X9lsdVtGJf4GO+QJuYgGuKjjgH1GRjvvOnzfyglfPrRuXMvAw3tu8ySjl1uZ+qG64VBc6iGw8yr5QE8cHBqQOwRQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30414345-3538-4704-77af-08d584b174de
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:03.1331
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

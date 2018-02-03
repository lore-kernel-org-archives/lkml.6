Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683266-2-10656562189936163956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683265; b=G4L639p8VuYJ5o9uEu2kKl4mRP8lkIzfFVhrzGcRjs53W4Z
    3BR4DBxoY40phHHuAxH2rjBfRsudZp0M25HZkbgmp92d2ay7VFO9DpXWDcDkEwLZ
    3UYZZb+/3iT7S+oyenlGo7GArY10QlWDiHKfN/jaq2hYg3oDFIWPn8lBDGePR/G2
    1YRprWGzTyDuXhTWZuzxa5Es+WYXsFe3PuNZCXSWVhZEyIaRpCI98YfhnXkJ+/aM
    WnjsAenqIDQbzCALK6fH/Gh9ayqXaNwGbC6YaZAdro4br8XIcnc9zRzOLyKo7fC1
    uf9LpNgunFKgqOID6SSiDaqLQzsngRGIRoDB0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683265; bh=/8EgB+
    2OrrMgKqcwBV4SajjW3AMFX/H61iMuJ0n8BU8=; b=HI5J8cVdjn0FINd/qwz7RB
    InTmDM8cgOY1W+g5oNhrvbq1SG/JjTVfW2/mgbKIEfIRsbuNqGxtqLkUMa7749Sb
    Tyfg4foWXB26Aldnn9oF/BpHZurvUEFrK3UnUcFvdS860sbrcyr3CJ2xFzmcV+mA
    HdmLEBgYL6Ty3pchn3Ub5jyB6EFt2+vxa9/gIlueuUBEQ+v+AFcmkGFN5HXVU/Cd
    HoqJZuAt0Kg2CigXZj1T/nn9wdeldDw73uM1j2whChkuHPPQQiv0Btdl1mjlbOVT
    S0I4hQGNVlAscU/PeDF083JdXqZTr5Mb4tyjtx7q3YQBQk4DPa/3NTYIgCysg/xg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TXBaHANf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TXBaHANf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754713AbeBCSij (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:38:39 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:10688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752616AbeBCSDm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 097/110] x86/platform/intel-mid: Revert "Make
 'bt_sfi_data' const"
Thread-Topic: [PATCH AUTOSEL for 4.14 097/110] x86/platform/intel-mid: Revert
 "Make 'bt_sfi_data' const"
Thread-Index: AQHTnRkEofvmfOGH/E6jJaxGnA2gIw==
Date: Sat, 3 Feb 2018 18:01:29 +0000
Message-ID: <20180203180015.29073-97-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:gkDzego6KBo0F7fHOZxdj5S1X5GnN+2Ic98vMcEGatEg63H0Qzu6p9+FiiclBTVuh9KApzVGwiidNp/ISNXvKgw6rkO2MFgbD5bpbSBphPZe/4pTPKCUwflWcDeyv3iGVj551zmcZQKc33tRM6jfXBelJs3igmvQEb4AYc3QfY4xdDzLfxRX4bS+V/E8a2VRg3V/ENGmfcUTUeIEmiPLTLwj9nwH7mJ8TfJo0UEGuAlqPfv5zZy//fiPCzpURuyf
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f47a4a21-a407-4b27-d00e-08d56b30566e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993204C8D2C50AE7368E94DFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(7416002)(86612001)(36756003)(99286004)(6306002)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(966005)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 8dIl59NkGyjMGn6rrgyvEz+5n0viR+xKhtEPEV0JdEhqCJIeQ2RWlPbO/y/1Gvk4cjGv8XeBwQpZVPfNs/RBxw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a4a21-a407-4b27-d00e-08d56b30566e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:29.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 9d0513d82f1a8fe17b41f113ac5922fa57dbaf5c ]

So one of the constification patches unearthed a type casting fragility
of the underlying code:

  276c87054751 ("x86/platform/intel-mid: Make 'bt_sfi_data' const")

converted the struct to be const while it is also used as a temporary
container for important data that is used to fill 'parent' and 'name'
fields in struct platform_device_info.

The compiler doesn't notice this due to an explicit type cast that loses
the const - which fragility will be fixed separately.

This type cast turned a seemingly trivial const propagation patch into a
hard to debug data corruptor and crasher bug.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: julia.lawall@lip6.fr
Cc: platform-driver-x86@vger.kernel.org
Link: http://lkml.kernel.org/r/20171228122523.21802-1-andriy.shevchenko@lin=
ux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/platform/intel-mid/device_libs/platform_bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x=
86/platform/intel-mid/device_libs/platform_bt.c
index dc036e511f48..5a0483e7bf66 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -60,7 +60,7 @@ static int __init tng_bt_sfi_setup(struct bt_sfi_data *dd=
ata)
 	return 0;
 }
=20
-static const struct bt_sfi_data tng_bt_sfi_data __initdata =3D {
+static struct bt_sfi_data tng_bt_sfi_data __initdata =3D {
 	.setup	=3D tng_bt_sfi_setup,
 };
=20
--=20
2.11.0

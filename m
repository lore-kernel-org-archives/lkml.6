Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683427-2-15986567818856793754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683426; b=lk90WvghEMCNf+fPmRjC8/+Ud/QZBzRR6ImTGW+dUXXPD1W
    cDCObUQb0rddP7DQ+QllPQD+BzmqVYkLI2m1fTSztR/SfozWgmQmeFOTpwuD1Li1
    RgbK2eA/hIJqIndN0dj49GVP0k0AXFqL0Dq88rr/OF8uP4gXw+yQASx5NE99fML5
    OElZ/ECop2EIaw3Dt3Dy5EMjcKET+5UM3DCk01dBJlow9L62xcw4VIQDh/5X3YK/
    4SUFPxQIV3svPhgTHp/GgKyPkJswaK7hoTsWyi3jmwbN7ZTaFI8XuDajWlvk9E4+
    M+OPkL0SVwkG4bU63Jwu92FFHmjEPa5XMPd4/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683426; bh=Ccdk0i
    Zal9G8f3ZiJwWSZ2FBpZAhuvYxMicuMGbJ63w=; b=UOc3+52lvVKILdzChLGmVz
    TPF/Zvm4KD1mglnkORI1UDrGJwQIbtyBYpr8S0vaQn5oNB4V4idz2BESsn8qfXH0
    l4mi9RucIeiJpu7YGGMnV068BMIMMhh0KrDcgtqnU/ew01LRycRVS/8CtaYkcd0J
    D0GIXxgcn8gPUk5MiXz+a2Lr9pEcInXIITLer429GKdwzo4NZoR/y2DVVDBCF8rS
    o702aWE+5dquvH1ebJkp2lX3MMdRwIJY0fr95soPijqUKoEfKHZ+5S9c9W19mGw2
    1jEVfE3JmtgykhXYzJjo7MuKv5WAwCeLFgONc0nSKEMbt7KmlEZcdFecbrbe5VLw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m2jT3wR9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=m2jT3wR9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754892AbeBCSnk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:40 -0500
Received: from mail-bl2nam02on0109.outbound.protection.outlook.com ([104.47.38.109]:45293
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753183AbeBCSC7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dave Young <dyoung@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Ge Song <ge.song@hxt-semitech.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 082/110] x86/efi: Fix kernel param
 add_efi_memmap regression
Thread-Topic: [PATCH AUTOSEL for 4.14 082/110] x86/efi: Fix kernel param
 add_efi_memmap regression
Thread-Index: AQHTnRj/b5DUJfk11kK0uVHzv31RMQ==
Date: Sat, 3 Feb 2018 18:01:21 +0000
Message-ID: <20180203180015.29073-82-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:5toZZz7FGnNXoHmCfy6W+jc7S/xqXqyIWMZuhBNMRTS9VR3fZy9zTdX2UUFYcLplcvCzygUTg3n+cTPOQG1L/IPosh1fMfI53/+LnMlLOXgyqczmlSF9prELvVvjPpujvbek9TnTki0qhbKWXGSJqYwr38OQVi2XFDRikLPlsJemoh0E28QYs2Lcj5uapLukUviIQtG8ruAV+zPpI7f+cMh1/iM4GsU0F3cI0FtotTvQJsvglCBbSCK7pwrTGhAu
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cca5785f-733a-490c-0528-08d56b30404e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB10413FAAA0A7194DA8CD5F67FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(7416002)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(966005)(4326008)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(6306002)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: +McDqsL+f+SjVyGVYd2r5L4mc5BvZGDndEEcE44LZMgHOhvanESPRAiHklK1AHbTAZ1FoUfCI/XemrGdvaSYdg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca5785f-733a-490c-0528-08d56b30404e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:21.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Young <dyoung@redhat.com>

[ Upstream commit 835bcec5fdf3f9e880111b482177e7e70e3596da ]

'add_efi_memmap' is an early param, but do_add_efi_memmap() has no
chance to run because the code path is before parse_early_param().
I believe it worked when the param was introduced but probably later
some other changes caused the wrong order and nobody noticed it.

Move efi_memblock_x86_reserve_range() after parse_early_param()
to fix it.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Ge Song <ge.song@hxt-semitech.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180102172110.17018-2-ard.biesheuvel@linaro=
.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index e84cb4c75cd0..c54361a22f59 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -928,9 +928,6 @@ void __init setup_arch(char **cmdline_p)
 		set_bit(EFI_BOOT, &efi.flags);
 		set_bit(EFI_64BIT, &efi.flags);
 	}
-
-	if (efi_enabled(EFI_BOOT))
-		efi_memblock_x86_reserve_range();
 #endif
=20
 	x86_init.oem.arch_setup();
@@ -984,6 +981,8 @@ void __init setup_arch(char **cmdline_p)
=20
 	parse_early_param();
=20
+	if (efi_enabled(EFI_BOOT))
+		efi_memblock_x86_reserve_range();
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
--=20
2.11.0

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490108-2-4073971145825201014
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
    t=1520490108; b=AVi0HkE0We6xPyK7IvicmmUROqImxBIELc97lzhq68MkIkE
    OwqWqolK4tlGt09e7VlA9wH+bTcn91RwE4pd3yeOaFOIcq0ipPd2gQtpEhOJ+s98
    8wCTaQGoYwjevJ0LjWv8PeVckyNHYkHqLo6q44fU1aVwgDslCw2J9l+BntI1Kw41
    h7B05pf6l9srxZ8VO7/Qx38L8/8ezrjeG263AE0S9Q6JUmD+XTzWXJJKvT9Ic310
    LBnaOUir0Dwb0FSPw1yuGqpPQCouEbbR0/53WsTJnm1T47GWbHhCMnKnxzE9+g6c
    8vuc2QEOMRWgzu3JW6EnnzOiaHXJt3WrKHtRk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490108; bh=B2qAbT
    goAgqFEYcGu59T5esT3HZhIlFEfAUWS1bZbKg=; b=qPl/tWqnul/PX2N095RWCg
    GG1IdROjvoN/JF9L4Dj5pmeDw1cuiMGxCo1chMLX/au7udhuQ0Kh5f4yFGR8NZLj
    DAUgPwwcisUYSTQBdwfshWpp6F0Z98BzOrl2xGNg5o/aJUhzVURhLUeZIddvDax2
    Lyeq3R/CIgWRo5+Ly+WBQAeoEe2qOCKFsLRr2JNcyD+Ng7xZja++wsTWoAQgZniA
    0twLSNU7UGgw8D/e0XVOs0CWTOBf42p8kgTCPxIxfMkx73iq7fq/6h0+IwkI4dyj
    nbVX4/xHRhL+LOyywX1bJfgdE/tCC2bzN5RMwjWyiTLuy9TX/1TaPQQjCigSa1Jg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=enVVKo4S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=enVVKo4S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964864AbeCHGUN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:20:13 -0500
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:45238
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935361AbeCHFA5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Abel Vesa <abelvesa@linux.com>, Abel Vesa <abelvesa@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 053/190] ARM: 8668/1: ftrace: Fix dynamic
 ftrace with DEBUG_RODATA and !FRAME_POINTER
Thread-Topic: [PATCH AUTOSEL for 4.9 053/190] ARM: 8668/1: ftrace: Fix dynamic
 ftrace with DEBUG_RODATA and !FRAME_POINTER
Thread-Index: AQHTtpo0WqYEXgOeVUeE7z061EpBZQ==
Date: Thu, 8 Mar 2018 04:59:15 +0000
Message-ID: <20180308045810.8041-53-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:0c1nSWftNO9R3zJ8g7wfdhSXdSTa6ZdPEfLEzgU9YQF58pQoJ3xhjvybXGIpNDugwNW3lKlg91dToXhi08NEDkr3bfXfQJD7E/uv0YqHXVG9r+zM3I/cPOFCKUNCAwnhE7IkqKTpiFaL5B22DjjSsduelYEoQsWjUdfiVGhEdukRnvqjvPJP/eAN4Tc3Lnc2N9T7FubddlA/AvvYoFvWNEOMH1RdxDA7Cyqew5VIgQeDEflmFu/SAcVdl2Oj4GQw;20:zHlr1LSV9Vckaz07ZzlhOdIB91AtkcqZYYT77lCLYB1mC+uLlmXMdagtoP8Q0R+CWMfOC3N+CgDK/5llUdEZ1pGJuxMyfbvYK90CRRoo1o2TomWiEsxoRGBcfSIBMt0FtGU8pU1H2NrgNR+au93eNPFzoCNY6nrk7unMeBKYw3U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6244766b-0181-4d8b-61aa-08d584b18d7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11098DFBE9EB09509804DE2AFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(39060400002)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: VEGgvxIB9RwV4fhfUyV8+luf24ZaqVrgayD1wvm/rkLy9n1VbxsEq65yjoKR5i3cXKPCEIuZ+9WyV5Fr1oGBIg88rpXeSp3/It//GSfByptHXAsR4cK6FlJoDqlvUYjUpwhoUdpb8UAvG8FRJAph+WYtaAPdA97PcET76mE2KUN3RPlFQwFwTxVlfv1aibmkfUjUDgnjKbQb+pjxnq4bCp7o3bE2bNbKoeYulHTdVC/zrv5ofCmB5oiBL2X32eN88BnI0kgmdK0VjPz+DXhW5n3O3O9UP4V3c7a/G/dmgQhPgX8nIFAQHA4RmF9vVFf21RtQ/RvuokNbD2pkbR8mqg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6244766b-0181-4d8b-61aa-08d584b18d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:15.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Abel Vesa <abelvesa@linux.com>

[ Upstream commit 6f05d0761af612e04572ba4d65b4c0274a88444f ]

The support for dynamic ftrace with CONFIG_DEBUG_RODATA involves
overriding the weak arch_ftrace_update_code() with a variant which makes
the kernel text writable around the patching.

This override was however added under the CONFIG_OLD_MCOUNT ifdef, and
CONFIG_OLD_MCOUNT is only enabled if frame pointers are enabled.

This leads to non-functional dynamic ftrace (ftrace triggers a
WARN_ON()) when CONFIG_DEBUG_RODATA is enabled and CONFIG_FRAME_POINTER
is not.

Move the override out of that ifdef and into the CONFIG_DYNAMIC_FTRACE
ifdef where it belongs.

Fixes: 80d6b0c2eed2a ("ARM: mm: allow text and rodata sections to be read-o=
nly")
Suggested-by: Nicolai Stange <nicstange@gmail.com>
Suggested-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Abel Vesa <abelvesa@gmail.com>
Acked-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/kernel/ftrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 3f1759411d51..414e60ed0257 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -29,11 +29,6 @@
 #endif
=20
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_OLD_MCOUNT
-#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
-#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
-
-#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
=20
 static int __ftrace_modify_code(void *data)
 {
@@ -51,6 +46,12 @@ void arch_ftrace_update_code(int command)
 	stop_machine(__ftrace_modify_code, &command, NULL);
 }
=20
+#ifdef CONFIG_OLD_MCOUNT
+#define OLD_MCOUNT_ADDR	((unsigned long) mcount)
+#define OLD_FTRACE_ADDR ((unsigned long) ftrace_caller_old)
+
+#define	OLD_NOP		0xe1a00000	/* mov r0, r0 */
+
 static unsigned long ftrace_nop_replace(struct dyn_ftrace *rec)
 {
 	return rec->arch.old_mcount ? OLD_NOP : NOP;
--=20
2.14.1

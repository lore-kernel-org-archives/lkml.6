Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121909-2-10124648311334507457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121909; b=vABhJXPywVZdGFgP1nTXtk1db1yr0tAMP7q+9HKUAsJhubV
    SKJVk1uOMhhD60SdGtFhD7kyK7L9T7c+c4XeLLXndX0KzW5IFFh0DVceoi5bMSxN
    nASHS2njbEZMhnU7ZTJBdS0mt1Vz5Ov0tDv3YS3R+SgVqilvq+XjURmQSmcLUW9O
    Hyb7QAkvmnjr3wMc7UFw2OhVG8Hpu3ECtqkWzMbYpZ8thsz1yYeDQYzR2qKQ9vBy
    6sUY/RrozDgCoNEJrGIqb6TB4h1ef9nrPsi9JZy83X3tukC47w0Ae/agJDIu5gqk
    OLR+eyTrswOo8fFzPmrJA7GmweESL/azipQclEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121909; bh=8HKQHL
    YWb9VkvEwcKhSN8Wtp98UdjfXKnpX4TOJoFxc=; b=LtoKFi3ISjS/qRBhu35yVV
    YT89hPiNhj84GANWnD2fLyqHVh6WyrVrDtjVchzISg0MiZmq8fhAmSKWaLwYxp1Y
    Or1Vthx5F79Z6v0yLWEeRun5yVpkZ4yHzIt3PsehVrW632Ze7LU026Ip70aM3Gnl
    VWyJfwBNkapOSLX9M+nwOucKCzUN8l4gJqK6pKSj6cJNAb8JB2CRl3tGbZ8aTdC7
    y4aJvkJg58fkH3s7S5deU9EzNEkksjjagQkx4JH/1tht32h+SUQ+5GgCLQqLFMqE
    mRMHcirXBMTIDoIV9tQRoDcZjYn60x2XN9szrkmNuJCMMZL8PmF7ZVTZBEsF1gYQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PBF0rVz7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PBF0rVz7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeCCWbW (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:31:22 -0500
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:11440
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933651AbeCCWbT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:19 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dmitry Safonov <dsafonov@virtuozzo.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Borislav Petkov <bp@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 022/219] x86/mm: Make mmap(MAP_32BIT) work
 correctly
Thread-Topic: [PATCH AUTOSEL for 4.9 022/219] x86/mm: Make mmap(MAP_32BIT)
 work correctly
Thread-Index: AQHTsz7n5yZ9zKa9/EG5wI7ncso62g==
Date: Sat, 3 Mar 2018 22:28:08 +0000
Message-ID: <20180303222716.26640-22-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:z5nKtFp2BKqLhFoB7/fI28rEPqGc7r97IMfKIcw+T7h7OCapgYrbErMDPG8uQ9zQGNhYs9StAKRxzPMmCHfWHetqdpLRuK+XpgmVOEai+M4sYq49JeWusQvYqaB5jibditAk7Zk14moh7bmpG4uSLl1P1Cc+3q/UBXjw+akOilwWu22JUEYmOpnp3sB+dtO6hYnlYDn0QHKTU8Sxp39S271KOYUYXDrXIB9avGCLf5Mdh1zkN77k9tN9XzL0Adrp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab8d64b5-5023-47c4-4a73-08d5815677d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970FBF4851E4FD97B25EC5BFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(85827821059158)(788757137089)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(54534003)(7416002)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(966005)(7736002)(8676002)(6512007)(6306002)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: IgxuiQbmK2NWt+jZp5L6q1aFAd/m1nn9453F+zu86F1wumjwpgos+D3zUme/cJzB+MQEuo3K/9VFhvZq0/4XUWHlPX3c+aL2dbEwYS6VyKXj8PppPu217gmM34dJSBtw4BZqiWUN64SLVKYOBvdXvd52jd5sejuiKXVQ9SodnvU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8d64b5-5023-47c4-4a73-08d5815677d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:08.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Safonov <dsafonov@virtuozzo.com>

[ Upstream commit 3e6ef9c80946f781fc25e8490c9875b1d2b61158 ]

mmap(MAP_32BIT) is broken due to the dependency on the TIF_ADDR32 thread
flag.

For 64bit applications MAP_32BIT will force legacy bottom-up allocations an=
d
the 1GB address space restriction even if the application issued a compat
syscall, which should not be subject of these restrictions.

For 32bit applications, which issue 64bit syscalls the newly introduced
mmap base separation into 64-bit and compat bases changed the behaviour
because now a 64-bit mapping is returned, but due to the TIF_ADDR32
dependency MAP_32BIT is ignored. Before the separation a 32-bit mapping was
returned, so the MAP_32BIT handling was irrelevant.

Replace the check for TIF_ADDR32 with a check for the compat syscall. That
solves both the 64-bit issuing a compat syscall and the 32-bit issuing a
64-bit syscall problems.

[ tglx: Massaged changelog ]

Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: 0x7f454c46@gmail.com
Cc: linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: http://lkml.kernel.org/r/20170306141721.9188-5-dsafonov@virtuozzo.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/sys_x86_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 1119414ab419..c45923e70f82 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -100,7 +100,7 @@ out:
 static void find_start_end(unsigned long flags, unsigned long *begin,
 			   unsigned long *end)
 {
-	if (!test_thread_flag(TIF_ADDR32) && (flags & MAP_32BIT)) {
+	if (!in_compat_syscall() && (flags & MAP_32BIT)) {
 		/* This is usually used needed to map code in small
 		   model, so it needs to be in the first 31bit. Limit
 		   it to that.  This means we need to move the
@@ -175,7 +175,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const=
 unsigned long addr0,
 		return addr;
=20
 	/* for MAP_32BIT mappings we force the legacy mmap base */
-	if (!test_thread_flag(TIF_ADDR32) && (flags & MAP_32BIT))
+	if (!in_compat_syscall() && (flags & MAP_32BIT))
 		goto bottomup;
=20
 	/* requesting a specific address */
--=20
2.14.1

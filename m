Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118936-2-9012559879050691305
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
    t=1520118935; b=QEp8ZuWfPc6BoAhvnQa5nvbLrPYZS9nXQh/mjgSAqx7TZBV
    ThGbNbSUQjQPjqjtip6OzLgcekJ0vbvphwK7FreuP2HS8eHkIZrpsrI6Iy2d+UUw
    2v/F/EW6pQG0zprUy7mISO06O16ON/kueerWQ8APvP/21qyWmjyjJuCE8nBlOw7e
    wuJS6athfmT968SSXyM+k/UlFqGkq7a0Bvo8uLc6kOaP0RoBhjkc+8xlrCOKRbI7
    xGC3hKbvm06j5NBYvXq8XBmDwr3h/yNsRKQhu98GNWk2Vec+ne6lhO1BvUDmkykU
    ikNqVfAAzU44xN24IvVcLia9qYX1Px9Yfu4iuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118935; bh=BOZptc
    s/i+Y6+HtURs84KvyCGAebIb99MWLekZ3oRdk=; b=BOFiKiH0bRkg0RHQLpYh6U
    +l1ESePCw9QvQ3BH1eEO+4z40kIOqdOEFzjhORTw1+lrAv5Sa79H163t2Ap6tqp/
    b/gUk39OasYU3+mi8msJTd+ex5pQfwEx4F41XJ5DCPcoOfLoeVsY11de7cspk9Yv
    wo0VDMZtCtREykpqg42XYvE7NvHz9IWNQo0ihdb2ECzYotpL4MKM0v2kxJbqt20W
    Mz/QB1i5Phizhbjy7avaaY+LOeoBHxgzQ4LJ+Qa4TGCxVXzci7lM39nw/49UGIZa
    FE2kfXe/Ba7Yrc10JD4HG7dYntfBD1poGf6MrqeWQFZ8P+aSg6Zo6iLctOIGl2Fw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W8HWbm/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W8HWbm/S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeCCXOV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:14:21 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935003AbeCCWjH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, LKP <lkp@01.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 037/115] mm: Fix false-positive VM_BUG_ON() in
 page_cache_{get,add}_speculative()
Thread-Topic: [PATCH AUTOSEL for 4.4 037/115] mm: Fix false-positive
 VM_BUG_ON() in page_cache_{get,add}_speculative()
Thread-Index: AQHTsz9UcSPKaxf+IEeb+vazptba8Q==
Date: Sat, 3 Mar 2018 22:31:10 +0000
Message-ID: <20180303223010.27106-37-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:HFtGqMuIq/neb4CKwuRb70OJKfFs9WodpLe5939V0YsNWfp6jUo3b3vNHw9aQ7he0Myla4QVYgyZvzoC2ibMzYmFKRWnvT6vsOC3ZCV9scsBWWPbh9lZZK+OzLrG1FuvrMHYri5kpYYJlKC/K/lm/UjOVLy+tV38xCXxNaL673mLhFuahfxmvLgISKvvXJOpaz1yW/V73zWRE4BkpiOx0TEQHfdpwm/SNDWsrvuEsNWj0ufFlCNOql49yap9xRLa
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d58501b-216b-437c-60c7-08d58157913a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938CDCB20E2FB545DBC2C3DFBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(966005)(6436002)(6512007)(14454004)(6306002)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(7416002)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: m+KbNfXhCxkQqkOYkPzYiuT6iPTIGacOJehLZQugNlKE6pw5u6+5tzhLLDyRLnzc7qK3uVwLFC9ez7CT3IovxBVc4UNzDtRpO4WURnXzpxjXOmC3jK+ITJGbPz7KunkzaXfSoS1k8qWS5GMnsO4FOJmGwckM3Y0tFXhUcRd5L0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d58501b-216b-437c-60c7-08d58157913a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:10.5415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

[ Upstream commit 591a3d7c09fa08baff48ad86c2347dbd28a52753 ]

0day testing by Fengguang Wu triggered this crash while running Trinity:

  kernel BUG at include/linux/pagemap.h:151!
  ...
  CPU: 0 PID: 458 Comm: trinity-c0 Not tainted 4.11.0-rc2-00251-g2947ba0 #1
  ...
  Call Trace:
   __get_user_pages_fast()
   get_user_pages_fast()
   get_futex_key()
   futex_requeue()
   do_futex()
   SyS_futex()
   do_syscall_64()
   entry_SYSCALL64_slow_path()

It' VM_BUG_ON() due to false-negative in_atomic(). We call
page_cache_get_speculative() with disabled local interrupts.
It should be atomic enough.

So let's check for disabled interrupts in the VM_BUG_ON() condition
too, to resolve this.

( This got triggered by the conversion of the x86 GUP code to the
  generic GUP code. )

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: LKP <lkp@01.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20170324114709.pcytvyb3d6ajux33@black.fi.int=
el.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fbfadba81c5a..771774e13f10 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -153,7 +153,7 @@ static inline int page_cache_get_speculative(struct pag=
e *page)
=20
 #ifdef CONFIG_TINY_RCU
 # ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic());
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
 # endif
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
@@ -191,7 +191,7 @@ static inline int page_cache_add_speculative(struct pag=
e *page, int count)
=20
 #if !defined(CONFIG_SMP) && defined(CONFIG_TREE_RCU)
 # ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic());
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
 # endif
 	VM_BUG_ON_PAGE(page_count(page) =3D=3D 0, page);
 	atomic_add(count, &page->_count);
--=20
2.14.1

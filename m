Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117543-2-17703667764185477694
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
    t=1520117542; b=RRreQvCbY8whaEed3/6XG47PKDnrM/hUG78gdjgH+57QLcq
    DMVgmWWlqIgqoYRybBiW0EntrNUwa41o1EzuWZVcW+RzCZFOD0df1FVMhP3QH9rA
    kfR8pm9F3W9UwGoee50ss2z3xFZFkRyhdO16xF+5FSZ2NPl/epfi/IHs1+xUXjhO
    ruSVo0rxXjq7WNJ97TLx344UDmLqwtdU393kh6hcli6YE566LXsWINU6PdiP+69r
    kEeNX3CnofMQT15GbZW9Xsl0JAiWK3g29ND57pLxS+jNW1UtcSgmqND7IWIpjOkZ
    2uqsyY2IWFEj39gQgKyXuqcSgzKRMMN1o+d2oLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117542; bh=cLJWgX
    wSqhxdAWUBJjg2Pd5zUm46OrpIYsj793d0kxc=; b=uEmBy6B/dw8mrOFothTUk3
    i50L3IPS2mOOTfm2AZN7o53cvI4F7XYYJdJYBpsTV6caNDvA4n2r/zsn0narXCFH
    Ut4FcK3g5Orlp1wUQCAkd0ElSlz4DtgXbDT3M0ccI7wq9NRMFGocsO5Tw9mIyha9
    kez08+Vt0GBJMAA+ctAsLCB5RitzvNTDVkR2cJS9DVabKLv4nlFjFMkJe67t1EyP
    /8N//w1iYD/9BQTJbA0eb2IdRkvD6TRik5pm4glvGNUbBJeH6KJeflYPqBdR7LNd
    nMW5SeU35wIX/iDwjPnBOfHo5IIHZLG0eOLpc0f2HhEMTyaZtUvwj50vatCFdL0w
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CdTCrfTP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CdTCrfTP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933646AbeCCWwE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:52:04 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935435AbeCCWlK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:10 -0500
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
Subject: [PATCH AUTOSEL for 3.18 22/63] mm: Fix false-positive VM_BUG_ON() in
 page_cache_{get,add}_speculative()
Thread-Topic: [PATCH AUTOSEL for 3.18 22/63] mm: Fix false-positive
 VM_BUG_ON() in page_cache_{get,add}_speculative()
Thread-Index: AQHTsz+j0Ej9J09mk0mlWiJBppzPDA==
Date: Sat, 3 Mar 2018 22:33:22 +0000
Message-ID: <20180303223228.27323-22-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:sOMwNWptvPyDzQ+Ic5HDMdmm8fiijl/xLhXDeG5vrRqwMcARD35TBtQg/LHAvwRvK70ZOBNxdmA5XHE989UC2fuVCU+tB8+GdBax1N8bGv43zw1qOBRXOvclVCBkrzUlQYl3Lm/oUw7OHog7SVWM3YIur2eqhTkkkVhq3D8EZrPE81g251MHwsh31mgvSHHjZsqP9C9yktA+v6iUTxyQ8tn4U9a1M1ekfZXj0ohK6a9nKvCMunCode+a3WCOK8x5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5e64083-a0c8-4f49-038f-08d58157da73
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09402FD3A3B49F69300D5FC3FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(104084551191319)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(6306002)(4326008)(966005)(5250100002)(305945005)(2501003)(76176011)(7416002)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: R/D7YtSZq0sYheZd2AVT9guIfrmhqVxyCXWSKUYEEgyMkdY7T0/hj56gYPHAn5xoZnZmkyygZ1QH5IKLh50z1WCG82N9hGoBLHU0Tu5w6pawHQ5ArpW4eGWDbzaZzsFQLMCzWXXciHHrQAHoU6yfi9BhQBzx8GFpRfaIMV66IJc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e64083-a0c8-4f49-038f-08d58157da73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:22.9973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
index 30a8f531236c..2629fc3e24e0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -146,7 +146,7 @@ static inline int page_cache_get_speculative(struct pag=
e *page)
=20
 #ifdef CONFIG_TINY_RCU
 # ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic());
+	VM_BUG_ON(!in_atomic() && !irqs_disabled());
 # endif
 	/*
 	 * Preempt must be disabled here - we rely on rcu_read_lock doing
@@ -184,7 +184,7 @@ static inline int page_cache_add_speculative(struct pag=
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

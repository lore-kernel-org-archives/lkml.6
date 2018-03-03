Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121499-2-1974008516439364953
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
    t=1520121498; b=rL5qdZDwVFy3e8AOkRldwhAFS3iPrZSJa3L1ghtq3OzGVAK
    /6O3LkddGgKQYsVkEW24vW6Oo2biT1HoTtjZIJzrXts+K7wVWYgIDetKQioP9O+f
    zmVADtYz6lnHO2NMhS2qLct7q6weXKrNpEWlS6jHVw9NeHOM3Y2JhDkxDO/HKuIP
    VZthPGD6L3FR2OrqZ38t9ZMEnfothEo0UC03+S8p5/vtW312huded6DRaYdG9Anj
    Kzk0tMlLFrzcQRLoAdeLia/j4ydwKnC92qTaErdS9RHeS8mbrQEdoRStnfnMg16Q
    p0IIEI/jkr5CgqAKRUHlKAWU2CgSviiSlQzGl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121498; bh=wzHzvZ
    H9sN1p39Jn+iVdyRj9LlwMiavWllhUjziLXjk=; b=hPzaUA+a7s02q/PDPwLvoV
    Wrw5rZPEjV5h7x36Cjx+7NlVJnosIWnOwffyVPx5tsl7GIL3mLjcGs/8o/15gF8J
    Rn2/AdNF3Z5csmrRlnWRBy1HRLn8WF9sxXOEYvkxgxmJ7zMp4mma2ho2joycFRNu
    r1GIwzBbKZS/N0qL0QHPDbIENaitxzxQQLSMGq0nc2rdrIpqVG9/x/W/wHiyvpKa
    Oi1GbtXCz0LKPSaDuEjF/ca6RbwJoS79dl6vTipmnzbLg02LBzFo4FQFtbbJW9r4
    DHN4s+O6NLi76xlM3Rd2GHiNwPVsnq1Cn8ercfa9rd9yQF1Y1sQYWu/j6nD7HzMQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PEEpwfl1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PEEpwfl1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeCCWcY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:24 -0500
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:2176
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933819AbeCCWcU (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:20 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tom Hromatka <tom.hromatka@oracle.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 059/219] sysrq: Reset the watchdog timers
 while displaying high-resolution timers
Thread-Topic: [PATCH AUTOSEL for 4.9 059/219] sysrq: Reset the watchdog timers
 while displaying high-resolution timers
Thread-Index: AQHTsz71WR+EklRNgkmLx0oprBgmJQ==
Date: Sat, 3 Mar 2018 22:28:30 +0000
Message-ID: <20180303222716.26640-59-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:lQ2T/TP/yhB3h7VhDG0feY2+/em4s8oA7u5JcrofUGV6jgDEV2ezYW3/hAv7b/3vkFWUC2OCKv+40qpv/ct+TZYbL6yTWSkvaU/j77IBAnVZK0yTKvorSjIiEakB6SXht08u2JJKDum7a8u76mCEnv3QGoTI+VqJlF9ecdHDN+zgImYA1paN9TPTC7P7IQd3fIiVn/+uYBqHeinKsMXqAmw1WBh4xOZAOdkNlVI8Bt3M1Uw4+xpW8RPMpiwGYBoP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69ef4e69-6b61-4d6a-2fce-08d581569f52
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1097ED1198C929501EA7FACEFBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xh0HTSFiobEzgX3RD3224qLECkAFkx6QvW6jxP61nonSb6uW/N2qEaBfUvopCOw8RYlDU5KrR5LjgkE+PSXwSaIEaMvzYmvR8xO1NIUptkW23jiJaMOvogYAhKwiNGX7gGrjKL9GXCv4CNqwYjibuwqmgXEjZVmLWvK/JDfDrZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ef4e69-6b61-4d6a-2fce-08d581569f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:30.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Tom Hromatka <tom.hromatka@oracle.com>

[ Upstream commit 0107042768658fea9f5f5a9c00b1c90f5dab6a06 ]

On systems with a large number of CPUs, running sysrq-<q> can cause
watchdog timeouts.  There are two slow sections of code in the sysrq-<q>
path in timer_list.c.

1. print_active_timers() - This function is called by print_cpu() and
   contains a slow goto loop.  On a machine with hundreds of CPUs, this
   loop took approximately 100ms for the first CPU in a NUMA node.
   (Subsequent CPUs in the same node ran much quicker.)  The total time
   to print all of the CPUs is ultimately long enough to trigger the
   soft lockup watchdog.

2. print_tickdevice() - This function outputs a large amount of textual
   information.  This function also took approximately 100ms per CPU.

Since sysrq-<q> is not a performance critical path, there should be no
harm in touching the nmi watchdog in both slow sections above.  Touching
it in just one location was insufficient on systems with hundreds of
CPUs as occasional timeouts were still observed during testing.

This issue was observed on an Oracle T7 machine with 128 CPUs, but I
anticipate it may affect other systems with similarly large numbers of
CPUs.

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/time/timer_list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ba7d8b288bb3..ef4f16e81283 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -16,6 +16,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/nmi.h>
=20
 #include <asm/uaccess.h>
=20
@@ -96,6 +97,9 @@ print_active_timers(struct seq_file *m, struct hrtimer_cl=
ock_base *base,
=20
 next_one:
 	i =3D 0;
+
+	touch_nmi_watchdog();
+
 	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
=20
 	curr =3D timerqueue_getnext(&base->active);
@@ -207,6 +211,8 @@ print_tickdevice(struct seq_file *m, struct tick_device=
 *td, int cpu)
 {
 	struct clock_event_device *dev =3D td->evtdev;
=20
+	touch_nmi_watchdog();
+
 	SEQ_printf(m, "Tick Device: mode:     %d\n", td->mode);
 	if (cpu < 0)
 		SEQ_printf(m, "Broadcast device\n");
--=20
2.14.1

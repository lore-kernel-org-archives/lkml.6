Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236032-2-3091765919953612213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523236032; b=CULJ5FJ3i3WL7oqApxMmmiZwUVdEZmmsC+LrvJgdAU4o6vyZqw
    xjuNO/x26VymfIw3+HMkhWbX9aCHHtvyZ0UeuvdWSU+RYWR0DVkR/L7s3nfLTbkG
    cy6DcsuRE/ZpqPxqMMm/Rm1NRC4Fcr/k+1Awc1tqZ9ba2clC7qRj4j1ruPpUVZPQ
    MQlpNRy6Z5Usb+hBDHAJfYMnVnBezoKS6LXbXtLSz8Nss/FoQ5BNeiNeKHwaotk0
    fB20yN3FwGfDms2efy+YL/Lr8KiX+/I49yt/fSY+3dI7f5Ydso/UBw74YhNqYYCP
    y3F0R6gKaMa3Z56LW2svwOU1lF3P4v3zZYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236032; bh=5VHgtmHgB0
    bZNz06Yr/1sZPFxkcGpJWcDA1bL/p8HH8=; b=CQNjt1urjwSl75tNbwubmWXkw4
    U6nsJOm1x8Rnk69/37v42LTf5QCU6e3KYPrEMk4XhI9WtdpF6bF1u4n1sVhnKHoD
    dprGFuVq9T5D/qJzbplLdqm4LAs5A092ipZC54QGcvWC9H0Sv6ZhJ3O2nhu/fWAm
    DQ+5y/nHpIXjF93FiHdWoJxCP8oVSDOI/RkcCAe4x2vp/oEoWrGyazkR7qMF5q7h
    Ri0jbY3nglQTpbgPDslu4MD63AXw2ZmVLLwbZ2RyqugJ831Bjfxedfp4Ytlo4jf9
    fYBZl24LBmY/8wph66tYlA1oKlqIxvk/vj0u++sL7x+EXH1hIKLvvxqkyDBw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hV6ue5Nu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hV6ue5Nu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGIliIpus72QPzy7DhbnTwcu2cryFRaj9YTHHdEa4WFAKPwxQypG8r+tPkO/fZ4KFBRw0fCCGvILQOPWiOdRosEjmqhDm6PoXO7USgTq6bDplzhjJE9i
    fmIk6SLfl0JpuAlYRi9B/bqDQsgtDXEcIDvbgpo4AlmIEKykhWe8TzgagVkO1K3kWQ+bOVLU0XqtVlUg5pY/dpsmBSRZL4XNOrmmOPqPOsoZWYw6uweUx2VI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uTJJjIG0AAAA:8 a=1RTuLK3dAAAA:8 a=yMhMjlubAAAA:8
    a=lXvjdysV1vCtatfK9zYA:9 a=wPNLvfGTeEIA:10 a=Oxz5h5Y_mNNx07kSEfs-:22
    a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeDIBGl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:06:41 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932150AbeDIAjX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Coly Li <colyli@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 155/162] bcache: properly set task state in
 bch_writeback_thread()
Thread-Topic: [PATCH AUTOSEL for 4.4 155/162] bcache: properly set task state
 in bch_writeback_thread()
Thread-Index: AQHTz5nfN4m4EbvFHk2L7GEmV0MVqw==
Date: Mon, 9 Apr 2018 00:29:51 +0000
Message-ID: <20180409002738.163941-155-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:ePyOlG1A2lXS9tqY17jZlVWs3YlDjUuU7YNH9KNQZm07ZyCS7/A/SelzS0/1bY4mFKv9c4UFbAgaP5Ii1/qcwaZeg5Zw337zyCOeIqyXk0CzZKdJJfCfoM1CtEHia6ZezkI6W6t1lt9BA8/stGhImlmOn/UP1tm1sMaII8zhxBslOeiKD+MAPvdWa0WHc3OkhTv/U6vlgHLvGJYGpkaSMzPYiq8NAmwnDNQZyAQkKCVY4OippLH38MqoubFjTRdY;20:/X6VKNV7qjhNGK8tl/E8ONQ1sWafwWNh43jcsPPUX/W2HkHQKBskD+9kfXu/Mnw6dJR+mEOS2Kwqak615wG8fFafP+wVOGB6nuYsSgkiGusqlq0AfL9OFW137Lzp4alWjwZPSaZbwsVyCDBH4ZGBaCfejnIGAcPOcy32jIlfsH0=
X-MS-Office365-Filtering-Correlation-Id: a550832e-c8ae-46a5-3d28-08d59db2551f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125A1FEAA93C66FAB8F136DFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(31014005)(189003)(199004)(54534003)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8NvGe7X71UiykWAP9jL/zcGkvDqP3Xonlrvz5KeQCG40OH7468iIhURDbs3YeOsbNjRm9pZCerC+0lYYEn28Hp890pPz8mpq/K63uZcjz1ASfcL7eRd2YSnYWGqZouqMnCcIJpeW6lQMLmd4zoDMzOlUmeinXl70v1BKuZfuP3+ZDROVLw7kXDVU2w+cHr0yeG/27osw1e6KHU3QSaV8mEuXjfPZ9GniT+b9VEeIQep2fQ5XfhM46RDxdhbiSfLr4aPU0aiVSHXznBl6PmxMKp4DWHd24fiD8sq2gbQb1g9BrKK5gErppog+TLFcM9aooOV9bAGHx9v5Us/tBXVdZVbFKTP20ijDycUdawzsKh32w6Hok/VnVhfB+Iuq4V87gOlETG8iknUTMMDFaajSbQzjxyD4agN/veRTAquPYCw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550832e-c8ae-46a5-3d28-08d59db2551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:51.1621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Coly Li <colyli@suse.de>

[ Upstream commit 99361bbf26337186f02561109c17a4c4b1a7536a ]

Kernel thread routine bch_writeback_thread() has the following code block,

447         down_write(&dc->writeback_lock);
448~450     if (check conditions) {
451                 up_write(&dc->writeback_lock);
452                 set_current_state(TASK_INTERRUPTIBLE);
453
454                 if (kthread_should_stop())
455                         return 0;
456
457                 schedule();
458                 continue;
459         }

If condition check is true, its task state is set to TASK_INTERRUPTIBLE
and call schedule() to wait for others to wake up it.

There are 2 issues in current code,
1, Task state is set to TASK_INTERRUPTIBLE after the condition checks, if
   another process changes the condition and call wake_up_process(dc->
   writeback_thread), then at line 452 task state is set back to
   TASK_INTERRUPTIBLE, the writeback kernel thread will lose a chance to be
   waken up.
2, At line 454 if kthread_should_stop() is true, writeback kernel thread
   will return to kernel/kthread.c:kthread() with TASK_INTERRUPTIBLE and
   call do_exit(). It is not good to enter do_exit() with task state
   TASK_INTERRUPTIBLE, in following code path might_sleep() is called and a
   warning message is reported by __might_sleep(): "WARNING: do not call
   blocking ops when !TASK_RUNNING; state=3D1 set at [xxxx]".

For the first issue, task state should be set before condition checks.
Ineed because dc->writeback_lock is required when modifying all the
conditions, calling set_current_state() inside code block where dc->
writeback_lock is hold is safe. But this is quite implicit, so I still move
set_current_state() before all the condition checks.

For the second issue, frankley speaking it does not hurt when kernel thread
exits with TASK_INTERRUPTIBLE state, but this warning message scares users,
makes them feel there might be something risky with bcache and hurt their
data.  Setting task state to TASK_RUNNING before returning fixes this
problem.

In alloc.c:allocator_wait(), there is also a similar issue, and is also
fixed in this patch.

Changelog:
v3: merge two similar fixes into one patch
v2: fix the race issue in v1 patch.
v1: initial buggy fix.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Cc: Michael Lyle <mlyle@lyle.org>
Cc: Junhui Tang <tang.junhui@zte.com.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/bcache/alloc.c     | 4 +++-
 drivers/md/bcache/writeback.c | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 4d46f2ce606f..3263658ccedb 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -285,8 +285,10 @@ do {									\
 			break;						\
 									\
 		mutex_unlock(&(ca)->set->bucket_lock);			\
-		if (kthread_should_stop())				\
+		if (kthread_should_stop()) {				\
+			set_current_state(TASK_RUNNING);		\
 			return 0;					\
+		}							\
 									\
 		try_to_freeze();					\
 		schedule();						\
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index bbb1dc9e1639..4639270bf99b 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -425,19 +425,22 @@ static int bch_writeback_thread(void *arg)
=20
 	while (!kthread_should_stop()) {
 		down_write(&dc->writeback_lock);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!atomic_read(&dc->has_dirty) ||
 		    (!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags) &&
 		     !dc->writeback_running)) {
 			up_write(&dc->writeback_lock);
-			set_current_state(TASK_INTERRUPTIBLE);
=20
-			if (kthread_should_stop())
+			if (kthread_should_stop()) {
+				set_current_state(TASK_RUNNING);
 				return 0;
+			}
=20
 			try_to_freeze();
 			schedule();
 			continue;
 		}
+		set_current_state(TASK_RUNNING);
=20
 		searched_full_index =3D refill_dirty(dc);
=20
--=20
2.15.1

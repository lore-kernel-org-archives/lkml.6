Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234719-2-12988831436088970509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234718; b=vX9koYZJdOw3P3Dt3MNnBMH6H+NJT4brPQ1O2GKSHGHrgpiLA9
    BLVHY+Gg+2C2jeifcxAZ2QpsGs6eCHj23fblhmEw7cv3GZVf+sYrJ+7HTPwQbt+8
    ZEsBCGbccH7BtHUOtDgwiPPLUGLZCKejMPxNbAOze78QvFPBiw5GkLYEU9m4WBDa
    i+xxubEGfKT2oz/yRikM8YAFpLEY7Nfhh8gvTOoDkgSDo+uQ5BhZUphetFWg4omZ
    AiF9KOu7Wx2egtakwV8NX9Kf7In9z38sUcHknbfjfbp62R6QpQjET8QExRjoq+Zs
    gXsrI/t31HVHQKi/nwNG0RcGMIWU7NTaf6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234718; bh=Y3PIgVIdKV
    rHD6HJosi+XtY4xlpLtV744LZjOwftulU=; b=juHrA2HgLxHbOfrDsmgrbfJQqO
    NA3k7UFMhURDFJZRf6Dw/2gvRpqJYKKZKlNdYIaQNjeXga5nCn0SCDCBC4C3oOE2
    3XuU6vrWg2OBIw2dCRQwVdE9tkhLLM0bwCUY2ar50EQMnXlPYgtWZdPU8HTDtEhH
    QPdZJsv/vzZBRvp6Er4j7Ov+YqMq752jmwBFf1tsxbwEePFt5h5DIAiiTOyFU73o
    KaxvwbBkX9Whu1IOfU6d+bEhR+DGnwUyZxDQCpczwuQ2KY5RAWBJgwRFEK/B4ku6
    lmIlGvSV6YFISKRJEZlZDbdCuL704Cp4HHbHJLvoPsfkouEVvz8ZTKUyvT9g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Upr3eL2Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Upr3eL2Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLOwlALH5dWSLcR6n9HYWNpGEbGKZVxNrAdDr9i2A5TExA9fzPP2cuv6axF2KW1CGrHRVI5Y2gHzu57AGsDBBInlCBOuD/46Avl+6cCmz5/xsZVMNg+W
    1fZ532fd+HFLAB+WBu4BqwrYA7isQ7zzGjILsaFuL0OTcWUVB6lxUa5Mm1QCBN23lwO1TneVmEFi//57uStAd6XBtkHE637RsPNRldg2V0k4mI1+sl+N6RO7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uTJJjIG0AAAA:8 a=1RTuLK3dAAAA:8 a=yMhMjlubAAAA:8
    a=lXvjdysV1vCtatfK9zYA:9 a=wPNLvfGTeEIA:10 a=Oxz5h5Y_mNNx07kSEfs-:22
    a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756779AbeDIApC (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:45:02 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:45955
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756778AbeDIAma (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Coly Li <colyli@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 096/101] bcache: properly set task state in
 bch_writeback_thread()
Thread-Topic: [PATCH AUTOSEL for 3.18 096/101] bcache: properly set task state
 in bch_writeback_thread()
Thread-Index: AQHTz5uNq+6VJHEM6EmQIdN0CXE4bg==
Date: Mon, 9 Apr 2018 00:41:52 +0000
Message-ID: <20180409004042.164920-46-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:O2wxfx0y5fsdwykHNVg+A3Bjb+N28sOIkW36m5GxrvoW1vnA19bn09qL4Ghitjo7x6vDb59uNuBSGmwQYF/ztAQpYOkYTa3iEdd0J75L1Lb2RAcLw9gmKWFu3U8zMnnPQTspgD/Mr1qqaMfWhlgzzXHPzwbCNLj2vsIt6j4BQj5e0Yaolh7IM6aS0q8b/cJEh502KyfDhk84ALjT9UBesm/Ng7EcyBMLB1VbYDIIQvjrdyDTHT1llyomUG9xwAHW;20:M6TbXNL9JQAdWR4U8EcJA6Tzbj0U53KYMV5UT4747OpCxWY0EFFYv2Eq3vnHabRzhRupPz3fCdlpGKzOKvaoE6gZGc4Wr9o1KuZcZtS1h6Ta8ATlAna5qlt4oSovdfVk1Up4o/LqTB0bEK6kj8esv1FCmI8p6+26sdEcKhgQM0s=
X-MS-Office365-Filtering-Correlation-Id: c8c46c33-9a6f-4395-a6ca-08d59db2c43a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10300E0D0D776C3E43FAB909FBBF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(189003)(199004)(31014005)(54534003)(7736002)(5250100002)(53936002)(66066001)(97736004)(99286004)(6506007)(68736007)(186003)(26005)(22452003)(86362001)(11346002)(6486002)(486006)(305945005)(59450400001)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(2616005)(8936002)(8676002)(6512007)(81156014)(81166006)(2906002)(36756003)(6436002)(14454004)(86612001)(10090500001)(54906003)(2501003)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dse9ef2bKMcr7RMslWULXft5IocrRrCaUsQwyI7RVIgbubi0kecupGg+rRMAh6I85JsGLAqEsCIJKUA1Z6ABFVt0f/64P306JNuUEMFbR/sTSMSIC0PYErBR1amYV0Z12W6uXlA5NTxyCN3QXxVpKgsCghuGP9j4O+S1JxB94ph/2AiLLwEhJxWo3PGczKYUcAVW0p2J2tSM3+958TyDCyqEs+tIX+gz1PQLho/AvCkzU1Ieoq2zU7fWyVyIw3jlbXiNPVuvEZoNbo2nbK8quiwOGXI1/DOe8g4mngLSqVZer+qCIUaeSFNB2winK0oyCMU9ob7cchBkK6zz2cX9OAvJJZbGrRifKOIeSViQU6nO99D6Gu5K3sdI1k9rapQIGpc9qqLIcBCk+ekazMmVYeOm9pBcqhGCV2nCU4Jjoh8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c46c33-9a6f-4395-a6ca-08d59db2c43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:52.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index ea47980949ef..c1da2321bf26 100644
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
index b0667b321a3f..50726f12a7c3 100644
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

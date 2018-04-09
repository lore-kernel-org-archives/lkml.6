Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238288-2-12394044035170133120
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
    1523238286; b=pfnixXHUGGZjN1p8XaCWpNY4f0rrMzVJrsNaB32UeGdVtHGVUx
    XfsNNbc5meg1nPoMFSn7DT+jAFkywnkPFWLBmhT5i+s8GeX7Zrkf49p5x7Vyzym0
    eWeay6idlJGwt89wc8lNMrneXGsU7jQ5TwV8v5glVUqYkeVgdPzyITwvCJfju+QG
    TfNkJCJColbRdCBgaLHuH45I0b/YAadqJgIaaO83tPi6OcyIf6tz6jJ1MUfRH5hN
    Uc0DcXpU1gCv7ZvarwiP6/zdy9tLrjcw1djcw02BQ8GRd/H8017J1TpgekpCpQNT
    Nt1Fjzn0NARsqh/xC7d2zSfc1NzzIy6OUAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238286; bh=93E6r0HIja
    fGKClTpiXRNQiBdH8APUg51hPZbv12lH0=; b=TBo3Qh5MyNna5JyyQn/dHN5kmm
    WFEcscF9M6IrvpN4zplKYvkibJUyNX8H9Dfxsf2g5s+C+wTfxglOIYRZ2H5X23Ee
    cBJl6Nb7diDGQe5Jf55nrHYQryjUr3cOVncYZ+BQ7uNmgnYObGH7bjrB8rKrX81t
    5yPfTo7Aab/E9Yfe3+7zrHtKFVZZvG++jl18U6V85dIejw6r2ynl0g4QRVP58uaz
    N6bAAq1pmwA9oR/cYqgpHCACkDva0T9NNCk9bj4BagbskrFyPExuhEoFe3paikwo
    a8JqORzePM9hs1Ha2LIM2xWw3A0vljlUoDO7bd9yROSpJEszdHv8luh2PKHA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FcH7+YHd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FcH7+YHd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK+5joxZJUskcXH9L5ZMLQKiSAeD4xGCdw1y32jUC1iyLexVKFprwc4HITr79VC44162IkF+yMtKMNXKsyLgGsAgi5JLDnaYbkCzYGoZAyTEo2DgbuKd
    nFObfJxyWEt3z/AoA+7+I4x2FobbHHzeXoq5pmnkzO5GMSeqBvAOIt5vjNgCxa62aLjH9HuJz8csPZeiW2vOCwO4ZMlyu3olMsLAq67HtQB+pP7adVpDXWMS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uTJJjIG0AAAA:8 a=1RTuLK3dAAAA:8 a=yMhMjlubAAAA:8
    a=lXvjdysV1vCtatfK9zYA:9 a=wPNLvfGTeEIA:10 a=Oxz5h5Y_mNNx07kSEfs-:22
    a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeDIBnc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:32 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932508AbeDIAep (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Coly Li <colyli@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 281/293] bcache: properly set task state in
 bch_writeback_thread()
Thread-Topic: [PATCH AUTOSEL for 4.9 281/293] bcache: properly set task state
 in bch_writeback_thread()
Thread-Index: AQHTz5lqZm+MFUq//Eue+WDrmewE7Q==
Date: Mon, 9 Apr 2018 00:26:35 +0000
Message-ID: <20180409002239.163177-281-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:qCHAHAAB2Q/kzEtp3PP0BUf+ZqepvmZKHW8VOmgtfO5QZWBJ6PDo5DiD/Mk+Oh6UR4iwAsAB3k6HFT2roeyaOy6l8PVZgxzP/II2kbPHDgECnjju19kGJBqOay6h4EmgU4B/9nbcmXfNgwxTKR5l/Gk0B4pUW3b0DIBJ0Ov15lOEfjehnBM/vPadBlwXWpDkyVaNHHcMQeoz8VBndZPCD8RUBG7r2BseAzq0+oxhtXX5iAx7dOKTOvKj4DZ8J32U;20:ZxV5G05u/IW+UVZ75+J7lTL4xTiFcQ1VjH1G6C2OdotdWF3K4zaJxRJQM7sKxlmfButK1KBWyNEAXp4CUcHpA/G+LOmMgw3CpoafIxy2SC5j1Sx/f+yEycFXD7w2WdJobrRPOAbUt6JXJIwzbE0BbQf77SJD8hfxrp9ETHeUtG0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 202620bd-9ee7-4bee-8cd0-08d59db1af15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806C9FA243DEC168523515CFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(54534003)(31014005)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5NjzdSgSDOk2ImJXVsCSZTX61P49sI9D1Y0QMB4EIvSccIdabAA+4yx2yAg9cN5y0Qv7xgBOMjl7B+xRnTf2jVnByhSk42YUsf6d4zMWmA4SLfRRvXsT+Ik1zl+27F69sBuyUcxrARLoAK6qC0Y2ytMqSaKoyN1ko8nC7e1VgYMhx2BKIS2pwLTCQcuJVDnSuhxVKbnZaTyw3eEz4uVY9fkudWboRHsw2ALHHwo/ujcmIeuJU2kSotjPzeUdt2n9yA2RppHIG0IOinIfHJFPCFHz1WxS/3UVXuXjPlufXT5/JyMMCW5S2fL5jbkQjSag/KIISVtITnQ2QR/gPPVkxOYbANpMlELQyoNaBKL3iva6i6xMdPpE2PrYwtJ/paFC9uRYr6WX+n4k4hhUgj3YAi6W/UgSE0qyYev7m5oU/PU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202620bd-9ee7-4bee-8cd0-08d59db1af15
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:35.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
index 537903bf9add..8075731a745a 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -284,8 +284,10 @@ do {									\
 			break;						\
 									\
 		mutex_unlock(&(ca)->set->bucket_lock);			\
-		if (kthread_should_stop())				\
+		if (kthread_should_stop()) {				\
+			set_current_state(TASK_RUNNING);		\
 			return 0;					\
+		}							\
 									\
 		schedule();						\
 		mutex_lock(&(ca)->set->bucket_lock);			\
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 4ce2b19fe120..db30da77aefb 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -420,18 +420,21 @@ static int bch_writeback_thread(void *arg)
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
 			schedule();
 			continue;
 		}
+		set_current_state(TASK_RUNNING);
=20
 		searched_full_index =3D refill_dirty(dc);
=20
--=20
2.15.1

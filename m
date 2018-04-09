Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242525-5-12529317847793890334
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
    1523242523; b=SShPbc9Ebt4Q3YYdEoRdmW4Ad/8/J7DNe3x5Doecby3PaHlZUw
    sMisS3Aff991ypJhJ1xoaZpgGLFdgI8EXpO0rkV5eyEpvmWFH53qiy4pxipNhVbZ
    zMFN3AaqimCr/Xqf3iuTekPJkHjOiCTltsS6vkTebPqbpU2179rCvQXwVPU8o/Cp
    xy3ZO7d5Pnkzy9vWL/NzMx6HLPcevSpT/j+JSwer1MxgcUnCaJw2y7swt8p7V/d9
    owEG59V7RIFBBqNpO033vHgM/OsN2XdpbDT8+KwBEpyKIghzJm5QCpDXtbgICMmm
    01KtTGszMvao9Mxfo+3GLraZyh7mMFen/O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242523; bh=/FzdpxEORD
    5e5fzx9weTCW4YacEjRn275psqJDP3bMc=; b=cXMmmEwwAcoqPWgOOzfGCTIsi1
    kkt+mxUAx4/9SnTKKzgjmrhXkAguK+t85glwN9pmr9K3YjhbFupOUBrJJS/ECSi8
    OQzg1CEq2aQ8YSyjkHh8S7X/OG4yf1v3rMSd8Jj9GUYR8fRgjBUe4sq/OcKM0Qvf
    NJ/ZxNNzpoNTSJVujLFupqg2sGLEaI5LvfCzj7T/cRJ2GBnCeXQEqiJEFwp7WBBJ
    PBRmAC/AZQ/0IsEKyhrb+C/JtyMkJmhRwfMJDdY0ysGiX7ocmSPOFduhkYxs5aTB
    OqEtXYqhszOjI4RKg/f88sZNLhefvklP/9WZNya4n+xmPhHOL3TUIDsfEnEw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q+7mzN7U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Q+7mzN7U x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPZeF6jv4dR5vs2mRCgZU23XVKFufTStt96IeaJJNE8cQDaR7stRyrjX6GDVtoJCcciAaFzW3IrwM5kJ9aHpaXyX0/OLuVOGBBhhNruXJ8NnRPOWDXaU
    RVXF0dYaboKN5H66XX37UE4JmPqHmGJ3IqEcD7TENC+a5nREXGXu6SOGEstUjzuc1vue9+cNOBK2CqfWWNw/WjfjzuZqrw91jziT+q7CNUEbrO91TKDTUebm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uTJJjIG0AAAA:8 a=1RTuLK3dAAAA:8 a=yMhMjlubAAAA:8
    a=lXvjdysV1vCtatfK9zYA:9 a=wPNLvfGTeEIA:10 a=Oxz5h5Y_mNNx07kSEfs-:22
    a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755253AbeDIAZs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:48 -0400
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:48312
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755231AbeDIAZm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Coly Li <colyli@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 136/161] bcache: properly set task state in
 bch_writeback_thread()
Thread-Topic: [PATCH AUTOSEL for 4.14 136/161] bcache: properly set task state
 in bch_writeback_thread()
Thread-Index: AQHTz5i9mkZJgERp2kiL2Ha9LIidig==
Date: Mon, 9 Apr 2018 00:21:44 +0000
Message-ID: <20180409001936.162706-136-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:teV0OBpG6YPuryUXNDvjzhT7b+fyBcLjfYCAfVyOxgD0Mh37TSgb62BRBMSQPN1++598W2jXUgHePNamy9nEGgzghvoBAolJ0L/iVzZKwbSohfqoWwl2l5BRpJvO5hWtue6e+auSHc4YgYh7SsVCSGNIvRuQasL2MeX00MkRui6L6cP1xGZtuhTz4siAZ1CfF+oUa1Z5lKy9RmZT07Ruaqr20/syMiowj8JZk1rplK2meRSbRG1GMsTvc+j79Z4X;20:poE9u4QOOgr8ES6H+0D1Gl4qMbDmcLvVElbsmCy9b0OdJHyDyC8o5JeyYV8U/AOh23do0VpgpG6d+m31adpSI8N4JM2Y5x5Jkldv0dyRulDQzLiiB5NHsqLUvuBd/yRNqh1KTUWiY6Ovjhs+3IlhXjQ1U1yadGuo7fWIWQk54tY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ae58bcb-de5c-4027-de5a-08d59db06cb0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725255785854B4122451446FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(54534003)(199004)(189003)(31014005)(6486002)(81166006)(26005)(6512007)(4326008)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: oxgqlHKtyn3bTf3K5RrwWmIa0RhqYbmLrzszpZ+1H4IClTGumnHKw9jhgc4VQvKiea0FBv4UuCjv4VJyT4eXSCJplwxVOBOUqdEuP20Md5O+Yq/p5Wc4F5vO8xR5WWL0RqIl9RUwkvFXzkeflm03u2oy+Nrnp0I8edcqWdD7CdXzjvWlV/wQwHNjZy4iiKfCezYZrq7BwMAJzK7kq2XuaM91HhGUDvYNxA2h27DlcLOv6oSEdh3dJFizbJiDJib5lLnze2pGoxzfbajLP7VQZ7JJFYoGu1P+VRVxo+LzPI/biHp1oMlcFgqXjHpsFKkrXTIM5jy1cdMjfoubvS9329/zCeJiBgBm6l8re025HP5o2Cud06p4jL6J7uoZALFXKVw1GJM1jggX2R28RwmWTUGwCyJY+5Iy/8RCT+iRes0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae58bcb-de5c-4027-de5a-08d59db06cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:44.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 934b1fce4ce1..02b576d55758 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -287,8 +287,10 @@ do {									\
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
index 70454f2ad2fa..f046dedc59ab 100644
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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485441-2-13386537929631549834
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
    t=1520485440; b=jUESOcJ//e/szu1MP4I1W8lPjrAuLq5fOsn8aK9N+6xunLf
    MNmFbGlvksm8TOJgndtvZW8ElHziZ4yY//LgljcVckumMo2LNTReDNw9wdENUrU6
    qBsSS5iDFZ/k/W+wHHNvJdqLXSdc1p5d4x2qrGzwAoPJBXgD2SyW3SdyjwVoBqs8
    banyonJxIHHxeTtWlEY9pEZ1u22+tY53mZOUEfJhEF1QB1y7dROrEcERLTqnFk+r
    Vnq4bO1s2tnmnNXUACFRZrAzT5tdHfy4ETg8sgEIslvnVbKOqcui+VH+wEzisth2
    rFxKSXyZ+mIUpOd9Jo9Mhk2WhIkfPRajyh38//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485440; bh=7LUqFi
    3T+T1t6VqgsNRgj5jummjyojbDtPfmGYXTyqI=; b=diXqRAxvMceWSWB+6sMHED
    fkw0Euo6fI1nLkg9plZUnO+7ybvWo9bZg5bBE2uwzLQaZXdy0//kfYJZ5XBIGpUx
    xf+priAlsUokeEymdbhss9nmHyUQdUjAb/mSPX9TDgn34rXv+S7oHWw0WcZ03NVe
    y1v463pZjkoNKrCRJ6kOzmeHDRPKbwxCCNOrV0rHZMn3k2EOKGsjNSlmuX4U7wPi
    UwhtMCqYqxTkDYD/ecKxCVYdtUSy0NzZiA3U1yQIQxUqoTxw5zbdFu333MfaPGTn
    2el1T/vISShooqusk6Inn2ubLCALeakp+kxKgA9vZjnfsxfzCOegUxh8w7e/CPGg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FCLzkLii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FCLzkLii x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965760AbeCHFD6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:03:58 -0500
Received: from mail-co1nam03on0092.outbound.protection.outlook.com ([104.47.40.92]:45512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965206AbeCHFDz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 151/190] block/mq: Cure cpu hotplug lock
 inversion
Thread-Topic: [PATCH AUTOSEL for 4.9 151/190] block/mq: Cure cpu hotplug lock
 inversion
Thread-Index: AQHTtppOnU/v9sl6q061VXdrt0UAoA==
Date: Thu, 8 Mar 2018 04:59:58 +0000
Message-ID: <20180308045810.8041-151-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Tdt54bwCPmqFyK5etkN+X4bnndYNoE6dkPwzkSkOLNEJf8zyA6K+UQEaHu/knV8UJWCIf3AjVn+R+2dYlPvfgrOI2/T/nTMvAvgRc9/9fh2+2xlVPuKKyde+L2+UIGfSOGrJzp3nYGnqTVXUAoADt9Rc0Qc8NGCVZoZoCqm0c42K0ft4rEaK/evOUcdAYVy4eVnMFhbQC1ngDrN+JdLZ1UJwOzDZ5V4bSU2qY07GAohrBjXlpSzLMLRMieqTyeBY;20:fOM3kqQLj38sT1e9UW6mduVhk0IrBqop6HGEI1hyE3wGY80JJdEdd5+TsSHSK9uyF/twRTjoeSvxvkTz+pYnV+lakkvhcCgUmM1Ovgv3+nHm/i0LbzmahgarpICLaWE8Lcmcrk4J2QsRpwTn4NgVstjq5MTYcNzyNruOBztCIGk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dca47f84-36b6-4325-b785-08d584b1fd56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09021CBBD2F787A26B9DDFAFFBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 9umEIobU3NkdeS5ufv4S8eYPlAfUCQB45exWOxyoe9nBVuDhDfN9fqbDTZFgCdzfb14YdDQkErBNOaxWGrFD526TXWV+j7n5lzn6ml5jd0oyOMOm+UnFGAeRI/JaF6xzBRHWGyMY5CKCXIXekWnprSPwn6xdsuE9hBQ+XCTVU1m02AWA1UFIR10PrtZMbIcNWW4YntExdyHeNQIfwKWODSewDPTQJfXF6VTnX84b7eABIT6k6OH1DRK3x7ojbd52FNXz0FCP2WzLMxk7IPEtjUIATGOLq17epTJx98jUWeODG2Layr5kAvVbE2RGcLxC+w8fcn9uePOJzQMvugQqzA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca47f84-36b6-4325-b785-08d584b1fd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:58.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit eabe06595d62cfa9278e2cd012df614bc68a7042 ]

By poking at /debug/sched_features I triggered the following splat:

 [] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 [] WARNING: possible circular locking dependency detected
 [] 4.11.0-00873-g964c8b7-dirty #694 Not tainted
 [] ------------------------------------------------------
 [] bash/2109 is trying to acquire lock:
 []  (cpu_hotplug_lock.rw_sem){++++++}, at: [<ffffffff8120cb8b>] static_key=
_slow_dec+0x1b/0x50
 []
 [] but task is already holding lock:
 []  (&sb->s_type->i_mutex_key#4){+++++.}, at: [<ffffffff81140216>] sched_f=
eat_write+0x86/0x170
 []
 [] which lock already depends on the new lock.
 []
 []
 [] the existing dependency chain (in reverse order) is:
 []
 [] -> #2 (&sb->s_type->i_mutex_key#4){+++++.}:
 []        lock_acquire+0x100/0x210
 []        down_write+0x28/0x60
 []        start_creating+0x5e/0xf0
 []        debugfs_create_dir+0x13/0x110
 []        blk_mq_debugfs_register+0x21/0x70
 []        blk_mq_register_dev+0x64/0xd0
 []        blk_register_queue+0x6a/0x170
 []        device_add_disk+0x22d/0x440
 []        loop_add+0x1f3/0x280
 []        loop_init+0x104/0x142
 []        do_one_initcall+0x43/0x180
 []        kernel_init_freeable+0x1de/0x266
 []        kernel_init+0xe/0x100
 []        ret_from_fork+0x31/0x40
 []
 [] -> #1 (all_q_mutex){+.+.+.}:
 []        lock_acquire+0x100/0x210
 []        __mutex_lock+0x6c/0x960
 []        mutex_lock_nested+0x1b/0x20
 []        blk_mq_init_allocated_queue+0x37c/0x4e0
 []        blk_mq_init_queue+0x3a/0x60
 []        loop_add+0xe5/0x280
 []        loop_init+0x104/0x142
 []        do_one_initcall+0x43/0x180
 []        kernel_init_freeable+0x1de/0x266
 []        kernel_init+0xe/0x100
 []        ret_from_fork+0x31/0x40

 []  *** DEADLOCK ***
 []
 [] 3 locks held by bash/2109:
 []  #0:  (sb_writers#11){.+.+.+}, at: [<ffffffff81292bcd>] vfs_write+0x17d=
/0x1a0
 []  #1:  (debugfs_srcu){......}, at: [<ffffffff8155a90d>] full_proxy_write=
+0x5d/0xd0
 []  #2:  (&sb->s_type->i_mutex_key#4){+++++.}, at: [<ffffffff81140216>] sc=
hed_feat_write+0x86/0x170
 []
 [] stack backtrace:
 [] CPU: 9 PID: 2109 Comm: bash Not tainted 4.11.0-00873-g964c8b7-dirty #69=
4
 [] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.0=
2.0002.122320131210 12/23/2013
 [] Call Trace:

 []  lock_acquire+0x100/0x210
 []  get_online_cpus+0x2a/0x90
 []  static_key_slow_dec+0x1b/0x50
 []  static_key_disable+0x20/0x30
 []  sched_feat_write+0x131/0x170
 []  full_proxy_write+0x97/0xd0
 []  __vfs_write+0x28/0x120
 []  vfs_write+0xb5/0x1a0
 []  SyS_write+0x49/0xa0
 []  entry_SYSCALL_64_fastpath+0x23/0xc2

This is because of the cpu hotplug lock rework. Break the chain at #1
by reversing the lock acquisition order. This way i_mutex_key#4 no
longer depends on cpu_hotplug_lock and things are good.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 10f8f94b7f20..c6572ffc1e87 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2014,15 +2014,15 @@ struct request_queue *blk_mq_init_allocated_queue(s=
truct blk_mq_tag_set *set,
=20
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
=20
-	get_online_cpus();
 	mutex_lock(&all_q_mutex);
+	get_online_cpus();
=20
 	list_add_tail(&q->all_q_node, &all_q_list);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q, cpu_online_mask);
=20
-	mutex_unlock(&all_q_mutex);
 	put_online_cpus();
+	mutex_unlock(&all_q_mutex);
=20
 	return q;
=20
--=20
2.14.1

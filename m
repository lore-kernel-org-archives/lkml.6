Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244984-2-9256921277321816989
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
    1523244983; b=ACPjz/LpU5c8qQ/oPiJeUZj+LUBamV0yFVTPbOJQlETbWpkUzX
    Hw3kSpA1o9wUJhJaEylhZGxaKx0QsbtJDNhG0AIRrml0UnlSctSI3S4V7GjLvk6K
    2fiscCG+Uc6gEuaEzIX6sncdCAOJgirzOdbhh3cu5CTHbNC58vE+0RMSfmtTUYWA
    raBJ4nLXQ32Wml/HrtdMK8grD3sV0Drf7foNY2vNrgR/Xndsfl2Eam+KEUpqyo5P
    h95+SpUCP9HnG8hcwJuO01z1iHA4jwtsueRMdMVkE1T3amAiU2ABRwRSJrJR3Rvg
    vLCIfIfRw3PADVxrnFzM5AOAQfT6iK4uVWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244983; bh=c1oz1/vBzE
    oz9oPp5yBEonw0u4NZasdLNu9T1Vgjjmo=; b=eIMV14Rmb95TT/xf9UFciLv9Gn
    pqsxmthXUAV4Hy2CLMl/p+Z8xokiXItNSO8MW1L9k0ex+4SltrVjyy+iscgeLkQ+
    48W3myasPaTWLMRjQMUn40DjLuZWUkRDi2KBc3OQAhTSuWLgvRttKh/lw7U2Dn7V
    ni0sqv9p0D2YaGbmAnWbl+rfytg8TitrTSPDjkwyKfDRMV16iqd2plfoiuIfVlZ2
    WIap/iWlWXFInv2MuCyoeGIvpQDmhkYMLlktZUrbJyprGdSgi3x2uxiFei0E3hdl
    f74TYcg9veF0hiL9aD75Catr1c2dQ9oeNTWws63E00QAxUAnAamEYrjuumPQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mj7yxgCO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mj7yxgCO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFpksQIM7CBMoLsLxyFoebbNpmTN7ejlzi4NPeN0dOgrzyuiC/FsRrrXJlsimP0+kRpBDOPDUkgpkZfJy8uqTB11DZvE+NxlHq7iqKht++DCUBMu7Gej
    GPIFdy/SVOdT32Fwxo272MAW5NNGmtB87Q+Zg+pzZt4hGZ6dQgENeL4MVOf9mnmXAEr8U/MQIMhUCgfRaOV94mYiisn80qrte0HDaNFChHsYol7mk6sXo4br
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uTJJjIG0AAAA:8 a=1RTuLK3dAAAA:8 a=yMhMjlubAAAA:8
    a=lXvjdysV1vCtatfK9zYA:9 a=wPNLvfGTeEIA:10 a=Oxz5h5Y_mNNx07kSEfs-:22
    a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeDIAVO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:14 -0400
Received: from mail-sn1nam01on0130.outbound.protection.outlook.com ([104.47.32.130]:47481
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeDIAVK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Coly Li <colyli@suse.de>, Michael Lyle <mlyle@lyle.org>,
        Junhui Tang <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 160/189] bcache: properly set task state in
 bch_writeback_thread()
Thread-Topic: [PATCH AUTOSEL for 4.15 160/189] bcache: properly set task state
 in bch_writeback_thread()
Thread-Index: AQHTz5hZccnfENxRtU6xxY4hHOYAoQ==
Date: Mon, 9 Apr 2018 00:18:56 +0000
Message-ID: <20180409001637.162453-160-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:pM5fax5wXvA1e3WRxMTqh8HNPSi7xsbXyX4rY+3Pvo5sdqVd0WJXJAIBZlzxdJcppXW3ekj9I3DlQ+zYM/6aIi1AKgnkyTmjsNv1/SfNVz19F3AFLzRrn8t3Y3Ins2AtBGaGoA/KJLATprHhN4O0M0Z22N9gwxHz/MS6wuSFwDMgYBacKDSzBJV7OjCVyqX4w36IKenUTBwyYDEJLXjK4DIViz3LFJa4hLs1YyiuJ+468b5KaQXnCtF1VwsQ88hn;20:KiUabYVZBLkQsFaSo9eT7dQAqqOoTavA1W/nTjltfk23vymOiKKglBdR1YUeSoDZmQu2OaGzkqccJP5NExzNVzxa81t5VohHoTDYkxC7DOMq1zMLRQteOY25baRbBdZTP6u6YsffRpuhM4CQINeXLiVL/YUYRMsmyWbEVw3PRIM=
X-MS-Office365-Filtering-Correlation-Id: ba0a9eb2-03f6-49e4-1f3a-08d59dafc819
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09203E867C5E7B922021D069FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(54534003)(31014005)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(575784001)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4pQzi02bntJKfJyY86LNh6+k/oI6LZnLKopQrdfq5bBDTUS1AwM5rTGYkfN2YoQUffn2OVz+uBvL2NVS0HXe1hLzqPMWgss/EzFW0UXssphVAoXnqbjP/bc8zzkM3qYmG9aPbNhXTwsL9b5ZY63+0uG8IBH5poemIJrxeJhA3z3YsBwqdVBmWKxvDL9FsiQSqGM1sPGXNFWg9SIr83PKNqo6FsZzecoJkEQlmcfPfdVkP4clzPCD2Sg2afujGaAsaBtr3aMVWXXDD+szd9E9xn4KdNHyaYz4MLKCIBR/LyTPOya37d/54Br2l71SElBzp6oIWKvpjaT04TQSfy11Pn1dmJ0nmYqjUkkC7UJonQc/if+IjBqZ/Y21h4nyNZdbHLZ0B//o03O4Niq4+nbp+LNmeZwhKGjosUOmFHOjAlE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a9eb2-03f6-49e4-1f3a-08d59dafc819
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:56.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index a0cc1bc6d884..aa2b657e507a 100644
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
index 56a37884ca8b..2259f78e9434 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -445,18 +445,21 @@ static int bch_writeback_thread(void *arg)
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

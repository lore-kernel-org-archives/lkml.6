Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523247235-2-3005799143055824282
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523247234; b=Tz0GfV9/RTABqGeEQFFLsBskKUiF9IzXX4LbPyCwotbQUD6VBg
    Mcuzcor78ZP/UN6EIXfTKJ0TqAhMndM9GFRv1CVYJl3vnQ3iq8mq/HN8VUiCksie
    6ae1a3bmwpKNRbmqUPjCYn7pSM0xwkvDz+KrNd8GXzAI4Ym7rsUlJJmN2l9HKUZA
    kXuKnK49ZYwnRTOQPWf5puPLCa42bTg4XCtjuP90WiCcAqNU9Yvi08v2sjWmpLzi
    V354T9iyTZMMmOT+JuUB2Gq8XC31rrXF9NnR7nfR6XDc+rmiC392Ud4AHXNpwnjU
    W/Phsv1QtnjIsESb5e1x6yErlqeXqw6CN5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523247234; bh=PtOoFOUDF9
    ScFdlHJs5qE5JEhQt6q9ezpDBlqVYZ98w=; b=GoxVyBN34s5mQI3XA5Vy/Nwru9
    Rc79F2dtvLJIsg51G5rj8Me5+XjpNvtfXpDfBnfc2uOoPJN05nZ7I5uzO74ZG5dQ
    sRorXzr09pvtoDYc/5ygrtNpZObX56OF9jcwD0quxEuVxq4hIYuApR1z6hFb3oRE
    kT9UStDYr/8kDa9BsPVp2HnM8MV+oHkdzkTSOJNKSu7iVmD9/jnA0kK8cop1hmdK
    Xdyt75ifi2vcj9scUolj75q1+ivxbeN65W7ldf9PjJeZjfj4KfLAZP0nIZvOCkLS
    ceF+jNQa88EWmPApj/CfwpYZ20AQQuPoK28wmkCSy+T8IUV21hwWgztlcWUQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+nA9ApV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T+nA9ApV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGpFJ6PEaMb/g3vhrVQouX/gG+LdmwqZ/JpwmP8lGX51uBix+/ZCFJN5baVbn0eQlDprw9rG54upD9BkgyVELTmxmpollrgID5fEm04jA4jRLGpudvZz
    A3dJgS6lt4LrQP8ZP2krZf5QEPGWqU3IYHNfR3fbDxMtJQbLNTVl4g57ZpJGW2rMyPJzHv5usneFg+7ik9t5CD/k63srdYG4VYVnFNOXLB3qmv8L83FbCYXE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LTlYuqKXAAAA:8 a=yMhMjlubAAAA:8 a=a5XcU_zBD_3pCyHo_N0A:9
    a=wPNLvfGTeEIA:10 a=LYRRFYru7CLaib6k0cb5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDIENh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:13:37 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752556AbeDIAQt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Roy Shterman <roys@lightbitslabs.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 004/189] nvme: host delete_work and
 reset_work on separate workqueues
Thread-Topic: [PATCH AUTOSEL for 4.15 004/189] nvme: host delete_work and
 reset_work on separate workqueues
Thread-Index: AQHTz5gLCjUzKmzdb0+tE97QpRQ/Vg==
Date: Mon, 9 Apr 2018 00:16:46 +0000
Message-ID: <20180409001637.162453-4-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:vZw6sjhVKofY71kpZyNGuqy5GAHC/sWwDVDFCPFBclhkcjIhSGmymBBBJvQU1sBspQrfMRtOLWklrlOiVjkQugL4MD7BgJSr9MTo4jwU9tKJ1dOT1UmIUSyyUJm+uTYiz5qVaPm38JVnEvw3Gq3DWagflwd3frm7I9XHkjD+/3TYdRkvnWX0m5TF6aul3o/xKVlqnKOE9ztth9dfXdJhrV1d3/mX0P2owhjIiInQ+Jx/GXQ0D9gsoe7F6F6fhOwV;20:g0zNLVqBe2G+wbkBhJQj1Yw9W1i/P6T3r3QJcjgRkH6SDaVeIZmHWVZTEAFXfGsbKbBEHZQ7OqvRvJTW2TQa2ZOejuhK0g7lcDhkYaTdZE5rjCJaKC4nbuzlxSjtw6knAjIZs18/hJgU5/agyK88LWZ7e8h+imC5nb+Y8qWJwdY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: eb562f41-37cc-49fc-c109-08d59daf2e9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968043EADF68D7B8AC3FAEEFBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(51234002)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(575784001)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: g6ftRqFCbbUG7VdMS9YlyyYUt4ApgjuJTNLGaIGvpk9j2lp+rx+xEjn+OtDevnqtRsEsxAIaQF7krzDLzx6K2tpPP+LyGKwXMA1nMvPO95sDkc9WwuYiCOCKBZ9AGRtjcduKQ8u3R3kBUMaJ9GuEKu9fjjObh46lQPVK+gVgw8R8rKVZW0IguHPr10XRGMKHXI9fO0+VgoJCJr0iFQYe5OuCkAfF4WxK+5azStYz+xzdDAQQ4WBIi/XsjAZTw8TQ6PbonVTim/FBdpcH32rl7lXUf/FX/ZITY6fVRzoe6U03ahrrRNrd5xQkdcJPl511vCGDaMOq+/GLo9WfK/2+H5vSNsWsLkzDQvDgDbMVH/MLQepPD4nxrasE8sYl8cZy8VL4TZT3JkAlV7g1m56K5+s7IHIQHZOXLf9c3ptDqak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb562f41-37cc-49fc-c109-08d59daf2e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:46.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Roy Shterman <roys@lightbitslabs.com>

[ Upstream commit b227c59b9b5b8ae52639c8980af853d2f654f90a ]

We need to ensure that delete_work will be hosted on a different
workqueue than all the works we flush or cancel from it.
Otherwise we may hit a circular dependency warning [1].

Also, given that delete_work flushes reset_work, host reset_work
on nvme_reset_wq and delete_work on nvme_delete_wq. In addition,
fix the flushing in the individual drivers to flush nvme_delete_wq
when draining queued deletes.

[1]:
[  178.491942] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  178.492718] [ INFO: possible recursive locking detected ]
[  178.493495] 4.9.0-rc4-c844263313a8-lb #3 Tainted: G           OE
[  178.494382] ---------------------------------------------
[  178.495160] kworker/5:1/135 is trying to acquire lock:
[  178.495894]  (
[  178.496120] "nvme-wq"
[  178.496471] ){++++.+}
[  178.496599] , at:
[  178.496921] [<ffffffffa70ac206>] flush_work+0x1a6/0x2d0
[  178.497670]
               but task is already holding lock:
[  178.498499]  (
[  178.498724] "nvme-wq"
[  178.499074] ){++++.+}
[  178.499202] , at:
[  178.499520] [<ffffffffa70ad6c2>] process_one_work+0x162/0x6a0
[  178.500343]
               other info that might help us debug this:
[  178.501269]  Possible unsafe locking scenario:

[  178.502113]        CPU0
[  178.502472]        ----
[  178.502829]   lock(
[  178.503115] "nvme-wq"
[  178.503467] );
[  178.503716]   lock(
[  178.504001] "nvme-wq"
[  178.504353] );
[  178.504601]
                *** DEADLOCK ***

[  178.505441]  May be due to missing lock nesting notation

[  178.506453] 2 locks held by kworker/5:1/135:
[  178.507068]  #0:
[  178.507330]  (
[  178.507598] "nvme-wq"
[  178.507726] ){++++.+}
[  178.508079] , at:
[  178.508173] [<ffffffffa70ad6c2>] process_one_work+0x162/0x6a0
[  178.509004]  #1:
[  178.509265]  (
[  178.509532] (&ctrl->delete_work)
[  178.509795] ){+.+.+.}
[  178.510145] , at:
[  178.510239] [<ffffffffa70ad6c2>] process_one_work+0x162/0x6a0
[  178.511070]
               stack backtrace:
:
[  178.511693] CPU: 5 PID: 135 Comm: kworker/5:1 Tainted: G           OE   =
4.9.0-rc4-c844263313a8-lb #3
[  178.512974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.1-1ubuntu1 04/01/2014
[  178.514247] Workqueue: nvme-wq nvme_del_ctrl_work [nvme_tcp]
[  178.515071]  ffffc2668175bae0 ffffffffa7450823 ffffffffa88abd80 ffffffff=
a88abd80
[  178.516195]  ffffc2668175bb98 ffffffffa70eb012 ffffffffa8d8d90d ffff9c47=
2e9ea700
[  178.517318]  ffff9c472e9ea700 ffff9c4700000000 ffff9c4700007200 ab83be61=
bec0d50e
[  178.518443] Call Trace:
[  178.518807]  [<ffffffffa7450823>] dump_stack+0x85/0xc2
[  178.519542]  [<ffffffffa70eb012>] __lock_acquire+0x17d2/0x18f0
[  178.520377]  [<ffffffffa75839a7>] ? serial8250_console_putchar+0x27/0x30
[  178.521330]  [<ffffffffa7583980>] ? wait_for_xmitr+0xa0/0xa0
[  178.522174]  [<ffffffffa70ac1eb>] ? flush_work+0x18b/0x2d0
[  178.522975]  [<ffffffffa70eb7cb>] lock_acquire+0x11b/0x220
[  178.523753]  [<ffffffffa70ac206>] ? flush_work+0x1a6/0x2d0
[  178.524535]  [<ffffffffa70ac229>] flush_work+0x1c9/0x2d0
[  178.525291]  [<ffffffffa70ac206>] ? flush_work+0x1a6/0x2d0
[  178.526077]  [<ffffffffa70a9cf0>] ? flush_workqueue_prep_pwqs+0x220/0x22=
0
[  178.527040]  [<ffffffffa70ae7cf>] __cancel_work_timer+0x10f/0x1d0
[  178.527907]  [<ffffffffa70fecb9>] ? vprintk_default+0x29/0x40
[  178.528726]  [<ffffffffa71cb507>] ? printk+0x48/0x50
[  178.529434]  [<ffffffffa70ae8c3>] cancel_delayed_work_sync+0x13/0x20
[  178.530381]  [<ffffffffc042100b>] nvme_stop_ctrl+0x5b/0x70 [nvme_core]
[  178.531314]  [<ffffffffc0403dcc>] nvme_del_ctrl_work+0x2c/0x50 [nvme_tcp=
]
[  178.532271]  [<ffffffffa70ad741>] process_one_work+0x1e1/0x6a0
[  178.533101]  [<ffffffffa70ad6c2>] ? process_one_work+0x162/0x6a0
[  178.533954]  [<ffffffffa70adc4e>] worker_thread+0x4e/0x490
[  178.534735]  [<ffffffffa70adc00>] ? process_one_work+0x6a0/0x6a0
[  178.535588]  [<ffffffffa70adc00>] ? process_one_work+0x6a0/0x6a0
[  178.536441]  [<ffffffffa70b48cf>] kthread+0xff/0x120
[  178.537149]  [<ffffffffa70b47d0>] ? kthread_park+0x60/0x60
[  178.538094]  [<ffffffffa70b47d0>] ? kthread_park+0x60/0x60
[  178.538900]  [<ffffffffa78e332a>] ret_from_fork+0x2a/0x40

Signed-off-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvme/host/core.c   | 44 +++++++++++++++++++++++++++++++++++++++---=
--
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 935593032123..93a4fa053e7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -65,9 +65,26 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
=20
+/*
+ * nvme_wq - hosts nvme related works that are not reset or delete
+ * nvme_reset_wq - hosts nvme reset works
+ * nvme_delete_wq - hosts nvme delete works
+ *
+ * nvme_wq will host works such are scan, aen handling, fw activation,
+ * keep-alive error recovery, periodic reconnects etc. nvme_reset_wq
+ * runs reset works which also flush works hosted on nvme_wq for
+ * serialization purposes. nvme_delete_wq host controller deletion
+ * works which flush reset works for serialization.
+ */
 struct workqueue_struct *nvme_wq;
 EXPORT_SYMBOL_GPL(nvme_wq);
=20
+struct workqueue_struct *nvme_reset_wq;
+EXPORT_SYMBOL_GPL(nvme_reset_wq);
+
+struct workqueue_struct *nvme_delete_wq;
+EXPORT_SYMBOL_GPL(nvme_delete_wq);
+
 static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
@@ -89,7 +106,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return -EBUSY;
-	if (!queue_work(nvme_wq, &ctrl->reset_work))
+	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
 		return -EBUSY;
 	return 0;
 }
@@ -122,7 +139,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
-	if (!queue_work(nvme_wq, &ctrl->delete_work))
+	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
 		return -EBUSY;
 	return 0;
 }
@@ -3491,16 +3508,26 @@ EXPORT_SYMBOL_GPL(nvme_reinit_tagset);
=20
 int __init nvme_core_init(void)
 {
-	int result;
+	int result =3D -ENOMEM;
=20
 	nvme_wq =3D alloc_workqueue("nvme-wq",
 			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
 	if (!nvme_wq)
-		return -ENOMEM;
+		goto out;
+
+	nvme_reset_wq =3D alloc_workqueue("nvme-reset-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvme_reset_wq)
+		goto destroy_wq;
+
+	nvme_delete_wq =3D alloc_workqueue("nvme-delete-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvme_delete_wq)
+		goto destroy_reset_wq;
=20
 	result =3D alloc_chrdev_region(&nvme_chr_devt, 0, NVME_MINORS, "nvme");
 	if (result < 0)
-		goto destroy_wq;
+		goto destroy_delete_wq;
=20
 	nvme_class =3D class_create(THIS_MODULE, "nvme");
 	if (IS_ERR(nvme_class)) {
@@ -3519,8 +3546,13 @@ destroy_class:
 	class_destroy(nvme_class);
 unregister_chrdev:
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
+destroy_delete_wq:
+	destroy_workqueue(nvme_delete_wq);
+destroy_reset_wq:
+	destroy_workqueue(nvme_reset_wq);
 destroy_wq:
 	destroy_workqueue(nvme_wq);
+out:
 	return result;
 }
=20
@@ -3530,6 +3562,8 @@ void nvme_core_exit(void)
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
+	destroy_workqueue(nvme_delete_wq);
+	destroy_workqueue(nvme_reset_wq);
 	destroy_workqueue(nvme_wq);
 }
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55c49a1aa231..d320df9ab588 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -32,6 +32,8 @@ extern unsigned int admin_timeout;
 #define NVME_KATO_GRACE		10
=20
 extern struct workqueue_struct *nvme_wq;
+extern struct workqueue_struct *nvme_reset_wq;
+extern struct workqueue_struct *nvme_delete_wq;
=20
 enum {
 	NVME_NS_LBA		=3D 0,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a0bba7f50cf..145aa97067d4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2040,7 +2040,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib=
_device, void *client_data)
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
=20
-	flush_workqueue(nvme_wq);
+	flush_workqueue(nvme_delete_wq);
 }
=20
 static struct ib_client nvme_rdma_ib_client =3D {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1e21b286f299..5d8054f9a412 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -716,7 +716,7 @@ static void __exit nvme_loop_cleanup_module(void)
 		nvme_delete_ctrl(&ctrl->ctrl);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
=20
-	flush_workqueue(nvme_wq);
+	flush_workqueue(nvme_delete_wq);
 }
=20
 module_init(nvme_loop_init_module);
--=20
2.15.1

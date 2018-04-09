Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243038-2-12553029692608451000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243037; b=nYI4UsZ6LsDsMrSInBf2s7Q/vebxiYaLZSbCdbpMJ1/RC/gTmf
    h0xz0QgkEmrArq5bRwacTpFdkKDKg9bO8j6HHIK6uugd2JDiao8vWhBRda7Jrvw/
    3gtF9BOAlD6/G2EEcK9plCYw0/5tiEflEZ8E2k2uEx71f7avkdNifVHXNMi9t8rk
    HqE7cPCZp12dgvJVSVat10vY+IgG3yEcnOcBg/qo1ntoeb1If35EKpXA6pkXX3Fa
    Wzy/FUlyLtRj/fIMUtRXv6Bzg8xGq4Q79Q/q1CvzGBCpmVURNXtKLdRod/88vM5M
    gKWqpTSmiLLeC/D4OvltFN54KPL4updpAWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243037; bh=Y0Fx6Z94Ab
    EpQ0CTuCQzCWuJYuswu/sPMv5AJ5ZUj3I=; b=RNCQwNW/tN6bkUCVty9Tps/yo9
    LwcSAH9qzWmA6TTGKq7UbkYWEEdXmJEckE49NP25dGrStNHWg4piZHxkCgq0IqZw
    O3OVerJ+gMc/EUs8JhdirBkIlj81W4j98FXblQoCXX2WfwVrDNmIpoDF7m9Sk6vP
    U6D2noBCcJxCMYHL0Lv/eBara/f9DwJ1pTkexlUXg5lpycptoalXMbn4wNQKLGlR
    8u8R6eu+zgKzoFwp3BH/chUimlPHGX2NgbU18b744JtzxSCO69lyjzb5Bir6p9z3
    CFKLCalv4nh/6dcgoxCLq5l1JyrAzcC3iovhpyjgTQCqP5TknuK3ElqGzSKg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dfyLSTuF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dfyLSTuF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI/MqDnXmYmToqfKE9VKo4+BjPD9PK4bWPfHAgxOP5jrUoMzsrNgGsm2NWDJLLA4E4hBQ8c6o9irH5ut4B4HTNnZ/CeCBKsammDd8Ih30elydPyqQM9j
    6Q/mGG4UUp4xlN4QipkxZWCAnhH2FFz5KP0TfYP/SYFR3oFMo/cjepjL+fUfo/flE+xJAXD7cccVqCjsQRXCWWNWN5tNzl4U7yw2XcgmI6KeIs++HRLPzEki
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=RgodnQvDy0uhUUV8o6kA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeDIDDw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:03:52 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755094AbeDIAYx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 107/161] blk-mq: fix discard merge with
 scheduler attached
Thread-Topic: [PATCH AUTOSEL for 4.14 107/161] blk-mq: fix discard merge with
 scheduler attached
Thread-Index: AQHTz5iucpgoiJKTYEO/j2ksBcfvnA==
Date: Mon, 9 Apr 2018 00:21:19 +0000
Message-ID: <20180409001936.162706-107-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:WMYYxMCm92FpYgVv8wL0SoBHYf7xxZuaGYzj+0Mw4E3argOunxo6vmLtFQ49BnF/fkKkJWIJ4PJRzy6B9RAL69znBOwdF7PLUFNb3dL9o31WZUGOfVOI7xVz8uTf5XOrXw7ElB5Q4AVWhZvgmomWt/m0wZbvE0/j1G8j1PQJHPknKyXmpUDgyuCKdoTbvjwOU4v6jnGHMud+Ltgnc5QN+W4eZSkqC0ThgKzyGkUvr+sYhbom4VAF1E16czwUGFiG;20:LnGk/HXNQLaoLuPjbSmpoOzS8aNiDm4l3t+Jzst+qfJBi/4XRovw9hHYeyLsTgCPy1gvebTim7q0dhX99zHmJSsJ8HK0Uhr2jlGROKJg0TTBgBcy1zjqE9TI//SjhcNlpR7a7Sz/6bCUwU/BQYHnmMZscPK6UhMW10pt92j+Kek=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bc1d6c2-7ed1-4b9f-c57f-08d59db04c91
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983A950C0E348A86864E520FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(551934003)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0jCIDF6rRZ2rB+JSH/s9dwb963lMHgS87GDEAVgnY5H+Tmght0CXvAUE+MBwJ7/Pg/26KqUTg64EEI72Ouvg45juJn/ZTBgQcjcZT/6a0/EGdI9IrirHfcj1x6OfzKx5MI5zswB8qtPUeKGBc2SlgfpcUtjENn3nqegu/LIT8RkNFCN8u6buHiG1SILgdIeoVud3rntffWoIcHIwTW3+Mde5BkTZVZWkTABOTurUXcj8c4E+hrGJJU4dJlsw4XpsSdj/o6Q9El0BtKOl2p1gWlWLOyoVapnaEl9tfAkRVm+gBvm1fYtEJaQFQI3aiLiRWTgNMW0ITdxUK2a3eEyOj5S1Gb1RJ+WvmWwZXqDDx6AUJXqgI8oJQPag8Hu3+T+UKjgdYwMsKNq0IlE1qnAld6d4DBEFptW+X7Dk36qkxtw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc1d6c2-7ed1-4b9f-c57f-08d59db04c91
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:19.9250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 445251d0f4d329aa061f323546cd6388a3bb7ab5 ]

I ran into an issue on my laptop that triggered a bug on the
discard path:

WARNING: CPU: 2 PID: 207 at drivers/nvme/host/core.c:527 nvme_setup_cmd+0x3=
d3/0x430
 Modules linked in: rfcomm fuse ctr ccm bnep arc4 binfmt_misc snd_hda_codec=
_hdmi nls_iso8859_1 nls_cp437 vfat snd_hda_codec_conexant fat snd_hda_codec=
_generic iwlmvm snd_hda_intel snd_hda_codec snd_hwdep mac80211 snd_hda_core=
 snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi snd_seq x86_pkg_temp_t=
hermal intel_powerclamp kvm_intel uvcvideo iwlwifi btusb snd_seq_device vid=
eobuf2_vmalloc btintel videobuf2_memops kvm snd_timer videobuf2_v4l2 blueto=
oth irqbypass videobuf2_core aesni_intel aes_x86_64 crypto_simd cryptd snd =
glue_helper videodev cfg80211 ecdh_generic soundcore hid_generic usbhid hid=
 i915 psmouse e1000e ptp pps_core xhci_pci xhci_hcd intel_gtt
 CPU: 2 PID: 207 Comm: jbd2/nvme0n1p7- Tainted: G     U           4.15.0+ #=
176
 Hardware name: LENOVO 20FBCTO1WW/20FBCTO1WW, BIOS N1FET59W (1.33 ) 12/19/2=
017
 RIP: 0010:nvme_setup_cmd+0x3d3/0x430
 RSP: 0018:ffff880423e9f838 EFLAGS: 00010217
 RAX: 0000000000000000 RBX: ffff880423e9f8c8 RCX: 0000000000010000
 RDX: ffff88022b200010 RSI: 0000000000000002 RDI: 00000000327f0000
 RBP: ffff880421251400 R08: ffff88022b200000 R09: 0000000000000009
 R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000ffff
 R13: ffff88042341e280 R14: 000000000000ffff R15: ffff880421251440
 FS:  0000000000000000(0000) GS:ffff880441500000(0000) knlGS:00000000000000=
00
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b684795030 CR3: 0000000002e09006 CR4: 00000000001606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  nvme_queue_rq+0x40/0xa00
  ? __sbitmap_queue_get+0x24/0x90
  ? blk_mq_get_tag+0xa3/0x250
  ? wait_woken+0x80/0x80
  ? blk_mq_get_driver_tag+0x97/0xf0
  blk_mq_dispatch_rq_list+0x7b/0x4a0
  ? deadline_remove_request+0x49/0xb0
  blk_mq_do_dispatch_sched+0x4f/0xc0
  blk_mq_sched_dispatch_requests+0x106/0x170
  __blk_mq_run_hw_queue+0x53/0xa0
  __blk_mq_delay_run_hw_queue+0x83/0xa0
  blk_mq_run_hw_queue+0x6c/0xd0
  blk_mq_sched_insert_request+0x96/0x140
  __blk_mq_try_issue_directly+0x3d/0x190
  blk_mq_try_issue_directly+0x30/0x70
  blk_mq_make_request+0x1a4/0x6a0
  generic_make_request+0xfd/0x2f0
  ? submit_bio+0x5c/0x110
  submit_bio+0x5c/0x110
  ? __blkdev_issue_discard+0x152/0x200
  submit_bio_wait+0x43/0x60
  ext4_process_freed_data+0x1cd/0x440
  ? account_page_dirtied+0xe2/0x1a0
  ext4_journal_commit_callback+0x4a/0xc0
  jbd2_journal_commit_transaction+0x17e2/0x19e0
  ? kjournald2+0xb0/0x250
  kjournald2+0xb0/0x250
  ? wait_woken+0x80/0x80
  ? commit_timeout+0x10/0x10
  kthread+0x111/0x130
  ? kthread_create_worker_on_cpu+0x50/0x50
  ? do_group_exit+0x3a/0xa0
  ret_from_fork+0x1f/0x30
 Code: 73 89 c1 83 ce 10 c1 e1 10 09 ca 83 f8 04 0f 87 0f ff ff ff 8b 4d 20=
 48 8b 7d 00 c1 e9 09 48 01 8c c7 00 08 00 00 e9 f8 fe ff ff <0f> ff 4c 89 =
c7 41 bc 0a 00 00 00 e8 0d 78 d6 ff e9 a1 fc ff ff
 ---[ end trace 50d361cc444506c8 ]---
 print_req_error: I/O error, dev nvme0n1, sector 847167488

Decoding the assembly, the request claims to have 0xffff segments,
while nvme counts two. This turns out to be because we don't check
for a data carrying request on the mq scheduler path, and since
blk_phys_contig_segment() returns true for a non-data request,
we decrement the initial segment count of 0 and end up with
0xffff in the unsigned short.

There are a few issues here:

1) We should initialize the segment count for a discard to 1.
2) The discard merging is currently using the data limits for
   segments and sectors.

Fix this up by having attempt_merge() correctly identify the
request, and by initializing the segment count correctly
for discards.

This can only be triggered with mq-deadline on discard capable
devices right now, which isn't a common configuration.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/blk-core.c  |  2 ++
 block/blk-merge.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c01f4907dbbc..1feeb1a8aad9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3065,6 +3065,8 @@ void blk_rq_bio_prep(struct request_queue *q, struct =
request *rq,
 {
 	if (bio_has_data(bio))
 		rq->nr_phys_segments =3D bio_phys_segments(q, bio);
+	else if (bio_op(bio) =3D=3D REQ_OP_DISCARD)
+		rq->nr_phys_segments =3D 1;
=20
 	rq->__data_len =3D bio->bi_iter.bi_size;
 	rq->bio =3D rq->biotail =3D bio;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index f5dedd57dff6..8d60a5bbcef9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -551,6 +551,24 @@ static bool req_no_special_merge(struct request *req)
 	return !q->mq_ops && req->special;
 }
=20
+static bool req_attempt_discard_merge(struct request_queue *q, struct requ=
est *req,
+		struct request *next)
+{
+	unsigned short segments =3D blk_rq_nr_discard_segments(req);
+
+	if (segments >=3D queue_max_discard_segments(q))
+		goto no_merge;
+	if (blk_rq_sectors(req) + bio_sectors(next->bio) >
+	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
+		goto no_merge;
+
+	req->nr_phys_segments =3D segments + blk_rq_nr_discard_segments(next);
+	return true;
+no_merge:
+	req_set_nomerge(q, req);
+	return false;
+}
+
 static int ll_merge_requests_fn(struct request_queue *q, struct request *r=
eq,
 				struct request *next)
 {
@@ -684,9 +702,13 @@ static struct request *attempt_merge(struct request_qu=
eue *q,
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
-	 * counts here.
+	 * counts here. Handle DISCARDs separately, as they
+	 * have separate settings.
 	 */
-	if (!ll_merge_requests_fn(q, req, next))
+	if (req_op(req) =3D=3D REQ_OP_DISCARD) {
+		if (!req_attempt_discard_merge(q, req, next))
+			return NULL;
+	} else if (!ll_merge_requests_fn(q, req, next))
 		return NULL;
=20
 	/*
@@ -716,7 +738,8 @@ static struct request *attempt_merge(struct request_que=
ue *q,
=20
 	req->__data_len +=3D blk_rq_bytes(next);
=20
-	elv_merge_requests(q, req, next);
+	if (req_op(req) !=3D REQ_OP_DISCARD)
+		elv_merge_requests(q, req, next);
=20
 	/*
 	 * 'next' is going away, so update stats accordingly
--=20
2.15.1

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246373-2-7013840897596009977
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246372; b=Sy99cOi5SJMd3it59+2XUQw2YTsPXwGktBLPBpBKGotEeogWrn
    qKujLd+0+bKZuWQc1CkyLDZe0AVqOoJCFO2dTGohoCZdQRXR9a1slMDKis2qBfyx
    TmJd/aRXrszuKgccQ7GxUebd4vr3AJuJp7O0pYN7O7sXoBwOKT/VrITVyw9Ge7JU
    dVKHy35NMwiC+HbxjUI6GcvZDEX4bw4YtNsK+hY5raIig2QTf4L50Lxc8Bud1gmX
    AvYYT4L6wQXYdHGHsnxrYyZdb8zI6U/LCN67FtiS/CZ9wx3nTuhi6kb7lMkGoVE1
    CE6n5oybEFNO7glTi2bhib4/MIWG+qGaE3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246372; bh=zKi3kYNuLc
    Y75fe1TEoZ8o7z6irNVq1oceHagqALo+o=; b=bK4R2UvtYWpgEq+sSZP8GFKTjU
    uNHTCe8iHvmyC1xOJhgG3HtN8Ohj1OHkm3+0F7ef+Tf+LTaV2HWWIhakhHqkDmn3
    o5d2K/prtiB6d/UBnfd6h6bMI9FX0JWFifcig63DrozQ8JPs5cDlpQKEXVMMNjDW
    OOyU29RMO2gZIDZ93MRcrE4oumo38dTJ6eCbN2367C7GL/qkjhMYnsrZusk6mCOq
    Qk3lgoFCksCWb0yuKAjDEnaAaAM+2prdyk5yDmjZDpYcpxDZA3bIZuY3NIOWw8if
    4duyg3OgXDIiUMTe2cRJP51a85Sg0hlQ0xOTBolqg004thg+jTr0EXXIYxqw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ofw+o0Yf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ofw+o0Yf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMkAJiyxQkF9m8WNc1HVeucXJVT9WeP/oDiOeb8ZTSEiaWY/yJbyYMaZZh6aHT8wG31ZgsjwPNUc4+FY2auweY5fQOiUHQsaydtOpQfbSfyVdRGEQLz0
    Q3xGlZwFPntqekW8CpAl7wMRuOywj/36vxjvobtJyZndo2R1E7+98OAHXGozezeCpthgbDjh8iCIQO84YDKlTwBGQNnc3RtDdweIS9798q5UH3/vy4Zeys/u
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=RpywtofDEX2MDo3HS_AA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeDID7L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:59:11 -0400
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:37278
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753596AbeDIASf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sheng Yong <shengyong1@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 068/189] f2fs: avoid hungtask when GC
 encrypted block if io_bits is set
Thread-Topic: [PATCH AUTOSEL for 4.15 068/189] f2fs: avoid hungtask when GC
 encrypted block if io_bits is set
Thread-Index: AQHTz5gqD1/FMi4Xd0qH16sj72GRkw==
Date: Mon, 9 Apr 2018 00:17:38 +0000
Message-ID: <20180409001637.162453-68-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:Z3Yf05hAyBIhfxYn/5ksGVsyJtwB4NpMH1Y7uPcu+5bSwbKrvOBJ7uj4VZWbQsSyFEIL3iwYlUTiAR1DEKa1VuDc70MINzJujJcnbmV53vBAUNrSOXlIalT0O9d2LspJFsPqsw3ZLAdwSrphIW6+QzO3QYmcXsYOzZJsqjF1mrkLg12Ar0LQNENCjFdi64lDkzxAjn+kKB8WmvWj4emPcPBMAZAnBx+u7mygB+Ge272BnDsFVG30rgiA5CwHZLK5;20:3K/CMLij6eggmZy1xM0eT+7Sab1bCGxFOGHkazfwQW0yQY7mFKyqk3nIxRZerrPFHdlUwKt8HYxfpvci8pSvjP316EM4FbXdGXpKmGhwvgHUebDGB1WFro2qbwAuML7rwaXJWVJDaxLCn8YFSnMfes9ib9gK69zuRkmgCGEG+bA=
X-MS-Office365-Filtering-Correlation-Id: 05e33a66-4e6d-4843-03dc-08d59daf6d0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1046CEE2F342AEAC8D109AE6FBBF0@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(51234002)(199004)(189003)(36756003)(186003)(11346002)(446003)(476003)(2616005)(7736002)(5660300001)(26005)(10290500003)(478600001)(106356001)(68736007)(10090500001)(54906003)(3846002)(59450400001)(22452003)(6116002)(86612001)(110136005)(99286004)(86362001)(72206003)(305945005)(76176011)(102836004)(6506007)(486006)(316002)(3280700002)(3660700001)(81166006)(81156014)(8676002)(2906002)(14454004)(2900100001)(97736004)(6486002)(8936002)(1076002)(6512007)(6436002)(105586002)(25786009)(4326008)(2501003)(5250100002)(53936002)(66066001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: EMIi06mp9OFHIrm50Bt4snmNyrBXmijrUTZ9Z7pqa1p29UwP0aNC/uMuvm7QsT8iCFznDe7P/2zNuVJEMi6gT6Bsq0w7lLFzAiLgaDXWtjJPqXdp6SxrM04a6EjTy0WCgFsLjr50qhH73ycosReugYkPi8l6dO32vThy9ZDA4BASWUEOWDc/jdwo0jIZ8wWo1JowKOs72U7ThG7SN4lndll4zHeogslJZeUQErq5jX5bidtcRTfke8hiBBxRQUjCaCnv8AJa+QQRyCqrDMmqB76iBCui9vA2Ahis4ZzZ9VzZGO1Y60hR6w115BFQqqkm1dRMdTNjRvIKInAto2tTPSA6MzOIg/tbNoMMPoovRLIo9CYpy13+LcHKLLVKd5DueMIYzjT6ZjctdLW5+zq/L13gXScINrYmXHrrBuKAOs8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e33a66-4e6d-4843-03dc-08d59daf6d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:38.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sheng Yong <shengyong1@huawei.com>

[ Upstream commit a9d572c7550044d5b217b5287d99a2e6d34b97b0 ]

When io_bits is set, GCing encrypted block may hit the following hungtask.
Since io_bits requires aligned block address, f2fs_submit_page_write may
return -EAGAIN if new_blkaddr does not satisify io_bits alignment. As a
result, the encrypted page will never be writtenback.

This patch makes move_data_block aware the EAGAIN error and cancel the
writeback.

[  246.751371] INFO: task kworker/u4:4:797 blocked for more than 90 seconds=
.
[  246.752423]       Not tainted 4.15.0-rc4+ #11
[  246.754176] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.
[  246.755336] kworker/u4:4    D25448   797      2 0x80000000
[  246.755597] Workqueue: writeback wb_workfn (flush-7:0)
[  246.755616] Call Trace:
[  246.755695]  ? __schedule+0x322/0xa90
[  246.755761]  ? blk_init_request_from_bio+0x120/0x120
[  246.755773]  ? pci_mmcfg_check_reserved+0xb0/0xb0
[  246.755801]  ? __radix_tree_create+0x19e/0x200
[  246.755813]  ? delete_node+0x136/0x370
[  246.755838]  schedule+0x43/0xc0
[  246.755904]  io_schedule+0x17/0x40
[  246.755939]  wait_on_page_bit_common+0x17b/0x240
[  246.755950]  ? wake_page_function+0xa0/0xa0
[  246.755961]  ? add_to_page_cache_lru+0x160/0x160
[  246.755972]  ? page_cache_tree_insert+0x170/0x170
[  246.755983]  ? __lru_cache_add+0x96/0xb0
[  246.756086]  __filemap_fdatawait_range+0x14f/0x1c0
[  246.756097]  ? wait_on_page_bit_common+0x240/0x240
[  246.756120]  ? __wake_up_locked_key_bookmark+0x20/0x20
[  246.756167]  ? wait_on_all_pages_writeback+0xc9/0x100
[  246.756179]  ? __remove_ino_entry+0x120/0x120
[  246.756192]  ? wait_woken+0x100/0x100
[  246.756204]  filemap_fdatawait_range+0x9/0x20
[  246.756216]  write_checkpoint+0x18a1/0x1f00
[  246.756254]  ? blk_get_request+0x10/0x10
[  246.756265]  ? cpumask_next_and+0x43/0x60
[  246.756279]  ? f2fs_sync_inode_meta+0x160/0x160
[  246.756289]  ? remove_element.isra.4+0xa0/0xa0
[  246.756300]  ? __put_compound_page+0x40/0x40
[  246.756310]  ? f2fs_sync_fs+0xec/0x1c0
[  246.756320]  ? f2fs_sync_fs+0x120/0x1c0
[  246.756329]  f2fs_sync_fs+0x120/0x1c0
[  246.756357]  ? trace_event_raw_event_f2fs__page+0x260/0x260
[  246.756393]  ? ata_build_rw_tf+0x173/0x410
[  246.756397]  f2fs_balance_fs_bg+0x198/0x390
[  246.756405]  ? drop_inmem_page+0x230/0x230
[  246.756415]  ? ahci_qc_prep+0x1bb/0x2e0
[  246.756418]  ? ahci_qc_issue+0x1df/0x290
[  246.756422]  ? __accumulate_pelt_segments+0x42/0xd0
[  246.756426]  ? f2fs_write_node_pages+0xd1/0x380
[  246.756429]  f2fs_write_node_pages+0xd1/0x380
[  246.756437]  ? sync_node_pages+0x8f0/0x8f0
[  246.756440]  ? update_curr+0x53/0x220
[  246.756444]  ? __accumulate_pelt_segments+0xa2/0xd0
[  246.756448]  ? __update_load_avg_se.isra.39+0x349/0x360
[  246.756452]  ? do_writepages+0x2a/0xa0
[  246.756456]  do_writepages+0x2a/0xa0
[  246.756460]  __writeback_single_inode+0x70/0x490
[  246.756463]  ? check_preempt_wakeup+0x199/0x310
[  246.756467]  writeback_sb_inodes+0x2a2/0x660
[  246.756471]  ? is_empty_dir_inode+0x40/0x40
[  246.756474]  ? __writeback_single_inode+0x490/0x490
[  246.756477]  ? string+0xbf/0xf0
[  246.756480]  ? down_read_trylock+0x35/0x60
[  246.756484]  __writeback_inodes_wb+0x9f/0xf0
[  246.756488]  wb_writeback+0x41d/0x4b0
[  246.756492]  ? writeback_inodes_wb.constprop.55+0x150/0x150
[  246.756498]  ? set_worker_desc+0xf7/0x130
[  246.756502]  ? current_is_workqueue_rescuer+0x60/0x60
[  246.756511]  ? _find_next_bit+0x2c/0xa0
[  246.756514]  ? wb_workfn+0x400/0x5d0
[  246.756518]  wb_workfn+0x400/0x5d0
[  246.756521]  ? finish_task_switch+0xdf/0x2a0
[  246.756525]  ? inode_wait_for_writeback+0x30/0x30
[  246.756529]  process_one_work+0x3a7/0x6f0
[  246.756533]  worker_thread+0x82/0x750
[  246.756537]  kthread+0x16f/0x1c0
[  246.756541]  ? trace_event_raw_event_workqueue_work+0x110/0x110
[  246.756544]  ? kthread_create_worker_on_cpu+0xb0/0xb0
[  246.756548]  ret_from_fork+0x1f/0x30

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/gc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d844dcb80570..bab49a270401 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -686,7 +686,12 @@ static void move_data_block(struct inode *inode, block=
_t bidx,
 	fio.op =3D REQ_OP_WRITE;
 	fio.op_flags =3D REQ_SYNC;
 	fio.new_blkaddr =3D newaddr;
-	f2fs_submit_page_write(&fio);
+	err =3D f2fs_submit_page_write(&fio);
+	if (err) {
+		if (PageWriteback(fio.encrypted_page))
+			end_page_writeback(fio.encrypted_page);
+		goto put_page_out;
+	}
=20
 	f2fs_update_iostat(fio.sbi, FS_GC_DATA_IO, F2FS_BLKSIZE);
=20
--=20
2.15.1

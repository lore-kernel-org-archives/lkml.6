Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652897-2-11182559315341315355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652897; b=EGnxozxe9KX7r3b6Ze6nxCmPi62zCv75Mou9iT0/R4mJe46Twe
    ylmP+SHZW6nIJaj0mEXBRHgJQrE2ZiXLNsn8elXTPen4NYNSoyiaTGFDfGcfp6P3
    hwKgAPF757sfuR96MTKH7i91a48W1hHmQyiOlZde6bwYTr46kxL1Epw4PE8fi5ZH
    tHWRnPDMPLzuSwTnljjNdPFWgw3+A3HAe1a8nVF9nF1Gk0uehXo3xdPw6U7tItDb
    9Ks7DxMRLOmzka7bZldIhs44J3t1jfSPvonc6cwT3bjXBC9WSzs395S5FNyoLaJZ
    fdWdMCaC8Ue2Am6Ow0nP/2udCF2PD4pADRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652897; bh=lpWaz3Tb+H8k1HDCMWnzAVjDfKQmGm
    hszScIzsak+0U=; b=GEA3Rix/2vA8uutOHevgtxHO1YFAQTVlOdEL6pzxuZ3wUy
    y0kfAxxjM/TGl6mvpG8/7kyA1BAPy2HBRNHJTjJePTXUzHX1ZhiBXpUe1euh7no7
    fYlw9hq0JyrPOlAEHKN3BjOQKBFQ1jSav0x+qovbU8/pogO5AGMSW+u8po3p00L4
    MLZ51XDx2pgKyqT9SgJIdBnBfXeWqcjt8HkRtP9B3CnZxGMDifZWF5YCUzTqVhs1
    0FKM6S7Ar/rG9KKYqW1Q3qev8F/QTygLGUPjGN8acNTYmlVNdAB+nsfIlXbsq91j
    CIb/vz8sjCvSOqJgn677ngYAOZM0rdP8CBf1mDjQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFKii+kHeg0sSWKujiOBhAj54IX4wx3mkPAPOBE7jXPFlHsqGUxK1mLqvplmTol10viy3VrIso5g+qL9Vcz2+FoutRY6nzdcB9l8XI1Egk6ZBRf5sFsS
    VtJQ88tJ3sOPROslXuo1fJnm86Iz+P7uglXBiVNb+uU+/GIG3gde/aXiDcnAPmHb5k4hXyz3y5mVcEpd6uXkJ93K5P76FQXWVreR2RcZAlTD97gJ3F8KXr+C
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=RpywtofDEX2MDo3HS_AA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeDYKlc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:41:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752350AbeDYKl2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sheng Yong <shengyong1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 070/183] f2fs: avoid hungtask when GC encrypted block if io_bits is set
Date: Wed, 25 Apr 2018 12:34:50 +0200
Message-Id: <20180425103245.334752370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sheng Yong <shengyong1@huawei.com>


[ Upstream commit a9d572c7550044d5b217b5287d99a2e6d34b97b0 ]

When io_bits is set, GCing encrypted block may hit the following hungtask.
Since io_bits requires aligned block address, f2fs_submit_page_write may
return -EAGAIN if new_blkaddr does not satisify io_bits alignment. As a
result, the encrypted page will never be writtenback.

This patch makes move_data_block aware the EAGAIN error and cancel the
writeback.

[  246.751371] INFO: task kworker/u4:4:797 blocked for more than 90 seconds.
[  246.752423]       Not tainted 4.15.0-rc4+ #11
[  246.754176] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/gc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -696,7 +696,12 @@ static void move_data_block(struct inode
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
-	f2fs_submit_page_write(&fio);
+	err = f2fs_submit_page_write(&fio);
+	if (err) {
+		if (PageWriteback(fio.encrypted_page))
+			end_page_writeback(fio.encrypted_page);
+		goto put_page_out;
+	}
 
 	f2fs_update_iostat(fio.sbi, FS_GC_DATA_IO, F2FS_BLKSIZE);
 

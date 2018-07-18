Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B79ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00F3206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00F3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeGRMab convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:30:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:7973 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729185AbeGRMab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 04:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,370,1526367600"; 
   d="scan'208";a="55917652"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2018 04:52:48 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 18 Jul 2018 04:52:48 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 18 Jul 2018 04:52:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Wed, 18 Jul 2018 19:52:46 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "Zhang, Jun" <jun.zhang@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: [PATCH] ALSA: core: fix unsigned int pages overflow when comapred
Thread-Topic: [PATCH] ALSA: core: fix unsigned int pages overflow when
 comapred
Thread-Index: AdQejWjk55iqWVRYS2+apgz1v2Viqg==
Date:   Wed, 18 Jul 2018 11:52:45 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52980C51@SHSMSX104.ccr.corp.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTFhZGVkODMtZTFmMi00YzYwLTk1YjUtNjhjNDI3NmY2N2YxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieFR3NVFsa1haWDIrV1V6emQ2Qnp6bWt1NlwvUjA2QktVYjB6R1BsVENNMWlSeUsxYWlnc1pEMEpLNE9NUXNvWE8ifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we see the below kernel panic on stress suspend resume test in
snd_malloc_sgbuf_pages(), snd_dma_alloc_pages_fallback() alloc
chunk maybe larger than the left pages due to the pages alignment,
which will cause the pages overflow.

while (pages > 0) {
	...
	pages -= chunk;
}

the patch is change the pages from unsigned int to int to fix the issue.

BUG: unable to handle kernel paging request at ffff88000deb4000
IP: [<ffffffff81404fa9>] memset_erms+0x9/0x10
Call Trace:
 [<ffffffff818f222f>] snd_dma_alloc_pages+0xff/0x210
 [<ffffffff818f23af>] snd_dma_alloc_pages_fallback+0x6f/0x90
 [<ffffffff818f2b85>] snd_malloc_sgbuf_pages+0x145/0x370
 [<ffffffff818f229e>] snd_dma_alloc_pages+0x16e/0x210
 [<ffffffffc011930d>] hdac_ext_dma_alloc_pages+0x1d/0x40 [snd_hda_ext_core]
 [<ffffffffc010729a>] snd_hdac_dsp_prepare+0xca/0x1c0 [snd_hda_core]
 [<ffffffffc01880f9>] skl_dsp_prepare+0x99/0xf0 [snd_soc_skl]
 [<ffffffffc0162a7e>] bxt_load_base_firmware+0x9e/0x5c0 [snd_soc_skl_ipc]
 [<ffffffffc01630ec>] bxt_set_dsp_D0+0x14c/0x300 [snd_soc_skl_ipc]
 [<ffffffffc015f9c3>] skl_dsp_get_core+0x43/0xd0 [snd_soc_skl_ipc]
 [<ffffffffc015fa60>] skl_dsp_wake+0x10/0x20 [snd_soc_skl_ipc]
 [<ffffffffc0188e3e>] skl_resume_dsp+0x7e/0x140 [snd_soc_skl]
 [<ffffffffc0183c4a>] skl_resume+0xda/0x170 [snd_soc_skl]
 [<ffffffff81452726>] pci_pm_resume+0x76/0xe0
 [<ffffffff816616da>] dpm_run_callback+0x5a/0x180
 [<ffffffff81661e3c>] device_resume+0xdc/0x2c0
 [<ffffffff81663818>] dpm_resume+0x118/0x310
 [<ffffffff81663e11>] dpm_resume_end+0x11/0x20
 [<ffffffff810f8bcc>] suspend_devices_and_enter+0x11c/0x2b0
 [<ffffffff810f90bd>] pm_suspend+0x35d/0x3d0
 [<ffffffff810f78a6>] state_store+0x66/0x90
 [<ffffffff813f80e2>] kobj_attr_store+0x12/0x20
 [<ffffffff812a37bc>] sysfs_kf_write+0x3c/0x50
 [<ffffffff812a2cbd>] kernfs_fop_write+0x11d/0x1a0
 [<ffffffff8121dfaa>] __vfs_write+0x3a/0x150
 [<ffffffff8121f2b1>] vfs_write+0xb1/0x1a0
 [<ffffffff81220898>] SyS_write+0x58/0xc0
 [<ffffffff81001fca>] do_syscall_64+0x6a/0xe0
 [<ffffffff81b06560>] entry_SYSCALL_64_after_swapgs+0x5d/0xd7

Signed-off-by: he, bo <bo.he@intel.com>
Signed-off-by: zhang jun <jun.zhang@intel.com>
---
 sound/core/sgbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/sgbuf.c b/sound/core/sgbuf.c
index 84fffab..33449ee 100644
--- a/sound/core/sgbuf.c
+++ b/sound/core/sgbuf.c
@@ -68,7 +68,8 @@ void *snd_malloc_sgbuf_pages(struct device *device,
 			     size_t *res_size)
 {
 	struct snd_sg_buf *sgbuf;
-	unsigned int i, pages, chunk, maxpages;
+	unsigned int i, chunk, maxpages;
+	int pages;
 	struct snd_dma_buffer tmpb;
 	struct snd_sg_page *table;
 	struct page **pgtable;
-- 
2.7.4


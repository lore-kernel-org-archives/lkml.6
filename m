Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F0BC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78EB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0AquN5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78EB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeIKCNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:13:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50622 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeIKCNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:13:23 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so31555051ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACeui2OlhHqYNJ9ldHYOq44pvSJtntw8ZsoU8FJw8yQ=;
        b=b0AquN5ZMqf5JquNkLQY/nwfpB36qBIzCmsyhNg5DsJ3PlroJUwRtxIdPy0pMtOWxs
         EAboTcNLOXRwhYEeP1x11hXsl1Uw1x/T33Y6TvuaTFNQk9qH/MPl5IPLb0Y0jiZB44qa
         /YRh9rufvvQgy1yQRV2V+W2sYX/4roY0lDVT4AMYErrNBBGtY9hzH/zOrj/Ti0q6cuyC
         7K/KRJYDd1+Q9sujEmUPWGqFK2qeA99J7dXMtLWqDm5RRKUx24R53d4ZZp50LMiKOXQ+
         hHsrUE0/e3xyHFoln+8G2BC5U7l8ULUiPanTfHHmpo414JhFvy8M7pqaYNPGbiOTmx5a
         8JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACeui2OlhHqYNJ9ldHYOq44pvSJtntw8ZsoU8FJw8yQ=;
        b=VOk/oUI2FblQgdsSTQxnwngmedl91boTlrheOmQBgTcb1tXycz5r+Ea2eVvvEr6IKL
         y0004EEMF4fGv2WZI1xqjA1z1QDTzekvIMyV6nTK8Pj+JBhDlKHKuCDFRjQ5AJN6cSXa
         SRsJnCd9bRsKTp2ap4CIHTfNSTzR/SeEARUsenoApjjARxzm4iTnOdkSHXPpf2OcWUjR
         XPt2UWCMMbNZLGwgi4kPXA6hgyb7hualrZGwIzfeOq6y1nWqYxQto/LcpUwspdVahZve
         t1j/VOH6kGWRZGVJ6ZK0ly7KPTjYDdtGzNcdhWCPjaQbakztiJ7UHb227HGYhNAIqcTN
         9DvQ==
X-Gm-Message-State: APzg51D/fHqCx34qLmpiPQ74jY5brFP5bFtiFZ+J/BybAsy4Jm4O7sfj
        jnAfrokCWU48FKWpuzlZr3cgyA==
X-Google-Smtp-Source: ANB0VdZ7CBQv83uCEnuVRlZ1JJY+o+1KsNAFOm8jIL92bLJZgZgdjXya95bqNkUMy+IaMb188iSlgQ==
X-Received: by 2002:a24:24c2:: with SMTP id f185-v6mr19418497ita.18.1536614245225;
        Mon, 10 Sep 2018 14:17:25 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id r126-v6sm7919979iod.7.2018.09.10.14.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:17:24 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
Date:   Mon, 10 Sep 2018 15:17:18 -0600
Message-Id: <20180910211718.200802-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.

The patch doesn't fix accessing memory with null pointer in
skl_interrupt().

There are two problems: 1) skl_init_chip() is called twice, before
and after dma buffer is allocate. The first call sets bus->chip_init
which prevents the second from initializing bus->corb.buf and
rirb.buf from bus->rb.area. 2) snd_hdac_bus_init_chip() enables
interrupt before snd_hdac_bus_init_cmd_io() initializing dma buffers.
There is a small window which skl_interrupt() can be called if irq
has been acquired. If so, it crashes when using null dma buffer
pointers.

Will fix the problems in the following patches. Also attaching the
crash for future reference.

[   16.949148] general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
[   16.950829] gsmi: Log Shutdown Reason 0x03
[   16.950830] Modules linked in: uvcvideo(+) videobuf2_vmalloc snd_soc_skl(+) videobuf2_memops videobuf2_v4l2 videobuf2_core snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_acpi snd_hda_ext_core snd_hda_core snd_soc_max98357a acpi_als snd_soc_da7219 lzo lzo_compress zram snd_seq_dummy snd_seq snd_seq_device bridge stp llc ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_mark fuse cfg80211 iio_trig_sysfs cros_ec_sensors cros_ec_sensors_ring cros_ec_sensors_core industrialio_triggered_buffer kfifo_buf industrialio smsc95xx usbnet mii joydev
[   16.950874] CPU: 0 PID: 1083 Comm: chrome Not tainted 4.14.64 #14
[   16.950875] Hardware name: Google Yorp/Yorp, BIOS Google_Yorp.10985.0.2018_08_20_1648 08/17/2018
[   16.950878] task: ffff88015b1c2b80 task.stack: ffff880155f30000
[   16.950887] RIP: 0010:snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core]
[   16.950889] RSP: 0000:ffff88015c807c08 EFLAGS: 00010003
[   16.950891] RAX: 0000000000000101 RBX: 000000000000080c RCX: 1ffff10026822185
[   16.950893] RDX: dffffc0000000000 RSI: ffff88015b1c2b80 RDI: ffffc90000514058
[   16.950894] RBP: ffff88015c807c68 R08: 0000000000000000 R09: 0000000000000000
[   16.950895] R10: 0000000000000000 R11: ffffffffc043074f R12: 0000000000000800
[   16.950897] R13: 0000000000000001 R14: 0000000000000002 R15: 1ffff10026822119
[   16.950899] FS:  00007d85924cc740(0000) GS:ffff88015c800000(0000) knlGS:0000000000000000
[   16.950900] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.950902] CR2: 000058a54df16038 CR3: 00000001551c0000 CR4: 00000000003406f0
[   16.950903] Call Trace:
[   16.950906]  <IRQ>
[   16.950918]  skl_interrupt+0x19e/0x2d6 [snd_soc_skl]
[   16.950926]  ? dma_supported+0xb5/0xb5 [snd_soc_skl]
[   16.950933]  __handle_irq_event_percpu+0x27a/0x6c8
[   16.950937]  ? __irq_wake_thread+0x1d1/0x1d1
[   16.950942]  ? __do_softirq+0x57a/0x69e
[   16.950944]  handle_irq_event_percpu+0x95/0x1ba
[   16.950948]  ? _raw_spin_unlock+0x65/0xdc
[   16.950951]  ? __handle_irq_event_percpu+0x6c8/0x6c8
[   16.950953]  ? _raw_spin_unlock+0x65/0xdc
[   16.950957]  ? time_cpufreq_notifier+0x483/0x483
[   16.950959]  handle_irq_event+0x89/0x123
[   16.950962]  handle_fasteoi_irq+0x16f/0x425
[   16.950965]  handle_irq+0x1fe/0x28e
[   16.950969]  do_IRQ+0x6e/0x12e
[   16.950972]  common_interrupt+0x7a/0x7a
[   16.950974]  </IRQ>
[   16.950976] RIP: 0033:0x58097f61a5c0
[   16.950978] RSP: 002b:00007ffe95c971a8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffffbc
[   16.950980] RAX: 000058097f61a5c0 RBX: 00000e4ac5220560 RCX: 0000000000004e10
[   16.950982] RDX: 000058098563df20 RSI: 00007ffe95c97250 RDI: 00000e4ac5220500
[   16.950983] RBP: 00007ffe95c97410 R08: 0000000000000000 R09: 00007ffe95c97250
[   16.950984] R10: 0000000000000000 R11: 0000000000000000 R12: 00000e4ac5220560
[   16.950986] R13: 00000e4ac5220560 R14: 00000e4ac47c9650 R15: 0000580987646350
[   16.950988] Code: 74 12 48 89 df e8 eb 2d 8e cd 48 ba 00 00 00 00 00 fc ff df 4c 8b 23 44 89 f0 83 c8 01 0f b7 c0 49 8d 1c 84 48 89 d8 48 c1 e8 03 <8a> 04 10 84 c0 0f 85 da 01 00 00 44 8b 3b 41 0f b7 c6 49 8d 1c
[   16.951031] RIP: snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core] RSP: ffff88015c807c08
[   16.951036] ---[ end trace 58bf9ece1775bc92 ]---
[   16.956871] Kernel panic - not syncing: Fatal exception in interrupt
[   16.956888] Kernel Offset: 0xc800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/intel/skylake/skl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index cf09721ca13e..dce649485649 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -838,7 +838,11 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
+	if (skl_acquire_irq(bus, 0) < 0)
+		return -EBUSY;
+
 	pci_set_master(pci);
+	synchronize_irq(bus->irq);
 
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
@@ -871,12 +875,6 @@ static int skl_first_init(struct hdac_bus *bus)
 	if (err < 0)
 		return err;
 
-	err = skl_acquire_irq(bus, 0);
-	if (err < 0)
-		return err;
-
-	synchronize_irq(bus->irq);
-
 	/* initialize chip */
 	skl_init_pci(skl);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog


Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558C0C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4B2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4M4PKwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4B2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeIMAuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:50:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42731 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeIMAuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:50:15 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so1199622ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fu1U9vAXs3jHw5oMG8XVHbKZwmRZK++gfhN6XjHohGk=;
        b=s4M4PKwAWJMsC3K9OcfxRRcJ/PhrglytVyxVW9/vOPn6n+KWAFSdxvyXVwX7j11MA+
         AjeJSqsjRYKZJbj3HTjxHM0UpM+xTISryYufQDNSexWf61Wq6bUTRzlaazIhLnXTL276
         YxpLkcUIN/fSvhv8W/ikXoe2YPudjYtn/eHXOGX64xso49MNToI06xsKGRwRamBgBQDj
         v16umUubhCkO4QPYq6kBl18aurSdJg/zzb3k0B0iRKviScXkWe7yFhJVJG3gaGdOVeX+
         cxBd6fFgfbWQ4cCuuKWLkteKKplYM7Ii7bi+m8PF0QEttj9BkmSRfpmqUzqbwYHRLTAG
         AFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fu1U9vAXs3jHw5oMG8XVHbKZwmRZK++gfhN6XjHohGk=;
        b=J7u5u70SphYNxvulJmgZ9ZDnjgFr3aCyPcuSjQNQZAnTOtSTP1Ez2fhdb7wPvNOBQA
         MYA8qqx9Gpaorzfuj02RWFi/vBAOpKXa3Ej+erkkrD6yby6ac/LizqbyUaqfrWNi3IMt
         UDbzB1roqaX9fHwW9puKUYDrj6sW9szMv8O4L2y7HxPnQV1mdaKPcJH9rlAJjpgoZSyx
         /miUutgukv00sQEXncsKwLPq2cPxAKnH3vIYtcf9AnMMgJelsGvhdiIWDDLSdrFtJF1K
         AWfxwBtnAd1UBTgT6JqkBfZpWMJuDkSNce+6GvzHfPT58MpEA5yYs7/a1KkcFYDIpCZ2
         zsWQ==
X-Gm-Message-State: APzg51BHH4+Ji0JA2RTGtQY9eZf5lXwNoppnfQzTPWEcDxyZ0qWeXhbI
        9J9+sKKhk21U9sjXBSNWCrhAwg==
X-Google-Smtp-Source: ANB0VdZb7gMdtiHBv/Drl0JaWJWycx1xDySZT7MCYjgK95Vs4wod0nqdURsCl2TFln685V3YOmG7xQ==
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr3259542ioa.168.1536781451568;
        Wed, 12 Sep 2018 12:44:11 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id y18-v6sm926341ita.29.2018.09.12.12.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 12:44:10 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ASoC: Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
Date:   Wed, 12 Sep 2018 13:43:43 -0600
Message-Id: <20180912194343.200443-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180911211246.31914-1-yuzhao@google.com>
References: <20180911211246.31914-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.

The patch claims it fixes accessing memory with null pointer on
skl_interrupt() and snd_hdac_bus_update_rirb() path, but in fact it
has no effect.

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
<snipped>
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
<snipped>
[   16.951031] RIP: snd_hdac_bus_update_rirb+0x19b/0x4cf [snd_hda_core] RSP: ffff88015c807c08
[   16.951036] ---[ end trace 58bf9ece1775bc92 ]---

Fixes: 2eeeb4f4733b ("ASoC: Intel: Skylake: Acquire irq after RIRB allocation")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/intel/skylake/skl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e7fd14daeb4f..d174cbe35f7a 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -912,7 +912,11 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	snd_hdac_bus_parse_capabilities(bus);
 
+	if (skl_acquire_irq(bus, 0) < 0)
+		return -EBUSY;
+
 	pci_set_master(pci);
+	synchronize_irq(bus->irq);
 
 	gcap = snd_hdac_chip_readw(bus, GCAP);
 	dev_dbg(bus->dev, "chipset global capabilities = 0x%x\n", gcap);
@@ -945,12 +949,6 @@ static int skl_first_init(struct hdac_bus *bus)
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


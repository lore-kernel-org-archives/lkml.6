Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95434C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332D320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1zdUxh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332D320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIKCUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:20:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43763 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeIKCUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:20:09 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so1875934ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v044/G01pq2GCJi+4YU6CUi8a2Ev+vGFyH/bVQL/jO8=;
        b=d1zdUxh32q4R72V8H+i0jrKE2xCSbfQZ4sfCTiq2fIGJLwR76qrk2z7xnyJsLZT4ql
         nEA/FRWKMRPlV5rudtGSeD+VJMZx8WWclt6foy/xQ0VKMq8uUCPsqUHRmtrz5gopBt5t
         cwUCPlh+l8+L1S30aS4Gisry5PoholSQe6U0GkUe+5WgRXxJCXzlUgYjQJkiS5opw9VN
         YNK80Z1euiC10A8naEHL69fTzEyyqGH4gBjI/Dqb95ETecmRhOmK/FobT2SfsTncFTNB
         N1Qvd6ZeuxqIpHoAXXgt1hxZleXQCmZdz3UigL80k8wn2S3qIFu4g77h7s1XepTZ5rmb
         Dk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v044/G01pq2GCJi+4YU6CUi8a2Ev+vGFyH/bVQL/jO8=;
        b=bzdXhUL7Xby41moF4rgO3ufsc+c2i7HQCnvGKjJN0jTb5lbxzkAtimmFsjUxYx/uoB
         G172Lro135HAhLrAUGrowBLKa7pLSl8BaJyPct1zkrVdphYanKqfiaeKMClBDsKrqMdI
         N1+CbnejESYWw0ECBWJZsGWf43nXwkHn9Z8lm3eAB6NYTHYrySriSSY8eLGXkixs2ULN
         3n8A7vOHNlz1zSRAxssJCDFLciOUtMMjxxJtKK7reUgfFPzVUNtUJpq2asw1keYAfeHr
         kfD3n2QFmepCD8TICGF5kdhUoULktMt9EGOgq8T245D5eYH/h62ZEqRe85fPoTvQ5aa3
         XvVA==
X-Gm-Message-State: APzg51ABN+QGbnClvA07vblLbib4jSwkSL8TZf4RrWM5+QkZ9orqiKL/
        50m6oqdXvjzrRo0O7k8XO2/xfw==
X-Google-Smtp-Source: ANB0VdabrNoYvY7R8pyCpTvVmwV2yQJbe8vtIHstyC95a/ZZsbe/Cm/Dcdz0awyX91WA1ErhJnR9WQ==
X-Received: by 2002:a6b:b797:: with SMTP id h145-v6mr18229447iof.274.1536614649848;
        Mon, 10 Sep 2018 14:24:09 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id n142-v6sm3578146itb.3.2018.09.10.14.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 14:24:08 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Yu Zhao <yuzhao@google.com>, Vinod Koul <vkoul@kernel.org>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sound: don't call skl_init_chip() to reset intel skl soc
Date:   Mon, 10 Sep 2018 15:23:58 -0600
Message-Id: <20180910212358.203050-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180910212150.202655-1-yuzhao@google.com>
References: <20180910212150.202655-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internally, skl_init_chip() calls snd_hdac_bus_init_chip() which
1) sets bus->chip_init to prevent multiple entrances before device
is stopped; 2) enables interrupt.

We shouldn't use it for the purpose of resetting device only because
1) when we really want to initialize device, we won't be able to do
so; 2) we are ready to handle interrupt yet, and kernel crashes when
interrupt comes in.

Rename azx_reset() to snd_hdac_bus_reset_link(), and use it to reset
device properly.

Fixes: 60767abcea3d ("ASoC: Intel: Skylake: Reset the controller in probe")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/sound/hdaudio.h       | 1 +
 sound/hda/hdac_controller.c   | 7 ++++---
 sound/soc/intel/skylake/skl.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 6f1e1f3b3063..cd1773d0e08f 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -412,6 +412,7 @@ void snd_hdac_bus_init_cmd_io(struct hdac_bus *bus);
 void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus);
 void snd_hdac_bus_enter_link_reset(struct hdac_bus *bus);
 void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus);
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset);
 
 void snd_hdac_bus_update_rirb(struct hdac_bus *bus);
 int snd_hdac_bus_handle_stream_irq(struct hdac_bus *bus, unsigned int status,
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 11057d9f84ec..74244d8e2909 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -385,7 +385,7 @@ void snd_hdac_bus_exit_link_reset(struct hdac_bus *bus)
 EXPORT_SYMBOL_GPL(snd_hdac_bus_exit_link_reset);
 
 /* reset codec link */
-static int azx_reset(struct hdac_bus *bus, bool full_reset)
+int snd_hdac_bus_reset_link(struct hdac_bus *bus, bool full_reset)
 {
 	if (!full_reset)
 		goto skip_reset;
@@ -410,7 +410,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_reset)
  skip_reset:
 	/* check to see if controller is ready */
 	if (!snd_hdac_chip_readb(bus, GCTL)) {
-		dev_dbg(bus->dev, "azx_reset: controller not ready!\n");
+		dev_dbg(bus->dev, "controller not ready!\n");
 		return -EBUSY;
 	}
 
@@ -425,6 +425,7 @@ static int azx_reset(struct hdac_bus *bus, bool full_reset)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_hdac_bus_reset_link);
 
 /* enable interrupts */
 static void azx_int_enable(struct hdac_bus *bus)
@@ -479,7 +480,7 @@ bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset)
 		return false;
 
 	/* reset controller */
-	azx_reset(bus, full_reset);
+	snd_hdac_bus_reset_link(bus, full_reset);
 
 	/* clear interrupts */
 	azx_int_clear(bus);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index dce649485649..1d17be0f78a0 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -834,7 +834,7 @@ static int skl_first_init(struct hdac_bus *bus)
 		return -ENXIO;
 	}
 
-	skl_init_chip(bus, true);
+	snd_hdac_bus_reset_link(bus, true);
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog


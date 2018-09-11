Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A0C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D973206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5FxajAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D973206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeILCQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:16:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38032 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeILCQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:16:31 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so219294ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/TSW8mXsIl5QhaBOCGXiLvrL+LIXbEjyZKvpePkUSY=;
        b=d5FxajAZ3BarKnr3Fc3r9Si0bO80kXAV1zUKZ4ipPEJejtM6ik/nrFjKrFk3+BZdSr
         DeShvHKh7RPyFn67RoD7ogkFTqUplwz3fdVPqZSTIHUm36LDSuNMaoxHo08lGcAN2zmP
         /zRL7vXB4bPEf24cz1HBmdIoBixF7BKOIgBNwZV9ifZAZOuSlZLgwCaWidW7MFjKxgK/
         vSPo+XJG7YsB3PaOpurMj+1sQVbxre7Ym3ASs6qfJxevnmWD0UVAvwe9vqbK5UkkVsRY
         7bqTHw0vfo3y1bhVIY1l8DcO7lJwQ+aU7nqAe1WoJpBsmBe6+MOZ8de8+jPo60P5zlPB
         yy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/TSW8mXsIl5QhaBOCGXiLvrL+LIXbEjyZKvpePkUSY=;
        b=gk1v8MLtWmPjYp0+2rWZjRB60rRu8SHRvdiDBIUbBkdyJ7EnjEQYvQvmqn5teIibqL
         tbcvYmCu0J1XDA1x1d5L1Zv7607kZs2hey7BMKM7byIfftmcQz/V0A0JNcIlhdROR7L2
         /gJq1CnMDtKVOheG16T9wzBBq47PU5op5fQMY2UAEbtbSlGlhlaVqhfs2DDLml4ynLqh
         bPIshU4zMPbxzW4W4EOVHVxbUmVDIKVV1F8V9aAVvspqaIanrWoruGxETNk+seAnc3PF
         w4Yzagy0Y9PA08RD8E7jDreJsXL3MAZGX2XveHpGH59OQnjb5XDhaU0R3v3pKe8LXjCQ
         wIyA==
X-Gm-Message-State: APzg51CbZ0qJRGTtUgFoDD0aBNxwaeOrTo29PXRMG/AFUTL5wlZcyvSj
        wmIQeSZ4GBBrqR8zCTI0natVhw==
X-Google-Smtp-Source: ANB0VdYbsPIB2X0eMwSwi9vCqnMrmSHYnT7dsf5btliHHkKsOLm4iN876VwH0vUg5qm7Egu9q0iYdw==
X-Received: by 2002:a02:298b:: with SMTP id p133-v6mr3166803jap.17.1536700521461;
        Tue, 11 Sep 2018 14:15:21 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id g10-v6sm6831226iob.88.2018.09.11.14.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:15:20 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
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
Subject: [PATCH v2 3/3] sound: don't call skl_init_chip() to reset intel skl soc
Date:   Tue, 11 Sep 2018 15:15:16 -0600
Message-Id: <20180911211516.32370-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180911211404.32178-1-yuzhao@google.com>
References: <20180911211404.32178-1-yuzhao@google.com>
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
Reviewed-by: Takashi Iwai <tiwai@suse.de>
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
index d174cbe35f7a..29225623b4b4 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -908,7 +908,7 @@ static int skl_first_init(struct hdac_bus *bus)
 		return -ENXIO;
 	}
 
-	skl_init_chip(bus, true);
+	snd_hdac_bus_reset_link(bus, true);
 
 	snd_hdac_bus_parse_capabilities(bus);
 
-- 
2.19.0.rc2.392.g5ba43deb5a-goog


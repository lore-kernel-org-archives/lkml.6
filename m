Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F4C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A7E2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URu1sqsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A7E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeIMAva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:51:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36366 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbeIMAv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:51:29 -0400
Received: by mail-io1-f67.google.com with SMTP id q5-v6so1235568iop.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/TSW8mXsIl5QhaBOCGXiLvrL+LIXbEjyZKvpePkUSY=;
        b=URu1sqsXnHjHy0qJw+Dvz5ZYdKZ3q6mN6g4NIl5ffl1xZXmIoGcdS97Fu8KKaEDxbb
         IsWJWpZi8mZ+0VIZ4ANfx8gebcojd96aUD1Z0LLvOFq/6ZBJ2ymTXIHdXIsl8KRA/2Yg
         bSjDPA/E2xRAamy0ri1bf9jIyBNb/YTvMu//HpAJKx5mZQuCWNWIGmfd9W3Vu4+HjgaU
         qZgpRqUG4I9OTXd7hAN1AgymdfAnpuesqxKssYNUnX1m6vpu3+aaqMoD9Erg5JqsTIJc
         uFdgZeJz3UfQf4QM3MwSbZMQrH6phhXZSm8kolegDexAUnzwacV1gcAYxoGdYepQmNqg
         nbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/TSW8mXsIl5QhaBOCGXiLvrL+LIXbEjyZKvpePkUSY=;
        b=avCChjYxtjs8y9QlpQ6Xc/zCe0I/pO4sHudqTydtGZuqlYEUJKXz9QZz36/ldRucfY
         CiPGIN73JZocA1wEK8EWwVtH7dWaDyTOre4x2TC3+o1kDG1/CydT6RTNOovZ71qzbPIz
         hlwE56ReFrdCxyMfJtsTNIEWkzIB0fVbt1m/8mPIc38J5FO9z+qImhHRchGYeeDjEGmT
         azaX6uWiZTBaRClohg0hS/fIyb4EtWKgk1/VNgHpxTXDH9LEC0XELoI+zHVoyMhWgVK0
         QKAQLeIzbQUuMRYCpnDkNj7+apDkgSyTRroRTXczlN7EPT/tT4ZtSH5io7klKErJ6UWU
         FQ1Q==
X-Gm-Message-State: APzg51CukoKzcycoLilNrwGbbrlb/1jdcqKFCF8gYKMAGiSfWqFmvgYp
        /GmzWRNO94RcCA869/UD6RB2cA==
X-Google-Smtp-Source: ANB0VdZU8CR3xv82WotKjMyFu8OyzqsSmx6z3PbERgiqMBS5K1SLhZYnxo4Ylsdq+zi0Zg9wprr8Tw==
X-Received: by 2002:a6b:5f12:: with SMTP id t18-v6mr3430255iob.62.1536781526224;
        Wed, 12 Sep 2018 12:45:26 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id p125-v6sm786266ite.17.2018.09.12.12.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 12:45:24 -0700 (PDT)
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
Subject: [PATCH v3 3/3] ASoC: don't call skl_init_chip() to reset intel skl soc
Date:   Wed, 12 Sep 2018 13:45:20 -0600
Message-Id: <20180912194520.200700-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
In-Reply-To: <20180912194441.200564-1-yuzhao@google.com>
References: <20180912194441.200564-1-yuzhao@google.com>
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


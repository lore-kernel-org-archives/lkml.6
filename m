Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC61220865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3T2ZUwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC61220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeIKNYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:24:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43953 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeIKNYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:24:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so19644790lfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw2PXv8XW2/jt3VCOUj66tZpQdzgkBwNMASMb2v4joM=;
        b=X3T2ZUwI+Tx6KNInQC46ioaCZVZBoR3oYchaiTBhM3MisuLWEgeaE4NVY/UJhF1Vlw
         dM3zEn86dz37hau5wLZm2AWoyoU+Hb7bAxUx7hZl8hVNL2zSNCWiMsGxPs/Cm3lcswUA
         Jb0KUT0S/w8keNPzQzMCleSIZA6G+m4THKDLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw2PXv8XW2/jt3VCOUj66tZpQdzgkBwNMASMb2v4joM=;
        b=ahl3edPSbC9LHGlsx1D8AwGE60urKiPfzh5mcTCaQg5xPi+DTWV7GaEWfuJaILcqGS
         hYQxbyuOZCeYzEHqoIgZsbjVDH7OALWa5dUAB1C4aWiT/IVG+ogiJ21C8hRVtXW8OxX5
         6IV6k0H7mRwoj5YxtWUQet9PWg5jqgNgcnf+HNhLCs0PqyzITvRB0L+x+QY0G7cPWa8M
         uQAgfNkXxeYyxHVetxkWexZ2c+0t4mTd31G+a+pe3XkOnwyXWB5OADr6A71xYg3mOaxU
         OWakcnn94jzk5EVvuqyvFqk1qKrT09M7TpiKRh/r2EQ7PQDTryRSr2yzwZ2On8pknVaJ
         Pjsw==
X-Gm-Message-State: APzg51DQoOa5bSxNAbSe5cC+0lUHruVdVscT3xSr3Q/flWuDHJX4bxHj
        JjXsqr1Tk1+u23V7uoRKYZcS5Q==
X-Google-Smtp-Source: ANB0VdZ/E/lz3iOH2LtdoNBk8+GDUHWQpGLSND/ESB5kP0zRXLOnsySQS+FJ5zJa+7YFzSLqb3BlsQ==
X-Received: by 2002:ac2:50c7:: with SMTP id h7-v6mr14412231lfm.47.1536654366009;
        Tue, 11 Sep 2018 01:26:06 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id m22-v6sm3116994lfc.44.2018.09.11.01.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:26:05 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ALSA: hda: fix unused variable warning
Date:   Tue, 11 Sep 2018 10:25:59 +0200
Message-Id: <20180911082559.24214-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_X86=n function azx_snoop doesn't use the variable chip it
only returns true.

sound/pci/hda/hda_intel.c: In function ‘dma_alloc_pages’:
sound/pci/hda/hda_intel.c:2002:14: warning: unused variable ‘chip’ [-Wunused-variable]
  struct azx *chip = bus_to_azx(bus);
              ^~~~

Create a inline function of azx_snoop.

Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/pci/hda/hda_controller.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 0053b704ddc4..aa20048742d0 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -170,11 +170,10 @@ struct azx {
 #define azx_bus(chip)	(&(chip)->bus.core)
 #define bus_to_azx(_bus)	container_of(_bus, struct azx, bus.core)
 
-#ifdef CONFIG_X86
-#define azx_snoop(chip)		((chip)->snoop)
-#else
-#define azx_snoop(chip)		true
-#endif
+static inline bool azx_snoop(struct azx *chip)
+{
+	return IS_ENABLED(CONFIG_X86) || (chip->snoop);
+}
 
 /*
  * macros for easy use
-- 
2.18.0


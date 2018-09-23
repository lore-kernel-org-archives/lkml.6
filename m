Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E193C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D339821473
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omHhU3c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D339821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeIXCiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 22:38:18 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55094 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbeIXCiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 22:38:18 -0400
Received: by mail-it1-f195.google.com with SMTP id f14-v6so8060165ita.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLpRmmAXcqfHQM/vlCqE+JhbjeuhgwiriiABBTiq/jM=;
        b=omHhU3c7duibBPB3lt93E5PtisCXz/m4zjdi1xZFWdRJxma9QrR2tIqIgk6jtMp1tH
         v0B3LTlYusF+3y+cxYnuhfo9xS25zOodG1BElPKORAKxeOgjE/3jlmbLfhbk4tFtTPl0
         ax8wq6BAfqx7RZDkahl4stzAVZh7bAIC4hUkm+y5kRu5GgNpjmchqOmY1hXEaGP/Q2kZ
         7xQQKN13/vcaNL8A5BGf8p/sLB5FZXHPmLym94qkV3wCbruB3fOO+ykUoQVMvnFTHAQw
         QqmJhx+oAql652W9qeiYjh9JHeAkXCTvgxruqpRXSn5066YFjc1TC9qvLgFueyODovaS
         J6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cLpRmmAXcqfHQM/vlCqE+JhbjeuhgwiriiABBTiq/jM=;
        b=Uw6viCJAVwJQXkJm25zXBMgrgVKI3Jdz1XSVP7XuDjExN7z98dkqz35sEwMiphRd17
         H07BtKNIgEQNV+6nJQdlFPewwf+zgLEiS8yFn3GnePR2KVdUB4rlOsm4kHJH1q8832oj
         NTGDP5jIzlqKMEjw5sTvxGNmsFtxH8SJJOkwNCAdd65QnYQkNSazNmzNPkspP86UX8a5
         Es/gGlrJb/EoZ64lHov9zI98Z5bgyZvLIGfQBWoNX0EWjMb9IUP+YZVUD2o0lHaDWIuk
         pGD1zuE05VkmMIH6LJETlRwtZvhWmL9w1cdECwfBuU5ev6Ngesgmgt8cNfl2wjEc2/Xy
         EILg==
X-Gm-Message-State: APzg51BIFJzR3Pp0+S8/Eu07yg5ESPK2Jg8R8jNPvPC17t9MK13WzIdX
        G3L8ZpVao/S/GLtBaPYf59NzRw==
X-Google-Smtp-Source: ACcGV62L5HrY188VztmIHAWmrih7S9gxo0Cgb42GxG8IkqV2n3CwcYmh1JI23BY1GHN6gWfMkuzodw==
X-Received: by 2002:a24:2c4e:: with SMTP id i75-v6mr5700252iti.81.1537735169729;
        Sun, 23 Sep 2018 13:39:29 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id b26-v6sm1399629iod.38.2018.09.23.13.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 13:39:28 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: [PATCH] mmc: add quirk for O2 Micro dev 0x8620 rev 0x01
Date:   Sun, 23 Sep 2018 14:39:24 -0600
Message-Id: <20180923203924.68452-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device reports SDHCI_CLOCK_INT_STABLE even though it's not
ready to take SDHCI_CLOCK_CARD_EN. The symptom is that reading
SDHCI_CLOCK_CONTROL after enabling the clock shows absence of the
bit from the register (e.g. expecting 0x0000fa07 = 0x0000fa03 |
SDHCI_CLOCK_CARD_EN but only observed the first operand).

mmc1: Timeout waiting for hardware cmd interrupt.
mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00000603
mmc1: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
mmc1: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000001
mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa03
mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
mmc1: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
mmc1: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc1: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x005800c8
mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc1: sdhci: Host ctl2: 0x00000008
mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
mmc1: sdhci: ============================================

The problem happens during wakeup from S3. Adding a delay quirk
after power up reliably fixes the problem.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 77e9bc4aaee9..3e5ecf7ce101 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -490,6 +490,8 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
 		break;
 	case PCI_DEVICE_ID_O2_SEABIRD0:
+		if (chip->pdev->revision == 0x01)
+			chip->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
 	case PCI_DEVICE_ID_O2_SEABIRD1:
 		/* UnLock WP */
 		ret = pci_read_config_byte(chip->pdev,
-- 
2.19.0.444.g18242da7ef-goog


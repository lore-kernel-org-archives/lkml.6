Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2903CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD6D20843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=orbital-systems-com.20150623.gappssmtp.com header.i=@orbital-systems-com.20150623.gappssmtp.com header.b="MMyymVLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD6D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=orbital-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJSWqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:46:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44253 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeJSWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:46:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so31025711ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbital-systems-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=s5MnNV4RjHCyfb8GjHutbJjoAcZTNqPufveAP5RsMMY=;
        b=MMyymVLY36H7w/U/WiWDHtPleNgqFmM8zD9vfF9+DFBn9T/lBB593wWQypP3Ds7+se
         643UDGScBvdy/RyxID5ptxioLZTiPH39vfT9o/A0o+kpvVFGEm7ioypWXYCbnU3xIgm7
         X/NDBxBMfymPTmsMJtWrbbANt1jdI6VKbZp6dJlAM4GtbHTQpL4rcvDo6SuPFEWyk+x6
         C3lMwiafN6v4BRU5BBi5ek80nPjp+MauDTMckKFTHeEgN9pTCGbCF2wiVmUwY16So7RE
         qFwEfEirnpHturvA4twW/xRIVCv6/LY/rr5/iEqPXKAdCg0vSWCDcE5ltELVOQlyuqW0
         +R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s5MnNV4RjHCyfb8GjHutbJjoAcZTNqPufveAP5RsMMY=;
        b=V8aBVGDA7+wZLUL7AragN8lq0pAVL67rSU5BwIDw0TCqlsOQ+UaxdMB0Yg4OWzeDpy
         K+gHoIQaJplZab8Fq6Ib6G6cD5RnNb7L4x8K9ZtlGHPNWL6BCJAGplJtFGJNbpZHpRKD
         aq0s4DqN5uS1j5BH2YJrYhPbiR79HqzYJl8SgVm5BhzBVI5Szivtgrl8YYlqhbLi/yR0
         SZCTibQ7cZRkVLjcimWOo4zC4DmmTWlO8x6urrpMo6TXJe5fwjAN7mDbJSt8rsR3Y/ig
         emOy9kGGv0rhgfaEII4J0juUogP3lSMhoAOVjPkvIIBEzsOz+axCWaZMWPJVzE5GqV65
         HjaA==
X-Gm-Message-State: ABuFfohWnD2IZxYekAi7vX4thJEG74zxAQ6ZXknbfyag1mdpMe7rdv0P
        Mtm6URsKW6FeVAmtt7EcPWBLYMut7qIWa1js
X-Google-Smtp-Source: ACcGV62rzkwbAaRcFKAkUgoBlw10YBrypvoiYJ/bkVhdlAvQ/CcFDiMsbYpBLclzV0CI8N/hsMQCow==
X-Received: by 2002:a2e:900c:: with SMTP id h12-v6mr24784319ljg.121.1539960028238;
        Fri, 19 Oct 2018 07:40:28 -0700 (PDT)
Received: from localhost.lan (81-225-58-94-no182.bredband.skanova.com. [81.225.58.94])
        by smtp.gmail.com with ESMTPSA id d9-v6sm5231991lja.39.2018.10.19.07.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 07:40:27 -0700 (PDT)
From:   Jonas Danielsson <jonas@orbital-systems.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Danielsson <jonas@orbital-systems.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: atmel-mci: do not assume idle after atmci_request_end
Date:   Fri, 19 Oct 2018 16:40:05 +0200
Message-Id: <20181019144024.31077-1-jonas@orbital-systems.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On our AT91SAM9260 board we use the same sdio bus for wifi and for the
sd card slot. This caused the atmel-mci to give the following splat on
the serial console:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 538 at drivers/mmc/host/atmel-mci.c:859 atmci_send_command+0x24/0x44
  Modules linked in:
  CPU: 0 PID: 538 Comm: mmcqd/0 Not tainted 4.14.76 #14
  Hardware name: Atmel AT91SAM9
  [<c000fccc>] (unwind_backtrace) from [<c000d3dc>] (show_stack+0x10/0x14)
  [<c000d3dc>] (show_stack) from [<c0017644>] (__warn+0xd8/0xf4)
  [<c0017644>] (__warn) from [<c0017704>] (warn_slowpath_null+0x1c/0x24)
  [<c0017704>] (warn_slowpath_null) from [<c033bb9c>] (atmci_send_command+0x24/0x44)
  [<c033bb9c>] (atmci_send_command) from [<c033e984>] (atmci_start_request+0x1f4/0x2dc)
  [<c033e984>] (atmci_start_request) from [<c033f3b4>] (atmci_request+0xf0/0x164)
  [<c033f3b4>] (atmci_request) from [<c0327108>] (mmc_start_request+0x280/0x2d0)
  [<c0327108>] (mmc_start_request) from [<c032800c>] (mmc_start_areq+0x230/0x330)
  [<c032800c>] (mmc_start_areq) from [<c03366f8>] (mmc_blk_issue_rw_rq+0xc4/0x310)
  [<c03366f8>] (mmc_blk_issue_rw_rq) from [<c03372c4>] (mmc_blk_issue_rq+0x118/0x5ac)
  [<c03372c4>] (mmc_blk_issue_rq) from [<c033781c>] (mmc_queue_thread+0xc4/0x118)
  [<c033781c>] (mmc_queue_thread) from [<c002daf8>] (kthread+0x100/0x118)
  [<c002daf8>] (kthread) from [<c000a580>] (ret_from_fork+0x14/0x34)
  ---[ end trace 594371ddfa284bd6 ]---

This is:
  WARN_ON(host->cmd);

This was fixed on our board by letting atmci_request_end determine what
state we are in. Instead of unconditionally setting it to STATE_IDLE on
STATE_END_REQUEST.

Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
---
 drivers/mmc/host/atmel-mci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 0a0ebf3a0..c8a591d8a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1954,13 +1954,14 @@ static void atmci_tasklet_func(unsigned long priv)
 			}
 
 			atmci_request_end(host, host->mrq);
-			state = STATE_IDLE;
+			goto unlock; /* atmci_request_end() sets host->state */
 			break;
 		}
 	} while (state != prev_state);
 
 	host->state = state;
 
+unlock:
 	spin_unlock(&host->lock);
 }
 
-- 
2.17.2


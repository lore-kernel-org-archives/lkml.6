Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1A724207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOlPsHpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1A724207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934241AbeGDJIC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:08:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43832 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934314AbeGDJGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:06:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so3714709ljg.10;
        Wed, 04 Jul 2018 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FZ75DloiVFEMun09YWlHZkiNbbYdFdjM7EkR1ml8GeE=;
        b=AOlPsHpuxtwegczcEmW1BIDXh2lmdmfXmEJ6shIBM0/RT7QcraPGlfQ4A1R4eg/k3J
         qwnSANLfRlRmYaHqxPRhjjvSp6QjVzutdgC44LMxnEbpPtPHLyjsxXXnwLjl6Qa++LrS
         UTbvmbizsz6BOONs/CmgRGoDMF1YzMswkV7OOzjyPvmTl/F5+BHYXBYIfTSWW/vwEX9N
         Q+6MXOrA+kKyCmwFn4mDxLSY78nZfAhyACcvmm1H2gfuLXiabKhGFi95mC6TzgJtXKK9
         Gr2p5PqIvB3I674fml4K39XEK0YNChK13p2X3oQH87OWooIpa9cbkMnW4UrjzpHmeOUs
         avLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=FZ75DloiVFEMun09YWlHZkiNbbYdFdjM7EkR1ml8GeE=;
        b=DRG1hkSlS6O1885ZDlcczAMnTths3jNZTJtQlyQrc7B3aUN4vZQZpCjrFSEN4O88ni
         aGD32R5t3/KOmVjEm1NmgxBUJVb9sNw3tVchk2PG0Io/eeL2RaLUoXNXs+Rhfi9ocnRv
         wR97+BGfMkNFSN2EUdafcwMu7++WAwQsc6lk3yT5o+9gzflVXVOAKMDxhrKUGmcTbFrL
         TvQExB2ka9deJPOGNO/bux2k6cSGbbthP8J7qFfiZH8YV7R9icWEGgKIVbicAUr6HV7K
         OkFUTHEmqHYbp1FmiOs3rTly/qZo+SGbWKd/zCWwSCJeIglHwvOF/+PjIGy9CwmN/OAR
         /2xw==
X-Gm-Message-State: APt69E1B0bNfKfYjjGvXYha8dqwvwE4ygRT1UPpZvZDbiz1Vd/zyr9/J
        dPfXxzp/5O0rY8Dpdb/WQhA=
X-Google-Smtp-Source: AAOMgpf3h4iwEB6YD7A+BJiV4SRpzfthRaRhgjuVX+R5jit5H/M12DqoW/K6a79YHQP+nu4lrE/LAg==
X-Received: by 2002:a2e:9f4d:: with SMTP id v13-v6mr909017ljk.42.1530695190184;
        Wed, 04 Jul 2018 02:06:30 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id f86-v6sm506571lji.73.2018.07.04.02.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 02:06:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fadjv-0004LZ-OV; Wed, 04 Jul 2018 11:06:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] rtc: omap: drop unnecessary register unlock around reads
Date:   Wed,  4 Jul 2018 11:05:58 +0200
Message-Id: <20180704090558.16647-5-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180704090558.16647-1-johan@kernel.org>
References: <20180704090558.16647-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary register write-unlock around two read accesses.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/rtc/rtc-omap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 7f9ee559dd99..323ff55cc165 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -583,9 +583,7 @@ static int rtc_pinconf_get(struct pinctrl_dev *pctldev,
 	u32 val;
 	u16 arg = 0;
 
-	rtc->type->unlock(rtc);
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
-	rtc->type->lock(rtc);
 
 	switch (param) {
 	case PIN_CONFIG_INPUT_ENABLE:
@@ -615,9 +613,7 @@ static int rtc_pinconf_set(struct pinctrl_dev *pctldev,
 	u32 param_val;
 	int i;
 
-	rtc->type->unlock(rtc);
 	val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
-	rtc->type->lock(rtc);
 
 	/* active low by default */
 	val |= OMAP_RTC_PMIC_EXT_WKUP_POL(pin);
-- 
2.18.0


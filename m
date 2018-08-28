Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D44C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1A208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="APtlpFpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A1A208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeH1NWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:22:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34210 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1NWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:22:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so836383ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCrycUkI2igXZYUZAQ5kmKLzX7nJozRTvvvVQw2759c=;
        b=APtlpFptnLaId7dDomOw0x8P0SSqHIgQ1fIFO03qLvZWIHs/rvQPZ6OVLdpTaDQaNq
         cKMOT1V+14KWUU8ZMHQeqDEfBBFU89qMOYOhZPf/6iz11twlbPZSMwa9xjeM2NQVm6t9
         5GrLTXPyzby3fQ11TzeT/DFzpr0ySc1A53Euo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCrycUkI2igXZYUZAQ5kmKLzX7nJozRTvvvVQw2759c=;
        b=fmLQt8ERsXV1OtfKwnZ18wooTCa2kK83hfKGUFpQCqAEK9yjgGcYdN6JI2+fWwPsnB
         aWEqEOW+XIxot2ZVOVYJmsILlg3+pmJ1Ui3E4pzm/EShP7dbOFwv/7jrMQuzmtso6T3Q
         LDH4X1vq0LO+x95mzM4QMAp22aEbnPuYTbVOA80752IlaeHsrk6yg5BUDpWc8q92LUX+
         48/GJJvwaS8EsYm5cbPb7ovBmQpQay/eDDIeQckAvsqRFQItv3VY8VYBwBkq+Huvt0ca
         4/rAyihWRAzXAf3LShnHv08KhrvDHNVYPDwfKPwWe2EVJR3qFbBVYiybjxkT6bcvhJg4
         H+Iw==
X-Gm-Message-State: APzg51Cd8s0WNhL8jXbGnLwOeGz92V2R1tUFtLYSl99EKyZiVjRvgeJz
        N2WT0CeM/qkjQpzKGezc1D0wZPkF1JQ0sQ==
X-Google-Smtp-Source: ANB0VdbYrSkPg38hT7XZsEixyb8ywUart2Hkrl0VVpEajdEVJ/BXHQJ7M4FLY42So7alFAtmrnmWTA==
X-Received: by 2002:a2e:9198:: with SMTP id f24-v6mr647817ljg.64.1535448684304;
        Tue, 28 Aug 2018 02:31:24 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id j140-v6sm127633lfg.16.2018.08.28.02.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 02:31:23 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] cpupower: remove stringop-truncation waring
Date:   Tue, 28 Aug 2018 11:31:18 +0200
Message-Id: <20180828093118.28326-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
References: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy doesn't null terminate the string because the size is too
short by one byte.

parse.c: In function ‘prepare_default_config’:
parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
    nul copying 8 bytes from a string of the same length
    [-Wstringop-truncation]
  strncpy(config->governor, "ondemand", 8);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The normal method of passing the length of the destination buffer works
correctly here.

Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/power/cpupower/bench/parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 9ba8a44ad2a7..84caee38418f 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -145,7 +145,7 @@ struct config *prepare_default_config()
 	config->cpu = 0;
 	config->prio = SCHED_HIGH;
 	config->verbose = 0;
-	strncpy(config->governor, "ondemand", 8);
+	strncpy(config->governor, "ondemand", sizeof(config->governor));
 
 	config->output = stdout;
 
-- 
2.18.0


Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD66CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8421D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A8421D25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeGCXsw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:48:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38252 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753608AbeGCXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id b1-v6so656925pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JUnOEOr8gHOAxc3fUHt42J/mZXyIJOME2B8KjbvJWaQ=;
        b=DqjE4dOVR8v3U64PBCVYbUU9cqC9TzH7bM3wYlbLoCrTbENP2+tCeITvIj27mfcgIP
         eWZA29KD79hA5XDpo0cPzyVJFjRAbiK60htklqfVXtV8PSR9ePTYL1BMfgh2+2dI9u0u
         XhUmWNxRN/TSiw7Hc3j+MFqw7A6Iq2NfOuBp7XV5We/LJkDy7Vz2U4MyK9muTgETDQYJ
         wQ9Wddy/P2oFX5BS5xfrmqMG8WJsdfFfNnVuOyy5HN+oz3jStPuVg2S68btlkhriLI/7
         rpbMVyPUyLVaTL0VVOn2+vU5MguDnMTMszF7C8PjqRFp58G1PcnTZASjtdr9K04qqS3s
         uJ4Q==
X-Gm-Message-State: APt69E3dvyiyxur4TkR3dGJCDEpe1iZE84ef+ZfFKrTfGo9ArT2CC97+
        YHYqEZLlLhcnZPR96XrtQeZ+lw==
X-Google-Smtp-Source: AAOMgpf2mgVPutTnkpv/VuB7AMo14804KRD5BelHDJVKIRPWi9hCc+LPxAhn8BCKb4cXHypUf3uB3A==
X-Received: by 2002:aa7:86d7:: with SMTP id h23-v6mr27889353pfo.132.1530661654453;
        Tue, 03 Jul 2018 16:47:34 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:33 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date:   Tue,  3 Jul 2018 16:47:01 -0700
Message-Id: <20180703234705.227473-9-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
cpufreq_update_policy() is not among them. The throttler driver
(https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
possible throttling mechanism, but it can still be useful without
cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
driver to be built without ugly #ifdef'ery when cpufreq is disabled.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- patch added to series
---
 include/linux/cpufreq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..dba8c4951e2e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 	return 0;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_policy(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.18.0.203.gfac676dfb9-goog


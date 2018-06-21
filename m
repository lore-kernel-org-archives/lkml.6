Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CAFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA1C20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA1C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeFUBzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:55:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36109 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbeFUBxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:06 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so645792pgd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PHqGB1KWmXG8tCPBzzeKxwdK3wpixqoJlVtQHpiPhAs=;
        b=pX9rxhOIy14NlKeM3C0eCncoXwZnvzJif5g2A3zIKetyIu7PzRd6KIcjSjG7y8S54/
         c9o5FzARwXb+lacYEH8+qcqdzVdp41EZb10oktuMp/1JjYMh8jP9gR02Qgke23rNmQCg
         AumUdlsHWKtGlxlGl5sRrOPoLR0DrRLi+411nhsja0MPX3/3EUnD7K1oRxMCizbdKDsu
         X4Axnhmm0i0n0VEfaJnVBBVM1Y/b3rTexs5ACqmVg+dM0v91k12kzAWk5EFkOMf0fHi+
         lk6mN8eDBsOY7c5n85Vauiax7rLcLlfLMUWoLk6gATMd/unXTsXchO4BaikFG0UEA187
         4acw==
X-Gm-Message-State: APt69E1Suyo5buRFH3Xw5W3n+YBekJCUq3RZBQ3t1NkqjKfqLBJpijuR
        jVBCKgf+A0RLMvimkQ8XrHsCSA==
X-Google-Smtp-Source: ADUXVKLKgIl2otPeamWlZeHla/fI4O2g81O2+bonDgSOrtj9o/CfBNGkOVYTttMTTljUAlQdYk9efg==
X-Received: by 2002:a62:4359:: with SMTP id q86-v6mr4060181pfa.140.1529545985103;
        Wed, 20 Jun 2018 18:53:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:53:04 -0700 (PDT)
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
Subject: [PATCH v4 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date:   Wed, 20 Jun 2018 18:52:33 -0700
Message-Id: <20180621015237.100100-9-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
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
2.18.0.rc2.346.g013aa6912e-goog


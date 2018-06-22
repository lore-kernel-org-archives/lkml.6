Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED677C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BB723EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsoA7xBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BB723EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFVIKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:10:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33431 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754173AbeFVIKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:10:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so3111502plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UOdkApVVBA+z4FyuVcx5+Va8JRtm2Zu3pthKkD+YL98=;
        b=OsoA7xBWvV27vxKUrsD2CDeNCrdnaaAfqqOKMk4RNQr+ZIMJ9Q8k42h1xEeWeXON3c
         6+E5f2dLG/4hbIhBgaI3heMEEajkGBLFozNMwjKrjR4Ami+RUfskpuqWrK/nxRoc2R7X
         V38J4MzNBi6um5MiB8pZ7xvkTZ9ghc8C7ibWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UOdkApVVBA+z4FyuVcx5+Va8JRtm2Zu3pthKkD+YL98=;
        b=g0I7CvUOTfeLUychLNeOBFjOYpJQaheWqyT+mHGSCO8m4YUCaoYwsoTVfBM0itvWhI
         eY1uIHTgftqgpD5h5Nuv7RMYstFDMdZhKaxjzUZsgoAgNaYdmqrXnepcr070oQSYY/Ob
         DrVF38wxIF6vJyN/11k56GLXAJcNJZyf+P73V3XVsyg6LEMgMTlvcARvf1o19QbbLHOW
         it05QQ5eiGWFCOTmfJTR0Yq9WBe224zwYq5+GriwNUEz0DC18UeM01hcz8GmfLCD68Dk
         B6v0lYaJP5eFpS/rhzPYAnUqKiEyH6ncrvmagGwLKKln7nPL3Yb086poqwYoFNQKg6eH
         2yfg==
X-Gm-Message-State: APt69E3ukC7ATrrxFTEkZ54uD35r5HgH3UkxjLFzK1BNnMIG+BQx2GH9
        of711ZGsJs7D9SRqn1ByiKL7DQ==
X-Google-Smtp-Source: ADUXVKI/UjsZR9Rf91+XbC35vvA77AR4EeyFcJ7whxWTFfZkmT4XfYSl9AFAxT66abxgwdHCu67CVw==
X-Received: by 2002:a17:902:aa83:: with SMTP id d3-v6mr576991plr.323.1529655002093;
        Fri, 22 Jun 2018 01:10:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i65-v6sm22656131pfd.17.2018.06.22.01.09.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:10:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc:     baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] hwspinlock: Remove redundant config
Date:   Fri, 22 Jun 2018 16:09:01 +0800
Message-Id: <a36034ffba1e2416270bce9ecf40bfa33f12f017.1529654288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware core can not be built as a module, so remove the redundant
CONFIG_HWSPINLOCK_MODULE config.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/hwspinlock.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 94064cc..0afe693 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -52,7 +52,7 @@ struct hwspinlock_pdata {
 	int base_id;
 };
 
-#if defined(CONFIG_HWSPINLOCK) || defined(CONFIG_HWSPINLOCK_MODULE)
+#ifdef CONFIG_HWSPINLOCK
 
 int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		const struct hwspinlock_ops *ops, int base_id, int num_locks);
-- 
1.7.9.5


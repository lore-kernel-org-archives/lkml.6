Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6B2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="somvAXwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfAJUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43160 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbfAJUxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so10946307lji.10;
        Thu, 10 Jan 2019 12:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SD/OC2mkph624S4bKD3nSN6vMhl6eg9eqmNC9NaBYg=;
        b=somvAXwFWVUInL8qU/Be8IdSbgDkR4UaG91kcTe3n8czAmA1mzk7gJ66uxFpI8hWx9
         IUOy9kXQtxiTGMzW4PAfI3Kpcvt5ANS99Gk6ImDv6q40PuVPxio/CBOsXUyxGG5xzdEy
         3qQv7zz38P83fi0E9RwOijcf7y2i6Rl0Fr8DJBSynNZ46gsWkSklwJA5736cB0Av8xoE
         +7gJoweqGrdbFWA/Yr2KVkfLxda8UUu+ROgf7FCrQIlD+0gVKta/xXMu5JGRl+xJtG0Z
         5qgFAKtnsuplwxD7Dpa/17EKWwaVCW6duIaY1XoVQ/h/uXMPDjMXz/9kyPJdLK09G1cW
         6q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SD/OC2mkph624S4bKD3nSN6vMhl6eg9eqmNC9NaBYg=;
        b=O5ahyR9rCvHIC6D0VoY4o1YM8836kqBk0LhlU6LroUhK59PrehkaEoXuiqRdjXzDku
         vadeR6dpQO5MYkhhY4AEHA5kmTMIdrmDfoMQGv9/2jdog6IWJm7oz9ZozeFPh27vrj9M
         EVPmmX9bbtdSmpZ7/TX+mNtYeN1MBgkF6v654ABhpbcfEpDN5HFNjLPbc0mNd6fomvxa
         R3Bhvj8HOCb6I3lv2rtiqh0UkR0wclY9yXxocQ6LvaG2IecZMNhSOAFS7YBSeQNgO5EM
         LgwB7fkMEtRiprHdjo9pMMMFW8j5kQ13fc4CZGzqej0xS7wu0ifgNuyP1Kr++hZB4c5p
         86dg==
X-Gm-Message-State: AJcUukctg2FMEb8lBD1FwHb4xrAVXuPqsGdPLtwKs0j14ow2aRYVSGO9
        dup3QhFisNG8o6opMV+8m34=
X-Google-Smtp-Source: ALg8bN5OhNydl/YWlWYGi+wVoxty4MjReSUNdvKbqB3yWLq4KH0DXd1xC7lsMDC1i783piOK1c0mig==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr6788109lji.167.1547153594941;
        Thu, 10 Jan 2019 12:53:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm15389690lji.42.2019.01.10.12.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:53:14 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/4] cpufreq: s5pv210: Don't flood kernel log after cpufreq change
Date:   Thu, 10 Jan 2019 21:52:13 +0100
Message-Id: <20190110205215.22030-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces printk with pr_debug, so we don't flood kernel log.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes from v1:
  - Added Acked-by
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index dbecd7667db2..f51697f1e0b3 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -481,7 +481,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 				arm_volt, arm_volt_max);
 	}
 
-	printk(KERN_DEBUG "Perf changed[L%d]\n", index);
+	pr_debug("Perf changed[L%d]\n", index);
 
 exit:
 	mutex_unlock(&set_freq_lock);
-- 
2.17.1


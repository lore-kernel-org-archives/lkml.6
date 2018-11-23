Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8682C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E3920672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM+rAQl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436518AbeKXASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:18:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32968 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeKXASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:18:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so3118662pgu.0;
        Fri, 23 Nov 2018 05:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lDsJKS1oNLz/0T0+4NfjSFsaxXGbh8mIOnrI7P5Es+4=;
        b=dM+rAQl2gUgSHgd1sdclsZ02HlyaCXQw3qQkN1u47coDUadS2NRwejkIGbLeiZu13f
         gD3amtdF0tQB5QepcdmwFQpH0INGPyDAIEVqo+XIe1HxG+nawsPt2SUq2bsmHQMKMcWd
         4KmcoK8YuQxD5miVw9cfqBPAgIJR/X6Hb/1fXPdFAVNVqrzuS1kziyFt3/oCxHtE0cGd
         QKkEwnql2mGQ9bhGE7OQqYt37ZEgYsG6hQvtYjhCisK29uTteo64znTH5vdBQFpbynhO
         Z+JBhDW5qkINjjWzdzyypERxiYYNitpZG+2RopXM/B9H7/wqxFRboxrRAP3aSLBkjv8m
         T3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lDsJKS1oNLz/0T0+4NfjSFsaxXGbh8mIOnrI7P5Es+4=;
        b=FR3leFdI0eSxsxE6Nno9fS0lnCF4ndBFwwt2DYlnYFRtDViAfqwwgDdZTyVtQgAgwt
         4cuad666caqnE2/xETcnYE1f5KN+Zb+5xX52q+thEN+WF5sOh73aniFfCp0llecwHWD1
         +v4igkE2KbCm9cIwM0B9pmBA/DS9M4fY1oLDENi1Ak92zlBxFRgoORX60NHxLng/UAOJ
         5beD7wpqNfcLSW93OSMgyFzaMbLpvoE3EuT19iTxRRb0CtFam58xK0j49CEN3iioaH0K
         NqYPzO7VHXm8cMNrPFhrn+pYeeFlWI2JHqhXATXfIsp2e2KvO7Zx5yISAnp0/zxlC4R1
         6SZA==
X-Gm-Message-State: AA+aEWbP17D1X1uWw7kQIm0VNpRqMRs9K5wXlrSCQuLVoMy+kgjg0kGH
        fbIxA27A4AUsvIzPI1M6gJY=
X-Google-Smtp-Source: AJdET5c9TngiJYlm6VKowHdlqL+8rwEppVXR4g+0oDVtg43zOtNU4dhbaD8NBLXnIdJ/Mm6UtP9/Kw==
X-Received: by 2002:a63:1b1f:: with SMTP id b31mr14108993pgb.66.1542980030167;
        Fri, 23 Nov 2018 05:33:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d68-v6sm61764630pfa.80.2018.11.23.05.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 05:33:48 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] cpufreq: pmac64: add of_node_put()
Date:   Fri, 23 Nov 2018 08:33:40 -0500
Message-Id: <20181123133340.26849-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.
g5_neo2_cpufreq_init() doesn't do that, so fix it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes in v2:
-update changelog
---
 drivers/cpufreq/pmac64-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index be623dd7b9f2..1d32a863332d 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
 		pfunc_vdnap0_complete =
 			pmf_find_function(root, "slewing-done");
+		of_node_put(root);
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
 			pr_err("Can't find required platform function\n");
-- 
2.17.0


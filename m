Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCDECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B372086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+5nHf4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B372086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbeIUT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39552 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390081AbeIUT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:34 -0400
Received: by mail-it1-f193.google.com with SMTP id h1-v6so1929525itj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzBeb2hyTL8rR7/sPqEb+muFfVwV6usujwCr55pWv2I=;
        b=i+5nHf4VQD0TBf/6+QzKfGTYdjIshV+4ER+vOBEyrUOK6wkK5aZIbZajPJlFDV/s5k
         D7FNjqzqZSB1Fwskh/zo4FWVLtj+Uh23mbNA1MV1TlTloHP9wF0FBGL232jXMzbuTCLA
         XEKemQ6Ly1P05/yg9M+2NcrVzy65UfTWygh/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzBeb2hyTL8rR7/sPqEb+muFfVwV6usujwCr55pWv2I=;
        b=MbCQ1NlHFiGJqvE7KK8dLOKV6hyGDS97uFe46SbMKrwBBQghV+fr8pL5qNwX1u80t4
         i784ZzXs62J8Aju1rQp/MT3axchXzBSq4x/fT2NiS3M1iGsxGROERLQHFNE14j4faMrF
         e5NPOuzGGQNyQsh5QQ6if1n/o2N5Z0WQqUAWVyUYwBWoNxGiqKfTeZWxUBZ0WeOzshCf
         gCnYFbbZQcjNsZYLCOdVpotL4Pef/+z7QyNBzw1RwpkJjh4KnQrpI/AMAwonaz/7Lxz0
         FL9kGNuGaeK95iN34scPUc6BNfdM5Fq5vQBzVR4sn45r5Mz3JStoRtwZ3THyZfqVFE1a
         xzYA==
X-Gm-Message-State: APzg51Dq5bL43VrwT2sV4hdqsR2njgo+eDqS8Da6xW1DvRRHpWHDcA4X
        hY8QAV87qi35uFc2IE6H4aAk0gvJvM8=
X-Google-Smtp-Source: ANB0Vdb9MlpNzTkMCIB0IiUHdo3QayCxv/Ci7A6PT3+QDi8FLPFr+z6DvnLOZ4fa6zFOgHjsb6FaXA==
X-Received: by 2002:a24:1ad1:: with SMTP id 200-v6mr5991746iti.4.1537537239709;
        Fri, 21 Sep 2018 06:40:39 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:39 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/26] nvmem: remove the name field from struct nvmem_device
Date:   Fri, 21 Sep 2018 06:40:04 -0700
Message-Id: <20180921134026.4596-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This field is never set and is only used in a single error message.
Remove the field and use nvmem_dev_name() instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 11afa3b6d551..72313a1d215f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -26,7 +26,6 @@
 #include <linux/slab.h>
 
 struct nvmem_device {
-	const char		*name;
 	struct module		*owner;
 	struct device		dev;
 	int			stride;
@@ -652,7 +651,7 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
 			"could not increase module refcount for cell %s\n",
-			nvmem->name);
+			nvmem_dev_name(nvmem));
 
 		mutex_lock(&nvmem_mutex);
 		nvmem->users--;
-- 
2.19.0


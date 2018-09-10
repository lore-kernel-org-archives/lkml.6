Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA9BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkDPTcHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeIJNvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:51:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37871 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:51:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id j8-v6so16759758lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WcKozNf/E/SqeBTKAgm33oNv/Y5p9ukod/O5JDKoYDY=;
        b=SkDPTcHlXuiu1oU7tB8VZ3314ULuOCXx3tktqslNA6x/OXgk86fm16/SQpppXnW3XK
         TwncQpm5DbTzZ+iQjOQj1zMXzVS/uokoLrM5/d1CDtVSBM5RrC4Lt73x+S9rPP6mVIob
         ilgpV2o1P/qXUtmNZNNVle2i68+KtXbCDhOG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WcKozNf/E/SqeBTKAgm33oNv/Y5p9ukod/O5JDKoYDY=;
        b=KsO+HsdAdGVyLkIDjaY09fM8gfgYiNrdVX7i9eieXChgr6kyZzTLQ+56nWAitnanz2
         aUqH13Fw3nWnexmWUpkmlBRcJNykgm7D+LQcFTlPCRTKjwm4Mr4SjyUHlDx6g67NDyN1
         RKaSViBagws6dJHKu89OrxYr3OpcmsL2Gq/mA096gnMgvgTKiup9BbwThAQ8IgLGpqiW
         +P0uMWGcrRD8IyIWWQ5RN6pZYGOzC09DQGEEWemELS3FWCf/2hMjmh3dJCf6rtQ2IQMx
         qMo+z+u+ASJrYqDiPRIOWjJp47zZm2A38rXq/EhvPVXeT4GcUeAXSbVeupTLJJCXttEZ
         iAxQ==
X-Gm-Message-State: APzg51D03tgnQhWvSUpj9Rw+Gqezxuiy9L5gL/cfCdrhM54/dyVlK8sY
        acVWSucpeLWuD5zWpKFLFDr+k+taqMcqR8z4MnAK5A==
X-Google-Smtp-Source: ANB0Vda4a104nmzyMfuX9gjnUCXVscTonxpl12m9e6kfHSR7mb5Sv1j265qXIVgGEZfjfvhzDbGeCPXN7j+xdSllNII=
X-Received: by 2002:a19:4e4e:: with SMTP id c75-v6mr11663297lfb.116.1536569889295;
 Mon, 10 Sep 2018 01:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:118f:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 01:57:28
 -0700 (PDT)
In-Reply-To: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
References: <CAHqM-Qgy7zPjrnNm0Xdyz_F_BYbSPgDfQrkv0tGv_rB1G7tSXg@mail.gmail.com>
From:   Victor Chong <victor.chong@linaro.org>
Date:   Mon, 10 Sep 2018 17:57:28 +0900
Message-ID: <CAHqM-QgH3d3Fz=P-_Gj_ZJODK1YOxT49G=qhzAnM=g2HAYqoow@mail.gmail.com>
Subject: Fwd: [PATCH] tee: optee: log message if dynamic shm is enabled
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Victor Chong <victor.chong@linaro.org>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/tee/optee/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe842d66..cca5c091e55a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)

        optee_enable_shm_cache(optee);

+       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+               pr_info("dynamic shared memory is enabled\n");
+
        pr_info("initialized driver\n");
        return optee;
 err:
--
2.17.1

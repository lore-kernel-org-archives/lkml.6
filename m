Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C644C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9248208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+MiC73q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9248208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeH0WLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:11:52 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:33740 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:11:51 -0400
Received: by mail-io0-f201.google.com with SMTP id s14-v6so14824176ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dH2DI1fRkDG1D5VXKEAsoAEVHFSG0wnaqoGIpPQaA1E=;
        b=o+MiC73qgxLsZorSUsx3RZRmQ43q05mPoMbfcFJJrMa+SkH8VqlTOJKzBr/PeceSZB
         BF1z+pe7v+382BAetPmKbYg92Xhr58E1qgxj9EAFPI5Yq7qf7zitt2KsclSGUMMapM+j
         ODf4ctKXY2aydDnPDsHqXNPxFanH+UUJaVLf1NqJigs1BW+HYhuBJEgUSWHDUNuU1N+9
         2ucwtZvmUI9MXXsU0oHg/b3hJbE9GaXmTPR6YpmfRcRrGwlATfPZEh6Z9aQ4uTKKOZpu
         WD6IU5BbXXaWl1sQMbAGWAO2f2hhlWQXGS2tStJvmRN6Vm7n0m4siQKdaoMCXFnieK/k
         Vl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dH2DI1fRkDG1D5VXKEAsoAEVHFSG0wnaqoGIpPQaA1E=;
        b=CpKdp+nn+c47YebkgxxQuL4nXyo5THMfMff9AnPn4PJPmt+o59nuvRdMFnWS/RLBvh
         1L0Ycu0Xph+I4Vc9jRueXU0bqy12u5Wg/hh0Gm4/gscMJUUITQPPstu3AnpFwhsepZ40
         80ucb93WOnEB9vb7+ZWjINT3vWP0guW2XV3g339nveVNS1bfaqJ43SVBHRrnO2RDYq+M
         +AxRSxRGv+8yiq5SHjo/rtXYlJOTqFXJOwy8unRPk20n88qLlUGnv1fSC+OUJ13bs4JS
         4goOFN7w/HM5qMVBRi0cc9OqZnJ5CO7rjkPJWxFJJQYfeGiix6qJaRZvCT5fBEMjUcVb
         t5ig==
X-Gm-Message-State: APzg51CtAoQRsaLIzIOBKiiw4+mChCY7B0t5vUgL4iMUoQNv4YmhACGL
        8Q7vZl3KcV/HksZdZ4s6S7cKxLMq
X-Google-Smtp-Source: ANB0Vdbe+uoHHtmSkR4I+R1qUUIxGc4mrE31C+umD6gLiw8dtIsx50O+NCR5EdTVkf28oFlIRPOleOWc
X-Received: by 2002:a6b:20ca:: with SMTP id g193-v6mr6233325iog.116.1535394249794;
 Mon, 27 Aug 2018 11:24:09 -0700 (PDT)
Date:   Mon, 27 Aug 2018 11:23:07 -0700
In-Reply-To: <20180827182315.126345-1-rkir@google.com>
Message-Id: <20180827182315.126345-12-rkir@google.com>
Mime-Version: 1.0
References: <20180827182315.126345-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH 12/20] platform: goldfish: pipe: Remove reduntant casting
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Casting to u32 is not required here.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index e3c09ff7867a..ff0e150d15d5 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -828,7 +828,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		      dev->base + PIPE_REG_SIGNAL_BUFFER,
 		      dev->base + PIPE_REG_SIGNAL_BUFFER_HIGH);
 
-	writel((u32)MAX_SIGNALLED_PIPES,
+	writel(MAX_SIGNALLED_PIPES,
 	       dev->base + PIPE_REG_SIGNAL_BUFFER_COUNT);
 
 	write_pa_addr(&dev->buffers->open_command_params,
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog


Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD7C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0168621569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnSr5wkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0168621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHGW7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:59:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53253 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeHGW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:59:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so433146wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oJ22a3liZEP8qbGc7vlWC/+LbnkmD1Srl9omg9amxoY=;
        b=pnSr5wkgsU2bQKSij/L7zOf2SL3byOFCELFbMLn1BQMcpOX/FV+vKtIWaRLLS/YIjf
         Z3e0spK93mcg7y/SkL4eb0kgALpPe1jjcSQ4u18j2nkvEvqMJz53R9Mo9CgdtKLnXjLz
         t+3EobQTtcwCDkIqHrI4zoV8UZvksDrjRXl813n5/B9toiM1rlZMejZOnkvwHTJHtxe4
         egif0BrE8q5wvpDIzsLiVwKEo/NVYGXv0l9qQBoT5+q2FTNnWKnZot4cZAq49gUx9KP+
         gcX1ZX/FltcZ1j8EgemFSfJhmAgV8yR0pcGpwIs488BOPKHVE3bzPdwJg6yI0wHDNcUE
         Satg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oJ22a3liZEP8qbGc7vlWC/+LbnkmD1Srl9omg9amxoY=;
        b=S0AM1D9ag9UAYyf0QhFj7Qk61KtBxAehU7UyCSjunZo+qZpVW6WbBlgZbllnfE9nGY
         neWaAhzU22mOUq0kqqJchiRyVmMD3WdJasDTwcnAxMdvjHvDtzbU1RcNACYUG+iwTXdM
         fObqAisZjxOY5iuODxToFo/Lt9sSpQIqNlw1DkaG83bL3Y7Q3bXn/c5PEGpAvn5kQwRO
         lOX5IlC8j4I4uKuN8yfvbTfRaf4UzTBcLXBbFv8AuuO5LZtKiEqyzTcIyiQaZ69kNIL+
         5fYJnzsfVfRTwP1bWK1Sx2tTNUiWyCsYMxyQQbjO0iV80oe/p7LOGv4pOdp1AA3BGL+H
         aCpw==
X-Gm-Message-State: AOUpUlHKLGtJMFwAxpuoFTaeVHKZNe2BraeG9JJhNjdjN1XUe+hi6IAo
        bR+nBe8WjtYzkVma3UHfY1k=
X-Google-Smtp-Source: AA+uWPwqHG1P0FT+slO+BaaJj9fWZW04Wa5KeAF0ugsyT7oOp8I1RD5900dJ4TrAIdLgyeTkSHy1ow==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr3095wme.70.1533674566850;
        Tue, 07 Aug 2018 13:42:46 -0700 (PDT)
Received: from www.gmail.com (bzq-109-67-115-153.red.bezeqint.net. [109.67.115.153])
        by smtp.gmail.com with ESMTPSA id y128-v6sm4094602wmy.26.2018.08.07.13.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 13:42:45 -0700 (PDT)
From:   Tal Shorer <tal.shorer@gmail.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tal Shorer <tal.shorer@gmail.com>
Subject: [PATCH] nvme: fabrics: fix ctrl_loss_tmo < 0 to reconnect forever
Date:   Tue,  7 Aug 2018 23:42:39 +0300
Message-Id: <20180807204239.24907-1-tal.shorer@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user supplics ctrl_loss_tmo < 0, we warn them that this will
cause the fabrics layer to attempt reconnection forever.
However, in reality the fabrics layer never attempts to reconnect
because the condition to test whether we should reconnect is backwards
in this case.

Signed-off-by: Tal Shorer <tal.shorer@gmail.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index f7efe5a58cc7..206d63cb1afc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->opts->max_reconnects != -1 &&
+	if (ctrl->opts->max_reconnects == -1 ||
 	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
 
-- 
2.14.1


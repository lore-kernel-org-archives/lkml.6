Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51013C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133A420666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nndFkjLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133A420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJCFGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:09 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39598 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:09 -0400
Received: by mail-yw1-f73.google.com with SMTP id l2-v6so1859202ywb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rhgtbiBZWaLOB7dPX6tpwMdix87qHLmmiTCVMezvGnc=;
        b=nndFkjLNrrb8lvoEXfjIFiRz6dRdYbP6bThn/vH0NPwG8+WWyNSUPNhW4xQksR+Zxe
         7fobeCjZyQvL7QmaKB7/2kG75jPIJZhpI/fTD4HfhhDnEOzA53/DxiAq/OFtPwipSppU
         WIdK7ReQEeOor7hjv9VuJfAVLaRalW2S0V+2rhOx+XcgB2GKQtCTwceWZRv+TRvO28/+
         8HN+v5qN68AtxlzPGFKjsx8EmNUpd/deHNLscQoCh7QarPECvhuYqCpzuZG0nOV0N00H
         A8yvPWmQLZrLxvzhpY4XEa5NglKePqGKbrNDKlQuK8vyAua8e3cOizbtAq6RcAnwVbcf
         5YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rhgtbiBZWaLOB7dPX6tpwMdix87qHLmmiTCVMezvGnc=;
        b=p06bYNEJpHPmaf5EyWJRk5C6x+RZeITS1obvSVDaWC/jCu5DPKw9QczFBEIiIZXU76
         YCXWK+C8KsyeVlcNPS9UlBbatX6BOW+Ynk30Nloc/JsGAXMf9rsK3CCcx/4eOvcNiDqu
         WSpRqLvycF6r43K2aUyB5ksZmPH+2FwtLK21VG5nSmx4V12B3o3pSV/AxVMNUgYqngVW
         hcgRhsLNCGZlzLFsGUCPWYzlyKVQhCVYsGipkZMO4m8UCJvdJPf8HZkPqXrWaVIESCeO
         JyXFtUk1bAYcDroMZjPKHlsLZERTv8Hi8S7hHdUrU/C4t9B0eOEDneQNkx5TIMHbRWop
         yAFg==
X-Gm-Message-State: ABuFfojAupWl0SjiKg8bY0qDfTTX2DCgftYxAMVwves1eqq9i5K74dT5
        G/OoNhv2obydL/5twakXbxHQz2bR
X-Google-Smtp-Source: ACcGV61NJOZUAHibQO8QPZXZxiWJozijEW+/x1d3DwRnejfv2QhUSMQI8Unf5zrUAyIotmrXML5Hy4Aq
X-Received: by 2002:a25:5457:: with SMTP id i84-v6mr9521100ybb.45.1538518834311;
 Tue, 02 Oct 2018 15:20:34 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:56 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-8-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 08/15] platform: goldfish: pipe: Add a blank line to separate
 varibles and code
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

checkpacth: Missing a blank line after declarations

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 1822d4146778..a1fbbf49cc3f 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -713,6 +713,7 @@ static int goldfish_pipe_open(struct inode *inode, struct file *file)
 
 	/* Allocate new pipe kernel object */
 	struct goldfish_pipe *pipe = kzalloc(sizeof(*pipe), GFP_KERNEL);
+
 	if (!pipe)
 		return -ENOMEM;
 
-- 
2.19.0.605.g01d371f741-goog


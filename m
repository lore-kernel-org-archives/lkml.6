Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276ADC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41C826A49
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aLncrsA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41C826A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935130AbeFZMLk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:11:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51938 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934970AbeFZMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:11:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so1656471wmw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kaxOqDokExo40cwHfnUNKY0iM5xw+MsC7qsbQxQnm+Y=;
        b=aLncrsA3t6hXxFA7PS5FT2Z8OW3QjCzMISl6m2AHHn9sQLFE2e6W2WyCUQQpvZZjLx
         Y1jWVtztYbgV9qHJEsl48Jr216NQiODLlaWnFlCszrCleetKWDdn0Oy5feAZnAHxmFPr
         IIeGSjEiMbJcIS0nR+GFHILgfQgfGtjk1W8qc8Mx0PPHTWDoF9ofOXGtYcQlkorbKjj+
         7a/TK7Cm0GpJ83tLEVRsxLm5SpKfENZV0tB+Oirfw8J4LHepJ2Vd5WYgf7CT+4SLZZ6S
         4xWY+eg2i0ZswwBUMCPQVBFNBKv5sebcnLMLRh2I5haH6tnxhpDeHCVuo86Mxlq7x+FN
         JxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaxOqDokExo40cwHfnUNKY0iM5xw+MsC7qsbQxQnm+Y=;
        b=i9kh2at0fOjYw6l4wkcwAPxrXhW4tgPRazK5KgYWEXfaiPdi2sCqm6ojCZjR5SpHJU
         x7PQlIKp3FJ2omZ4+WKH7aEZtWgUaXoKc8UISPfTuKhd8weFI8uJUz3h9FojMlY374h+
         WE24Cam6tbR2EyotKp6v1ZzKwSHOj1F916ELSvzhZGDm0pakT28gQ50ZNwghOY6XrQ3k
         T/KMnhsUh9PbwoZAGytZb0RlatGcuW05AVqnYqSSBq8f//lBQvrTRxAItCr8e/jzykq6
         16ofESlkts7hyzNPW64md0QzLqW9tHxB8RwgoiuxsPYKNUSw7iFoI88Mf7u2uxxP9O06
         YlKQ==
X-Gm-Message-State: APt69E37n3diuND/axQMhCRBnDz71tqV8VGxueeZbUNJGykN1fbTykhx
        6KU0QDFIsUoXqCyDbb7Vc6ggkg==
X-Google-Smtp-Source: AAOMgpeOrQ/IS3rF7g5RMe12CJqhnKSj3uCJf2/gx/yIxQAXw95qBAGhBl5Hvt/jvKTcJK63eULAEw==
X-Received: by 2002:a1c:4596:: with SMTP id l22-v6mr1459152wmi.33.1530015096960;
        Tue, 26 Jun 2018 05:11:36 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id l15-v6sm1917865wrs.95.2018.06.26.05.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 05:11:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: simple-amplifer: add simple-amplifier compatible
Date:   Tue, 26 Jun 2018 14:11:28 +0200
Message-Id: <20180626121128.28564-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180626121128.28564-1-jbrunet@baylibre.com>
References: <20180626121128.28564-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple-audio-amplifier to the list of available compatible

Suggested-by: Nicolò Veronese <nicveronese@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/simple-amplifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index 6c27d4afaf3a..85524acf3e9c 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -101,6 +101,7 @@ static int simple_amp_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id simple_amp_ids[] = {
 	{ .compatible = "dioo,dio2125", },
+	{ .compatible = "simple-audio-amplifier", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, simple_amp_ids);
-- 
2.14.4


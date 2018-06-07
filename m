Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V2bmLPyPGVsoLQAAmS7hNA
	; Thu, 07 Jun 2018 20:05:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0D5C6089E; Thu,  7 Jun 2018 20:05:24 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mAj6/ja2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0926A60290;
	Thu,  7 Jun 2018 20:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0926A60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeFGUFU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:05:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52236 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbeFGUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:05:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so20214748wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX4JavC5r+wDie0MzJp42r8v3Y1P9ZA0tiR4xFkF+e8=;
        b=mAj6/ja2AtSEh5yklYKMkNCZ3YmeeeR2Z+wa5kehRwtlzkLc+tKUi4Fx6fWJmEWnHQ
         Zm6X5fheGYOhQQZSqbLr2TCx/JwxsuTxrJkEJIhJ09LKHXquFgL6ncstRY6bcp5XgDdc
         tVfU0Od3BYcAOUjw6F89MDh9FF3bcrNgnEfrZGEWvLRNBDotJ3x2KKbt4Ur8xPAaRGY0
         GHuogzBnmQqwntRVzmRgLjgJCutTgudB1mM4rmHXPvtfjJkNXW/6hWx3Gk8B+s3Ceczn
         F1y5q2Ffiui9ZROno6+/8omjv9OnBD31I/zz5/0UsdXR9vSHDxhOyWTrS9w7R45nRFci
         LzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gX4JavC5r+wDie0MzJp42r8v3Y1P9ZA0tiR4xFkF+e8=;
        b=GwL38sRwKNpfcAk1HUAxClUPXz3Nv373dbul8MRleZq7FKYxxEXn0ZpBQqGB8uMc5R
         Dben9YEgDRILFtWel+3nPM1vppC+RE224c3wsnNyRjOKWueIFq0ZXX3lJ/RjTiR0OIT7
         3QxZMNAaCqZ12CDQ3mBu7L82OnBKGEcFgMlcE6kXHTcI4QMgmuFjFDA/+k8EEK/cYUxX
         xkaIO3uX5ARSvI/91AtMEbEmSDsZ1JWjUlBTvaB5iEHF7dI9jASj9uuPNG2DO1SgCOK+
         g2HVgfsa/dENqFdz1NjKBrn82uFfNLkka+o9qhpXHxUoQueGR4+/5WysyeqXWih7uYXz
         +Wcg==
X-Gm-Message-State: APt69E1T08mw8x82it8uxEKIPoQkRECZQrIxTrj90oE97N/mAtFb9259
        cGVESkm0+aDdQ5x4gzhTRvMolg==
X-Google-Smtp-Source: ADUXVKJ9TVTFBSbt0gCaDq7wd39wFHhr/vRxtsm72P2u/mfFhhdd9bjaJvEhc+uHzRvLikVrGctdyQ==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr2480187wme.159.1528401917257;
        Thu, 07 Jun 2018 13:05:17 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id i46-v6sm58394573wra.36.2018.06.07.13.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 13:05:16 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] usb: Replace empty define with do while
Date: Thu,  7 Jun 2018 20:05:11 +0000
Message-Id: <1528401911-5263-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dangerous to use empty code define.
Furthermore it lead to the following warning:
"suggest braces around empty body in an « else » statement"

So let's replace emptyness by "do {} while(0)"

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/host/ehci.h    | 2 +-
 drivers/usb/host/fotg210.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index c8e9a48e1d51..a60d91eac771 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -237,7 +237,7 @@ struct ehci_hcd {			/* one per controller */
 	struct ehci_stats	stats;
 #	define COUNT(x) ((x)++)
 #else
-#	define COUNT(x)
+#	define COUNT(x) do {} while (0)
 #endif
 
 	/* debug files */
diff --git a/drivers/usb/host/fotg210.h b/drivers/usb/host/fotg210.h
index 7fcd785c7bc8..dca46d04e288 100644
--- a/drivers/usb/host/fotg210.h
+++ b/drivers/usb/host/fotg210.h
@@ -179,7 +179,7 @@ struct fotg210_hcd {			/* one per controller */
 	struct fotg210_stats	stats;
 #	define COUNT(x) ((x)++)
 #else
-#	define COUNT(x)
+#	define COUNT(x) do {} while (0)
 #endif
 
 	/* debug files */
-- 
2.16.4

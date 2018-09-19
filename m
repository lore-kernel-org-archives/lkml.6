Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFD221522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AD4rNOUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EFD221522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeITB3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:29:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731211AbeITB3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:29:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so7033681wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo4j3UukUa9SkDMYYl/pGFxA3YY3EzpYaHWvoHWKYew=;
        b=AD4rNOUuqggZl8uYSjsJ10M5F43RLQqqbS01EoaAgr4ZIT4R0X/IZarvvrXu0osPRf
         FPyQiLFuW/bHp92BfQucGh1U0wp8rHKO6YmfIFqbxhYrYemXmgzhp92CxnoUqqoHdvHE
         fAuBtHLv+wIggVse0wDsVhRkvcV4ZUwrJyI7QrYblrc3h4/gVvbzo8Madasgjq7SGtfs
         JqXOZomjF5Ve7soJfMQuL+8GkaYc+9mYbo6p7FHItWOgMXM/fDz+yi6Qp2UjKZCpR22i
         3+barpYcAV7VFqOycLnbN5aDIVyLqGRqaFLU77wS4fM7Z0pFvvigh2UXZ2hqS24FjsJ0
         SMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bo4j3UukUa9SkDMYYl/pGFxA3YY3EzpYaHWvoHWKYew=;
        b=VaK+0CKJcDWGQWZxTHd082LVT5R8rBUTZSN98BnqDrqwsmnZ2TkHrkc60rA4mKyoZV
         uZrfp8U5+USA1EAXcMoW3tYOL0HYKJb4HdvnXKjqlOaQAfGUKPHvaYDfUpS86zRGpnha
         T57+0Uo+yQjRMTeZcQomd6FWNotexyW1wzmyPuFmRJC5Cz548ZjiWXFTiwG8Z1FGhJsX
         ZJUvbXtI5ARLpku1oPsEuJjiz4JQd0c4k6PtTOXUR8BROnEbq78Ef7NE5qJtkrghz0iE
         k5eND/LSav05a/+2wSCnyuKXsP6j3nbZx7eHaDY0n+vLvn7LZlQmF6wFyBKkWjUMXWx1
         xBtg==
X-Gm-Message-State: APzg51DwZtjAMsPdtd/72VUcz1PiDwQYZlLo9kR59puOq+UCq8BEdyU4
        lrLJDFR91EkcgpW9VjMIzNCBYA==
X-Google-Smtp-Source: ANB0VdZjKR/Bm1j/L66d03X3Qqmv3EcK3TV+MWKLbMkYXWpS9CKVhBpXB9pbwKnotWgPENaYkEUg+A==
X-Received: by 2002:a5d:404a:: with SMTP id w10-v6mr28358056wrp.147.1537386577336;
        Wed, 19 Sep 2018 12:49:37 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p11-v6sm23528047wrd.74.2018.09.19.12.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 12:49:36 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        joe@perches.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2] usb: host: Replace empty define with do while
Date:   Wed, 19 Sep 2018 19:48:53 +0000
Message-Id: <1537386533-22916-1-git-send-email-clabbe@baylibre.com>
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

Furthermore, as suggested by Joe Perches, rename the macro to INCR.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Changes since v1:
- rename the macro from COUNT to INCR

 drivers/usb/host/ehci-hcd.c    |  6 +++---
 drivers/usb/host/ehci-q.c      |  4 ++--
 drivers/usb/host/ehci-timer.c  |  2 +-
 drivers/usb/host/ehci.h        |  4 ++--
 drivers/usb/host/fotg210-hcd.c | 12 ++++++------
 drivers/usb/host/fotg210.h     |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 8608ac513fb7..64186cf59c33 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -730,9 +730,9 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 	/* normal [4.15.1.2] or error [4.15.1.1] completion */
 	if (likely ((status & (STS_INT|STS_ERR)) != 0)) {
 		if (likely ((status & STS_ERR) == 0))
-			COUNT (ehci->stats.normal);
+			INCR(ehci->stats.normal);
 		else
-			COUNT (ehci->stats.error);
+			INCR(ehci->stats.error);
 		bh = 1;
 	}
 
@@ -756,7 +756,7 @@ static irqreturn_t ehci_irq (struct usb_hcd *hcd)
 		if (cmd & CMD_IAAD)
 			ehci_dbg(ehci, "IAA with IAAD still set?\n");
 		if (ehci->iaa_in_progress)
-			COUNT(ehci->stats.iaa);
+			INCR(ehci->stats.iaa);
 		end_iaa_cycle(ehci);
 	}
 
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 327630405695..aa2f77f1506d 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -245,12 +245,12 @@ ehci_urb_done(struct ehci_hcd *ehci, struct urb *urb, int status)
 	}
 
 	if (unlikely(urb->unlinked)) {
-		COUNT(ehci->stats.unlink);
+		INCR(ehci->stats.unlink);
 	} else {
 		/* report non-error and short read status as zero */
 		if (status == -EINPROGRESS || status == -EREMOTEIO)
 			status = 0;
-		COUNT(ehci->stats.complete);
+		INCR(ehci->stats.complete);
 	}
 
 #ifdef EHCI_URB_TRACE
diff --git a/drivers/usb/host/ehci-timer.c b/drivers/usb/host/ehci-timer.c
index 4fcebda4b79d..a79c8ac0a55f 100644
--- a/drivers/usb/host/ehci-timer.c
+++ b/drivers/usb/host/ehci-timer.c
@@ -347,7 +347,7 @@ static void ehci_iaa_watchdog(struct ehci_hcd *ehci)
 	 */
 	status = ehci_readl(ehci, &ehci->regs->status);
 	if ((status & STS_IAA) || !(cmd & CMD_IAAD)) {
-		COUNT(ehci->stats.lost_iaa);
+		INCR(ehci->stats.lost_iaa);
 		ehci_writel(ehci, STS_IAA, &ehci->regs->status);
 	}
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index c8e9a48e1d51..ac5e967907d1 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -235,9 +235,9 @@ struct ehci_hcd {			/* one per controller */
 	/* irq statistics */
 #ifdef EHCI_STATS
 	struct ehci_stats	stats;
-#	define COUNT(x) ((x)++)
+#	define INCR(x) ((x)++)
 #else
-#	define COUNT(x)
+#	define INCR(x) do {} while (0)
 #endif
 
 	/* debug files */
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 058ff82ea789..de43d0d326bc 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -1286,7 +1286,7 @@ static void fotg210_iaa_watchdog(struct fotg210_hcd *fotg210)
 		 */
 		status = fotg210_readl(fotg210, &fotg210->regs->status);
 		if ((status & STS_IAA) || !(cmd & CMD_IAAD)) {
-			COUNT(fotg210->stats.lost_iaa);
+			INCR(fotg210->stats.lost_iaa);
 			fotg210_writel(fotg210, STS_IAA,
 					&fotg210->regs->status);
 		}
@@ -2205,12 +2205,12 @@ __acquires(fotg210->lock)
 	}
 
 	if (unlikely(urb->unlinked)) {
-		COUNT(fotg210->stats.unlink);
+		INCR(fotg210->stats.unlink);
 	} else {
 		/* report non-error and short read status as zero */
 		if (status == -EINPROGRESS || status == -EREMOTEIO)
 			status = 0;
-		COUNT(fotg210->stats.complete);
+		INCR(fotg210->stats.complete);
 	}
 
 #ifdef FOTG210_URB_TRACE
@@ -5154,9 +5154,9 @@ static irqreturn_t fotg210_irq(struct usb_hcd *hcd)
 	/* normal [4.15.1.2] or error [4.15.1.1] completion */
 	if (likely((status & (STS_INT|STS_ERR)) != 0)) {
 		if (likely((status & STS_ERR) == 0))
-			COUNT(fotg210->stats.normal);
+			INCR(fotg210->stats.normal);
 		else
-			COUNT(fotg210->stats.error);
+			INCR(fotg210->stats.error);
 		bh = 1;
 	}
 
@@ -5181,7 +5181,7 @@ static irqreturn_t fotg210_irq(struct usb_hcd *hcd)
 		if (cmd & CMD_IAAD)
 			fotg210_dbg(fotg210, "IAA with IAAD still set?\n");
 		if (fotg210->async_iaa) {
-			COUNT(fotg210->stats.iaa);
+			INCR(fotg210->stats.iaa);
 			end_unlink_async(fotg210);
 		} else
 			fotg210_dbg(fotg210, "IAA with nothing unlinked?\n");
diff --git a/drivers/usb/host/fotg210.h b/drivers/usb/host/fotg210.h
index 28f6467c0cbf..1b4db95e5c43 100644
--- a/drivers/usb/host/fotg210.h
+++ b/drivers/usb/host/fotg210.h
@@ -177,9 +177,9 @@ struct fotg210_hcd {			/* one per controller */
 	/* irq statistics */
 #ifdef FOTG210_STATS
 	struct fotg210_stats	stats;
-#	define COUNT(x) ((x)++)
+#	define INCR(x) ((x)++)
 #else
-#	define COUNT(x)
+#	define INCR(x) do {} while (0)
 #endif
 
 	/* silicon clock */
-- 
2.16.4


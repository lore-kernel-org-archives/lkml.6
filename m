Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6865C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C86520896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDXIfIIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C86520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756709AbeFOWBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:01:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35242 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756592AbeFOWBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:01:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id c22-v6so5472120pfi.2;
        Fri, 15 Jun 2018 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4uZyYgvrVDUhhzi40GfGKkKrXsTVo0f813Dr+ifEwR8=;
        b=HDXIfIIfOJzL/cprV/ByPW6lDsj7UGnLcwtR5OJdKfDufiPdH7PYwPu2A1FEor2qCI
         8n9etBLzElqyjtPHRtRsk+0S8k9dGYbS9EFQxjB1EwtpZ/3EboOGVf5vEcesuKkrMb5c
         yMQVivTomTN8JOvsl86hb9PHuHF2qqeFtWn8qS/OhHkR2OiehXTWpbA0tzCxk96nIdzM
         T5Z0q8cw/fKiBKFX/lXVHheHVu5duvBRXmuvdtavOPayCTlDpHknrDIrcrvl7qSmawcO
         2t0jkkQlQGoF+GyX2D1pK2fOiP+FBRJF8Ch+9raq93OQUerNwOzmP3OTpIIxYVi64Mw4
         Gehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4uZyYgvrVDUhhzi40GfGKkKrXsTVo0f813Dr+ifEwR8=;
        b=kDpCwhQiLuC3M3rauVKpuQ+Sn83H5CzAxNa+INS+veMidkSoNZUDZ1z8PUBQ191Jj6
         70QlLG9Bo4jverOM3MYuGFfgub7tYdBUZl7ZsGJtrQlI/XYXYlr4cccyNjT5I9h+8Hnn
         nS8+OL5hcy06g9TTP8VbCSMXcuAuK6oEUXOavgOPkp/3UdOkfkOHS+2aIYSaftQ1H1xr
         eAfOisFxaJmDcTl0FirRYsgug0LktYU7OPCnla/z0tbhiqVjftLxSdZUCumWTg+YJbgu
         +aMiJrwcCXYzYlm0x5MF3ZBWVymMfpIuihk9lieFJpFuCSGBjT7Sp9d+tqUNlXkAr4uT
         vUUw==
X-Gm-Message-State: APt69E2oeyPBPfOEeqqUqL67iSk52Y4rqajv8MkPHeeyhU50vV3C0f+n
        l5WLsXZN0rlYCg8VDD6KUyk=
X-Google-Smtp-Source: ADUXVKJ9TIEmdFEkW3lM9R24dxIo8RdZC1G4oAPJ+I0hF1dUKqidGheSKo6D+YQiQl20VDhx/z9OpQ==
X-Received: by 2002:a65:6343:: with SMTP id p3-v6mr3174979pgv.63.1529100095808;
        Fri, 15 Jun 2018 15:01:35 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id b83-v6sm20233241pfe.159.2018.06.15.15.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 15:01:34 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: dwc2: host: do not delay retries for CONTROL IN transfers
Date:   Fri, 15 Jun 2018 15:01:29 -0700
Message-Id: <20180615220131.65402-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handling split transactions we will try to delay retry after
getting a NAK from the device. This works well for BULK transfers that
can be polled for essentially forever. Unfortunately, on slower systems
at boot time, when the kernel is busy enumerating all the devices (USB
or not), we issue a bunch of control requests (reading device
descriptors, etc). If we get a NAK for the IN part of the control
request and delay retry for too long (because the system is busy), we
may confuse the device when we finally get to reissue SSPLIT/CSPLIT IN
and the device will respond with STALL. As a result we end up with
failure to get device descriptor and will fail to enumerate the device:

[    3.428801] usb 2-1.2.1: new full-speed USB device number 9 using dwc2
[    3.508576] usb 2-1.2.1: device descriptor read/8, error -32
[    3.699150] usb 2-1.2.1: device descriptor read/8, error -32
[    3.891653] usb 2-1.2.1: new full-speed USB device number 10 using dwc2
[    3.968859] usb 2-1.2.1: device descriptor read/8, error -32
...

Let's not delay retries of split CONTROL IN transfers, as this allows us
to reliably enumerate devices at boot time.

Fixes 38d2b5fb75c1 ("usb: dwc2: host: Don't retry NAKed transactions right away")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/dwc2/hcd_intr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index a5dfd9d8bd9a2..d423b6a49f96c 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -1212,7 +1212,10 @@ static void dwc2_hc_nak_intr(struct dwc2_hsotg *hsotg,
 	 * avoid interrupt storms we'll wait before retrying if we've got
 	 * several NAKs. If we didn't do this we'd retry directly from the
 	 * interrupt handler and could end up quickly getting another
-	 * interrupt (another NAK), which we'd retry.
+	 * interrupt (another NAK), which we'd retry. Note that we do not
+	 * delay retries for IN parts of control requests, as those are expected
+	 * to complete fairly quickly, and if we delay them we risk confusing
+	 * the device and cause it issue STALL.
 	 *
 	 * Note that in DMA mode software only gets involved to re-send NAKed
 	 * transfers for split transactions, so we only need to apply this
@@ -1225,7 +1228,9 @@ static void dwc2_hc_nak_intr(struct dwc2_hsotg *hsotg,
 			qtd->error_count = 0;
 		qtd->complete_split = 0;
 		qtd->num_naks++;
-		qtd->qh->want_wait = qtd->num_naks >= DWC2_NAKS_BEFORE_DELAY;
+		qtd->qh->want_wait = qtd->num_naks >= DWC2_NAKS_BEFORE_DELAY &&
+				!(chan->ep_type == USB_ENDPOINT_XFER_CONTROL &&
+				  chan->ep_is_in);
 		dwc2_halt_channel(hsotg, chan, qtd, DWC2_HC_XFER_NAK);
 		goto handle_nak_done;
 	}
-- 
2.18.0.rc1.244.gcf134e6275-goog


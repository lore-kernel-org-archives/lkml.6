Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8620858
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2XfjQmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D8620858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeGTEgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42463 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeGTEgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id y4-v6so5609418pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bCg8UsGV6aNVlTYOKQwHQHZXXvhtfFcoKJs1IsSv0wo=;
        b=Z2XfjQmgbsDZIAWkQUqVglliosSStlLuMoC2pWp/AB7tp/ejaDSgeO6PBkO8girblf
         70frS86/PSMFWViWQfLrWOysQCjoRhmAz1xLpuV6as4Q8fPMW2QMg65MrS5EW0bWNRAr
         u7G4C0kJMcVgEChaRoOnQmb5IrC06UBAIMWXHT/eIqi/KNi/a3KbZ9o0PORoP5LppxcB
         nSXGL1ggfwBbk/zMu0qqwtumoQNiIz6PORuolGTHinSFL4+D5guxy93Pbv0qbGh6QXZW
         An+IvN6PLyIeCzWHN6nqVfPBHoIzQaZrsqcP18q+0jWUxkeK1O7X+MpYv/js+gFBzYtA
         qoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bCg8UsGV6aNVlTYOKQwHQHZXXvhtfFcoKJs1IsSv0wo=;
        b=b4KzDQmrVJg5RVnJEMcMQQxjCmBjdZN/2hTX2CjNwKUhcNBZI4DHah2gw6IVC0WOvS
         roVn9u92tuXe/6XRkjmTMRgbFo0J+MFgbHWeVpyrPtbQnDc3c44bBvTB179vgXbo77jF
         erj/udrdOZF23G4EQRsIYJNCT3weg/HzD0T0lt8epfP+WZrELAc1+PR0OAltf2HM1Z1L
         kAofE3BATxZ+IImZA17aUBAyMIWQpLTwU8/6muSBPpxI4uC+bCfgKz2wrrkisHmAFbpr
         bF2Dywy57rrKJbB46iJdOhep2/mQoNJTuAQ+0aDuGCvM2rG32W2J+eRK2SU8FWL+0xtB
         mKqQ==
X-Gm-Message-State: AOUpUlEapaTZrDZFrQZaqsoh3jydIrF/sIuVYNO5Gg2XLSf2fnSPNFI5
        W44rqh1T/hyvCdRqK18OE0E=
X-Google-Smtp-Source: AAOMgpdbxC0AqOaedIU8thfsIGLKjn4svPAbaDBaae32UaxlVlAeZVzQS+GswzlMF8j4M6mJRUbR3Q==
X-Received: by 2002:a62:1a4a:: with SMTP id a71-v6mr473764pfa.190.1532058602555;
        Thu, 19 Jul 2018 20:50:02 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:50:02 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/20] staging: gasket: remove extra parens in gasket_write_mappable_regions
Date:   Thu, 19 Jul 2018 20:49:14 -0700
Message-Id: <20180720034920.77320-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove unneeded parentheses around subexpressions.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index ae5febec8844c..ba48a379b0ada 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1889,7 +1889,7 @@ static ssize_t gasket_write_mappable_regions(
 	if (bar_desc.permissions == GASKET_NOMAP)
 		return 0;
 	for (i = 0;
-	     (i < bar_desc.num_mappable_regions) && (total_written < PAGE_SIZE);
+	     i < bar_desc.num_mappable_regions && total_written < PAGE_SIZE;
 	     i++) {
 		min_addr = bar_desc.mappable_regions[i].start -
 			   driver_desc->legacy_mmap_address_offset;
-- 
2.18.0.233.g985f88cf7e-goog


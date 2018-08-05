Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82134C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A20E218DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEoXBCol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A20E218DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeHEWOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38616 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbeHEWOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:21 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so4716965plq.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ft3BztATCb2tXPIomIoUc3e6+ITvre+280iAc9l2Vs=;
        b=pEoXBColXPHgS99InGq0Rh4nZJnah1b011IpwCu0ELkY20LrNaBcV4sGv+zIoALBW7
         qqetjCDL/7UGmSLwH3+Sxxe3S7RZgdr4jJUgdvDxLX/XdxQvP36pjGoPdpNlb6mmOix0
         /pqkup70lfZurny3dcBtG38ibsjNcszn5i4Noa4oOQs899OItnUnEv+HOyH4xF2DSdGl
         E7QCSp6rSYYy5oTpcs3jlxLxe1hP/nBSjdeU/gmRzkJL+5pclFBXw/qChagzAu+R79vO
         PFgILzUP/jhDpx4b4GszWg0zehFktuheYCKWi5jUbU2ZJDoZB6yih0K6p5PFOjQMx80R
         4U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ft3BztATCb2tXPIomIoUc3e6+ITvre+280iAc9l2Vs=;
        b=MIZF8JE4iK637dV1vloANX8KXmqYU1TZz0Xm1W6PTAyLmbzxJnSlqObgBUEkQdUBig
         VOga2ogmoHrqEgIs8YBhe0crkc8JIRSjG8NRfhnOJj2p42uf+EXA/FgHD05UUvezyo8d
         AvE7BHS1i5Bpf3PN3ffJnCIRXnt4Bal09jIOSqLGamb9C00xAibaUqLUQbmnuoyP506B
         zjUEdrV24SBis1LOWbyaNLgmBkMrVmS9/BEbZL4FAlubRUycppQRTdZsLvBSzaK4mQ0/
         EBrQcmgEQ5OGvB+x8B+0R3RgMs8Iw9q0ShG9325y/HIuGr7+I4NV39JP+fvYkISbsuM3
         NKGQ==
X-Gm-Message-State: AOUpUlFycFpMp4u49pQElf7S/7m9g+SDhJDCOoluSJt8AXQlquCAnxAJ
        Q+cRtwYcCNIQ9NQPMGeAIEo=
X-Google-Smtp-Source: AAOMgpc0SXSQTxfgoysFZMachxG5amF8FXnf6w7oGT2PMUenQpdlnuIgnvkZyZOVvpCYUIp0PCE6NQ==
X-Received: by 2002:a17:902:290a:: with SMTP id g10-v6mr11403783plb.110.1533499716980;
        Sun, 05 Aug 2018 13:08:36 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:36 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 14/15] staging: gasket: apex: place in low power reset until opened
Date:   Sun,  5 Aug 2018 13:07:48 -0700
Message-Id: <20180805200749.116693-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The apex device is left out of reset mode at the end of device
probe/initialize processing.  Add a call to enter reset at the end of
the sequence, triggering power gating and other low power features.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 55319619b2e66..c747e9ca45186 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -644,6 +644,10 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 		goto remove_device;
 	}
 
+	/* Place device in low power mode until opened */
+	if (allow_power_save)
+		apex_enter_reset(gasket_dev);
+
 	return 0;
 
 remove_device:
-- 
2.18.0.597.ga71716f1ad-goog


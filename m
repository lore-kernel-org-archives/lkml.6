Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tEMuCeIrGlurJAAAmS7hNA
	; Fri, 08 Jun 2018 07:11:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85B6B607E4; Fri,  8 Jun 2018 07:11:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gODOUihy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB42A606FA;
	Fri,  8 Jun 2018 07:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB42A606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeFHHLw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:11:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41083 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeFHHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:11:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id az12-v6so7744864plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8jAQmTuGvAX+EIfu45cbzVZ46i/vDGVTiU+n/4q2ACE=;
        b=gODOUihyYvnFgbfb4ViIFYxA6u59yecXX99beK4saeMNqG9fKnjt7BSGo+3Woaigz2
         9G9KtH0hUV/+WFP/MWyiQu1ku3IRo5bOThWplRx9+U2jnUDmTsJ9/pZkdOrPMS07S2AQ
         vrgRhdxVjlSM1j3kx7fj3+O/T1WTpAQs3KyNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jAQmTuGvAX+EIfu45cbzVZ46i/vDGVTiU+n/4q2ACE=;
        b=bkP2A5XZ/HDo0H8+Gu49StQJWq8mn0DZxX69S124MicFzlMjP5P+z1wcEtvW05x90d
         rfY8viwj0hDhAeXvviCPVxH65UYFb8KIwBVD6Tw3znHIKOBTEgWFG3NPq052APRmS2uB
         waQ7uNXTus3QM3y/kjwyINBTsL42VuoudMxUMQVy65uo0SW44xFVwhOUVKLNMKOm2wwP
         c3s19MGJuuonzleh2JoXSn21V1Hc9MawavcAKmI83sy5JKUa5ZZNEmIzDQm6RuOJf1uJ
         SEaY8NZTIb7VRHEVf5FoJH7iM8MZuvysCUBfeXI1WAndxpfN4KvvVt3K8pgp5jGD+fs0
         geQw==
X-Gm-Message-State: APt69E1UkcAGufn9puP8rX6fmDPuSgGkyL738pHhpjXTm06Zp/LwwY8W
        lNEG9loTEK1fEwzjM3aPmib+dA==
X-Google-Smtp-Source: ADUXVKISNaQ+RYgnsP1sl8ohRVYdvqKMaJdXLrJHmi3JY82kqU/8MENrkrM3987WpqbRG+Yob2rs1A==
X-Received: by 2002:a17:902:22a:: with SMTP id 39-v6mr5272387plc.146.1528441910951;
        Fri, 08 Jun 2018 00:11:50 -0700 (PDT)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:3987:9bf6:3352:7574])
        by smtp.gmail.com with ESMTPSA id a27-v6sm15421764pfc.18.2018.06.08.00.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 00:11:50 -0700 (PDT)
From: Louis Collard <louiscollard@chromium.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH] tpm: Allow tpm_tis drivers to set hwrng quality.
Date: Fri,  8 Jun 2018 15:11:46 +0800
Message-Id: <20180608071146.110567-1-louiscollard@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds plumbing required for drivers based on tpm_tis to set hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
 drivers/char/tpm/tpm_tis_core.c | 2 ++
 drivers/char/tpm/tpm_tis_core.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 8b46aaa9e049..d2345d9fd7b5 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -875,6 +875,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
 
+	chip->hwrng.quality = priv->rng_quality;
+
 	/* Maximum timeouts */
 	chip->timeout_a = msecs_to_jiffies(TIS_TIMEOUT_A_MAX);
 	chip->timeout_b = msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index f6e1dbe212a7..f48125f1e6e0 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -99,6 +99,7 @@ struct tpm_tis_data {
 	wait_queue_head_t int_queue;
 	wait_queue_head_t read_queue;
 	const struct tpm_tis_phy_ops *phy_ops;
+	unsigned short rng_quality;
 };
 
 struct tpm_tis_phy_ops {
-- 
2.13.5

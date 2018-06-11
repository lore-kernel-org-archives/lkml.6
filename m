Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id k93JNjNkHlvHYgAAmS7hNA
	; Mon, 11 Jun 2018 12:00:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3AE7660850; Mon, 11 Jun 2018 12:00:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9k9jdh+"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AB9B0601C3;
	Mon, 11 Jun 2018 12:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB9B0601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeFKMAv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 08:00:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41088 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933375AbeFKL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so20091516wrq.8;
        Mon, 11 Jun 2018 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPpkHioiUkdTpuMosTtHDEBffKev/EMboTnmzRCdZ68=;
        b=H9k9jdh+dGXn7a7F1jeeDmxVaKBtNOSR2QF/Qu8ptwWL3tfJMRak5Dha44G7nAEtKQ
         W4YTSdQVuouih36opjlwjBbQ/0nJOaCAcA5weLnLs75ZYEOUd2erGTAUSgPO5x0snLne
         F/iymMM2VcA/RdsLMSM3ITKqF+EW991xrQ3kDZ3nbtk5bf2RXXNraSyGM6lcyfpdtUjm
         OBPs8UfNULTdUjOSqybmk5EZqHl0BchDv/41aSNyRDi0cIc/uoP3H9/85xS34sfbv0fX
         3nrtT5XeNDQZ9vdQduukPDXqdV5cWv+OWN9ojHAcxDvy7e7eqoQ2Xam5EpZYt1h1sxS2
         OBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPpkHioiUkdTpuMosTtHDEBffKev/EMboTnmzRCdZ68=;
        b=tMnh3W5eozhC3ZFDxrJl53O1l4okEvZZtOwuGAYNdBhBsfbWXlASNxTvicrGdAppEs
         SlXvoSE3f7Cp0u9yUmQfFlbBr+7MtyjqsfOY90EouNs9ReoXEtpNnr1mJ6vvyWyBlbhs
         ZZa158wTZ/csQ9JZljFhYivTJAwXM5Bz8/TXagTcYRAmSyGhLMLm6b7S+XTH+JwgUX1d
         h1MB2+MCY/7Ewk1Es4zbgEArRf8tcoGBJL2BAU5gOvQ9WYeYVaZLnwSpFoAE8NPNUDZ9
         RcKBLuT66Dv43zFxqe/+QEo28+5RanQmVmXmja0uA/YVb2KNYCXK/1RIsbJjjMxQ0mjd
         510g==
X-Gm-Message-State: APt69E1EDaTqZUM1SubKrt5Pj42rZ4EcXif0zSJqRoRcdNhHyeeQ+Reu
        utbw9TN1cCjcbKZRj86d+Jqyk/8p
X-Google-Smtp-Source: ADUXVKI+SBlA7iAmRe3N3GTxYIpC4YWNSh6H37rWMLDkJgKcwOKBtYSmO7dZzaSE7anJ3z07+70vwg==
X-Received: by 2002:adf:9441:: with SMTP id 59-v6mr12026953wrq.274.1528718355122;
        Mon, 11 Jun 2018 04:59:15 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:14 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 09/14] mfd: da9063: Add DA9063L type
Date: Mon, 11 Jun 2018 13:58:46 +0200
Message-Id: <20180611115851.1987-9-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add type for DA9063L, which is a reduced variant of the DA9063
without RTC block and with less regulators.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
V6: No change
---
 include/linux/mfd/da9063/core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 9e36097adc42..71b09154e2db 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -33,6 +33,7 @@
 
 enum da9063_type {
 	PMIC_TYPE_DA9063 = 0,
+	PMIC_TYPE_DA9063L,
 };
 
 enum da9063_variant_codes {
-- 
2.16.2

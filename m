Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A46C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D662214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Eo3DyDfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D662214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbeKPIvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:51:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50348 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPIvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:51:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so20444959wmw.0;
        Thu, 15 Nov 2018 14:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1OnMjerHobgxeRKJqmEmHVjTlKqDa43MFe3VfFeUNA=;
        b=Eo3DyDfAUUClIgS3T9isr4frWLqyrNYCZ3u9sqvGgS78wGuCJQ0iVnxcpEwpvcXCUt
         MAxkSLGjzchwLIDSDIbGbVafUkJD7OKIqBpfU9fCSEPyj+tgHi56vcChIk6aYnNfRL18
         KK+psZw0dUc5FOBb6qQpWIP0qGeda/DJzkIYW1JnK2r5W1OPoEpmROcjunOXv4PXjfiU
         AFv5n1yvljcOe6MMQRtMjRcSISGiY8DBTqbNgutCU/nn6s5tRCDf+kynDOsmqsmyVGyX
         tYMwZ5hq3kk07DJhP4FO+TVIFQJxqTkAM9X7NLu593mPxpnBIszfVwmFv8kfZUp7vfyX
         Y25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1OnMjerHobgxeRKJqmEmHVjTlKqDa43MFe3VfFeUNA=;
        b=s85dNpex7TmKhBKfMJHRQ3aGyczDZyzhFX8TORuSK93H9VuvQe1h10TXhY034ETbgM
         cptEXuM33axRNDZWcGa2dx+89scYtiPeZUuhyeiWjfeRkye/nfEBAsdVWtaUpKGDNcUd
         a53arOAwvXZZRpBlbI66AHr8taEjzxdYlmF0g1WMGrapJiF7hMu3Nrg47HzeD161YVrC
         vpx6QtvmWqWgQtfnVNAS4BWPhAC4QEOj23oiKJN82hGbRw4E0qLVcU511u9zpcBVr23w
         ytiq2Ofj1NIW+XTWqGbfN2IkmZzsDm/K8TRb8VrTk6tOqoPgMTZJ81e7TAusynao7QR8
         yixw==
X-Gm-Message-State: AGRZ1gIb4nCiTnJ712YpOOZtGghV2qVIobuS1B2rzjaHO3e3+d4fVcSM
        Omz1/2VnKEBlidkK+ZtK4T0=
X-Google-Smtp-Source: AJdET5d+RuTFE5gNqRCuFYp4DNf62o0rc6lVciTY5Nxsgcfi1MaxXIzfiSEcItssW9iRHGdd6hMfpA==
X-Received: by 2002:a1c:1792:: with SMTP id 140-v6mr614417wmx.117.1542321680273;
        Thu, 15 Nov 2018 14:41:20 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x12sm2076388wmc.37.2018.11.15.14.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:41:19 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/6] clk: meson: meson8b: add support for more M/N values in sys_pll
Date:   Thu, 15 Nov 2018 23:40:46 +0100
Message-Id: <20181115224048.13511-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
References: <20181115224048.13511-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_pll on the EC-100 board is configured to 1584MHz at boot
(either by u-boot, firmware or chip defaults). This is achieved by using
M = 66, N = 1 (24MHz * 66 / 1).
At boot the CPU clock is running off sys_pll divided by 2 which results
in 792MHz. Thus M = 66 is considered to be a "safe" value for Meson8b.

To achieve 1608MHz (one of the CPU OPPs on Meson8 and Meson8m2) we need
M = 67, N = 1. I ran "stress --cpu 4" while infinitely cycling through
all available frequencies on my Meson8m2 board and could not spot any
issues with this setting (after ~12 hours of running this).

On Meson8, Meson8b and Meson8m2 we also want to be able to use 408MHz
and 816MHz CPU frequencies. These can be achieved by dividing sys_pll by
4 (for 408MHz) or 2 (for 816MHz). That means that sys_pll has to run at
1632MHz which can be generated using M = 68, N = 1.
Similarily we also want to be able to use 1008MHz as CPU frequency. This
means that sys_pll has to run either at 1008MHz or 2016MHz. The former
would result in an M value of 42, which is lower than the smallest value
used by the 3.10 GPL kernel sources from Amlogic (50 is the lower limit
there). Thus we need to run sys_pll at 2016MHz which can ge generated
using M = 84, N = 1.
I tested M = 68 and M = 84 on my Meson8b Odroid-C1 and my Meson8m2 board
by running "stress --cpu 4" while infinitely cycling thorugh all
available frequencies. I could not spot any issues after ~12 hours of
running this.

Amlogic's 3.10 GPL kernel sources have more M/N combinations. I did not
add them yet because M = 74 (to achieve close to 1800MHz on Meson8) and
M = 82 (to achieve close to 1992MHz on Meson8 as well) caused my
Meson8m2 board to hang randomly. It's not clear why this is (for example
because the board's voltage regulator design is bad, some missing bits
for these values in our clk-pll driver, etc.). Thus the following M
values from the Amlogic 3.10 GPL kernel sources are skipped as of now:
69, 70, 71, 72, 73, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 41a5025364f9..b07a92ed7de3 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -43,6 +43,11 @@ static const struct pll_params_table sys_pll_params_table[] = {
 	PLL_PARAMS(62, 1),
 	PLL_PARAMS(63, 1),
 	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(67, 1),
+	PLL_PARAMS(68, 1),
+	PLL_PARAMS(84, 1),
 	{ /* sentinel */ },
 };
 
-- 
2.19.1


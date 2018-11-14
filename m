Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2627AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53362175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DQNvAzeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53362175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeKOJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42472 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id u5-v6so13828872wrn.9;
        Wed, 14 Nov 2018 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdbHJpWfnE4dGFR/ow//dClXtqW/EtX9HERAF4Q8i2I=;
        b=DQNvAzeGWkDxCVEsx+IXCEhNio/mPxQMG97/B+xXkSL7iRylj5EJqHMfE5L/l79LEI
         BYH+tJT/xmTKXKwTaqnvryiD1pjpVGn11HL8UA95kXKbEFaCr2bkIRvSV/IFnOFpexfy
         Ttm7BWgf8zqcc1Q4sGgDHARksHcPqUf98oY7iWDICv1GWKNU/iRJwfHcdUEk+DAQ3+oY
         V1XWGoBar70LN7gKrxrDW0s34qDuNImNBCcLJzEa/2+6h4cgMu26vdyFv09WrfDs5cRy
         Z2a2e7QxqOac41BXUaaF6ZTE0aVBIp8mBygWXneOUdDQDD60yKR90biJSg6SDQg/97Ws
         LTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdbHJpWfnE4dGFR/ow//dClXtqW/EtX9HERAF4Q8i2I=;
        b=VOFnZfkKFKg4Xic8zPadwrTkKONOdpbkT3b38oenc+GODhW8x9csTrpvjGAHsfkwqE
         zhtz0K3tsoWrJXHgFtJ5TYhHxNwEjhkEl/OG8K+NqtPf6KhFgWoQJ1Szb20URx50yuMT
         QC7b34zuIP3/3zMd0xMZCdNaOs2eDYP7hXjzIcF+zQ7j6mE1V2R+bfOJEcik/vC5mq49
         TLQ70UN2Tc8FwHkP+aACZ9Pm4oiTvTaIKQrPxBxWAx7oFkckBk/UAJdsa87pkzy4jsvR
         nsHJfBiXOaNSxoDWQYuj/apVTS7TergN4PPZ9A+t5sQfBtdllOvPlF+PZchdNziIHwkT
         e+1Q==
X-Gm-Message-State: AGRZ1gJzJPI+pZVhH/nYW2VUbDRhBciLZ8B3FroKQ32M/Jmno3emgmvg
        gUVrLaoz4DepH0ACdWuh+IB/Qo3/
X-Google-Smtp-Source: AJdET5db3Eo5Ii1AFuVT0vAIGJ2PQTwq1hpyQmM9c7jYQnz+74k5zml2zBkq5Sh0E2c6Y4bUaOS5Zw==
X-Received: by 2002:a5d:6684:: with SMTP id l4mr3952933wru.154.1542236277466;
        Wed, 14 Nov 2018 14:57:57 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 6/7] clk: meson: meson8b: add support for more M/N values in sys_pll
Date:   Wed, 14 Nov 2018 23:57:24 +0100
Message-Id: <20181114225725.2821-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
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
---
 drivers/clk/meson/meson8b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index d566dd5bc567..c06a1a7faa4c 100644
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


Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146BAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2D120881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSm1rIGl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfA1SeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:34:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34671 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfA1Sdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:33:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id f7so19308335wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
        b=jSm1rIGlQyTPja2+ldYbXDr+A1YqBNWmTeaDsPGMl7TadS2uye65vk+lYjGr8Yox3F
         80uPZnH1mldfRsnbu+xQwdKYVWUR16/oHBEGlzc1Ck4LcODmicjYbz0BPrPxx7pAYW7i
         UdjwgF9oGxKzZb573jtPHKtsEE2WYnR1uGpxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
        b=YicE8+GuqgpUy4yu3OMnZApWiCIC0EBkcAADlT2qIRpS0/kcUtZ0w7sT2BEyOZznYM
         b7xSfCWkagY2uasXZVorpDeb+Php9D0ohKBgyWt8OQlo59soh+T6oLj+xUzWW6F/Fu+V
         WXbb8UbkgpNh4iOkkSnkJvXDdtooTiACisHk1CA6WGSRm8Dq9BSq4ZlH/ziMxSJSN8D8
         CiDvLF5iRSS/S/bgoJQj8wVgfnRyeBLAR5L4VxYthqacLh3DkdmPAvV+ypY1p7ektfZb
         KQjjYRxV64x1xNyCKcWIsP/OizNUiFgmkDdRqursJSSIuNTWnwwdnm2d0r26SlV2Gb2C
         qGbw==
X-Gm-Message-State: AJcUukcD0/B+oOdrdNqBBtB04YXyNNaBOrfC/zmM1xF7mN0XdD3G0pJF
        F47vfDgC9wIPAphg5rfbS7+ctw==
X-Google-Smtp-Source: ALg8bN56Btc4EmKhRmzfolsJuEPhFqCUgA9Tle2qQgKO/izjpdp9h32ZsM+121WwJEPOwl4jYwVVBQ==
X-Received: by 2002:a5d:6808:: with SMTP id w8mr22035898wru.270.1548700410592;
        Mon, 28 Jan 2019 10:33:30 -0800 (PST)
Received: from localhost.localdomain (233.red-81-47-145.staticip.rima-tde.net. [81.47.145.233])
        by smtp.gmail.com with ESMTPSA id l19sm270082wme.21.2019.01.28.10.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 10:33:29 -0800 (PST)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v2 08/14] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Date:   Mon, 28 Jan 2019 19:32:55 +0100
Message-Id: <1548700381-22376-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
to keep the software model of the clock in line with reality, the
framework transverses the clock tree and disables those clocks that
were enabled by the firmware but have not been enabled by any device
driver.

If CPUFREQ is enabled, early during the system boot, it might attempt
to change the CPU frequency ("set_rate"). If the HFPLL is selected as
a provider, it will then change the rate for this clock.

As boot continues, clk_disable_unused_subtree will run. Since it wont
find a valid counter (enable_count) for a clock that is actually
enabled it will attempt to disable it which will cause the CPU to
stop. Notice that in this driver, calls to check whether the clock is
enabled are routed via the is_enabled callback which queries the
hardware.

The following commit, rather than marking the clock critical and
forcing the clock to be always enabled, addresses the above scenario
making sure the clock is not disabled but it continues to rely on the
firmware to enable the clock.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 0ffed0d..9d92f5d 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
 	};
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
-- 
2.7.4


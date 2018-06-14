Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1A4EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A668F208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq33kkoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A668F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965020AbeFNVzf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:55:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46270 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964907AbeFNVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:55:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so7914556wrp.13;
        Thu, 14 Jun 2018 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7oy/PpN2lfqXCp6xvaoXyWxkxv3vHGUHRhCD4XihcPc=;
        b=bq33kkoTNjB6qRIg4bQtbTXI6s2lfwfMwt31I4ubOKBfIruq+PXPS7Ry/vP1hdK1Zh
         +Nj4g/TFhoWVGBw+R/LYJ3lZlzrFmLm29k/9cdJCMiA0bG130RShgk6mfjKkV6lsuqJJ
         yZ2RNikTj7bA9lpK0X26KoB9PhN8ha6mcEt7atdIzQJlbhEt8D81Gxq8ZhS5sWls0yux
         ia2wkeFxNdiwLKS+Nw/HZUTsFfOpTtNAL8SmBNnUx/jjW8WVrQxO7zXKAAfOhmzRoCyc
         jdAFkJieNgqoerR9qQVYdfyHHxGwLQHXQ4QC3D7XAO/gAblhttxdUZeq0q5h4y7gLS/F
         XTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7oy/PpN2lfqXCp6xvaoXyWxkxv3vHGUHRhCD4XihcPc=;
        b=LWbPXy/iZibwjI+gSncJBJzylYyx8tjz4r+zVjQPiidIhXsAVjbOdai7xBSZvoabRo
         glrbW27mQU6n/692vhS/N7k3O99pxyXempppY8MDMxSIStE2vdkqumRk+CWDo8cH3xB+
         YpmAj6IRRexcRntGeyHY8UH1UTnkbo2nvwlWOWGTCLRtenC0frOI9A/DC0PkO6c17Ex9
         J2GqbfmOHn25ivOah9qKTtOshWpAJeOwgsnYjQ/jP9lZ1HTwsayFWY9iW3x8fYESheQD
         zpLlhpZa+wTfyfkYR6BolE/fpuNIi32AcEUoUK2mlTEooiJZ17dvKZDKHhD4s55VSp+T
         t//w==
X-Gm-Message-State: APt69E14tPqsjHInS91vD5bGOFrSlKUv0NP+OyNIL5yW7Xg5CaouRCoC
        KZKE5G7sWK0qz/j24KhxCZA=
X-Google-Smtp-Source: ADUXVKKgmm7CtIEVtjdCbtktPE4qe3CtPKW92Etxy3dzBP9njy1UtE3yLhj2c8r1KJ9PP3egX710CA==
X-Received: by 2002:adf:f482:: with SMTP id l2-v6mr3936698wro.259.1529013320274;
        Thu, 14 Jun 2018 14:55:20 -0700 (PDT)
Received: from gcc67.tetaneutral.net (gcc67.tetaneutral.net. [2a03:7220:8080:c00::1])
        by smtp.gmail.com with ESMTPSA id i76-v6sm285367wmd.20.2018.06.14.14.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 14:55:19 -0700 (PDT)
From:   ilia.lin@gmail.com
To:     ilia.lin@gmail.com
Cc:     Ilia Lin <ilialin@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 3/8] clk: Use devm_ in the register fixed factor clock
Date:   Thu, 14 Jun 2018 23:53:50 +0200
Message-Id: <20180614215358.11264-4-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614215358.11264-1-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilialin@codeaurora.org>

Use devm_clk_hw_register instead of clk_hw_register
to simplify the usage of this API. This way drivers that call
the clk_hw_register_fixed_factor won't need to maintain
a data structure for further cleanup.

Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/clk-fixed-factor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index a5d402de5584..8e39bda8e596 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -94,7 +94,7 @@ struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 	init.num_parents = 1;
 
 	hw = &fix->hw;
-	ret = clk_hw_register(dev, hw);
+	ret = devm_clk_hw_register(dev, hw);
 	if (ret) {
 		kfree(fix);
 		hw = ERR_PTR(ret);
-- 
2.11.0


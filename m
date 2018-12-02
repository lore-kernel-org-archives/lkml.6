Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E3620892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ibV/6RgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E3620892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbeLBVml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:42:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40819 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeLBVmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:42:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so3747197wmf.5;
        Sun, 02 Dec 2018 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqOVMr4edQpgQLfHsL+QrU5eXVARfT4qWY4Nu0+S58o=;
        b=ibV/6RgBPygN9/wXDAsvGRvQCXxJjyebVpu90yF+z5InzkKNsTtOAsM+H5YQhrWop1
         wAj8nuuM+Utxx3YmXZFIUN8DTm3UFQIfYF3BCXEyE9XrujjWWelb9lviIJm0+zdN4ZXK
         2rrPaP37b2dIzu2CkYrCm9HcKLFYxS02X6R7GEWllc+QcpAhA9SYmXA28SgYRSbhk+6P
         9QlkTBAlfyPt6pXH+khTxEa91dpzynKHRjmP8/nu4EbpWjou7umYjIv7vhnLntEbdm1U
         QXtTsJJbYK5NtJGpMiClhPiui14GDMUzTFoBtLykrwRBsY6Yz41CFS5ADVUQW3+5bDnN
         Jl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqOVMr4edQpgQLfHsL+QrU5eXVARfT4qWY4Nu0+S58o=;
        b=Hp/19BsPPs4SSMArNRf3nsYKZKkvp9+4kfa0ZOZoCFGLVv0+skvdYF4lx9gOVIFTtP
         IHcofTB2eVSNhDCWH/SkNMW7xm+abcyhblidH6dzEQTyuDW09EJ9GnR7FKiQcCAyn1A0
         HOEXPDuKfUrmtiTqyfoquoIjRERCFdjweWODIPUFAqP8s5cWgaUYuS0MrkkmmHTJz1gm
         p3Is/Oc6cL+63nDCOYM7UYtOj/8stV019luORUwcFGxbN3bcdoNOip5uui61IsNQALWp
         OkryehmtzDahw9fS038b2k8H/FLiU7O6KFM9zxQhgofMjkGwANr4mWohmnKTzE3n7G8N
         S5PA==
X-Gm-Message-State: AA+aEWYEOZ6dyCBrNyWgdp1aRe+UkccSVaDoYzBIDOvVVkrhdTxHhiIr
        HhLGuaa15kl2IRb9JfnpZJI=
X-Google-Smtp-Source: AFSGD/XBimG4vkhBniAZKy3FRKlJ+JfrRtZcqFT2MEtHh6ro+wDxb/bHOOPuNHUbuOKPPWo/a37ZrQ==
X-Received: by 2002:a1c:bd82:: with SMTP id n124mr5818622wmf.105.1543786958180;
        Sun, 02 Dec 2018 13:42:38 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 13:42:37 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] clk: meson: meson8b: fix the offset of vid_pll_dco's N value
Date:   Sun,  2 Dec 2018 22:42:18 +0100
Message-Id: <20181202214220.7715-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike the other PLLs on Meson8b the N value "vid_pll_dco" (a better
name would be hdmi_pll_dco or - as the datasheet calls it - HPLL) is
located at HHI_VID_PLL_CNTL[14:10] instead of [13:9].
This results in an incorrect calculation of the rate of this PLL because
the value seen by the kernel is double the actual N (divider) value.
Update the offset of the N value to fix the calculation of the PLL rate.

Fixes: 28b9fcd016126e ("clk: meson8b: Add support for Meson8b clocks")
Reported-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index f906a9f0eefd..a4ae9c957fde 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -134,7 +134,7 @@ static struct clk_regmap meson8b_vid_pll_dco = {
 		},
 		.n = {
 			.reg_off = HHI_VID_PLL_CNTL,
-			.shift   = 9,
+			.shift   = 10,
 			.width   = 5,
 		},
 		.l = {
-- 
2.19.2


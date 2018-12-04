Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A3C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3134020851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3134020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeLDLeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:34:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42082 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeLDLeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:34:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so14565813lja.9;
        Tue, 04 Dec 2018 03:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D9Xfj5O6TrPCZ4XAaumYQKAYYnZ79yMVJdwXxt1b5i0=;
        b=gTpKOWLMz+5nBpvh2F7P6C3vmb1PCq192jz2R6YgdKjMWCo6OSbt7hVnfv8+6ttEYI
         dvT3DLDkm9L2ejMiE2LbMDD6fJNT9QBxdXhGgPCcpDhJuhSScVKw0n8RqG10U3741z7V
         YdegiJITFagVzSfuFHMQV0xb1J3A60Gqs8/VMYfoyke8PPLsgBFJrxwvoqhSurG8DZFz
         /CBqiU3HlVFS2m0ZYlKf7AGcv7HEo5NS5Tpdn3WCh8yZRWnpGmgGjWlZGsEQVLW7v9ZT
         Pft0WxPeczt6AyOABl7uR2Esb9gY/LTNE/yPrRheyBCDzz9GMQ6J198P4hdhZ0kMvvfc
         AquA==
X-Gm-Message-State: AA+aEWbRUEdrM0MzeSjpldSPBHAYsWsyIalVYBqzzG+v0zB/EV3Zat6k
        yHm6rYC3peqyPzN/MxJJjGY=
X-Google-Smtp-Source: AFSGD/VfpVRI6uMyQNhr/c9FW6Ywud7OWk+oS7nf1VGsTMoPXyA5RaDpG1w+CiC52xYvr7CdcOSZ2Q==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr12336777ljk.76.1543923242641;
        Tue, 04 Dec 2018 03:34:02 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g70-v6sm3120443ljg.92.2018.12.04.03.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:34:01 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:33:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 02/10] clk: Add kerneldoc to managed of-provider interfaces
Message-ID: <dbbe1896ba62d2421606fb0807740d9e6090a1df.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the devm_of_clk_del_provider and the
devm_of_clk_add_hw_provider functions.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..78c90913f987 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,6 +3893,17 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
+/**
+ * devm_of_clk_add_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Used for DT node and lifetime.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's node. Provider is automatically
+ * released at device exit.
+ */
 int devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 					      void *data),
@@ -3950,6 +3961,10 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 	return *np == data;
 }
 
+/**
+ * devm_of_clk_del_provider() - Remove clock provider registered using devm
+ * @dev: Device to whose lifetime the clock provider was bound
+ */
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
-- 
2.14.3

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15136208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15136208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeH1FoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:05 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39768 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeH1FoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:05 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so14425oig.6;
        Mon, 27 Aug 2018 18:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MWzmyGPE+4quYOfdKtwyh9zUbo2pjVGzo/pqYBMkyv8=;
        b=mQ5K+RQt4JC2IFgy9H65CbKaspyrffqN6v4Fo5Q6y1uV3agJ357CZFt5EY4AmYCnoe
         McimKNgOqOEotE7Bpu9P01U8m1r527hz1oBBzNioK7vj/v0x5OQH6LVMmqimgzWstj2/
         S8ZhjS+/pBsLwxpYFzO0Mlc5TwlujxtMTTLlm4zEE5OClQ9HbM8OL+Mx1Uu4wLAN8sgR
         nORcMrT4HeoEigPzWlkagaXBkzKmemJ+PzzXx5PlnQcO2KeiC39MONL+WTebfbNcNTrX
         jf7y/jH/NbxDJMKu6sVHtCqxL07y5ewSP2SVc0IIQivef8cgAf4IGxgbP0gOKv2ia7Di
         vUww==
X-Gm-Message-State: APzg51AQfBswiQBld/mI7bQTYNwsNDxMYIFx9gvOBgkdKWkhMxLZqmog
        PPjgakxyYRTwWsG0sAUuW6+HtZc=
X-Google-Smtp-Source: ANB0VdYge7u0yhS7Fnl1U00BhR5gfASWRpLAX+WurqHtYKvtvXKBixEq2ORyMJEN94dxaLNVN/2pgA==
X-Received: by 2002:aca:5cd4:: with SMTP id q203-v6mr969037oib.217.1535421289594;
        Mon, 27 Aug 2018 18:54:49 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input: sun4i-lradc: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:24 -0500
Message-Id: <20180828015252.28511-23-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index a37c172452e6..57272df34cd5 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -185,19 +185,19 @@ static int sun4i_lradc_load_dt_keymap(struct device *dev,
 
 		error = of_property_read_u32(pp, "channel", &channel);
 		if (error || channel != 0) {
-			dev_err(dev, "%s: Inval channel prop\n", pp->name);
+			dev_err(dev, "%pOFn: Inval channel prop\n", pp);
 			return -EINVAL;
 		}
 
 		error = of_property_read_u32(pp, "voltage", &map->voltage);
 		if (error) {
-			dev_err(dev, "%s: Inval voltage prop\n", pp->name);
+			dev_err(dev, "%pOFn: Inval voltage prop\n", pp);
 			return -EINVAL;
 		}
 
 		error = of_property_read_u32(pp, "linux,code", &map->keycode);
 		if (error) {
-			dev_err(dev, "%s: Inval linux,code prop\n", pp->name);
+			dev_err(dev, "%pOFn: Inval linux,code prop\n", pp);
 			return -EINVAL;
 		}
 
-- 
2.17.1


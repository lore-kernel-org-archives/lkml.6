Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF03C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7270420868
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7+PtZso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7270420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeKZDKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:10:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36728 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeKZDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:10:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so208648plo.3;
        Sun, 25 Nov 2018 08:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dNaTAnr10zrYPVdsj0Xu4lcwWPKS7hR7CHzNPhUwwUg=;
        b=g7+PtZsoKpLBBoCYnVRnl/v5J7PlNw13Xu9ps86JqOKwgf/tWyZwmjG6f31J8Y02bc
         Z1rMv1r5b0DJTk9y9vo9hxCvxZfytTqbEfCtHyNQYKLybHBt48MAHw8TRfV7RYIgvOsq
         3ay9eQzRY4Mlkf44ByHz2mEy3RVSIeHYO+tnh9CRUEOGm54i3JlpZsHieZualjvVOeHs
         QYD/6HZuOrdGlOUS+SrKt8Ap4zxG0hi28SIKPlP6wWo1MhfIHZSwl6EEe9V+7aUbiEst
         Uj9QqrhKfQ2ZiEBUjG0hL8nn2QUDx8DCd1gzMOoDaJpOCppzcYNmfE7sf6iF0C0Z0AJf
         PcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dNaTAnr10zrYPVdsj0Xu4lcwWPKS7hR7CHzNPhUwwUg=;
        b=uV1khKhl72PqQWWimlLtj2RV28wJnno2YNLUOlmIq5MqIWzgpGrgrkRv709M22RvJQ
         LLRur+9rXhv9H8zp6NUU/yhfeybg5+dZjX4facruWXVGcla3QfAltJ5blbSAhCc7vSu7
         9tPUDgo+QeGJMB6kg39EUSJZcIcLaN6fyg/dE9tdh34dH/0XB5AAsfNafvLK8jHxRC+u
         Io+2myn24njwj9cRPd/BMPbpGu/vQnUE+oM+PEjiakUKnJRthCkWOkiBQM9NGIZo8e+X
         EbdAfzu/GNJX0PAaI2tWqn4ESwIKUMYlklhfjqZl9Fm45BWZ6gn1i7Xjc/x+9RDPHwd9
         wZTg==
X-Gm-Message-State: AA+aEWZnHEgWSWic7hVcOli8gUwUY5+hYgiIGDetL1MqKdHRxRnoLu/W
        iO4lx1WUc4G3Fo9kHJeCTkk=
X-Google-Smtp-Source: AFSGD/X2HdyJokSI7P9S8vmbLUJwfsWeJhDWr09Qj7gJ3pjMJJmrn1Mj8iWxpSfNOKsX7GFBXb2XWg==
X-Received: by 2002:a17:902:14e:: with SMTP id 72mr11379492plb.287.1543162746402;
        Sun, 25 Nov 2018 08:19:06 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id e23sm78420517pfh.68.2018.11.25.08.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:19:05 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:18:59 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
Message-ID: <20181125161859.GA5277@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Allwinner sun8i pwm binding document.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
new file mode 100644
index 0000000..7531d85
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
@@ -0,0 +1,24 @@
+Allwinner sun8i R40/V40/T3 SoC PWM controller
+
+Required properties:
+  - compatible: Should be one of:
+    - "allwinner,sun8i-r40-pwm"
+  - reg: Physical base address and length of the controller's registers
+  - interrupts: Should contain interrupt.
+  - clocks: From common clock binding, handle to the parent clock.
+  - clock-names: Must contain the clock names described just above.
+  - pwm-channels: PWM channels of the controller.
+  - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+    the cells format.
+
+Example:
+
+pwm: pwm@1c23400 {
+	     compatible = "allwinner,sun8i-r40-pwm";
+	     reg = <0x01c23400 0x400>;
+	     interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	     clocks = <&osc24M>, <&ccu CLK_APB1>;
+	     clock-names = "mux-0", "mux-1";
+	     pwm-channels = <8>;
+	     #pwm-cells = <3>;
+};
-- 
2.7.4


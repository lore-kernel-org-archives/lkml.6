Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A90C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482020863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgfAnrGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfBKJWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:22:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54804 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBKJV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so16191296wmh.4;
        Mon, 11 Feb 2019 01:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GeJh1mZ8HNX8SodOIqWEKIstu7HfmSuWt0fhpAm7b20=;
        b=kgfAnrGQirpPWUUooWkQC+SnSWB04mo7Pqhkcs1A89WQY0iT8EcwHDsUyO8K3yirgy
         2pB+6Z8vluIXPQ6ErQNkP8JHO7RWvw5cJzYCOV6sGmopeAoq+bbiXgKqipxhr+8tc3j/
         DG1gTk3cUqlrnljMGtUzPTk3RU8Uu6FGJfci90YZIDv7JVx+NcC6gZjg901n9v8Wzn/g
         A+HpYtkswMGWnUyLzntd7OTr6XfshPlsllakCRG3icYwZ3XS+jX6FT9gGFzYnPWY3X8T
         Uj430tYf/rhduqpocHdAVw6gZ/CnJo/vdYXxg0dtXEfhjE9dfAmiEoxpQavG2Sp0D6pu
         RI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GeJh1mZ8HNX8SodOIqWEKIstu7HfmSuWt0fhpAm7b20=;
        b=cnooKbsj3lu+IHc3RyqB6CfLff9XlPOpA+n7Gu7YPuFXgrCww7F6OsWxAxGW6KQD5/
         0DM7qJLwBXQHhI4MgHLi4ml6Ab1iEi3cUSvHHp8qX+NApNIuGuKowGc3mffo/MOddB0o
         3hDijg+l9Tq+Yp5ETkQz3yeVoMA/B700+GS4UBoePIDPrUgkr/Ujegk8UQ3mVcahgDg5
         vg0I6qCL+nf620bckZhNL+SQJco/O5TXWHd3Ot15QKfJSGxUFS8z7UZLVO+XNjuWVfL/
         E/wabcviwF17JkLWsJRtE9VWgU5WfYRf7QXvjQ/QBNF6jgS6G+If4Mj+s57wz893ojBo
         22cg==
X-Gm-Message-State: AHQUAubFEXvEhaeh37YyxSJKip0RcKyislh2p42ozZ0/F/rJwVgcb1hT
        o4LedqZeSSbA8Nkq1U6n3c8iabxqbE0=
X-Google-Smtp-Source: AHgI3IYjSM1FfR7S2WwI6NLUi2OnKURL/gGbASgo2peTVXcVSWpFZO/Rkr81Uw+beLruJ1xXJDssjQ==
X-Received: by 2002:a1c:f919:: with SMTP id x25mr8461804wmh.61.1549876915112;
        Mon, 11 Feb 2019 01:21:55 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:54 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 6/7] ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
Date:   Mon, 11 Feb 2019 12:21:12 +0300
Message-Id: <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PC0~PC4 is pin group for SPI0. PA0~PA4 is pin group for SPI1.
Add device tree nodes for this groups.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index 1b332d9..a92a411 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -96,6 +96,16 @@
 				pins = "PE0", "PE1";
 				function = "uart0";
 			};
+
+			spi0_pc_pins: spi0-pc-pins {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
+
+			spi1_pa_pins: spi1-pa-pins {
+				pins = "PA0", "PA1", "PA2", "PA3";
+				function = "spi1";
+			};
 		};
 
 		timer@1c20c00 {
-- 
2.7.4


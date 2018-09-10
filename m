Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FBF20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1s1bo5Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FBF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbeIJXej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:34:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38294 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJXej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:34:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so22445718wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=r8OnygGIGwgPwNrID8QMkntNDNypXvjFXll4EsC1hu8=;
        b=1s1bo5Ymjf/GuyK48l3oUyt9jjJSFh9lunmPHuRfXFaQuk94dRVgbaaezZN+vOg+X/
         MX6u+I9Ywj43aq4jVOk1M0Yovdk6l4F6PHZQzQCF1xARwckTTNrXi0kAGWA4fnGw/wd4
         RNj2V5sxQWYA785aKsCBT0y46HiXk9QGpfyR1/EpBC6In84b0UZuiuY72bVPq3PSYbrD
         c+H9YfvnPhTqsrUY30Ishw7Qs1EehN2oEEDCowBvFlnXKdO3W1thg8LZUBlAtwFh81ra
         Qi5dErtS1SBHGkRBZ0uWJinsiRB39I4f8o+ZWI1yDW9wmo4BrLeQ3efeWnuwTSk3/bz6
         t9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r8OnygGIGwgPwNrID8QMkntNDNypXvjFXll4EsC1hu8=;
        b=d6UEAXwxNmV+DNzL9TXCTkMowSTWbzhLcuR3XMb2XaA2GumiytpqLaDa2CTT6AVY+F
         gyXpW45vSntnL/hAzboPzOvBhdfA5IoP/ZdkcAD3ILEnksya4eT09L/tySAdmvhMO+BS
         8fkjTR8ldXvTtcCHpB+UxyBLW8b2HWNhE08BFlfICQw8plzAuCSvwwKcOSmRp2cWL5R0
         U86QnaY+5BinyNodihevBGPr3IZccEkv4Ei5ANbbYzx5BA3cjOCnPSS7wtGTAmTRKeGZ
         5b/osw9qUllsR4vwPqcrJcl0dZTqgId9DgsGOmEG6SSccZedYoGhTb2BlJ1gIqBvDOMr
         ghHw==
X-Gm-Message-State: APzg51AFOmRnAmeW4n99iMSp78IZleo/2gtnIoJnwVSZ65KEfhqdFEiv
        MpYTrK3amqUu/dzlt7mqb/5vuA==
X-Google-Smtp-Source: ANB0VdadA3hKEDVBX82aCFyqGL+EFZeOS2ljd2G8VqvRSjScJ7MRZUOh3BpOTY+U9nV1n2SRAlAjIw==
X-Received: by 2002:a1c:65c5:: with SMTP id z188-v6mr1673959wmb.57.1536604753232;
        Mon, 10 Sep 2018 11:39:13 -0700 (PDT)
Received: from bender.home ([2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3])
        by smtp.gmail.com with ESMTPSA id f17-v6sm20261659wrs.1.2018.09.10.11.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 11:39:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg: use the proper compatible for ethmac
Date:   Mon, 10 Sep 2018 20:39:10 +0200
Message-Id: <1536604750-32621-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct compatible for the AXG ethernet mac node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 32f6dca..75f4ca7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -525,7 +525,7 @@
 		};
 
 		ethmac: ethernet@ff3f0000 {
-			compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 				0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
-- 
2.7.4


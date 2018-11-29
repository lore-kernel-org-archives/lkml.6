Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626D1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EE0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rogHK7K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbeK3Dvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:51:31 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbeK3Dvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:51:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2587979wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me0Lfu5BhBpqT9CdhSlWzYxuoOF7cdOkh9x6AmuvvVc=;
        b=rogHK7K0kH++y0ednXP5cVWtEAOsfL2jgfyiecbhwdJCPuUVTYZF99Zg8xq9DUY+Hc
         wX6oOpFbaHEf70oUzyFV5mKcUBEFSV21S6GP1w4FqUrn3tRW+/FlndxpCuwXk3E3SC9q
         pgdLvhuRsNwWP6ip0QiMl1bN/Xved5y+9OLW8S77vr2tpdgQ8Ckqb+O15ncQZY37RkmO
         RFLxXVj8exSgsJDFHFTff8s/IRalyhdYSX3KmUWJ480i1cyjSsaXc0LWx7sgdmbsMIQP
         vR5usXsclWAJjQumh3BIIUQ1dfGVfQ1lqpUQydWFsYPyWPOQvk/flXyCiQvC1YysaFL/
         MX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me0Lfu5BhBpqT9CdhSlWzYxuoOF7cdOkh9x6AmuvvVc=;
        b=DuIoudyFgeq50lp4ziNNCPhkNzuJVdqX77cVXCPtHMMvtZb5UVPmaVAMj/ZIYW6zzx
         UG7GASLSo8B5eVWMYT90m2EMZoMRvF2Faz/fVirqHW8ztIS8BFli2SO8nOHjPrGdJ8/2
         KIrjC06r683Wbk2Jpz9UN0TtJfRwIY+c3JS0GEMJ+90WzmuYD5OQ3rQ4E8dJOclEl/a9
         Okh+giKxsIxsvfDK83bb9DW6y4PEmsPVPcWwol9n061P8XNOxRnyJuBpEN6i3a6WXiOZ
         N5XwbQ1c/E/HJYwRLlGO95l/Dw+x2cgwZ5u8jVemAE29GRl+xa4i83sOBVtcbjmtxJCp
         gGmw==
X-Gm-Message-State: AA+aEWZBe221aX1Ckk2PuPiSPJWCMQV0PdHGJdesnJIHMX86QwmHJvcm
        ZX5i6APVxnYfAIcTArO+etcKRg==
X-Google-Smtp-Source: AFSGD/XyqyRkcAFp5kKA+MdFtQ28BEmg6t3MEjW6UemCTXoCMSbYGhlrVpJdoLkehKWq33qeKJAP0A==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr2135687wro.105.1543509931333;
        Thu, 29 Nov 2018 08:45:31 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id d4sm2721909wrp.89.2018.11.29.08.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:45:30 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: add clock controllers input clocks
Date:   Thu, 29 Nov 2018 17:45:21 +0100
Message-Id: <20181129164524.18670-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is the first step that needs to be done so the
amlogic clock controllers properly claim their input clocks
through instead of relying on fixed names.

I'll be waiting for this hit mainline before sending the related
driver changes.

Jerome Brunet (3):
  dt-bindings: clk: meson: add ao controller clock inputs
  dt-bindings: clk: meson: add main controller clock input
  arm64: dts: meson: add clock controller clock inputs

 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt     | 8 +++++++-
 .../devicetree/bindings/clock/amlogic,gxbb-clkc.txt       | 3 +++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi               | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                | 3 +++
 5 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.19.1


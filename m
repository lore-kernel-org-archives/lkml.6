Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3FFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428EA20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vb/FSQJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428EA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeJBPZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:25:59 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38005 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:25:58 -0400
Received: by mail-wr1-f53.google.com with SMTP id a13-v6so1183394wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RmZAOFEaUpvoAvp811RfHNEMyn1v4jbzQsj99cgB7Do=;
        b=vb/FSQJayrkwNkPMGPDC4BivGYeZzSNOKT7Z0/kLRJSG+O5PfFDNnG51gkL83TfpT9
         GLIKBn8fOCQi5WgBWP7PJ2XKq5eCb3SlKi4u+Bp1lVnaXlmO6/kGdFhZA3Bnq7ZlmIEs
         1UB5M2dN6D0rcfaZhOMOaJZxUFvU1Rnxojm7wBGLqxa5Vv3vLAuIU1mrAWDNfiDyKqzt
         +HKsrHfwI+mhMSsvbWDMqdIVj4F17IFWc0AyhSN8SRutVbe7tQ7LWp68aPOYZh1Mfb0e
         MKRrRZn3bS726ZveBoR8GfAylaAygiDPzCSVygmOIdJ8mEPQqhj1kAIeBvqQLJ8TvOu3
         69/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RmZAOFEaUpvoAvp811RfHNEMyn1v4jbzQsj99cgB7Do=;
        b=GUG0MVe8y4V82+wb1ReWk4mjHz1ilAiykzRfVyTnrF3RCNpTh06SUD8xQZjbbGdWoV
         pqEfHOyG+OO0QcvtHAkwXjiknwN6FSUgPkYL/B3wiGMXFEwGMhTVb3z0aEcxCgnCZpwR
         qJUNjggfJihBwbrSQ5damM+rSwFQRZJ8j6mQ96hDMkSEPp2dBOIHxeqxO7tQaWx7gfos
         z8yE4WArv1yXxF3zHl6KzVwNkcIk9wvZEoalQDmL832dlBfV6+F9ZegDSMWOV+VGmWXU
         rUhO5mgNVEphjuz24SPhX4tNzxcgMguNbRxu5/0zDmRM9hEBb3IJDEkSdiLAgts0lcI+
         iTvQ==
X-Gm-Message-State: ABuFfoitrnV2abvWSvFbxO8nHcxON8W/OuH4Td9/A0Ibt7hUR/9hPnin
        q3QeOlQQiQk44qThEFeQDtqpYA==
X-Google-Smtp-Source: ACcGV61TyMOgRtf/SACectiAsntDCaHVLBljg3YcZpPrB+Okdx4LLSVVaCedEPfwotGuvYVxtIcN3g==
X-Received: by 2002:a5d:6707:: with SMTP id o7-v6mr10054067wru.326.1538469828542;
        Tue, 02 Oct 2018 01:43:48 -0700 (PDT)
Received: from boomer.baylibre.local ([2a01:e34:eeb6:4690:3146:aafc:91d9:4b96])
        by smtp.googlemail.com with ESMTPSA id 198-v6sm16162298wmm.0.2018.10.02.01.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:43:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] arm64: dts: meson: s400: emmc updates
Date:   Tue,  2 Oct 2018 10:43:39 +0200
Message-Id: <20181002084341.5487-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the emmc pwrseq to the emmc node and disable the device
by default, since eMMC is not the default option for this board.

Jerome Brunet (2):
  arm64: dts: meson-axg: s400: add missing emmc pwrseq
  arm64: dts: meson-axg: s400: disable emmc

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1


Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E13C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C52087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M75wnLsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3C52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbeKQB2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:28:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51061 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeKQB2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:28:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so22578820wmw.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=M75wnLsDH1tPjURSQnJFIjw6ciUNnxAMgszkRwv45pVUJYIAQwqYNSQlFTRI+IqEPU
         lwqcaqMEYc++dLdkfz2jFD3nFQs94bYauubSEdRmdQI2pS66hjc/NjOtzfPO/AdmfeAB
         qiowaI+BX2oyZd4vDSIZEkO9RHOuadxjEqfCeBwUlPm1PRAGB9K12DwpmW2+3L92Gu+p
         p+54UmVWJ8MR8Wh2LJvOhmgILxO9XRQimfTKJEDC3vDRMxF2sOKOMeyNOr3QiSuTil7I
         6yBWc66hUKbfhRf9yFR1PRRvvNW4wjp5vOkHplKsDKtgP+BPK6pQ/9ax2zQtmY9QaePD
         u+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhrsNFD+e9chNyIzaJLgBTnb8Z4z8WMz0KpzTlhbRZc=;
        b=scngErpcmGSh9S8YRmoaRQmQLjZVVspHbuxYhgCjFuF9r+vFPceDtyI+aSshdZNkwW
         ArdDGNtBnJ9U03F+jzmmrOMwUO5OWc+Mtbq73Ri8vd3628BFBRaF3rKn0Oolr+EuEGGe
         L0hFyEjTROrcBSgQM5WQuyldo1bAK74JQL895GVQ9INbDoda3KDAQIHaVLguISVUm3pZ
         TzxbEmuX6pazfoEDh4NBLoPv3YNT8tS6AguQYoNyEWTelUynU9sJvF/Ckdo5/X3WNjCj
         iXeGA6yzXzIotPqpUtw+YwVfJ/qrBt0QOEmaPAWp9/fFQiGz+oGzSIMdatCoJeKfhxeZ
         OPDA==
X-Gm-Message-State: AGRZ1gJG/6y81udUMc1osw6uZeNboYdumCmQQDBhHIw175aFUI7E++FP
        bJvG+c8rPJ+HmEbcrDFyAmd2mQ==
X-Google-Smtp-Source: AJdET5f/9bwMwexA+6KQEKTErUQc9TsZOfpXVrWINX7+D0eXE4UToLSp8qUVOwiylmU9Be5eIbec8Q==
X-Received: by 2002:a1c:1c88:: with SMTP id c130-v6mr9159216wmc.115.1542381345946;
        Fri, 16 Nov 2018 07:15:45 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h125-v6sm13937816wmf.48.2018.11.16.07.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:15:45 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings
Date:   Fri, 16 Nov 2018 16:15:38 +0100
Message-Id: <20181116151539.18501-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116151539.18501-1-jbrunet@baylibre.com>
References: <20181116151539.18501-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Libretech aml-s805x-ac board, aka 'La Frite'.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 4498292b833d..203d38e5e271 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -93,6 +93,7 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amlogic,p231" (Meson gxl s905d)
 
   - "amlogic,p241" (Meson gxl s805x)
+  - "libretech,aml-s805x-ac" (Meson gxl s805x)
 
   - "amlogic,p281" (Meson gxl s905w)
   - "oranth,tx3-mini" (Meson gxl s905w)
-- 
2.19.1


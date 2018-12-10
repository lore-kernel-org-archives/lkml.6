Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F79C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iooce9HI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B32320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeLJNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:22:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeLJNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:22:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so10439672wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPFj6MLu/M8G4PTHe2LZz+FX5iaOvPF1UuFtv4gFdoM=;
        b=iooce9HIO/IlQvwj9SUjEVZnfs4JA8YOgJDRilfuZl6auKf8xTrYC9R5wRQ+C0bHxX
         ZoFdLXyU3el2I9dN9udnFGLs4UxW6Gg5ijO2IoI9UK+vPkV3zubFGZUNq3RRD7yR0si5
         66F9q1JZHKxsUODKLPhESXtIAOv+SDnoCVVfNIezW2czQtrLsbRQIs2xotIRdGhS1Wl1
         xdUkmfyWQD++JJNL9TQVCq08kwEK4ZRHGDCJ6oaYtwoRRXp3otKtUoEHPJBCX7gWrcSM
         Ewwf5pqG3wqhf9DckZw2fqS9rqIWcZ271KOBsQHQ/Y5GvgJdW2lwVzUWjy+zssTlFyef
         1TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPFj6MLu/M8G4PTHe2LZz+FX5iaOvPF1UuFtv4gFdoM=;
        b=P7KZ8KJyTN2X36CmLO8R8EgKQS15GodksfmH/SqN5HF+fjAeMxVoCI0SUl2MGnE/p8
         P0KR2VqzjX+NA8UGGhFyXwbajU33K3yUwOKmvy1XajU7hVkpcQYRGZFOL8JxQ47am9Ou
         J068FD5/Le66CMSa5Aj5MjHCa/KAR3+/XA7s7NhmhMi818B8WR/DXvMJ43fULuLLW8PM
         UTGIpF3vUw/uMCUB/4fVoXsa4fB/qZ7rI6MFRjfw1A5MVlQ97pY0/OV+Y7NIYLU65RYe
         q6ggrsWiV5NthjVsI6V4qI0QFUD+Dk/qGZIN7ET2F69vWRsblVNELOXrzIHxHuEwl9H+
         reSQ==
X-Gm-Message-State: AA+aEWbWYRViMHu3qswvfULIuBbfMM/uJ+53PUN/V1hNdN5cvlDOueLh
        MYaB0xFkdOT8EpkmuDSqqsSs0w==
X-Google-Smtp-Source: AFSGD/VMEYq9rPP0ewBLKlh/rB6emjkoSuKndni9TE55hTZ/5s2L+oaavtKw/KDurpcOrw1X+emiDw==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr9607298wrn.11.1544448151513;
        Mon, 10 Dec 2018 05:22:31 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3sm11208424wru.36.2018.12.10.05.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:22:30 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Mon, 10 Dec 2018 14:22:26 +0100
Message-Id: <20181210132227.29262-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181210132227.29262-1-narmstrong@baylibre.com>
References: <20181210132227.29262-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..24d83ec952f1 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,8 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- resets : Phandle to the reset controls for the Mali Midgard device.
+
 
 Example for a Mali-T760:
 
-- 
2.19.2


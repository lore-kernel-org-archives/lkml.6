Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcpN7OVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736D420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389091AbeHALdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:33:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50591 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeHALdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:33:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6256047wmc.0;
        Wed, 01 Aug 2018 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NcwAUVgFYFLdbSN6IWjkFLeSkrlUTnoto+Lmo4tqt7c=;
        b=KcpN7OVt0sEz4UzH5zKq7Q3AWeGHpv0fqh3DZ+2dgmAEb5Uh15HN+PGAWOAxjS1/Sm
         qGy/RzXKFGPMtGbD8CTx7LUWKIhv4Eb1DCNEdGCa8EDLwtqFkFgXJjM0fso0TET0jvB+
         l89JcXgL15Qa/4CpSU4nKKHXx8932g5729Zf8+RK6M1rxPlktdSwXfFElWBlcEK2nqEk
         abDTncpASPlYrKe8KNmFUMQkTLSWDXLqkwCJSwXrR37eRNGFZ1O6/f7UgYwkdLlpyANp
         iP4vHvy1pi9mFj1gGkDTzo75RXjQmhq9sV+Fk3+91zRK3FAsxDtEoAYfcy7Ph0aX00MK
         Pzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NcwAUVgFYFLdbSN6IWjkFLeSkrlUTnoto+Lmo4tqt7c=;
        b=CuxYsr3QWHXh8mc+TNSFDVeLanKHa7GnzWyB5pPZQXdKTZN+JpdIoNo4paVPBXvk1A
         /h8qcyMHcUp4SkhAvirCmOriehHvIHPr14cCnSZUqney9jO3ZWX9cUSmAEJW+2jJCjR6
         9v/NWoZhDiVenESxAkIABwj2ACRc1jBM6iyu96c2mSL7eefzpk1XqP+89DjwTayaTrpv
         KcdxQ4IhOoQOTj0HkZneIiWJ5C7+c0eWFSHbGtUeAHjBBqwMxuAdu9Wg0MVcaA0pb25H
         6eoXkMSe4rEz8S1W3mjtqvwkX4GOIj99OV+TvekZr+8Om2YF2mY1CabWrm0ECR/YCUEG
         x0Kg==
X-Gm-Message-State: AOUpUlHwxcx78fbpKv2VWl0xarUDVU32HJqjzj5uj229Ij+SSvPBE1s9
        djVmJXy/oMVgqo4A+xT6eF0=
X-Google-Smtp-Source: AAOMgpd5QcfruyPoMb/rKMc4KdmaDFTrgsdzIp1V4aaFj9u0AJgdUI5mWF47u58+xNzEzeqIj6EdYQ==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr2394596wmf.114.1533116885578;
        Wed, 01 Aug 2018 02:48:05 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id r12-v6sm13580217wmh.0.2018.08.01.02.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 02:48:05 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v7 3/4] ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller
Date:   Wed,  1 Aug 2018 11:48:00 +0200
Message-Id: <20180801094801.26627-4-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bananapi M3 has an onboard IR receiver.
This enables the onboard IR receiver subnode.
Unlike the other IR receivers this one needs a base clock frequency
of 3000000 Hz (3 MHz), to be able to work.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 3b579d7567c8..ea23ff821166 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -183,6 +183,11 @@
 	status = "okay";
 };
 
+&r_cir {
+	clock-frequency = <3000000>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.11.0


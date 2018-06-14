Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 699ACC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA620864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VbOxeVFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EA620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965099AbeFNWwb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:52:31 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45624 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965037AbeFNWwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:52:30 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so8978263otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 15:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ztr1SvESHr1XzY+6q41GxTJGHsuiBzX3nQVyt/cQyEo=;
        b=VbOxeVFgTDWuOn9ZR7YasQxgNovqW1nwFc1mwnmuKhXhjnqB0P6x8HNSUqziJ2AVlS
         jzq2IGdAHKUtTFFfA4ydEdkt8WXDrhl1SFDJN6g8aBpD0ZknCRNrY2DmtNYldU2TPquV
         BrbKI1C5W2CgIF+tBUM2KMYMPS/KHiOvOneh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ztr1SvESHr1XzY+6q41GxTJGHsuiBzX3nQVyt/cQyEo=;
        b=iwowZk00jRLz5ddoSgjOATf1dX0E0Ppuy1/U+NI+NQn504bA8XRnZYj3DiuVW6gSNs
         HLL9fFOu4CaHFplmfN3YqHw9ceKgBRznOinHZFOR59ixYwdu7keaRaKNAa/XUKTVgu0U
         cqCgPw0sTVdVR41SuSXM5GvyqpkWesEbKmttPEu3IFqjrjuycMu+AjIRh1+BE6LIrhgB
         05WruRfWxo37jKmoZ/tY3Z0nMvRNRuN7FBsDX6tjo4l+J7JlgAQWcxVDfSq50RPAlGsU
         IA4dI72JTpeZww5onnfKo9gzCOB5I9CjY94r0X2Djj0jqxFMejiZs4dVsSfihm3JUnrH
         bbRA==
X-Gm-Message-State: APt69E1q5etSSwLTVTTPzi7p2oOHj21kfq4/LsvSQfRB22swYEMO5/4W
        VcvUW6UCgjveHdDIW/uXKjA3g3aUdzq7aA==
X-Google-Smtp-Source: ADUXVKI8cM3D1nJARYY1ng5LS/0Ylf91AR0tUyplRU4zdNzTbCUqTfpQ1i+IxcVG666wut+Yu96MWg==
X-Received: by 2002:a9d:5c84:: with SMTP id a4-v6mr369878oti.301.1529016749590;
        Thu, 14 Jun 2018 15:52:29 -0700 (PDT)
Received: from aura.cortijodelrio.net (CableLink-187-161-191-185.PCs.InterCable.net. [187.161.191.185])
        by smtp.googlemail.com with ESMTPSA id w5-v6sm2778982otg.5.2018.06.14.15.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 15:52:28 -0700 (PDT)
From:   =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     anders.roxell@linaro.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Eric Anholt <eric@anholt.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm: multi_v7_defconfig: Enable KSM.
Date:   Thu, 14 Jun 2018 17:50:27 -0500
Message-Id: <1529016629-2948-2-git-send-email-daniel.diaz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the documentation, Kernel Samepage Merging (available
since 2.6.32) is a memory-saving de-duplication feature,
enabled by CONFIG_KSM=y and activated via sysfs. More
information can be found here:
  https://www.kernel.org/doc/Documentation/vm/ksm.txt

When enabled in the kernel, the default is to not do anything
at all, until it is activated at run-time with:
  echo 1 > /sys/kernel/mm/ksm/run

Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7e1c543..79eedf4d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -133,6 +133,7 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HIGHPTE=y
 CONFIG_CMA=y
+CONFIG_KSM=y
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-- 
2.7.4


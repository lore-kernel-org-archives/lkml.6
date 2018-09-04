Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6AFC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42222077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeL5Aazx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42222077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIDW5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:57:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36730 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDW5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:57:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so5285396wmj.1;
        Tue, 04 Sep 2018 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mttFuPMlNFcuoEx3wWq0n6xfpraMik+75IFyKG0dmaM=;
        b=qeL5AazxSZK+UlYTyarzShel9M3lKyoRnbHClgL73qitPG5YMYPwwQ8Mvk0ZDkF9Zk
         TOJ+iKZyCNQR6Ze7kQvmEOD6qQswSSd/cNoSClPJldWuSkp5HgVyo6Htxq/aI8UNNbJo
         EenKxc+HxIIyTQ2KIBRJC5pp+buymtx9mAYZe+V9oCWsPYn1m5f56S6A00f66c8zHWgE
         sXpoL8ecHyArEeAOQ9l75XIdw88y/q5JZlUfeDljvT28XHP5OWwheM5gWMwq38b41NkX
         RmJT3J+2LmNMPBC1Y+w5T77Nk40/VZ1m1bOBxei4GQd0xwmMQk17vZKS3GY6WZpQ9FMG
         dCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mttFuPMlNFcuoEx3wWq0n6xfpraMik+75IFyKG0dmaM=;
        b=fitx2mT9mSBt6cSXMO2JOFVnH8dNp1uYZjUqGOi03RwC9WXYVJ3YrRJshpYPjTUlmU
         Sqf0J0zKj2Gm8bsNDX7Zphuw0HH1xo6Lgz1huq78LjU3Ghr1bVm7+BX9aCj+DM3Gg6EI
         tg3dQvZAIOyhtYmP+5s0EorULIEj5Z3glnIk/zoOcjaKzXpy+pJvwoluMnXOk6QXJ/Yh
         BryKbj3xtFD1AjqgIjoaa5BQrbAuCtLnnF0Bo1LDmMqsK5Zp7c89KKKOVt8zqET3Y8F9
         be00g+/rAhvrCZoZ7wpP0xDIINgYAHJHXC9aYZZ1TV2rq/0RJpVo/DmvhCDhdDw9X+xn
         yrHQ==
X-Gm-Message-State: APzg51CYaZ26s7zFomlQyIQYuowQ/HE73i2ErpCy0nZqHAKfZHI6XFxG
        v0nbYJmGP9u3KW7KclAMfBo=
X-Google-Smtp-Source: ANB0VdakWdKoWWp4q/2fB7eoD93H+INgWKDbWK87lCz76+MH+N37iMbTnxz5v6ERx2Ct2UQUVWnROg==
X-Received: by 2002:a1c:40d5:: with SMTP id n204-v6mr8800306wma.44.1536085894657;
        Tue, 04 Sep 2018 11:31:34 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id q5-v6sm29575741wmd.29.2018.09.04.11.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 11:31:33 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gx: increase default shared CMA pool size
Date:   Tue,  4 Sep 2018 22:30:43 +0400
Message-Id: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices using the new V4L2 mem2mem vdec require a larger CMA pool. As
nearly all GX* devices are video/media focused and will use it, set a
larger (256MB) default value.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4db..ef43922 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -44,7 +44,7 @@
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-			size = <0x0 0xbc00000>;
+			size = <0x0 0x10000000>;
 			alignment = <0x0 0x400000>;
 			linux,cma-default;
 		};
-- 
2.7.4


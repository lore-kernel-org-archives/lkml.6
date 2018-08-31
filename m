Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E5CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267B20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A267B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeHaUtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:49:07 -0400
Received: from mout.perfora.net ([74.208.4.197]:52971 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeHaUrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:33 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfQa7-1fXPz10hOz-00p0xw; Fri, 31 Aug 2018 18:39:06 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 21/34] ARM: tegra: apalis_t30: add i2c-thermtrip
Date:   Fri, 31 Aug 2018 18:38:03 +0200
Message-Id: <20180831163817.23970-22-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:GcpZCdrSZ8aPk4ZlMc7zq0B7130ob6mGNWiiVP5oyxyZ8VCTV7/
 D3xdpREwz3m9ozRm23siJXpHbXA2Yl6Oo5S3B7hbQLaT+faW9CK20nISUYIIv8rpiuK4uBd
 3DoAoT4/GBElrQXonJLXTq/417lD2WTaNCzuyt2QDKQ1mpvm2OQTp540tJPZybaokb0/nJZ
 RoiIksji3tRFhYLRUQj/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4QpHSYdHJrM=:+vCLkzC+adjLrN2rjSL0kb
 zVZW/aoAzqyRHYWR3xe+uSaOUDQTf/vBTYQI5z7DGPwexBGm7Ydde30QtofJJlkNP5VIwM8DX
 tnQ9gh1pS2w9PgkT7PSuJR6kArCfoRqpsVGnTXk7Fd7ki9wIyVGsG/M8UqLt7eoUn3hMpWYqm
 wsHN/k1sUWZ6dPMSlR+SJf6E+oymmKhZxtbafD0d03KMlLWnZ8oE5EzrCFW7PpfiTo6sJKzDY
 dZJ6mItuKgZ7RCjiYgLjnnQT+N960R0x6jN260unLCimRkIKJBBVRktjW8zgPPL4XlbYF9F6v
 GPuSR8UeSfV67rJL9EJIo8wRLDKMygsrWyLyy6AE8L/ehh37zIF7aewWNQbpZdTMykAfm071D
 BBYM0NhS5/nG2UjqCmTBWLeLfCiYZ55/YjXB0fu7U3tadfW13bCjXuT91WenU39sG5+zoNXbY
 rRs4R4Qh5Ynjnn9EffJUmL99DmeA3NK9hb//0rjisL6EUI1xZ84JEAZnMbmdAxyEK7wgaLA5x
 wQH+KWJJDDW1DA1sZ/tDM8s2KhJRFY0KDHs1V4yI9Rgs2KgSnCXSaSPWdGrvd/yeWlyciyaoq
 Re0q2EMhtdKu5pqfV1lUqLhWzsvDRARozc0i2R7Jt2xqkeyJoFkPFVyOeuw+RL71XVwxBSiq5
 io3sXcRJM/N9p8CfkcrUvBKsj2RsyTj+irKglFD2TmhzFJH9pN3Tu5XFtBicjskmqHwQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add i2c-thermtrip which would set the DEV_OFF bit in the DCDC control
register of the TPS65911 PMIC.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- When running some more tests I realized that the reg-addr should
  really be 0x3f. Fix this.

 arch/arm/boot/dts/tegra30-apalis.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index c3e37d944c62..02d0117e9398 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1071,6 +1071,14 @@
 		nvidia,core-pwr-off-time = <0>;
 		nvidia,core-power-req-active-high;
 		nvidia,sys-clock-req-active-high;
+
+		/* Set DEV_OFF bit in DCDC control register of TPS65911 PMIC */
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3f>;
+			nvidia,reg-data = <0x1>;
+		};
 	};
 
 	ahub@70080000 {
-- 
2.14.4


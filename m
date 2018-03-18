Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbeCRPX7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754020AbeCRPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:23:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F99620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: samsung: Mark unused Odroid compatibles as deprecated
Date: Sun, 18 Mar 2018 16:23:21 +0100
Message-Id: <20180318152321.4419-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible for XU4 audio is not being used.  Instead the board uses the
same compatible as XU3.  The devices are now just compatible so they
should use the same value.  Mark hardkernel,odroid-xu4-audio as being
deprecated so in future could be removed to limit useless compatibles.

Additionally add older compatibles appearing in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/sound/samsung,odroid.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
index f35a2694eb04..4a18d83456c3 100644
--- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
+++ b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
@@ -3,7 +3,9 @@ Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
 Required properties:
 
  - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
-		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board
+		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
+		"samsung,odroid-xu3-audio" - for Odroid XU4 board (deprecated)
+		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
  - model - the user-visible name of this sound complex
  - clocks - should contain entries matching clock names in the clock-names
     property
-- 
2.14.1

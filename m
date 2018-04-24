Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AIpwx4/td3x4k4F6A4C2OSWXn9W3KIcM0wX8LNzJ5n6D81PcMlL2yR8CSELWRNjMsWxJca3/Yk8f
ARC-Seal: i=1; a=rsa-sha256; t=1524602005; cv=none;
        d=google.com; s=arc-20160816;
        b=iBuH22yUd99mLXM/7sal6rIBjy+ne8BbsHmwG9ffJgrIlREiS58lG6seTB/VUp59YB
         2kLu5K4JG5jE5VDEaT9le3JLtHYUpFAmXT3GOVBHD5MGvdtfXeZ5G7L7fK0y8VB14Xh2
         iKDOXzpkH1StvYlc4VG7nv/n2TdoCbMu2WoGAsp+X6+AUtboJBKbnPMV7CosimaCUrFY
         0SEaVxO+ahFoH+gm8uwOwKPUAfyxK9cvQ/s+1kzwYtD9910AIkPO7CXZDO3fK+6CwC03
         omZf6dKRTRu+ASuXbSmBL1hraiBUO302h6imdQRfrIiJvxfHs4CVbarcbHg63mUhFqgr
         izjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=FPHdO1e2J3fflVZ7q/2XHCcjcHzfUuYnOi/YzZi2KTw=;
        b=Pb0CWpH9QnNh9k4eHsrpE/6R5VHBVDxKa4FrgKI2kxFCtER9KaZcHvgnojxGJwPyiM
         a+lANC2TKr8RhHkoQp6Fn3QyQJtLJASStGc+eMQGY375UOHiuRmLSU/omQm0amb2EsBv
         bSHm+f6QZVbVkCI4KO9QorRB7ZC8DxGD21GyosvMpnXTkwc9mczF1OQPnShyuJMijo/3
         l7U59GxY+NgwNzzZi9bCu3Kel6ie0gqLxtqfpYAUeyBBQDRLZTo3f3SzL0lnjQ50Y7RD
         nIPydN5vFNgXuvQTleVlmTfOTeIGnf+2GFpo5Vo3W5E4UlhcUki99LI6OV7LqCYtCsNK
         PivA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD228217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tejun Heo <tj@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andi Shyti <andi@etezian.org>,
	Mark Brown <broonie@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 02/10] ata: ahci-platform: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:31 +0200
Message-Id: <20180424203239.21885-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661072571633220?=
X-GMAIL-MSGID: =?utf-8?q?1598661072571633220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 -
 drivers/ata/ahci_platform.c                             | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c760ecb81381..663766685818 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -17,7 +17,6 @@ Required properties:
   - "marvell,armada-380-ahci"
   - "marvell,armada-3700-ahci"
   - "snps,dwc-ahci"
-  - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
   - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a895a459..564570ea3e27 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -75,7 +75,6 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "generic-ahci", },
 	/* Keep the following compatibles for device tree compatibility */
 	{ .compatible = "snps,spear-ahci", },
-	{ .compatible = "snps,exynos5440-ahci", },
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
-- 
2.14.1

Return-Path: <mperttunen@nvidia.com>
X-Google-Smtp-Source: AB8JxZrFIjJrXvwDNGkN9KMxIh3PosnvZ8PZIj82GllnexYe5bLSN03w9K1jsHczKLeqZAu9luSx
ARC-Seal: i=1; a=rsa-sha256; t=1525780187; cv=none;
        d=google.com; s=arc-20160816;
        b=zNm8u9ij1MdK5VE+ZfWWk6SHK+qivAxHO6SEGf3n37jlyRxVzvlJwtYGBJTmHq195V
         EiRM0qpIRj0RFnCTjcLgrpV4D/Uk1czDdAroOy4NJ5CF9np6BQ/cgU6YpXp7M0my4nr7
         GO/U9/nMFkFIvLkYrTqnL5ZJNdWUH5ghStmdc8VI7ueuQr4LxuPeQoKIz+kNb79M94Ua
         8ilsAAhPRnKIByx4hyf3nihG+J1KIpf4HevRY2ZQUQaCvncekygWxWNJAH4NjuGrf3rk
         YgKiUFh+en+h/MGpSqKYTgHaHcbOuQdmWTMRjjh7ms9ABkzhvSwr88MJfk8mvn4DWKWm
         7+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=9/9fxDF9pVaggka6zceAucrvictZIRxQYwl52zu0axE=;
        b=hWNOcdQ1O1WN4epEIYgeuQlfStmeWVo5hjuIZeKhgGqUmNSHoGxuA3Xu0zFls3e1FQ
         VClVKLr/bchL8yT9Xw36uBE8r2XxyW5t6wloqnKQQls+n7KTiWuaaDyQAtqsb7kxwyIs
         1w3oVrkz8OpqS1gnrou4jF3VqFrlEXvzr1NFz1uf5xnqoEuXWm/E5C0HF+2lnT+pftxS
         fl7ocqNbDOt97cF7uySW+cE8gG2E4zTnLUDf0AN/7RqdZGjL1wqQMjthsCmRFQZFF3Pb
         8uXc7PefI30ioIoWUsp+XejfppM7zMAaA++YvMkAwm+4q79TSwjiYS8/BJOdvpnhwUmk
         Mn4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mperttunen@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=mperttunen@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 08 May 2018 04:49:45 -0700
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Mikko Perttunen" <mperttunen@nvidia.com>
Subject: [PATCH 8/8] arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888
Date: Tue, 8 May 2018 14:44:03 +0300
Message-ID: <20180508114403.14499-9-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180508114403.14499-1-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896485341986490?=
X-GMAIL-MSGID: =?utf-8?q?1599896485341986490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Tegra Combined UART is the proper primary serial port on P2888,
so use it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 859ab5af17c1..95e2433984f7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -10,7 +10,7 @@
 	aliases {
 		sdhci0 = "/cbb/sdhci@3460000";
 		sdhci1 = "/cbb/sdhci@3400000";
-		serial0 = &uartb;
+		serial0 = &tcu;
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/cbb/i2c@3160000";
 		i2c2 = "/cbb/i2c@c240000";
-- 
2.16.1

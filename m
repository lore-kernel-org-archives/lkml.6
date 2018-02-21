Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELu/YY2sf4rKXd7SrIhxRC7O6rEJWHwiloDWJb8p+oFKmbMe2gcfHuSgf3g+bskUhzquTUlQ
ARC-Seal: i=1; a=rsa-sha256; t=1519196401; cv=none;
        d=google.com; s=arc-20160816;
        b=HnCswe9iUFZonCEKR5SMHIg98IibFwAY2KTmbEe0JpRo+asbY6pFy3RYAqkCvBsz9V
         t1I3rly+1bQBM/lFPizJB2HqMK5OclZwaMN5zfohBVq1AN4hF7x36ltgjxZDRYtE8ut9
         co6BbFCKl/Gnxz4gYXzx+PCOAn3PowgWAeSqX4OCRqd8qgHbT3PsFu6P2+aBrUZT0Bvd
         cLhdwg8lPkHykhii34NYJKG1uEVWzr2leLwImHbwm1Z6ZFgwlflUPDpQCmiOqFVIWoUj
         ygjOx/+8JPsH7VJqSKBkSSQmeaTQsOKiwP9aQnSuPvh+bi+BbHqOm/y4QVLiIU6fABb3
         XqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=Zkzsd45GOQK4qdErtazaxQwyAwbXnyZ49lGFMObF+TE=;
        b=dWf7CMvYoPFxvrtvsBF6dzhxysB4++EhucW53f8GWFwOlNBhkHvzGGJrBxAsxIqTj/
         pMBf2EVG8Rg6n+oJqnGpoaR8G4gnpmX3CgKlD3ElS1zpKj4X3YxVZ2e/+vyYiIyYZpdQ
         ADTyrkpleO433m7rAJ2FLt7bLob2qHAzycJAPkeXGAnI/y3Wiljvan+htsb7F9ZtVqiK
         S6GAEGBtADIc3KscQoAwnrGX2R+ACglzTlDotOZtQEpThtnWKS65CGAz7I8bB12cMiaX
         m/imiFHNeyjczJFDdEdaGhWOC6ZtMb5fXvISNA9ZG0eZdtvYwCg2k3b+DbtOQHJc15eq
         hMDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:00 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 04/10] hwmon: generic-pwm-tachometer: Add DT binding details
Date: Wed, 21 Feb 2018 12:28:53 +0530
Message-ID: <1519196339-9377-5-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992886059931447?=
X-GMAIL-MSGID: =?utf-8?q?1592992886059931447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add DT binding details for the PWM based generic tachometer
driver which gets the period of the PWM tach-output from Fan
via PWM IP having capability of capturing the signal.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 .../bindings/hwmon/generic-pwm-tachometer.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt

diff --git a/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt b/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
new file mode 100644
index 0000000..3541fe5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
@@ -0,0 +1,25 @@
+Device tree bindings for fan tach output connected to PWM controller with
+PWM capture capability.
+
+Required properties:
+- compatible : Should be "generic-pwm-tachometer"
+- pwms       : PWM handle. Please refer pwm.txt DT binding for more details.
+
+Example:
+	tegra_tachometer: tachometer@39c0000 {
+		compatible = "nvidia,tegra186-pwm-tachometer";
+		reg = <0x0 0x039c0000 0x0 0x10>;
+		clocks = <&bpmp_clks TEGRA194_CLK_TACH>;
+		clock-names = "tachometer";
+		resets = <&bpmp_resets TEGRA194_RESET_TACH>;
+		reset-names = "tachometer";
+		nvidia,pulse-per-rev = <2>;
+		nvidia,sampling-window = <2>;
+		status = "okay";
+	};
+
+	generic_pwm_tachometer {
+		compatible = "generic-pwm-tachometer";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "okay";
+	};
-- 
2.1.4

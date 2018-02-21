Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x227qEm/oS2w29ya1jHOutftoOzd+9c2Dt98nocXbSUSucZ/gJXU8Gt3P0UFFSdEr8oKbhAm+
ARC-Seal: i=1; a=rsa-sha256; t=1519229781; cv=none;
        d=google.com; s=arc-20160816;
        b=KHkicOAyHYH8tch+3KHUfApE0+6HFQblQH3L/tunRgsPkw5c2ohNJNz+lU1EzPPjMR
         AhIejf0YEjTGzKZogezWRokMFKBEKYkeTq5rLJhkFwNclrePNpgiiPFRMOWStzf1Xg/q
         Y//4EBhCyAtq94FuyzxeB2JBe1Px5DoDbq88sx/L4uh8Ocouhfg2XAZ3WIcHvKgkpkY+
         R3rgXWScbtY046tWjQzoaBtOahhboZwPcOlrUw38FatCBbpcfWVp6CcluRWeJR2tgNFp
         +LRdIBOKgQP6ykzpISuz1NHTUAtxoOonHmH00eBKBypZJGyMiAYFvVaBdB47czshO6lD
         levg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uTViNhkTCo8ujDzDLJb/yvJo6M5Dh9BKAuHvexKoJWE=;
        b=P8S9Ol+lGtO9It+QUKaGMRqUUwqBLNEoxNAaXEHyib8FZm7AYSDcoi33Y33GTHdndE
         lY+JszZhvpMb7kZWbfeL9OHlQXQSMfkdRpb6az3NIQERMQsbLpY3TSEnx+GoNZjt+ehK
         GvqkIRwB5YYDM2O9wd7DX1HR/ovBvfl4a727OWO2B/lnlOOfmTZthrH2AAq89J6evBvl
         ugQzADPQo3OjobeKEjSYWbSJ+tE89w0HmCjR8Ulc4XP+iAFF72/h2iMBqrQyx97J7Seo
         JOT1LVIXYY1NC1kk4naDMTJhXUQlGl04jB2Fn1ipXU5RGUrTauteYW4h8zAWcZHPlGaN
         4Qlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617851"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 5/8] [PATCH [5/8] Documentation: dt-bindings: Add a document for PECI hwmon client driver
Date: Wed, 21 Feb 2018 08:16:03 -0800
Message-Id: <20180221161606.32247-6-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027887659877027?=
X-GMAIL-MSGID: =?utf-8?q?1593027887659877027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a dt-bindings document for a generic PECI hwmon client
driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 .../devicetree/bindings/hwmon/peci-hwmon.txt       | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
new file mode 100644
index 000000000000..831813158884
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
@@ -0,0 +1,27 @@
+Bindings for Intel PECI (Platform Environment Control Interface) hwmon driver.
+
+Required properties:
+- compatible
+	Should be "intel,peci-hwmon".
+
+- reg
+	Should contain address of a client CPU. Address range of CPU clients is
+	starting from 0x30 based on PECI specification.
+	<0x30> .. <0x37> (depends on the PECI_OFFSET_MAX definition)
+
+Example:
+	peci-bus@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		peci-hwmon@cpu0 {
+			compatible = "intel,peci-hwmon";
+			reg = <0x30>;
+		};
+
+		peci-hwmon@cpu1 {
+			compatible = "intel,peci-hwmon";
+			reg = <0x31>;
+		};
+	};
-- 
2.16.1

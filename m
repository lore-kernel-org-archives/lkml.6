Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELvqJTwVJ1RKyd/SDFuXX/Liv3BK/dpjyg3Qasu2wtT3zPDSvdPjHxTBv2rU1uciiX10SrYy
ARC-Seal: i=1; a=rsa-sha256; t=1520621063; cv=none;
        d=google.com; s=arc-20160816;
        b=pXIRaHjD+gHKnn4fg2Yh20KKNFiQ4CXEXaKjO1U0EhLmejtu6feZS1w5QJRi17qOZ7
         K+gFJaG653y9z2Ns3FaEqP7Lk7pyrdoddKMTw45iMiJmaVM7GrB1OW3Tj/zo3+ZYATXh
         ZNYo0rNqWkKc6jCUmiCk9EHlnnFbOCZHrLHOtK+lMcfcXhRR9uN0F4iu+b23dNDmF8/w
         zZedJJx+x9rFRkHFh2785OXP5S+4xoRE95MeRvVAZkpDB2g+ipKU3FiIpNM+QE0YkopX
         jeZoH0GS+eHYC8RizH9ohwhl9CME1+n9fMHUzI3OuhfVcqIEJD+AERXuLvlIrjA6XCZf
         aCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=HcqySU9pkkmq0P6N3fqUdE2bu21o7l0jNR1matMCjXA=;
        b=gt98x7IUrQzGndPHHpGFWLerXWXEBt0lWQOAihdzVZjTuWXI+wTkRsRfsvxaliYpb5
         gsXu1Hhs19seyj9DfhDXtug1/qILtB9CuQlExyiU7kOc8SahiyTQLpoByfaYtIXR48/i
         StihHPdZ7/9PzUsS/RHO7PZO56l2o9ahrXXxJAG1AZ4SKbhqhx++JJMnkWwyMDstc+PK
         2C2nuVZcDNHX7YsB89MshmdyylcQlVN6oAbZ79U9qN98FcYFcZ2wP5MVofoSewUR1CxG
         fD/0n60BSbd5seKDKAFGDHmj6jjp8XJrUMAlkfUR7jPlijDUJ75L276hTm9UNJ1cYupV
         mheg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 4/6] ARM: dts: bcm2835: Add VCHIQ node to the Raspberry Pi boards. (v3)
Date: Fri,  9 Mar 2018 10:44:15 -0800
Message-Id: <20180309184417.23368-4-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486752543735841?=
X-GMAIL-MSGID: =?utf-8?q?1594486752543735841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHIQ firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com> (v2)
---

v2: dropped firmware property, added cache-line-size.
v3: dropped cache-line-size, s/vchi@/mailbox@/

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..593f58d4ac0f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,12 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		mailbox@7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+		};
 	};
 };
 
-- 
2.16.2

Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELuhr8a6u+LTPguIJGNds69dIPtcORTSaDjpp514yOAxyCsUjrw6/F0OmGJWe0NMlp8DX3No
ARC-Seal: i=1; a=rsa-sha256; t=1520449042; cv=none;
        d=google.com; s=arc-20160816;
        b=Ym38ADJjl3d0Yk1hfvs+cdi9RLq2P5JXLizAa17M5/Nm4kv2ra0O+wU9HbJg3kqH80
         nrsTVsl2AgJtDWMC+/WBtv2UD77Wg6bAXjvUaGZXGmzrc5YNZ+vSBLSx3SihsyxzPwrq
         KrxHdoprhrUkDXEdfEllVFMQojt7sWpJ4nB9ptrL8eXZ9j+ekGWM/af0OkRQvrkwA6Bc
         ZitqQOutQsOsvABJZsk6CTdM1KDiIrx766CGipBBEb8BZ3HGPcIWINBOfTJVsKBvCxbu
         BOu7YkX8zNYa7CUxnf3qBmdIBONln7SsQ1g0hi6gjipc1GXpx+xiPJYdfqzFp7/hwjwp
         BJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=K8u1nsSKYm+yK5ydKl9jjssm+6yhDKA1RTy0+vTGXzs=;
        b=q8AT3rx7hOioTO2z4/P/EHVGj86NbDi9Vc7azGWfgJWfjC41to96Zo/7eVXGSGVK8L
         IiuASxvH6jkPh3aBaLKWzbfI0I/iOwgybf7RBdpBxNdQ4zg2sP1SAA6hhzwA4EJFjbIQ
         dkw2rsdzycEzXg9mT38A6WXH42sudofAN8HCKQ4jNAZFMNR4V1t/YvAxPUxzSRo6YlFu
         gN+iDP/EytGbNG8DARxkljNBFjq03ySbq5ij1EsOgKFbGFaiOgUCOwvj/mE5cNrrv3EC
         HjJNJltNvEt1eIrUnfTTSRV1kwTgsLwceQmSPaF+iueGjTO94V/fTvr0tjnqTTw9956i
         pOdw==
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
Subject: [PATCH v2 4/6] ARM: dts: bcm2835: Add VCHIQ node to the Raspberry Pi boards.
Date: Wed,  7 Mar 2018 10:57:14 -0800
Message-Id: <20180307185716.17449-4-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307185716.17449-1-eric@anholt.net>
References: <20180307185716.17449-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594306374794647594?=
X-GMAIL-MSGID: =?utf-8?q?1594306374794647594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHIQ firmware communication channel operates in parallel with our
other mailbox-based channel.  This is the communication channel that
exposes the firmware's media decode/encode and ISP interfaces.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: dropped firmware property, added cache-line-size.

 arch/arm/boot/dts/bcm2835-rpi.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e36c392a2b8f..ba6dd25ac93f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -27,6 +27,17 @@
 			firmware = <&firmware>;
 			#power-domain-cells = <1>;
 		};
+
+		vchiq@7e00b840 {
+			compatible = "brcm,bcm2835-vchiq";
+			reg = <0x7e00b840 0xf>;
+			interrupts = <0 2>;
+			/* The VPU firmware will override this DT property
+			 * (if present) with the L2 cache line size value it
+			 * wants to use.
+			 */
+			cache-line-size = <32>;
+		};
 	};
 };
 
-- 
2.16.2

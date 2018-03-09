Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELu59iutxlKinnZKBoam6mnw+oDCb+issnUCbfhBhRZJ2XdSg1/poHtcmK5l/Y5Npk/5/AH1
ARC-Seal: i=1; a=rsa-sha256; t=1520621061; cv=none;
        d=google.com; s=arc-20160816;
        b=0bpAlE4McYosA9C88b7Xc0p7UucM9pA0ZCshos1VVBEJIVWSar37THREHW5B5JLc54
         EjYAjGo9VM/n+817zfIWWib5cYpbySOrfC+x/IckRiHT1ifV63GJ2ahG826mekaFojBJ
         soiDcmIkx+t4T0kWNr3LRxP5tEOuM3aveACdhJIrz0u6MIA1H1Q0XEdkUv8G8Yw3gDa+
         zS74JN5EHSjRiw7LlKBHRig9gvG0x9VqueXB8ZFNY4dMkKHTh9NG3WCFlnSdjPwMwShL
         wqXk4vR1+ovCxqpnWMHkoYPdSpofAkNY4XCk5tprYAEb5ojMC09X2JXe4Lv9gNEF6uPa
         xGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fYTyph/s5nZn7R91iE1w6WddVO6hIkASk43I39xM3xg=;
        b=DZ6H5LojX8TCwIbrZSpeQtuDR5FNrY3jRyS6RQMSIX1ZC51WbWgD1dJRmdXL3zIjsK
         8IGf4oZ08PMkRA0WyTkjHm+WNBQzCXItkeMqyFfY4o2O4U2dtz0uCA2SURLM9J00zi3P
         HwJcF8c6mCgv1Kq+/k0XgI/FouZofkYVuKMnggtAmTpPtx7gh1LKG2huWthPLCcg6y+t
         fSmNtC4jb6nBV7UHhpK+Nf1VrQK+jdztv+JOR24xT0IpUpuW8EPFRaOSXx0BstPAvmEZ
         d2sr4NDKNGd3Lwi0wYySr6Jtv2hcDfBVLaMBkxIzRXf8JHPhwqCNt36SYOj2AJm0Q2Sh
         v2Lw==
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
Subject: [PATCH v3 3/6] dt-bindings: soc: Add a binding for the Broadcom VCHIQ services. (v3)
Date: Fri,  9 Mar 2018 10:44:14 -0800
Message-Id: <20180309184417.23368-3-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309184417.23368-1-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486750832006220?=
X-GMAIL-MSGID: =?utf-8?q?1594486750832006220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The VCHIQ communication channel can be provided by BCM283x and Capri
SoCs, to communicate with the VPU-side OS services.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: VCHI->VCHIQ, dropped firmware property, added cache-line-size
v3: Dropped cache-line-size, s/vchi@/mailbox@/

 .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
new file mode 100644
index 000000000000..8dd7b3a7de65
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
@@ -0,0 +1,16 @@
+Broadcom VCHIQ firmware services
+
+Required properties:
+
+- compatible:	Should be "brcm,bcm2835-vchiq"
+- reg:		Physical base address and length of the doorbell register pair
+- interrupts:	The interrupt number
+		  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
+
+Example:
+
+mailbox@7e00b840 {
+	compatible = "brcm,bcm2835-vchiq";
+	reg = <0x7e00b840 0xf>;
+	interrupts = <0 2>;
+};
-- 
2.16.2

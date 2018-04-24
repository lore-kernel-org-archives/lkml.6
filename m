Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588646; cv=none;
        d=google.com; s=arc-20160816;
        b=jz/uE9+EFBRxaKhJ5HEU/ChPe+t7V10KTulD3/QdTlpWil3IoTZMsgzlsjHnvpfVvQ
         L226qOgUZM/KoekyMdx+TXE8sqL9/UhoYZP+JXUXmKxNT/6QehG1ZLIKhDG/VEAyELvI
         qm84Fy8wGqEE+EJtjnlv/Z4BKaXmAwA/Fr0cvY2HGP9WuI65KisCiRVQqh6RUXOX7kwS
         KmxKQUAsW0U1i71czDZRMHVSYX4L0KL2DFSnS3vkaENv8l8DnwNoueumVkYXrC9FNjfH
         zTJiN12nkvw6CIDmZfD1Rap7a29riL8BnWf39SpTQ73UVmn8HOqB+usgleFtYHr2vFkf
         yDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=SrDwffJ2tXXoAEV7Z6qOPZNJNDpDFoyYg6jyDhM1jjQ=;
        b=S+exRScgs30st/pBMBSzDGS2xfpfyrsZmtG5s10k9ZdA67HH5kfYVQJLmYG+X1MPPy
         DVR+/VXXq1HmX8aIa/OGcYGXFznlAJl/O75q467+/5PdGrADTt23w4sctpqB+IYGBp3D
         BYZog8wkG9ZGSU8r9s1E+dvqVMUxJJgQEN1B/HLLSccK5hJSJEQ2TrbNa+aFIkjXKMW1
         REf0M7Cj+GI53z03laopBx/tDLDOW/8x7SWjc82PDPEeTu/C5WSuyZlvjG5R5yH77w67
         ZxGZGm79IOd+9AYa36piCjglabNqI/QJNOPMfFuT1Ukedaxd7DiInMT2D9YXV1aZ7PVQ
         UXqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=se578fJn;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=se578fJn;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx497PA1iYyMRx0vNMwh6VAVGOOKV/s3gRZdyjHr5FfKQgkyNYnDhoiUV+pg42C6j62pXtgCCTw==
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Date: Tue, 24 Apr 2018 18:34:55 +0200
Message-Id: <20180424163458.11947-5-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424163458.11947-1-johan@kernel.org>
References: <20180424163458.11947-1-johan@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1598647064088300079?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add binding for u-blox GNSS receivers.

Note that the u-blox product names encodes form factor (e.g. "neo"),
chipset (e.g. "8") and variant (e.g. "q"), but that only formfactor and
chipset is used for the compatible strings (for now).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 .../devicetree/bindings/gnss/u-blox.txt       | 31 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt

diff --git a/Documentation/devicetree/bindings/gnss/u-blox.txt b/Documentation/devicetree/bindings/gnss/u-blox.txt
new file mode 100644
index 000000000000..bb54b83a177f
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/u-blox.txt
@@ -0,0 +1,31 @@
+u-blox GNSS Receiver DT binding
+
+The u-blox GNSS receivers can use UART, DDC (I2C), SPI and USB interfaces.
+
+Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
+properties.
+
+Required Properties:
+
+- compatible 	: Must be one of
+
+			"u-blox,neo-8"
+			"u-blox,neo-m8"
+
+- vcc-supply	: Main voltage regulator (VCC)
+
+Optional Properties:
+
+- timepulse-gpios	: Timepulse (e.g. 1PPS) GPIO (TIMEPULSE)
+
+Example:
+
+serial@1234 {
+	compatible = "ns16550a";
+
+	gnss {
+		compatible = "u-blox,neo-8";
+
+		vcc-supply = <&gnss_reg>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index b5f978a4cac6..2128dfdf73f1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -374,6 +374,7 @@ tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
 tsd	Theobroma Systems Design und Consulting GmbH
 tyan	Tyan Computer Corporation
+u-blox	u-blox
 ucrobotics	uCRobotics
 ubnt	Ubiquiti Networks
 udoo	Udoo
-- 
2.17.0

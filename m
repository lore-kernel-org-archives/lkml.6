Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4/iYdMff7yHuaIhGWq5qC8mwqYK6RcXUo4uNQhXkfV82xiPrUTBZz5vUlifwvy1BTuca4uS
ARC-Seal: i=1; a=rsa-sha256; t=1522396077; cv=none;
        d=google.com; s=arc-20160816;
        b=we62pRLzDHJSKf3rU1KVVC3Pxk4710rIF4NnP6hEjuM/Qn5lrinbj+OHY0C/i8FiQG
         Had2G/7XVjyOXzwFeW8XxutNyUFf57xOe1p4ucFw3Dd6RgpcFc2w9Kgg3Rtf+rcdalZd
         Rh/ZBYcgHh3JSM8Ym7F6DaP76lUXa8zMHpav9g/CAWPCxmCyivchOMQ4r4Z0ALMqh1E/
         aGqRBT2/SaGXuHWOHcXu/62nJsbLtKUL+SNO//fREdhzzCE2dayrt0W6rDQ5vvHYmAzV
         XIu+1pnPy2MkfKdmJYEGSQqMQjcQYY+PhY+3CxNHaEdHl1BHAnPk/xggtCEL/a/cckxQ
         E94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=GMZq9f63E5MfZKQ1yo5YcKZ+jJpaMGaf5UZM3Mya0mw=;
        b=UbhYmqBfUGZffonGUnClOKd91jVS5SGPINbeard8z3j+Y6KavfzqHq5YD6sReVIafm
         GL3VBD4YJewGvCQYlu1a2E2g3+XpJt6Jr5OOMDBlpmIkDl8flvtjYN+aQA+0adKMWUL5
         qrKxc8RxpHhTVkyLccTYCOb/N6Ri0E0y/5ckiQBcnHljiy45HUizLIT75yPi2R8lv0iZ
         MTX0bXWTYfCVtH3P7pES7JVRVIIFpf8zzlfpIOJZ5c/L5VLvhiu4ahUmNtevS68KabrK
         Ad3GpCFxqIjMr/RFE9/v6WUfqfc01H4SeAeIBq587ep3BPydsAAXV9tuKBtj418W0TFG
         z8oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 03/10] i3c: Add sysfs ABI spec
Date: Fri, 30 Mar 2018 09:47:44 +0200
Message-Id: <20180330074751.25987-4-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347988973645659?=
X-GMAIL-MSGID: =?utf-8?q?1596347988973645659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document sysfs files/directories/symlinks exposed by the I3C subsystem.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v2:
- new patch
---
 Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c

diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
new file mode 100644
index 000000000000..5e88cc093e0e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-i3c
@@ -0,0 +1,95 @@
+What:		/sys/bus/i3c/devices/i3c-<bus-id>
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C bus. This directory will contain one sub-directory per
+		I3C device present on the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/current_master
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the master that owns the bus (<bus-id>-<master-pid>) at
+		the time this file is read. Note that bus ownership can change
+		overtime, so there's no guarantee that when the read() call
+		returns, the value returned is still valid.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/mode
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		I3C bus mode. Can be "pure", "mixed-fast" or "mixed-slow". See
+		the I3C specification for a detailed description of what each
+		of these modes implies.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i3c_scl_frequency
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I3C SDR mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/i2c_scl_frequency
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		The frequency (expressed in Hz) of the SCL signal when
+		operating in I2C mode.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		An I3C device present on I3C bus identified by <bus-id>. Note
+		that all devices are represented including the master driving
+		the bus.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/address
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Dynamic address assigned to device <bus-id>-<device-pid>. This
+		address may change if the bus is re-initialized.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/bcr
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		BCR stands for Bus Characteristics Register and express the
+		device capabilities in term of speed, maximum read/write
+		length, etc. See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/dcr
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		DCR stands for Device Characteristics Register and express the
+		device capabilities in term of exposed features. See the I3C
+		specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/pid
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		PID stands for Provisional ID and is used to uniquely identify
+		a device on a bus. This PID contains information about the
+		vendor, the part and an instance ID so that several devices of
+		the same type can be connected on the same bus.
+		See the I3C specification for more details.
+
+What:		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>/hdrcap
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		Expose the HDR (High Data Rate) capabilities of a device.
+		Returns a list of supported HDR mode, each element is separated
+		by space. Modes can be "hdr-ddr", "hdr-tsp" and "hdr-tsl".
+		See the I3C specification for more details about these HDR
+		modes.
+
+What:		/sys/bus/i3c/devices/<bus-id>-<device-pid>
+KernelVersion:  4.16
+Contact:	linux-i3c@vger.kernel.org
+Description:
+		These directories are just symbolic links to
+		/sys/bus/i3c/devices/i3c-<bus-id>/<bus-id>-<device-pid>.
-- 
2.14.1

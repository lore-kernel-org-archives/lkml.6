Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518548056; cv=none;
        d=google.com; s=arc-20160816;
        b=URgGhBHaPd5tS8FCHmlqVGcDWdX6/0yEQCTqcCAB/S5N1MQszxWTbiRTkdl7Pi6yHE
         VulXMTYhpBKa87Ht6oouFy+YPMyKNV4CKG7BOBNLIxWdNuWMnCWXz7tKoA/oGW6H+joU
         7T0tWUgZTybkOv1qmGyBFO5qTh3pPGuuQ0uxMQ4tZrBXdF7Zjrxp5FuCsujOuAQoCGKZ
         f9VQ9Z3PvEsqeSTLshBUrxSAGnVj/1g7sOVL2PAxrJTo51gYew0oUE+8nlq8FtgyyIzb
         0mZ85W63EvpKObA8fOMl1I57O3i9cFloWkt/YjiZYh5ZOVDIs1qN4sqmlxz5pznrASCJ
         A/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=rsg17EXKjztZT7jzMlPl0xLfdwVXGTjmW2yYpmTB9MI=;
        b=fN72KkWbfMQv+z1qmCf68ZusUIxFIm0W7C3afu8iHzJw+2HdUFOfxGWm55xPtAH4nF
         5zEnp4QAYFj5Gi+jU6odeIB6K+tVZJb6wGjzmf0DxaBPkQw8WtU5M9ab3DYjbzQBqAGm
         n49wcOCp1NIGF+OuxUU3+fYM6JhcrEdyZR16kZX7944jeukQwHg6WHxYvZh2dXnt1+KO
         Xa7FI7+dXNrfe91UJkYmRGoY+8KKiIF69K4zGAEQ4xPhmCGRQubwJx8NUQM56cm0YdgM
         hcVTH/Cn+zkm9ZfBHqFk1UKoBnu8fSFtaFJPLWOLRLUTEetQhRvqufg8no1V7NcSGuao
         Y3kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uTBiyvIu;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uTBiyvIu;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224hZOeearA1J38fPELT1V8sEXPByJKj0U1LIXSdkf7usHrYiYJa/iqQS6FwFytKYNZa6pc70A==
Date: Wed, 14 Feb 2018 00:24:10 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] acpi: device_sysfs: update sysfs documentation
Message-ID: <20180213185410.GA27234@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592313046574811248?=
X-GMAIL-MSGID: =?utf-8?q?1592313046574811248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add documentation for two attributes - status and hrv in
Documentation/ABI/testing/sysfs-bus-acpi. Compiled from git logs and the
ACPI specification.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-acpi | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI/testing/sysfs-bus-acpi
index 7fa9cbc75344..89feb01d1d0d 100644
--- a/Documentation/ABI/testing/sysfs-bus-acpi
+++ b/Documentation/ABI/testing/sysfs-bus-acpi
@@ -56,3 +56,39 @@ Description:
 		Writing 1 to this attribute will trigger hot removal of
 		this device object.  This file exists for every device
 		object that has _EJ0 method.
+
+What:		/sys/bus/acpi/devices/.../status
+Date:		Jan, 2014
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		(RO) Displays the ACPI device status - enabled, disabled or
+		functioning or present, if the method _STA is present.
+
+		Return value is an integer containing a device status bitmap:
+
+		Bit [0] –  Set if the device is present.
+		Bit [1] –  Set if the device is enabled and decoding its
+		resources.
+		Bit [2] –  Set if the device should be shown in the UI.
+		Bit [3] –  Set if the device is functioning properly (cleared if
+		device failed its diagnostics).
+		Bit [4] –  Set if the battery is present.
+		Bits [31:5] –  Reserved (must be cleared)
+
+		If bit [0] is cleared, then bit 1 must also be cleared (a device
+		that is not present cannot be enabled).
+
+		Bit 0 can be clear (not present) with bit [3] set (device is
+		functional). This case is used to indicate a valid device for
+		which no device driver should be loaded.
+
+		More special cases are covered in the ACPI specification.
+
+What:		/sys/bus/acpi/devices/.../hrv
+Date:		Apr, 2016
+Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
+Description:
+		(RO) Allows users to read the hardware version of non-PCI
+		hardware, if the _HRV control method is present. It is most
+		useful for non-PCI devices because lspci can list the hardware
+		version for PCI devices.
-- 
2.16.1

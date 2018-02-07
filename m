Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518009504; cv=none;
        d=google.com; s=arc-20160816;
        b=GtFqy7kXCkt7v4vwM8TC26rC1LLM8ri3MY0UDYJZTvZJRXPnzAiP368Q3KpHmMxjsM
         Hqak4VPvEwxYRfkoxgVKrmlRoX8HlZzf9TFrQTelOTOqAgyXetiqACL1ibWULDE7kfCk
         ZrQDLS80AQ4YMyOCyEFdlpgW4Hb2r/CcsDTHIrXygwNEAy2ZfDrhYeQPq2PiQSV/k53B
         coXGDV1YftBp5FJss/BnTL4G7O6fiat4rsz1V4o/j6j+FOwVsWbokT4+y1ddX5EYw1FG
         +9WU75DSGWNEkwMfazOjEYVTEu996tuG1PkN7L6zFZRDgjNXFnnUj+GXOlt8ZmPY5S2r
         gPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Zq7vQBszJtft0Pv1q7Tk+0UdZoM+J0otqiP27P1D9co=;
        b=ykA1w/i8NoKUG7SWbZt6MLhly/0mAcww/n9VWJFXplyVMlGtKVlZs12sot7X/k5P/7
         4Yg32g2qATlIjjR4rbrBT4O4a7Sy/HJaRAKoch3w1ZwUoA8D+Zux59WkiHkFPd3VwK9W
         Q/qJOjqh43Ev+CsW4q9JrNDzWmhpmU+cixvc+++Kfbubw6xF3PH344WuqU6vReqOH9Hl
         h7+8uS0lwnC0iCeI2gV03uFSg4DxM4WaJr9ZPA8GJmR5RGvDdMPF5dFpHJ77TUp0i55Q
         UqMHh3palCA6Ro/yI/YR+pLzoW/1EkAK6OQz2dLbrzUZGOsHwZeeQINOouO5F/wwL6XP
         bIeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b7D6NGmN;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b7D6NGmN;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227uyxeSdcfeTjA0bq/0cmF1Xxvit+YgAnBCpbDrJJFR2FPYp/zQONbZtiGihmazJ5iZfZxt4w==
Date: Wed, 7 Feb 2018 18:48:17 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v1 2/2] acpi/dock: document sysfs interface
Message-ID: <9dff9dee68daf82305de32c45604757eca93afaf.1518009225.git.aishpant@gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518009225.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748334124741028?=
X-GMAIL-MSGID: =?utf-8?q?1591748334124741028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Description has been collected from git commit history and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-devices-platform-dock        | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
new file mode 100644
index 000000000000..0bb0d42e9126
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
@@ -0,0 +1,38 @@
+sysfs interface for ACPI dock station driver
+--------------------------------------------
+
+What:		/sys/devices/platform/dock.N/docked
+What:		/sys/devices/platform/dock.N/undock
+Date:		Dec, 2006
+KernelVersion:	2.6.19
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		docked: (RO) Value 1 or 0 indicates whether the software
+		believes the laptop is docked in a docking station.
+
+		undock: (WO) Writing to this file causes the software to
+		initiate an undock request to the firmware.
+
+What:		/sys/devices/platform/dock.N/uid
+Date:		Feb, 2007
+KernelVersion:	v2.6.21
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Displays the docking station the laptop is docked to.
+
+What:		/sys/devices/platform/dock.N/flags
+Date:		May, 2007
+KernelVersion:	v2.6.21
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Show dock station flags, useful for checking if undock
+		request has been made by the user (from the immediate_undock
+		option).
+
+What:		/sys/devices/platform/dock.N/type
+Date:		Aug, 2008
+KernelVersion:	v2.6.27
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Display the dock station type- dock_station, ata_bay or
+		battery_bay.
-- 
2.16.1

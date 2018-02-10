Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518253064; cv=none;
        d=google.com; s=arc-20160816;
        b=NpGOYb+oXJW86YzOaU15pU0lel7JqWzHevl/lQOEG0CJyjA2eg8WIdXzyl6/9+91tn
         9EYelMhH9NNJFh2ZfV8BtnZAvJsDBHzPfn5uateQSqX1R751dPNhL8qHAlZ/XIoSejaF
         yF4wUGoCEa4+XCdyFzVUmIoR7IW/m2a/yGi/5zjIdMdpZoD7KWqCIDhDTyxB8GtN/9WI
         7Y1Qb3SrjtpDYF60HE2dDO7iFRlQYVG4Cv9w4hwWyDYUEuqFtKmm44CzlbEAMOrBZLze
         0FcP9lut+RWR3i2QbEsmD4LGduIJl8G3BppBfkWoKew9sSMEuNFB+mUrznKuc1ki7LHF
         V7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KC/xvYbcoSBaXlH+IQ3phb/1sJpYauN0C9my7sRNl4I=;
        b=V2KjOvpmjvsrHvDO/Q07SWLuNO6cIGFVexRRxe9aF0BRLrO9kC9zWPHDZcbTLU4xim
         uxtm+HB0q8l9VcTLodK5jVAJcHzierofJ69jKi2UMmiZpLisRqMXowbCXT/JU7phx+8l
         Q8K5ZvZkws/2Aa7WiYstdQSzd3tsSb0q8L+9k4wW3yDkJVa6Nd7fOlVcGL3ERW8YKzLJ
         CZeNSkU1gRamQmXtVcAmdT9ge7O6TpkJsLl3UyyzPi9sN1OBdpbj7IrtXswYKYdvzJS6
         4n2zLyxeQJ/y03e8O8+PuK0Cftfl8LAFL8VOLbtzLL7nr8j86iq0/6aQ4ZfKzBrZnKKX
         Srag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bVd08x2A;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bVd08x2A;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225uO0IhTCj6SxnYO6d59sgkfxbK6QqMN+/HnKnasGv9EPVLwuYaAZECWd5eMusxTzaPPmYRDg==
Date: Sat, 10 Feb 2018 14:27:38 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2 2/2] acpi/dock: document sysfs interface
Message-ID: <4766f754e929cf4888ebe4da8d406d29bf07436c.1518252138.git.aishpant@gmail.com>
References: <cover.1518252138.git.aishpant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518252138.git.aishpant@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592003725146559257?=
X-GMAIL-MSGID: =?utf-8?q?1592003725146559257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Description has been collected from git commit history and reading
through code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Split up attribute definitions

 .../ABI/testing/sysfs-devices-platform-dock        | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
new file mode 100644
index 000000000000..1d8c18f905c7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
@@ -0,0 +1,39 @@
+What:		/sys/devices/platform/dock.N/docked
+Date:		Dec, 2006
+KernelVersion:	2.6.19
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(RO) Value 1 or 0 indicates whether the software believes the
+		laptop is docked in a docking station.
+
+What:		/sys/devices/platform/dock.N/undock
+Date:		Dec, 2006
+KernelVersion:	2.6.19
+Contact:	linux-acpi@vger.kernel.org
+Description:
+		(WO) Writing to this file causes the software to initiate an
+		undock request to the firmware.
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

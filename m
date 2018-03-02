Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519996619; cv=none;
        d=google.com; s=arc-20160816;
        b=uxN62vF6Gtf8vtrn0MxOakdlInbnqMF8anHcj97DHKgrDUNWFcrz25Ga+gKuZwYpfY
         WnYHb/aD5AgGp+zCZOrIVG3yugkNJAz/zLoVdjbsFkh3beARJPgp1GsasNWDEMSujdps
         LeW7CHvIGRs53ZZAHt9NFo+U4B/+47IWVRLWLJgAHEhCqTjEqaawBCtlxsz7qW1GxLOS
         45qmjxPGSPCXo7X+cTCDe4+e17AXNBlAxIHyGWaLmM+QoTBZl2AMdTPZzQwtYLdUy87X
         +OmTFSy0WCHgMGcohDe/MUCYYPi40+Ke+f0xdC7z6C+lvPVW+BEvTuTJCEXmUetoohir
         F7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=/c/v8m0ONk5DalxCyAZvPiHHkI8OSDThXBbg8q/HPPg=;
        b=eQAX0uBEPIYuYK5DLmjgTYVB+t6TtYDQpJynBwu72MBKdCeLvuyO/8o8Q1QdbRTr3a
         bSKJN68a/6k3HG59H9SI7A0hNvx2LkHVFUGvqoJf1ZrCDJ1QApkw/5c8cglstsHGlssF
         hLbHin/XXWaWueAXpgzkG1eeitn9r+I4IXci4q80WqKpp2VksxlshRwk7WSgiOgRMtzH
         h0chrMDmdAW2qWcM47BsIdI1OJpzxh/6K8FyGZ06ZpVKzT4SmBE30tsYiJxvOwu4G/+m
         tvM0UgIbvidv5Y+E1bgDOZG6j7FkvwOBAYZ94rb7NLzbsK+0BvswFYy1Z3y2cgM8wsSL
         WoJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rkDtTcEH;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rkDtTcEH;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvPffTjbzAMVu37MSafOjhLKZ+oRcUJQCdivuscfY9mwnF66nDp26nbeuVTXzPHNrP6/6Jqgg==
Date: Fri, 2 Mar 2018 18:46:53 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: document sysfs interface
Message-ID: <20180302131653.GA24934@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593831975590179411?=
X-GMAIL-MSGID: =?utf-8?q?1593831975590179411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Descriptions have been collected from git commit logs.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 .../ABI/testing/sysfs-driver-hid-logitech-hidpp       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
new file mode 100644
index 000000000000..d8f831f2d6b5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
@@ -0,0 +1,19 @@
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/range
+Date:		Jan, 2016
+KernelVersion:	4.6
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) This attribute controls the amount of 'turn' permitted in
+		Logitech G920 wheel. Reading from the file shows the current
+		range of the steering wheel. Writing a value within the min and
+		max boundary sets the range of the wheel.
+
+What:		/sys/bus/hid/drivers/logitech-hidpp-device/<dev>/builtin_power_supply
+Date:		Apr, 2017
+KernelVersion:	4.12
+Contact:	linux-input@vger.kernel.org
+Description:
+		Presence of this file indicates that HID++ driver is capable of
+		handling battery properties in the kernel. This way, upower can
+		add a udev rule to decide whether or not it should use the
+		internal unifying support or the generic kernel one.
-- 
2.16.2

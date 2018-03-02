Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519968624; cv=none;
        d=google.com; s=arc-20160816;
        b=uzTxZRXDG6kHkX7cYROlVsVig4JkivxB5WJH39J/U1ay7c3YUzdVus6aFxnte4wgdk
         nL7ceYN89FVc8ldOUwnpnZi/gZBYJfweT3528LRWTk97aTn5rPfW11lqxndJbt42M8TX
         x84ZdPpd6voj1Yct0HnHWzocQNH8TzTpWM90PSZ6kQajwAHnGWQH0fzVOgmNuyM8bypT
         yV/V/d6oL5mDShEBCZatqeXsFiir0KmYiff+HgKYrpqwwVbrYS9Dj/0Lri53Oc9wTt2Y
         x5fLRRpoO9Movc15tzW63JcgEziQ/4THEuinyIuo0iEGrcuUxeHXPrI/7rVPLfq2iQoz
         OR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=EKWbNuOaB7J+Nkp4GsAVxPYK91Ek95LW31erYN7HkVE=;
        b=AOGP3t6zjDALreO/LNWJ1k7ug8OmeTovu2anZ9/K/V3f0hLNk7VK1ihH35u4zNa7oZ
         NMWslXDFRKSOxemM5j692DoUKfXkCIjL6wyL+NTcRIPjK8LUAIwmQB7eEJZVDP3ffBA4
         6f1Diw6i9Uo7XjRpDZNv3uQnlh8yzWD/gmJJeCQeBFMfkcmnMX+3ONknqXLyggHo+KY9
         MVFvgafJVg2sl2N+H56+cDKrwQVJOqJAiDrqchMgU3x7jvQIfLmYy93GKFUqJCSzTJuU
         mlY+MDZvF8fQS1oXG9plEvngCd3eNBzES7k1bjlqqu2kgBnIuiUHNluuoF5V8BOV11OW
         c3lg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sgw5VvCc;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sgw5VvCc;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsbq85IhgmMn9W7PEEwB9eO109LFup3U+V+2Zt5jXmegS7owg+qxwUlHb6ctQB+h6WocFgbfQ==
Date: Fri, 2 Mar 2018 11:00:17 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: [PATCH] HID: ntrig: document sysfs interface
Message-ID: <20180302053017.GA23123@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593802620168296630?=
X-GMAIL-MSGID: =?utf-8?q?1593802620168296630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add sysfs documentation for N-Trig touchscreens under Documentation/ABI.
Descriptions have been collected from code comments.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-ntrig | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ntrig

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ntrig b/Documentation/ABI/testing/sysfs-driver-hid-ntrig
new file mode 100644
index 000000000000..e574a5625efe
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-ntrig
@@ -0,0 +1,70 @@
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activate_slack
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Number of contact frames ignored before acknowledging the
+		start of activity (activating touch).
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/decativate_slack
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RW) Number of empty (no contact) frames ignored before
+		acknowledging the end of activity (deactivating touch).
+
+		When the last finger is removed from the device, it sends a
+		number of empty frames. By holding off on deactivation for a few
+		frames false erroneous disconnects can be tolerated, where the
+		sensor may mistakenly not detect a finger that is still present.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activation_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/activation_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		Threholds to override activation slack.
+
+		activation_width:	(RW) Width threshold to immediately
+					start processing touch events.
+
+		activation_height:	(RW) Height threshold to immediately
+					start processing touch events.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/min_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/min_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		Minimum size contact accepted.
+
+		min_width:	(RW) Minimum touch contact width to decide
+				activation and activity.
+
+		min_height:	(RW) Minimum touch contact height to decide
+				activation and activity.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_physical_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_physical_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RO) These are internal ranges not used for normal events but
+		useful for tuning.
+
+
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_logical_width
+What:		/sys/bus/hid/drivers/ntrig/<dev>/sensor_logical_height
+Date:		May, 2010
+KernelVersion:	2.6.35
+Contact:	linux-input@vger.kernel.org
+Description:
+		(RO) The range for positions reported during activity.
-- 
2.16.2

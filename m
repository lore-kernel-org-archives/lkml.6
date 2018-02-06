Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517946021; cv=none;
        d=google.com; s=arc-20160816;
        b=xhfzaN1nyL9Gpd/ZBI+Kg1V57OQBMf69c5zbe84fGd1zvYL5zEa3eHI1g2628AVRXu
         RNFjtP90Tx6u5sJ2yrUt6R/bYAKqj5KGqmmj7AszcRpbrb+FmbYFgAVP6efv2hqCclR3
         iwsHmbLm8LQwrMyjquPt35xjv8I64KCGAgTGWmZVkL0z+2/HsaB5DnAvaXcJdT8HHDC0
         K2sFitBUHAGOLH1QM1nKRYOFwMUahn1vAyNXhsd+JKxdiQwRVUwRtXal1JsGQJ7OQ2/6
         nycU0VNd3LLgc068Sns0mAYduSHPGOP7+948AhqgDinuMUgAuk+YBaElsMIxHJHngvo5
         llTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=SIHVmjPNbnMowrZqFne4EDMnxA5ZwFWwfFsoAeevwj4=;
        b=zAgXhCgwsIp3vZKfvqJEQ4vsF7FaT/0Hg6kvtf/an7OIuSZguPL1aSXkufwhjMOl3Y
         p36LY5ecMl5WQS/LbNvgQAKt8POYJszmevGSlUTeQ5o0v+41HqxF8CzHzGbwpqwzGroN
         SRbyKcxN4Iy59kyMAAgto2FfLjv5/7b+eqx3J2nHV7eUngf6aQiExPRHN/9Ru5QFZWGj
         NeF+8F3UOISsA0Ya4rtH8B6WKLia4KClOCeKdWsJhjHgpbUHvKQ2hEh6Gx3mUb/5fKlp
         suCuEfGgywle93xFfXpIFhcE5kctU7BpnDP8XoffaMt0u0wfqAXGQ2/7wX28XfAZ80tD
         FyqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MY2B+1ir;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MY2B+1ir;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226h0uo5bmVb/q9gwJJobTo/vmBpX8wiEIfOIejDvFhzM6dzw/QFMuEbQc96yR+mO67773GdZw==
Date: Wed, 7 Feb 2018 01:10:13 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	InKi Dae <inki.dae@samsung.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v2] Documentation/ABI: add sysfs interface for s6e63m0 lcd
 driver
Message-ID: <20180206194013.GA25380@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591681766852646908?=
X-GMAIL-MSGID: =?utf-8?q?1591681766852646908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document sysfs attributes of s6e63m0 lcd panel driver by looking through
git logs and reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Update contact information

 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd-s6e63m0

diff --git a/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0 b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
new file mode 100644
index 000000000000..ae0a2d3dcc07
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-lcd-s6e63m0
@@ -0,0 +1,27 @@
+sysfs interface for the S6E63M0 AMOLED LCD panel driver
+-------------------------------------------------------
+
+What:		/sys/class/lcd/<lcd>/gamma_mode
+Date:		May, 2010
+KernelVersion:	v2.6.35
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(RW) Read or write the gamma mode. Following three modes are
+		supported:
+		0 - gamma value 2.2,
+		1 - gamma value 1.9 and
+		2 - gamma value 1.7.
+
+
+What:		/sys/class/lcd/<lcd>/gamma_table
+Date:		May, 2010
+KernelVersion:	v2.6.35
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+		(RO) Displays the size of the gamma table i.e. the number of
+		gamma modes available.
+
+This is a backlight lcd driver. These interfaces are an extension to the API
+documented in Documentation/ABI/testing/sysfs-class-lcd and in
+Documentation/ABI/stable/sysfs-class-backlight (under
+/sys/class/backlight/<backlight>/).
-- 
2.16.1

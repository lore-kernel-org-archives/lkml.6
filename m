Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519392239; cv=none;
        d=google.com; s=arc-20160816;
        b=shI/p12P26NbrabnqmiuWg6YMHHEXfm2JPAOw6U5162niIxxud9jdbfav0Mr7Ysbnk
         AfOmFBZOnJSdu65IydpxFXeuJBY3f7MpA4uG+2RQub/X8qHP0DQVxlH+Oi6hFq5iYyfm
         ygksUftWWpNtY5R3IiPhnnLb8D3Vjg1Yez2GJaDj6OI6WC+lQm/dE40LgWgw/Bn9YS0+
         60CJ+j6HAxOAvkshPjBtZdYwzDXH6/OshVpG6U4uXBFPbtHfK/pkoBEqoz/mLQL3p529
         NY9U1ZUEL9On9JtecOHamRLvl3KyZgq0jlV2HonXvGminj+RH0yGVSIbmRNO4At9BGGH
         uk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=gH6Fu6AEanmJJDSUG0WZWf82HU3ZTOLCjkrBETjS4jk=;
        b=j93TZxpFYdWsVcjv2EP4BE5dNDVX+V6mQRy7JIN9B9Vu78YBCoNQeRFGtt3ppIe5Ci
         /et71t2URSIV/1RhUtZG1EHbvtrnMbRPALNq7Q8eI+ma7lMCliZCt6Q/26PY5onmLEH+
         dF6FdtPD9FgkmB+YuBP13fAJh27JmvuEVc1R8VXisEytW8UajXzzGHP7d9y0ltWh/gKZ
         BZgDQYaQnEuAMbHNlAzjDAVc3klhz3IwhvnGMQv3cCZbR4iLJqCQDr3/eHIkTd8FHt4+
         TyZwHJ+uPXQ+N7HxVQ3n3CLwYYyNtxJy8EGArpy3eA1s0W9k/rF1Km4XMsLv+knrhoyf
         5b9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KLZLLtwT;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KLZLLtwT;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225pdclbAtQ43vKbNFoMnoBcHfMH0fDI1WRujqbvtrft0rHBmCd27OBB3AUJZjgqjjCq674Kdw==
Date: Fri, 23 Feb 2018 18:53:52 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Lee Jones <lee.jones@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [RESEND PATCH v2] Documentation/ABI: add sysfs interface for s6e63m0
 lcd driver
Message-ID: <20180223132352.GA25436@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593198237571612180?=
X-GMAIL-MSGID: =?utf-8?q?1593198237571612180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Document sysfs attributes of s6e63m0 lcd panel driver by looking through
git logs and reading code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Convert spaces to tabs

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
2.16.2

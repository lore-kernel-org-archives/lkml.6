Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518847990; cv=none;
        d=google.com; s=arc-20160816;
        b=AKaB5CdCUIJbcRcNUC7VkYGRsKzlYFRXoxWLpiPWiCT7gBvs7ox7oAok9X4Sjr8iJR
         M+Q5IW849jZKnvVETdp7IEwUjOIHNGTXg2a1fvJzwvNEc2dwhBLQqQk4AXyS5fb1BNzM
         1JOx90gjTgwICZUzl3k+lprqyHEjIYGLF83Y/zLEwr8LAqJzTpToXQWlnkrSh76ylGqR
         d5L1gSI8q/OQ1sWBOIREZ49P5bBBAS6WRNh0Y6uzAe068IUZhrLw4IkqQJFRPXDu9YS5
         uR6b5t9AFEIGtrE0pUx4fP5mUuuhzu9FeyNXh+LsWq/c6YWakPpUdogIGEIB42Xrwo2h
         /GpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=qau8JE0myrVtuJ9r/HjUOQm4ETdWsobeh5D6wkv6K6o=;
        b=nkLznGQOxjIU+J10Z0V0IsIamATy5u5flE1Yp7G1PUxbdbmFFHBLE9a2puBj/gy+DZ
         WmOYDp6sujY1KOWEW8QQoUOkfpdNNfy4AXmMuEXrDrGNsNkulwnk9cd+bKL+3Q5R1n6f
         VBDu2MNu5yl38ksVmEafOLLF20wh12HhUuQYu0cGAYnlhISqvAfAi9uHclawzQKogro0
         wUaUe27t8V2D2rAAHzHTEl0fKqPfDfLjOBLop4m6l0HfugKd/RD9+qQQM3K3XbADFkws
         n5N4qdqWk3AXnKg6Le96HhVmVpYExKhX6YGErRQXXud6hMPuI8o8eCF6PpDG2Fi6m5UD
         qV9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DLigs2mJ;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DLigs2mJ;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224ZYJ+HKWSnZSjsniWN7tfqy5MTEPjcQiJcv0zKLTUfXlGqq/ArYE/6Ars58U2kr8UdpoUl/A==
Date: Sat, 17 Feb 2018 11:43:04 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: linux-block@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: [PATCH v2] block/loop: add documentation for sysfs interface
Message-ID: <20180217061304.GA14083@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592627550453000826?=
X-GMAIL-MSGID: =?utf-8?q?1592627550453000826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Documentation has been compiled from git logs and by reading through
code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
For drivers/block/loop.c, I don't see any maintainers or mailing lists except
for LKML. I am guessing linux-block mailing list should be okay.

Changes in v2:
- Add linux-block@vger.kernel.org to the recipient list.

 Documentation/ABI/testing/sysfs-block-loop | 50 ++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-loop

diff --git a/Documentation/ABI/testing/sysfs-block-loop b/Documentation/ABI/testing/sysfs-block-loop
new file mode 100644
index 000000000000..627f4eb87286
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-loop
@@ -0,0 +1,50 @@
+What:		/sys/block/loopX/loop/autoclear
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if the device is in autoclear mode or not ( "1" or
+		"0"). Autoclear (if set) indicates that the loopback device will
+		self-distruct after last close.
+
+What:		/sys/block/loopX/loop/backing_file
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) The path of the backing file that the loop device maps its
+		data blocks to.
+
+What:		/sys/block/loopX/loop/offset
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Start offset (in bytes).
+
+What:		/sys/block/loopX/loop/sizelimit
+Date:		Aug, 2010
+KernelVersion:	v2.6.37
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) The size (in bytes) that the block device maps, starting
+		from the offset.
+
+What:		/sys/block/loopX/loop/partscan
+Date:		Aug, 2011
+KernelVersion:	v3.10
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if automatic partition scanning is enabled for the
+		device or not ("1" or "0"). This can be requested individually
+		per loop device during its setup by setting LO_FLAGS_PARTSCAN in
+		in the ioctl request. By default, no partition tables are
+		scanned.
+
+What:		/sys/block/loopX/loop/dio
+Date:		Aug, 2015
+KernelVersion:	v4.10
+Contact:	linux-block@vger.kernel.org
+Description:
+		(RO) Shows if direct IO is being used to access backing file or
+		not ("1 or "0").
-- 
2.16.1

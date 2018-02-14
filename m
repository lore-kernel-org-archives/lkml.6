Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518620911; cv=none;
        d=google.com; s=arc-20160816;
        b=QI8GTY//cpTSXlGNZogh1pO9dVnuXMXOTRghIiLPVg0nSN2XLcZRxi5F0mqmqCcb/s
         fTaYDYgMQhwOviYnKUHJy+5vQZ/cz9Qfvs0e+s3FJjfNHrLYLqLa74Fib2peRLs3Bd5c
         uLZA+cIR5H8lSG69Xbw2WONgeY/3ZMO6jT3MR+fOXp5IZUpcedbaM6ZeN79fAgaHyXCZ
         MbNipGNdioBUDofDi6uPwbhekN9mamjIqQIUcvogrO1vc15mZrGPkChSZpV3TTYeLR/4
         aaLkdb3EeyTdmQYs4R/E4TiRw/hEwAd8PFBpLRNK+CDmANf8BIeuIkjNv/5b+h4LwtyX
         bR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=kLAKW3+lJWnPY8mgIrPeLxQBxnFlE14bpEeXicjl6ok=;
        b=v2qA1gdyKYF3Cm3Q5Ke2Wo3qGFiJludn9RYRKz4VC/0ZJwPBhCS2am1V+r7NrgJ/R/
         N0MQjoGUo5mIsSn7DwUu6pJemCis4kcH5oVWFJZEUL6xe0yWUV72hsLhwS9qrzPJrtfH
         YRpc12XInLCTKqN2J0JEzgrpz0BAgsyp4Y1Gdzag/5cn0L9l2oGCC+dzEeF2v26nlNXn
         rRmtB+6nV/XikgUSatcx0kECDl6S3kByeulYwR5MFkl57Qrp6AELoDuYswfSGT/C9sft
         RDQvCDm6ZaRtYmFVm9Ndk8mnu3pXYtZsn5t9OdvXdo5/z1oOVBZhal6VAOsGlpItacZT
         6/sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eiL3NH2d;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eiL3NH2d;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226HZImpb9o0Epv8Ekenw8rMkchkf0yxbMquMjTA49h6w907Vh9Vu71nspp6qOK/nqw0nw421A==
Date: Wed, 14 Feb 2018 20:38:25 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] block/loop: add documentation for sysfs interface
Message-ID: <20180214150825.GA4764@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592389440871916985?=
X-GMAIL-MSGID: =?utf-8?q?1592389440871916985?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Documentation has been compiled from git logs and by reading through
code.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---

For drivers/block/loop.c, I don't see any maintainers or mailing lists except
for LKML.

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

Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519391798; cv=none;
        d=google.com; s=arc-20160816;
        b=xXW1ykbQxwPXyqeKhmM9H8GmcpFKfMxgjEe2rk2OU305yN8ycuOtvniXY5EbYxLSDv
         Rb6gPVNwpAIMU/BRSdAW8CdEzS/2/xZUCb7DJXt+aZ7LppfblA3xPDALJMmsDpwnb/PK
         u8AvfYso266zfE0v+/MMRmnUeA0A4liJyQeebbc08p95mUV0v8D3f6duqgACi1Jy2ZvJ
         K5JrIDp8QgzQyes4uWuMr7Jkt3DD3OjKqI6BhD8wnSqy+1p7S9OAzeCK0GduOPm3qQ/V
         H6V4RpLz5m9wIID1TM2xBAUEWXEtCBpMfyVkfi4aGJ6NKCdhOGz0nG6omsm6U/TOSEDG
         ejew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=3Cel6ihyHaatehwQY0uV+uzpvTe+wT6RZQrqWcEUMVM=;
        b=wiTQFF0n3prh9Y6JO332y9AKAUDjG0zr9JkSm2NFjyM63NZAUdrjLb2y47vAoBapKL
         dZbG61aMt6SK59XqB8QmyoXlGZk24A4yXbYlfYe6uabVuwZB4PeSUnFa0YREZExRIZZ4
         0PgQ482XkPkphz7gK9kFaZR3kaozUlAXnMfYHCTD9Yn7kybWIFM4eRiHE2e5pn2h0pD9
         P28ZIsd5IGmiiqgv739skrN92I24Nq5iRloNo2sYScDU/KrLJvBNbAbRFmTq5x2sMfyl
         F6htgcT99HCtc7Aa+k4cKVw/kSjOsnoZf3fU07//UQcG5YSIjXus2zDEDE9qplsheeWM
         7LlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=De5OdvHf;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=De5OdvHf;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225JbfhOHKsLmshTa9Wayr+6RKgAIRGWzw8GANWWmZLbZgNiXFVlehsArwlw0iNEOc0MVcM3kA==
Date: Fri, 23 Feb 2018 18:46:32 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [RESEND PATCH v2] Documentation/ABI: clean up sysfs-class-pktcdvd
Message-ID: <20180223131632.GA21867@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593197774356284506?=
X-GMAIL-MSGID: =?utf-8?q?1593197774356284506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up the sysfs documentation such that it is in the same format as
described in Documentation/ABI/README. Mainly, the patch moves the
attribute names to the 'What:' field. This might be useful for scripting
and tracking changes in the ABI.

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
Changes in v2:
- Convert spaces to tabs

 Documentation/ABI/testing/sysfs-class-pktcdvd | 129 +++++++++++++++-----------
 1 file changed, 75 insertions(+), 54 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-pktcdvd b/Documentation/ABI/testing/sysfs-class-pktcdvd
index b1c3f0263359..dde4f26d0780 100644
--- a/Documentation/ABI/testing/sysfs-class-pktcdvd
+++ b/Documentation/ABI/testing/sysfs-class-pktcdvd
@@ -1,60 +1,81 @@
-What:           /sys/class/pktcdvd/
-Date:           Oct. 2006
-KernelVersion:  2.6.20
-Contact:        Thomas Maier <balagi@justmail.de>
-Description:
-
 sysfs interface
 ---------------
+The pktcdvd module (packet writing driver) creates the following files in the
+sysfs: (<devid> is in the format major:minor)
+
+What:		/sys/class/pktcdvd/add
+What:		/sys/class/pktcdvd/remove
+What:		/sys/class/pktcdvd/device_map
+Date:		Oct. 2006
+KernelVersion:	2.6.20
+Contact:	Thomas Maier <balagi@justmail.de>
+Description:
+
+		add:		(WO) Write a block device id (major:minor) to
+				create a new pktcdvd device and map it to the
+				block device.
+
+		remove:		(WO) Write the pktcdvd device id (major:minor)
+				to remove the pktcdvd device.
+
+		device_map:	(RO) Shows the device mapping in format:
+				pktcdvd[0-7] <pktdevid> <blkdevid>
+
+
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/dev
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/uevent
+Date:		Oct. 2006
+KernelVersion:	2.6.20
+Contact:	Thomas Maier <balagi@justmail.de>
+Description:
+		dev:	(RO) Device id
+
+		uevent:	(WO) To send a uevent
+
+
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/packets_started
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/packets_finished
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_written
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_read
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/kb_read_gather
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/stat/reset
+Date:		Oct. 2006
+KernelVersion:	2.6.20
+Contact:	Thomas Maier <balagi@justmail.de>
+Description:
+		packets_started:	(RO) Number of started packets.
+
+		packets_finished:	(RO) Number of finished packets.
+
+		kb_written:		(RO) kBytes written.
+
+		kb_read:		(RO) kBytes read.
+
+		kb_read_gather:		(RO) kBytes read to fill write packets.
+
+		reset:			(WO) Write any value to it to reset
+					pktcdvd device statistic values, like
+					bytes read/written.
+
+
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/size
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/congestion_off
+What:		/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/congestion_on
+Date:		Oct. 2006
+KernelVersion:	2.6.20
+Contact:	Thomas Maier <balagi@justmail.de>
+Description:
+		size:		(RO) Contains the size of the bio write queue.
+
+		congestion_off:	(RW) If bio write queue size is below this mark,
+				accept new bio requests from the block layer.
 
-The pktcdvd module (packet writing driver) creates
-these files in the sysfs:
-(<devid> is in format  major:minor )
-
-/sys/class/pktcdvd/
-    add            (0200)  Write a block device id (major:minor)
-                           to create a new pktcdvd device and map
-                           it to the block device.
-
-    remove         (0200)  Write the pktcdvd device id (major:minor)
-                           to it to remove the pktcdvd device.
-
-    device_map     (0444)  Shows the device mapping in format:
-                             pktcdvd[0-7] <pktdevid> <blkdevid>
-
-/sys/class/pktcdvd/pktcdvd[0-7]/
-    dev                   (0444) Device id
-    uevent                (0200) To send an uevent.
-
-/sys/class/pktcdvd/pktcdvd[0-7]/stat/
-    packets_started       (0444) Number of started packets.
-    packets_finished      (0444) Number of finished packets.
-
-    kb_written            (0444) kBytes written.
-    kb_read               (0444) kBytes read.
-    kb_read_gather        (0444) kBytes read to fill write packets.
-
-    reset                 (0200) Write any value to it to reset
-                                 pktcdvd device statistic values, like
-                                 bytes read/written.
-
-/sys/class/pktcdvd/pktcdvd[0-7]/write_queue/
-    size                  (0444) Contains the size of the bio write
-                                 queue.
-
-    congestion_off        (0644) If bio write queue size is below
-                                 this mark, accept new bio requests
-                                 from the block layer.
-
-    congestion_on         (0644) If bio write queue size is higher
-                                 as this mark, do no longer accept
-                                 bio write requests from the block
-                                 layer and wait till the pktcdvd
-                                 device has processed enough bio's
-                                 so that bio write queue size is
-                                 below congestion off mark.
-                                 A value of <= 0 disables congestion
-                                 control.
+		congestion_on:	(RW) If bio write queue size is higher as this
+				mark, do no longer accept bio write requests
+				from the block layer and wait till the pktcdvd
+				device has processed enough bio's so that bio
+				write queue size is below congestion off mark.
+				A value of <= 0 disables congestion control.
 
 
 Example:
-- 
2.16.2

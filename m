Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518520925; cv=none;
        d=google.com; s=arc-20160816;
        b=EHfS6l9xnSo6fEvgctsvAsAzzQNM4/nh4hWJ6XiNHYMu/ZC7X5ejWoUj964+64LUPm
         I9KbbKtMxrDqfZ/pnDrret74cQ0CyGugntKB6Xrqv0oz5HI/j62GDU//iXYunuBK8qTv
         SN8WDerukKXXNR8pwSvIaoveeijI1R8UhlqvU7REQxVglmwv3X/DU2BSU6GWmrFpn2hX
         Ur3IsfWuVDIm72OL+Qt61jgYnOsaR5O58fbwqSx70VjnWVTDSCqzI6B2ltGyjv4HZuYu
         bB0Ef+fZN1B08Np2+V8Wsa7EstqVY8CQNqYeDmr6U4G3PWFa7kbi0uqHWrPcWr+DTMR7
         6Ang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=7PvPQhiAwwkOtGkpmtQgSK4E5LvTd2vYfVOqIexaXGA=;
        b=ZBca9odcHiU4aT7fyuy93DHuvfngBfFLfqHwHXjMhUv9fl8Xi9G0w7KFOtevF2oi9S
         +1eakkGeRJmZ/OSOO7cpOcO70c2G3+aKhpIDNrGJ7w7lJkuYrQHBqVsqzTKNhC927uLb
         /Zf7pKEDwmDaWc9s0sQ9goMLri3jUeh+gjAZnDMLRZJuAqEEfbEURc0h2oBf4++nvmkw
         NAgnTJ9Oe/BTMBUWFMNyNwM6JEcsNx/OyzOMfXz7ZYIIe5ZLu02uuEL0sqrUEgRpE+tV
         BCnk2pD+BAS+m9ZUNta+qcD53x7OkB12PYtYeROn//iyu+zslsB2DigPqdx0TS9T4SUX
         q0oA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rye9Q5Z+;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rye9Q5Z+;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225I/eQ7aXMSkPB8vaOGsPWwH5L73lgvnlWjRAr17WDWqKdug6MEPSvNmcqnTcTSXj8NMocZHw==
Date: Tue, 13 Feb 2018 16:51:59 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Gwendal Grignou <gwendal@chromium.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] libata: transport: cleanup documentation of sysfs interface
Message-ID: <20180213112159.GA24306@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592284598676313404?=
X-GMAIL-MSGID: =?utf-8?q?1592284598676313404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean-up the documentation of sysfs interfaces to be in the same format
as described in Documentation/ABI/README. This will be useful for
tracking changes in the ABI. Attributes are grouped by function (device,
link or port) and then by date added.

This patch also adds documentation for one attribute -
/sys/class/ata_port/ataX/port_no

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-ata | 171 +++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 71 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testing/sysfs-ata
index aa4296498859..9ab0ef1dd1c7 100644
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -1,110 +1,139 @@
 What:		/sys/class/ata_...
-Date:		August 2008
-Contact:	Gwendal Grignou<gwendal@google.com>
 Description:
-
-Provide a place in sysfs for storing the ATA topology of the system.  This allows
-retrieving various information about ATA objects.
+		Provide a place in sysfs for storing the ATA topology of the
+		system. This allows retrieving various information about ATA
+		objects.
 
 Files under /sys/class/ata_port
 -------------------------------
 
-	For each port, a directory ataX is created where X is the ata_port_id of
-	the port. The device parent is the ata host device.
+For each port, a directory ataX is created where X is the ata_port_id of the
+port. The device parent is the ata host device.
 
-idle_irq (read)
 
-	Number of IRQ received by the port while idle [some ata HBA only].
+What:		/sys/class/ata_port/ataX/nr_pmp_links
+What:		/sys/class/ata_port/ataX/idle_irq
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		nr_pmp_links:	(RO) If a SATA Port Multiplier (PM) is
+				connected, the number of links behind it.
 
-nr_pmp_links (read)
+		idle_irq:	(RO) Number of IRQ received by the port while
+				idle [some ata HBA only].
 
-	If a SATA Port Multiplier (PM) is connected, number of link behind it.
+
+What:		/sys/class/ata_port/ataX/port_no
+Date:		May, 2013
+KernelVersion:	v3.11
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		(RO) Host local port number. While registering host controller,
+		port numbers are tracked based upon number of ports available on
+		the controller. This attribute is needed by udev for composing
+		persistent links in /dev/disk/by-path.
 
 Files under /sys/class/ata_link
 -------------------------------
 
-	Behind each port, there is a ata_link. If there is a SATA PM in the
-	topology, 15 ata_link objects are created.
-
-	If a link is behind a port, the directory name is linkX, where X is
-	ata_port_id of the port.
-	If a link is behind a PM, its name is linkX.Y where X is ata_port_id
-	of the parent port and Y the PM port.
+Behind each port, there is a ata_link. If there is a SATA PM in the topology, 15
+ata_link objects are created.
 
-hw_sata_spd_limit
+If a link is behind a port, the directory name is linkX, where X is ata_port_id
+of the port. If a link is behind a PM, its name is linkX.Y where X is
+ata_port_id of the parent port and Y the PM port.
 
-	Maximum speed supported by the connected SATA device.
 
-sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/hw_sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/sata_spd_limit
+What:		/sys/class/ata_link/linkX[.Y]/sata_spd
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		hw_sata_spd_limit:	(RO) Maximum speed supported by the
+					connected SATA device.
 
-	Maximum speed imposed by libata.
+		sata_spd_limit:		(RO) Maximum speed imposed by libata.
 
-sata_spd
+		sata_spd:		(RO) Current speed of the link
+					eg. 1.5, 3 Gbps etc.
 
-	Current speed of the link [1.5, 3Gps,...].
 
 Files under /sys/class/ata_device
 ---------------------------------
 
-	Behind each link, up to two ata device are created.
-	The name of the directory is devX[.Y].Z where:
-	- X is ata_port_id of the port where the device is connected,
-	- Y the port of the PM if any, and
-	- Z the device id: for PATA, there is usually 2 devices [0,1],
-	only 1 for SATA.
-
-class
-	Device class. Can be "ata" for disk, "atapi" for packet device,
-	"pmp" for PM, or "none" if no device was found behind the link.
-
-dma_mode
+Behind each link, up to two ata devices are created.
+The name of the directory is devX[.Y].Z where:
+- X is ata_port_id of the port where the device is connected,
+- Y the port of the PM if any, and
+- Z the device id: for PATA, there is usually 2 devices [0,1], only 1 for SATA.
+
+
+What:		/sys/class/ata_device/devX[.Y].Z/spdn_cnt
+What:		/sys/class/ata_device/devX[.Y].Z/gscr
+What:		/sys/class/ata_device/devX[.Y].Z/ering
+What:		/sys/class/ata_device/devX[.Y].Z/id
+What:		/sys/class/ata_device/devX[.Y].Z/pio_mode
+What:		/sys/class/ata_device/devX[.Y].Z/xfer_mode
+What:		/sys/class/ata_device/devX[.Y].Z/dma_mode
+What:		/sys/class/ata_device/devX[.Y].Z/class
+Date:		May, 2010
+KernelVersion:	v2.6.37
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		spdn_cnt:	(RO) Number of times libata decided to lower the
+				speed of link due to errors.
 
-	Transfer modes supported by the device when in DMA mode.
-	Mostly used by PATA device.
+		gscr:		(RO) Cached result of the dump of PM GSCR
+				register. Valid registers are:
 
-pio_mode
+				0:      SATA_PMP_GSCR_PROD_ID,
+				1:	SATA_PMP_GSCR_REV,
+				2:      SATA_PMP_GSCR_PORT_INFO,
+				32:     SATA_PMP_GSCR_ERROR,
+				33:     SATA_PMP_GSCR_ERROR_EN,
+				64:     SATA_PMP_GSCR_FEAT,
+				96:     SATA_PMP_GSCR_FEAT_EN,
+				130:    SATA_PMP_GSCR_SII_GPIO
 
-	Transfer modes supported by the device when in PIO mode.
-	Mostly used by PATA device.
+				Only valid if the device is a PM.
 
-xfer_mode
+		ering:		(RO) Formatted output of the error ring of the
+				device.
 
-	Current transfer mode.
+		id:		(RO) Cached result of IDENTIFY command, as
+				described in ATA8 7.16 and 7.17. Only valid if
+				the device is not a PM.
 
-id
+		pio_mode:	(RO) Transfer modes supported by the device when
+				in PIO mode. Mostly used by PATA device.
 
-	Cached result of IDENTIFY command, as described in ATA8 7.16 and 7.17.
-	Only valid if the device is not a PM.
+		xfer_mode:	(RO) Current transfer mode
 
-gscr
+		dma_mode:	(RO) Transfer modes supported by the device when
+				in DMA mode. Mostly used by PATA device.
 
-	Cached result of the dump of PM GSCR register.
-	Valid registers are:
-	0: 	SATA_PMP_GSCR_PROD_ID,
-	1: 	SATA_PMP_GSCR_REV,
-	2: 	SATA_PMP_GSCR_PORT_INFO,
-	32:	SATA_PMP_GSCR_ERROR,
-	33:	SATA_PMP_GSCR_ERROR_EN,
-	64:	SATA_PMP_GSCR_FEAT,
-	96:	SATA_PMP_GSCR_FEAT_EN,
-	130:	SATA_PMP_GSCR_SII_GPIO
-	Only valid if the device is a PM.
+		class:		(RO) Device class. Can be "ata" for disk,
+				"atapi" for packet device, "pmp" for PM, or
+				"none" if no device was found behind the link.
 
-trim
 
-	Shows the DSM TRIM mode currently used by the device. Valid
-	values are:
-	unsupported:		Drive does not support DSM TRIM
-	unqueued:		Drive supports unqueued DSM TRIM only
-	queued:			Drive supports queued DSM TRIM
-	forced_unqueued:	Drive's queued DSM support is known to be
-				buggy and only unqueued TRIM commands
-				are sent
+What:		/sys/class/ata_device/devX[.Y].Z/trim
+Date:		May, 2015
+KernelVersion:	v4.10
+Contact:	Gwendal Grignou <gwendal@chromium.org>
+Description:
+		(RO) Shows the DSM TRIM mode currently used by the device. Valid
+		values are:
 
-spdn_cnt
+		unsupported:		Drive does not support DSM TRIM
 
-	Number of time libata decided to lower the speed of link due to errors.
+		unqueued:               Drive supports unqueued DSM TRIM only
 
-ering
+		queued:                 Drive supports queued DSM TRIM
 
-	Formatted output of the error ring of the device.
+		forced_unqueued:	Drive's queued DSM support is known to
+					be buggy and only unqueued TRIM commands
+					are sent
-- 
2.16.1

Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518509903; cv=none;
        d=google.com; s=arc-20160816;
        b=NhvBRRy6WAUHT42J9o44Wtewz7hzc0i7eYq+bx0N+IIIylpuKGywvzy+teWWmtXm/2
         lane4cwHgFiJbkeK32A3TVweWqZiyJoZX8vLOmygr+Q5mSsAn/DF8JRQLY32pykVduVG
         vb9Dt48FRZwFKDHs/gcMFa/NuPUQuOaKXy02Dg+8LRJHOXI8qqHYZU+WQ5EhOuuM2pZd
         Uf+nSYukK8/zXy4ipE+BPzGDvL9s8KlS3891CSgca9rX7qagurSalQDbjhPNdZfVy9RR
         f4lRVkj5SI046xRkJo6g0tP4JxTwTVaPOXr0SIdSalI18h6iDVZ9dYXE3aEVgCeBJbWZ
         9iTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=0MKjXTeDx15Sp+L7YweSh0AWXuZ8i5EMoab8nQA22ao=;
        b=xSuHIRXOMuX/acDeegc85qh5c/ktVDtnZpVYE1tZZqznmhnAKoeBVDTXvxXG72HKXC
         XQYXDwxIyj+FA42a5BKMYzt1F6utNrqgFSoH5r0ncaep4BUiqRChGnkoXxPZrSHqQAf3
         kP8ihAjzsutrDAIi/Ldm0saD1S1O8TvcLZleN9kQp0ylT1pozpYglXSZrSFtim6hWldL
         Ekn4ovQP6RfEzF+jJQhFH8UdbRVuABk7Bl3PIScmQvwW+9PyUPADP/MRUVJIz6jq3RZ3
         /Uo223m0MkhOI7nNNI1IDACnOLgRTFlZ0/yUVU6LphRDEn7ZiTitWGGpkL8YF8QqT9pq
         4Xyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nsfOatcs;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nsfOatcs;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224d3dsYZUuw7qfMK5aXdlFd3Sokww+MT/ybBiyh4bEsyPiPHf67jlw8b2H7Kte5x0k8WvRYYw==
Date: Tue, 13 Feb 2018 13:48:16 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] libata: update documentation for sysfs interfaces
Message-ID: <20180213081816.GA11350@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592273039999135902?=
X-GMAIL-MSGID: =?utf-8?q?1592273039999135902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dcoumentation has been added by parsing through git commit history and
reading code. This might be useful for scripting and tracking changes in
the ABI.

I do not have complete descriptions for the following 3 attributes; they
have been annotated with the comment [to be documented] -

	/sys/class/scsi_host/hostX/ahci_port_cmd
	/sys/class/scsi_host/hostX/ahci_host_caps
	/sys/class/scsi_host/hostX/ahci_host_cap2

Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
---
 Documentation/ABI/testing/sysfs-block-device    | 58 ++++++++++++++++
 Documentation/ABI/testing/sysfs-class-scsi_host | 89 +++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-block-device

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
new file mode 100644
index 000000000000..82ef6eab042d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -0,0 +1,58 @@
+What:		/sys/block/*/device/sw_activity
+Date:		Jun, 2008
+KernelVersion:	v2.6.27
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) Used by drivers which support software controlled activity
+		LEDs.
+
+		It has the following valid values:
+
+		0	OFF - the LED is not activated on activity
+		1	BLINK_ON - the LED blinks on every 10ms when activity is
+			detected.
+		2	BLINK_OFF - the LED is on when idle, and blinks off
+			every 10ms when activity is detected.
+
+		Note that the user must turn sw_activity OFF it they wish to
+		control the activity LED via the em_message file.
+
+
+What:		/sys/block/*/device/unload_heads
+Date:		Sep, 2008
+KernelVersion:	v2.6.28
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) Hard disk shock protection
+
+		Writing an integer value to this file will take the heads of the
+		respective drive off the platter and block all I/O operations
+		for the specified number of milliseconds.
+
+		- If the device does not support the unload heads feature,
+		  access is denied with -EOPNOTSUPP.
+		- The maximal value accepted for a timeout is 30000
+		  milliseconds.
+		- A previously set timeout can be cancelled and disk can resume
+		  normal operation immediately by specifying a timeout of 0.
+		- Some hard drives only comply with an earlier version of the
+		  ATA standard, but support the unload feature nonetheless.
+		  There is no safe way Linux can detect these devices, so this
+		  is not enabled by default. If it is known that your device
+		  does support the unload feature, then you can tell the kernel
+		  to enable it by writing -1. It can be disabled again by
+		  writing -2.
+		- Values below -2 are rejected with -EINVAL
+
+		For more information, see
+		Documentation/laptops/disk-shock-protection.txt
+
+
+What:		/sys/block/*/device/ncq_prio_enable
+Date:		Oct, 2016
+KernelVersion:	v4.10
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) Write to the file to turn on or off the SATA ncq (native
+		command queueing) support. By default this feature is turned
+		off.
diff --git a/Documentation/ABI/testing/sysfs-class-scsi_host b/Documentation/ABI/testing/sysfs-class-scsi_host
index 0eb255e7db12..bafc59fd7b69 100644
--- a/Documentation/ABI/testing/sysfs-class-scsi_host
+++ b/Documentation/ABI/testing/sysfs-class-scsi_host
@@ -27,3 +27,92 @@ Description:	This file contains the current status of the "SSD Smart Path"
 		the direct i/o path to physical devices.  This setting is
 		controller wide, affecting all configured logical drives on the
 		controller.  This file is readable and writable.
+
+What:		/sys/class/scsi_host/hostX/link_power_management_policy
+Date:		Oct, 2007
+KernelVersion:	v2.6.24
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) This parameter allows the user to read and set the link
+		(interface) power management.
+
+		There are four possible options:
+
+		min_power: Tell the controller to try to make the link use the
+		least possible power when possible. This may sacrifice some
+		performance due to increased latency when coming out of lower
+		power states.
+
+		max_performance: Generally, this means no power management.
+		Tell the controller to have performance be a priority over power
+		management.
+
+		medium_power: Tell the controller to enter a lower power state
+		when possible, but do not enter the lowest power state, thus
+		improving latency over min_power setting.
+
+		med_power_with_dipm: Identical to the existing medium_power
+		setting except that it enables dipm (device initiated power
+		management) on top, which makes it match the Windows IRST (Intel
+		Rapid Storage Technology) driver settings. This setting is also
+		close to min_power, except that:
+		a) It does not use host-initiated slumber mode, but it does
+		allow device-initiated slumber
+		b) It does not enable low power device sleep mode (DevSlp).
+
+What:		/sys/class/scsi_host/hostX/em_message
+What:		/sys/class/scsi_host/hostX/em_message_type
+Date:		Jun, 2008
+KernelVersion:	v2.6.27
+Contact:	linux-ide@vger.kernel.org
+Description:
+		em_message: (RW) Enclosure management support. For the LED
+		protocol, writes and reads correspond to the LED message format
+		as defined in the AHCI spec.
+
+		The user must turn sw_activity (under /sys/block/*/device/) OFF
+		it they wish to control the activity LED via the em_message
+		file.
+
+		em_message_type: (RO) Displays the current enclosure management
+		protocol that is being used by the driver (for eg. LED, SAF-TE,
+		SES-2, SGPIO etc).
+
+What:		/sys/class/scsi_host/hostX/ahci_port_cmd
+What:		/sys/class/scsi_host/hostX/ahci_host_caps
+What:		/sys/class/scsi_host/hostX/ahci_host_cap2
+Date:		Mar, 2010
+KernelVersion:	v2.6.35
+Contact:	linux-ide@vger.kernel.org
+Description:
+		[to be documented]
+
+What:		/sys/class/scsi_host/hostX/ahci_host_version
+Date:		Mar, 2010
+KernelVersion:	v2.6.35
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RO) Display the version of the AHCI spec implemented by the
+		host.
+
+What:		/sys/class/scsi_host/hostX/em_buffer
+Date:		Apr, 2010
+KernelVersion:	v2.6.35
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RW) Allows access to AHCI EM (enclosure management) buffer
+		directly if the host supports EM.
+
+		For eg. the AHCI driver supports SGPIO EM messages but the
+		SATA/AHCI specs do not define the SGPIO message format of the EM
+		buffer. Different hardware(HW) vendors may have different
+		definitions. With the em_buffer attribute, this issue can be
+		solved by allowing HW vendors to provide userland drivers and
+		tools for their SGPIO initiators.
+
+What:		/sys/class/scsi_host/hostX/em_message_supported
+Date:		Oct, 2009
+KernelVersion:	v2.6.39
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(RO) Displays supported enclosure management message types.
-- 
2.16.1
